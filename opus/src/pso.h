#pragma once

#include <stdbool.h>
#include <sys/types.h>

#define USE_ROUNDING_BLOOM_FILTER 1

typedef double (*blackbox_fun)(double const *const);

// PSO_X : pso::pso, t:int, i:int -> x_i(t):double*
// PSO_FX : pso:pso, t:int, i:int -> f(x_i(t)):double
#define PSO_X(pso, t, i)                                                       \
  ((pso)->x + ((t) * (pso)->population_size + (i)) * (pso)->dimensions)
#define PSO_FX(pso, t, i) (pso)->x_eval[(t) * (pso)->population_size + (i)]

// PSO_V : pso::pso, i:int -> v_i:double*
#define PSO_V(pso, i) ((pso)->v + (i) * (pso)->dimensions)

// PSO_Y : pso::pso, i:int -> y_i:double*
// PSO_FY : pso::pso, i:int -> f(y_i):double
#define PSO_Y(pso, i) ((pso)->y + (i) * (pso)->dimensions)
#define PSO_FY(pso, i) (pso)->y_eval[(t) * (pso)->population_size + (i)]

// PSO_PAST_REFINEMENT : pso::pso, k:int -> epsilon_k:double*
// PSO_PAST_REFINEMENT_EVAL : pso:pso, k:int -> f(epsilon_k):double
#define PSO_PAST_REFINEMENT(pso, k)                                            \
  ((pso)->past_refinement_points + (k) * (pso)->dimensions)
#define PSO_PAST_REFINEMENT_EVAL(pso, k) (pso)->past_refinement_points_eval[k]

// for other inertia choices, see https://ieeexplore.ieee.org/document/6089659
struct pso_data_constant_inertia
{
  blackbox_fun f;
  // positions x_i, saved for all times
  // i.e. PSO_X(pso, t, i) is the position vector x_i(t)
  double *x;
  // PSO_FX(pso, t, i) = f(x_i(t))
  double *x_eval;

  // PSO_V(pso,i) = v_i
  double *v;

  // PSO_Y(pso,i) := y_i := best position ever recorded for particle i
  double *y;
  // PSO_FY(pso,i) := f(y_i)
  double *y_eval;

  // ŷ = best position ever recorded over all particles
  // here a pointer to one of the y_i or in past_refinement_points
  double *y_hat;

  double *x_trial;
  double *v_trial;

  double *x_trial_best;
  double *v_trial_best;

  // Used in steps 10 and 11 in local refinement 
  double *x_local;

  // Keep track of local refinement points.
  // max lenght of list = tmax
  // current length  = n_past_refinement_points
  double *past_refinement_points;
  double *past_refinement_points_eval;

  double *bound_low;
  double *bound_high;
  double *vmin;
  double *vmax;

  // pre-alocated storage for fit_surrogate
  double *fit_surrogate_Ab;
  double *fit_surrogate_x;

  // list of idx of distinct
  size_t *x_distinct;
  size_t x_distinct_s;
#ifdef USE_ROUNDING_BLOOM_FILTER
  struct rounding_bloom *bloom;
#endif

  // parameters of the surrogate
  double *lambda;
  double *p;

  double inertia;
  double social;
  double cognition;

  double local_refinement_box_size;
  double min_minimizer_distance;

  double y_hat_eval;

  int dimensions;
  int population_size;
  int n_trials;

  int n_past_refinement_points;

  int time_max;
  int time;
};

void run_pso(blackbox_fun f, double inertia, double social, double cognition,
             double local_refinement_box_size, double min_minimizer_distance,
             int dimensions, int population_size, int time_max, int n_trials,
             double *bounds_low, double *bounds_high, double *vmin,
             double *vmax, double *initial_positions);