#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lu_solve.h"
// #include "perf_testers/perf_lu_solve.h"
// #include "perf_testers/perf_mmm.h"

#define M 8
#define N 8
#define K 8

#define ALIGN_TO 32

#define CLAMP(x) (((x) + (ALIGN_TO - 1)) & -ALIGN_TO)

static void print_m(double *A, int m, int n)
{
  for (int i = 0; i < m; ++i)
  {
    for (int j = 0; j < n; ++j)
      printf("%f ", MIX(A, n, i, j));
    printf("\n");
  }
  printf("\n");
}

static void assert_equal(double *A, double *B, int m, int n)
{
  long wrong = 0L;

  for (int i = 0; i < m; ++i)
    for (int j = 0; j < n; ++j)
    {
      if (!APPROX_EQUAL(MIX(A, n, i, j), MIX(B, n, i, j)))
      {
        printf("Positions %d %d differ\nExpected %.5f Got %.5f\n", i, j,
               MIX(A, n, i, j), MIX(B, n, i, j));
        wrong++;
      }
    }

  if (0L < wrong)
  {
    printf("%ld wrong\n", wrong);
  }
  printf("\n");
}

/* static double A0[N * N] = { */

/*     1.28216,  0.72144,  1.37331,  1.90447,  1.77002,  0.866491, 0.761879, */
/*     1.24103,  0.72144,  1.91535,  1.25983,  0.222315, 0.398356, 1.22274, */
/*     0.837722, 0.860074, 1.37331,  1.25983,  0.615427, 1.30208,  1.12784, */
/*     1.00424,  1.37829,  0.258668, 1.90447,  0.222315, 1.30208,  0.468529, */
/*     1.11613,  0.861144, 0.597477, 0.824372, 1.77002,  0.398356, 1.12784, */
/*     1.11613,  0.794511, 1.70065,  0.704597, 1.348,    0.866491, 1.22274, */
/*     1.00424,  0.861144, 1.70065,  0.634552, 1.21498,  1.47736,  0.761879, */
/*     0.837722, 1.37829,  0.597477, 0.704597, 1.21498,  0.839329, 0.929368, */
/*     1.24103,  0.860074, 0.258668, 0.824372, 1.348,    1.47736,  0.929368, */
/*     1.06079 */

/* }; */

/* static double b0[N] = {0.6725654202538094, 0.21218380852808516, */
/*                        0.5154063695599664, 0.6531856734631304, */
/*                        0.2851420094765321, 0.7178972209257121, */
/*                        0.697889432181623,  0.847306267474455}; */

/* static double x[N] = {-0.43437789195670634, -0.3210374171587546, */
/*                       0.2927063196039346,   -0.41338616235059056, */
/*                       1.0455051505731106,   0.6613304469390048, */
/*                       0.12425501815908874,  -0.541360763464939}; */

static double drand()
{
  double a = 5.0;
  return ((double)rand() / (double)(RAND_MAX)) * a;
}

int main()
{

  lu_initialize_memory(N);

  /* double *A = (double *)aligned_alloc(32, CLAMP(N * N) * sizeof(double)); */
  /* double *b = (double *)aligned_alloc(32, CLAMP(N) * sizeof(double)); */

  double *A0 = (double *)aligned_alloc(ALIGN_TO, CLAMP(M * K * sizeof(double)));
  double *B0 = (double *)aligned_alloc(ALIGN_TO, CLAMP(K * N * sizeof(double)));
  double *C0 = (double *)aligned_alloc(ALIGN_TO, CLAMP(M * N * sizeof(double)));

  double *A1 = (double *)aligned_alloc(ALIGN_TO, CLAMP(M * K * sizeof(double)));
  double *B1 = (double *)aligned_alloc(ALIGN_TO, CLAMP(K * N * sizeof(double)));
  double *C1 = (double *)aligned_alloc(ALIGN_TO, CLAMP(M * N * sizeof(double)));

  /* for (int i = 0; i < N; ++i) */
  /*   for (int j = 0; j < N; ++j) */
  /*     A[i * N + j] = drand(); // A0[i * N + j]; */
  /* for (int i = 0; i < N; ++i) */
  /*   b[i] = drand(); // b0[i]; */

  for (int i = 0; i < M; ++i)
    for (int j = 0; j < K; ++j)
      MIX(A0, K, i, j) = drand();
  for (int i = 0; i < K; ++i)
    for (int j = 0; j < N; ++j)
      MIX(B0, N, i, j) = drand();
  for (int i = 0; i < M; ++i)
    for (int j = 0; j < N; ++j)
      MIX(C0, N, i, j) = drand();

  memcpy(A1, A0, M * K * sizeof(double));
  memcpy(B1, B0, N * K * sizeof(double));
  memcpy(C1, C0, M * N * sizeof(double));

  printf("Solving\n");

  print_m(A0, M, K);
  print_m(B0, K, N);

  /* int ret = lu_solve(N, A, b); */
  /* for (int i = 0; i < N; ++i) */
  /*   assert(APPROX_EQUAL(b[i], x[i])); */

  sgemm_5(M, N, K, -ONE, A0, M, B0, K, ONE, C0, M);
  sgemm_1T(M, N, K, -ONE, A1, M, B1, K, ONE, C1, M);

  assert_equal(C0, C1, M, N);

  print_m(C0, M, N);
  print_m(C1, M, N);

  // int ret = perf_test_mmm(M, N, K, -ONE, A0, M, B0, K, ONE, C0, M);

  printf("Done\n");

  /* assert_equal(C0, C1, M, N); */
  /* perf_test_lu_solve(N, A, ipiv, b); */

  lu_free_memory();

  return 0;
}
