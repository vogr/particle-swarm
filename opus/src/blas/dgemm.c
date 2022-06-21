#include "dgemm.h"

#include <assert.h>
#include <immintrin.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef TEST_MKL
#include "mkl.h"
#endif

#ifdef TEST_PERF
#include "../perf_testers/perf_mmm.h"
#endif

#include "../helpers.h"

// M N K block sizes for scratch buffers
#ifndef M_BLOCK
#define M_BLOCK 192
#endif
#ifndef N_BLOCK
#define N_BLOCK 2048
#endif
#ifndef K_BLOCK
#define K_BLOCK 384
#endif

static double *scratch_a;
static double *scratch_b;

void dgemm_initialize_memory(int max_n)
{
  // XXX align the scratch buffers to the page size to avoid any potential
  // page misses.
  scratch_a = (double *)aligned_alloc(
      4096, (M_BLOCK * K_BLOCK * sizeof(double) + 4095) & -4096);
  scratch_b = (double *)aligned_alloc(
      4096, (K_BLOCK * N_BLOCK * sizeof(double) + 4095) & -4096);
}

void dgemm_free_memory()
{
  free(scratch_a);
  free(scratch_b);
}

void dgemm_1(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC)
{

  // NOTE as written below, we specialize to alpha = -1 beta = 1
  assert(APPROX_EQUAL(beta, ONE));
  assert(APPROX_EQUAL(alpha, -ONE));

  int i, j, k;
  double acc;

  for (i = 0; i < M; ++i)
    for (j = 0; j < N; ++j)
    {
      // BETA = 1
      acc = MIX(C, LDC, i, j);
      for (k = 0; k < K; ++k)
        acc += alpha * MIX(A, LDA, i, k) * MIX(B, LDB, k, j);
      MIX(C, LDC, i, j) = acc;
    }
}

void dgemm_1T(int M, int N, int K, double alpha, double *A, int LDA, double *B,
              int LDB, double beta, double *C, int LDC)
{

  // NOTE as written below, we specialize to alpha = -1 beta = 1
  assert(APPROX_EQUAL(beta, ONE));
  assert(APPROX_EQUAL(alpha, -ONE));

  int i, j, k;
  double acc;

  for (i = 0; i < M; ++i)
    for (j = 0; j < N; ++j)
    {
      // BETA = 1
      acc = TIX(C, LDC, i, j);
      for (k = 0; k < K; ++k)
        acc += alpha * TIX(A, LDA, i, k) * TIX(B, LDB, k, j);
      TIX(C, LDC, i, j) = acc;
    }
}

