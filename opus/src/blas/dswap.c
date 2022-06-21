#include <assert.h>
#include <immintrin.h>

#include "dswap.h"

void dswap_1(int N, double *X, int incx, double *Y, int incy)
{
  assert(0 < N);
  assert(0 < incx);
  assert(0 < incy);

  double t;
  int i, ix, iy;

  for (i = 0, ix = 0, iy = 0; i < N; ++i, ix += incx, iy += incy)
  {
    t = X[ix];
    X[ix] = Y[iy];
    Y[iy] = t;
  }

  return;
}

void dswap_2(int N, double *X, int incx, double *Y, int incy)
{

  assert(0 < N);
  assert(0 < incx);
  assert(0 < incy);

  double   //
      t,   //
      t_0, //
      t_1, //
      t_2, //
      t_3, //
      t_4, //
      t_5, //
      t_6, //
      t_7, //

      x_i_0, //
      x_i_1, //
      x_i_2, //
      x_i_3, //
      x_i_4, //
      x_i_5, //
      x_i_6, //
      x_i_7, //

      y_i_0, //
      y_i_1, //
      y_i_2, //
      y_i_3, //
      y_i_4, //
      y_i_5, //
      y_i_6, //
      y_i_7  //
      ;

  int i, ix, iy;

  if (incx == 1 && incy == 1)
  {
    for (i = 0; i < N - 7; i += 8)
    {

      x_i_0 = X[i + 0];
      x_i_1 = X[i + 1];
      x_i_2 = X[i + 2];
      x_i_3 = X[i + 3];
      x_i_4 = X[i + 4];
      x_i_5 = X[i + 5];
      x_i_6 = X[i + 6];
      x_i_7 = X[i + 7];

      y_i_0 = Y[i + 0];
      y_i_1 = Y[i + 1];
      y_i_2 = Y[i + 2];
      y_i_3 = Y[i + 3];
      y_i_4 = Y[i + 4];
      y_i_5 = Y[i + 5];
      y_i_6 = Y[i + 6];
      y_i_7 = Y[i + 7];

      X[i + 0] = y_i_0;
      X[i + 1] = y_i_1;
      X[i + 2] = y_i_2;
      X[i + 3] = y_i_3;
      X[i + 4] = y_i_4;
      X[i + 5] = y_i_5;
      X[i + 6] = y_i_6;
      X[i + 7] = y_i_7;

      Y[i + 0] = x_i_0;
      Y[i + 1] = x_i_1;
      Y[i + 2] = x_i_2;
      Y[i + 3] = x_i_3;
      Y[i + 4] = x_i_4;
      Y[i + 5] = x_i_5;
      Y[i + 6] = x_i_6;
      Y[i + 7] = x_i_7;
    }

    for (; i < N; ++i)
    {
      t_0 = X[i + 0];
      X[i + 0] = Y[i + 0];
      Y[i + 0] = t_0;
    }
  }
  else
  {
    for (i = 0, ix = 0, iy = 0; i < N; ++i, ix += incx, iy += incy)
    {
      t = X[ix];
      X[ix] = Y[iy];
      Y[iy] = t;
    }
  }
}

void dswap_6(int N, double *X, int incx, double *Y, int incy)
{
  // TODO special case when incx == incy == 1
  // ^^^ This is our case actually (row-major iteration).

  assert(0 < N);
  assert(0 < incx);
  assert(0 < incy);

  double  //
      t_0 //
      ;

  __m256d  //
      x_0, //
      x_4,

      y_0, //
      y_4;

  int i, ix, iy;

  if (incx == 1 && incy == 1)
  {
    for (i = 0; i < N - 7; i += 8)
    {
      x_0 = _mm256_loadu_pd(X + i + 0);
      y_0 = _mm256_loadu_pd(Y + i + 0);
      _mm256_storeu_pd(X + i + 0, y_0);
      _mm256_storeu_pd(Y + i + 0, x_0);

      x_4 = _mm256_loadu_pd(X + i + 4);
      y_4 = _mm256_loadu_pd(Y + i + 4);
      _mm256_storeu_pd(X + i + 4, y_4);
      _mm256_storeu_pd(Y + i + 4, x_4);
    }

    for (; i < N; ++i)
    {
      t_0 = X[i + 0];
      X[i + 0] = Y[i + 0];
      Y[i + 0] = t_0;
    }
  }
  else
  {
    for (i = 0, ix = 0, iy = 0; i < N; ++i, ix += incx, iy += incy)
    {
      t_0 = X[ix];
      X[ix] = Y[iy];
      Y[iy] = t_0;
    }
  }
}
