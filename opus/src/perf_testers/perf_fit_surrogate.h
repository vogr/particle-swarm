#pragma once

#include "../steps/fit_surrogate.h"

void add_function_FIT_SURROGATE(fit_surrogate_fun_t f, char const *name,
                                int flop);
void register_functions_FIT_SURROGATE();
int perf_test_fit_surrogate(struct pso_data_constant_inertia *);
