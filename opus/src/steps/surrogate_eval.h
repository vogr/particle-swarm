#pragma once

#include "../pso.h"

double surrogate_eval_base(struct pso_data_constant_inertia const *pso,
                           double const *x);
double surrogate_eval_optimized(struct pso_data_constant_inertia const *pso,
                                double const *x);
