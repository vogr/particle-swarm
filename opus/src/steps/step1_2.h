#pragma once

#include "../pso.h"

#ifndef STEP1_2_VERSION
#define STEP1_2_VERSION step1_2_opt0
#endif

void step1_2(struct pso_data_constant_inertia *pso, size_t sfd_size,
             double *space_filling_design);

void step1_2_opt0(struct pso_data_constant_inertia *pso, size_t sfd_size,
                  double *space_filling_design);
