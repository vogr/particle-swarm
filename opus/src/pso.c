#include "pso.h"

#include <float.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "gaussian_elimination_solver.h"
#include "helpers.h"
#include "local_refinement.h"

#include "steps/steps.h"

#define DEBUG_TRIALS 0
#define DEBUG_SURROGATE 0

#define LOG_SURROGATE 0

#if LOG_SURROGATE
#include "logging.h"
#endif

#if USE_ROUNDING_BLOOM_FILTER
#include "rounding_bloom.h"
#endif

double rand_between(double a, double b)
{
  // see http://c-faq.com/lib/randrange.html
  return a + (double)rand() / ((double)RAND_MAX / (b - a));
}

double dist2(size_t dim, double const *x, double const *y)
{
  double s = 0;
  for (size_t i = 0; i < dim; i++)
  {
    double v = x[i] - y[i];
    s += v * v;
  }
  return s;
}

static double dist(size_t dim, double const *x, double const *y)
{
  return sqrt(dist2(dim, x, y));
}

int fit_surrogate(struct pso_data_constant_inertia *pso)
{
  // TODO: include past_refinement_points in phi !!!

  // TODO: note that the matrix and vector barely change between the
  //  iterations. Maybe there could be a way to re-use them?

  // the size of phi is the total number of _distinct_ points where
  // f has been evaluated
  // currently : n = x_distinct_s
  size_t n_phi = pso->x_distinct_s; // + pso->n_past_refinement_points

  // the size of P is n x d+1
  size_t n_P = pso->dimensions + 1;

  // the size of the matrix in the linear system is n+d+1
  size_t n_A = n_phi + n_P;

  double *Ab = pso->fit_surrogate_Ab;

  /********
   * Prepare left hand side A
   ********/

  // phi_p,q = || u_p - u_q ||
  // currently the {u_p} = {x_i(t=j)} i=0..pop_size, j=0..time+1

  for (size_t k1 = 0; k1 < pso->x_distinct_s; k1++)
  {
    size_t p = pso->x_distinct[k1];
    double *u_p = pso->x + p * pso->dimensions;

    for (size_t k2 = 0; k2 < pso->x_distinct_s; k2++)
    {
      size_t q = pso->x_distinct[k2];
      double *u_q = pso->x + q * pso->dimensions;
      double d2 = dist2(pso->dimensions, u_p, u_q);
      double d = sqrt(d2);
      double d3 = d2 * d;
      Ab[k1 * (n_A + 1) + k2] = d3;
    }
  }

  // P and tP are blocks in A
  // P_{i,j} := A_{i,n_phi + j} = A[i * n_A + n_phi + j]
  // tP_{i,j} := A_{n_phi + i, j} = A[(n_phi + i) * n_A + j]

  for (size_t k = 0; k < pso->x_distinct_s; k++)
  {
    size_t p = pso->x_distinct[k];
    double *u = pso->x + p * pso->dimensions;

    // P(p,0) = 1;
    Ab[k * (n_A + 1) + n_phi + 0] = 1;
    // tP(0,p) = 1;
    Ab[(n_phi + 0) * (n_A + 1) + k] = 1;

    for (int j = 0; j < pso->dimensions; j++)
    {
      // P(p,1+j) = u[j];
      Ab[k * (n_A + 1) + n_phi + j + 1] = u[j];
      // tP(1+j,p) = u[j];
      Ab[(n_phi + 1 + j) * (n_A + 1) + k] = u[j];
    }
  }

  // lower right block is zeros
  for (size_t i = n_phi; i < n_A; i++)
  {
    for (size_t j = n_phi; j < n_A; j++)
    {
      Ab[i * (n_A + 1) + j] = 0;
    }
  }

  /********
   * Prepare right hand side b
   ********/
  for (size_t k = 0; k < n_phi; k++)
  {
    size_t p = pso->x_distinct[k];
    // set b_k
    Ab[k * (n_A + 1) + n_A] = pso->x_eval[p];
  }

  for (size_t k = n_phi; k < n_A; k++)
  {
    // set b_k
    Ab[k * (n_A + 1) + n_A] = 0;
  }

#if DEBUG_SURROGATE
  print_rect_matrixd(Ab, n_A, n_A + 1, "Ab");
#endif

  double *x = pso->fit_surrogate_x;

  if (gaussian_elimination_solve(n_A, Ab, x) < 0)
  {
    return -1;
  }

#if DEBUG_SURROGATE
  print_vectord(x, n_A, "x");
#endif

  pso->lambda = (double *)realloc(pso->lambda, n_phi * sizeof(double));
  for (size_t i = 0; i < n_phi; i++)
  {
    pso->lambda[i] = x[i];
  }

  for (size_t i = 0; i < n_P; i++)
  {
    pso->p[i] = x[n_phi + i];
  }

  return 0;
}

