#include <assert.h>
#include <math.h>

#include "../helpers.h"
#include "idamax.h"

int idamax_1(int N, double *A, int stride)
{
  // NOTE N can be 0 if we iterate to the end of the rows in _lu_solve_XXX
  // this saves us from initializing the ipiv array. We could also do this
  // by just setting the end index to itself.

  // assert(0 < N);
  if (0 == N)
    return 0;

  assert(0 < stride);

  // TODO speacialize the case when `STRIDE` == 1.

  double p_v, p_t;
  int i, p_i, ix;

  p_v = fabs(A[0]);
  p_i = 0;
  ix = 0 + stride;

  for (i = 1; i < N; ++i, ix += stride)
  {
    assert(ix == i * stride);

    p_t = fabs(A[ix]);
    if (p_t > p_v)
    {
      p_v = p_t;
      p_i = i;
    }
  }
  return p_i;
}

int idamax_2(int N, double *A, int stride)
{
  // NOTE N can be 0 if we iterate to the end of the rows in _lu_solve_XXX
  // this saves us from initializing the ipiv array. We could also do this
  // by just setting the end index to itself.

  assert(0 <= N);

  // TODO FIXME
  if (N < 1 || stride == 0)
    return 0;

  assert(0 < stride);

  // TODO speacialize the case when `STRIDE` == 1.

  double p_v, p_t;
  int i, p_i, ix;

  p_v = fabs(A[0]);
  p_i = 0;
  ix = 0 + stride;

  for (i = 1; i < N; ++i, ix += stride)
  {
    assert(ix == i * stride);

    p_t = fabs(A[ix]);
    if (p_t > p_v)
    {
      p_v = p_t;
      p_i = i;
    }
  }
  return p_i;
}
