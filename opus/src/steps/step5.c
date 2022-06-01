#include "step5.h"

#include "stdio.h"
#include "stdlib.h"
#include <string.h>

#include "../gaussian_elimination_solver.h"
#include "math.h"

#include "fit_surrogate.h"

#include "../distincts.h"

#include "../logging.h"

void step5_base(struct pso_data_constant_inertia *pso)
{
  // Step 5.
  // Fit surrogate
  // f already evaluated on x[0..t][0..i-1]

  // Build set of distinct points: add latest x positions
  for (size_t i = 0; i < pso->population_size; i++)
  {
    add_to_distincts_if_distinct(pso, PSO_X(pso, i), pso->x_eval[i]);
  }

  TIMING_INIT();
  if (fit_surrogate(pso) < 0)
  {
    fprintf(stderr, "ERROR: Failed to fit surrogate\n");
    exit(1);
  }
  TIMING_STEP("fit_surrogate", STR(FIT_SURROGATE_VERSION), pso->time);
}

void step5_optimized(struct pso_data_constant_inertia *pso) { step5_base(pso); }
