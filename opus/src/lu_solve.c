#include "lu_solve.h"

#include <assert.h>
#include <immintrin.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// BLAS subroutines
#include "blas/dgemm.h"
#include "blas/dgetf2.h"
#include "blas/dgetrs.h"
#include "blas/dlaswp.h"
#include "blas/dswap.h"
#include "blas/dtrsm.h"
#include "blas/idamax.h"

#include "helpers.h"

#ifdef TEST_MKL
#include "mkl.h"
#endif

#ifdef TEST_PERF
#include "perf_testers/perf_lu_solve.h"
#endif

int lu_solve_0(int N, double *A, double *b);
int lu_solve_1(int N, double *A, double *b);
int lu_solve_2(int N, double *A, double *b);
#ifdef TEST_MKL
int lu_solve_3(int N, double *A, double *b);
int lu_solve_4(int N, double *A, double *b);
int lu_solve_7(int N, double *A, double *b);
#endif
int lu_solve_5(int N, double *A, double *b);
int lu_solve_6(int N, double *A, double *b);

static int *scratch_ipiv;

#ifndef LU_SOLVE_VERSION
#define LU_SOLVE_VERSION lu_solve_7
#endif

/** @brief Entry function to solve system A * x = b
 *         After exit b is overwritten with solution vector x.
 *
 * @param N Number of columns and rows of A.
 * @param A Real valued NxN matrix A.
 * @param ipiv Buffer for internal usage when pivoting.
 * @param b Real valued Nx1 vector b.
 */
int lu_solve(int N, double *A, double *b) { return LU_SOLVE_VERSION(N, A, b); }

void lu_initialize_memory(int max_n)
{
  dgemm_initialize_memory(max_n); // XXX HACK!
  scratch_ipiv = (int *)aligned_alloc(32, (max_n * sizeof(int) + 31) & -32);
}

void lu_free_memory()
{
  dgemm_free_memory();
  free(scratch_ipiv);
}

// -----------------
// Utilities

static void swapd(double *a, int i, int j)
{
  double t = a[i];
  a[i] = a[j];
  a[j] = t;
}

static unsigned usqrt4(unsigned val)
{
  unsigned a, b;
  if (val < 2)
    return val; /* avoid div/0 */
  a = 1255;     /* starting point is relatively unimportant */
  b = val / a;
  a = (a + b) / 2;
  b = val / a;
  a = (a + b) / 2;
  b = val / a;
  a = (a + b) / 2;
  b = val / a;
  a = (a + b) / 2;
  return a;
}

static __attribute__((always_inline)) int ideal_block(int M, int N)
{
#ifdef LU_BLOCK
  return LU_BLOCK;
#else
  return usqrt4(M);
#endif
}

/** ------------------------------------------------------------------
 * Base implementation
 */
int lu_solve_0(int N, double *A, double *b)
{
  int i, j, k;
  int *ipiv = scratch_ipiv;

  for (i = 0; i < N; ++i)
  {

    // == Partial Pivoting ==

    double p_t;
    double p_v;
    int p_i;

    p_v = fabs(AIX(i, i));
    p_i = i;

    for (k = i + 1; k < N; ++k)
    {
      p_t = fabs(AIX(k, i));
      if (p_t > p_v)
      {
        p_v = p_t;
        p_i = k;
      }
    }

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      return -1;
    }

    if (i != p_i)
    {

#if DEBUG_LU_SOLVER
      printf("p %f pivot row %d\n", p_v, p_i);
      printf("swap rows %d <-> %d\n", i, p_i);
#endif

      // Swap immediately the b
      swapd(b, i, p_i);

      // Swap rows k and p_i
      for (j = 0; j < N; ++j)
      {
        swapd(A, IX(i, j), IX(p_i, j));
      }
    }

    // === ===

    // BLAS 1 Scale vector
    for (j = i + 1; j < N; ++j)
    {
      AIX(j, i) = AIX(j, i) / AIX(i, i);
    }

    // BLAS 2 rank-1 update
    for (j = i + 1; j < N; ++j)
    {
      for (int k = i + 1; k < N; ++k)
      {
        AIX(j, k) = AIX(j, k) - AIX(j, i) * AIX(i, k);
      }
    }
  }

  // A now contains L (below diagonal)
  //                U (above diagonal)

  // Forward substitution
  for (k = 0; k < N; ++k)
  {
    if (!APPROX_EQUAL(b[k], 0.))
    {
      for (i = k + 1; i < N; ++i)
      {
        b[i] = b[i] - b[k] * AIX(i, k);
      }
    }
  }

  // Backward substitution
  for (k = N - 1; k >= 0; --k)
  {
    if (!APPROX_EQUAL(b[k], 0.))
    {
      b[k] = b[k] / AIX(k, k); // Non-unit diagonal
      for (i = 0; i < k; ++i)
      {
        b[i] = b[i] - b[k] * AIX(i, k);
      }
    }
  }

  return 0;
}

