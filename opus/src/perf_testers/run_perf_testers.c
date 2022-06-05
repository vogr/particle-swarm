
#include "run_perf_testers.h"
#include "../helpers.h"

#include <assert.h>

#include "perf_block_tri_solve.h"
#include "perf_ge_solve.h"
#include "perf_lu_solve.h"
#include "perf_mmm.h"

#include "../gaussian_elimination_solver.h"
#include "../lu_solve.h"
#include "../triangular_system_solver.h"

#include "math.h"

#define MAT(M, s, i, j) M[(i)*s + j]

#define MAT_ELEM_MIN 0.1
#define MAT_ELEM_MAX 100000

#define FIXED_D_SCHEME

#ifdef FIXED_D_SCHEME
#define FIXED_D 30
#define CALCULATE_D(n) (FIXED_D)
#else
#define D_RATIO (1 / 3)
#define CALCULATE_D(n) (D_RATIO * n)
#endif

// Generate symmetric matrix in A of size 'cxc' and starting at specified
// row,column
static void generate_sym_matrix(double *A, size_t start_row, size_t start_col,
                                size_t c, size_t n_A)
{
  assert(start_row + c <= n_A);
  assert(start_col + c <= n_A);

  for (size_t i = 0; i < c; ++i)
  {
    for (size_t j = 0; j <= i; ++j)
    {
      double t = rand_between(MAT_ELEM_MIN, MAT_ELEM_MAX);
      MAT(A, n_A, i + start_row, j + start_col) = t;
      MAT(A, n_A, j + start_row, i + start_col) = t;
    }
  }
}

// Generate P matrix in A of size 'cxd' and starting at specified row,column
static void generate_P_matrix(double *A, size_t c, size_t d, size_t start_row_1,
                              size_t start_col_1, size_t start_row_2,
                              size_t start_col_2, size_t n_A)
{
  assert(start_row_1 + c <= n_A);
  assert(start_col_1 + d <= n_A);

  assert(start_row_2 + d <= n_A);
  assert(start_col_2 + c <= n_A);

  size_t i_1, i_2, j_1, j_2;
  for (size_t i = 0; i < c; ++i)
  {
    i_1 = i + start_row_1;
    i_2 = i + start_row_2;
    for (size_t j = 0; j < d; ++j)
    {
      j_1 = j + start_col_1;
      j_2 = j + start_col_2;

      double t = rand_between(MAT_ELEM_MIN, MAT_ELEM_MAX);
      MAT(A, n_A, i_1, j_1) = t;
      MAT(A, n_A, j_2, i_2) = t;
    }
  }
}

// Generate P matrix in A of size 'cxd' and starting at specified row,column
static void dump_zeros(double *A, size_t start_row, size_t start_col, size_t d,
                       size_t n_A)
{
  assert(start_row + d <= n_A);
  assert(start_col + d <= n_A);

  for (size_t i = start_row; i < start_row + d; ++i)
  {
    for (size_t j = start_col; j < start_col + d; ++j)
    {
      MAT(A, n_A, i, j) = 0.0;
    }
  }
}

static void dump_vec_to_col(double *A, double *v, size_t col, size_t n_A)
{
  for (size_t i = 0; i < n_A; ++i)
  {
    MAT(A, n_A, i, col) = v[i];
  }
}

// Generate matrices layed out in the same form as for the pb
static void tile_matrices(double *A_ge, double *A_lu, double *A_tri, double *b,
                          size_t c, size_t d)
{
  size_t n_A = c + d;

  // A_ge and A_lu
  generate_sym_matrix(A_ge, 0, 0, c, n_A);
  generate_sym_matrix(A_lu, 0, 0, c, n_A);

  generate_P_matrix(A_ge, c, d, 0, c, c, 0, n_A);
  generate_P_matrix(A_lu, c, d, 0, c, c, 0, n_A);

  dump_zeros(A_ge, c, c, d, n_A);
  dump_zeros(A_lu, c, c, d, n_A);

  dump_vec_to_col(A_ge, b, n_A, n_A);

  // A_tri
  generate_sym_matrix(A_tri, 0, d, c, n_A);

  generate_P_matrix(A_tri, c, d, 0, 0, c, d, n_A);

  dump_zeros(A_tri, c, 0, d, n_A);

  dump_vec_to_col(A_tri, b, n_A, n_A);
}

static void generate_random_vec(double *b, size_t n)
{
  for (size_t i = 0; i < n; ++i)
  {
    b[i] = rand_between(MAT_ELEM_MIN, MAT_ELEM_MAX);
  }
}

static void init_perf_test() {
    register_functions_GE_SOLVE();
    register_functions_LU_SOLVE();
    register_functions_TRI_SYS_SOLVE();
    register_functions_MMM();

    // enough mem
    lu_initialize_memory((int) pow(2, 20));
}

static void pre_perf_test(double **A_ge, double **A_lu, double **A_tri, double **b,
                          double **x, size_t n, size_t d)
{
  *A_ge = realloc(*A_ge, n * (n + 1) * sizeof(double));

  *A_lu = realloc(*A_lu, n * n * sizeof(double));
  *b = realloc(*b, n * sizeof(double));

  *A_tri = realloc(*A_tri, n * (n + 1) * sizeof(double));

  tile_matrices(*A_ge, *A_lu, *A_tri, *b, n - d, d);
  generate_random_vec(*b, n);

  *x = realloc(*x, n * sizeof(double));
}

static void run_perf_tests_single(double *A_ge, double *A_lu, double *A_tri,
                                  double *b, double *x, size_t n, size_t d)
{
  // lu overwrites b, for fairness we run all perf tests with same input
  // hence we run lu last.
  perf_test_ge_solve(n, A_ge, x);
  perf_test_tri_sys_solve(n, d, A_tri, x);
  perf_test_lu_solve(n, A_lu, b);
}

/*
    - In cubic interpolation scheme, step is ignored
*/
void run_perf_tests_range(size_t start, size_t step, size_t stop,
                          range_scheme_t scheme)
{
  double *A_ge = NULL;
  double *A_lu = NULL;
  double *A_tri = NULL;
  double *b = NULL;
  double *x = NULL;

  size_t _start, _step, _stop;

  switch (scheme)
  {
  case linear:
    _start = start;
    _step = step;
    _stop = stop;
    break;

  case cubic_interpolation:
    _start = (size_t)round(pow(start, 1 / 3.));
    _step = 1;
    _stop = (size_t)round(pow(stop, 1 / 3.));
    break;
  }

  size_t _n, n, d;

  init_perf_test();

  for (_n = _start; _n < _stop; _n += _step)
  {
    printf("%d\n", _n);
    switch (scheme)
    {
    case linear:
      n = _n;
      break;

    case cubic_interpolation:
      n = (size_t)pow(_n, 3);
      break;
    }

    d = CALCULATE_D(n);
    pre_perf_test(&A_ge, &A_lu, &A_tri, &b, &x, n, d);
    run_perf_tests_single(A_ge, A_lu, A_tri, b, x, n, d);
  }
}

int main(int argc, char **argv)
{
  run_perf_tests_range(100, 1, 5000, cubic_interpolation);
}
