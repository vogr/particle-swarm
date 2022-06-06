#include "lu_solve.h"

#include <assert.h>
#include <immintrin.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "helpers.h"

#ifdef TEST_MKL
#include "mkl.h"
#endif

#ifdef TEST_PERF
#include "perf_testers/perf_lu_solve.h"
#include "perf_testers/perf_mmm.h"
#endif

// XXX Assume 'A' is an NxN defined in scope
#define AIX(ROW, COL) (A)[(N) * (ROW) + (COL)]
#define IX(ROW, COL) ((N) * (ROW) + (COL))

int lu_solve_0(int N, double *A, double *b);
int lu_solve_1(int N, double *A, double *b);
int lu_solve_2(int N, double *A, double *b);
#ifdef TEST_MKL
int lu_solve_3(int N, double *A, double *b);
int lu_solve_4(int N, double *A, double *b);
#endif
int lu_solve_5(int N, double *A, double *b);
int lu_solve_6(int N, double *A, double *b);

// M N K block sizes for scratch buffers
#define M_BLOCK 192
#define N_BLOCK 2048
#define K_BLOCK 384

static double *scratch_a;
static double *scratch_b;
static int *scratch_ipiv;

/** @brief Entry function to solve system A * x = b
 *         After exit b is overwritten with solution vector x.
 *
 * @param N Number of columns and rows of A.
 * @param A Real valued NxN matrix A.
 * @param ipiv Buffer for internal usage when pivoting.
 * @param b Real valued Nx1 vector b.
 */

#ifndef LU_SOLVE_VERSION
#define LU_SOLVE_VERSION lu_solve_6
#endif

int lu_solve(int N, double *A, double *b) { return LU_SOLVE_VERSION(N, A, b); }

void lu_initialize_memory(int max_n)
{
  // XXX align the scratch buffers to the page size to avoid any potential
  // page misses.
  scratch_a = (double *)aligned_alloc(
      4096, (M_BLOCK * K_BLOCK * sizeof(double) + 4095) & -4096);
  scratch_b = (double *)aligned_alloc(
      4096, (K_BLOCK * N_BLOCK * sizeof(double) + 4095) & -4096);
  scratch_ipiv = (int *)aligned_alloc(32, (max_n * sizeof(int) + 31) & -32);
}

void lu_free_memory()
{
  free(scratch_a);
  free(scratch_b);
  free(scratch_ipiv);
}

// -----------------
// LAPACK routines
#if 0
// NOTE these functions have no declaration. However, a
// corresponding <name>_XXX  definition is made for each
// iteration XXX. This way performance testing is consistent.
// Forward declaration are here merely to have useful doc
// comments in one place.
// And YES, they are incorrectly using an (s) for single
// precision floats when they should be using a (d) for
// double precision (but I didn't notice until too late).

/** @brief Finds the index of the first element having maximum
 *         absolute value.
 *
 * @param N Number of elements in A.
 * @param A Real valued vector.
 * @param stride Space between elements
 * @return Index of the first element with the maximum absolute value.
 */
int isamax(int N, double *A, int stride);

/** @brief Swap interchanges two vectors.
 *
 * @param N The number of elements in vectors X and Y to swap.
 * @param X The first vector of real valued elements to swap.
 * @param incx The storage stride between elements in X.
 * @param Y The second vector of real valued elements to swap.
 * @param incy The storage stride between elements in Y.
 */
void sswap(int N, double *X, int incx, double *Y, int incy);

/** @brief Perform a series of row interchanges, one for each row
 *         k1 - k2 of A.
 *
 * @param N The number of column in MxN matrix A.
 * @param A MxN real valued matrix.
 * @param LDA Leading dimension of A.
 * @param k1 The first element of ipiv to interchange rows.
 * @param k2 (k2 - k1) elements of ipiv to do row interchanges.
 * @param ipiv The array of vector pivot indices such that i <-> ipiv[i].
 * @param incx The increment between indices in ipiv.
 */
void slaswp(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx);

/** @brief Solves matrix equation A * X = B
 *         A is assumed to be Non-transposed (L)ower
 *         triangular with a unit diagonal
 *         After exit, the matrix B is overwritten with
 *         the solution matrix X.
 *
 *  @param M Number of rows (height) of B.
 *  @param N Number of cols (width) of B.
 *  @param A Real valued matrix A.
 *  @param LDA Leading dimension of A.
 *  @param B Real valued matrix B.
 *  @param LDB Leading dimension of B.
 */
void strsm_L(int M, int N, double *A, int LDA, double *B, int LDB);

/** @brief equivalent to strsm_L except A is an (U)pper triangular matrix
 *         with a *Non-unit* diagonal. It is still assumed to be
non-transposed.
 */
void strsm_U(int M, int N, double *A, int LDA, double *B, int LDB);

// Assume No-transpose for both matrices
/** @brief compute C := alpha * A * B + beta * C
 *
 * @param M Number of rows (height) of A and C.
 * @param N Number of cols (width) of B and C.
 * @param K Number of cols (width) of A and rows (height) of B.
 * @param alpha Scalar alpha.
 * @param A Real valued MxK matrix A.
 * @param LDA Leading dimension of A.
 * @param B Real valued KxN matrix B.
 * @param LDB Leading dimension of B.
 * @param beta Scalar beta.
 * @param C Real valued MxN matrix C.
 * @param Leading dimension of C.
 */
void sgemm(int M, int N, int K, double alpha, double *A, int LDA, double *B,
           int LDB, double beta, double *C, int LDC);

/** @brief Factor A = P * L * U in place using BLAS1 / BLAS2 functions
 *
 * @param M The number of rows (height) of A.
 * @param N The number of columns (width) of A.
 * @param A Real valued matrix in which to factor [L\U].
 * @param LDA The leading dimension of the matrix in memory A.
 * @param ipiv Pivot indices for A.
 */
int sgetf2(int M, int N, double *A, int LDA, int *ipiv);

// Equivalent to SGETRS (no-transpose).
/** @brief Solves system of linear equations A * x = b.
 *         After exit b is overwritten with solution vector x.
 *
 * @param N Number of rows and columns in A.
 * @param A Real valued NxN matrix A which has been factored into [L\U].
 * @param ipiv Pivot indices used when factoring A.
 * @param b Real valued vector with N elements.
 */
int sgetrs(int N, double *A, int *ipiv, double *b);

#endif // FALSE to remove the above documentation.

// -----------------
// Utilities

static void swapd(double *a, int i, int j)
{
  double t = a[i];
  a[i] = a[j];
  a[j] = t;
}

// XXX FIXME
static int ideal_block(int M, int N) { return 32; }

// ------------------------------------------------------------------
// Implementation start

// NOTE All functions preceded by a _ are internal and unexposed by the API.
// They are prefixed because they often have the same name with a different
// signature than those exposed.

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

/** ------------------------------------------------------------------
 * Base implementation and LAPACK base impls.
 *
 * Using blocked (outer function) and delayed updates.
 */
static int isamax_1(int N, double *A, int stride)
{
  // NOTE N can be 0 if we iterate to the end of the rows in _lu_solve_XXX
  // this saves us from initializing the ipiv array. We could also do this
  // by just setting the end index to itself.

  // assert(0 < N);
  if (0 == N)
    return 0;

  assert(0 < stride);

  // TODO speacialize the case when `STRIDE` == 1.

  double p_v, p_t;
  int i, p_i, ix;

  p_v = fabs(A[0]);
  p_i = 0;
  ix = 0 + stride;

  for (i = 1; i < N; ++i, ix += stride)
  {
    assert(ix == i * stride);

    p_t = fabs(A[ix]);
    if (p_t > p_v)
    {
      p_v = p_t;
      p_i = i;
    }
  }
  return p_i;
}

static void sswap_1(int N, double *X, int incx, double *Y, int incy)
{
  // TODO special case when incx == incy == 1
  // ^^^ This is our case actually (row-major iteration).

  assert(0 < N);
  assert(0 < incx);
  assert(0 < incy);

  double t;
  int i, ix, iy;

  for (i = 0, ix = 0, iy = 0; i < N; ++i, ix += incx, iy += incy)
  {
    t = X[ix];
    X[ix] = Y[iy];
    Y[iy] = t;
  }

  return;
}

static void slaswp_1(int N, double *A, int LDA, int k1, int k2, int *ipiv,
                     int incx)
{
  // interchange row i with row IPIV[k1 + (i - k1) * abs(incx)]

  assert(0 < incx); // Do not cover the negative case

  int ix, ix0;
  int i, k, p_i;
  double tmp;
  ix0 = k1;
  ix = ix0;

  for (i = k1; i < k2; ++i, ix += incx)
  {
    p_i = ipiv[ix];
    if (p_i != i)
    {
      for (k = 0; k < N; ++k)
      {
        tmp = MIX(A, LDA, i, k);
        MIX(A, LDA, i, k) = MIX(A, LDA, p_i, k);
        MIX(A, LDA, p_i, k) = tmp;
      }
    }
  }
}

static void strsm_L_1(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = 0; k < M; ++k)
    {
      if (!APPROX_EQUAL(MIX(B, LDB, k, j), 0.))
      {
        for (i = k + 1; i < M; ++i)
        {
          MIX(B, LDB, i, j) =
              MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
        }
      }
    }
  }
}

static void strsm_U_1(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = M - 1; k >= 0; --k)
    {
      if (!APPROX_EQUAL(MIX(B, LDB, k, j), 0.))
      {
        MIX(B, LDB, k, j) = MIX(B, LDB, k, j) / MIX(A, LDA, k, k);
        for (i = 0; i < k; ++i)
        {
          MIX(B, LDB, i, j) =
              MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
        }
      }
    }
  }
}

static void sgemm_1(int M, int N, int K, double alpha, double *A, int LDA,
                    double *B, int LDB, double beta, double *C, int LDC)
{

  // NOTE as written below, we specialize to alpha = -1 beta = 1
  assert(APPROX_EQUAL(beta, ONE));
  assert(APPROX_EQUAL(alpha, -ONE));

  int i, j, k;
  double acc;

  for (i = 0; i < M; ++i)
    for (j = 0; j < N; ++j)
    {
      // BETA = 1
      acc = MIX(C, LDC, i, j);
      for (k = 0; k < K; ++k)
        acc += alpha * MIX(A, LDA, i, k) * MIX(B, LDB, k, j);
      MIX(C, LDC, i, j) = acc;
    }
}

void sgemm_1T(int M, int N, int K, double alpha, double *A, int LDA, double *B,
              int LDB, double beta, double *C, int LDC)
{

  // NOTE as written below, we specialize to alpha = -1 beta = 1
  assert(APPROX_EQUAL(beta, ONE));
  assert(APPROX_EQUAL(alpha, -ONE));

  int i, j, k;
  double acc;

  for (i = 0; i < M; ++i)
    for (j = 0; j < N; ++j)
    {
      // BETA = 1
      acc = TIX(C, LDC, i, j);
      for (k = 0; k < K; ++k)
        acc += alpha * TIX(A, LDA, i, k) * TIX(B, LDB, k, j);
      TIX(C, LDC, i, j) = acc;
    }
}

int sgetf2_1(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {
    // --------
    // ISAMAX
    double p_v;
    int p_i;

    p_i = i + isamax_1(M - i, &MIX(A, LDA, i, i), LDA);
    p_v = MIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
      sswap_1(N, &MIX(A, LDA, i, 0), 1, &MIX(A, LDA, p_i, 0), 1);
    }

    // TODO compute the minimum machine safe integer such that
    // 1 / fmin doesn't overflow. This can be inlind because
    // we are targeting SKYLAKE.

    // BLAS 1 Scale vector
    for (j = i + 1; j < M; ++j)
    {
      MIX(A, LDA, j, i) = MIX(A, LDA, j, i) / MIX(A, LDA, i, i);
    }

    if (i < MIN(M, N))
    {

      // BLAS 2 rank-1 update
      for (j = i + 1; j < M; ++j)
      {
        for (int k = i + 1; k < N; ++k)
        {
          MIX(A, LDA, j, k) =
              MIX(A, LDA, j, k) - MIX(A, LDA, j, i) * MIX(A, LDA, i, k);
        }
      }
    }
  }

  return 0;
}

// Equivalent to SGETRS (no-transpose).
static int sgetrs_1(int N, double *A, int *ipiv, double *b)
{
  // A now contains L (below diagonal)
  //                U (above diagonal)
  // Swap pivot rows in b
  slaswp_1(1, b, 1, 0, N, ipiv, 1);

#if DEBUG_LU_SOLVER
  printf("B: ");
  for (int i = 0; i < N; ++i)
    printf("%.4f  ", b[i]);
  printf("\n");
#endif

  // Forward substitution
  strsm_L_1(N, 1, A, N, b, 1);
  // Backward substitution
  strsm_U_1(N, 1, A, N, b, 1);
  return 0;
}

