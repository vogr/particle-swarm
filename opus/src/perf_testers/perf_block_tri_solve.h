#pragma once

typedef int (*block_tri_solve_fun_t)(int N, int d, double *Ab, double *x);

void add_function_TRI_SYS_SOLVE(block_tri_solve_fun_t f, char *name, int flop);
void register_functions_TRI_SYS_SOLVE();
int perf_test_tri_sys_solve(int N, int d, double *Ab, double *x);
