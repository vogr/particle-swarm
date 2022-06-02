#pragma once

#include "../pso.h"

#ifndef STEP4_VERSION
#define STEP4_VERSION step4_opt1_memcpy
#endif

void step4(struct pso_data_constant_inertia *pso);

void step4_base(struct pso_data_constant_inertia *pso);
void step4_opt1(struct pso_data_constant_inertia *pso);
void step4_opt1_memcpy(struct pso_data_constant_inertia *pso);