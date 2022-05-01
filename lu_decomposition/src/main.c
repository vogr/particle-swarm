#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "../../opus/src/helpers.h"
#include "../../opus/src/plu_factorization.h"

static double rand_between(double a, double b)
{
    // see http://c-faq.com/lib/randrange.html
    return a + (double)rand() / ((double)RAND_MAX / (b - a));
}

#define N 6
int main()
{
  int ret = 0;

  srand(clock());

  double A[N * N];
  for (int i = 0; i < N ; i++)
    for(int j = 0 ; j < N ; j++)
      A[i * N + j] = rand_between(-100,100);


  A[4 * N + 4] = A[4 * N + 5] = A[5 * N + 4] = A[5 * N + 5] = 0;

  double b[N];
  for (int i = 0 ; i < N ; i++)
    b[i] = i;



  printf("=== Test 1 ===\n");
  print_matrixd(A, N, "A");
  print_vectord(b, N, "b");
  printf("\n\n\n");

  plu_factorization plu;
  alloc_plu_factorization(N, &plu);
  if (plu_factorize(N, A, &plu) < 0)
  {
    ret = 1;
    goto fact_fail;
  }

  print_matrixd(plu.L, N, "L");
  print_matrixd(plu.U, N, "U");


  double x[N] = {0};
  plu_solve(N, &plu, b, x);
  



  print_vectori(plu.P, N, "p");
  print_vectord(x, N, "x");


#if 0
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
#endif


fact_fail:
  free_plu_factorization(&plu);

  return ret;
}