int lu_solve_1(int N, double *A, double *b)
{
  int *ipiv = scratch_ipiv;

  int NB = 64, retcode;

  int M = N;   // Square matrix
  int LDA = N; // N is the leading dimension

  int ib, IB, k;

  // BLocked factor A into [L \ U]

  if (N < NB)
  {
    // Use unblocked code
    retcode = dgetf2_1(M, N, A, LDA, ipiv);

#if DEBUG_LU_SOLVER
    printf("IPIV: ");
    for (int i = 0; i < N; ++i)
      printf("%d  ", ipiv[i]);
    printf("\n");
#endif

    if (retcode != 0)
      return retcode;
  }
  else
  {

    for (ib = 0; ib < MIN(M, N); ib += NB)
    {
      IB = MIN(MIN(M, N) - ib, NB);

      retcode = dgetf2_1(M - ib, IB, &AIX(ib, ib), LDA, ipiv + ib);

      if (retcode != 0)
        return retcode;

      // Update the pivot indices
      for (k = ib; k < MIN(M, ib + IB); ++k)
      {
        ipiv[k] = ipiv[k] + ib;
      }

      // Apply interchanges to columns 0 : ib
      dlaswp_1(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        dlaswp_1(N - ib - IB, &AIX(0, ib + IB), LDA, ib, ib + IB, ipiv, 1);

        // Compute the block row of U
        dtrsm_L_1(IB, N - ib - IB, &AIX(ib, ib), LDA, &AIX(ib, ib + IB), LDA);

        if (ib + IB < M) // NOTE for a square matrix this will always be true.
        {
          // Update trailing submatrix
          dgemm_1(M - ib - IB, N - ib - IB, IB, -ONE, //
                  &AIX(ib + IB, ib), LDA,             //
                  &AIX(ib, ib + IB), LDA,             //
                  ONE,                                //
                  &AIX(ib + IB, ib + IB), LDA         //
          );
        }
      }
    }
  }

  // Solve the system with A
  retcode = dgetrs_1(N, A, ipiv, b);
  return retcode;
}

int lu_solve_2(int N, double *A, double *b)
{
  int retcode, ib, IB, k;
  int *ipiv = scratch_ipiv;

  const int NB = ideal_block(N, N), //
      M = N,                        //
      LDA = N,                      //
      MIN_MN = N                    //
      ;

  // Use unblocked code
  if (NB <= 1 || NB >= MIN_MN)
  {
    retcode = dgetf2_2(M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }

  // BLocked factor A into [L \ U]
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = dgetf2_2(M - ib, IB, &AIX(ib, ib), LDA, ipiv + ib);

      if (retcode != 0)
        return retcode;

      // Update the pivot indices
      for (k = ib; k < MIN(M, ib + IB) - 7; k += 8)
      {
        ipiv[k + 0] = ipiv[k + 0] + ib;
        ipiv[k + 1] = ipiv[k + 1] + ib;
        ipiv[k + 2] = ipiv[k + 2] + ib;
        ipiv[k + 3] = ipiv[k + 3] + ib;

        ipiv[k + 4] = ipiv[k + 4] + ib;
        ipiv[k + 5] = ipiv[k + 5] + ib;
        ipiv[k + 6] = ipiv[k + 6] + ib;
        ipiv[k + 7] = ipiv[k + 7] + ib;
      }
      for (; k < MIN(M, ib + IB); ++k)
      {
        ipiv[k + 0] = ipiv[k + 0] + ib;
      }

      // Apply interchanges to columns 0 : ib
      dlaswp_2(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        dlaswp_2(N - ib - IB, &AIX(0, ib + IB), LDA, ib, ib + IB, ipiv, 1);

        // Compute the block row of U
        dtrsm_L_2(IB, N - ib - IB, &AIX(ib, ib), LDA, &AIX(ib, ib + IB), LDA);

        // Update trailing submatrix
        dgemm_2(M - ib - IB, N - ib - IB, IB, -ONE, //
                &AIX(ib + IB, ib), LDA,             //
                &AIX(ib, ib + IB), LDA,             //
                ONE,                                //
                &AIX(ib + IB, ib + IB), LDA         //
        );
      }
    }
  }