void dgemm_2(int M, int N, int K, double alpha, double *restrict A, int LDA,
             double *restrict B, int LDB, double beta, double *restrict C,
             int LDC)
{

  /**
   * A[ M x K ] * B[ K x N ] = C[ M x N ]
   */

  // NOTE as written below, we specialize to alpha = -1 beta = 1
  assert(APPROX_EQUAL(beta, ONE));
  assert(APPROX_EQUAL(alpha, -ONE));

  // ---------------
  // https://en.wikichip.org/wiki/intel/microarchitectures/skylake_(client)
  //
  // NOTE Skylake has a 32000 B L1 cache
  // With cache lines of 64 B

  const int NB = 56;
  const int MB = 56;
  const int KB = 56;
#define DBL_LMT (512 * 2)

  // NOTE choose MU + NU + MU * NU <= 16
  const int MU = 4;
  const int NU = 2;
  const int KU = 8;

  int i, j, k,      //
      ii, jj, kk,   //
      iii, jjj, kkk //
      ;

  i = 0;
  ii = 0;
  iii = 0;

  j = 0;
  jj = 0;
  jjj = 0;

  k = 0;
  kk = 0;
  kkk = 0;

  double             //
      A_iii_0_kkk_0, //
      A_iii_0_kkk_1, //
      A_iii_0_kkk_2, //
      A_iii_0_kkk_3, //
      A_iii_0_kkk_4, //
      A_iii_0_kkk_5, //
      A_iii_0_kkk_6, //
      A_iii_0_kkk_7, //

      A_iii_1_kkk_0, //
      A_iii_1_kkk_1, //
      A_iii_1_kkk_2, //
      A_iii_1_kkk_3, //
      A_iii_1_kkk_4, //
      A_iii_1_kkk_5, //
      A_iii_1_kkk_6, //
      A_iii_1_kkk_7, //

      A_iii_2_kkk_0, //
      A_iii_2_kkk_1, //
      A_iii_2_kkk_2, //
      A_iii_2_kkk_3, //
      A_iii_2_kkk_4, //
      A_iii_2_kkk_5, //
      A_iii_2_kkk_6, //
      A_iii_2_kkk_7, //

      A_iii_3_kkk_0, //
      A_iii_3_kkk_1, //
      A_iii_3_kkk_2, //
      A_iii_3_kkk_3, //
      A_iii_3_kkk_4, //
      A_iii_3_kkk_5, //
      A_iii_3_kkk_6, //
      A_iii_3_kkk_7, //
      A_iii_3_kkk_8, //

      C_iii_0_jjj_0, //
      C_iii_0_jjj_1, //
      C_iii_1_jjj_0, //
      C_iii_1_jjj_1, //
      C_iii_2_jjj_0, //
      C_iii_2_jjj_1, //
      C_iii_3_jjj_0, //
      C_iii_3_jjj_1, //

      B_kkk_0_jjj_0, //
      B_kkk_0_jjj_1, //
      B_kkk_1_jjj_0, //
      B_kkk_1_jjj_1, //
      B_kkk_2_jjj_0, //
      B_kkk_2_jjj_1, //
      B_kkk_3_jjj_0, //
      B_kkk_3_jjj_1, //
      B_kkk_4_jjj_0, //
      B_kkk_4_jjj_1, //
      B_kkk_5_jjj_0, //
      B_kkk_5_jjj_1, //
      B_kkk_6_jjj_0, //
      B_kkk_6_jjj_1, //
      B_kkk_7_jjj_0, //
      B_kkk_7_jjj_1  //

      ;

  // -----------------------------------------------------------------
  // Basic unrolled MMM with no register blocking

  // NOTE this should be our case as the incoming matrix A is tall and skinny.
  // i blocked
  for (i = 0; i <= M - MB; i += MB)
  {
    // j blocked
    for (j = 0; j <= N - NB; j += NB)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)
          for (jj = j; jj <= (j + NB) - NU; jj += NU)
            for (kk = k; kk <= (k + KB) - KU; kk += KU)

            /* // Register blocking */
            /* for (kkk = kk; kkk < kk + KU; ++kkk) */
            /*   for (iii = ii; iii < ii + MU; ++iii) */
            /*     for (jjj = jj; jjj < jj + NU; ++jjj) */
            {

              // FIXME reorder stores and loads

              C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, jj + 0);
              C_iii_0_jjj_1 = MIX(C, LDC, ii + 0, jj + 1);
              C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, jj + 0);
              C_iii_1_jjj_1 = MIX(C, LDC, ii + 1, jj + 1);
              C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, jj + 0);
              C_iii_2_jjj_1 = MIX(C, LDC, ii + 2, jj + 1);
              C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, jj + 0);
              C_iii_3_jjj_1 = MIX(C, LDC, ii + 3, jj + 1);

              B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, jj + 0);
              B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, jj + 0);
              B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, jj + 0);
              B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, jj + 0);
              B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, jj + 0);
              B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, jj + 0);
              B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, jj + 0);
              B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, jj + 0);

              B_kkk_0_jjj_1 = MIX(B, LDB, kk + 0, jj + 1);
              B_kkk_1_jjj_1 = MIX(B, LDB, kk + 1, jj + 1);
              B_kkk_2_jjj_1 = MIX(B, LDB, kk + 2, jj + 1);
              B_kkk_3_jjj_1 = MIX(B, LDB, kk + 3, jj + 1);
              B_kkk_4_jjj_1 = MIX(B, LDB, kk + 4, jj + 1);
              B_kkk_5_jjj_1 = MIX(B, LDB, kk + 5, jj + 1);
              B_kkk_6_jjj_1 = MIX(B, LDB, kk + 6, jj + 1);
              B_kkk_7_jjj_1 = MIX(B, LDB, kk + 7, jj + 1);

              A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, kk + 0);
              A_iii_0_kkk_1 = MIX(A, LDA, ii + 0, kk + 1);
              A_iii_0_kkk_2 = MIX(A, LDA, ii + 0, kk + 2);
              A_iii_0_kkk_3 = MIX(A, LDA, ii + 0, kk + 3);
              A_iii_0_kkk_4 = MIX(A, LDA, ii + 0, kk + 4);
              A_iii_0_kkk_5 = MIX(A, LDA, ii + 0, kk + 5);
              A_iii_0_kkk_6 = MIX(A, LDA, ii + 0, kk + 6);
              A_iii_0_kkk_7 = MIX(A, LDA, ii + 0, kk + 7);

              A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, kk + 0);
              A_iii_1_kkk_1 = MIX(A, LDA, ii + 1, kk + 1);
              A_iii_1_kkk_2 = MIX(A, LDA, ii + 1, kk + 2);
              A_iii_1_kkk_3 = MIX(A, LDA, ii + 1, kk + 3);
              A_iii_1_kkk_4 = MIX(A, LDA, ii + 1, kk + 4);
              A_iii_1_kkk_5 = MIX(A, LDA, ii + 1, kk + 5);
              A_iii_1_kkk_6 = MIX(A, LDA, ii + 1, kk + 6);
              A_iii_1_kkk_7 = MIX(A, LDA, ii + 1, kk + 7);

              A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, kk + 0);
              A_iii_2_kkk_1 = MIX(A, LDA, ii + 2, kk + 1);
              A_iii_2_kkk_2 = MIX(A, LDA, ii + 2, kk + 2);
              A_iii_2_kkk_3 = MIX(A, LDA, ii + 2, kk + 3);
              A_iii_2_kkk_4 = MIX(A, LDA, ii + 2, kk + 4);
              A_iii_2_kkk_5 = MIX(A, LDA, ii + 2, kk + 5);
              A_iii_2_kkk_6 = MIX(A, LDA, ii + 2, kk + 6);
              A_iii_2_kkk_7 = MIX(A, LDA, ii + 2, kk + 7);

              A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, kk + 0);
              A_iii_3_kkk_1 = MIX(A, LDA, ii + 3, kk + 1);
              A_iii_3_kkk_2 = MIX(A, LDA, ii + 3, kk + 2);
              A_iii_3_kkk_3 = MIX(A, LDA, ii + 3, kk + 3);
              A_iii_3_kkk_4 = MIX(A, LDA, ii + 3, kk + 4);
              A_iii_3_kkk_5 = MIX(A, LDA, ii + 3, kk + 5);
              A_iii_3_kkk_6 = MIX(A, LDA, ii + 3, kk + 6);
              A_iii_3_kkk_7 = MIX(A, LDA, ii + 3, kk + 7);
              A_iii_3_kkk_8 = MIX(A, LDA, ii + 3, kk + 8);

              // ------

              C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
              C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;
              C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
              C_iii_1_jjj_1 -= B_kkk_0_jjj_1 * A_iii_1_kkk_0;
              C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
              C_iii_2_jjj_1 -= B_kkk_0_jjj_1 * A_iii_2_kkk_0;
              C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;
              C_iii_3_jjj_1 -= B_kkk_0_jjj_1 * A_iii_3_kkk_0;

              C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
              C_iii_0_jjj_1 -= B_kkk_1_jjj_1 * A_iii_0_kkk_1;
              C_iii_1_jjj_0 -= B_kkk_1_jjj_0 * A_iii_1_kkk_1;
              C_iii_1_jjj_1 -= B_kkk_1_jjj_1 * A_iii_1_kkk_1;
              C_iii_2_jjj_0 -= B_kkk_1_jjj_0 * A_iii_2_kkk_1;
              C_iii_2_jjj_1 -= B_kkk_1_jjj_1 * A_iii_2_kkk_1;
              C_iii_3_jjj_0 -= B_kkk_1_jjj_0 * A_iii_3_kkk_1;
              C_iii_3_jjj_1 -= B_kkk_1_jjj_1 * A_iii_3_kkk_1;

              C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
              C_iii_0_jjj_1 -= B_kkk_2_jjj_1 * A_iii_0_kkk_2;
              C_iii_1_jjj_0 -= B_kkk_2_jjj_0 * A_iii_1_kkk_2;
              C_iii_1_jjj_1 -= B_kkk_2_jjj_1 * A_iii_1_kkk_2;
              C_iii_2_jjj_0 -= B_kkk_2_jjj_0 * A_iii_2_kkk_2;
              C_iii_2_jjj_1 -= B_kkk_2_jjj_1 * A_iii_2_kkk_2;
              C_iii_3_jjj_0 -= B_kkk_2_jjj_0 * A_iii_3_kkk_2;
              C_iii_3_jjj_1 -= B_kkk_2_jjj_1 * A_iii_3_kkk_2;

              C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
              C_iii_0_jjj_1 -= B_kkk_3_jjj_1 * A_iii_0_kkk_3;
              C_iii_1_jjj_0 -= B_kkk_3_jjj_0 * A_iii_1_kkk_3;
              C_iii_1_jjj_1 -= B_kkk_3_jjj_1 * A_iii_1_kkk_3;
              C_iii_2_jjj_0 -= B_kkk_3_jjj_0 * A_iii_2_kkk_3;
              C_iii_2_jjj_1 -= B_kkk_3_jjj_1 * A_iii_2_kkk_3;
              C_iii_3_jjj_0 -= B_kkk_3_jjj_0 * A_iii_3_kkk_3;
              C_iii_3_jjj_1 -= B_kkk_3_jjj_1 * A_iii_3_kkk_3;

              C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
              C_iii_0_jjj_1 -= B_kkk_4_jjj_1 * A_iii_0_kkk_4;
              C_iii_1_jjj_0 -= B_kkk_4_jjj_0 * A_iii_1_kkk_4;
              C_iii_1_jjj_1 -= B_kkk_4_jjj_1 * A_iii_1_kkk_4;
              C_iii_2_jjj_0 -= B_kkk_4_jjj_0 * A_iii_2_kkk_4;
              C_iii_2_jjj_1 -= B_kkk_4_jjj_1 * A_iii_2_kkk_4;
              C_iii_3_jjj_0 -= B_kkk_4_jjj_0 * A_iii_3_kkk_4;
              C_iii_3_jjj_1 -= B_kkk_4_jjj_1 * A_iii_3_kkk_4;

              C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
              C_iii_0_jjj_1 -= B_kkk_5_jjj_1 * A_iii_0_kkk_5;
              C_iii_1_jjj_0 -= B_kkk_5_jjj_0 * A_iii_1_kkk_5;
              C_iii_1_jjj_1 -= B_kkk_5_jjj_1 * A_iii_1_kkk_5;
              C_iii_2_jjj_0 -= B_kkk_5_jjj_0 * A_iii_2_kkk_5;
              C_iii_2_jjj_1 -= B_kkk_5_jjj_1 * A_iii_2_kkk_5;
              C_iii_3_jjj_0 -= B_kkk_5_jjj_0 * A_iii_3_kkk_5;
              C_iii_3_jjj_1 -= B_kkk_5_jjj_1 * A_iii_3_kkk_5;

              C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
              C_iii_0_jjj_1 -= B_kkk_6_jjj_1 * A_iii_0_kkk_6;
              C_iii_1_jjj_0 -= B_kkk_6_jjj_0 * A_iii_1_kkk_6;
              C_iii_1_jjj_1 -= B_kkk_6_jjj_1 * A_iii_1_kkk_6;
              C_iii_2_jjj_0 -= B_kkk_6_jjj_0 * A_iii_2_kkk_6;
              C_iii_2_jjj_1 -= B_kkk_6_jjj_1 * A_iii_2_kkk_6;
              C_iii_3_jjj_0 -= B_kkk_6_jjj_0 * A_iii_3_kkk_6;
              C_iii_3_jjj_1 -= B_kkk_6_jjj_1 * A_iii_3_kkk_6;

              C_iii_0_jjj_1 -= B_kkk_7_jjj_1 * A_iii_0_kkk_7;
              C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;
              C_iii_1_jjj_1 -= B_kkk_7_jjj_1 * A_iii_1_kkk_7;
              C_iii_1_jjj_0 -= B_kkk_7_jjj_0 * A_iii_1_kkk_7;
              C_iii_2_jjj_0 -= B_kkk_7_jjj_0 * A_iii_2_kkk_7;
              C_iii_2_jjj_1 -= B_kkk_7_jjj_1 * A_iii_2_kkk_7;
              C_iii_3_jjj_0 -= B_kkk_7_jjj_0 * A_iii_3_kkk_7;
              C_iii_3_jjj_1 -= B_kkk_7_jjj_1 * A_iii_3_kkk_7;

              // -----

              MIX(C, LDC, ii + 0, jj + 0) = C_iii_0_jjj_0;
              MIX(C, LDC, ii + 0, jj + 1) = C_iii_0_jjj_1;
              MIX(C, LDC, ii + 1, jj + 0) = C_iii_1_jjj_0;
              MIX(C, LDC, ii + 1, jj + 1) = C_iii_1_jjj_1;
              MIX(C, LDC, ii + 2, jj + 0) = C_iii_2_jjj_0;
              MIX(C, LDC, ii + 2, jj + 1) = C_iii_2_jjj_1;
              MIX(C, LDC, ii + 3, jj + 0) = C_iii_3_jjj_0;
              MIX(C, LDC, ii + 3, jj + 1) = C_iii_3_jjj_1;
            }

      // k overflow
      for (; k < K; ++k)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)
          for (jj = j; jj <= (j + NB) - NU; jj += NU)
          /* // Registier blocking */
          /* for (iii = ii; iii < ii + MU; ++iii) */
          /*   for (jjj = jj; jjj < jj + NU; ++jjj) */
          {
            C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, jj + 0);
            C_iii_0_jjj_1 = MIX(C, LDC, ii + 0, jj + 1);

            C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, jj + 0);
            C_iii_1_jjj_1 = MIX(C, LDC, ii + 1, jj + 1);

            C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, jj + 0);
            C_iii_2_jjj_1 = MIX(C, LDC, ii + 2, jj + 1);

            C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, jj + 0);
            C_iii_3_jjj_1 = MIX(C, LDC, ii + 3, jj + 1);

            B_kkk_0_jjj_0 = MIX(B, LDB, k + 0, jj + 0);
            B_kkk_0_jjj_1 = MIX(B, LDB, k + 0, jj + 1);

            A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, k + 0);
            A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, k + 0);
            A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, k + 0);
            A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, k + 0);

            // ----

            C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
            C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;
            C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
            C_iii_1_jjj_1 -= B_kkk_0_jjj_1 * A_iii_1_kkk_0;
            C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
            C_iii_2_jjj_1 -= B_kkk_0_jjj_1 * A_iii_2_kkk_0;
            C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;
            C_iii_3_jjj_1 -= B_kkk_0_jjj_1 * A_iii_3_kkk_0;

            // ----

            MIX(C, LDC, ii + 0, jj + 0) = C_iii_0_jjj_0;
            MIX(C, LDC, ii + 0, jj + 1) = C_iii_0_jjj_1;
            MIX(C, LDC, ii + 1, jj + 0) = C_iii_1_jjj_0;
            MIX(C, LDC, ii + 1, jj + 1) = C_iii_1_jjj_1;
            MIX(C, LDC, ii + 2, jj + 0) = C_iii_2_jjj_0;
            MIX(C, LDC, ii + 2, jj + 1) = C_iii_2_jjj_1;
            MIX(C, LDC, ii + 3, jj + 0) = C_iii_3_jjj_0;
            MIX(C, LDC, ii + 3, jj + 1) = C_iii_3_jjj_1;
          }
    }

    // j overflow
    for (; j < N; ++j)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)
          for (kk = k; kk <= (k + KB) - KU; kk += KU)

          // Registier blocking
          /* for (kkk = kk; kkk < kk + KU; ++kkk) */
          /*   for (iii = ii; iii < ii + MU; ++iii) */
          {

            C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, j + 0);
            C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, j + 0);
            C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, j + 0);
            C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, j + 0);

            B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, j + 0);
            B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, j + 0);
            B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, j + 0);
            B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, j + 0);
            B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, j + 0);
            B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, j + 0);
            B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, j + 0);
            B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, j + 0);

            A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, kk + 0);
            A_iii_0_kkk_1 = MIX(A, LDA, ii + 0, kk + 1);
            A_iii_0_kkk_2 = MIX(A, LDA, ii + 0, kk + 2);
            A_iii_0_kkk_3 = MIX(A, LDA, ii + 0, kk + 3);
            A_iii_0_kkk_4 = MIX(A, LDA, ii + 0, kk + 4);
            A_iii_0_kkk_5 = MIX(A, LDA, ii + 0, kk + 5);
            A_iii_0_kkk_6 = MIX(A, LDA, ii + 0, kk + 6);
            A_iii_0_kkk_7 = MIX(A, LDA, ii + 0, kk + 7);

            A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, kk + 0);
            A_iii_1_kkk_1 = MIX(A, LDA, ii + 1, kk + 1);
            A_iii_1_kkk_2 = MIX(A, LDA, ii + 1, kk + 2);
            A_iii_1_kkk_3 = MIX(A, LDA, ii + 1, kk + 3);
            A_iii_1_kkk_4 = MIX(A, LDA, ii + 1, kk + 4);
            A_iii_1_kkk_5 = MIX(A, LDA, ii + 1, kk + 5);
            A_iii_1_kkk_6 = MIX(A, LDA, ii + 1, kk + 6);
            A_iii_1_kkk_7 = MIX(A, LDA, ii + 1, kk + 7);

            A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, kk + 0);
            A_iii_2_kkk_1 = MIX(A, LDA, ii + 2, kk + 1);
            A_iii_2_kkk_2 = MIX(A, LDA, ii + 2, kk + 2);
            A_iii_2_kkk_3 = MIX(A, LDA, ii + 2, kk + 3);
            A_iii_2_kkk_4 = MIX(A, LDA, ii + 2, kk + 4);
            A_iii_2_kkk_5 = MIX(A, LDA, ii + 2, kk + 5);
            A_iii_2_kkk_6 = MIX(A, LDA, ii + 2, kk + 6);
            A_iii_2_kkk_7 = MIX(A, LDA, ii + 2, kk + 7);

            A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, kk + 0);
            A_iii_3_kkk_1 = MIX(A, LDA, ii + 3, kk + 1);
            A_iii_3_kkk_2 = MIX(A, LDA, ii + 3, kk + 2);
            A_iii_3_kkk_3 = MIX(A, LDA, ii + 3, kk + 3);
            A_iii_3_kkk_4 = MIX(A, LDA, ii + 3, kk + 4);
            A_iii_3_kkk_5 = MIX(A, LDA, ii + 3, kk + 5);
            A_iii_3_kkk_6 = MIX(A, LDA, ii + 3, kk + 6);
            A_iii_3_kkk_7 = MIX(A, LDA, ii + 3, kk + 7);
            A_iii_3_kkk_8 = MIX(A, LDA, ii + 3, kk + 8);

            // ------

            C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
            C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
            C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
            C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;

            C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
            C_iii_1_jjj_0 -= B_kkk_1_jjj_0 * A_iii_1_kkk_1;
            C_iii_2_jjj_0 -= B_kkk_1_jjj_0 * A_iii_2_kkk_1;
            C_iii_3_jjj_0 -= B_kkk_1_jjj_0 * A_iii_3_kkk_1;

            C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
            C_iii_1_jjj_0 -= B_kkk_2_jjj_0 * A_iii_1_kkk_2;
            C_iii_2_jjj_0 -= B_kkk_2_jjj_0 * A_iii_2_kkk_2;
            C_iii_3_jjj_0 -= B_kkk_2_jjj_0 * A_iii_3_kkk_2;

            C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
            C_iii_1_jjj_0 -= B_kkk_3_jjj_0 * A_iii_1_kkk_3;
            C_iii_2_jjj_0 -= B_kkk_3_jjj_0 * A_iii_2_kkk_3;
            C_iii_3_jjj_0 -= B_kkk_3_jjj_0 * A_iii_3_kkk_3;

            C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
            C_iii_1_jjj_0 -= B_kkk_4_jjj_0 * A_iii_1_kkk_4;
            C_iii_2_jjj_0 -= B_kkk_4_jjj_0 * A_iii_2_kkk_4;
            C_iii_3_jjj_0 -= B_kkk_4_jjj_0 * A_iii_3_kkk_4;

            C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
            C_iii_1_jjj_0 -= B_kkk_5_jjj_0 * A_iii_1_kkk_5;
            C_iii_2_jjj_0 -= B_kkk_5_jjj_0 * A_iii_2_kkk_5;
            C_iii_3_jjj_0 -= B_kkk_5_jjj_0 * A_iii_3_kkk_5;

            C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
            C_iii_1_jjj_0 -= B_kkk_6_jjj_0 * A_iii_1_kkk_6;
            C_iii_2_jjj_0 -= B_kkk_6_jjj_0 * A_iii_2_kkk_6;
            C_iii_3_jjj_0 -= B_kkk_6_jjj_0 * A_iii_3_kkk_6;

            C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;
            C_iii_1_jjj_0 -= B_kkk_7_jjj_0 * A_iii_1_kkk_7;
            C_iii_2_jjj_0 -= B_kkk_7_jjj_0 * A_iii_2_kkk_7;
            C_iii_3_jjj_0 -= B_kkk_7_jjj_0 * A_iii_3_kkk_7;

            // -----

            MIX(C, LDC, ii + 0, j + 0) = C_iii_0_jjj_0;
            MIX(C, LDC, ii + 1, j + 0) = C_iii_1_jjj_0;
            MIX(C, LDC, ii + 2, j + 0) = C_iii_2_jjj_0;
            MIX(C, LDC, ii + 3, j + 0) = C_iii_3_jjj_0;
          }

      // k overflow
      for (; k < K; ++k)

        // Cache blocking
        for (ii = i; ii <= (i + MB) - MU; ii += MU)

        // Register blocking
        /* for (iii = ii; iii < ii + MU; ++iii) */
        {
          C_iii_0_jjj_0 = MIX(C, LDC, ii + 0, j + 0);
          C_iii_1_jjj_0 = MIX(C, LDC, ii + 1, j + 0);
          C_iii_2_jjj_0 = MIX(C, LDC, ii + 2, j + 0);
          C_iii_3_jjj_0 = MIX(C, LDC, ii + 3, j + 0);

          B_kkk_0_jjj_0 = MIX(B, LDB, k + 0, j + 0);

          A_iii_0_kkk_0 = MIX(A, LDA, ii + 0, k + 0);
          A_iii_1_kkk_0 = MIX(A, LDA, ii + 1, k + 0);
          A_iii_2_kkk_0 = MIX(A, LDA, ii + 2, k + 0);
          A_iii_3_kkk_0 = MIX(A, LDA, ii + 3, k + 0);

          // ------

          C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
          C_iii_1_jjj_0 -= B_kkk_0_jjj_0 * A_iii_1_kkk_0;
          C_iii_2_jjj_0 -= B_kkk_0_jjj_0 * A_iii_2_kkk_0;
          C_iii_3_jjj_0 -= B_kkk_0_jjj_0 * A_iii_3_kkk_0;

          // -----

          MIX(C, LDC, ii + 0, j + 0) = C_iii_0_jjj_0;
          MIX(C, LDC, ii + 1, j + 0) = C_iii_1_jjj_0;
          MIX(C, LDC, ii + 2, j + 0) = C_iii_2_jjj_0;
          MIX(C, LDC, ii + 3, j + 0) = C_iii_3_jjj_0;
        }
    }
  }

  // i overflow
  for (; i < M; ++i)
  {
    // j blocked
    for (j = 0; j <= N - NB; j += NB)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (jj = j; jj <= (j + NB) - NU; jj += NU)
          for (kk = k; kk <= (k + KB) - KU; kk += KU)

          // Register blocking
          /* for (kkk = kk; kkk < kk + KU; ++kkk) */
          /*   for (jjj = jj; jjj < jj + NU; ++jjj) */
          {

            C_iii_0_jjj_0 = MIX(C, LDC, i + 0, jj + 0);
            C_iii_0_jjj_1 = MIX(C, LDC, i + 0, jj + 1);

            B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, jj + 0);
            B_kkk_0_jjj_1 = MIX(B, LDB, kk + 0, jj + 1);
            B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, jj + 0);
            B_kkk_1_jjj_1 = MIX(B, LDB, kk + 1, jj + 1);
            B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, jj + 0);
            B_kkk_2_jjj_1 = MIX(B, LDB, kk + 2, jj + 1);
            B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, jj + 0);
            B_kkk_3_jjj_1 = MIX(B, LDB, kk + 3, jj + 1);
            B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, jj + 0);
            B_kkk_4_jjj_1 = MIX(B, LDB, kk + 4, jj + 1);
            B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, jj + 0);
            B_kkk_5_jjj_1 = MIX(B, LDB, kk + 5, jj + 1);
            B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, jj + 0);
            B_kkk_6_jjj_1 = MIX(B, LDB, kk + 6, jj + 1);
            B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, jj + 0);
            B_kkk_7_jjj_1 = MIX(B, LDB, kk + 7, jj + 1);

            A_iii_0_kkk_0 = MIX(A, LDA, i + 0, kk + 0);
            A_iii_0_kkk_1 = MIX(A, LDA, i + 0, kk + 1);
            A_iii_0_kkk_2 = MIX(A, LDA, i + 0, kk + 2);
            A_iii_0_kkk_3 = MIX(A, LDA, i + 0, kk + 3);
            A_iii_0_kkk_4 = MIX(A, LDA, i + 0, kk + 4);
            A_iii_0_kkk_5 = MIX(A, LDA, i + 0, kk + 5);
            A_iii_0_kkk_6 = MIX(A, LDA, i + 0, kk + 6);
            A_iii_0_kkk_7 = MIX(A, LDA, i + 0, kk + 7);

            // ------

            C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
            C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;

            C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
            C_iii_0_jjj_1 -= B_kkk_1_jjj_1 * A_iii_0_kkk_1;

            C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
            C_iii_0_jjj_1 -= B_kkk_2_jjj_1 * A_iii_0_kkk_2;

            C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
            C_iii_0_jjj_1 -= B_kkk_3_jjj_1 * A_iii_0_kkk_3;

            C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
            C_iii_0_jjj_1 -= B_kkk_4_jjj_1 * A_iii_0_kkk_4;

            C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
            C_iii_0_jjj_1 -= B_kkk_5_jjj_1 * A_iii_0_kkk_5;

            C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
            C_iii_0_jjj_1 -= B_kkk_6_jjj_1 * A_iii_0_kkk_6;

            C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;
            C_iii_0_jjj_1 -= B_kkk_7_jjj_1 * A_iii_0_kkk_7;

            // -----

            MIX(C, LDC, i + 0, jj + 0) = C_iii_0_jjj_0;
            MIX(C, LDC, i + 0, jj + 1) = C_iii_0_jjj_1;
          }

      // k overflow
      for (; k < K; ++k)

        // Cache blocking
        for (jj = j; jj <= (j + NB) - NU; jj += NU)

        // Register blocking
        /* for (jjj = jj; jjj < jj + NU; ++jjj) */
        {

          C_iii_0_jjj_0 = MIX(C, LDC, i + 0, jj + 0);
          C_iii_0_jjj_1 = MIX(C, LDC, i + 0, jj + 1);

          B_kkk_0_jjj_0 = MIX(B, LDB, k + 0, jj + 0);
          B_kkk_0_jjj_1 = MIX(B, LDB, k + 0, jj + 1);

          A_iii_0_kkk_0 = MIX(A, LDA, i + 0, k + 0);

          // ------

          C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
          C_iii_0_jjj_1 -= B_kkk_0_jjj_1 * A_iii_0_kkk_0;

          // -----

          MIX(C, LDC, i + 0, jj + 0) = C_iii_0_jjj_0;
          MIX(C, LDC, i + 0, jj + 1) = C_iii_0_jjj_1;
        }
    }

    // j overflow
    for (; j < N; ++j)
    {

      // k blocked
      for (k = 0; k <= K - KB; k += NB)

        // Cache blocking
        for (kk = k; kk <= (k + KB) - KU; kk += KU)

        // Register blocking
        /* for (kkk = kk; kkk < kk + KU; ++kkk) */
        {
          C_iii_0_jjj_0 = MIX(C, LDC, i + 0, j + 0);

          B_kkk_0_jjj_0 = MIX(B, LDB, kk + 0, j + 0);
          B_kkk_1_jjj_0 = MIX(B, LDB, kk + 1, j + 0);
          B_kkk_2_jjj_0 = MIX(B, LDB, kk + 2, j + 0);
          B_kkk_3_jjj_0 = MIX(B, LDB, kk + 3, j + 0);
          B_kkk_4_jjj_0 = MIX(B, LDB, kk + 4, j + 0);
          B_kkk_5_jjj_0 = MIX(B, LDB, kk + 5, j + 0);
          B_kkk_6_jjj_0 = MIX(B, LDB, kk + 6, j + 0);
          B_kkk_7_jjj_0 = MIX(B, LDB, kk + 7, j + 0);

          A_iii_0_kkk_0 = MIX(A, LDA, i + 0, kk + 0);
          A_iii_0_kkk_1 = MIX(A, LDA, i + 0, kk + 1);
          A_iii_0_kkk_2 = MIX(A, LDA, i + 0, kk + 2);
          A_iii_0_kkk_3 = MIX(A, LDA, i + 0, kk + 3);
          A_iii_0_kkk_4 = MIX(A, LDA, i + 0, kk + 4);
          A_iii_0_kkk_5 = MIX(A, LDA, i + 0, kk + 5);
          A_iii_0_kkk_6 = MIX(A, LDA, i + 0, kk + 6);
          A_iii_0_kkk_7 = MIX(A, LDA, i + 0, kk + 7);

          // ------

          C_iii_0_jjj_0 -= B_kkk_0_jjj_0 * A_iii_0_kkk_0;
          C_iii_0_jjj_0 -= B_kkk_1_jjj_0 * A_iii_0_kkk_1;
          C_iii_0_jjj_0 -= B_kkk_2_jjj_0 * A_iii_0_kkk_2;
          C_iii_0_jjj_0 -= B_kkk_3_jjj_0 * A_iii_0_kkk_3;
          C_iii_0_jjj_0 -= B_kkk_4_jjj_0 * A_iii_0_kkk_4;
          C_iii_0_jjj_0 -= B_kkk_5_jjj_0 * A_iii_0_kkk_5;
          C_iii_0_jjj_0 -= B_kkk_6_jjj_0 * A_iii_0_kkk_6;
          C_iii_0_jjj_0 -= B_kkk_7_jjj_0 * A_iii_0_kkk_7;

          // -----

          MIX(C, LDC, i + 0, j + 0) = C_iii_0_jjj_0;
        }

      // k overflow
      for (; k < K; ++k)
        MIX(C, LDC, i, j) =
            MIX(C, LDC, i, j) - MIX(B, LDB, k, j) * MIX(A, LDA, i, k);
    }
  }

  return;
}

