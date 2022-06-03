#pragma once

#define LINEAR_SYSTEM_SOLVER_USED BLOCK_TRI_SOLVER

#define GE_SOLVER 1
#define LU_SOLVER 2
#define BLOCK_TRI_SOLVER 3

#include "../gaussian_elimination_solver.h"
#include "../lu_solve.h"
#include "../triangular_system_solver.h"
