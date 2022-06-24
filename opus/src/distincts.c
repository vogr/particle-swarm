#include "distincts.h"

#include <math.h>
#include <string.h>

#include <immintrin.h>

#include "helpers.h"

#if DISTINCTIVENESS_CHECK_TYPE == 0
// Accept all
#elif DISTINCTIVENESS_CHECK_TYPE == 1
// Naive compare
#elif DISTINCTIVENESS_CHECK_TYPE == 2
// Bloom filter
#include "rounding_bloom.h"
#endif

double *add_to_distincts_unconditionnaly(struct pso_data_constant_inertia *pso,
                                         double const *const x, double x_eval)
{
  size_t dst = pso->x_distinct_s;
  // copy point and value to x_distinct
  memcpy(PSO_XD(pso, dst), x, pso->dimensions * sizeof(double));
  pso->x_distinct_eval[dst] = x_eval;
  pso->x_distinct_s++;

  return PSO_XD(pso, dst);
}

int add_to_distincts_if_distinct(struct pso_data_constant_inertia *pso,
                                 double const *const x, double x_eval)
{
  if (check_if_distinct(pso, x, 1))
  {
    add_to_distincts_unconditionnaly(pso, x, x_eval);
    return 1;
  }
  else
  {
    return 0;
  }
}

int check_if_distinct(struct pso_data_constant_inertia *pso,
                      double const *const x, int add_to_cache)
{
  return CHECK_IF_DISTINCT_VERSION(pso, x, add_to_cache);
}

int check_if_distinct_0(struct pso_data_constant_inertia *pso,
                        double const *const x, int add_to_cache)
{
#if DISTINCTIVENESS_CHECK_TYPE == 0
  return 1;

#elif DISTINCTIVENESS_CHECK_TYPE == 1

  for (int i = 0; i < pso->x_distinct_s; i++)
  {
    double d2 = dist2(pso->dimensions, x, PSO_XD(pso, i));
    if (d2 < pso->min_dist2)
    {
      return 0;
    }
  }
  return 1;

#elif DISTINCTIVENESS_CHECK_TYPE == 2
  // check but DO NOT add
  return !rounding_bloom_check_add(pso->bloom, pso->dimensions, x,
                                   add_to_cache);

#endif
}

/*
 * v1: compute distances and add them to the cache for fit_surrogate
 *
 * ONLY COMPATIBLE (and required) WITH fit_surrogate version >= 6
 * AND WITH THE NAIVE DISTANCE COMPUTATION
 */

extern size_t fit_surrogate_max_N_phi;
extern double *fit_surrogate_phi_cache;

int check_if_distinct_1(struct pso_data_constant_inertia *pso,
                        double const *const x, int add_to_cache)
{
#if DISTINCTIVENESS_CHECK_TYPE == 1

  size_t x_distinct_s = pso->x_distinct_s;
  double *chache_dest =
      fit_surrogate_phi_cache + x_distinct_s * (x_distinct_s - 1) / 2;

  for (int i = 0; i < pso->x_distinct_s; i++)
  {
    double d2 = dist2(pso->dimensions, x, PSO_XD(pso, i));

    if (add_to_cache)
    {
      double d1 = sqrt(d2);
      double d3 = d1 * d2;
      chache_dest[i] = d3;
    }

    if (d2 < pso->min_dist2)
    {
      // we leave the invalid values in the cache, they will be
      // overwritten
      return 0;
    }
  }

  // UGLY:
  // the addition of the distances to the cache will be concretized
  // when x is added to x_distinct and x_distinct_s gets incremented
  return 1;

#else
  assert(
      "check_if_distinct_1 only compatible with naive distance computations" &&
      false);
#endif
}

int check_if_distinct_1_opt(struct pso_data_constant_inertia *pso,
                            double const *const x_ptr, int add_to_cache)
{
#if DISTINCTIVENESS_CHECK_TYPE == 1

  size_t dim = pso->dimensions;

  size_t x_distinct_s = pso->x_distinct_s;
  double *chache_dest =
      fit_surrogate_phi_cache + x_distinct_s * (x_distinct_s - 1) / 2;

  __m128d zero_128 = _mm_set1_pd(0.);
  __m128d min_dist_d2__128 = _mm_set1_pd(pso->min_dist2);

  // iterate directly on x_distinct
  size_t k = 0;
  for (; k + 1 < pso->x_distinct_s; k += 2)
  {
    double *u0_ptr = pso->x_distinct + k * dim;
    double *u1_ptr = pso->x_distinct + (k + 1) * dim;
    //    double *u2 = pso->x_distinct + (k+2)*dim;
    //    double *u3 = pso->x_distinct + (k+3)*dim;

    __m256d s0 = _mm256_set1_pd(0);
    __m256d s1 = _mm256_set1_pd(0);

    size_t i = 0;
    for (; i + 3 < pso->dimensions; i += 4)
    {
      __m256d u0 = _mm256_loadu_pd(u0_ptr + i);
      __m256d u1 = _mm256_loadu_pd(u1_ptr + i);
      __m256d x = _mm256_loadu_pd(x_ptr + i);

      __m256d v0 = _mm256_sub_pd(u0, x); // u - x_ptr
      __m256d v1 = _mm256_sub_pd(u1, x);
      s0 = _mm256_fmadd_pd(v0, v0, s0); // s += v*v
      s1 = _mm256_fmadd_pd(v1, v1, s1);
    }

    // s0 = a1 a2 a3 a4
    // s1 = b1 b2 b3 b4
    __m256d t1 = _mm256_hadd_pd(s0, s1);
    // t1 = (a1 + a2) (b1 + b2) (a3 + a4) (b3 + b4)

    __m128d tlow = _mm256_castpd256_pd128(t1);
    __m128d thigh = _mm256_extractf128_pd(t1, 1); // high 128
    __m128d d2 = _mm_add_pd(tlow, thigh);
    // t2 = (a1 + .. + a4) (b1 + .. + b4)

    for (; i < pso->dimensions; i++)
    {
      __m128d uu = _mm_load1_pd(&u0_ptr[i]);
      __m128d uv = _mm_loadh_pd(uu, &u1_ptr[i]);
      __m128d xi = _mm_load1_pd(&x_ptr[i]);
      __m128d diff = _mm_sub_pd(uv, xi);
      d2 = _mm_fmadd_pd(diff, diff, d2);
    }

    if (add_to_cache)
    {
      __m128d d = _mm_sqrt_pd(d2);
      __m128d d3 = _mm_mul_pd(d, d2);
      _mm_store_pd(chache_dest + k, d3);
    }

    __m128d cmp = _mm_cmple_pd(d2, min_dist_d2__128);
    int far_enough = _mm_testz_pd(cmp, cmp);

    if (!far_enough)
    {
      // we leave the invalid values in the cache, they will be
      // overwritten
      return 0;
    }
  }

  for (; k < pso->x_distinct_s; k++)
  {
    double d2 = dist2(pso->dimensions, x_ptr, PSO_XD(pso, k));

    if (add_to_cache)
    {
      double d1 = sqrt(d2);
      double d3 = d1 * d2;
      chache_dest[k] = d3;
    }

    if (d2 < pso->min_dist2)
    {
      // we leave the invalid values in the cache, they will be
      // overwritten
      return 0;
    }
  }

  // UGLY:
  // the addition of the distances to the cache will be concretized
  // when x is added to x_distinct and x_distinct_s gets incremented
  return 1;

#else
  assert(
      "check_if_distinct_1 only compatible with naive distance computations" &&
      false);
#endif
}