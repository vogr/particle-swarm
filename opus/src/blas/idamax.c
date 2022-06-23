#include <assert.h>
#include <immintrin.h>
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

  double p_v, p_t, vr1, vi1, vr2, vi2;
  int i, p_i, ix;

  double pp_i[4] __attribute__((aligned(64)));
  double v_i[4] __attribute__((aligned(64)));
  double pr_i[4] __attribute__((aligned(64)));

  __m256d                                //
      mask,                              //
      vpd,                               //
      fabs_vpd,                          //
      ppd = _mm256_set1_pd(0.),          //
      sign = _mm256_set1_pd(-0.f),       //
      ixpd = _mm256_setr_pd(0, 1, 2, 3), //
      pripd = _mm256_set1_pd(-1.),       //
      inc = _mm256_set1_pd(4.)           //
      ;

  p_v = fabs(A[0]);
  p_i = 0;
  ix = 0 + stride;

  if (stride == 1)
  {

    double *A_ptr = &A[0];
    for (i = 0; i < N - 3; i += 4, A_ptr += 4)
    {
      vpd = _mm256_loadu_pd(A_ptr);

      fabs_vpd = _mm256_andnot_pd(sign, vpd);

      // fabs(v) > fabs(p)
      mask = _mm256_cmp_pd(fabs_vpd, ppd, _CMP_GT_OQ);
      ppd = _mm256_blendv_pd(ppd, fabs_vpd, mask);
      pripd = _mm256_blendv_pd(pripd, ixpd, mask);

      ixpd = _mm256_add_pd(ixpd, inc);
    }
    // NOTE these arrays should be aligned
    _mm256_store_pd(pp_i, ppd);
    _mm256_store_pd(pr_i, pripd);

    for (; i < N; i++, ++A_ptr)
    {
      v_i[0] = fabs(*A_ptr);

      if (v_i[0] > pp_i[0])
      {
        pp_i[0] = v_i[0];
        pr_i[0] = (double)i;
      }
    } // leftover i

    // ----- get the max from the 4-vector

    vr1 = pp_i[0] > pp_i[1] ? pp_i[0] : pp_i[1];
    vi1 = pp_i[0] > pp_i[1] ? pr_i[0] : pr_i[1];
    vr2 = pp_i[2] > pp_i[3] ? pp_i[2] : pp_i[3];
    vi2 = pp_i[2] > pp_i[3] ? pr_i[2] : pr_i[3];
    p_i = vr1 > vr2 ? vi1 : vi2;
  }
  else // Stride is not 1 and we can't assume locality
  {
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
  }

  return p_i;
}