#ifdef TEST_MKL

void dgemm_intel(int M, int N, int K, double alpha, double *A, int LDA,
                 double *B, int LDB, double beta, double *C, int LDC)
{
  // Update trailing submatrix
  cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, M, N, K, alpha, A, LDA,
              B, LDB, beta, C, LDC);
}

#endif

// ** FOR TESTING **
// TODO DGEMM 3
void dgemm_3(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC)
{
  return;
}

// TODO DGEMM 4
void dgemm_4(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC)
{
  return;
}

// TODO DGEMM 5
void dgemm_5(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC)
{
  return;
}

// -------------
// DGEMM 6 helpers

#define B_SP(M, MB) ((M) & -(MB))
#define B_EQ(M, MB) ((M) == B_SP(M, MB))
#define for_bft(VAR, ST, DIM, B)                                               \
  for ((VAR) = (ST); (VAR) < B_SP(DIM, B); (VAR) += (B))
#define for_b(VAR, DIM, B) for_bft(VAR, 0, DIM, B)

// ----

#define INIT_8x4B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();                                               \
  c_i0_j2 = _mm256_setzero_pd();                                               \
  c_i0_j3 = _mm256_setzero_pd();                                               \
  c_i4_j0 = _mm256_setzero_pd();                                               \
  c_i4_j1 = _mm256_setzero_pd();                                               \
  c_i4_j2 = _mm256_setzero_pd();                                               \
  c_i4_j3 = _mm256_setzero_pd();

