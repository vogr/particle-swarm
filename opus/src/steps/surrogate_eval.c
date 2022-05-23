#include "surrogate_eval.h"

#include "../helpers.h"

double surrogate_eval_base(struct pso_data_constant_inertia const *pso,
                      double const *x)
{
  // TODO: add the past_local_refinements
  // Note: will also require adding them to the bloom filter / distinctiveness
  // check

  // TODO: I think there is something wrong with the surrogate:
  //  I don't have the same values when evaluating in the Jupyter notebook
  //  To investigate!
  //  VO

  double res = 0;

  for (int k = 0; k < (int)pso->x_distinct_s; k++)
  {
    size_t p = pso->x_distinct[k];
    double *u = pso->x + p * pso->dimensions;
    double d = dist(pso->dimensions, u, x);
    res += pso->lambda[k] * d * d * d;
  }

  for (int j = 0; j < pso->dimensions; j++)
  {
    res += pso->p[j + 1] * x[j];
  }
  res += pso->p[0];

  return res;
}

double surrogate_eval_optimized(struct pso_data_constant_inertia const *pso,
                      double const *x)
{
    return surrogate_eval_base(pso, x);
}
