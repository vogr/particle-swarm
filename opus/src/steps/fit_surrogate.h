#pragma once

#include "../pso.h"

#define prealloc_fit_surrogate prealloc_fit_surrogate_3
#define fit_surrogate fit_surrogate_3

int fit_surrogate_0(struct pso_data_constant_inertia *pso);
int fit_surrogate_1(struct pso_data_constant_inertia *pso);
int fit_surrogate_2(struct pso_data_constant_inertia *pso);
int fit_surrogate_3(struct pso_data_constant_inertia *pso);

int prealloc_fit_surrogate_0(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_1(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_2(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_3(size_t max_n_phi, size_t n_P);