int lu_solve_1(int N, double *A, double *b)
{
  /**
   * FIXME for simplicity we will choose a block size of 32.
   * In the real system we can choose a dynamic block (better), or we can
   * always choose a fixed block and handle clean-up cases afterward (worse).
   */
  int *ipiv = scratch_ipiv;

  int NB = 32, retcode;

  int M = N;   // Square matrix
  int LDA = N; // N is the leading dimension

  int ib, IB, k;

  // BLocked factor A into [L \ U]

  if (N < NB)
  {
    // Use unblocked code
    retcode = sgetf2_1(M, N, A, LDA, ipiv);

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

      retcode = sgetf2_1(M - ib, IB, &AIX(ib, ib), LDA, ipiv + ib);

      if (retcode != 0)
        return retcode;

      // Update the pivot indices
      for (k = ib; k < MIN(M, ib + IB); ++k)
      {
        ipiv[k] = ipiv[k] + ib;
      }

      // Apply interchanges to columns 0 : ib
      slaswp_1(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        slaswp_1(N - ib - IB, &AIX(0, ib + IB), LDA, ib, ib + IB, ipiv, 1);

        // Compute the block row of U
        strsm_L_1(IB, N - ib - IB, &AIX(ib, ib), LDA, &AIX(ib, ib + IB), LDA);

        if (ib + IB < M) // NOTE for a square matrix this will always be true.
        {
          // Update trailing submatrix
          sgemm_1(M - ib - IB, N - ib - IB, IB, -ONE, //
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
  retcode = sgetrs_1(N, A, ipiv, b);

  return retcode;
}

/** ------------------------------------------------------------------
 * Base implementation and LAPACK base impls.
 * Using C optimizations, but NO vectorization (only setting it up).
 *
 * Using blocked (outer function) and delayed updates.
 *
 */
// FIXME XXX we can play with NB
static int isamax_2(int N, double *A, int stride)
{
  // NOTE N can be 0 if we iterate to the end of the rows in _lu_solve_XXX
  // this saves us from initializing the ipiv array. We could also do this
  // by just setting the end index to itself.

  assert(0 <= N);

  // TODO FIXME
  if (N < 1 || stride == 0)
    return 0;

  assert(0 < stride);

  // TODO speacialize the case when `STRIDE` == 1.

  double p_v, p_t;
  int i, p_i, ix;

  p_v = fabs(A[0]);
  p_i = 0;
  ix = 0 + stride;

  for (i = 1; i < N; ++i, ix += stride)
  {
    assert(ix == i * stride);

    p_t = fabs(A[ix]);
    if (p_t > p_v)
    {
      p_v = p_t;
      p_i = i;
    }
  }
  return p_i;
}

static void sswap_2(int N, double *X, int incx, double *Y, int incy)
{
  // TODO special case when incx == incy == 1
  // ^^^ This is our case actually (row-major iteration).

  assert(0 < N);
  assert(0 < incx);
  assert(0 < incy);

  double   //
      t,   //
      t_0, //
      t_1, //
      t_2, //
      t_3, //
      t_4, //
      t_5, //
      t_6, //
      t_7, //

      x_i_0, //
      x_i_1, //
      x_i_2, //
      x_i_3, //
      x_i_4, //
      x_i_5, //
      x_i_6, //
      x_i_7, //

      y_i_0, //
      y_i_1, //
      y_i_2, //
      y_i_3, //
      y_i_4, //
      y_i_5, //
      y_i_6, //
      y_i_7  //
      ;

  int i, ix, iy;

  if (incx == 1 && incy == 1)
  {
    for (i = 0; i < N - 7; i += 8)
    {

      x_i_0 = X[i + 0];
      x_i_1 = X[i + 1];
      x_i_2 = X[i + 2];
      x_i_3 = X[i + 3];
      x_i_4 = X[i + 4];
      x_i_5 = X[i + 5];
      x_i_6 = X[i + 6];
      x_i_7 = X[i + 7];

      y_i_0 = Y[i + 0];
      y_i_1 = Y[i + 1];
      y_i_2 = Y[i + 2];
      y_i_3 = Y[i + 3];
      y_i_4 = Y[i + 4];
      y_i_5 = Y[i + 5];
      y_i_6 = Y[i + 6];
      y_i_7 = Y[i + 7];

      X[i + 0] = y_i_0;
      X[i + 1] = y_i_1;
      X[i + 2] = y_i_2;
      X[i + 3] = y_i_3;
      X[i + 4] = y_i_4;
      X[i + 5] = y_i_5;
      X[i + 6] = y_i_6;
      X[i + 7] = y_i_7;

      Y[i + 0] = x_i_0;
      Y[i + 1] = x_i_1;
      Y[i + 2] = x_i_2;
      Y[i + 3] = x_i_3;
      Y[i + 4] = x_i_4;
      Y[i + 5] = x_i_5;
      Y[i + 6] = x_i_6;
      Y[i + 7] = x_i_7;
    }

    for (; i < N; ++i)
    {
      t_0 = X[i + 0];
      X[i + 0] = Y[i + 0];
      Y[i + 0] = t_0;
    }
  }
  else
  {
    for (i = 0, ix = 0, iy = 0; i < N; ++i, ix += incx, iy += incy)
    {
      t = X[ix];
      X[ix] = Y[iy];
      Y[iy] = t;
    }
  }
}

static void slaswp_2(int N, double *A, int LDA, int k1, int k2, int *ipiv,
                     int incx)
{
  // NOTE ipiv is layed out sequentially in memory so we can special case it
  assert(0 < incx);  // Do not cover the negative case
  assert(1 == incx); // Do not cover the negative case

  int n32;
  int i, j, k, p_i;

  double tmp;
  double        //
      a__i_k_0, //
      a__i_k_1, //
      a__i_k_2, //
      a__i_k_3, //
      a__i_k_4, //
      a__i_k_5, //
      a__i_k_6, //
      a__i_k_7, //

      a_pi_k_0, //
      a_pi_k_1, //
      a_pi_k_2, //
      a_pi_k_3, //
      a_pi_k_4, //
      a_pi_k_5, //
      a_pi_k_6, //
      a_pi_k_7  //
      ;

  n32 = (N / 32) * 32;

  if (0 < n32)
  {
    for (j = 0; j < n32; j += 32)
    {
      for (i = k1; i < k2; ++i)
      {
        p_i = ipiv[i];
        if (p_i != i)
        {
          for (k = j; k < j + 32 - 7; k += 8)
          {
            a__i_k_0 = MIX(A, LDA, i, k + 0);
            a__i_k_1 = MIX(A, LDA, i, k + 1);
            a__i_k_2 = MIX(A, LDA, i, k + 2);
            a__i_k_3 = MIX(A, LDA, i, k + 3);
            a__i_k_4 = MIX(A, LDA, i, k + 4);
            a__i_k_5 = MIX(A, LDA, i, k + 5);
            a__i_k_6 = MIX(A, LDA, i, k + 6);
            a__i_k_7 = MIX(A, LDA, i, k + 7);

            a_pi_k_0 = MIX(A, LDA, p_i, k + 0);
            a_pi_k_1 = MIX(A, LDA, p_i, k + 1);
            a_pi_k_2 = MIX(A, LDA, p_i, k + 2);
            a_pi_k_3 = MIX(A, LDA, p_i, k + 3);
            a_pi_k_4 = MIX(A, LDA, p_i, k + 4);
            a_pi_k_5 = MIX(A, LDA, p_i, k + 5);
            a_pi_k_6 = MIX(A, LDA, p_i, k + 6);
            a_pi_k_7 = MIX(A, LDA, p_i, k + 7);

            MIX(A, LDA, i, k + 0) = a_pi_k_0;
            MIX(A, LDA, i, k + 1) = a_pi_k_1;
            MIX(A, LDA, i, k + 2) = a_pi_k_2;
            MIX(A, LDA, i, k + 3) = a_pi_k_3;
            MIX(A, LDA, i, k + 4) = a_pi_k_4;
            MIX(A, LDA, i, k + 5) = a_pi_k_5;
            MIX(A, LDA, i, k + 6) = a_pi_k_6;
            MIX(A, LDA, i, k + 7) = a_pi_k_7;

            MIX(A, LDA, p_i, k + 0) = a__i_k_0;
            MIX(A, LDA, p_i, k + 1) = a__i_k_1;
            MIX(A, LDA, p_i, k + 2) = a__i_k_2;
            MIX(A, LDA, p_i, k + 3) = a__i_k_3;
            MIX(A, LDA, p_i, k + 4) = a__i_k_4;
            MIX(A, LDA, p_i, k + 5) = a__i_k_5;
            MIX(A, LDA, p_i, k + 6) = a__i_k_6;
            MIX(A, LDA, p_i, k + 7) = a__i_k_7;
          }
        }
      }
    }
  }

  // Leftover cases from blocking by 32
  if (n32 != N)
  {
    for (i = k1; i < k2; ++i)
    {
      p_i = ipiv[i];
      if (i != p_i)
      {
        for (k = n32; k < N - 7; k += 8)
        {
          a__i_k_0 = MIX(A, LDA, i, k + 0);
          a__i_k_1 = MIX(A, LDA, i, k + 1);
          a__i_k_2 = MIX(A, LDA, i, k + 2);
          a__i_k_3 = MIX(A, LDA, i, k + 3);
          a__i_k_4 = MIX(A, LDA, i, k + 4);
          a__i_k_5 = MIX(A, LDA, i, k + 5);
          a__i_k_6 = MIX(A, LDA, i, k + 6);
          a__i_k_7 = MIX(A, LDA, i, k + 7);

          a_pi_k_0 = MIX(A, LDA, p_i, k + 0);
          a_pi_k_1 = MIX(A, LDA, p_i, k + 1);
          a_pi_k_2 = MIX(A, LDA, p_i, k + 2);
          a_pi_k_3 = MIX(A, LDA, p_i, k + 3);
          a_pi_k_4 = MIX(A, LDA, p_i, k + 4);
          a_pi_k_5 = MIX(A, LDA, p_i, k + 5);
          a_pi_k_6 = MIX(A, LDA, p_i, k + 6);
          a_pi_k_7 = MIX(A, LDA, p_i, k + 7);

          MIX(A, LDA, i, k + 0) = a_pi_k_0;
          MIX(A, LDA, i, k + 1) = a_pi_k_1;
          MIX(A, LDA, i, k + 2) = a_pi_k_2;
          MIX(A, LDA, i, k + 3) = a_pi_k_3;
          MIX(A, LDA, i, k + 4) = a_pi_k_4;
          MIX(A, LDA, i, k + 5) = a_pi_k_5;
          MIX(A, LDA, i, k + 6) = a_pi_k_6;
          MIX(A, LDA, i, k + 7) = a_pi_k_7;

          MIX(A, LDA, p_i, k + 0) = a__i_k_0;
          MIX(A, LDA, p_i, k + 1) = a__i_k_1;
          MIX(A, LDA, p_i, k + 2) = a__i_k_2;
          MIX(A, LDA, p_i, k + 3) = a__i_k_3;
          MIX(A, LDA, p_i, k + 4) = a__i_k_4;
          MIX(A, LDA, p_i, k + 5) = a__i_k_5;
          MIX(A, LDA, p_i, k + 6) = a__i_k_6;
          MIX(A, LDA, p_i, k + 7) = a__i_k_7;
        }

        for (; k < N; ++k)
        {
          a__i_k_0 = MIX(A, LDA, i, k + 0);
          a_pi_k_0 = MIX(A, LDA, p_i, k + 0);
          MIX(A, LDA, p_i, k + 0) = a__i_k_0;
          MIX(A, LDA, i, k + 0) = a_pi_k_0;
        }
      }
    }
  }
}

static void strsm_L_2(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = 0; k < M; ++k)
    {
      for (i = k + 1; i < M; ++i)
      {
        MIX(B, LDB, i, j) =
            MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
      }
    }
  }
}

static void strsm_U_2(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = M - 1; k >= 0; --k)
    {
      MIX(B, LDB, k, j) = MIX(B, LDB, k, j) / MIX(A, LDA, k, k);
      for (i = 0; i < k; ++i)
      {
        MIX(B, LDB, i, j) =
            MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
      }
    }
  }
}

