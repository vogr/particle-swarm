#include <stdio.h>

#include "dgetrs.h"
#include "dlaswp.h"
#include "dtrsm.h"

int dgetrs_1(int N, double *A, int *ipiv, double *b)
{
  // A now contains L (below diagonal)
  //                U (above diagonal)
  // Swap pivot rows in b
  dlaswp_1(1, b, 1, 0, N, ipiv, 1);

#if DEBUG_LU_SOLVER
  printf("B: ");
  for (int i = 0; i < N; ++i)
    printf("%.4f  ", b[i]);
  printf("\n");
#endif

  // Forward substitution
  dtrsm_L_1(N, 1, A, N, b, 1);
  // Backward substitution
  dtrsm_U_1(N, 1, A, N, b, 1);
  return 0;
}

int dgetrs_2(int N, double *A, int *ipiv, double *b)
{
  dlaswp_2(1, b, 1, 0, N, ipiv, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Swapped\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Forward substitution
  dtrsm_L_2(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB forward\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Backward substitution
  dtrsm_U_2(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB solved\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  return 0;
}

int dgetrs_5(int N, double *A, int *ipiv, double *b)
{
  dlaswp_5(1, b, 1, 0, N, ipiv, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Swapped\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Forward substitution
  dtrsm_L_5(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Forward\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Backward substitution
  dtrsm_U_5(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Solved\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  return 0;
}

int dgetrs_6(int N, double *A, int *ipiv, double *b)
{
  // A now contains L (below diagonal)
  //                U (above diagonal)
  // Swap pivot rows in b
  dlaswp_6(1, b, 1, 0, N, ipiv, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Swapped\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Forward substitution
  dtrsm_L_6(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Forward\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  // Backward substitution
  dtrsm_U_6(N, 1, A, N, b, 1);
#ifdef DEBUG_LU_SOLVER
  printf("\nB Solved\n");
  for (int i = 0; i < N; ++i)
    printf("%.4f\n", b[i]);
#endif
  return 0;
}
