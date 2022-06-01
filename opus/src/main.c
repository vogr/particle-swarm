

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "logging.h"
#include "pso.h"

#include "helpers.h"

#include "latin_hypercube.h"
#include "timing.h"


#define POPSIZE 10
#define DIMENSION 20
#define SPACE_FILLING_DESIGN_SIZE 25

static double my_f(double const *const x)
{
  return (x[0] - 2) * (x[0] - 2) + (x[1] - 5) * (x[1] - 5);
}



static double griewank_Nd(double const *const x)
{
  // see https://mathworld.wolfram.com/GriewankFunction.html
  double r = 0;

  double d = 1. / 4000;
  for (size_t i = 0; i < DIMENSION; i++)
  {
    double v = x[i];
    r += v * v;
  }

  double t = 1;
  for (size_t i = 0; i < DIMENSION; i++)
  {
    t *= cos(x[i]) / sqrt((double)i + 1);
  }
  return (1. + d * r - t);
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

  double inertia = 0.3;
  double social = 0.2, cognition = 0.4;
  double local_refinement_box_size = 10.;
  double min_minimizer_distance = 0.5;
  int dimensions = DIMENSION;
  int population_size = POPSIZE;
  int time_max = 100;
  int n_trials = 10;
  double bounds_low[DIMENSION] = {0};
  double bounds_high[DIMENSION] = {0};
  double vmin[DIMENSION] = {0};
  double vmax[DIMENSION] = {0};

  for(size_t k = 0; k < DIMENSION ; k++)
  {
    bounds_low[k] = -500, bounds_high[k] = 700;
    vmin[k] = -20, vmax[k] = 20;
  }

  
  double lh[SPACE_FILLING_DESIGN_SIZE * DIMENSION] = {0};
  latin_hypercube(lh, SPACE_FILLING_DESIGN_SIZE, DIMENSION);


  double space_filling_design[SPACE_FILLING_DESIGN_SIZE * DIMENSION] = {0};
  for (size_t i = 0 ; i < SPACE_FILLING_DESIGN_SIZE ; i++)
  {
    for(size_t k = 0 ; k < DIMENSION ; k++ )
    {
      double lo = bounds_low[k], hi = bounds_high[k];
      space_filling_design[i * DIMENSION + k] = lo + (hi -lo) * lh[i * DIMENSION + k];
    }
  }

  print_rect_matrixd(space_filling_design, SPACE_FILLING_DESIGN_SIZE, DIMENSION, "space_filling_design");

  run_pso(&griewank_Nd, inertia, social, cognition, local_refinement_box_size,
          min_minimizer_distance, dimensions, population_size, time_max,
          n_trials, bounds_low, bounds_high, vmin, vmax, SPACE_FILLING_DESIGN_SIZE, space_filling_design);

  stop_logging();
}
