#include "step1_2.h"

#include "../distincts.h"

#include <stdlib.h>
#include <string.h>

struct id_and_eval
{
  double eval;
  size_t id;
};

static int id_and_eval_compar(void const *av, void const *bv)
{
  struct id_and_eval *a = (struct id_and_eval *)av;
  struct id_and_eval *b = (struct id_and_eval *)bv;
  if (a->eval < b->eval)
  {
    return -1;
  }
  else if (a->eval > b->eval)
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

void step1_2(struct pso_data_constant_inertia *pso, size_t sfd_size,
             double *space_filling_design)
{
  STEP1_2_VERSION(pso, sfd_size, space_filling_design);
}

void step1_2_opt0(struct pso_data_constant_inertia *pso, size_t sfd_size,
                  double *space_filling_design)
{

  struct id_and_eval *z_eval = malloc(sfd_size * sizeof(struct id_and_eval));

  // by choice, the values in the
  for (size_t k = 0; k < sfd_size; k++)
  {
    double *z = space_filling_design + k * pso->dimensions;

    // point is new, evaluate it
    double fz = pso->f(z);

    // add to x_distinct
    add_to_distincts_if_distinct(pso, z, fz);

    // add to initial positions if it beats fmax or if it is in the popsize
    // first points
    z_eval[k].id = k;
    z_eval[k].eval = fz;
  }

  qsort(z_eval, sfd_size, sizeof(struct id_and_eval), &id_and_eval_compar);

  // take the popsize smallest in the initial positions
  for (size_t i = 0; i < pso->population_size; i++)
  {

    struct id_and_eval zi = z_eval[i];

    double *z = space_filling_design + zi.id * pso->dimensions;

    memcpy(PSO_X(pso, i), z, pso->dimensions * sizeof(double));
    PSO_FX(pso, i) = zi.eval;
  }

  free(z_eval);
}