// NOTE this function handles boundary cases
static void sgemm_2(int M, int N, int K, double alpha, double *restrict A,
                    int LDA, double *restrict B, int LDB, double beta,
                    double *restrict C, int LDC)
{

  /**
   * A[ M x K ] * B[ K x N ] = C[ M x N ]
   */

  // NOTE as written below, we specialize to alpha = -1 beta = 1
  assert(APPROX_EQUAL(beta, ONE));
  assert(APPROX_EQUAL(alpha, -ONE));

  // ---------------
  // https://en.wikichip.org/wiki/intel/microarchitectures/skylake_(client)
  //
  // NOTE Skylake has a 32000 B L1 cache
  // With cache lines of 64 B

  // TODO add an include for autotuning
  const int NB = 56;
  const int MB = 56;
  const int KB = 56;
  const int DBL_LMT = 512 * 2;

  double __attribute__((aligned(32))) AL[MB * KB];
  double __attribute__((aligned(32))) BL[KB * NB];
  double __attribute__((aligned(32))) CL[MB * NB];

  // NOTE choose MU + NU + MU * NU <= 16
  const int MU = 4;
  const int NU = 2;
  const int KU = 8;

  int i, j, k,      //
      ii, jj, kk,   //
      iii, jjj, kkk //
      ;

  i = 0;
  ii = 0;
  iii = 0;

  j = 0;
  jj = 0;
  jjj = 0;

  k = 0;
  kk = 0;
  kkk = 0;

  double             //
      A_iii_0_kkk_0, //
      A_iii_0_kkk_1, //
      A_iii_0_kkk_2, //
      A_iii_0_kkk_3, //
      A_iii_0_kkk_4, //
      A_iii_0_kkk_5, //
      A_iii_0_kkk_6, //
      A_iii_0_kkk_7, //

      A_iii_1_kkk_0, //
      A_iii_1_kkk_1, //
      A_iii_1_kkk_2, //
      A_iii_1_kkk_3, //
      A_iii_1_kkk_4, //
      A_iii_1_kkk_5, //
      A_iii_1_kkk_6, //
      A_iii_1_kkk_7, //

      A_iii_2_kkk_0, //
      A_iii_2_kkk_1, //
      A_iii_2_kkk_2, //
      A_iii_2_kkk_3, //
      A_iii_2_kkk_4, //
      A_iii_2_kkk_5, //
      A_iii_2_kkk_6, //
      A_iii_2_kkk_7, //

      A_iii_3_kkk_0, //
      A_iii_3_kkk_1, //
      A_iii_3_kkk_2, //
      A_iii_3_kkk_3, //
      A_iii_3_kkk_4, //
      A_iii_3_kkk_5, //
      A_iii_3_kkk_6, //
      A_iii_3_kkk_7, //
      A_iii_3_kkk_8, //

      C_iii_0_jjj_0, //
      C_iii_0_jjj_1, //
      C_iii_1_jjj_0, //
      C_iii_1_jjj_1, //
      C_iii_2_jjj_0, //
      C_iii_2_jjj_1, //
      C_iii_3_jjj_0, //
      C_iii_3_jjj_1, //

      B_kkk_0_jjj_0, //
      B_kkk_0_jjj_1, //
      B_kkk_1_jjj_0, //
      B_kkk_1_jjj_1, //
      B_kkk_2_jjj_0, //
      B_kkk_2_jjj_1, //
      B_kkk_3_jjj_0, //
      B_kkk_3_jjj_1, //
      B_kkk_4_jjj_0, //
      B_kkk_4_jjj_1, //
      B_kkk_5_jjj_0, //
      B_kkk_5_jjj_1, //
      B_kkk_6_jjj_0, //
      B_kkk_6_jjj_1, //
      B_kkk_7_jjj_0, //
      B_kkk_7_jjj_1  //

      ;

  // -----------------------------------------------------------------
  // Basic unrolled MMM with no register blocking

  // NOTE this should be our case as the incoming matrix A is tall and skinny.
  // i blocked
  for (i = 0; i <= M - MB; i += MB)
  {
    // j blocked
    for (j = 0; j <= N - NB; j += NB)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)
          for (jj = j; jj <= (j + NB) - NU; jj += NU)
            for (kk = k; kk <= (k + KB) - KU; kk += KU)

            /* // Register blocking */
            /* for (kkk = kk; kkk < kk + KU; ++kkk) */
            /*   for (iii = ii; iii < ii + MU; ++iii) */
            /*     for (jjj = jj; jjj < jj + NU; ++jjj) */
            {

              // FIXME reorder stores and loads

              C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, jj + 0);
              C_iii_0_jjj_1 = MIX(C, LDC, ii + 0, jj + 1);
              C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, jj + 0);
              C_iii_1_jjj_1 = MIX(C, LDC, ii + 1, jj + 1);
              C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, jj + 0);
              C_iii_2_jjj_1 = MIX(C, LDC, ii + 2, jj + 1);
              C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, jj + 0);
              C_iii_3_jjj_1 = MIX(C, LDC, ii + 3, jj + 1);

              B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, jj + 0);
              B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, jj + 0);
              B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, jj + 0);
              B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, jj + 0);
              B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, jj + 0);
              B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, jj + 0);
              B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, jj + 0);
              B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, jj + 0);

              B_kkk_0_jjj_1 = MIX(B, LDB, kk + 0, jj + 1);
              B_kkk_1_jjj_1 = MIX(B, LDB, kk + 1, jj + 1);
              B_kkk_2_jjj_1 = MIX(B, LDB, kk + 2, jj + 1);
              B_kkk_3_jjj_1 = MIX(B, LDB, kk + 3, jj + 1);
              B_kkk_4_jjj_1 = MIX(B, LDB, kk + 4, jj + 1);
              B_kkk_5_jjj_1 = MIX(B, LDB, kk + 5, jj + 1);
              B_kkk_6_jjj_1 = MIX(B, LDB, kk + 6, jj + 1);
              B_kkk_7_jjj_1 = MIX(B, LDB, kk + 7, jj + 1);

              A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, kk + 0);
              A_iii_0_kkk_1 = MIX(A, LDA, ii + 0, kk + 1);
              A_iii_0_kkk_2 = MIX(A, LDA, ii + 0, kk + 2);
              A_iii_0_kkk_3 = MIX(A, LDA, ii + 0, kk + 3);
              A_iii_0_kkk_4 = MIX(A, LDA, ii + 0, kk + 4);
              A_iii_0_kkk_5 = MIX(A, LDA, ii + 0, kk + 5);
              A_iii_0_kkk_6 = MIX(A, LDA, ii + 0, kk + 6);
              A_iii_0_kkk_7 = MIX(A, LDA, ii + 0, kk + 7);

              A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, kk + 0);
              A_iii_1_kkk_1 = MIX(A, LDA, ii + 1, kk + 1);
              A_iii_1_kkk_2 = MIX(A, LDA, ii + 1, kk + 2);
              A_iii_1_kkk_3 = MIX(A, LDA, ii + 1, kk + 3);
              A_iii_1_kkk_4 = MIX(A, LDA, ii + 1, kk + 4);
              A_iii_1_kkk_5 = MIX(A, LDA, ii + 1, kk + 5);
              A_iii_1_kkk_6 = MIX(A, LDA, ii + 1, kk + 6);
              A_iii_1_kkk_7 = MIX(A, LDA, ii + 1, kk + 7);

              A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, kk + 0);
              A_iii_2_kkk_1 = MIX(A, LDA, ii + 2, kk + 1);
              A_iii_2_kkk_2 = MIX(A, LDA, ii + 2, kk + 2);
              A_iii_2_kkk_3 = MIX(A, LDA, ii + 2, kk + 3);
              A_iii_2_kkk_4 = MIX(A, LDA, ii + 2, kk + 4);
              A_iii_2_kkk_5 = MIX(A, LDA, ii + 2, kk + 5);
              A_iii_2_kkk_6 = MIX(A, LDA, ii + 2, kk + 6);
              A_iii_2_kkk_7 = MIX(A, LDA, ii + 2, kk + 7);

              A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, kk + 0);
              A_iii_3_kkk_1 = MIX(A, LDA, ii + 3, kk + 1);
              A_iii_3_kkk_2 = MIX(A, LDA, ii + 3, kk + 2);
              A_iii_3_kkk_3 = MIX(A, LDA, ii + 3, kk + 3);
              A_iii_3_kkk_4 = MIX(A, LDA, ii + 3, kk + 4);
              A_iii_3_kkk_5 = MIX(A, LDA, ii + 3, kk + 5);
              A_iii_3_kkk_6 = MIX(A, LDA, ii + 3, kk + 6);
              A_iii_3_kkk_7 = MIX(A, LDA, ii + 3, kk + 7);
              A_iii_3_kkk_8 = MIX(A, LDA, ii + 3, kk + 8);

              // ------

              C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
              C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;
              C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
              C_iii_1_jjj_1 -= B_kkk_0_jjj_1 * A_iii_1_kkk_0;
              C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
              C_iii_2_jjj_1 -= B_kkk_0_jjj_1 * A_iii_2_kkk_0;
              C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;
              C_iii_3_jjj_1 -= B_kkk_0_jjj_1 * A_iii_3_kkk_0;

              C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
              C_iii_0_jjj_1 -= B_kkk_1_jjj_1 * A_iii_0_kkk_1;
              C_iii_1_jjj_0 -= B_kkk_1_jjj_0 * A_iii_1_kkk_1;
              C_iii_1_jjj_1 -= B_kkk_1_jjj_1 * A_iii_1_kkk_1;
              C_iii_2_jjj_0 -= B_kkk_1_jjj_0 * A_iii_2_kkk_1;
              C_iii_2_jjj_1 -= B_kkk_1_jjj_1 * A_iii_2_kkk_1;
              C_iii_3_jjj_0 -= B_kkk_1_jjj_0 * A_iii_3_kkk_1;
              C_iii_3_jjj_1 -= B_kkk_1_jjj_1 * A_iii_3_kkk_1;

              C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
              C_iii_0_jjj_1 -= B_kkk_2_jjj_1 * A_iii_0_kkk_2;
              C_iii_1_jjj_0 -= B_kkk_2_jjj_0 * A_iii_1_kkk_2;
              C_iii_1_jjj_1 -= B_kkk_2_jjj_1 * A_iii_1_kkk_2;
              C_iii_2_jjj_0 -= B_kkk_2_jjj_0 * A_iii_2_kkk_2;
              C_iii_2_jjj_1 -= B_kkk_2_jjj_1 * A_iii_2_kkk_2;
              C_iii_3_jjj_0 -= B_kkk_2_jjj_0 * A_iii_3_kkk_2;
              C_iii_3_jjj_1 -= B_kkk_2_jjj_1 * A_iii_3_kkk_2;

              C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
              C_iii_0_jjj_1 -= B_kkk_3_jjj_1 * A_iii_0_kkk_3;
              C_iii_1_jjj_0 -= B_kkk_3_jjj_0 * A_iii_1_kkk_3;
              C_iii_1_jjj_1 -= B_kkk_3_jjj_1 * A_iii_1_kkk_3;
              C_iii_2_jjj_0 -= B_kkk_3_jjj_0 * A_iii_2_kkk_3;
              C_iii_2_jjj_1 -= B_kkk_3_jjj_1 * A_iii_2_kkk_3;
              C_iii_3_jjj_0 -= B_kkk_3_jjj_0 * A_iii_3_kkk_3;
              C_iii_3_jjj_1 -= B_kkk_3_jjj_1 * A_iii_3_kkk_3;

              C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
              C_iii_0_jjj_1 -= B_kkk_4_jjj_1 * A_iii_0_kkk_4;
              C_iii_1_jjj_0 -= B_kkk_4_jjj_0 * A_iii_1_kkk_4;
              C_iii_1_jjj_1 -= B_kkk_4_jjj_1 * A_iii_1_kkk_4;
              C_iii_2_jjj_0 -= B_kkk_4_jjj_0 * A_iii_2_kkk_4;
              C_iii_2_jjj_1 -= B_kkk_4_jjj_1 * A_iii_2_kkk_4;
              C_iii_3_jjj_0 -= B_kkk_4_jjj_0 * A_iii_3_kkk_4;
              C_iii_3_jjj_1 -= B_kkk_4_jjj_1 * A_iii_3_kkk_4;

              C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
              C_iii_0_jjj_1 -= B_kkk_5_jjj_1 * A_iii_0_kkk_5;
              C_iii_1_jjj_0 -= B_kkk_5_jjj_0 * A_iii_1_kkk_5;
              C_iii_1_jjj_1 -= B_kkk_5_jjj_1 * A_iii_1_kkk_5;
              C_iii_2_jjj_0 -= B_kkk_5_jjj_0 * A_iii_2_kkk_5;
              C_iii_2_jjj_1 -= B_kkk_5_jjj_1 * A_iii_2_kkk_5;
              C_iii_3_jjj_0 -= B_kkk_5_jjj_0 * A_iii_3_kkk_5;
              C_iii_3_jjj_1 -= B_kkk_5_jjj_1 * A_iii_3_kkk_5;

              C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
              C_iii_0_jjj_1 -= B_kkk_6_jjj_1 * A_iii_0_kkk_6;
              C_iii_1_jjj_0 -= B_kkk_6_jjj_0 * A_iii_1_kkk_6;
              C_iii_1_jjj_1 -= B_kkk_6_jjj_1 * A_iii_1_kkk_6;
              C_iii_2_jjj_0 -= B_kkk_6_jjj_0 * A_iii_2_kkk_6;
              C_iii_2_jjj_1 -= B_kkk_6_jjj_1 * A_iii_2_kkk_6;
              C_iii_3_jjj_0 -= B_kkk_6_jjj_0 * A_iii_3_kkk_6;
              C_iii_3_jjj_1 -= B_kkk_6_jjj_1 * A_iii_3_kkk_6;

              C_iii_0_jjj_1 -= B_kkk_7_jjj_1 * A_iii_0_kkk_7;
              C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;
              C_iii_1_jjj_1 -= B_kkk_7_jjj_1 * A_iii_1_kkk_7;
              C_iii_1_jjj_0 -= B_kkk_7_jjj_0 * A_iii_1_kkk_7;
              C_iii_2_jjj_0 -= B_kkk_7_jjj_0 * A_iii_2_kkk_7;
              C_iii_2_jjj_1 -= B_kkk_7_jjj_1 * A_iii_2_kkk_7;
              C_iii_3_jjj_0 -= B_kkk_7_jjj_0 * A_iii_3_kkk_7;
              C_iii_3_jjj_1 -= B_kkk_7_jjj_1 * A_iii_3_kkk_7;

              // -----

              MIX(C, LDC, ii + 0, jj + 0) = C_iii_0_jjj_0;
              MIX(C, LDC, ii + 0, jj + 1) = C_iii_0_jjj_1;
              MIX(C, LDC, ii + 1, jj + 0) = C_iii_1_jjj_0;
              MIX(C, LDC, ii + 1, jj + 1) = C_iii_1_jjj_1;
              MIX(C, LDC, ii + 2, jj + 0) = C_iii_2_jjj_0;
              MIX(C, LDC, ii + 2, jj + 1) = C_iii_2_jjj_1;
              MIX(C, LDC, ii + 3, jj + 0) = C_iii_3_jjj_0;
              MIX(C, LDC, ii + 3, jj + 1) = C_iii_3_jjj_1;
            }

      // k overflow
      for (; k < K; ++k)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)
          for (jj = j; jj <= (j + NB) - NU; jj += NU)
          /* // Registier blocking */
          /* for (iii = ii; iii < ii + MU; ++iii) */
          /*   for (jjj = jj; jjj < jj + NU; ++jjj) */
          {
            C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, jj + 0);
            C_iii_0_jjj_1 = MIX(C, LDC, ii + 0, jj + 1);

            C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, jj + 0);
            C_iii_1_jjj_1 = MIX(C, LDC, ii + 1, jj + 1);

            C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, jj + 0);
            C_iii_2_jjj_1 = MIX(C, LDC, ii + 2, jj + 1);

            C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, jj + 0);
            C_iii_3_jjj_1 = MIX(C, LDC, ii + 3, jj + 1);

            B_kkk_0_jjj_0 = MIX(B, LDB, k + 0, jj + 0);
            B_kkk_0_jjj_1 = MIX(B, LDB, k + 0, jj + 1);

            A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, k + 0);
            A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, k + 0);
            A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, k + 0);
            A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, k + 0);

            // ----

            C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
            C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;
            C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
            C_iii_1_jjj_1 -= B_kkk_0_jjj_1 * A_iii_1_kkk_0;
            C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
            C_iii_2_jjj_1 -= B_kkk_0_jjj_1 * A_iii_2_kkk_0;
            C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;
            C_iii_3_jjj_1 -= B_kkk_0_jjj_1 * A_iii_3_kkk_0;

            // ----

            MIX(C, LDC, ii + 0, jj + 0) = C_iii_0_jjj_0;
            MIX(C, LDC, ii + 0, jj + 1) = C_iii_0_jjj_1;
            MIX(C, LDC, ii + 1, jj + 0) = C_iii_1_jjj_0;
            MIX(C, LDC, ii + 1, jj + 1) = C_iii_1_jjj_1;
            MIX(C, LDC, ii + 2, jj + 0) = C_iii_2_jjj_0;
            MIX(C, LDC, ii + 2, jj + 1) = C_iii_2_jjj_1;
            MIX(C, LDC, ii + 3, jj + 0) = C_iii_3_jjj_0;
            MIX(C, LDC, ii + 3, jj + 1) = C_iii_3_jjj_1;
          }
    }

    // j overflow
    for (; j < N; ++j)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)
          for (kk = k; kk <= (k + KB) - KU; kk += KU)

          // Registier blocking
          /* for (kkk = kk; kkk < kk + KU; ++kkk) */
          /*   for (iii = ii; iii < ii + MU; ++iii) */
          {

            C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, j + 0);
            C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, j + 0);
            C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, j + 0);
            C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, j + 0);

            B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, j + 0);
            B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, j + 0);
            B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, j + 0);
            B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, j + 0);
            B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, j + 0);
            B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, j + 0);
            B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, j + 0);
            B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, j + 0);

            A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, kk + 0);
            A_iii_0_kkk_1 = MIX(A, LDA, ii + 0, kk + 1);
            A_iii_0_kkk_2 = MIX(A, LDA, ii + 0, kk + 2);
            A_iii_0_kkk_3 = MIX(A, LDA, ii + 0, kk + 3);
            A_iii_0_kkk_4 = MIX(A, LDA, ii + 0, kk + 4);
            A_iii_0_kkk_5 = MIX(A, LDA, ii + 0, kk + 5);
            A_iii_0_kkk_6 = MIX(A, LDA, ii + 0, kk + 6);
            A_iii_0_kkk_7 = MIX(A, LDA, ii + 0, kk + 7);

            A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, kk + 0);
            A_iii_1_kkk_1 = MIX(A, LDA, ii + 1, kk + 1);
            A_iii_1_kkk_2 = MIX(A, LDA, ii + 1, kk + 2);
            A_iii_1_kkk_3 = MIX(A, LDA, ii + 1, kk + 3);
            A_iii_1_kkk_4 = MIX(A, LDA, ii + 1, kk + 4);
            A_iii_1_kkk_5 = MIX(A, LDA, ii + 1, kk + 5);
            A_iii_1_kkk_6 = MIX(A, LDA, ii + 1, kk + 6);
            A_iii_1_kkk_7 = MIX(A, LDA, ii + 1, kk + 7);

            A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, kk + 0);
            A_iii_2_kkk_1 = MIX(A, LDA, ii + 2, kk + 1);
            A_iii_2_kkk_2 = MIX(A, LDA, ii + 2, kk + 2);
            A_iii_2_kkk_3 = MIX(A, LDA, ii + 2, kk + 3);
            A_iii_2_kkk_4 = MIX(A, LDA, ii + 2, kk + 4);
            A_iii_2_kkk_5 = MIX(A, LDA, ii + 2, kk + 5);
            A_iii_2_kkk_6 = MIX(A, LDA, ii + 2, kk + 6);
            A_iii_2_kkk_7 = MIX(A, LDA, ii + 2, kk + 7);

            A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, kk + 0);
            A_iii_3_kkk_1 = MIX(A, LDA, ii + 3, kk + 1);
            A_iii_3_kkk_2 = MIX(A, LDA, ii + 3, kk + 2);
            A_iii_3_kkk_3 = MIX(A, LDA, ii + 3, kk + 3);
            A_iii_3_kkk_4 = MIX(A, LDA, ii + 3, kk + 4);
            A_iii_3_kkk_5 = MIX(A, LDA, ii + 3, kk + 5);
            A_iii_3_kkk_6 = MIX(A, LDA, ii + 3, kk + 6);
            A_iii_3_kkk_7 = MIX(A, LDA, ii + 3, kk + 7);
            A_iii_3_kkk_8 = MIX(A, LDA, ii + 3, kk + 8);

            // ------

            C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
            C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
            C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
            C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;

            C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
            C_iii_1_jjj_0 -= B_kkk_1_jjj_0 * A_iii_1_kkk_1;
            C_iii_2_jjj_0 -= B_kkk_1_jjj_0 * A_iii_2_kkk_1;
            C_iii_3_jjj_0 -= B_kkk_1_jjj_0 * A_iii_3_kkk_1;

            C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
            C_iii_1_jjj_0 -= B_kkk_2_jjj_0 * A_iii_1_kkk_2;
            C_iii_2_jjj_0 -= B_kkk_2_jjj_0 * A_iii_2_kkk_2;
            C_iii_3_jjj_0 -= B_kkk_2_jjj_0 * A_iii_3_kkk_2;

            C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
            C_iii_1_jjj_0 -= B_kkk_3_jjj_0 * A_iii_1_kkk_3;
            C_iii_2_jjj_0 -= B_kkk_3_jjj_0 * A_iii_2_kkk_3;
            C_iii_3_jjj_0 -= B_kkk_3_jjj_0 * A_iii_3_kkk_3;

            C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
            C_iii_1_jjj_0 -= B_kkk_4_jjj_0 * A_iii_1_kkk_4;
            C_iii_2_jjj_0 -= B_kkk_4_jjj_0 * A_iii_2_kkk_4;
            C_iii_3_jjj_0 -= B_kkk_4_jjj_0 * A_iii_3_kkk_4;

            C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
            C_iii_1_jjj_0 -= B_kkk_5_jjj_0 * A_iii_1_kkk_5;
            C_iii_2_jjj_0 -= B_kkk_5_jjj_0 * A_iii_2_kkk_5;
            C_iii_3_jjj_0 -= B_kkk_5_jjj_0 * A_iii_3_kkk_5;

            C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
            C_iii_1_jjj_0 -= B_kkk_6_jjj_0 * A_iii_1_kkk_6;
            C_iii_2_jjj_0 -= B_kkk_6_jjj_0 * A_iii_2_kkk_6;
            C_iii_3_jjj_0 -= B_kkk_6_jjj_0 * A_iii_3_kkk_6;

            C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;
            C_iii_1_jjj_0 -= B_kkk_7_jjj_0 * A_iii_1_kkk_7;
            C_iii_2_jjj_0 -= B_kkk_7_jjj_0 * A_iii_2_kkk_7;
            C_iii_3_jjj_0 -= B_kkk_7_jjj_0 * A_iii_3_kkk_7;

            // -----

            MIX(C, LDC, ii + 0, j + 0) = C_iii_0_jjj_0;
            MIX(C, LDC, ii + 1, j + 0) = C_iii_1_jjj_0;
            MIX(C, LDC, ii + 2, j + 0) = C_iii_2_jjj_0;
            MIX(C, LDC, ii + 3, j + 0) = C_iii_3_jjj_0;
          }

      // k overflow
      for (; k < K; ++k)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)

        // Register blocking
        /* for (iii = ii; iii < ii + MU; ++iii) */
        {
          C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, j + 0);
          C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, j + 0);
          C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, j + 0);
          C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, j + 0);

          B_kkk_0_jjj_0 = MIX(B, LDB, k + 0, j + 0);

          A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, k + 0);
          A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, k + 0);
          A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, k + 0);
          A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, k + 0);

          // ------

          C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
          C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
          C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
          C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;

          // -----

          MIX(C, LDC, ii + 0, j + 0) = C_iii_0_jjj_0;
          MIX(C, LDC, ii + 1, j + 0) = C_iii_1_jjj_0;
          MIX(C, LDC, ii + 2, j + 0) = C_iii_2_jjj_0;
          MIX(C, LDC, ii + 3, j + 0) = C_iii_3_jjj_0;
        }
    }
  }

  // i overflow
  for (; i < M; ++i)
  {
    // j blocked
    for (j = 0; j <= N - NB; j += NB)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (jj = j; jj <= (j + NB) - NU; jj += NU)
          for (kk = k; kk <= (k + KB) - KU; kk += KU)

          // Register blocking
          /* for (kkk = kk; kkk < kk + KU; ++kkk) */
          /*   for (jjj = jj; jjj < jj + NU; ++jjj) */
          {

            C_iii_0_jjj_0 = MIX(C, LDC, i + 0, jj + 0);
            C_iii_0_jjj_1 = MIX(C, LDC, i + 0, jj + 1);

            B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, jj + 0);
            B_kkk_0_jjj_1 = MIX(B, LDB, kk + 0, jj + 1);
            B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, jj + 0);
            B_kkk_1_jjj_1 = MIX(B, LDB, kk + 1, jj + 1);
            B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, jj + 0);
            B_kkk_2_jjj_1 = MIX(B, LDB, kk + 2, jj + 1);
            B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, jj + 0);
            B_kkk_3_jjj_1 = MIX(B, LDB, kk + 3, jj + 1);
            B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, jj + 0);
            B_kkk_4_jjj_1 = MIX(B, LDB, kk + 4, jj + 1);
            B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, jj + 0);
            B_kkk_5_jjj_1 = MIX(B, LDB, kk + 5, jj + 1);
            B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, jj + 0);
            B_kkk_6_jjj_1 = MIX(B, LDB, kk + 6, jj + 1);
            B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, jj + 0);
            B_kkk_7_jjj_1 = MIX(B, LDB, kk + 7, jj + 1);

            A_iii_0_kkk_0 = MIX(A, LDA, i + 0, kk + 0);
            A_iii_0_kkk_1 = MIX(A, LDA, i + 0, kk + 1);
            A_iii_0_kkk_2 = MIX(A, LDA, i + 0, kk + 2);
            A_iii_0_kkk_3 = MIX(A, LDA, i + 0, kk + 3);
            A_iii_0_kkk_4 = MIX(A, LDA, i + 0, kk + 4);
            A_iii_0_kkk_5 = MIX(A, LDA, i + 0, kk + 5);
            A_iii_0_kkk_6 = MIX(A, LDA, i + 0, kk + 6);
            A_iii_0_kkk_7 = MIX(A, LDA, i + 0, kk + 7);

            // ------

            C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
            C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;

            C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
            C_iii_0_jjj_1 -= B_kkk_1_jjj_1 * A_iii_0_kkk_1;

            C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
            C_iii_0_jjj_1 -= B_kkk_2_jjj_1 * A_iii_0_kkk_2;

            C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
            C_iii_0_jjj_1 -= B_kkk_3_jjj_1 * A_iii_0_kkk_3;

            C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
            C_iii_0_jjj_1 -= B_kkk_4_jjj_1 * A_iii_0_kkk_4;

            C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
            C_iii_0_jjj_1 -= B_kkk_5_jjj_1 * A_iii_0_kkk_5;

            C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
            C_iii_0_jjj_1 -= B_kkk_6_jjj_1 * A_iii_0_kkk_6;

            C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;
            C_iii_0_jjj_1 -= B_kkk_7_jjj_1 * A_iii_0_kkk_7;

            // -----

            MIX(C, LDC, i + 0, jj + 0) = C_iii_0_jjj_0;
            MIX(C, LDC, i + 0, jj + 1) = C_iii_0_jjj_1;
          }

      // k overflow
      for (; k < K; ++k)

        // Cache blocking
        for (jj = j; jj <= (j + NB) - NU; jj += NU)

        // Register blocking
        /* for (jjj = jj; jjj < jj + NU; ++jjj) */
        {

          C_iii_0_jjj_0 = MIX(C, LDC, i + 0, jj + 0);
          C_iii_0_jjj_1 = MIX(C, LDC, i + 0, jj + 1);

          B_kkk_0_jjj_0 = MIX(B, LDB, k + 0, jj + 0);
          B_kkk_0_jjj_1 = MIX(B, LDB, k + 0, jj + 1);

          A_iii_0_kkk_0 = MIX(A, LDA, i + 0, k + 0);

          // ------

          C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
          C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;

          // -----

          MIX(C, LDC, i + 0, jj + 0) = C_iii_0_jjj_0;
          MIX(C, LDC, i + 0, jj + 1) = C_iii_0_jjj_1;
        }
    }

    // j overflow
    for (; j < N; ++j)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (kk = k; kk <= (k + KB) - KU; kk += KU)

        // Register blocking
        /* for (kkk = kk; kkk < kk + KU; ++kkk) */
        {
          C_iii_0_jjj_0 = MIX(C, LDC, i + 0, j + 0);

          B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, j + 0);
          B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, j + 0);
          B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, j + 0);
          B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, j + 0);
          B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, j + 0);
          B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, j + 0);
          B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, j + 0);
          B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, j + 0);

          A_iii_0_kkk_0 = MIX(A, LDA, i + 0, kk + 0);
          A_iii_0_kkk_1 = MIX(A, LDA, i + 0, kk + 1);
          A_iii_0_kkk_2 = MIX(A, LDA, i + 0, kk + 2);
          A_iii_0_kkk_3 = MIX(A, LDA, i + 0, kk + 3);
          A_iii_0_kkk_4 = MIX(A, LDA, i + 0, kk + 4);
          A_iii_0_kkk_5 = MIX(A, LDA, i + 0, kk + 5);
          A_iii_0_kkk_6 = MIX(A, LDA, i + 0, kk + 6);
          A_iii_0_kkk_7 = MIX(A, LDA, i + 0, kk + 7);

          // ------

          C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
          C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
          C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
          C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
          C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
          C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
          C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
          C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;

          // -----

          MIX(C, LDC, i + 0, j + 0) = C_iii_0_jjj_0;
        }

      // k overflow
      for (; k < K; ++k)
        MIX(C, LDC, i, j) =
            MIX(C, LDC, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
    }
  }

  return;
}

