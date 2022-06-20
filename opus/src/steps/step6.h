#pragma once

#include "../pso.h"

#ifndef STEP6_VERSION
#define STEP6_VERSION step6_opt3
#endif

void step6_base(struct pso_data_constant_inertia *pso);
void step6_optimized(struct pso_data_constant_inertia *pso);
