#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lu_decomposition.h"

void print_matrix(double *M, int N, char *name)
{
  printf("=== %s matrix ===\n", name);
  int i, j;
  for (i = 0; i < N; i++)
  {
    for (j = 0; j < N; j++)
      printf("%.4f ", IDX(M, i, j));
    printf("\n");
  }
  printf("\n");
}

void test(int N, double *A, double *L, double *U, double *exp_l, double *exp_u)
{
  printf("Testing ...\n");
  print_matrix(A, N, "A");
  print_matrix(L, N, "L");
  print_matrix(U, N, "U");
  assert(memcmp(L, exp_l, sizeof(double) * N * N) == 0);
  assert(memcmp(U, exp_u, sizeof(double) * N * N) == 0);
}

int main()
{

  int N;

  // Test 1

  N = 3;

  double A[] =     // Comments to avoid formatting
      {2,  -1, -2, //
       -4, 6,  3,  //
       -4, -2, 8};

  double expected_l[] = //
      {1,  0,  0,       //
       -2, 1,  0,       //
       -2, -1, 1};

  double expected_u[] = //
      {2, -1, -2,       //
       0, 4,  -1,       //
       0, 0,  3};

  lu_decomposition *result = lu_decompose(&A, N);
  test(&A, result->L, result->U, &expected_l, &expected_u);

  // Test 2

  N = 3;

  double B[] =   //
      {1, 2, 4,  //
       3, 8, 14, //
       2, 6, 13};

  double expected_l2[] = //
      {1, 0, 0,          //
       3, 1, 0,          //
       2, 1, 1};

  double expected_u2[] = //
      {1, 2, 4,          //
       0, 2, 2,          //
       0, 0, 3};

  result = lu_decompose(&B, N);
  test(&A, result->L, result->U, &expected_l2, &expected_u2);

  return 0;
}
