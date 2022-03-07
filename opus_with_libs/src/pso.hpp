#pragma once


typedef double (*blackbox_fun)(double const * const);


void run_pso(
    blackbox_fun f,
    double inertia,
    double social, double cognition,
    int dimensions, int population_size, int time_max, int n_trials,
    double * bounds_low, double * bounds_high,
    double * vmin, double * vmax,
    double ** initial_positions
);