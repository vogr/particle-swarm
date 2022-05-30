#pragma once

int triangular_system_solve(int N, double *Ab, double *x);

#ifdef TEST_PERF

void register_functions_TRI_SYS_SOLVE();

#endif
