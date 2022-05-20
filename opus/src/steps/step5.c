#include "step5.h"

#include "stdlib.h"
#include "stdio.h"

#include "math.h"
#include "../gaussian_elimination_solver.h"

int fit_surrogate(struct pso_data_constant_inertia *pso)
{
  // TODO: include past_refinement_points in phi !!!

  // TODO: note that the matrix and vector barely change between the
  //  iterations. Maybe there could be a way to re-use them?

  // the size of phi is the total number of _distinct_ points where
  // f has been evaluated
  // currently : n = x_distinct_s
  size_t n_phi = pso->x_distinct_s; // + pso->n_past_refinement_points

  // the size of P is n x d+1
  size_t n_P = pso->dimensions + 1;

  // the size of the matrix in the linear system is n+d+1
  size_t n_A = n_phi + n_P;

  double *Ab = pso->fit_surrogate_Ab;

  /********
   * Prepare left hand side A
   ********/

  // phi_p,q = || u_p - u_q ||
  // currently the {u_p} = {x_i(t=j)} i=0..pop_size, j=0..time+1

  for (size_t k1 = 0; k1 < pso->x_distinct_s; k1++)
  {
    size_t p = pso->x_distinct[k1];
    double *u_p = pso->x + p * pso->dimensions;

    for (size_t k2 = 0; k2 < pso->x_distinct_s; k2++)
    {
      size_t q = pso->x_distinct[k2];
      double *u_q = pso->x + q * pso->dimensions;
      double d2 = dist2(pso->dimensions, u_p, u_q);
      double d = sqrt(d2);
      double d3 = d2 * d;
      Ab[k1 * (n_A + 1) + k2] = d3;
    }
  }

  // P and tP are blocks in A
  // P_{i,j} := A_{i,n_phi + j} = A[i * n_A + n_phi + j]
  // tP_{i,j} := A_{n_phi + i, j} = A[(n_phi + i) * n_A + j]

  for (size_t k = 0; k < pso->x_distinct_s; k++)
  {
    size_t p = pso->x_distinct[k];
    double *u = pso->x + p * pso->dimensions;

    // P(p,0) = 1;
    Ab[k * (n_A + 1) + n_phi + 0] = 1;
    // tP(0,p) = 1;
    Ab[(n_phi + 0) * (n_A + 1) + k] = 1;

    for (int j = 0; j < pso->dimensions; j++)
    {
      // P(p,1+j) = u[j];
      Ab[k * (n_A + 1) + n_phi + j + 1] = u[j];
      // tP(1+j,p) = u[j];
      Ab[(n_phi + 1 + j) * (n_A + 1) + k] = u[j];
    }
  }

  // lower right block is zeros
  for (size_t i = n_phi; i < n_A; i++)
  {
    for (size_t j = n_phi; j < n_A; j++)
    {
      Ab[i * (n_A + 1) + j] = 0;
    }
  }

  /********
   * Prepare right hand side b
   ********/
  for (size_t k = 0; k < n_phi; k++)
  {
    size_t p = pso->x_distinct[k];
    // set b_k
    Ab[k * (n_A + 1) + n_A] = pso->x_eval[p];
  }

  for (size_t k = n_phi; k < n_A; k++)
  {
    // set b_k
    Ab[k * (n_A + 1) + n_A] = 0;
  }

#if DEBUG_SURROGATE
  print_rect_matrixd(Ab, n_A, n_A + 1, "Ab");
#endif

  double *x = pso->fit_surrogate_x;

  if (gaussian_elimination_solve(n_A, Ab, x) < 0)
  {
    return -1;
  }

#if DEBUG_SURROGATE
  print_vectord(x, n_A, "x");
#endif

  pso->lambda = (double *)realloc(pso->lambda, n_phi * sizeof(double));
  for (size_t i = 0; i < n_phi; i++)
  {
    pso->lambda[i] = x[i];
  }

  for (size_t i = 0; i < n_P; i++)
  {
    pso->p[i] = x[n_phi + i];
  }

  return 0;
}

void step5_base(struct pso_data_constant_inertia *pso)
{
  // Step 5.
  // Fit surrogate
  // f already evaluated on x[0..t][0..i-1]
  if (fit_surrogate(pso) < 0)
  {
    fprintf(stderr, "ERROR: Failed to fit surrogate\n");
    exit(1);
  }

#if LOG_SURROGATE
  {
    char fname[256] = {0};
    snprintf(fname, sizeof(fname), "surrogate_step5_t_%05d.struct", t);
    log_surrogate(fname, pso->lambda, pso->p, pso->x, t, pso->dimensions,
                  pso->population_size);
  }
#endif
}

void step5_optimized(struct pso_data_constant_inertia *pso) 
{
    step5_base(pso);
}