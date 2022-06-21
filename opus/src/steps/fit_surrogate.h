#pragma once

#include "../pso.h"

typedef int (*fit_surrogate_fun_t)(struct pso_data_constant_inertia *);

#ifndef FIT_SURROGATE_VERSION
#define FIT_SURROGATE_VERSION fit_surrogate_6
#define FIT_SURROGATE_PREALLOC_VERSION prealloc_fit_surrogate_6
#endif

int fit_surrogate(struct pso_data_constant_inertia *pso);
int prealloc_fit_surrogate(size_t max_n_phi, size_t n_P);

int fit_surrogate_0(struct pso_data_constant_inertia *pso);
int fit_surrogate_1(struct pso_data_constant_inertia *pso);
int fit_surrogate_2(struct pso_data_constant_inertia *pso);
int fit_surrogate_3(struct pso_data_constant_inertia *pso);
int fit_surrogate_4(struct pso_data_constant_inertia *pso);
int fit_surrogate_5(struct pso_data_constant_inertia *pso);
int fit_surrogate_6(struct pso_data_constant_inertia *pso);
int fit_surrogate_6_LU_blocked(struct pso_data_constant_inertia *pso);

int prealloc_fit_surrogate_0(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_1(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_2(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_3(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_4(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_5(size_t max_n_phi, size_t n_P);
int prealloc_fit_surrogate_6(size_t max_n_phi, size_t n_P);