int sgetf2_2(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j, k, p_i;

  double   //
      p_v, //
      m_0  //
      ;

  double      //
      A_j_k0, //
      A_j_k1, //
      A_j_k2, //
      A_j_k3, //
      A_j_k4, //
      A_j_k5, //
      A_j_k6, //
      A_j_k7, //

      A_i_k0, //
      A_i_k1, //
      A_i_k2, //
      A_i_k3, //
      A_i_k4, //
      A_i_k5, //
      A_i_k6, //
      A_i_k7  //
      ;
  // Quick return
  if (!M || !N)
    return 0;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {

    p_i = i + isamax_2(M - i, &MIX(A, LDA, i, i), LDA);
    p_v = MIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
#ifdef DEBUG_LU_SOLVER
      printf("Switching rows: %d %d\n", i, p_i);
#endif
      sswap_2(N, &MIX(A, LDA, i, 0), 1, &MIX(A, LDA, p_i, 0), 1);
    }

    // TODO compute the minimum machine safe integer such that
    // 1 / fmin doesn't overflow. This can be inlind because
    // we are targeting SKYLAKE.

    m_0 = 1 / MIX(A, LDA, i, i);

    // BLAS 1 Scale vector (NOTE column vector)
    for (j = i + 1; j < M; ++j)
    {
      MIX(A, LDA, j, i) = m_0 * MIX(A, LDA, j, i);
    }

    if (i < MIN(M, N))
    {

      // BLAS 2 rank-1 update
      for (j = i + 1; j < M; ++j)
      {

        // Negate to make computations look like FMA :)
        m_0 = -MIX(A, LDA, j, i);
        for (k = i + 1; k < N - 7; k += 8)
        {
          A_j_k0 = MIX(A, LDA, j, k + 0);
          A_j_k1 = MIX(A, LDA, j, k + 1);
          A_j_k2 = MIX(A, LDA, j, k + 2);
          A_j_k3 = MIX(A, LDA, j, k + 3);
          A_j_k4 = MIX(A, LDA, j, k + 4);
          A_j_k5 = MIX(A, LDA, j, k + 5);
          A_j_k6 = MIX(A, LDA, j, k + 6);
          A_j_k7 = MIX(A, LDA, j, k + 7);

          A_i_k0 = MIX(A, LDA, i, k + 0);
          A_i_k1 = MIX(A, LDA, i, k + 1);
          A_i_k2 = MIX(A, LDA, i, k + 2);
          A_i_k3 = MIX(A, LDA, i, k + 3);
          A_i_k4 = MIX(A, LDA, i, k + 4);
          A_i_k5 = MIX(A, LDA, i, k + 5);
          A_i_k6 = MIX(A, LDA, i, k + 6);
          A_i_k7 = MIX(A, LDA, i, k + 7);

          MIX(A, LDA, j, k + 0) = m_0 * A_i_k0 + A_j_k0;
          MIX(A, LDA, j, k + 1) = m_0 * A_i_k1 + A_j_k1;
          MIX(A, LDA, j, k + 2) = m_0 * A_i_k2 + A_j_k2;
          MIX(A, LDA, j, k + 3) = m_0 * A_i_k3 + A_j_k3;
          MIX(A, LDA, j, k + 4) = m_0 * A_i_k4 + A_j_k4;
          MIX(A, LDA, j, k + 5) = m_0 * A_i_k5 + A_j_k5;
          MIX(A, LDA, j, k + 6) = m_0 * A_i_k6 + A_j_k6;
          MIX(A, LDA, j, k + 7) = m_0 * A_i_k7 + A_j_k7;
        }

        for (; k < N; ++k)
        {
          A_j_k0 = MIX(A, LDA, j, k + 0);
          A_i_k0 = MIX(A, LDA, i, k + 0);
          MIX(A, LDA, j, k + 0) = m_0 * A_i_k0 + A_j_k0;
        }
      }
    }
  }

  return 0;
}