#if DEBUG_LU_SOLVER
  for (int i = 0; i < N; ++i)
  {
    for (int j = 0; j < N; ++j)
      printf("%.4f  ", MIX(A, N, i, j));
    printf("\n");
  }
  printf("\n");
#endif

  // Solve the system with A
  retcode = dgetrs_2(N, A, ipiv, b);
  return retcode;
}

#ifdef TEST_MKL

/**
 * This implementation should remain /equal/ to the previous, however,
 * it uses the Intel OneAPI MKL instead of the handrolled LAPACK routines.
 */
int lu_solve_3(int N, double *A, double *b)
{
  int retcode, ib, IB, k;
  int *ipiv = scratch_ipiv;

  const int //
      NB = ideal_block(N, N),
      M = N,     //
      LDA = N,   //
      MIN_MN = N //
      ;

  // BLocked factor A into [L \ U]

  if (NB <= 1 || NB >= MIN_MN)
  {
    // Use unblocked code
    retcode = LAPACKE_dgetf2(LAPACK_ROW_MAJOR, M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = LAPACKE_dgetf2(LAPACK_ROW_MAJOR, M - ib, IB, &AIX(ib, ib), LDA,
                               ipiv + ib);

      if (retcode != 0)
        return retcode;

      // Update the pivot indices
      for (k = ib; k < MIN(M, ib + IB) - 7; k += 8)
      {
        ipiv[k + 0] = ipiv[k + 0] + ib;
        ipiv[k + 1] = ipiv[k + 1] + ib;
        ipiv[k + 2] = ipiv[k + 2] + ib;
        ipiv[k + 3] = ipiv[k + 3] + ib;

        ipiv[k + 4] = ipiv[k + 4] + ib;
        ipiv[k + 5] = ipiv[k + 5] + ib;
        ipiv[k + 6] = ipiv[k + 6] + ib;
        ipiv[k + 7] = ipiv[k + 7] + ib;
      }
      for (; k < MIN(M, ib + IB); ++k)
      {
        ipiv[k + 0] = ipiv[k + 0] + ib;
      }

      // Apply interchanges to columns 0 : ib
      dlaswp_2(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        dlaswp_2(N - ib - IB, &AIX(0, ib + IB), LDA, ib, ib + IB, ipiv, 1);

        // Compute the block row of U
        dtrsm_L_2(IB, N - ib - IB, &AIX(ib, ib), LDA, &AIX(ib, ib + IB), LDA);

        // Update trailing submatrix
        dgemm_intel(M - ib - IB, N - ib - IB, IB, -ONE, //
                    &AIX(ib + IB, ib), LDA,             //
                    &AIX(ib, ib + IB), LDA,             //
                    ONE,                                //
                    &AIX(ib + IB, ib + IB), LDA         //
        );
      }
    }
  }

  // Solve the system with A
  // retcode = dgetrs_2(N, A, ipiv, b);
  retcode = LAPACKE_dgetrs(LAPACK_ROW_MAJOR, 'N',
                           N,    // Number of equations
                           1,    // Number of rhs equations
                           A, N, //
                           ipiv, //
                           b, 1  //
  );
  return retcode;
}

/**
 * Solve system only with the Intel OneAPI routine.
 */
int lu_solve_4(int N, double *A, double *b)
{
  int *ipiv = scratch_ipiv;
  return LAPACKE_dgesv(LAPACK_ROW_MAJOR,
                       N,    // Number of equations
                       1,    // Number of rhs equations
                       A, N, //
                       ipiv, //
                       b, 1  //
  );
}

#endif // TEST_MKL

// -----------------------------------
// Transposed memory layout operations

/**
 * Same al lu_solve_2 except it uses the new dgemm_6
 * and a transposed memory layout.
 */
