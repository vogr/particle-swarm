
#include "helpers.h"

#include <stdio.h>

void print_matrixd(double const * M, int N, char const *name)
{
  printf("%s = [\n", name);
  int i, j;
  for (i = 0; i < N; i++)
  {
    for (j = 0; j < N; j++)
      printf("%.3f ", M[N * i + j]);
    printf("\n");
  }
  printf("]\n");
}

void print_vectord(double const * M, int N, char const * name)
{
  printf("%s = [", name);
  int i;
  for (i = 0; i < N; i++)
  {
    printf("%.4f", M[i]);
    if (i < N - 1) printf(", ");
  }
  printf("]\n");
}

void print_vectori(int const * M, int N, char const * name)
{
  printf("%s = [", name);
  int i;
  for (i = 0; i < N; i++)
  {
    printf("%d", M[i]);
    if (i < N - 1) printf(", ");
  }
  printf("]\n");
}