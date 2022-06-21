#pragma once

#ifndef GE_SOLVE_VERSION
#define GE_SOLVE_VERSION gaussian_elimination_solve_2
#endif

int gaussian_elimination_solve(int N, double *Ab, double *x);

#ifdef TEST_PERF

void register_functions_GE_SOLVE();

#endif