int lu_solve_5(int N, double *A, double *b)
{
  int retcode, ib, IB, k;
  int *ipiv = scratch_ipiv;

  const int NB = ideal_block(N, N), //
      M = N,                        //
      LDA = N,                      //
      MIN_MN = N                    //
      ;

  // Use unblocked code
  if (NB <= 1 || NB >= MIN_MN)
  {
    retcode = dgetf2_5(M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }

  // BLocked factor A into [L \ U]
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = dgetf2_5(M - ib, IB, &TIX(A, LDA, ib, ib), LDA, ipiv + ib);

      if (retcode != 0)
        return retcode;

      // Update the pivot indices
      for (k = ib; k < MIN(M, ib + IB) - 7; k += 8)
      {
        ipiv[k + 0] = ipiv[k + 0] + ib;
        ipiv[k + 1] = ipiv[k + 1] + ib;
        ipiv[k + 2] = ipiv[k + 2] + ib;
        ipiv[k + 3] = ipiv[k + 3] + ib;

        ipiv[k + 4] = ipiv[k + 4] + ib;
        ipiv[k + 5] = ipiv[k + 5] + ib;
        ipiv[k + 6] = ipiv[k + 6] + ib;
        ipiv[k + 7] = ipiv[k + 7] + ib;
      }
      for (; k < MIN(M, ib + IB); ++k)
      {
        ipiv[k + 0] = ipiv[k + 0] + ib;
      }

      // Apply interchanges to columns 0 : ib
      dlaswp_5(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        dlaswp_5(N - ib - IB, &TIX(A, LDA, 0, ib + IB), LDA, ib, ib + IB, ipiv,
                 1);

        // Compute the block row of U
        dtrsm_L_5(IB, N - ib - IB, &TIX(A, LDA, ib, ib), LDA,
                  &TIX(A, LDA, ib, ib + IB), LDA);

        // Update trailing submatrix
        dgemm_6(M - ib - IB, N - ib - IB, IB, -ONE, //
                &TIX(A, LDA, ib + IB, ib), LDA,     //
                &TIX(A, LDA, ib, ib + IB), LDA,     //
                ONE,                                //
                &TIX(A, LDA, ib + IB, ib + IB), LDA //
        );
      }
    }
  }

  // Solve the system with A
  retcode = dgetrs_5(N, A, ipiv, b);
  return retcode;
}

int lu_solve_6(int N, double *A, double *b)
{
  int retcode, ib, IB, k;
  int *ipiv = scratch_ipiv;

  const int NB = ideal_block(N, N), //
      M = N,                        //
      LDA = N,                      //
      MIN_MN = N                    //
      ;

  __m256i      //
      ipiv_k0, //
      ipiv_k4, //
      pib;

  // Use unblocked code
  if (NB <= 1 || NB >= MIN_MN)
  {
    retcode = dgetf2_6(M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }

  // BLocked factor A into [L \ U]
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = dgetf2_6(M - ib, IB, &TIX(A, LDA, ib, ib), LDA, ipiv + ib);

      if (retcode != 0)
        return retcode;

      pib = _mm256_set1_epi32(ib); // XXX sequence of instructions

      // ----

      k = ib;

      // Update the pivot indices
      for (; k < MIN(M, ib + IB) - 15; k += 16)
      {
        ipiv_k0 = _mm256_loadu_si256((void *)(ipiv + k + 0));
        _mm256_storeu_si256((void *)(ipiv + k + 0),
                            _mm256_add_epi32(ipiv_k0, pib));

        ipiv_k0 = _mm256_loadu_si256((void *)(ipiv + k + 8));
        _mm256_storeu_si256((void *)(ipiv + k + 8),
                            _mm256_add_epi32(ipiv_k0, pib));
      }

      for (; k < MIN(M, ib + IB) - 7; k += 8)
      {
        ipiv_k0 = _mm256_loadu_si256((void *)(ipiv + k + 0));
        _mm256_storeu_si256((void *)(ipiv + k + 0),
                            _mm256_add_epi32(ipiv_k0, pib));
      }

      for (; k < MIN(M, ib + IB); ++k)
      {
        ipiv[k + 0] += ib;
      }

      // ----

      // Apply interchanges to columns 0 : ib
      dlaswp_6(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        dlaswp_6(N - ib - IB, &TIX(A, LDA, 0, ib + IB), LDA, ib, ib + IB, ipiv,
                 1);

        // Compute the block row of U
        dtrsm_L_6(IB, N - ib - IB, &TIX(A, LDA, ib, ib), LDA,
                  &TIX(A, LDA, ib, ib + IB), LDA);

        // Update trailing submatrix
        dgemm_5(M - ib - IB, N - ib - IB, IB, -1.,  //
                &TIX(A, LDA, ib + IB, ib), LDA,     //
                &TIX(A, LDA, ib, ib + IB), LDA,     //
                1.,                                 //
                &TIX(A, LDA, ib + IB, ib + IB), LDA //
        );
      }
    }
  }

  // Solve the system with A
  retcode = dgetrs_6(N, A, ipiv, b);
  return retcode;
}

