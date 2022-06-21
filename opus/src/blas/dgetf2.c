#include <immintrin.h>
#include <math.h>

#include "../helpers.h"
#include "dgetf2.h"
#include "dswap.h"
#include "idamax.h"

int dgetf2_1(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {
    // --------
    // IDAMAX
    double p_v;
    int p_i;

    p_i = i + idamax_1(M - i, &MIX(A, LDA, i, i), LDA);
    p_v = MIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
      dswap_1(N, &MIX(A, LDA, i, 0), 1, &MIX(A, LDA, p_i, 0), 1);
    }

    // BLAS 1 Scale vector
    for (j = i + 1; j < M; ++j)
    {
      MIX(A, LDA, j, i) = MIX(A, LDA, j, i) / MIX(A, LDA, i, i);
    }

    if (i < MIN(M, N))
    {

      // BLAS 2 rank-1 update
      for (j = i + 1; j < M; ++j)
      {
        for (int k = i + 1; k < N; ++k)
        {
          MIX(A, LDA, j, k) =
              MIX(A, LDA, j, k) - MIX(A, LDA, j, i) * MIX(A, LDA, i, k);
        }
      }
    }
  }

  return 0;
}

int dgetf2_2(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j, k, p_i;

  double   //
      p_v, //
      m_0  //
      ;

  double      //
      A_j_k0, //
      A_j_k1, //
      A_j_k2, //
      A_j_k3, //
      A_j_k4, //
      A_j_k5, //
      A_j_k6, //
      A_j_k7, //

      A_i_k0, //
      A_i_k1, //
      A_i_k2, //
      A_i_k3, //
      A_i_k4, //
      A_i_k5, //
      A_i_k6, //
      A_i_k7  //
      ;
  // Quick return
  if (!M || !N)
    return 0;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {

    p_i = i + idamax_2(M - i, &MIX(A, LDA, i, i), LDA);
    p_v = MIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
#ifdef DEBUG_LU_SOLVER
      printf("Switching rows: %d %d\n", i, p_i);
#endif
      dswap_2(N, &MIX(A, LDA, i, 0), 1, &MIX(A, LDA, p_i, 0), 1);
    }

    // TODO compute the minimum machine safe integer such that
    // 1 / fmin doesn't overflow. This can be inlind because
    // we are targeting SKYLAKE.

    m_0 = 1 / MIX(A, LDA, i, i);

    // BLAS 1 Scale vector (NOTE column vector)
    for (j = i + 1; j < M; ++j)
    {
      MIX(A, LDA, j, i) = m_0 * MIX(A, LDA, j, i);
    }

    if (i < MIN(M, N))
    {

      // BLAS 2 rank-1 update
      for (j = i + 1; j < M; ++j)
      {

        // Negate to make computations look like FMA :)
        m_0 = -MIX(A, LDA, j, i);
        for (k = i + 1; k < N - 7; k += 8)
        {
          A_j_k0 = MIX(A, LDA, j, k + 0);
          A_j_k1 = MIX(A, LDA, j, k + 1);
          A_j_k2 = MIX(A, LDA, j, k + 2);
          A_j_k3 = MIX(A, LDA, j, k + 3);
          A_j_k4 = MIX(A, LDA, j, k + 4);
          A_j_k5 = MIX(A, LDA, j, k + 5);
          A_j_k6 = MIX(A, LDA, j, k + 6);
          A_j_k7 = MIX(A, LDA, j, k + 7);

          A_i_k0 = MIX(A, LDA, i, k + 0);
          A_i_k1 = MIX(A, LDA, i, k + 1);
          A_i_k2 = MIX(A, LDA, i, k + 2);
          A_i_k3 = MIX(A, LDA, i, k + 3);
          A_i_k4 = MIX(A, LDA, i, k + 4);
          A_i_k5 = MIX(A, LDA, i, k + 5);
          A_i_k6 = MIX(A, LDA, i, k + 6);
          A_i_k7 = MIX(A, LDA, i, k + 7);

          MIX(A, LDA, j, k + 0) = m_0 * A_i_k0 + A_j_k0;
          MIX(A, LDA, j, k + 1) = m_0 * A_i_k1 + A_j_k1;
          MIX(A, LDA, j, k + 2) = m_0 * A_i_k2 + A_j_k2;
          MIX(A, LDA, j, k + 3) = m_0 * A_i_k3 + A_j_k3;
          MIX(A, LDA, j, k + 4) = m_0 * A_i_k4 + A_j_k4;
          MIX(A, LDA, j, k + 5) = m_0 * A_i_k5 + A_j_k5;
          MIX(A, LDA, j, k + 6) = m_0 * A_i_k6 + A_j_k6;
          MIX(A, LDA, j, k + 7) = m_0 * A_i_k7 + A_j_k7;
        }

        for (; k < N; ++k)
        {
          A_j_k0 = MIX(A, LDA, j, k + 0);
          A_i_k0 = MIX(A, LDA, i, k + 0);
          MIX(A, LDA, j, k + 0) = m_0 * A_i_k0 + A_j_k0;
        }
      }
    }
  }

  return 0;
}