// Equivalent to SGETRS (no-transpose).
static int sgetrs_2(int N, double *A, int *ipiv, double *b)
{
  // A now contains L (below diagonal)
  //                U (above diagonal)
  // Swap pivot rows in b
  slaswp_2(1, b, 1, 0, N, ipiv, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Swapped\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Forward substitution
  strsm_L_2(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB forward\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Backward substitution
  strsm_U_2(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB solved\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  return 0;
}

// Skylake has L1 cache of 32 KB
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
    retcode = sgetf2_2(M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }

  // BLocked factor A into [L \ U]
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = sgetf2_2(M - ib, IB, &AIX(ib, ib), LDA, ipiv + ib);

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
      slaswp_2(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        slaswp_2(N - ib - IB, &AIX(0, ib + IB), LDA, ib, ib + IB, ipiv, 1);

        // Compute the block row of U
        strsm_L_2(IB, N - ib - IB, &AIX(ib, ib), LDA, &AIX(ib, ib + IB), LDA);

        // Update trailing submatrix
        sgemm_2(M - ib - IB, N - ib - IB, IB, -ONE, //
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
  retcode = sgetrs_2(N, A, ipiv, b);

  return retcode;
}

#ifdef TEST_MKL

void sgemm_intel(int M, int N, int K, double alpha, double *A, int LDA,
                 double *B, int LDB, double beta, double *C, int LDC)
{
  // Update trailing submatrix
  return cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, M, N, K, alpha,
                     A, LDA, B, LDB, beta, C, LDC);
}

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
      slaswp_2(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        slaswp_2(N - ib - IB, &AIX(0, ib + IB), LDA, ib, ib + IB, ipiv, 1);

        // Compute the block row of U
        strsm_L_2(IB, N - ib - IB, &AIX(ib, ib), LDA, &AIX(ib, ib + IB), LDA);

        // Update trailing submatrix
        sgemm_intel(M - ib - IB, N - ib - IB, IB, -ONE, //
                    &AIX(ib + IB, ib), LDA,             //
                    &AIX(ib, ib + IB), LDA,             //
                    ONE,                                //
                    &AIX(ib + IB, ib + IB), LDA         //
        );
      }
    }
  }

  // Solve the system with A
  // retcode = sgetrs_2(N, A, ipiv, b);
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

/* -------------------------------------------------------------------
 * Transposed memory layout operations
 *
 */
static void slaswp_5(int N, double *A, int LDA, int k1, int k2, int *ipiv,
                     int incx)
{
  // NOTE ipiv is layed out sequentially in memory so we can special case it
  assert(0 < incx);  // Do not cover the negative case
  assert(1 == incx); // Do not cover the negative case

  int n32;
  int i, j, k, p_i;

  double tmp;
  double        //
      a__i_k_0, //
      a__i_k_1, //
      a__i_k_2, //
      a__i_k_3, //
      a__i_k_4, //
      a__i_k_5, //
      a__i_k_6, //
      a__i_k_7, //

      a_pi_k_0, //
      a_pi_k_1, //
      a_pi_k_2, //
      a_pi_k_3, //
      a_pi_k_4, //
      a_pi_k_5, //
      a_pi_k_6, //
      a_pi_k_7  //
      ;

  n32 = (N / 32) * 32;

  if (0 < n32)
  {
    for (j = 0; j < n32; j += 32)
    {
      for (i = k1; i < k2; ++i)
      {
        p_i = ipiv[i];
        if (p_i != i)
        {
          for (k = j; k < j + 32 - 7; k += 8)
          {
            a__i_k_0 = TIX(A, LDA, i, k + 0);
            a__i_k_1 = TIX(A, LDA, i, k + 1);
            a__i_k_2 = TIX(A, LDA, i, k + 2);
            a__i_k_3 = TIX(A, LDA, i, k + 3);
            a__i_k_4 = TIX(A, LDA, i, k + 4);
            a__i_k_5 = TIX(A, LDA, i, k + 5);
            a__i_k_6 = TIX(A, LDA, i, k + 6);
            a__i_k_7 = TIX(A, LDA, i, k + 7);

            a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
            a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
            a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
            a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
            a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
            a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
            a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
            a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

            TIX(A, LDA, i, k + 0) = a_pi_k_0;
            TIX(A, LDA, i, k + 1) = a_pi_k_1;
            TIX(A, LDA, i, k + 2) = a_pi_k_2;
            TIX(A, LDA, i, k + 3) = a_pi_k_3;
            TIX(A, LDA, i, k + 4) = a_pi_k_4;
            TIX(A, LDA, i, k + 5) = a_pi_k_5;
            TIX(A, LDA, i, k + 6) = a_pi_k_6;
            TIX(A, LDA, i, k + 7) = a_pi_k_7;

            TIX(A, LDA, p_i, k + 0) = a__i_k_0;
            TIX(A, LDA, p_i, k + 1) = a__i_k_1;
            TIX(A, LDA, p_i, k + 2) = a__i_k_2;
            TIX(A, LDA, p_i, k + 3) = a__i_k_3;
            TIX(A, LDA, p_i, k + 4) = a__i_k_4;
            TIX(A, LDA, p_i, k + 5) = a__i_k_5;
            TIX(A, LDA, p_i, k + 6) = a__i_k_6;
            TIX(A, LDA, p_i, k + 7) = a__i_k_7;
          }
        }
      }
    }
  }

  // Leftover cases from blocking by 32
  if (n32 != N)
  {
    for (i = k1; i < k2; ++i)
    {
      p_i = ipiv[i];
      if (i != p_i)
      {
        for (k = n32; k < N - 7; k += 8)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a__i_k_1 = TIX(A, LDA, i, k + 1);
          a__i_k_2 = TIX(A, LDA, i, k + 2);
          a__i_k_3 = TIX(A, LDA, i, k + 3);
          a__i_k_4 = TIX(A, LDA, i, k + 4);
          a__i_k_5 = TIX(A, LDA, i, k + 5);
          a__i_k_6 = TIX(A, LDA, i, k + 6);
          a__i_k_7 = TIX(A, LDA, i, k + 7);

          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
          a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
          a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
          a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
          a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
          a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
          a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

          TIX(A, LDA, i, k + 0) = a_pi_k_0;
          TIX(A, LDA, i, k + 1) = a_pi_k_1;
          TIX(A, LDA, i, k + 2) = a_pi_k_2;
          TIX(A, LDA, i, k + 3) = a_pi_k_3;
          TIX(A, LDA, i, k + 4) = a_pi_k_4;
          TIX(A, LDA, i, k + 5) = a_pi_k_5;
          TIX(A, LDA, i, k + 6) = a_pi_k_6;
          TIX(A, LDA, i, k + 7) = a_pi_k_7;

          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, p_i, k + 1) = a__i_k_1;
          TIX(A, LDA, p_i, k + 2) = a__i_k_2;
          TIX(A, LDA, p_i, k + 3) = a__i_k_3;
          TIX(A, LDA, p_i, k + 4) = a__i_k_4;
          TIX(A, LDA, p_i, k + 5) = a__i_k_5;
          TIX(A, LDA, p_i, k + 6) = a__i_k_6;
          TIX(A, LDA, p_i, k + 7) = a__i_k_7;
        }

        for (; k < N; ++k)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, i, k + 0) = a_pi_k_0;
        }
      }
    }
  }
}

