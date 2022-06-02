#include "distincts.h"

#include <math.h>
#include <string.h>

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
int check_if_distinct_1(struct pso_data_constant_inertia *pso,
                        double const *const x, int add_to_cache)
{
#if DISTINCTIVENESS_CHECK_TYPE == 1

  for (int i = 0; i < pso->x_distinct_s; i++)
  {
    double d2 = dist2(pso->dimensions, x, PSO_XD(pso, i));
    double d1 = sqrt(d2);
    double d3 = d1 * d2;

    if (d2 < pso->min_dist2)
    {
      return 0;
    }
  }
  return 1;

#else
  assert(
      "check_if_distinct_1 only compatible with naive distance computations" &&
      false);
#endif
}