#include "step11.h"

#include <math.h>
#include <string.h>

#include "../distincts.h"

void step11_base(struct pso_data_constant_inertia *pso)
{
  double *x_local = pso->x_local;
  // Determine if minimizer of surrogate is far from previous points
  // if it is add it to the bloom filter (if enabled) ...
  if (check_if_distinct(pso, x_local, 1))
  {
    double x_local_eval = pso->f(x_local);

    // ... and add new refinement point and its evaluation to list of distinct evaluation
    // positions
    
    double *x_local_in_xdistinct = add_to_distincts_unconditionnaly(pso, x_local, x_local_eval);

    // update overall best if applicable
    if (x_local_eval < pso->y_hat_eval)
    {
      pso->y_hat = x_local_in_xdistinct;
      pso->y_hat_eval = x_local_eval;
    }
  }
}

void step11_optimized(struct pso_data_constant_inertia *pso)
{
  step11_base(pso);
}
