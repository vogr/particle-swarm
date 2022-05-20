#include "step5.h"

#include "stdio.h"
#include "stdlib.h"

#include "../gaussian_elimination_solver.h"
#include "math.h"

void step5_base(struct pso_data_constant_inertia *pso)
{
  // Step 5.
  // Fit surrogate
  // f already evaluated on x[0..t][0..i-1]
  if (fit_surrogate(pso) < 0)
  {
    fprintf(stderr, "ERROR: Failed to fit surrogate\n");
    exit(1);
  }

#if LOG_SURROGATE
  {
    char fname[256] = {0};
    snprintf(fname, sizeof(fname), "surrogate_step5_t_%05d.struct", t);
    log_surrogate(fname, pso->lambda, pso->p, pso->x, t, pso->dimensions,
                  pso->population_size);
  }
#endif
}

void step5_optimized(struct pso_data_constant_inertia *pso) { step5_base(pso); }
