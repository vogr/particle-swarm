#pragma once

typedef void (*mmm_fun_t)(int M, int N, int K, double alpha, double *A, int LDA,
                          double *B, int LDB, double beta, double *C, int LDC);

void add_function_MMM(mmm_fun_t f, char *name, int flop);
void register_functions_MMM();
int perf_test_mmm(int M, int N, int K, double alpha, double *A, int LDA,
                  double *B, int LDB, double beta, double *C, int LDC);
