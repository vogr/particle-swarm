#pragma once

#include "perf_ge_common.h"

void add_function_GE_SOLVE(comp_func f, char *name, int flop);
void register_functions_GE_SOLVE();
int perf_test_ge_solve(int N, double *Ab, double *x);
