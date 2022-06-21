#include <assert.h>

#include "dlaswp.h"

#include "../helpers.h"

void dlaswp_1(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx)
{
  // interchange row i with row IPIV[k1 + (i - k1) * abs(incx)]

  assert(0 < incx); // Do not cover the negative case

  int ix, ix0;
  int i, k, p_i;
  double tmp;
  ix0 = k1;
  ix = ix0;

  for (i = k1; i < k2; ++i, ix += incx)
  {
    p_i = ipiv[ix];
    if (p_i != i)
    {
      for (k = 0; k < N; ++k)
      {
        tmp = MIX(A, LDA, i, k);
        MIX(A, LDA, i, k) = MIX(A, LDA, p_i, k);
        MIX(A, LDA, p_i, k) = tmp;
      }
    }
  }
}

void dlaswp_2(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx)
{
  // NOTE ipiv is layed out sequentially in memory so we can special case it
  assert(0 < incx);  // Do not cover the negative case
  assert(1 == incx); // Do not cover the negative case

  int n32;
  int i, j, k, p_i;

  double tmp;
  double        //
      a__i_k_0, //
      a__i_k_1, //
      a__i_k_2, //
      a__i_k_3, //
      a__i_k_4, //
      a__i_k_5, //
      a__i_k_6, //
      a__i_k_7, //

      a_pi_k_0, //
      a_pi_k_1, //
      a_pi_k_2, //
      a_pi_k_3, //
      a_pi_k_4, //
      a_pi_k_5, //
      a_pi_k_6, //
      a_pi_k_7  //
      ;

  n32 = (N / 32) * 32;

  if (0 < n32)
  {
    for (j = 0; j < n32; j += 32)
    {
      for (i = k1; i < k2; ++i)
      {
        p_i = ipiv[i];
        if (p_i != i)
        {
          for (k = j; k < j + 32 - 7; k += 8)
          {
            a__i_k_0 = MIX(A, LDA, i, k + 0);
            a__i_k_1 = MIX(A, LDA, i, k + 1);
            a__i_k_2 = MIX(A, LDA, i, k + 2);
            a__i_k_3 = MIX(A, LDA, i, k + 3);
            a__i_k_4 = MIX(A, LDA, i, k + 4);
            a__i_k_5 = MIX(A, LDA, i, k + 5);
            a__i_k_6 = MIX(A, LDA, i, k + 6);
            a__i_k_7 = MIX(A, LDA, i, k + 7);

            a_pi_k_0 = MIX(A, LDA, p_i, k + 0);
            a_pi_k_1 = MIX(A, LDA, p_i, k + 1);
            a_pi_k_2 = MIX(A, LDA, p_i, k + 2);
            a_pi_k_3 = MIX(A, LDA, p_i, k + 3);
            a_pi_k_4 = MIX(A, LDA, p_i, k + 4);
            a_pi_k_5 = MIX(A, LDA, p_i, k + 5);
            a_pi_k_6 = MIX(A, LDA, p_i, k + 6);
            a_pi_k_7 = MIX(A, LDA, p_i, k + 7);

            MIX(A, LDA, i, k + 0) = a_pi_k_0;
            MIX(A, LDA, i, k + 1) = a_pi_k_1;
            MIX(A, LDA, i, k + 2) = a_pi_k_2;
            MIX(A, LDA, i, k + 3) = a_pi_k_3;
            MIX(A, LDA, i, k + 4) = a_pi_k_4;
            MIX(A, LDA, i, k + 5) = a_pi_k_5;
            MIX(A, LDA, i, k + 6) = a_pi_k_6;
            MIX(A, LDA, i, k + 7) = a_pi_k_7;

            MIX(A, LDA, p_i, k + 0) = a__i_k_0;
            MIX(A, LDA, p_i, k + 1) = a__i_k_1;
            MIX(A, LDA, p_i, k + 2) = a__i_k_2;
            MIX(A, LDA, p_i, k + 3) = a__i_k_3;
            MIX(A, LDA, p_i, k + 4) = a__i_k_4;
            MIX(A, LDA, p_i, k + 5) = a__i_k_5;
            MIX(A, LDA, p_i, k + 6) = a__i_k_6;
            MIX(A, LDA, p_i, k + 7) = a__i_k_7;
          }
        }
      }
    }
  }

  // Leftover cases from blocking by 32
  if (n32 != N)
  {
    for (i = k1; i < k2; ++i)
    {
      p_i = ipiv[i];
      if (i != p_i)
      {
        for (k = n32; k < N - 7; k += 8)
        {
          a__i_k_0 = MIX(A, LDA, i, k + 0);
          a__i_k_1 = MIX(A, LDA, i, k + 1);
          a__i_k_2 = MIX(A, LDA, i, k + 2);
          a__i_k_3 = MIX(A, LDA, i, k + 3);
          a__i_k_4 = MIX(A, LDA, i, k + 4);
          a__i_k_5 = MIX(A, LDA, i, k + 5);
          a__i_k_6 = MIX(A, LDA, i, k + 6);
          a__i_k_7 = MIX(A, LDA, i, k + 7);

          a_pi_k_0 = MIX(A, LDA, p_i, k + 0);
          a_pi_k_1 = MIX(A, LDA, p_i, k + 1);
          a_pi_k_2 = MIX(A, LDA, p_i, k + 2);
          a_pi_k_3 = MIX(A, LDA, p_i, k + 3);
          a_pi_k_4 = MIX(A, LDA, p_i, k + 4);
          a_pi_k_5 = MIX(A, LDA, p_i, k + 5);
          a_pi_k_6 = MIX(A, LDA, p_i, k + 6);
          a_pi_k_7 = MIX(A, LDA, p_i, k + 7);

          MIX(A, LDA, i, k + 0) = a_pi_k_0;
          MIX(A, LDA, i, k + 1) = a_pi_k_1;
          MIX(A, LDA, i, k + 2) = a_pi_k_2;
          MIX(A, LDA, i, k + 3) = a_pi_k_3;
          MIX(A, LDA, i, k + 4) = a_pi_k_4;
          MIX(A, LDA, i, k + 5) = a_pi_k_5;
          MIX(A, LDA, i, k + 6) = a_pi_k_6;
          MIX(A, LDA, i, k + 7) = a_pi_k_7;

          MIX(A, LDA, p_i, k + 0) = a__i_k_0;
          MIX(A, LDA, p_i, k + 1) = a__i_k_1;
          MIX(A, LDA, p_i, k + 2) = a__i_k_2;
          MIX(A, LDA, p_i, k + 3) = a__i_k_3;
          MIX(A, LDA, p_i, k + 4) = a__i_k_4;
          MIX(A, LDA, p_i, k + 5) = a__i_k_5;
          MIX(A, LDA, p_i, k + 6) = a__i_k_6;
          MIX(A, LDA, p_i, k + 7) = a__i_k_7;
        }

        for (; k < N; ++k)
        {
          a__i_k_0 = MIX(A, LDA, i, k + 0);
          a_pi_k_0 = MIX(A, LDA, p_i, k + 0);
          MIX(A, LDA, p_i, k + 0) = a__i_k_0;
          MIX(A, LDA, i, k + 0) = a_pi_k_0;
        }
      }
    }
  }
}

