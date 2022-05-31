#pragma once

// int triangular_system_solve(int N, double *Ab, double *x);
int triangular_system_solve(int N, double *Ab, double *x, size_t d);

#ifdef TEST_PERF

void register_functions_TRI_SYS_SOLVE();

#endif