#define DO_8x4B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  a_i4_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 4));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i4_j0 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j0);                        \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j1);                        \
  c_i4_j1 = _mm256_fmadd_pd(a_i4_k0, b_k0_j1, c_i4_j1);                        \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 2));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 3));                                      \
  c_i0_j2 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j2);                        \
  c_i4_j2 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j2);                        \
  c_i0_j3 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j3);                        \
  c_i4_j3 = _mm256_fmadd_pd(a_i4_k0, b_k0_j1, c_i4_j3);                        \
  ++k, abuff += 8, bbuff += 4;

// clang-format off
#define STORE_8x4B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 0), _mm256_add_pd(c_i4_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 1), _mm256_add_pd(c_i4_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 2), _mm256_add_pd(c_i0_j2, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 2))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 2), _mm256_add_pd(c_i4_j2, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 2))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 3), _mm256_add_pd(c_i0_j3, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 3))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 3), _mm256_add_pd(c_i4_j3, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 3))));
// clang-format on

#define MICRO_8x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_8x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_8x4B;                                                                   \
    DO_8x4B;                                                                   \
    DO_8x4B;                                                                   \
    DO_8x4B;                                                                   \
  }                                                                            \
  for (; k < K;)                                                               \
  {                                                                            \
    DO_8x4B;                                                                   \
  }                                                                            \
  STORE_8x4B;

