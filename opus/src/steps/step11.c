#include "step11.h"

#include "math.h"

static int is_far_from_previous_evaluations(
    struct pso_data_constant_inertia const *pso, double *x, double min_dist)
{
  // - find way to check "if minimizer of surrogate is far from previous points"
  //    + see https://en.wikipedia.org/wiki/Nearest_neighbor_search
  //    + in high dim naive search can be best

  double delta2 = min_dist * min_dist;

  // check previous particle positions
  for (int t = 0; t < pso->time + 1; t++)
  {
    for (int i = 0; i < pso->population_size; i++)
    {
      double d2 = dist2(pso->dimensions, x, PSO_X(pso, t, i));
      if (d2 < delta2)
      {
        return 0;
      }
    }
  }

  // check previous local minimizers positions
  for (int k = 0; k < pso->n_past_refinement_points; k++)
  {
    double d2 = dist2(pso->dimensions, x, PSO_PAST_REFINEMENT(pso, k));
    if (d2 < delta2)
    {
      return 0;
    }
  }

  return 1;
}

void step11_base(struct pso_data_constant_inertia *pso)
{
  // Determine if minimizer of surrogate is far from previous points
  if (is_far_from_previous_evaluations(pso, pso->x_local,
                                       pso->min_minimizer_distance))
  {
    // Add new refinement point to list of past refinement points epsilon

    double x_local_eval = pso->f(pso->x_local);

    for (int k = 0; k < pso->dimensions; k++)
    {
      PSO_PAST_REFINEMENT(pso, pso->n_past_refinement_points)
      [k] = pso->x_local[k];
    }
    PSO_PAST_REFINEMENT_EVAL(pso, pso->n_past_refinement_points) = x_local_eval;

    // update overall best if applicable
    if (x_local_eval < pso->y_hat_eval)
    {
      pso->y_hat = PSO_PAST_REFINEMENT(pso, pso->n_past_refinement_points);
      pso->y_hat_eval = x_local_eval;
    }

    pso->n_past_refinement_points++;
  }
}

void step11_optimized(struct pso_data_constant_inertia *pso) 
{
    step11_base(pso);
}