#include "distincts.h"

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


double * add_to_distincts_unconditionnaly(struct pso_data_constant_inertia * pso, double const * const x, double x_eval)
{
  size_t dst = pso->x_distinct_s;
  // copy point and value to x_distinct
  memcpy(PSO_XD(pso, dst), x,
          pso->dimensions * sizeof(double));
  pso->x_distinct_eval[dst] = x_eval;
  pso->x_distinct_s++;

  return PSO_XD(pso, dst);
}


int check_if_distinct(struct pso_data_constant_inertia * pso, double const * const x, int add_to_cache)
{
#if DISTINCTIVENESS_CHECK_TYPE == 0
  return 1;

#elif DISTINCTIVENESS_CHECK_TYPE == 1

  for (int i = 0; i < pso->x_distinct_s; i++)
  {
    double d2 = dist2(pso->dimensions, x, PSO_XD(pso, i));
    if (d2 < pso->min_dist2)
    {
      return  0;
    }
  }
  return 1;

#elif DISTINCTIVENESS_CHECK_TYPE == 2
  // check but DO NOT add
  return ! rounding_bloom_check_add(pso->bloom, pso->dimensions, x, add_to_cache);

#endif
}


int add_to_distincts_if_distinct(struct pso_data_constant_inertia * pso, double const * const x, double x_eval)
{
  if ( check_if_distinct(pso, x, 1) )
  {
    add_to_distincts_unconditionnaly(pso, x, x_eval);
    return 1;
  }
  else
  {
    return 0;
  }
}