#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "plu_factorization.h"

void print_matrix(double *M, int N, char *name)
{
  printf("=== %s matrix ===\n", name);
  int i, j;
  for (i = 0; i < N; i++)
  {
    for (j = 0; j < N; j++)
      printf("%.4f ", M[N * i + j]);
    printf("\n");
  }
  printf("\n");
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

  plu_factorization plu;
  alloc_plu_factorization(N, &plu);
  plu_factorize(N, A, &plu);

  print_matrix(A, N, "A");
  print_matrix(plu.L, N, "L");
  print_matrix(plu.U, N, "U");

  printf("=== p vector ===\n");
  for (int i = 0 ; i < N ; i++)
  {
    printf("%d ", plu.P[i]);
  }
  printf("\n");


  // Solve a system
  double b[] = {1., 2., 3.};
  double x[3] = {0};
  plu_solve(N, &plu, b, x);

  printf("=== x vector ===\n[ ");
  for (int i = 0 ; i < N ; i++)
  {
    printf("%f ", x[i]);
    if(i < N-1) printf(", ");
  }
  printf(" ]\n\n\n");


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

  // reuse memory from previous plu
  plu_factorize(N, B, &plu);

  print_matrix(B, N, "B");
  print_matrix(plu.L, N, "L");
  print_matrix(plu.U, N, "U");

  printf("=== p vector ===\n");
  for (int i = 0 ; i < N ; i++)
  {
    printf("%d ", plu.P[i]);
  }
  printf("\n");

  // Solve a system
  double b2[] = {1., 2, 3.};
  double x2[3] = {0};
  plu_solve(N, &plu, b2, x2);

  printf("=== x vector ===\n[ ");
  for (int i = 0 ; i < N ; i++)
  {
    printf("%f", x2[i]);
    if(i < N-1) printf(", ");
  }
  printf(" ]\n");

  free_plu_factorization(&plu);

  return 0;
}