void dlaswp_5(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx)
{
  // NOTE ipiv is layed out sequentially in memory so we can special case it
  assert(0 < incx);  // Do not cover the negative case
  assert(1 == incx); // Do not cover the negative case

  int n32;
  int i, j, k, p_i;

  double tmp;
  double        //
      a__i_k_0, //
      a__i_k_1, //
      a__i_k_2, //
      a__i_k_3, //
      a__i_k_4, //
      a__i_k_5, //
      a__i_k_6, //
      a__i_k_7, //

      a_pi_k_0, //
      a_pi_k_1, //
      a_pi_k_2, //
      a_pi_k_3, //
      a_pi_k_4, //
      a_pi_k_5, //
      a_pi_k_6, //
      a_pi_k_7  //
      ;

  n32 = (N / 32) * 32;

  if (0 < n32)
  {
    for (j = 0; j < n32; j += 32)
    {
      for (i = k1; i < k2; ++i)
      {
        p_i = ipiv[i];
        if (p_i != i)
        {
          for (k = j; k < j + 32 - 7; k += 8)
          {
            a__i_k_0 = TIX(A, LDA, i, k + 0);
            a__i_k_1 = TIX(A, LDA, i, k + 1);
            a__i_k_2 = TIX(A, LDA, i, k + 2);
            a__i_k_3 = TIX(A, LDA, i, k + 3);
            a__i_k_4 = TIX(A, LDA, i, k + 4);
            a__i_k_5 = TIX(A, LDA, i, k + 5);
            a__i_k_6 = TIX(A, LDA, i, k + 6);
            a__i_k_7 = TIX(A, LDA, i, k + 7);

            a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
            a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
            a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
            a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
            a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
            a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
            a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
            a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

            TIX(A, LDA, i, k + 0) = a_pi_k_0;
            TIX(A, LDA, i, k + 1) = a_pi_k_1;
            TIX(A, LDA, i, k + 2) = a_pi_k_2;
            TIX(A, LDA, i, k + 3) = a_pi_k_3;
            TIX(A, LDA, i, k + 4) = a_pi_k_4;
            TIX(A, LDA, i, k + 5) = a_pi_k_5;
            TIX(A, LDA, i, k + 6) = a_pi_k_6;
            TIX(A, LDA, i, k + 7) = a_pi_k_7;

            TIX(A, LDA, p_i, k + 0) = a__i_k_0;
            TIX(A, LDA, p_i, k + 1) = a__i_k_1;
            TIX(A, LDA, p_i, k + 2) = a__i_k_2;
            TIX(A, LDA, p_i, k + 3) = a__i_k_3;
            TIX(A, LDA, p_i, k + 4) = a__i_k_4;
            TIX(A, LDA, p_i, k + 5) = a__i_k_5;
            TIX(A, LDA, p_i, k + 6) = a__i_k_6;
            TIX(A, LDA, p_i, k + 7) = a__i_k_7;
          }
        }
      }
    }
  }

  // Leftover cases from blocking by 32
  if (n32 != N)
  {
    for (i = k1; i < k2; ++i)
    {
      p_i = ipiv[i];
      if (i != p_i)
      {
        for (k = n32; k < N - 7; k += 8)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a__i_k_1 = TIX(A, LDA, i, k + 1);
          a__i_k_2 = TIX(A, LDA, i, k + 2);
          a__i_k_3 = TIX(A, LDA, i, k + 3);
          a__i_k_4 = TIX(A, LDA, i, k + 4);
          a__i_k_5 = TIX(A, LDA, i, k + 5);
          a__i_k_6 = TIX(A, LDA, i, k + 6);
          a__i_k_7 = TIX(A, LDA, i, k + 7);

          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
          a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
          a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
          a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
          a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
          a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
          a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

          TIX(A, LDA, i, k + 0) = a_pi_k_0;
          TIX(A, LDA, i, k + 1) = a_pi_k_1;
          TIX(A, LDA, i, k + 2) = a_pi_k_2;
          TIX(A, LDA, i, k + 3) = a_pi_k_3;
          TIX(A, LDA, i, k + 4) = a_pi_k_4;
          TIX(A, LDA, i, k + 5) = a_pi_k_5;
          TIX(A, LDA, i, k + 6) = a_pi_k_6;
          TIX(A, LDA, i, k + 7) = a_pi_k_7;

          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, p_i, k + 1) = a__i_k_1;
          TIX(A, LDA, p_i, k + 2) = a__i_k_2;
          TIX(A, LDA, p_i, k + 3) = a__i_k_3;
          TIX(A, LDA, p_i, k + 4) = a__i_k_4;
          TIX(A, LDA, p_i, k + 5) = a__i_k_5;
          TIX(A, LDA, p_i, k + 6) = a__i_k_6;
          TIX(A, LDA, p_i, k + 7) = a__i_k_7;
        }

        for (; k < N; ++k)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, i, k + 0) = a_pi_k_0;
        }
      }
    }
  }
}

