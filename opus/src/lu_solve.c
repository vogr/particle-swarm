#include "lu_solve.h"

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "helpers.h"
#include "perf_testers/perf_lu_solve.h"

#define DEBUG_LU 0

// TODO XXX change the signature to accept an additional (int *ipiv)

// XXX Assume 'A' is an NxN defined in scope
#define AIX(ROW, COL) (A)[(N) * (ROW) + (COL)]
#define IX(ROW, COL) ((N) * (ROW) + (COL))
#define ONE 1.E0
#define ERR_THRESHOLD 1.0E-6 // TODO is this small / big enough
#define APPROX_EQUAL(l, r) (fabs((l) - (r)) <= ERR_THRESHOLD)

//

#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

int lu_solve_0(int N, double *A, int *ipiv, double *b, double *x);
int lu_solve_1(int N, double *A, int *ipiv, double *b, double *x);

// -----------------
// Utilities

static void swapi(int *a, int i, int j)
{
  int t = a[i];
  a[i] = a[j];
  a[j] = t;
}

static void swapd(double *a, int i, int j)
{
  double t = a[i];
  a[i] = a[j];
  a[j] = t;
}

/**
 * Entry
 */
int lu_solve(int N, double *A, int *ipiv, double *b, double *x)
{
  return lu_solve_1(N, A, ipiv, b, x);
}

// NOTE All functions preceded by a _ are internal and unexposed by the API.
// They are prefixed because they often have the same name with a different
// signature than those exposed.

/** ------------------------------------------------------------------
 * Base implementation
 */
int lu_solve_0(int N, double *A, int *ipiv, double *b, double *x)
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
  // NOTE this can be done in place
  for (i = 0; i < N; ++i)
  {
    double v = b[i];
    for (j = 0; j < i; ++j)
    {
      v -= AIX(i, j) * b[j];
    }
    b[i] = v; /* / AIX(i, i); */ // XXX The diagonal for L is of unit value
  }

  // Backward substitution
  // Stored in 'x'
  for (int i = N - 1; i >= 0; --i)
  {
    double v = b[i];
    for (int j = i + 1; j < N; ++j)
    {
      v -= AIX(i, j) * x[j];
    }

    x[i] = v / AIX(i, i);
  }

  return 0;
}

// -----------------
// LAPACK routines

/**
 * @param N Number of elements in A.
 * @param A Real valued vector.
 * @param stride Space between elements
 * @return Index of the first element with the maximum absolute value.
 */
static int isamax(int N, double *A, int stride)
{
  assert(0 < N);
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

/**
 * @param N The number of elements in vectors X and Y to swap.
 * @param X The first vector of real valued elements to swap.
 * @param incx The storage stride between elements in X.
 * @param Y The second vector of real valued elements to swap.
 * @param incy The storage stride between elements in Y.
 */
static void sswap(int N, double *X, int incx, double *Y, int incy)
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

/**
 * @param ROW Is the row offset into an MxN matrix which is contained within an
 *            M0xN0 matrix.
 * @param COL Is the col offset into an MxN matrix which is contained within an
 *            M0xN0 matrix.
 *
 * NOTE the MxN matrix is offset by MDA rows and NDA cols within A.
 */
#define _IX(ROW, COL) ((N0 * (MDA + (ROW)) + (NDA + (COL))))
#define _AIX(ROW, COL) (A)[_IX(ROW, COL)]

/** ------------------------------------------------------------------
 * Base implementation
 *
 * Using blocked delayed updated witih BLAS2 / BLAS3
 */
int _lu_solve_1(int M, int N, int M0, int N0, int MDA, int NDA, //
                double *A, int *ipiv)
{

  int i, j, k;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N) - 1; ++i)
  {

    // --------
    // ISAMAX

    double p_v;
    int p_i;

    p_i = i + isamax(M - i - 1, &_AIX(i, i), N0);
    p_v = fabs(_AIX(p_i, i));

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      return -1;
    }

    if (i != p_i)
    {

#if DEBUG_LU_SOLVER
      printf("p %f pivot row %d\n", _AIX(p_i, i), p_i);
      printf("swap rows %d <-> %d\n\n", i, p_i);
#endif
      swapi(ipiv, i, p_i);
      // ipiv[i] = p_i;
      // FIXME this is only working because I know we aren't
      // (currently) using a submatrix.
      sswap(N0, &AIX(i, 0), 1, &AIX(p_i, 0), 1);
    }

    // BLAS 1 Scale vector
    for (j = i + 1; j < N; ++j)
    {
      _AIX(j, i) = _AIX(j, i) / _AIX(i, i);
    }

    if (i < MIN(M, N))
    {
      // BLAS 2 rank-1 update
      for (j = i + 1; j < N; ++j)
      {
        for (int k = i + 1; k < N; ++k)
        {
          _AIX(j, k) = _AIX(j, k) - _AIX(j, i) * _AIX(i, k);
        }
      }
    }
  }

  return 0;
}

int __lu_solve_1(int N, double *A, int *ipiv, double *b, double *x)
{
  // A now contains L (below diagonal)
  //                U (above diagonal)

  int i, j, k;

  // Forward substitution
  // NOTE this can be done in place
  for (i = 0; i < N; ++i)
  {
    double v = b[ipiv[i]];
    for (j = 0; j < i; ++j)
    {
      v -= AIX(i, j) * x[j];
    }
    x[i] = v; /* / AIX(i, i); */ // XXX The diagonal for L is of unit value
  }

  for (i = 0; i < N; ++i)
    b[i] = x[i];

  // Backward substitution
  // Stored in 'x'
  for (i = N - 1; i >= 0; --i)
  {
    double v = b[i];
    for (j = i + 1; j < N; ++j)
    {
      v -= AIX(i, j) * x[j];
    }

    x[i] = v / AIX(i, i);
  }

  return 0;
}

int lu_solve_1(int N, double *A, int *ipiv, double *b, double *x)
{
  /**
   * FIXME for simplicity we will choose a block size of 32.
   * In the real system we can choose a dynamic block (better), or we can
   * always choose a fixed block and handle clean-up cases afterward (worse).
   */

  /* int NB = 32; */

  /* assert(N % NB == 0); */

  /* for (int i = 0; i < N; ++i) */
  /*   ipiv[i] = i; */

  /* int i, ib, j, k; */

  /* for (ib = 0; ib < N; ib += NB) */
  /* { */
  /*   // FIXME should I pass ipiv + ib ? */
  /*   int retcode = _lu_solve_1(N - ib, NB, N, N, ib, ib, A, ipiv); */

  /*   // Fix the pivot indices */
  /*   for (k = ib; k < ib + NB; ++k) */
  /*   { */
  /*     ipiv[k] = ipiv[k] + ib; */
  /*   } */

  /*   // Apply interchanges to columns */
  /* } */

  // Factor A into [L \ U]
  int retcode = _lu_solve_1(N, N, N, N, 0, 0, A, ipiv);
  if (retcode != 0)
    return retcode;
  // Solve the system with A
  retcode = __lu_solve_1(N, A, ipiv, b, x);

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
  add_function_LU_SOLVE(&lu_solve_1, "LU Solve Recursive BLAS", 1);
}

#endif
