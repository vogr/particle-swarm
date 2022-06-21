#include <assert.h>
#include <math.h>

#include "../helpers.h"
#include "dtrsm.h"

// ------------------------
// Lower Triangular DTRSM_L
// ------------------------

// A is a lower / left / unit / *transposed* matrix
void dtrsm_L_1(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = 0; k < M; ++k)
    {
      if (!APPROX_EQUAL(MIX(B, LDB, k, j), 0.))
      {
        for (i = k + 1; i < M; ++i)
        {
          MIX(B, LDB, i, j) =
              MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
        }
      }
    }
  }
}

void dtrsm_L_2(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = 0; k < M; ++k)
    {
      for (i = k + 1; i < M; ++i)
      {
        MIX(B, LDB, i, j) =
            MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
      }
    }
  }
}

void dtrsm_L_5(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = 0; k < M; ++k)
      for (i = k + 1; i < M; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
}

void dtrsm_L_6(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = 0; k < M; ++k)
      for (i = k + 1; i < M; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
}

// ---------------------------
// Upper Triangular DTRSM_U
// ---------------------------

// A is a upper / left / non-unit / *transposed* matrix
void dtrsm_U_1(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = M - 1; k >= 0; --k)
    {
      if (!APPROX_EQUAL(MIX(B, LDB, k, j), 0.))
      {
        MIX(B, LDB, k, j) = MIX(B, LDB, k, j) / MIX(A, LDA, k, k);
        for (i = 0; i < k; ++i)
        {
          MIX(B, LDB, i, j) =
              MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
        }
      }
    }
  }
}

void dtrsm_U_2(int M, int N, double *A, int LDA, double *B, int LDB)
{
  int i, j, k;

  for (j = 0; j < N; ++j)
  {
    for (k = M - 1; k >= 0; --k)
    {
      MIX(B, LDB, k, j) = MIX(B, LDB, k, j) / MIX(A, LDA, k, k);
      for (i = 0; i < k; ++i)
      {
        MIX(B, LDB, i, j) =
            MIX(B, LDB, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
      }
    }
  }
}

void dtrsm_U_5(int M, int N, double *A, int LDA, double *B, int LDB)
{
  // TODO
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = M - 1; k >= 0; --k)
    {
      TIX(B, LDB, k, j) = TIX(B, LDB, k, j) / TIX(A, LDA, k, k);
      for (i = 0; i < k; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
    }
}

void dtrsm_U_6(int M, int N, double *A, int LDA, double *B, int LDB)
{
  // TODO
  int i, j, k;

  for (j = 0; j < N; ++j)
    for (k = M - 1; k >= 0; --k)
    {
      TIX(B, LDB, k, j) = TIX(B, LDB, k, j) / TIX(A, LDA, k, k);
      for (i = 0; i < k; ++i)
        TIX(B, LDB, i, j) =
            TIX(B, LDB, i, j) - TIX(B, LDB, k, j) * TIX(A, LDA, i, k);
    }
}
