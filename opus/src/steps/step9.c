#include "step9.h"

#include "stdlib.h"
#include "stdio.h"

#if USE_ROUNDING_BLOOM_FILTER
#include "../rounding_bloom.h"
#endif

void step9_base(struct pso_data_constant_inertia *pso)
{
  // Refit surrogate with time = t+1

  // first update the set of distinct points
#if USE_ROUNDING_BLOOM_FILTER
  for (int i = 0; i < pso->population_size; i++)
  {
    // add and check proximity to previous points
    if (!rounding_bloom_check_add(pso->bloom, pso->dimensions,
                                  PSO_X(pso, pso->time, i), 1))
    {
      pso->x_distinct[pso->x_distinct_s] =
          (pso->time) * pso->population_size + i;
      pso->x_distinct_s++;
    }
  }
#else
  // naive implementation with distance computation
  fprintf(stderr, "Not implemented.\n");
  exit(1);
#endif

  if (fit_surrogate(pso) < 0)
  {
    fprintf(stderr, "ERROR: Failed to fit surrogate\n");
    exit(1);
  }

#if LOG_SURROGATE
  {
    char fname[256] = {0};
    snprintf(fname, sizeof(fname), "surrogate_step9_t_%05d.struct", t);
    log_surrogate(fname, pso->lambda, pso->p, pso->x, t, pso->dimensions,
                  pso->population_size);
  }
#endif
}

void step9_optimized(struct pso_data_constant_inertia *pso) 
{
    step9_base(pso);
}