// ----

#define INIT_8x2B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i4_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();                                               \
  c_i4_j1 = _mm256_setzero_pd();

#define DO_8x2B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  a_i4_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 4));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i4_j0 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j0);                        \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j1);                        \
  c_i4_j1 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j1);                        \
  ++k, abuff += 8, bbuff += 2;

// clang-format off
#define STORE_8x2B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 0), _mm256_add_pd(c_i4_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 1), _mm256_add_pd(c_i4_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 1))));  \
// clang-format on

#define MICRO_8x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_8x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_8x2B;                                                                   \
    DO_8x2B;                                                                   \
    DO_8x2B;                                                                   \
    DO_8x2B;                                                                   \
  }                                                                            \
  for (; k < K;)                                                     \
  {                                                                            \
    DO_8x2B;                                                                   \
  }                                                                            \
  STORE_8x2B;

// ----

#define INIT_8x1B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i4_j0 = _mm256_setzero_pd();                                               \

#define DO_8x1B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  a_i4_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 4));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i4_j0 = _mm256_fmadd_pd(a_i4_k0, b_k0_j0, c_i4_j0);                        \
  ++k, abuff += 8, ++bbuff;

// clang-format off
#define STORE_8x1B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 4, j + 0), _mm256_add_pd(c_i4_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 4, j + 0))));
// clang-format on