int dgetf2_5(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j, k, p_i;

  double   //
      p_v, //
      m_0  //
      ;

  double      //
      A_j0_i, //
      A_j1_i, //
      A_j2_i, //
      A_j3_i, //
      A_j4_i, //
      A_j5_i, //
      A_j6_i, //
      A_j7_i, //

      A_j_k0, //
      A_j_k1, //
      A_j_k2, //
      A_j_k3, //
      A_j_k4, //
      A_j_k5, //
      A_j_k6, //
      A_j_k7, //

      A_i_k0, //
      A_i_k1, //
      A_i_k2, //
      A_i_k3, //
      A_i_k4, //
      A_i_k5, //
      A_i_k6, //
      A_i_k7  //
      ;

  // Quick return
  if (!M || !N)
    return 0;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {

    p_i = i + idamax_2(M - i, &TIX(A, LDA, i, i), 1);
    p_v = TIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      fprintf(stderr, "LU Solving failed with A[%d x %d]", M, N);
#ifdef DEBUG_LU_SOLVER
#endif
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
#ifdef DEBUG_LU_SOLVER
      printf("Switching rows: %d %d\n", i, p_i);
#endif
      dswap_2(N, &TIX(A, LDA, i, 0), LDA, &TIX(A, LDA, p_i, 0), LDA);
    }

    m_0 = 1 / TIX(A, LDA, i, i);

    // BLAS 1 Scale vector ---
    for (j = i + 1; j <= M - 8; j += 8)
    {

      A_j0_i = TIX(A, LDA, j + 0, i);
      A_j1_i = TIX(A, LDA, j + 1, i);
      A_j2_i = TIX(A, LDA, j + 2, i);
      A_j3_i = TIX(A, LDA, j + 3, i);
      A_j4_i = TIX(A, LDA, j + 4, i);
      A_j5_i = TIX(A, LDA, j + 5, i);
      A_j6_i = TIX(A, LDA, j + 6, i);
      A_j7_i = TIX(A, LDA, j + 7, i);

      TIX(A, LDA, j + 0, i) = m_0 * A_j0_i;
      TIX(A, LDA, j + 1, i) = m_0 * A_j1_i;
      TIX(A, LDA, j + 2, i) = m_0 * A_j2_i;
      TIX(A, LDA, j + 3, i) = m_0 * A_j3_i;
      TIX(A, LDA, j + 4, i) = m_0 * A_j4_i;
      TIX(A, LDA, j + 5, i) = m_0 * A_j5_i;
      TIX(A, LDA, j + 6, i) = m_0 * A_j6_i;
      TIX(A, LDA, j + 7, i) = m_0 * A_j7_i;
    }
    for (; j <= M - 4; j += 4)
    {

      A_j0_i = TIX(A, LDA, j + 0, i);
      A_j1_i = TIX(A, LDA, j + 1, i);
      A_j2_i = TIX(A, LDA, j + 2, i);
      A_j3_i = TIX(A, LDA, j + 3, i);

      TIX(A, LDA, j + 0, i) = m_0 * A_j0_i;
      TIX(A, LDA, j + 1, i) = m_0 * A_j1_i;
      TIX(A, LDA, j + 2, i) = m_0 * A_j2_i;
      TIX(A, LDA, j + 3, i) = m_0 * A_j3_i;
    }
    for (; j < M; ++j)
    {
      TIX(A, LDA, j, i) = m_0 * TIX(A, LDA, j, i);
    }
    // --- BLAS 1 Scale Vector

    if (i < MIN(M, N))
    {

      // BLAS 2 Rank 1 update ---
      for (j = i + 1; j < M; ++j)
      {
        // Negate to make computations look like FMA :)
        m_0 = -TIX(A, LDA, j, i);
        for (k = i + 1; k < N; ++k)
        {
          A_j_k0 = TIX(A, LDA, j, k + 0);
          A_i_k0 = TIX(A, LDA, i, k + 0);
          TIX(A, LDA, j, k + 0) = m_0 * A_i_k0 + A_j_k0;
        }
      }
      // --- BLAS 2 Rank 1 update
      //
    }
  }

  return 0;
}

