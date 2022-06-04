#pragma once

// int triangular_system_solve(int N, double *Ab, double *x);
int triangular_system_solve(int N, int d, double *Ab, double *x);

int triangular_system_solve_0(int N, int d, double *Ab, double *x);

#ifdef TEST_PERF

void register_functions_TRI_SYS_SOLVE();

#endif
