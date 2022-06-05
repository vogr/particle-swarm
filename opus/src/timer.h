#pragma once

#include "stdlib.h"
#include "perf_testers/tsc_x86.h"

static const char *fixed_steps_descriptions[3] = {
    "Evaluate points of space-filling design AND Determine initial swarm positions",
    "Determine initial particle velocities",
    "Initialize best position for each particle and overall best"
};

static const char *repeated_steps_description[7] = {
    "Fit surrogate",
    "Determine new particle positions",
    "Evaluate swarm positions",
    "Update best position for each particle and overall best",
    "Refit surrogate",
    "Perform local refinement of overall best position",
    "Determine if minimizer of surrogate is far from previous points"
};

static double* fixed_steps_cycles;
static size_t fixed_steps_count;

static double* repeated_steps_cycles;
static size_t repeated_steps_count;

#define FIXED_STEP(s) (fixed_steps_cycles[s])
#define REP_STEP(t, s) (repeated_steps_cycles[(t) * repeated_steps_count + s])

static void alloc_timer(size_t time_max, size_t fixed_steps_count_, size_t repeated_steps_count_) {
    fixed_steps_cycles = malloc(fixed_steps_count_ * sizeof(double));
    repeated_steps_cycles = malloc(time_max * repeated_steps_count_ * sizeof(double));

    fixed_steps_count = fixed_steps_count_;
    repeated_steps_count = repeated_steps_count_;
}

static myInt64 last_cycles_fixed;
static size_t step_it_fixed;

void timer_start_fixed() {
    step_it_fixed = 0;
    last_cycles_fixed = start_tsc();
}

static void timer_step_fixed() {
    myInt64 delta = stop_tsc(last_cycles_fixed);

    FIXED_STEP(step_it_fixed) = (double) delta;
    ++step_it_fixed;

    last_cycles_fixed = start_tsc();
}

static myInt64 last_cycles_rep;
static size_t step_it_rep;

static void timer_start_repeat() {
    step_it_rep = 0;
    last_cycles_rep = start_tsc();
}

static void timer_step_repeat(size_t timestep) {
    myInt64 delta = stop_tsc(last_cycles_rep);

    REP_STEP(timestep, step_it_rep) = (double) delta;
    ++step_it_rep;

    last_cycles_rep = start_tsc();
}

static void timer_print_statistics(size_t time_max) {

    printf("\nCYCLE COUNT BREAKDOWN ===============\n");

    // First collect total cycles

    double total = 0;

    for(size_t step = 0; step < fixed_steps_count; ++step) {
        total += FIXED_STEP(step);
    }

    for(size_t t = 0; t < time_max; ++t) {
        for(size_t step = 0; step < repeated_steps_count; ++step) {
                total += REP_STEP(t, step);
        }
    }

    printf("FIXED STEPS =========================\n");

    for(size_t step = 0; step < fixed_steps_count; ++step) {
        printf("Step %d: %lf cycles (%lf%%)\n", step + 1, FIXED_STEP(step), 100 * FIXED_STEP(step) / total);
        printf(" -> (%s)\n", fixed_steps_descriptions[step]);

    }

    printf("AVERAGES ============================\n");

    for(size_t step = 0; step < repeated_steps_count; ++step) {
        double step_total = 0;
        for(size_t t = 0; t < time_max; ++t) {
            step_total += REP_STEP(t, step);
        }
        printf("Step %d: %lf cycles (%lf%%), %lf cycles per step on average\n", step + 5, step_total, 100 * step_total / total, step_total / time_max);
        printf(" -> (%s)\n", repeated_steps_description[step]);
    }

    printf("=====================================\n");

}

