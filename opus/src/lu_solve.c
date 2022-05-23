#include "lu_solve.h"

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "helpers.h"
#include "perf_testers/perf_lu_solve.h"

// XXX Assume 'A' is an NxN defined in scope
#define AIX(ROW, COL) (A)[(N) * (ROW) + (COL)]
#define IX(ROW, COL) ((N) * (ROW) + (COL))
// NOTE When working with a matrix inset in another, you must
// index into using this macro. Explicitely specifying the
// leading dimension which *must* be available.
#define MIX(A, LDA, ROW, COL) (A)[((LDA) * (ROW) + (COL))]

#define ONE 1.E0
#define ERR_THRESHOLD 1.0E-6 // FIXME is this small / big enough

#define APPROX_EQUAL(l, r) (fabs((l) - (r)) <= ERR_THRESHOLD)
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

int lu_solve_0(int N, double *A, int *ipiv, double *b);
int lu_solve_1(int N, double *A, int *ipiv, double *b);

/** @brief Entry function to solve system A * x = b
 *         After exit b is overwritten with solution vector x.
 *
 * @param N Number of columns and rows of A.
 * @param A Real valued NxN matrix A.
 * @param ipiv Buffer for internal usage when pivoting.
 * @param b Real valued Nx1 vector b.
 */
int lu_solve(int N, double *A, int *ipiv, double *b)
{
  return lu_solve_1(N, A, ipiv, b);
}

// -----------------
// Utilities

static void swapd(double *a, int i, int j)
{
  double t = a[i];
  a[i] = a[j];
  a[j] = t;
}

// -----------------
// LAPACK routines
//
// NOTE these functions have no declaration. However, a
// corresponding <lapack>_XXX  definition is made for each
// iteration. This way performance testing is consistent.
// Forward declaration are here merely to have useful doc
// comments in one place.

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
 *         with a *Non-unit* diagonal. It is still assumed to be non-transposed.
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

// NOTE All functions preceded by a _ are internal and unexposed by the API.
// They are prefixed because they often have the same name with a different
// signature than those exposed.

/** ------------------------------------------------------------------
 * Base implementation
 */
int lu_solve_0(int N, double *A, int *ipiv, double *b)
{

  int i, j, k;

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

  int ix, ix0, i1, i2, inc, n32;
  int i, j, k, p_i;
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
  double tmp;

  for (j = 0; j < N; ++j)
  {
    // BETA = 1
    for (k = 0; k < K; ++k)
    {
      tmp = alpha * MIX(B, LDB, k, j);
      for (i = 0; i < M; ++i)
      {
        MIX(C, LDC, i, j) = MIX(C, LDC, i, j) + tmp * MIX(A, LDA, i, k);
      }
    }
  }
}

int sgetf2_1(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j, k;

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

int lu_solve_1(int N, double *A, int *ipiv, double *b)
{
  /**
   * FIXME for simplicity we will choose a block size of 32.
   * In the real system we can choose a dynamic block (better), or we can
   * always choose a fixed block and handle clean-up cases afterward (worse).
   */

  int NB = 32, retcode;

  int M = N;   // Square matrix
  int LDA = N; // N is the leading dimension

  int ib, IB, i, j, k;

  // BLocked factor A into [L \ U]

  if (N < NB)
  {
    // Use unblocked code
    retcode = sgetf2_1(M, N, A, LDA, ipiv);

#if DEBUG_LU_SOLVER
    printf("IPIV: ");
    for (i = 0; i < N; ++i)
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

// -----------------
// Internal functions

// BLAS 2 GEPP for submatrix

// BLAS 3 MMM for submatrices

#ifdef TEST_PERF

// NOTE I bet we can put these in the templated perf framework and remove the
// weirdness of compiling seperately and linking.
void register_functions_LU_SOLVE()
{
  add_function_LU_SOLVE(&lu_solve_0, "LU Solve Base", 1);
  add_function_LU_SOLVE(&lu_solve_1, "LU Solve Recursive", 1);
}

#endif