// -------------
// DGEMM helpers

#define B_SP(M, MB) ((M) & -(MB))
#define B_EQ(M, MB) ((M) == B_SP(M, MB))
#define for_bft(VAR, ST, DIM, B)                                               \
  for ((VAR) = (ST); (VAR) < B_SP(DIM, B); (VAR) += (B))
#define for_b(VAR, DIM, B) for_bft(VAR, 0, DIM, B)

// ----

#define INIT_8x4B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();                                               \
  c_i0_j2 = _mm256_setzero_pd();                                               \
  c_i0_j3 = _mm256_setzero_pd();                                               \
  c_i4_j0 = _mm256_setzero_pd();                                               \
  c_i4_j1 = _mm256_setzero_pd();                                               \
  c_i4_j2 = _mm256_setzero_pd();                                               \
  c_i4_j3 = _mm256_setzero_pd();

#define DO_8x4B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  a_i4_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 4));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i4_j0 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j0);                        \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j1);                        \
  c_i4_j1 = _mm256_fmadd_pd(a_i4_k0, b_k0_j1, c_i4_j1);                        \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 2));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 3));                                      \
  c_i0_j2 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j2);                        \
  c_i4_j2 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j2);                        \
  c_i0_j3 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j3);                        \
  c_i4_j3 = _mm256_fmadd_pd(a_i4_k0, b_k0_j1, c_i4_j3);                        \
  ++k, abuff += 8, bbuff += 4;

// clang-format off
#define STORE_8x4B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 0), _mm256_add_pd(c_i4_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 1), _mm256_add_pd(c_i4_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 2), _mm256_add_pd(c_i0_j2, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 2))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 2), _mm256_add_pd(c_i4_j2, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 2))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 3), _mm256_add_pd(c_i0_j3, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 3))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 3), _mm256_add_pd(c_i4_j3, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 3))));
// clang-format on

#define MICRO_8x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_8x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_8x4B;                                                                   \
    DO_8x4B;                                                                   \
    DO_8x4B;                                                                   \
    DO_8x4B;                                                                   \
  }                                                                            \
  for (; k < K;)                                                               \
  {                                                                            \
    DO_8x4B;                                                                   \
  }                                                                            \
  STORE_8x4B;

// ----

#define INIT_8x2B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i4_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();                                               \
  c_i4_j1 = _mm256_setzero_pd();

#define DO_8x2B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  a_i4_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 4));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i4_j0 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j0);                        \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j1);                        \
  c_i4_j1 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j1);                        \
  ++k, abuff += 8, bbuff += 2;

// clang-format off
#define STORE_8x2B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 0), _mm256_add_pd(c_i4_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 1), _mm256_add_pd(c_i4_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 1))));  \
// clang-format on

#define MICRO_8x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_8x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_8x2B;                                                                   \
    DO_8x2B;                                                                   \
    DO_8x2B;                                                                   \
    DO_8x2B;                                                                   \
  }                                                                            \
  for (; k < K;)                                                     \
  {                                                                            \
    DO_8x2B;                                                                   \
  }                                                                            \
  STORE_8x2B;

// ----

#define INIT_8x1B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i4_j0 = _mm256_setzero_pd();                                               \

#define DO_8x1B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  a_i4_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 4));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i4_j0 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j0);                        \
  ++k, abuff += 8, ++bbuff;

// clang-format off
#define STORE_8x1B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 0), _mm256_add_pd(c_i4_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 0))));
// clang-format on

#define MICRO_8x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_8x1B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_8x1B;                                                                   \
    DO_8x1B;                                                                   \
    DO_8x1B;                                                                   \
    DO_8x1B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_8x1B;                                                                   \
  }                                                                            \
  STORE_8x1B;

// ----

#define INIT_4x4B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();                                               \
  c_i0_j2 = _mm256_setzero_pd();                                               \
  c_i0_j3 = _mm256_setzero_pd();

#define DO_4x4B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
                                                                               \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j1);                        \
                                                                               \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 2));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 3));                                      \
  c_i0_j2 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j2);                        \
  c_i0_j3 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j3);                        \
  ++k, abuff += 4, bbuff += 4;

// clang-format off
#define STORE_4x4B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 2), _mm256_add_pd(c_i0_j2, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 2))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 3), _mm256_add_pd(c_i0_j3, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 3))));
// clang-format on

#define MICRO_4x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_4x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_4x4B;                                                                   \
    DO_4x4B;                                                                   \
    DO_4x4B;                                                                   \
    DO_4x4B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_4x4B;                                                                   \
  }                                                                            \
  STORE_4x4B;

// ----

#define INIT_4x2B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();

#define DO_4x2B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j1);                        \
  ++k, abuff += 4, bbuff += 2;

// clang-format off
#define STORE_4x2B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));
// clang-format on

#define MICRO_4x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_4x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_4x2B;                                                                   \
    DO_4x2B;                                                                   \
    DO_4x2B;                                                                   \
    DO_4x2B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_4x2B;                                                                   \
  }                                                                            \
  STORE_4x2B;

// ----

#define INIT_4x1B c_i0_j0 = _mm256_setzero_pd();

#define DO_4x1B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  ++k, abuff += 4, ++bbuff;

// clang-format off
#define STORE_4x1B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));
// clang-format on

#define MICRO_4x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_4x1B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_4x1B;                                                                   \
    DO_4x1B;                                                                   \
    DO_4x1B;                                                                   \
    DO_4x1B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_4x1B;                                                                   \
  }                                                                            \
  STORE_4x1B;

// ----

#define INIT_2x4B                                                              \
  dc_i0_j0 = _mm_setzero_pd();                                                 \
  dc_i0_j1 = _mm_setzero_pd();                                                 \
  dc_i0_j2 = _mm_setzero_pd();                                                 \
  dc_i0_j3 = _mm_setzero_pd();

#define DO_2x4B                                                                \
  da_i0_k0 = _mm_mul_pd(dvalpha, _mm_load_pd(abuff + 0));                      \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 0));                                        \
  db_k0_j1 = _mm_set1_pd(*(bbuff + 1));                                        \
  dc_i0_j0 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j0);                       \
  dc_i0_j1 = _mm_fmadd_pd(da_i0_k0, db_k0_j1, dc_i0_j1);                       \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 2));                                        \
  db_k0_j1 = _mm_set1_pd(*(bbuff + 3));                                        \
  dc_i0_j2 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j2);                       \
  dc_i0_j3 = _mm_fmadd_pd(da_i0_k0, db_k0_j1, dc_i0_j3);                       \
  ++k, abuff += 2, bbuff += 4;

// clang-format off
#define STORE_2x4B                                                                                            \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm_add_pd(dc_i0_j0, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm_add_pd(dc_i0_j1, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 2), _mm_add_pd(dc_i0_j2, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 2))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 3), _mm_add_pd(dc_i0_j3, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 3))));
// clang-format on

#define MICRO_2x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_2x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_2x4B;                                                                   \
    DO_2x4B;                                                                   \
    DO_2x4B;                                                                   \
    DO_2x4B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_2x4B;                                                                   \
  }                                                                            \
  STORE_2x4B;

// ----

#define INIT_2x2B                                                              \
  dc_i0_j0 = _mm_setzero_pd();                                                 \
  dc_i0_j1 = _mm_setzero_pd();

#define DO_2x2B                                                                \
  da_i0_k0 = _mm_mul_pd(dvalpha, _mm_load_pd(abuff + 0));                      \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 0));                                        \
  db_k0_j1 = _mm_set1_pd(*(bbuff + 1));                                        \
  dc_i0_j0 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j0);                       \
  dc_i0_j1 = _mm_fmadd_pd(da_i0_k0, db_k0_j1, dc_i0_j1);                       \
  ++k, abuff += 2, bbuff += 2;

// clang-format off
#define STORE_2x2B                                                                                            \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm_add_pd(dc_i0_j0, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm_add_pd(dc_i0_j1, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));
// clang-format on

#define MICRO_2x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_2x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_2x2B;                                                                   \
    DO_2x2B;                                                                   \
    DO_2x2B;                                                                   \
    DO_2x2B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_2x2B;                                                                   \
  }                                                                            \
  STORE_2x2B;

// ----

#define INIT_2x1B                                                              \
  dc_i0_j0 = _mm_setzero_pd();                                                 \
  dc_i0_j1 = _mm_setzero_pd();

#define DO_2x1B                                                                \
  da_i0_k0 = _mm_mul_pd(dvalpha, _mm_load_pd(abuff + 0));                      \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 0));                                        \
  dc_i0_j0 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j0);                       \
  ++k, abuff += 2, ++bbuff;

// clang-format off
#define STORE_2x1B                                                                                            \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm_add_pd(dc_i0_j0, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));
// clang-format on

#define MICRO_2x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_2x1B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_2x1B;                                                                   \
    DO_2x1B;                                                                   \
    DO_2x1B;                                                                   \
    DO_2x1B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_2x1B;                                                                   \
  }                                                                            \
  STORE_2x1B;

// -----

#define INIT_1x4B s_c0 = s_c1 = s_c2 = s_c3 = 0.;

#define DO_1x4B                                                                \
  s_a0 = *abuff;                                                               \
  s_b0 = *(bbuff + 0);                                                         \
  s_b1 = *(bbuff + 1);                                                         \
  s_c0 -= s_a0 * s_b0;                                                         \
  s_c1 -= s_a0 * s_b1;                                                         \
  s_b0 = *(bbuff + 2);                                                         \
  s_b1 = *(bbuff + 3);                                                         \
  s_c2 -= s_a0 * s_b0;                                                         \
  s_c3 -= s_a0 * s_b1;                                                         \
  ++k, ++abuff, bbuff += 4;

#define STORE_1x4B                                                             \
  TIX(C, LDC, i + 0, j + 0) += s_c0;                                           \
  TIX(C, LDC, i + 0, j + 1) += s_c1;                                           \
  TIX(C, LDC, i + 0, j + 2) += s_c2;                                           \
  TIX(C, LDC, i + 0, j + 3) += s_c3;

#define MICRO_1x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_1x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_1x4B;                                                                   \
    DO_1x4B;                                                                   \
    DO_1x4B;                                                                   \
    DO_1x4B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_1x4B;                                                                   \
  }                                                                            \
  STORE_1x4B;

// -----

#define INIT_1x2B s_c0 = s_c1 = 0.;

#define DO_1x2B                                                                \
  s_a0 = *abuff;                                                               \
  s_b0 = *(bbuff + 0);                                                         \
  s_b1 = *(bbuff + 1);                                                         \
  s_c0 -= s_a0 * s_b0;                                                         \
  s_c1 -= s_a0 * s_b1;                                                         \
  ++k, ++abuff, bbuff += 2;

#define STORE_1x2B                                                             \
  TIX(C, LDC, i + 0, j + 0) += s_c0;                                           \
  TIX(C, LDC, i + 0, j + 1) += s_c1;

#define MICRO_1x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_1x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_1x2B;                                                                   \
    DO_1x2B;                                                                   \
    DO_1x2B;                                                                   \
    DO_1x2B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_1x2B;                                                                   \
  }                                                                            \
  STORE_1x2B;

// -----

#define INIT_1x1B s_c0 = 0.;

#define DO_1x1B                                                                \
  s_a0 = *abuff;                                                               \
  s_b0 = *(bbuff + 0);                                                         \
  s_c0 -= s_a0 * s_b0;                                                         \
  ++k, ++abuff, ++bbuff;

#define STORE_1x1B TIX(C, LDC, i + 0, j + 0) += s_c0;

#define MICRO_1x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_1x1B;                                                                   \
  for (k = 0; 0 && k < K4_MOD;)                                                \
  {                                                                            \
    DO_1x1B;                                                                   \
    DO_1x1B;                                                                   \
    DO_1x1B;                                                                   \
    DO_1x1B;                                                                   \
  }                                                                            \
  for (; k < K;)                                                               \
  {                                                                            \
    DO_1x1B;                                                                   \
  }                                                                            \
  STORE_1x1B;

// -----

