#pragma once

#include "../pso.h"

#ifndef STEP3_VERSION
#define STEP3_VERSION step3_opt4
#endif

void step3(struct pso_data_constant_inertia *pso);

void step3_base(struct pso_data_constant_inertia *pso);
void step3_opt1(struct pso_data_constant_inertia *pso);
void step3_opt2(struct pso_data_constant_inertia *pso);
void step3_opt3(struct pso_data_constant_inertia *pso);
void step3_opt4(struct pso_data_constant_inertia *pso);
