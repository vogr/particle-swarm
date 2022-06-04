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

int triangular_system_solve_0(int N, int d, double *Ab, double *x);

int triangular_system_solve(int N, int d, double *Ab, double *x)
{
  return triangular_system_solve_0(N, d, Ab, x);
}

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
      fprintf(stderr,
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
    fprintf(stderr,
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

/**
 * DON'T USE THAT IT DOESN'T WORK
 * - Loop unrolling up to depth 8.
 */
int triangular_system_solve_1(int N, double *Ab, double *x)
{
  // loop indices
  int k, i, j;

  for (k = 0; k < N - 1; k++)
  {
    // Find largest possible pivot in submatrix of A

    double                        //
        v_i[4],                   //
        p = 0.0,                  //
        p_i[4] = {0., 0., 0., 0.} //
    ;

    int                            //
        pivot_row_idx = -1,        //
        pr_i[4] = {-1, -1, -1, -1} //
    ;

    // NOTE this is a column major iteration
    // ! unrolling will probably not help
    // but vectorization might.
    //
    // Potentially we can change iteration order
    // for better locality.
    for (i = k; i < N - 3; i += 4)
    {
      v_i[0] = MAT_Ab(i + 0, k);
      v_i[1] = MAT_Ab(i + 1, k);
      v_i[2] = MAT_Ab(i + 2, k);
      v_i[3] = MAT_Ab(i + 3, k);

      if (fabs(v_i[0]) > fabs(p_i[0]))
      {
        p_i[0] = v_i[0];
        pr_i[0] = i + 0;
      }

      if (fabs(v_i[1]) > fabs(p_i[1]))
      {
        p_i[1] = v_i[1];
        pr_i[1] = i + 1;
      }

      if (fabs(v_i[2]) > fabs(p_i[2]))
      {
        p_i[2] = v_i[2];
        pr_i[2] = i + 2;
      }

      if (fabs(v_i[3]) > fabs(p_i[3]))
      {
        p_i[3] = v_i[3];
        pr_i[3] = i + 3;
      }

    } // unroll i

    for (; i < N; i++)
    {
      v_i[0] = MAT_Ab(i + 0, k);

      if (fabs(v_i[0]) > fabs(p_i[0]))
      {
        p_i[0] = v_i[0];
        pr_i[0] = i;
      }
    } // leftover i

    // -----

    for (int ii = 0; ii < 4; ii++)
    {
      if (fabs(p_i[ii]) > fabs(p))
      {
        p = p_i[ii];
        pivot_row_idx = pr_i[ii];
      }
    }

    // -----

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

      for (j = 0; j < N + 1 - 7; j += 8)
      {
        swapd(Ab, k * (N + 1) + j + 0, pivot_row_idx * (N + 1) + j + 0);
        swapd(Ab, k * (N + 1) + j + 1, pivot_row_idx * (N + 1) + j + 1);
        swapd(Ab, k * (N + 1) + j + 2, pivot_row_idx * (N + 1) + j + 2);
        swapd(Ab, k * (N + 1) + j + 3, pivot_row_idx * (N + 1) + j + 3);

        swapd(Ab, k * (N + 1) + j + 4, pivot_row_idx * (N + 1) + j + 4);
        swapd(Ab, k * (N + 1) + j + 5, pivot_row_idx * (N + 1) + j + 5);
        swapd(Ab, k * (N + 1) + j + 6, pivot_row_idx * (N + 1) + j + 6);
        swapd(Ab, k * (N + 1) + j + 7, pivot_row_idx * (N + 1) + j + 7);
      } // unrolled j

      for (; j < N + 1; j++)
      {
        swapd(Ab, k * (N + 1) + j, pivot_row_idx * (N + 1) + j);
      } // leftover j
    }

    // elimination: on A __and b__
    // note: the first substraction could be skipped / or replaced by =0
    // as it is known to give value 0 (and not used in back substitution)
    // Keep for debugging for now

    double   //
        r_0, //
        r_1, //
        r_2, //
        r_3, //

        inv_p = 1 / p //
        ;

    // NOTE unroll i 4 times
    //      unroll j 8 times
    for (i = k + 1; i < N - 3; i += 4)
    {

      r_0 = inv_p * MAT_Ab(i + 0, k);
      r_1 = inv_p * MAT_Ab(i + 1, k);
      r_2 = inv_p * MAT_Ab(i + 2, k);
      r_3 = inv_p * MAT_Ab(i + 3, k);

      for (j = k; j < N + 1 - 7; j += 8)
      {
        // ----
        MAT_Ab(i + 0, j + 0) -= r_0 * MAT_Ab(k, j + 0);
        MAT_Ab(i + 0, j + 1) -= r_0 * MAT_Ab(k, j + 1);
        MAT_Ab(i + 0, j + 2) -= r_0 * MAT_Ab(k, j + 2);
        MAT_Ab(i + 0, j + 3) -= r_0 * MAT_Ab(k, j + 3);
        MAT_Ab(i + 0, j + 4) -= r_0 * MAT_Ab(k, j + 4);
        MAT_Ab(i + 0, j + 5) -= r_0 * MAT_Ab(k, j + 5);
        MAT_Ab(i + 0, j + 6) -= r_0 * MAT_Ab(k, j + 6);
        MAT_Ab(i + 0, j + 7) -= r_0 * MAT_Ab(k, j + 7);

        // ----
        MAT_Ab(i + 1, j + 0) -= r_1 * MAT_Ab(k, j + 0);
        MAT_Ab(i + 1, j + 1) -= r_1 * MAT_Ab(k, j + 1);
        MAT_Ab(i + 1, j + 2) -= r_1 * MAT_Ab(k, j + 2);
        MAT_Ab(i + 1, j + 3) -= r_1 * MAT_Ab(k, j + 3);
        MAT_Ab(i + 1, j + 4) -= r_1 * MAT_Ab(k, j + 4);
        MAT_Ab(i + 1, j + 5) -= r_1 * MAT_Ab(k, j + 5);
        MAT_Ab(i + 1, j + 6) -= r_1 * MAT_Ab(k, j + 6);
        MAT_Ab(i + 1, j + 7) -= r_1 * MAT_Ab(k, j + 7);

        // ----
        MAT_Ab(i + 2, j + 0) -= r_2 * MAT_Ab(k, j + 0);
        MAT_Ab(i + 2, j + 1) -= r_2 * MAT_Ab(k, j + 1);
        MAT_Ab(i + 2, j + 2) -= r_2 * MAT_Ab(k, j + 2);
        MAT_Ab(i + 2, j + 3) -= r_2 * MAT_Ab(k, j + 3);
        MAT_Ab(i + 2, j + 4) -= r_2 * MAT_Ab(k, j + 4);
        MAT_Ab(i + 2, j + 5) -= r_2 * MAT_Ab(k, j + 5);
        MAT_Ab(i + 2, j + 6) -= r_2 * MAT_Ab(k, j + 6);
        MAT_Ab(i + 2, j + 7) -= r_2 * MAT_Ab(k, j + 7);

        // ----
        MAT_Ab(i + 3, j + 0) -= r_3 * MAT_Ab(k, j + 0);
        MAT_Ab(i + 3, j + 1) -= r_3 * MAT_Ab(k, j + 1);
        MAT_Ab(i + 3, j + 2) -= r_3 * MAT_Ab(k, j + 2);
        MAT_Ab(i + 3, j + 3) -= r_3 * MAT_Ab(k, j + 3);
        MAT_Ab(i + 3, j + 4) -= r_3 * MAT_Ab(k, j + 4);
        MAT_Ab(i + 3, j + 5) -= r_3 * MAT_Ab(k, j + 5);
        MAT_Ab(i + 3, j + 6) -= r_3 * MAT_Ab(k, j + 6);
        MAT_Ab(i + 3, j + 7) -= r_3 * MAT_Ab(k, j + 7);

      } // j unrolled

      for (; j < N + 1; j++)
      {
        MAT_Ab(i + 0, j) -= r_0 * MAT_Ab(k, j);
        MAT_Ab(i + 1, j) -= r_1 * MAT_Ab(k, j);
        MAT_Ab(i + 2, j) -= r_2 * MAT_Ab(k, j);
        MAT_Ab(i + 3, j) -= r_3 * MAT_Ab(k, j);
      } // leftover j

    } // i unrolled

    // -----

    for (; i < N; i++)
    {

      r_0 = inv_p * MAT_Ab(i, k);

      for (j = k; j < N + 1 - 7; j += 8)
      {
        MAT_Ab(i, j + 0) -= r_0 * MAT_Ab(k, j + 0);
        MAT_Ab(i, j + 1) -= r_0 * MAT_Ab(k, j + 1);
        MAT_Ab(i, j + 2) -= r_0 * MAT_Ab(k, j + 2);
        MAT_Ab(i, j + 3) -= r_0 * MAT_Ab(k, j + 3);

        MAT_Ab(i, j + 4) -= r_0 * MAT_Ab(k, j + 4);
        MAT_Ab(i, j + 5) -= r_0 * MAT_Ab(k, j + 5);
        MAT_Ab(i, j + 6) -= r_0 * MAT_Ab(k, j + 6);
        MAT_Ab(i, j + 7) -= r_0 * MAT_Ab(k, j + 7);
      } // j unrolled

      for (; j < N + 1; j++)
      {
        MAT_Ab(i, j) -= r_0 * MAT_Ab(k, j);
      } // leftover j

    } // Leftover i
  }

  if (fabs(MAT_Ab(N - 1, N - 1)) < 1e-10)
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
    // NOTE dangerous reordering of ops
    double                       //
        v = MAT_Ab(i, N),        //
        v_ii = 1 / MAT_Ab(i, i), //

        v_0 = 0, //
        v_1 = 0, //
        v_2 = 0, //
        v_3 = 0, //
        v_4 = 0, //
        v_5 = 0, //
        v_6 = 0, //
        v_7 = 0  //
        ;

    for (j = i + 1; j < N - 7; j += 8)
    {
      v_0 += MAT_Ab(i, j + 0) * x[j + 0];
      v_1 += MAT_Ab(i, j + 1) * x[j + 1];
      v_2 += MAT_Ab(i, j + 2) * x[j + 2];
      v_3 += MAT_Ab(i, j + 3) * x[j + 3];

      v_4 += MAT_Ab(i, j + 4) * x[j + 4];
      v_5 += MAT_Ab(i, j + 5) * x[j + 5];
      v_6 += MAT_Ab(i, j + 6) * x[j + 6];
      v_7 += MAT_Ab(i, j + 7) * x[j + 7];
    }

    for (; j < N; j++)
    {
      v_7 += MAT_Ab(i, j + 0) * x[j + 0];
    }

    x[i] = (v - v_0 - v_1 - v_2 - v_3 - v_4 - v_5 - v_6 - v_7) * v_ii;
  }

  return 0;
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