// NOTE sgemm_5 assumes a TRANSPOSED memory layout
static void sgemm_5_mini(const int M, const int N, const int K,
                         double *restrict A, const int LDA, double *restrict B,
                         const int LDB, double *restrict C, const int LDC)
{
  int i, j, k;

  double *abuff, *bbuff;

  const int                  //
      M24_MOD = B_SP(M, 24), //
      M8_MOD = B_SP(M, 8),   //
      M4_MOD = B_SP(M, 4),   //
      M2_MOD = B_SP(M, 2),   //

      N4_MOD = B_SP(N, 4), //
      N2_MOD = B_SP(N, 2), //

      K4_MOD = B_SP(K, 4) //
      ;

  __m256d valpha = _mm256_set1_pd(-ONE); // broadcast alpha to a 256-bit vector
  __m128d dvalpha = _mm_set1_pd(-ONE);   // broadcast alpha to a 128-bit vector

  __m128d       //
      da_i0_k0, //
      da_i4_k0, //

      db_k0_j0, //
      db_k0_j1, //
      db_k0_j2, //
      db_k0_j3, //

      dc_i0_j0, //
      dc_i0_j1, //
      dc_i0_j2, //
      dc_i0_j3, //

      dc_i4_j0, //
      dc_i4_j1, //
      dc_i4_j2, //
      dc_i4_j3  //
      ;

  __m256d       //
      a_i0_k0,  //
      a_i4_k0,  //
      a_i8_k0,  //
      a_i12_k0, //
      a_i16_k0, //
      a_i20_k0, //

      b_k0_j0, //
      b_k0_j1, //

      c_i0_j0, //
      c_i0_j1, //
      c_i0_j2, //
      c_i0_j3, //

      c_i4_j0, //
      c_i4_j1, //
      c_i4_j2, //
      c_i4_j3  //

      ;

  double    //
      s_a0, //

      s_b0, //
      s_b1, //
      s_b2, //
      s_b3, //

      s_c0, //
      s_c1, //
      s_c2, //
      s_c3  //
      ;

  i = j = 0;

  for (; j < N4_MOD; j += 4)
  {
    for (i = 0; i < M8_MOD; i += 8)
    {
      MICRO_8x4_MMM;
    }
    for (; i < M4_MOD; i += 4)
    {
      MICRO_4x4_MMM;
    }
    for (; i < M2_MOD; i += 2)
    {
      MICRO_2x4_MMM;
    }
    for (; i < M; ++i)
    {
      MICRO_1x4_MMM;
    }
  }

  for (; j < N2_MOD; j += 2)
  {
    for (i = 0; i < M8_MOD; i += 8)
    {
      MICRO_8x2_MMM;
    }
    for (; i < M4_MOD; i += 4)
    {
      MICRO_4x2_MMM;
    }
    for (; i < M2_MOD; i += 2)
    {
      MICRO_2x2_MMM;
    }
    for (; i < M; ++i)
    {
      MICRO_1x2_MMM;
    }
  }

  for (; j < N; ++j)
  {
    for (i = 0; i < M8_MOD; i += 8)
    {
      MICRO_8x1_MMM;
    }
    for (; i < M4_MOD; i += 4)
    {
      MICRO_4x1_MMM;
    }
    for (; i < M2_MOD; i += 2)
    {
      MICRO_2x1_MMM;
    }
    for (; i < M; ++i)
    {
      MICRO_1x1_MMM;
    }
  }
}

static void pack_a(double *dst, double *src, int LDA, int M, int N)
{
  int i, j;
  double *s0, *d0 = dst;
  i = 0;

  __m256d psrc0, psrc4;

  for (; i < M - 7; i += 8)
  {
    s0 = src + i;
    for (j = 0; j < N; ++j, dst += 8, s0 += LDA)
    {
      psrc0 = _mm256_loadu_pd(s0 + 0);
      psrc4 = _mm256_loadu_pd(s0 + 4);
      _mm256_storeu_pd(dst + 0, psrc0);
      _mm256_storeu_pd(dst + 4, psrc4);
    }
  }

  for (; i < M - 3; i += 4)
  {
    s0 = src + i;
    for (j = 0; j < N; ++j, dst += 4, s0 += LDA)
    {
      psrc0 = _mm256_loadu_pd(s0 + 0);
      _mm256_storeu_pd(dst + 0, psrc0);
    }
  }

  for (; i < M - 1; i += 2)
  {
    // NOTE you could do this with an SSE instruction
    s0 = src + i;
    for (j = 0; j < N; ++j, dst += 2, s0 += LDA)
    {
      *dst = *s0;
      *(dst + 1) = *(s0 + 1);
    }
  }

  for (; i < M; ++i)
  {
    s0 = src + i;
    for (j = 0; j < N; ++j, s0 += LDA, dst++)
      *dst = *s0;
  }
}

static void pack_b(double *dst, double *src, int LDA, int M, int N)
{
  int i, j;
  double   //
      *s0, //
      *s1, //
      *s2, //
      *s3, //
      *s4, //
      *s5, //
      *s6, //
      *s7  //
      ;

  j = 0;

  for (; j < N - 3; j += 4)
  {
    s0 = src + j * LDA;
    s1 = s0 + LDA;
    s2 = s1 + LDA;
    s3 = s2 + LDA;
    for (i = 0; i < M; ++i)
    {
      *dst++ = *s0++;
      *dst++ = *s1++;
      *dst++ = *s2++;
      *dst++ = *s3++;
    }
  }

  for (; j < N - 1; j += 2)
  {
    s0 = src + j * LDA;
    s1 = s0 + LDA;
    for (i = 0; i < M; ++i)
    {
      *dst++ = *s0++;
      *dst++ = *s1++;
    }
  }

  for (; j < N; ++j)
  {
    s0 = src + j * LDA;
    for (i = 0; i < M; ++i, dst++, s0++)
    {
      *dst = *s0;
    }
  }
}

void sgemm_5(int M, int N, int K, double alpha, double *restrict A, int LDA,
             double *restrict B, int LDB, double beta, double *restrict C,
             int LDC)
{
  double *AL = scratch_a;
  double *BL = scratch_b;

  // Deltas for blocking
  int i, j, k, //
      d_i, d_j, d_k;

  // A[M, K] B[K, N] C[M, N]
  for (j = 0; j < N; j += d_j)
  {
    d_j = MIN(N - j, N_BLOCK);
    for (k = 0; k < K; k += d_k)
    {
      d_k = MIN(K - k, K_BLOCK);
      pack_b(BL, &TIX(B, LDB, k, j), LDB, d_k, d_j);
      for (i = 0; i < M; i += d_i)
      {
        d_i = MIN(M - i, M_BLOCK);
        pack_a(AL, &TIX(A, LDA, i, k), LDA, d_i, d_k);
        sgemm_5_mini(d_i, d_j, d_k, //
                     AL, -10E5,     // NOTE these shouldn't be used
                     BL, -10E5,     //
                     &TIX(C, LDC, i, j), LDC);
      }
    }
  }
}

// A is a lower / left / unit / *transposed* matrix
static void strsm_L_5(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = 0; k < M; ++k)
      for (i = k + 1; i < M; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
}

// A is a upper / left / non-unit / *transposed* matrix
static void strsm_U_5(int M, int N, double *A, int LDA, double *B, int LDB)
{
  // TODO
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = M - 1; k >= 0; --k)
    {
      TIX(B, LDB, k, j) = TIX(B, LDB, k, j) / TIX(A, LDA, k, k);
      for (i = 0; i < k; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
    }
}

