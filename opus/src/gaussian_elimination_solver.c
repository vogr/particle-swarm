
#include "gaussian_elimination_solver.h"

#include <math.h>
#include <stdio.h>

#include "helpers.h"

// TODO @vogier had mentioned using a macro system to
// compile the code in different ways for performance
// testing.
//
#include <immintrin.h>

#define DEBUG_GE_SOLVER 0

// NOTE predefine functions here and put them in increasing level
// of optimization below. Please list the optimizations performed
// in the preceding function comment.
int gaussian_elimination_solve_0(int N, double *Ab, double *x);
int gaussian_elimination_solve_1(int N, double *Ab, double *x);

static void swapd(double *a, int i, int j)
{
  double t = a[i];
  a[i] = a[j];
  a[j] = t;
}

// Textual transformation assumes matrix Ab and matrix size `N`
// are in scope.
#define MAT_Ab(ROW, COL) (Ab)[(N + 1) * (ROW) + (COL)]

int gaussian_elimination_solve(int N, double *Ab, double *x)
{
  return gaussian_elimination_solve_0(N, Ab, x);
}

// Base implementation
int gaussian_elimination_solve_0(int N, double *Ab, double *x)
{
  // Note: works inplace on Ab, outputs in x
  // Ab= [ A | b], sie N x (N+1)

  // Gaussian elimination with partial pivoting

#if DEBUG_GE_SOLVER
  printf("Before elimination:");
  print_rect_matrixd(Ab, N, N + 1, "Ab0");
#endif

  for (int k = 0; k < N - 1; k++)
  {
    // Find largest possible pivot in submatrix of A
    double p = 0.;
    int pivot_row_idx = -1;
    for (int i = k; i < N; i++)
    {
      double v = MAT_Ab(i, k);
      if (fabs(v) > fabs(p))
      {
        p = v;
        pivot_row_idx = i;
      }
    }

    if (pivot_row_idx < 0)
    {
      // singular matrix
      fprintf(
          stderr,
          "ERROR: gaussian elimination failed: cannot find non-zero pivot for "
          "sub-matrix %d\n",
          k);
      return -1;
    }

    if (k != pivot_row_idx)
    {
// swap the rows in Ab
#if DEBUG_GE_SOLVER
      printf("Swap rows %d <-> %d\n", k, pivot_row_idx);
#endif
      for (int j = 0; j < N + 1; j++)
      {
        swapd(Ab, k * (N + 1) + j, pivot_row_idx * (N + 1) + j);
      }
    }

    // elimination: on A __and b__
    // note: the first substraction could be skipped / or replaced by =0
    // as it is known to give value 0 (and not used in back substitution)
    // Keep for debugging for now

    for (int i = k + 1; i < N; i++)
    {
      double r = MAT_Ab(i, k) / p;
      for (int j = k; j < N + 1; j++)
      {
        MAT_Ab(i, j) -= r * MAT_Ab(k, j);
      }
    }

#if DEBUG_GE_SOLVER
    printf("Elimination step %d:\n", k);
    print_rect_matrixd(Ab, N, N + 1, "Ab");
#endif
  }

  if (fabs(MAT_Ab(N - 1, N - 1)) < 1e-3)
  {
    // singular matrix
    fprintf(stderr, "ERROR: gaussian elimination failed: last pivot is 0\n");
    return -1;
  }

  // A is now upper triangular

  // Backward substitution
  // U x = y
  for (int i = N - 1; i >= 0; i--)
  {
    // value in b
    double v = MAT_Ab(i, N);
    for (int j = i + 1; j < N; j++)
    {
      v -= MAT_Ab(i, j) * x[j];
    }
    x[i] = v / MAT_Ab(i, i);
  }

  return 0;
}

/**
 * - Loop unrolling up to depth 4.
 */
int gaussian_elimination_solve_1(int N, double *Ab, double *x)
{

  // loop indices
  int    //
      k, //
      i, //
      j  //
      ;

  double   //
      v_0, //
      v_1, //
      v_2, //
      v_3  //
      ;

  for (k = 0; k < N - 1; k++)
  {
    // Find largest possible pivot in submatrix of A
    double p = 0.;
    int pivot_row_idx = -1;

    // NOTE this is a column major iteration
    // !
    for (i = k; i < N; i++)
    {

      v_0 = MAT_Ab(i + 0, k);

      if (fabs(v_0) > fabs(p))
      {
        p = v_0;
        pivot_row_idx = i;
      }
    }

    if (pivot_row_idx < 0)
    {
      // singular matrix
      fprintf(
          stderr,
          "ERROR: gaussian elimination failed: cannot find non-zero pivot for "
          "sub-matrix %d\n",
          k);
      return -1;
    }

    if (k != pivot_row_idx)
    {

      for (j = 0; j < N + 1 - 3; j += 4)
      {

        /* __m256d row_00; */
        /* __m256d pivot_row_00; */
        /* int row_i_00 = k * (N + 1) + j + 0; */
        /* int prow_i_00 = pivot_row_idx * (N + 1) + j + 0; */
        /* row_00 = _mm256_load_pd(Ab + row_i_00); */
        /* pivot_row_00 = _mm256_load_pd(Ab + prow_i_00); */
        /* _mm256_store_pd(Ab + row_i_00, pivot_row_00); */
        /* _mm256_store_pd(Ab + prow_i_00, row_00); */

        swapd(Ab, k * (N + 1) + j + 0, pivot_row_idx * (N + 1) + j + 0);
        swapd(Ab, k * (N + 1) + j + 1, pivot_row_idx * (N + 1) + j + 1);
        swapd(Ab, k * (N + 1) + j + 2, pivot_row_idx * (N + 1) + j + 2);
        swapd(Ab, k * (N + 1) + j + 3, pivot_row_idx * (N + 1) + j + 3);
      }

      // Swap leftover indices
      for (; j < N + 1; j++)
      {
        swapd(Ab, k * (N + 1) + j, pivot_row_idx * (N + 1) + j);
      }
    }

    // elimination: on A __and b__
    // note: the first substraction could be skipped / or replaced by =0
    // as it is known to give value 0 (and not used in back substitution)
    // Keep for debugging for now

    double   //
        r_0, //
        r_1, //
        r_2, //
        r_3  //
        ;

    for (i = k + 1; i < N; i++)
    {

      r_0 = MAT_Ab(i, k) / p;

      for (j = k; j < N + 1 - 3; j += 4)
      {
        MAT_Ab(i, j + 0) -= r_0 * MAT_Ab(k, j + 0);
        MAT_Ab(i, j + 1) -= r_0 * MAT_Ab(k, j + 1);
        MAT_Ab(i, j + 2) -= r_0 * MAT_Ab(k, j + 2);
        MAT_Ab(i, j + 3) -= r_0 * MAT_Ab(k, j + 3);
      }

      for (; j < N + 1; j++)
      {
        MAT_Ab(i, j) -= r_0 * MAT_Ab(k, j);
      }
    }
  }

  if (fabs(MAT_Ab(N - 1, N - 1)) < 1e-3)
  {
    // singular matrix
    fprintf(stderr, "ERROR: gaussian elimination failed: last pivot is 0\n");
    return -1;
  }

  // A is now upper triangular

  // Backward substitution
  // U x = y
  for (i = N - 1; i >= 0; i--)
  {
    // value in b
    double v = MAT_Ab(i, N);
    for (j = i + 1; j < N; j++)
    {
      v -= MAT_Ab(i, j) * x[j];
    }
    x[i] = v / MAT_Ab(i, i);
  }

  return 0;
}