void dlaswp_6(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx)
{
  // NOTE ipiv is layed out sequentially in memory so we can special case it
  assert(0 < incx);  // Do not cover the negative case
  assert(1 == incx); // Do not cover the negative case

  int n32;
  int i, j, k, p_i;

  double tmp;
  double        //
      a__i_k_0, //
      a__i_k_1, //
      a__i_k_2, //
      a__i_k_3, //
      a__i_k_4, //
      a__i_k_5, //
      a__i_k_6, //
      a__i_k_7, //

      a_pi_k_0, //
      a_pi_k_1, //
      a_pi_k_2, //
      a_pi_k_3, //
      a_pi_k_4, //
      a_pi_k_5, //
      a_pi_k_6, //
      a_pi_k_7  //
      ;

  n32 = (N / 32) * 32;

  if (0 < n32)
  {
    for (j = 0; j < n32; j += 32)
    {
      for (i = k1; i < k2; ++i)
      {
        p_i = ipiv[i];
        if (p_i != i)
        {
          for (k = j; k < j + 32 - 7; k += 8)
          {
            a__i_k_0 = TIX(A, LDA, i, k + 0);
            a__i_k_1 = TIX(A, LDA, i, k + 1);
            a__i_k_2 = TIX(A, LDA, i, k + 2);
            a__i_k_3 = TIX(A, LDA, i, k + 3);
            a__i_k_4 = TIX(A, LDA, i, k + 4);
            a__i_k_5 = TIX(A, LDA, i, k + 5);
            a__i_k_6 = TIX(A, LDA, i, k + 6);
            a__i_k_7 = TIX(A, LDA, i, k + 7);

            a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
            a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
            a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
            a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
            a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
            a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
            a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
            a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

            TIX(A, LDA, i, k + 0) = a_pi_k_0;
            TIX(A, LDA, i, k + 1) = a_pi_k_1;
            TIX(A, LDA, i, k + 2) = a_pi_k_2;
            TIX(A, LDA, i, k + 3) = a_pi_k_3;
            TIX(A, LDA, i, k + 4) = a_pi_k_4;
            TIX(A, LDA, i, k + 5) = a_pi_k_5;
            TIX(A, LDA, i, k + 6) = a_pi_k_6;
            TIX(A, LDA, i, k + 7) = a_pi_k_7;

            TIX(A, LDA, p_i, k + 0) = a__i_k_0;
            TIX(A, LDA, p_i, k + 1) = a__i_k_1;
            TIX(A, LDA, p_i, k + 2) = a__i_k_2;
            TIX(A, LDA, p_i, k + 3) = a__i_k_3;
            TIX(A, LDA, p_i, k + 4) = a__i_k_4;
            TIX(A, LDA, p_i, k + 5) = a__i_k_5;
            TIX(A, LDA, p_i, k + 6) = a__i_k_6;
            TIX(A, LDA, p_i, k + 7) = a__i_k_7;
          }
        }
      }
    }
  }

  // Leftover cases from blocking by 32
  if (n32 != N)
  {
    for (i = k1; i < k2; ++i)
    {
      p_i = ipiv[i];
      if (i != p_i)
      {
        for (k = n32; k < N - 7; k += 8)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a__i_k_1 = TIX(A, LDA, i, k + 1);
          a__i_k_2 = TIX(A, LDA, i, k + 2);
          a__i_k_3 = TIX(A, LDA, i, k + 3);
          a__i_k_4 = TIX(A, LDA, i, k + 4);
          a__i_k_5 = TIX(A, LDA, i, k + 5);
          a__i_k_6 = TIX(A, LDA, i, k + 6);
          a__i_k_7 = TIX(A, LDA, i, k + 7);

          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          a_pi_k_1 = TIX(A, LDA, p_i, k + 1);
          a_pi_k_2 = TIX(A, LDA, p_i, k + 2);
          a_pi_k_3 = TIX(A, LDA, p_i, k + 3);
          a_pi_k_4 = TIX(A, LDA, p_i, k + 4);
          a_pi_k_5 = TIX(A, LDA, p_i, k + 5);
          a_pi_k_6 = TIX(A, LDA, p_i, k + 6);
          a_pi_k_7 = TIX(A, LDA, p_i, k + 7);

          TIX(A, LDA, i, k + 0) = a_pi_k_0;
          TIX(A, LDA, i, k + 1) = a_pi_k_1;
          TIX(A, LDA, i, k + 2) = a_pi_k_2;
          TIX(A, LDA, i, k + 3) = a_pi_k_3;
          TIX(A, LDA, i, k + 4) = a_pi_k_4;
          TIX(A, LDA, i, k + 5) = a_pi_k_5;
          TIX(A, LDA, i, k + 6) = a_pi_k_6;
          TIX(A, LDA, i, k + 7) = a_pi_k_7;

          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, p_i, k + 1) = a__i_k_1;
          TIX(A, LDA, p_i, k + 2) = a__i_k_2;
          TIX(A, LDA, p_i, k + 3) = a__i_k_3;
          TIX(A, LDA, p_i, k + 4) = a__i_k_4;
          TIX(A, LDA, p_i, k + 5) = a__i_k_5;
          TIX(A, LDA, p_i, k + 6) = a__i_k_6;
          TIX(A, LDA, p_i, k + 7) = a__i_k_7;
        }

        for (; k < N; ++k)
        {
          a__i_k_0 = TIX(A, LDA, i, k + 0);
          a_pi_k_0 = TIX(A, LDA, p_i, k + 0);
          TIX(A, LDA, p_i, k + 0) = a__i_k_0;
          TIX(A, LDA, i, k + 0) = a_pi_k_0;
        }
      }
    }
  }
}