static int sgetrs_5(int N, double *A, int *ipiv, double *b)
{
  // A now contains L (below diagonal)
  //                U (above diagonal)
  // Swap pivot rows in b
  slaswp_5(1, b, 1, 0, N, ipiv, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Swapped\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Forward substitution
  strsm_L_5(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Forward\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Backward substitution
  strsm_U_5(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Solved\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  return 0;
}

int sgetf2_5(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j, k, p_i;

  double   //
      p_v, //
      m_0  //
      ;

  double      //
      A_j0_i, //
      A_j1_i, //
      A_j2_i, //
      A_j3_i, //
      A_j4_i, //
      A_j5_i, //
      A_j6_i, //
      A_j7_i, //

      A_j_k0, //
      A_j_k1, //
      A_j_k2, //
      A_j_k3, //
      A_j_k4, //
      A_j_k5, //
      A_j_k6, //
      A_j_k7, //

      A_i_k0, //
      A_i_k1, //
      A_i_k2, //
      A_i_k3, //
      A_i_k4, //
      A_i_k5, //
      A_i_k6, //
      A_i_k7  //
      ;

  // Quick return
  if (!M || !N)
    return 0;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {

    p_i = i + isamax_2(M - i, &TIX(A, LDA, i, i), 1);
    p_v = TIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      fprintf(stderr, "LU Solving failed with A[%d x %d]", M, N);
#ifdef DEBUG_LU_SOLVER
#endif
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
#ifdef DEBUG_LU_SOLVER
      printf("Switching rows: %d %d\n", i, p_i);
#endif
      sswap_2(N, &TIX(A, LDA, i, 0), LDA, &TIX(A, LDA, p_i, 0), LDA);
    }

    m_0 = 1 / TIX(A, LDA, i, i);

    // BLAS 1 Scale vector ---
    for (j = i + 1; j <= M - 8; j += 8)
    {

      A_j0_i = TIX(A, LDA, j + 0, i);
      A_j1_i = TIX(A, LDA, j + 1, i);
      A_j2_i = TIX(A, LDA, j + 2, i);
      A_j3_i = TIX(A, LDA, j + 3, i);
      A_j4_i = TIX(A, LDA, j + 4, i);
      A_j5_i = TIX(A, LDA, j + 5, i);
      A_j6_i = TIX(A, LDA, j + 6, i);
      A_j7_i = TIX(A, LDA, j + 7, i);

      TIX(A, LDA, j + 0, i) = m_0 * A_j0_i;
      TIX(A, LDA, j + 1, i) = m_0 * A_j1_i;
      TIX(A, LDA, j + 2, i) = m_0 * A_j2_i;
      TIX(A, LDA, j + 3, i) = m_0 * A_j3_i;
      TIX(A, LDA, j + 4, i) = m_0 * A_j4_i;
      TIX(A, LDA, j + 5, i) = m_0 * A_j5_i;
      TIX(A, LDA, j + 6, i) = m_0 * A_j6_i;
      TIX(A, LDA, j + 7, i) = m_0 * A_j7_i;
    }
    for (; j <= M - 4; j += 4)
    {

      A_j0_i = TIX(A, LDA, j + 0, i);
      A_j1_i = TIX(A, LDA, j + 1, i);
      A_j2_i = TIX(A, LDA, j + 2, i);
      A_j3_i = TIX(A, LDA, j + 3, i);

      TIX(A, LDA, j + 0, i) = m_0 * A_j0_i;
      TIX(A, LDA, j + 1, i) = m_0 * A_j1_i;
      TIX(A, LDA, j + 2, i) = m_0 * A_j2_i;
      TIX(A, LDA, j + 3, i) = m_0 * A_j3_i;
    }
    for (; j < M; ++j)
    {
      TIX(A, LDA, j, i) = m_0 * TIX(A, LDA, j, i);
    }
    // --- BLAS 1 Scale Vector

    if (i < MIN(M, N))
    {

      // BLAS 2 Rank 1 update ---
      for (j = i + 1; j < M; ++j)
      {
        // Negate to make computations look like FMA :)
        m_0 = -TIX(A, LDA, j, i);
        for (k = i + 1; k < N; ++k)
        {
          A_j_k0 = TIX(A, LDA, j, k + 0);
          A_i_k0 = TIX(A, LDA, i, k + 0);
          TIX(A, LDA, j, k + 0) = m_0 * A_i_k0 + A_j_k0;
        }
      }
      // --- BLAS 2 Rank 1 update
      //
    }
  }

  return 0;
}

/**
 * Same al lu_solve_2 except it uses the new sgemm_5
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
    retcode = sgetf2_5(M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }

  // BLocked factor A into [L \ U]
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = sgetf2_5(M - ib, IB, &TIX(A, LDA, ib, ib), LDA, ipiv + ib);

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
      slaswp_5(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        slaswp_5(N - ib - IB, &TIX(A, LDA, 0, ib + IB), LDA, ib, ib + IB, ipiv,
                 1);

        // Compute the block row of U
        strsm_L_5(IB, N - ib - IB, &TIX(A, LDA, ib, ib), LDA,
                  &TIX(A, LDA, ib, ib + IB), LDA);

        // Update trailing submatrix
        sgemm_5(M - ib - IB, N - ib - IB, IB, -ONE, //
                &TIX(A, LDA, ib + IB, ib), LDA,     //
                &TIX(A, LDA, ib, ib + IB), LDA,     //
                ONE,                                //
                &TIX(A, LDA, ib + IB, ib + IB), LDA //
        );
      }
    }
  }

#if DEBUG_LU_SOLVER
  for (int i = 0; i < N; ++i)
  {
    for (int j = 0; j < N; ++j)
      printf("%.4f  ", TIX(A, N, i, j));
    printf("\n");
  }
  printf("\n");
#endif

  // Solve the system with A
  retcode = sgetrs_5(N, A, ipiv, b);

  return retcode;
}

/* -------------------------------------------------------------------
 * Transposed memory layout operations
 *
 */
static void sswap_6(int N, double *X, int incx, double *Y, int incy)
{
  // TODO special case when incx == incy == 1
  // ^^^ This is our case actually (row-major iteration).

  assert(0 < N);
  assert(0 < incx);
  assert(0 < incy);

  double  //
      t_0 //
      ;

  __m256d  //
      x_0, //
      x_4,

      y_0, //
      y_4;

  int i, ix, iy;

  if (incx == 1 && incy == 1)
  {
    for (i = 0; i < N - 7; i += 8)
    {
      x_0 = _mm256_loadu_pd(X + i + 0);
      y_0 = _mm256_loadu_pd(Y + i + 0);
      _mm256_storeu_pd(X + i + 0, y_0);
      _mm256_storeu_pd(Y + i + 0, x_0);

      x_4 = _mm256_loadu_pd(X + i + 4);
      y_4 = _mm256_loadu_pd(Y + i + 4);
      _mm256_storeu_pd(X + i + 4, y_4);
      _mm256_storeu_pd(Y + i + 4, x_4);
    }

    for (; i < N; ++i)
    {
      t_0 = X[i + 0];
      X[i + 0] = Y[i + 0];
      Y[i + 0] = t_0;
    }
  }
  else
  {
    for (i = 0, ix = 0, iy = 0; i < N; ++i, ix += incx, iy += incy)
    {
      t_0 = X[ix];
      X[ix] = Y[iy];
      Y[iy] = t_0;
    }
  }
}

static void slaswp_6(int N, double *A, int LDA, int k1, int k2, int *ipiv,
                     int incx)
{
  // NOTE ipiv is layed out sequentially in memory so we can special case it
  assert(0 < incx);  // Do not cover the negative case
  assert(1 == incx); // Do not cover the negative case

  int n32;
  int i, j, k, p_i;

  double tmp;
  double        //
      a__i_k_0, //
      a__i_k_1, //
      a__i_k_2, //
      a__i_k_3, //
      a__i_k_4, //
      a__i_k_5, //
      a__i_k_6, //
      a__i_k_7, //

      a_pi_k_0, //
      a_pi_k_1, //
      a_pi_k_2, //
      a_pi_k_3, //
      a_pi_k_4, //
      a_pi_k_5, //
      a_pi_k_6, //
      a_pi_k_7  //
      ;

  n32 = (N / 32) * 32;

  if (0 < n32)
  {
    for (j = 0; j < n32; j += 32)
    {
      for (i = k1; i < k2; ++i)
      {
        p_i = ipiv[i];
        if (p_i != i)
        {
          for (k = j; k < j + 32 - 7; k += 8)
          {
            a__i_k_0 = TIX(A, LDA, i, k + 0);
            a__i_k_1 = TIX(A, LDA, i, k + 1);
            a__i_k_2 = TIX(A, LDA, i, k + 2);
            a__i_k_3 = TIX(A, LDA, i, k + 3);
            a__i_k_4 = TIX(A, LDA, i, k + 4);
            a__i_k_5 = TIX(A, LDA, i, k + 5);
            a__i_k_6 = TIX(A, LDA, i, k + 6);
            a__i_k_7 = TIX(A, LDA, i, k + 7);

            a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
            a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
            a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
            a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
            a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
            a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
            a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
            a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

            TIX(A, LDA, i, k + 0) = a_pi_k_0;
            TIX(A, LDA, i, k + 1) = a_pi_k_1;
            TIX(A, LDA, i, k + 2) = a_pi_k_2;
            TIX(A, LDA, i, k + 3) = a_pi_k_3;
            TIX(A, LDA, i, k + 4) = a_pi_k_4;
            TIX(A, LDA, i, k + 5) = a_pi_k_5;
            TIX(A, LDA, i, k + 6) = a_pi_k_6;
            TIX(A, LDA, i, k + 7) = a_pi_k_7;

            TIX(A, LDA, p_i, k + 0) = a__i_k_0;
            TIX(A, LDA, p_i, k + 1) = a__i_k_1;
            TIX(A, LDA, p_i, k + 2) = a__i_k_2;
            TIX(A, LDA, p_i, k + 3) = a__i_k_3;
            TIX(A, LDA, p_i, k + 4) = a__i_k_4;
            TIX(A, LDA, p_i, k + 5) = a__i_k_5;
            TIX(A, LDA, p_i, k + 6) = a__i_k_6;
            TIX(A, LDA, p_i, k + 7) = a__i_k_7;
          }
        }
      }
    }
  }

  // Leftover cases from blocking by 32
  if (n32 != N)
  {
    for (i = k1; i < k2; ++i)
    {
      p_i = ipiv[i];
      if (i != p_i)
      {
        for (k = n32; k < N - 7; k += 8)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a__i_k_1 = TIX(A, LDA, i, k + 1);
          a__i_k_2 = TIX(A, LDA, i, k + 2);
          a__i_k_3 = TIX(A, LDA, i, k + 3);
          a__i_k_4 = TIX(A, LDA, i, k + 4);
          a__i_k_5 = TIX(A, LDA, i, k + 5);
          a__i_k_6 = TIX(A, LDA, i, k + 6);
          a__i_k_7 = TIX(A, LDA, i, k + 7);

          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
          a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
          a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
          a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
          a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
          a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
          a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

          TIX(A, LDA, i, k + 0) = a_pi_k_0;
          TIX(A, LDA, i, k + 1) = a_pi_k_1;
          TIX(A, LDA, i, k + 2) = a_pi_k_2;
          TIX(A, LDA, i, k + 3) = a_pi_k_3;
          TIX(A, LDA, i, k + 4) = a_pi_k_4;
          TIX(A, LDA, i, k + 5) = a_pi_k_5;
          TIX(A, LDA, i, k + 6) = a_pi_k_6;
          TIX(A, LDA, i, k + 7) = a_pi_k_7;

          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, p_i, k + 1) = a__i_k_1;
          TIX(A, LDA, p_i, k + 2) = a__i_k_2;
          TIX(A, LDA, p_i, k + 3) = a__i_k_3;
          TIX(A, LDA, p_i, k + 4) = a__i_k_4;
          TIX(A, LDA, p_i, k + 5) = a__i_k_5;
          TIX(A, LDA, p_i, k + 6) = a__i_k_6;
          TIX(A, LDA, p_i, k + 7) = a__i_k_7;
        }

        for (; k < N; ++k)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, i, k + 0) = a_pi_k_0;
        }
      }
    }
  }
}

// A is a lower / left / unit / *transposed* matrix
static void strsm_L_6(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = 0; k < M; ++k)
      for (i = k + 1; i < M; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
}

// A is a upper / left / non-unit / *transposed* matrix
static void strsm_U_6(int M, int N, double *A, int LDA, double *B, int LDB)
{
  // TODO
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = M - 1; k >= 0; --k)
    {
      TIX(B, LDB, k, j) = TIX(B, LDB, k, j) / TIX(A, LDA, k, k);
      for (i = 0; i < k; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
    }
}

static int sgetrs_6(int N, double *A, int *ipiv, double *b)
{
  // A now contains L (below diagonal)
  //                U (above diagonal)
  // Swap pivot rows in b
  slaswp_6(1, b, 1, 0, N, ipiv, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Swapped\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Forward substitution
  strsm_L_6(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Forward\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Backward substitution
  strsm_U_6(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Solved\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  return 0;
}

int sgetf2_6(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j, k, p_i;

  double   //
      p_v, //
      m_0  //
      ;

  double      //
      A_j_k0, //
      A_j_k1, //
      A_j_k2, //
      A_j_k3, //
      A_j_k4, //
      A_j_k5, //
      A_j_k6, //
      A_j_k7, //

      A_i_k0, //
      A_i_k1, //
      A_i_k2, //
      A_i_k3, //
      A_i_k4, //
      A_i_k5, //
      A_i_k6, //
      A_i_k7  //
      ;

  __m256d     //
      pm_0,   //
      A_j0_i, //
      A_j4_i  //
      ;

  // Quick return
  if (!M || !N)
    return 0;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {

    p_i = i + isamax_2(M - i, &TIX(A, LDA, i, i), 1);
    p_v = TIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      fprintf(stderr, "LU Solving failed with A[%d x %d]", M, N);
#ifdef DEBUG_LU_SOLVER
#endif
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
#ifdef DEBUG_LU_SOLVER
      printf("Switching rows: %d %d\n", i, p_i);
#endif
      sswap_6(N, &TIX(A, LDA, i, 0), LDA, &TIX(A, LDA, p_i, 0), LDA);
    }

    // BLAS 1 Scale vector ---
    m_0 = 1 / TIX(A, LDA, i, i);
    pm_0 = _mm256_set1_pd(m_0); // XXX sequence of instructions
    for (j = i + 1; j <= M - 8; j += 8)
    {
      A_j0_i = _mm256_loadu_pd(&TIX(A, LDA, j + 0, i));
      _mm256_storeu_pd(&TIX(A, LDA, j + 0, i), _mm256_mul_pd(pm_0, A_j0_i));
      A_j0_i = _mm256_loadu_pd(&TIX(A, LDA, j + 4, i));
      _mm256_storeu_pd(&TIX(A, LDA, j + 4, i), _mm256_mul_pd(pm_0, A_j0_i));
    }
    for (; j <= M - 4; j += 4)
    {
      A_j0_i = _mm256_loadu_pd(&TIX(A, LDA, j + 0, i));
      _mm256_storeu_pd(&TIX(A, LDA, j + 0, i), _mm256_mul_pd(pm_0, A_j0_i));
    }
    for (; j < M; ++j)
    {
      TIX(A, LDA, j, i) = m_0 * TIX(A, LDA, j, i);
    }
    // --- BLAS 1 Scale Vector

    if (i < MIN(M, N))
    {

      // BLAS 2 Rank 1 update ---
      for (k = i + 1; k < N; ++k)
      {
        // XXX flip the loop order to get better locaility
        for (j = i + 1; j < M; ++j)
        {
          // Negate to make computations look like FMA :)
          m_0 = -TIX(A, LDA, j, i);
          A_j_k0 = TIX(A, LDA, j, k + 0);
          A_i_k0 = TIX(A, LDA, i, k + 0);
          TIX(A, LDA, j, k + 0) = m_0 * A_i_k0 + A_j_k0;
        }
      }
      // --- BLAS 2 Rank 1 update
      //
    }
  }

  return 0;
}

/**
 * Same al lu_solve_2 except it uses the new sgemm_5
 * and a transposed memory layout.
 */
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
    retcode = sgetf2_6(M, N, A, LDA, ipiv);
    if (retcode != 0)
      return retcode;
  }

  // BLocked factor A into [L \ U]
  else
  {
    for (ib = 0; ib < MIN_MN; ib += NB)
    {
      IB = MIN(MIN_MN - ib, NB);

      retcode = sgetf2_6(M - ib, IB, &TIX(A, LDA, ib, ib), LDA, ipiv + ib);

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
      slaswp_6(ib, A, LDA, ib, ib + IB, ipiv, 1);

      if (ib + IB < N)
      {
        // Apply interchanges to columns ib + IB : N
        slaswp_6(N - ib - IB, &TIX(A, LDA, 0, ib + IB), LDA, ib, ib + IB, ipiv,
                 1);

        // Compute the block row of U
        strsm_L_6(IB, N - ib - IB, &TIX(A, LDA, ib, ib), LDA,
                  &TIX(A, LDA, ib, ib + IB), LDA);

        // Update trailing submatrix
        sgemm_5(M - ib - IB, N - ib - IB, IB, -1.,  //
                &TIX(A, LDA, ib + IB, ib), LDA,     //
                &TIX(A, LDA, ib, ib + IB), LDA,     //
                1.,                                 //
                &TIX(A, LDA, ib + IB, ib + IB), LDA //
        );
      }
    }
  }

#if DEBUG_LU_SOLVER
  for (int i = 0; i < N; ++i)
  {
    for (int j = 0; j < N; ++j)
      printf("%.4f  ", TIX(A, N, i, j));
    printf("\n");
  }
  printf("\n");
#endif

  // Solve the system with A
  retcode = sgetrs_6(N, A, ipiv, b);

  return retcode;
}

#ifdef TEST_PERF

void register_functions_LU_SOLVE()
{
  // add_function_LU_SOLVE(&lu_solve_0, "LU Solve Base", 1);
  // add_function_LU_SOLVE(&lu_solve_1, "LU Solve Recursive", 1);
  add_function_LU_SOLVE(&lu_solve_2, "LU_Solve_Basic_C_Opts", 1);
#ifdef TEST_MKL
  add_function_LU_SOLVE(&lu_solve_3, "LU_Solve_Intel_DGEMM", 1);
  add_function_LU_SOLVE(&lu_solve_4, "LU_Solve_Intel_DGESV_Row_Major", 1);
#endif
  add_function_LU_SOLVE(&lu_solve_5, "LU_Solve_Transposed", 1);
  add_function_LU_SOLVE(&lu_solve_6, "LU_Solve_Transposed_Vector", 1);
}

void register_functions_MMM()
{
  add_function_MMM(&sgemm_1, "MMM Base", 1);
  add_function_MMM(&sgemm_2, "MMM_C_opts", 1);
  add_function_MMM(&sgemm_5, "MMM_Copts_Vector", 1);
#ifdef TEST_MKL
  add_function_MMM(&sgemm_intel, "MMM_Intel", 1);
#endif
}

#endif