#define MICRO_8x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_8x1B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_8x1B;                                                                   \
    DO_8x1B;                                                                   \
    DO_8x1B;                                                                   \
    DO_8x1B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_8x1B;                                                                   \
  }                                                                            \
  STORE_8x1B;

// ----

#define INIT_4x4B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();                                               \
  c_i0_j2 = _mm256_setzero_pd();                                               \
  c_i0_j3 = _mm256_setzero_pd();

#define DO_4x4B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
                                                                               \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j1);                        \
                                                                               \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 2));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 3));                                      \
  c_i0_j2 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j2);                        \
  c_i0_j3 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j3);                        \
  ++k, abuff += 4, bbuff += 4;

// clang-format off
#define STORE_4x4B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 2), _mm256_add_pd(c_i0_j2, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 2))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 3), _mm256_add_pd(c_i0_j3, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 3))));
// clang-format on

#define MICRO_4x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_4x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_4x4B;                                                                   \
    DO_4x4B;                                                                   \
    DO_4x4B;                                                                   \
    DO_4x4B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_4x4B;                                                                   \
  }                                                                            \
  STORE_4x4B;

// ----

#define INIT_4x2B                                                              \
  c_i0_j0 = _mm256_setzero_pd();                                               \
  c_i0_j1 = _mm256_setzero_pd();

#define DO_4x2B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  b_k0_j1 = _mm256_set1_pd(*(bbuff + 1));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  c_i0_j1 = _mm256_fmadd_pd(a_i0_k0, b_k0_j1, c_i0_j1);                        \
  ++k, abuff += 4, bbuff += 2;

// clang-format off
#define STORE_4x2B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm256_add_pd(c_i0_j1, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));
// clang-format on

#define MICRO_4x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_4x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_4x2B;                                                                   \
    DO_4x2B;                                                                   \
    DO_4x2B;                                                                   \
    DO_4x2B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_4x2B;                                                                   \
  }                                                                            \
  STORE_4x2B;

// ----

#define INIT_4x1B c_i0_j0 = _mm256_setzero_pd();

#define DO_4x1B                                                                \
  a_i0_k0 = _mm256_mul_pd(valpha, _mm256_loadu_pd(abuff + 0));                 \
  b_k0_j0 = _mm256_set1_pd(*(bbuff + 0));                                      \
  c_i0_j0 = _mm256_fmadd_pd(a_i0_k0, b_k0_j0, c_i0_j0);                        \
  ++k, abuff += 4, ++bbuff;

// clang-format off
#define STORE_4x1B                                                                                                    \
  _mm256_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm256_add_pd(c_i0_j0, _mm256_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));
// clang-format on

#define MICRO_4x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_4x1B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_4x1B;                                                                   \
    DO_4x1B;                                                                   \
    DO_4x1B;                                                                   \
    DO_4x1B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_4x1B;                                                                   \
  }                                                                            \
  STORE_4x1B;

// ----

#define INIT_2x4B                                                              \
  dc_i0_j0 = _mm_setzero_pd();                                                 \
  dc_i0_j1 = _mm_setzero_pd();                                                 \
  dc_i0_j2 = _mm_setzero_pd();                                                 \
  dc_i0_j3 = _mm_setzero_pd();

