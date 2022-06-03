#pragma once

typedef int (*lu_solve_fun_t)(int N, double *A, double *b);

void add_function_LU_SOLVE(lu_solve_fun_t f, char *name, int flop);
void register_functions_LU_SOLVE();
int perf_test_lu_solve(int N, double *A, double *b);

void lu_initialize_memory(int N);
void lu_free_memory();
