

#include <stdio.h>

#include "pso.h"

/*
    TODO:
    In order to implement OPUS, some changes are necessary:
    - keep record of all the evaluations f(x_i) and the associated x_i (used for re-fit step)
    - solve linear system: hand-rolled (LU?) or library
    - find minimum on neighborhood: hand-rolled or library (project Ceres)
    - find way to check "if minimizer of surrogate is far from previous points"
        + see https://en.wikipedia.org/wiki/Nearest_neighbor_search
        + high dim naive search can be best  
*/


double my_f(double const * const x, void const * const additional_args)
{
    (void)additional_args;
    return (x[0] - 2) * (x[0] - 2) + (x[1] - 5) * (x[1] - 5);
}


int main(int argc, char **argv)
{
    int n_points = 1;
    double U[] = {
        10., 20.
    };
    double lambda[] = {
        3.
    };

    double inertia = 0.7;
    double social = 1., cognition = 1.;
    double local_refinement_box_size = 3.;
    double min_minimizer_distance = 1.;
    int dimensions = 2;
    int population_size = 5;
    int time_max = 100;
    int n_trials = 5;
    double bounds_low[2] = {-10., -10.};
    double bounds_high[2] = {10., 10.};
    double vmin[2] = {-10., -10.};
    double vmax[2] = {10., 10.};
    double initial_position_data[10] = {-1, 8, 5, -3, 5, 6, 7, 3, -9, -2};
    double * initial_positions[5];
    for(int i = 0; i < 5; i++)
        initial_positions[i] = initial_position_data + 2 * i;

    run_pso(
        &my_f,
        inertia, social, cognition,
        local_refinement_box_size,
        min_minimizer_distance,
        dimensions,
        population_size, time_max, n_trials,
        bounds_low, bounds_high,
        vmin, vmax,
        initial_positions       
    );

}