#define DO_2x4B                                                                \
  da_i0_k0 = _mm_mul_pd(dvalpha, _mm_load_pd(abuff + 0));                      \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 0));                                        \
  db_k0_j1 = _mm_set1_pd(*(bbuff + 1));                                        \
  dc_i0_j0 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j0);                       \
  dc_i0_j1 = _mm_fmadd_pd(da_i0_k0, db_k0_j1, dc_i0_j1);                       \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 2));                                        \
  db_k0_j1 = _mm_set1_pd(*(bbuff + 3));                                        \
  dc_i0_j2 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j2);                       \
  dc_i0_j3 = _mm_fmadd_pd(da_i0_k0, db_k0_j1, dc_i0_j3);                       \
  ++k, abuff += 2, bbuff += 4;

// clang-format off
#define STORE_2x4B                                                                                            \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm_add_pd(dc_i0_j0, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm_add_pd(dc_i0_j1, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 2), _mm_add_pd(dc_i0_j2, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 2))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 3), _mm_add_pd(dc_i0_j3, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 3))));
// clang-format on

#define MICRO_2x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_2x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_2x4B;                                                                   \
    DO_2x4B;                                                                   \
    DO_2x4B;                                                                   \
    DO_2x4B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_2x4B;                                                                   \
  }                                                                            \
  STORE_2x4B;

// ----

#define INIT_2x2B                                                              \
  dc_i0_j0 = _mm_setzero_pd();                                                 \
  dc_i0_j1 = _mm_setzero_pd();

#define DO_2x2B                                                                \
  da_i0_k0 = _mm_mul_pd(dvalpha, _mm_load_pd(abuff + 0));                      \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 0));                                        \
  db_k0_j1 = _mm_set1_pd(*(bbuff + 1));                                        \
  dc_i0_j0 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j0);                       \
  dc_i0_j1 = _mm_fmadd_pd(da_i0_k0, db_k0_j1, dc_i0_j1);                       \
  ++k, abuff += 2, bbuff += 2;

// clang-format off
#define STORE_2x2B                                                                                            \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm_add_pd(dc_i0_j0, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));  \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 1), _mm_add_pd(dc_i0_j1, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 1))));
// clang-format on

#define MICRO_2x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_2x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_2x2B;                                                                   \
    DO_2x2B;                                                                   \
    DO_2x2B;                                                                   \
    DO_2x2B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_2x2B;                                                                   \
  }                                                                            \
  STORE_2x2B;

// ----

#define INIT_2x1B                                                              \
  dc_i0_j0 = _mm_setzero_pd();                                                 \
  dc_i0_j1 = _mm_setzero_pd();

#define DO_2x1B                                                                \
  da_i0_k0 = _mm_mul_pd(dvalpha, _mm_load_pd(abuff + 0));                      \
  db_k0_j0 = _mm_set1_pd(*(bbuff + 0));                                        \
  dc_i0_j0 = _mm_fmadd_pd(da_i0_k0, db_k0_j0, dc_i0_j0);                       \
  ++k, abuff += 2, ++bbuff;

// clang-format off
#define STORE_2x1B                                                                                            \
  _mm_storeu_pd(&TIX(C, LDC, i + 0, j + 0), _mm_add_pd(dc_i0_j0, _mm_loadu_pd(&TIX(C, LDC, i + 0, j + 0))));
// clang-format on

#define MICRO_2x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_2x1B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_2x1B;                                                                   \
    DO_2x1B;                                                                   \
    DO_2x1B;                                                                   \
    DO_2x1B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_2x1B;                                                                   \
  }                                                                            \
  STORE_2x1B;

// -----

#define INIT_1x4B s_c0 = s_c1 = s_c2 = s_c3 = 0.;

#define DO_1x4B                                                                \
  s_a0 = *abuff;                                                               \
  s_b0 = *(bbuff + 0);                                                         \
  s_b1 = *(bbuff + 1);                                                         \
  s_c0 -= s_a0 * s_b0;                                                         \
  s_c1 -= s_a0 * s_b1;                                                         \
  s_b0 = *(bbuff + 2);                                                         \
  s_b1 = *(bbuff + 3);                                                         \
  s_c2 -= s_a0 * s_b0;                                                         \
  s_c3 -= s_a0 * s_b1;                                                         \
  ++k, ++abuff, bbuff += 4;

#define STORE_1x4B                                                             \
  TIX(C, LDC, i + 0, j + 0) += s_c0;                                           \
  TIX(C, LDC, i + 0, j + 1) += s_c1;                                           \
  TIX(C, LDC, i + 0, j + 2) += s_c2;                                           \
  TIX(C, LDC, i + 0, j + 3) += s_c3;

#define MICRO_1x4_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_1x4B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_1x4B;                                                                   \
    DO_1x4B;                                                                   \
    DO_1x4B;                                                                   \
    DO_1x4B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_1x4B;                                                                   \
  }                                                                            \
  STORE_1x4B;

// -----

#define INIT_1x2B s_c0 = s_c1 = 0.;

#define DO_1x2B                                                                \
  s_a0 = *abuff;                                                               \
  s_b0 = *(bbuff + 0);                                                         \
  s_b1 = *(bbuff + 1);                                                         \
  s_c0 -= s_a0 * s_b0;                                                         \
  s_c1 -= s_a0 * s_b1;                                                         \
  ++k, ++abuff, bbuff += 2;

#define STORE_1x2B                                                             \
  TIX(C, LDC, i + 0, j + 0) += s_c0;                                           \
  TIX(C, LDC, i + 0, j + 1) += s_c1;

#define MICRO_1x2_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_1x2B;                                                                   \
  for (k = 0; k < K4_MOD;)                                                     \
  {                                                                            \
    DO_1x2B;                                                                   \
    DO_1x2B;                                                                   \
    DO_1x2B;                                                                   \
    DO_1x2B;                                                                   \
  }                                                                            \
  for (k = K4_MOD; k < K;)                                                     \
  {                                                                            \
    DO_1x2B;                                                                   \
  }                                                                            \
  STORE_1x2B;

// -----

#define INIT_1x1B s_c0 = 0.;

#define DO_1x1B                                                                \
  s_a0 = *abuff;                                                               \
  s_b0 = *(bbuff + 0);                                                         \
  s_c0 -= s_a0 * s_b0;                                                         \
  ++k, ++abuff, ++bbuff;

#define STORE_1x1B TIX(C, LDC, i + 0, j + 0) += s_c0;

#define MICRO_1x1_MMM                                                          \
  abuff = A + i * K, bbuff = B + j * K;                                        \
  INIT_1x1B;                                                                   \
  for (k = 0; 0 && k < K4_MOD;)                                                \
  {                                                                            \
    DO_1x1B;                                                                   \
    DO_1x1B;                                                                   \
    DO_1x1B;                                                                   \
    DO_1x1B;                                                                   \
  }                                                                            \
  for (; k < K;)                                                               \
  {                                                                            \
    DO_1x1B;                                                                   \
  }                                                                            \
  STORE_1x1B;

// -----

