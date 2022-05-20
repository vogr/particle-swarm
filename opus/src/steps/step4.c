#include "step4.h"

// Step 4. Initialise y, y_eval, and x_eval for each particle
void step4_base(struct pso_data_constant_inertia *pso)
{
  for (int i = 0; i < pso->population_size; i++)
  {
    for (int k = 0; k < pso->dimensions; k++)
    {
      PSO_Y(pso, i)[k] = PSO_X(pso, 0, i)[k];
    }

    double x_eval = pso->f(PSO_X(pso, 0, i));
    pso->y_eval[i] = x_eval;
    PSO_FX(pso, 0, i) = x_eval;
  }

  // find ŷ

  double *y_hat = PSO_Y(pso, 0);
  double y_hat_eval = pso->y_eval[0];
  for (int i = 1; i < pso->population_size; i++)
  {
    if (pso->y_eval[i] < y_hat_eval)
    {
      y_hat = PSO_Y(pso, i);
      y_hat_eval = pso->y_eval[i];
    }
  }
  pso->y_hat = y_hat;
  pso->y_hat_eval = y_hat_eval;
}

void step4_optimized(struct pso_data_constant_inertia *pso)
{
  return step4_base(pso);
}