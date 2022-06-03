#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>

#include "helpers.h"
#include "perf_testers/perf_block_tri_solve.h"
#include "triangular_system_solver.h"

// TODO @vogier had mentioned using a macro system to
// compile the code in different ways for performance
// testing.
//
#include <immintrin.h>

#define DEBUG_GE_SOLVER 0

static void swapd(double *a, int i, int j)
{
  double t = a[i];
  a[i] = a[j];
  a[j] = t;
}

// Textual transformation assumes matrix Ab and matrix size `N`
// are in scope.
#define MAT_Ab(ROW, COL) (Ab)[(N + 1) * (ROW) + (COL)]
#define MAT_Ab_IX(ROW, COL) (Ab + ((N + 1) * (ROW) + (COL)))

// NOTE predefine functions here and put them in increasing level
// of optimization below. Please list the optimizations performed
// in the preceding function comment.

/*
    The system is actually equivalent to

    | P | Phi | * |   c    |  =  | F |
    | 0 | P^t |   | lambda |     | 0 |

    Which is an upper-triangular block matrix system.

    We assume that Ab is written in such form.
    Also, parameter d is the side length of the 0 matrix.

    The dimensions are therefeore:
    | t x d | t x t | * | t |  =  | t |
    | d x d | d x t |   | d |     | d |

    Where t = N - d

    We assume that N-d >= d, otherwise the above matrix
    is singular.
*/
int triangular_system_solve_0(int N, int d, double *Ab, double *x)
{
#if DEBUG_GE_SOLVER
  printf("Before elimination:");
  print_rect_matrixd(Ab, N, N + 1, "Ab0");
#endif

  int t = N - d;

  // first triangularize the left upper block
  // from 0 to d - 1
  // have to search for pivot until k=t
  for (int k = 0; k < t; k++)
  {
    // Find largest possible pivot in submatrix of A
    double p = 0.;
    int pivot_row_idx = -1;
    for (int i = k; i < t; i++)
    {
      double v = MAT_Ab(i, k);
      if (fabs(v) > fabs(p))
      {
        p = v;
        pivot_row_idx = i;
      }
    }

#if DEBUG_GE_SOLVER
    printf("p %f pivot row %d\n", p, pivot_row_idx);
#endif

    if (pivot_row_idx < 0)
    {
      // singular matrix
      fprintf(
          stderr,
          "ERROR: block tri GE failed: cannot find non-zero pivot for "
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
      // we swap the line only from pivot column k
      // otherwise we're just swapping zeros around
      // for (int j = k; j < N + 1; j++) {
      for (int j = k; j < N + 1; j++)
      {
        swapd(Ab, k * (N + 1) + j, pivot_row_idx * (N + 1) + j);
        // double t = MAT_Ab(k, j);
        // MAT_Ab(k, j) = MAT_Ab(pivot_row_idx, j);
        // MAT_Ab(pivot_row_idx, j) = t;
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
  }

  if (fabs(MAT_Ab(t - 1, t - 1)) < 1e-3)
  {
    // singular matrix
    fprintf(
        stderr,
        "ERROR: block tri GE failed: pivot after first block is 0\n");
    return -1;
  }

  // second: triangularize middle block
  // from d to t - 1
  // have to search for pivot until t - 1
  //   for (int k = d; k < t; k++)
  //   {
  //     // Find largest possible pivot in submatrix of A
  //     double p = 0.;
  //     int pivot_row_idx = -1;
  //     for (int i = k; i < t; i++)
  //     {
  //       double v = MAT_Ab(i, k);
  //       if (fabs(v) > fabs(p))
  //       {
  //         p = v;
  //         pivot_row_idx = i;
  //       }
  //     }

  // #if DEBUG_GE_SOLVER
  //     printf("p %f pivot row %d\n", p, pivot_row_idx);
  // #endif

  //     if (pivot_row_idx < 0)
  //     {
  //       // singular matrix
  //       fprintf(stderr,
  //               "ERROR: block tri GE failed: cannot find non-zero "
  //               "pivot for "
  //               "sub-matrix %d\n",
  //               k);
  //       return -1;
  //     }

  //     if (k != pivot_row_idx)
  //     {
  // // swap the rows in Ab
  // #if DEBUG_GE_SOLVER
  //       printf("Swap rows %d <-> %d\n", k, pivot_row_idx);
  // #endif
  //       // we swap the line only from pivot column k
  //       // otherwise we're just swapping zeros around
  //       for (int j = k; j < N + 1; j++)
  //       {
  //         double t = MAT_Ab(k, j);
  //         MAT_Ab(k, j) = MAT_Ab(pivot_row_idx, j);
  //         MAT_Ab(pivot_row_idx, j) = t;
  //       }
  //     }

  //     // elimination: on A __and b__
  //     // note: the first substraction could be skipped / or replaced by =0
  //     // as it is known to give value 0 (and not used in back substitution)
  //     // Keep for debugging for now

  //     for (int i = k + 1; i < N; i++)
  //     {
  //       double r = MAT_Ab(i, k) / p;
  //       for (int j = k; j < N + 1; j++)
  //       {
  //         MAT_Ab(i, j) -= r * MAT_Ab(k, j);
  //       }
  //     }

  // #if DEBUG_GE_SOLVER
  //     printf("Elimination step %d:\n", k);
  //     print_rect_matrixd(Ab, N, N + 1, "Ab");
  // #endif
  //   }

  // if (fabs(MAT_Ab(N - 1, N - 1)) < 1e-3)
  // {
  //   // singular matrix
  //   fprintf(stderr, "ERROR: block tri GE failed: pivot after middle
  //   block is 0\n"); return -1;
  // }

  // last: triangularize the right bottom block
  // from t to N - 1
  // have to search for pivot until N
  for (int k = t; k < N - 1; k++)
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

#if DEBUG_GE_SOLVER
    printf("p %f pivot row %d\n", p, pivot_row_idx);
#endif

    if (pivot_row_idx < 0)
    {
      // singular matrix
      fprintf(stderr,
              "ERROR: block tri GE failed: cannot find non-zero "
              "pivot for "
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
      // we swap the line only from pivot column k
      // otherwise we're just swapping zeros around
      for (int j = k; j < N + 1; j++)
      {
        double t = MAT_Ab(k, j);
        MAT_Ab(k, j) = MAT_Ab(pivot_row_idx, j);
        MAT_Ab(pivot_row_idx, j) = t;
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
    fprintf(stderr, "ERROR: block tri GE failed: last pivot is 0\n");
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

int triangular_system_solve(int N, int d, double *Ab, double *x)
{
  return triangular_system_solve_0(N, d, Ab, x);
}

#ifdef TEST_PERF

// NOTE I bet we can put these in the templated perf framework and remove the
// weirdness of compiling seperately and linking.
void register_functions_TRI_SYS_SOLVE()
{
  add_function_TRI_SYS_SOLVE(&triangular_system_solve_0,
                             "Triangular System Solve Base", 1);
}

#endif