int lu_solve_7(int N, double *A, double *b)
{
  int retcode, ib, IB, k;
  int *ipiv = scratch_ipiv;

  const int NB = ideal_block(N, N), //
      M = N,                        //
      LDA = N,                      //
      MIN_MN = N                    //
      ;

  __m256i      //
      ipiv_k0, //
      ipiv_k4, //
      pib;

  // Use unblocked code
  if (NB <= 1 || NB >= MIN_MN)
  {
    retcode = dgetf2_6(M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }

  // BLocked factor A into [L \ U]
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = dgetf2_6(M - ib, IB, &TIX(A, LDA, ib, ib), LDA, ipiv + ib);

      if (retcode != 0)
        return retcode;

      pib = _mm256_set1_epi32(ib); // XXX sequence of instructions

      // ----

      k = ib;

      // Update the pivot indices
      for (; k < MIN(M, ib + IB) - 15; k += 16)
      {
        ipiv_k0 = _mm256_loadu_si256((void *)(ipiv + k + 0));
        _mm256_storeu_si256((void *)(ipiv + k + 0),
                            _mm256_add_epi32(ipiv_k0, pib));

        ipiv_k0 = _mm256_loadu_si256((void *)(ipiv + k + 8));
        _mm256_storeu_si256((void *)(ipiv + k + 8),
                            _mm256_add_epi32(ipiv_k0, pib));
      }

      for (; k < MIN(M, ib + IB) - 7; k += 8)
      {
        ipiv_k0 = _mm256_loadu_si256((void *)(ipiv + k + 0));
        _mm256_storeu_si256((void *)(ipiv + k + 0),
                            _mm256_add_epi32(ipiv_k0, pib));
      }

      for (; k < MIN(M, ib + IB); ++k)
      {
        ipiv[k + 0] += ib;
      }

      // ----

      // Apply interchanges to columns 0 : ib
      dlaswp_6(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        dlaswp_6(N - ib - IB, &TIX(A, LDA, 0, ib + IB), LDA, ib, ib + IB, ipiv,
                 1);

        // Compute the block row of U
        dtrsm_L_6(IB, N - ib - IB, &TIX(A, LDA, ib, ib), LDA,
                  &TIX(A, LDA, ib, ib + IB), LDA);

        // Update trailing submatrix
        dgemm_intelT(M - ib - IB, N - ib - IB, IB, -1.,  //
                     &TIX(A, LDA, ib + IB, ib), LDA,     //
                     &TIX(A, LDA, ib, ib + IB), LDA,     //
                     1.,                                 //
                     &TIX(A, LDA, ib + IB, ib + IB), LDA //
        );
      }
    }
  }
  // Solve the system with A
  retcode = dgetrs_6(N, A, ipiv, b);
  return retcode;
}

#ifdef TEST_PERF

void register_functions_LU_SOLVE()
{
  char lu_6_msg[100];
#ifndef LU_BLOCK
  sprintf(lu_6_msg, "LU_Solve Transposed Vector (sqrt)");
#else
  sprintf(lu_6_msg, "LU_Solve Transposed Vector (%d)", LU_BLOCK);
#endif

  add_function_LU_SOLVE(&lu_solve_0, "LU Solve Base", 1);
  add_function_LU_SOLVE(&lu_solve_1, "LU Solve Toledo Base", 1);
  add_function_LU_SOLVE(&lu_solve_2, "LU_Solve Basic C_Opts", 1);
#ifdef TEST_MKL
  add_function_LU_SOLVE(&lu_solve_3, "LU_Solve Intel DGEMM", 1);
  add_function_LU_SOLVE(&lu_solve_4, "LU_Solve Intel DGESV RowMjr", 1);
  add_function_LU_SOLVE(&lu_solve_7, "LU Solve Intel DGEMM ColMjr", 1);
#endif
  add_function_LU_SOLVE(&lu_solve_5, "LU_Solve Transposed", 1);
  add_function_LU_SOLVE(&lu_solve_6, lu_6_msg, 1);
}

#endif