int dgetf2_6(int M, int N, double *A, int LDA, int *ipiv)
{

  int i, j, k, p_i;

  double   //
      p_v, //
      m_0, //
      m_1, //
      m_2, //
      m_3  //
      ;

  double      //
      A_j0_k, //
      A_j1_k, //
      A_j2_k, //
      A_j3_k, //

      A_i_k //
      ;

  __m256d     //
      m_0p,   //
      m_4p,   //
      A_j0_i, //
      A_j4_i  //
      ;

  __m256d      //
      A_i_kp,  //
      A_j0_kp, //
      A_j4_kp, //

      zero_pd //
      ;

  zero_pd = _mm256_setzero_pd();

  // Quick return
  if (!M || !N)
    return 0;

  // NOTE I have increased this to iterate *until* N however you could
  // stop at < N - 1 if you cover the bounds case.
  for (i = 0; i < MIN(M, N); ++i)
  {

    p_i = i + idamax_2(M - i, &TIX(A, LDA, i, i), 1);
    p_v = TIX(A, LDA, p_i, i);

    if (APPROX_EQUAL(p_v, 0.))
    {
      fprintf(stderr, "ERROR: LU Solve singular matrix\n");
      fprintf(stderr, "LU Solving failed with A[%d x %d]", M, N);
#ifdef DEBUG_LU_SOLVER
#endif
      return -1;
    }

    ipiv[i] = p_i;

    if (i != p_i)
    {
#ifdef DEBUG_LU_SOLVER
      printf("Switching rows: %d %d\n", i, p_i);
#endif
      dswap_6(N, &TIX(A, LDA, i, 0), LDA, &TIX(A, LDA, p_i, 0), LDA);
    }

    // BLAS 1 Scale vector ---
    m_0 = 1 / TIX(A, LDA, i, i);
    m_0p = _mm256_set1_pd(m_0); // XXX sequence of instructions
    for (j = i + 1; j <= M - 8; j += 8)
    {
      A_j0_i = _mm256_loadu_pd(&TIX(A, LDA, j + 0, i));
      _mm256_storeu_pd(&TIX(A, LDA, j + 0, i), _mm256_mul_pd(m_0p, A_j0_i));
      A_j0_i = _mm256_loadu_pd(&TIX(A, LDA, j + 4, i));
      _mm256_storeu_pd(&TIX(A, LDA, j + 4, i), _mm256_mul_pd(m_0p, A_j0_i));
    }
    for (; j <= M - 4; j += 4)
    {
      A_j0_i = _mm256_loadu_pd(&TIX(A, LDA, j + 0, i));
      _mm256_storeu_pd(&TIX(A, LDA, j + 0, i), _mm256_mul_pd(m_0p, A_j0_i));
    }
    for (; j < M; ++j)
    {
      TIX(A, LDA, j, i) = m_0 * TIX(A, LDA, j, i);
    }
    // --- BLAS 1 Scale Vector

    if (i < MIN(M, N))
    {

      // BLAS 2 Rank 1 update ---
      for (k = i + 1; k < N; ++k)
      {
        A_i_k = TIX(A, LDA, i, k + 0);
        A_i_kp = _mm256_set1_pd(A_i_k);

        j = i + 1;

        for (; j < M - 7; j += 8)
        {
          // Negate to make computations look like FMA :)
          m_0p = _mm256_sub_pd(                       //
              zero_pd,                                //
              _mm256_loadu_pd(&TIX(A, LDA, j + 0, i)) //
          );
          m_4p = _mm256_sub_pd(                       //
              zero_pd,                                //
              _mm256_loadu_pd(&TIX(A, LDA, j + 4, i)) //
          );
          A_j0_kp = _mm256_loadu_pd(&TIX(A, LDA, j + 0, k + 0));
          A_j4_kp = _mm256_loadu_pd(&TIX(A, LDA, j + 4, k + 0));
          _mm256_storeu_pd(&TIX(A, LDA, j + 0, k + 0), //
                           _mm256_fmadd_pd(m_0p, A_i_kp, A_j0_kp));
          _mm256_storeu_pd(&TIX(A, LDA, j + 4, k + 0), //
                           _mm256_fmadd_pd(m_4p, A_i_kp, A_j4_kp));
        }

        for (; j < M - 3; j += 4)
        {
          m_0p = _mm256_sub_pd(                       //
              zero_pd,                                //
              _mm256_loadu_pd(&TIX(A, LDA, j + 0, i)) //
          );
          A_j0_kp = _mm256_loadu_pd(&TIX(A, LDA, j + 0, k + 0));
          _mm256_storeu_pd(&TIX(A, LDA, j + 0, k + 0), //
                           _mm256_fmadd_pd(m_0p, A_i_kp, A_j0_kp));
        }

        for (; j < M; ++j)
        {
          // Negate to make computations look like FMA :)
          m_0 = -TIX(A, LDA, j, i);
          A_j0_k = TIX(A, LDA, j, k + 0);
          TIX(A, LDA, j, k + 0) = m_0 * A_i_k + A_j0_k;
        }
      }
      // --- BLAS 2 Rank 1 update
    }
  }

  return 0;
}
