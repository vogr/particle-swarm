#include "step5.h"

#include "stdio.h"
#include "stdlib.h"

#include "../gaussian_elimination_solver.h"
#include "math.h"

#include "fit_surrogate.h"

void step5_base(struct pso_data_constant_inertia *pso)
{
  // Step 5.
  // Fit surrogate
  // f already evaluated on x[0..t][0..i-1]
  
  // XXX: currently refit surrogate but it is the same as in step9
  // bc we don't use the local minimizers !
  if (fit_surrogate(pso) < 0)
  {
    fprintf(stderr, "ERROR: Failed to fit surrogate\n");
    exit(1);
  }

}

void step5_optimized(struct pso_data_constant_inertia *pso) { step5_base(pso); }