// NOTE dgemm_6 assumes a TRANSPOSED memory layout
static void dgemm_6_mini(const int M, const int N, const int K,
                         double *restrict A, const int LDA, double *restrict B,
                         const int LDB, double *restrict C, const int LDC)
{
  int i, j, k;

  double *abuff, *bbuff;

  const int                  //
      M24_MOD = B_SP(M, 24), //
      M8_MOD = B_SP(M, 8),   //
      M4_MOD = B_SP(M, 4),   //
      M2_MOD = B_SP(M, 2),   //

      N4_MOD = B_SP(N, 4), //
      N2_MOD = B_SP(N, 2), //

      K4_MOD = B_SP(K, 4) //
      ;

  __m256d valpha = _mm256_set1_pd(-ONE); // broadcast alpha to a 256-bit vector
  __m128d dvalpha = _mm_set1_pd(-ONE);   // broadcast alpha to a 128-bit vector

  __m128d       //
      da_i0_k0, //
      da_i4_k0, //

      db_k0_j0, //
      db_k0_j1, //
      db_k0_j2, //
      db_k0_j3, //

      dc_i0_j0, //
      dc_i0_j1, //
      dc_i0_j2, //
      dc_i0_j3, //

      dc_i4_j0, //
      dc_i4_j1, //
      dc_i4_j2, //
      dc_i4_j3  //
      ;

  __m256d       //
      a_i0_k0,  //
      a_i4_k0,  //
      a_i8_k0,  //
      a_i12_k0, //
      a_i16_k0, //
      a_i20_k0, //

      b_k0_j0, //
      b_k0_j1, //

      c_i0_j0, //
      c_i0_j1, //
      c_i0_j2, //
      c_i0_j3, //

      c_i4_j0, //
      c_i4_j1, //
      c_i4_j2, //
      c_i4_j3  //

      ;

  double    //
      s_a0, //

      s_b0, //
      s_b1, //
      s_b2, //
      s_b3, //

      s_c0, //
      s_c1, //
      s_c2, //
      s_c3  //
      ;

  i = j = 0;

  for (; j < N4_MOD; j += 4)
  {
    for (i = 0; i < M8_MOD; i += 8)
    {
      MICRO_8x4_MMM;
    }
    for (; i < M4_MOD; i += 4)
    {
      MICRO_4x4_MMM;
    }
    for (; i < M2_MOD; i += 2)
    {
      MICRO_2x4_MMM;
    }
    for (; i < M; ++i)
    {
      MICRO_1x4_MMM;
    }
  }

  for (; j < N2_MOD; j += 2)
  {
    for (i = 0; i < M8_MOD; i += 8)
    {
      MICRO_8x2_MMM;
    }
    for (; i < M4_MOD; i += 4)
    {
      MICRO_4x2_MMM;
    }
    for (; i < M2_MOD; i += 2)
    {
      MICRO_2x2_MMM;
    }
    for (; i < M; ++i)
    {
      MICRO_1x2_MMM;
    }
  }

  for (; j < N; ++j)
  {
    for (i = 0; i < M8_MOD; i += 8)
    {
      MICRO_8x1_MMM;
    }
    for (; i < M4_MOD; i += 4)
    {
      MICRO_4x1_MMM;
    }
    for (; i < M2_MOD; i += 2)
    {
      MICRO_2x1_MMM;
    }
    for (; i < M; ++i)
    {
      MICRO_1x1_MMM;
    }
  }
}

static void pack_a(double *dst, double *src, int LDA, int M, int N)
{
  int i, j;
  double *s0, *d0 = dst;
  i = 0;

  __m256d psrc0, psrc4;

  for (; i < M - 7; i += 8)
  {
    s0 = src + i;
    for (j = 0; j < N; ++j, dst += 8, s0 += LDA)
    {
      psrc0 = _mm256_loadu_pd(s0 + 0);
      psrc4 = _mm256_loadu_pd(s0 + 4);
      _mm256_storeu_pd(dst + 0, psrc0);
      _mm256_storeu_pd(dst + 4, psrc4);
    }
  }

  for (; i < M - 3; i += 4)
  {
    s0 = src + i;
    for (j = 0; j < N; ++j, dst += 4, s0 += LDA)
    {
      psrc0 = _mm256_loadu_pd(s0 + 0);
      _mm256_storeu_pd(dst + 0, psrc0);
    }
  }

  for (; i < M - 1; i += 2)
  {
    // NOTE you could do this with an SSE instruction
    s0 = src + i;
    for (j = 0; j < N; ++j, dst += 2, s0 += LDA)
    {
      *dst = *s0;
      *(dst + 1) = *(s0 + 1);
    }
  }

  for (; i < M; ++i)
  {
    s0 = src + i;
    for (j = 0; j < N; ++j, s0 += LDA, dst++)
      *dst = *s0;
  }
}

static void pack_b(double *dst, double *src, int LDA, int M, int N)
{
  int i, j;
  double   //
      *s0, //
      *s1, //
      *s2, //
      *s3, //
      *s4, //
      *s5, //
      *s6, //
      *s7  //
      ;

  j = 0;

  for (; j < N - 3; j += 4)
  {
    s0 = src + j * LDA;
    s1 = s0 + LDA;
    s2 = s1 + LDA;
    s3 = s2 + LDA;
    for (i = 0; i < M; ++i)
    {
      *dst++ = *s0++;
      *dst++ = *s1++;
      *dst++ = *s2++;
      *dst++ = *s3++;
    }
  }

  for (; j < N - 1; j += 2)
  {
    s0 = src + j * LDA;
    s1 = s0 + LDA;
    for (i = 0; i < M; ++i)
    {
      *dst++ = *s0++;
      *dst++ = *s1++;
    }
  }

  for (; j < N; ++j)
  {
    s0 = src + j * LDA;
    for (i = 0; i < M; ++i, dst++, s0++)
    {
      *dst = *s0;
    }
  }
}

void dgemm_6(int M, int N, int K, double alpha, double *restrict A, int LDA,
             double *restrict B, int LDB, double beta, double *restrict C,
             int LDC)
{
  double *AL = scratch_a;
  double *BL = scratch_b;

  // Deltas for blocking
  int i, j, k, //
      d_i, d_j, d_k;

  // A[M, K] B[K, N] C[M, N]
  for (j = 0; j < N; j += d_j)
  {
    d_j = MIN(N - j, N_BLOCK);
    for (k = 0; k < K; k += d_k)
    {
      d_k = MIN(K - k, K_BLOCK);
      pack_b(BL, &TIX(B, LDB, k, j), LDB, d_k, d_j);
      for (i = 0; i < M; i += d_i)
      {
        d_i = MIN(M - i, M_BLOCK);
        pack_a(AL, &TIX(A, LDA, i, k), LDA, d_i, d_k);
        dgemm_6_mini(d_i, d_j, d_k, //
                     AL, -10E5,     // NOTE these shouldn't be used
                     BL, -10E5,     //
                     &TIX(C, LDC, i, j), LDC);
      }
    }
  }
}

// -----------
// END OF IMPL
// -----------

#ifdef TEST_PERF

void register_functions_MMM()
{
  add_function_MMM(&dgemm_1, "MMM Base", 1);
  add_function_MMM(&dgemm_2, "MMM C opts", 1);
  add_function_MMM(&dgemm_5, "MMM C opts Vector", 1);
  add_function_MMM(&dgemm_6, "MMM C opts Vector + Pack", 1);
#ifdef TEST_MKL
  add_function_MMM(&dgemm_intel, "MMM_Intel", 1);
#endif
}

#endif
