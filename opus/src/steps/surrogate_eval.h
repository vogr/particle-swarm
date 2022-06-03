#pragma once

#include "../pso.h"
#include <immintrin.h>

#ifndef SURROGATE_EVAL_VERSION
#define SURROGATE_EVAL_VERSION 0
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
