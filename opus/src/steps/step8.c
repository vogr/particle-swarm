#include "step8.h"
#include <string.h>

void step8_base(struct pso_data_constant_inertia *pso)
{
  // Update the best positions per particle and overall
  for (int i = 0; i < pso->population_size; i++)
  {
    double x_eval = PSO_FX(pso, i);

    if (x_eval < pso->y_eval[i])
    {
      // y_i <- x_i
      for (int k = 0; k < pso->dimensions; k++)
      {
        PSO_Y(pso, i)[k] = PSO_X(pso, i)[k];
      }
      pso->y_eval[i] = x_eval;

      // is x_i(t+1) better than ŷ(t) ?
      if (x_eval < pso->y_hat_eval)
      {
        pso->y_hat = PSO_Y(pso, i);
        pso->y_hat_eval = x_eval;
      }
    }
  }

  pso->time++;
}

void step8_opt1(struct pso_data_constant_inertia *pso)
{
  int pop_size = pso->population_size;
  int dim = pso->dimensions;
  double * pso_x = pso->x;
  double * pso_y = pso->y;
  double * pso_y_eval = pso->y_eval;
  double * pso_y_hat = pso->y_hat;
  double pso_y_hat_eval = pso->y_hat_eval;



  // Update the best positions per particle and overall
  for (int i = 0; i < pop_size; i++)
  {
    int i_dim = i * dim;
    double *pso_x_i_dim = pso_x + i_dim; // PSO_X(pso, 0, i)
    double *pso_y_i_dim = pso_y + i_dim; // PSO_Y(pso, i);

    double x_eval = PSO_FX(pso, i);

    if (x_eval < pso_y_eval[i])
    {
      // y_i <- x_i
      memcpy(pso_y_i_dim, pso_x_i_dim, dim * sizeof(double));
      pso_y_eval[i] = x_eval; // pso->y_eval[i] = x_eval;

      // is x_i(t+1) better than ŷ(t) ?
      if (x_eval < pso_y_hat_eval)
      {
        // TODO: why does pso_y_hat not work?
        //        pso_y_hat = pso_y_i_dim;  // PSO_Y(pso, i);
        pso->y_hat = pso_y_i_dim;  // pso->y_hat = PSO_Y(pso, i);
        pso_y_hat_eval = x_eval;
      }
    }
  }
  pso->y_hat_eval = pso_y_hat_eval;
  pso->time++;
}

void step8_optimized(struct pso_data_constant_inertia *pso) {
  step8_base(pso);
//  step8_opt1(pso);
}