double surrogate_eval(struct pso_data_constant_inertia const *pso,
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

struct pso_data_constant_inertia *alloc_pso_data_constant_inertia()
{
  return malloc(sizeof(struct pso_data_constant_inertia));
}

void random_number_generation(struct pso_data_constant_inertia *pso)
{
  // Step 3
  pso->step3_rands =
      malloc(pso->population_size * pso->dimensions * sizeof(double));
  for (int i = 0; i < pso->population_size; i++)
  {
    for (int k = 0; k < pso->dimensions; k++)
    {
      PSO_STEP3_RAND(pso, i)
      [k] = rand_between(pso->bound_low[k], pso->bound_high[k]);
    }
  }
}

void pso_constant_inertia_init(
    struct pso_data_constant_inertia *pso, blackbox_fun f, double inertia,
    double social, double cognition, double local_refinement_box_size,
    double min_minimizer_distance, int dimensions, int population_size,
    int time_max, int n_trials, double *bounds_low, double *bounds_high,
    double *vmin, double *vmax, double *initial_positions)
{
  pso->f = f;
  pso->inertia = inertia;
  pso->dimensions = dimensions;
  pso->social = social, pso->cognition = cognition;
  pso->local_refinement_box_size = local_refinement_box_size;
  pso->min_minimizer_distance = min_minimizer_distance;
  pso->population_size = population_size;
  pso->time_max = time_max, pso->n_trials = n_trials;

  pso->n_past_refinement_points = 0;
  pso->time = 0;

  pso->x = (double *)malloc(pso->time_max * pso->population_size *
                            pso->dimensions * sizeof(double));

  pso->x_eval = malloc(pso->time_max * pso->population_size * sizeof(double));

  pso->v = malloc(pso->population_size * pso->dimensions * sizeof(double));

  pso->y = malloc(pso->population_size * pso->dimensions * sizeof(double));

  pso->y_eval = malloc(pso->population_size * sizeof(double *));

  pso->past_refinement_points =
      malloc(pso->time_max * pso->dimensions * sizeof(double));
  pso->past_refinement_points_eval =
      malloc(pso->population_size * sizeof(double));

  pso->v_trial = malloc(pso->dimensions * sizeof(double));
  pso->x_trial = malloc(pso->dimensions * sizeof(double));

  pso->v_trial_best = malloc(pso->dimensions * sizeof(double));
  pso->x_trial_best = malloc(pso->dimensions * sizeof(double));

  pso->x_local = malloc(pso->dimensions * sizeof(double));

  pso->bound_low = (double *)malloc(pso->dimensions * sizeof(double));
  pso->bound_high = (double *)malloc(pso->dimensions * sizeof(double));

  pso->vmin = (double *)malloc(pso->dimensions * sizeof(double));
  pso->vmax = (double *)malloc(pso->dimensions * sizeof(double));

  for (int j = 0; j < dimensions; j++)
  {
    pso->vmin[j] = vmin[j];
    pso->vmax[j] = vmax[j];
  }

  // the size of phi is the total number of _distinct_ points where
  // f has been evaluated
  // max: pop_size * time
  //  TODO: add the refinement points + 1 * time
  //        add the space filling design +?
  size_t max_n_phi = pso->time_max * pso->population_size;
  size_t n_P = pso->dimensions + 1;
  size_t max_n_A = max_n_phi + n_P;
  // Ab size: n x n for A and n x 1 for b
  size_t Ab_size = max_n_A * max_n_A + max_n_A;

  pso->fit_surrogate_Ab = malloc(Ab_size * sizeof(double));
  pso->fit_surrogate_x = malloc(max_n_A * sizeof(double));

  pso->x_distinct =
      malloc(pso->time_max * pso->population_size * sizeof(size_t));
  pso->x_distinct_s = 0;

#if USE_ROUNDING_BLOOM_FILTER
  pso->bloom = malloc(sizeof(struct rounding_bloom));
  int bloom_entries = pso->time_max * pso->population_size;
  if (bloom_entries < 1000)
    bloom_entries = 1000;
  double bloom_false_pos_rate = 0.001;
  double bloom_rounding_eps = 0.1;
  rounding_bloom_init(pso->bloom, bloom_entries, bloom_false_pos_rate,
                      bloom_rounding_eps, dimensions, bounds_low);
#else
// No data structure needed for naive search
#endif

  // will realloc in fit_surrogate
  pso->lambda = NULL;
  pso->p = malloc((pso->dimensions + 1) * sizeof(double));

  // setup x
  for (int i = 0; i < population_size; i++)
  {
    // add it to the point cloud
    for (int j = 0; j < pso->dimensions; j++)
    {
      PSO_X(pso, 0, i)[j] = initial_positions[i * pso->dimensions + j];
    }

// Check if x is distinct
#if USE_ROUNDING_BLOOM_FILTER
    // add and check proximity to previous points
    if (!rounding_bloom_check_add(pso->bloom, dimensions, PSO_X(pso, 0, i), 1))
    {
      pso->x_distinct[pso->x_distinct_s] = i;
      pso->x_distinct_s++;
    }
#else
    // naive implementation with distance computation
    fprintf(stderr, "Not implemented.\n");
    exit(1);
#endif
  }

  // setup bounds in space
  for (int k = 0; k < pso->dimensions; k++)
    pso->bound_low[k] = bounds_low[k];
  for (int k = 0; k < pso->dimensions; k++)
    pso->bound_high[k] = bounds_high[k];
  // setup bounds on velocity
  for (int k = 0; k < pso->dimensions; k++)
    pso->vmin[k] = vmin[k];
  for (int k = 0; k < pso->dimensions; k++)
    pso->vmax[k] = vmax[k];

  // precomputed random numbers
  random_number_generation(pso);
}

// TODO: step 1 and 2 "space-filling design"
void step1(struct pso_data_constant_inertia *pso) {}

void step2(struct pso_data_constant_inertia *pso) {}

void pso_constant_inertia_first_steps(struct pso_data_constant_inertia *pso)
{
  step1(pso);
  step2(pso);
  step3_optimized(pso);
  step4_optimized(pso);
}

bool pso_constant_inertia_loop(struct pso_data_constant_inertia *pso)
{
  step5_optimized(pso);
  step6_optimized(pso);
  step7_optimized(pso);
  step8_optimized(pso);
  step9_optimized(pso);
  step10_optimized(pso);
  step11_optimized(pso);

  return (pso->time < pso->time_max - 1);
}

void run_pso(blackbox_fun f, double inertia, double social, double cognition,
             double local_refinement_box_size, double min_minimizer_distance,
             int dimensions, int population_size, int time_max, int n_trials,
             double *bounds_low, double *bounds_high, double *vmin,
             double *vmax, double *initial_positions)
{
  struct pso_data_constant_inertia pso;
  pso_constant_inertia_init(
      &pso, f, inertia, social, cognition, local_refinement_box_size,
      min_minimizer_distance, dimensions, population_size, time_max, n_trials,
      bounds_low, bounds_high, vmin, vmax, initial_positions);

  pso_constant_inertia_first_steps(&pso);

  printf("t=%d  ŷ=[", pso.time);
  for (int j = 0; j < dimensions; j++)
  {
    printf("%f", pso.y_hat[j]);
    if (j < dimensions - 1)
      printf(", ");
  }
  printf("]  f(ŷ)=%f\n", pso.y_hat_eval);

  while (pso.time < pso.time_max - 1)
  {
    pso_constant_inertia_loop(&pso);

    printf("t=%d  ŷ=[", pso.time);
    for (int j = 0; j < dimensions; j++)
    {
      printf("%f", pso.y_hat[j]);
      if (j < dimensions - 1)
        printf(", ");
    }
    printf("]  f(ŷ)=%f\n", pso.y_hat_eval);
  }
}
