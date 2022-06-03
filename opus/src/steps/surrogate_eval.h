#pragma once

#include "../pso.h"

typedef double (*surrogate_eval_fun_t)(
    struct pso_data_constant_inertia const *pso, double const *x);

#ifndef SURROGATE_EVAL_VERSION
#define SURROGATE_EVAL_VERSION surrogate_eval_5
#endif

double surrogate_eval(struct pso_data_constant_inertia const *pso,
                      double const *x);

double surrogate_eval_0(struct pso_data_constant_inertia const *pso,
                        double const *x);

double surrogate_eval_1(struct pso_data_constant_inertia const *pso,
                        double const *x);

double surrogate_eval_2(struct pso_data_constant_inertia const *pso,
                        double const *x);

double surrogate_eval_3(struct pso_data_constant_inertia const *pso,
                        double const *x);

double surrogate_eval_4(struct pso_data_constant_inertia const *pso,
                        double const *x);

double surrogate_eval_5(struct pso_data_constant_inertia const *pso,
                        double const *x_ptr);