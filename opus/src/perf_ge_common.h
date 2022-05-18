#pragma once

typedef int (*comp_func)(int N, double *Ab, double *x);
void add_function_GE_SOLVE(comp_func f, char *name, int flop);
