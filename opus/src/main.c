

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "logging.h"
#include "pso.h"

#include "timing.h"

double my_f(double const *const x)
{
  return (x[0] - 2) * (x[0] - 2) + (x[1] - 5) * (x[1] - 5);
}

double griewank_4d(double const *const x)
{
  // see https://mathworld.wolfram.com/GriewankFunction.html
  double r = 1;

  for (int i = 0; i < 4; i++)
  {
    r += 1. / 4000. * x[i] * x[i];
  }

  double t = 1;
  for (int i = 0; i < 4; i++)
  {
    t *= cos(x[i]) / sqrt((double)i + 1);
  }
  return (r - t);
}

int main(int argc, char **argv)
{
  if (argc > 1)
  {
    printf("Logging to %s\n", argv[1]);
    set_logging_directory(argv[1]);
  }

  //  uint64_t seed = time(NULL);
  uint64_t seed = 42;
  srand(seed);

  printf("Starting PSO with seed %" PRIu64 "\n", seed);

  double inertia = 0.7;
  double social = 1., cognition = 1.;
  double local_refinement_box_size = 3.;
  double min_minimizer_distance = 1.;
  int dimensions = 2;
  int population_size = 5;
  int time_max = 100;
  int n_trials = 4;
  double bounds_low[4] = {-10., -10., -10., -10.};
  double bounds_high[4] = {10., 10., 10., 10.};
  double vmin[4] = {-10., -10., -10., -10.};
  double vmax[4] = {10., 10., 10., 10.};
  double initial_positions[20] = {-1, 8, 5,  -3, 5,  6,  7,  3, -9, -2,
                                  9,  1, -9, 7,  -9, -8, -5, 1, 9,  -5};

  run_pso(&griewank_4d, inertia, social, cognition, local_refinement_box_size,
          min_minimizer_distance, dimensions, population_size, time_max,
          n_trials, bounds_low, bounds_high, vmin, vmax, initial_positions);

  stop_logging();
}
