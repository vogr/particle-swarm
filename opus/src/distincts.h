#pragma once

#include "pso.h"

#ifndef CHECK_IF_DISTINCT_VERSION
#define CHECK_IF_DISTINCT_VERSION check_if_distinct_1
#endif

double *add_to_distincts_unconditionnaly(struct pso_data_constant_inertia *pso,
                                         double const *const x, double x_eval);

int check_if_distinct(struct pso_data_constant_inertia *pso,
                      double const *const x, int add_to_cache);

int add_to_distincts_if_distinct(struct pso_data_constant_inertia *pso,
                                 double const *const x, double x_eval);

int check_if_distinct_0(struct pso_data_constant_inertia *pso,
                        double const *const x, int add_to_cache);
int check_if_distinct_1(struct pso_data_constant_inertia *pso,
                        double const *const x, int add_to_cache);
