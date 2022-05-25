#include "fit_surrogate.h"

#include "math.h"
#include "stdlib.h"

#include "../gaussian_elimination_solver.h"
#include "../helpers.h"

static void
fit_surrogate_prepare_phi_base(struct pso_data_constant_inertia *pso,
                               size_t n_A, double *Ab)
{
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
}

/*
  + inlining
*/
static void
fit_surrogate_prepare_phi_opt1(struct pso_data_constant_inertia *pso,
                               size_t n_A, double *Ab)
{
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

      double d2 = 0;
      for (size_t i = 0; i < pso->dimensions; i++)
      {
        double v = u_p[i] - u_q[i];
        d2 += v * v;
      }

      double d3 = pow(d2, 1.5);
      Ab[k1 * (n_A + 1) + k2] = d3;
    }
  }
}

/*
  inlining
  + order inversion
*/
static void
fit_surrogate_prepare_phi_opt1(struct pso_data_constant_inertia *pso,
                               size_t n_A, double *Ab)
{
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

      double d2 = 0;
      for (size_t i = 0; i < pso->dimensions; i++)
      {
        double v = u_p[i] - u_q[i];
        d2 += v * v;
      }

      double d3 = pow(d2, 1.5);
      Ab[k1 * (n_A + 1) + k2] = d3;
    }
  }
}

static void fit_surrogate_prepare_p_base(struct pso_data_constant_inertia *pso,
                                         size_t n_A, size_t n_phi, double *Ab)
{
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
}

fit_surrogate_prepare_zero_base(size_t n_A, size_t n_phi, double *Ab)
{
  // lower right block is zeros
  for (size_t i = n_phi; i < n_A; i++)
  {
    for (size_t j = n_phi; j < n_A; j++)
    {
      Ab[i * (n_A + 1) + j] = 0;
    }
  }
}

fit_surrogate_prepare_b_base(struct pso_data_constant_inertia *pso, size_t n_A,
                             size_t n_phi, double *Ab)
{
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
}

fit_surrogate_final_assignments_base(struct pso_data_constant_inertia *pso,
                                     size_t n_P, size_t n_phi, double *x)
{
  pso->lambda = (double *)realloc(pso->lambda, n_phi * sizeof(double));
  for (size_t i = 0; i < n_phi; i++)
  {
    pso->lambda[i] = x[i];
  }

  for (size_t i = 0; i < n_P; i++)
  {
    pso->p[i] = x[n_phi + i];
  }
}

// Step 4. Initialise y, y_eval, and x_eval for each particle
int fit_surrogate_base(struct pso_data_constant_inertia *pso)
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

  fit_surrogate_prepare_phi_base(pso, n_A, Ab);

  fit_surrogate_prepare_p_base(pso, n_A, n_phi, Ab);

  fit_surrogate_prepare_zero_base(n_A, n_phi, Ab);

  fit_surrogate_prepare_b_base(pso, n_A, n_phi, Ab);

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

  fit_surrogate_final_assignments_base(pso, n_P, n_phi, x);

  return 0;
}

// Step 4. Initialise y, y_eval, and x_eval for each particle
int fit_surrogate_opt1(struct pso_data_constant_inertia *pso)
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

  fit_surrogate_prepare_phi_opt1(pso, n_A, Ab);

  fit_surrogate_prepare_p_base(pso, n_A, n_phi, Ab);

  fit_surrogate_prepare_zero_base(n_A, n_phi, Ab);

  fit_surrogate_prepare_b_base(pso, n_A, n_phi, Ab);

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

  fit_surrogate_final_assignments_base(pso, n_P, n_phi, x);

  return 0;
}

int fit_surrogate_optimized(struct pso_data_constant_inertia *pso)
{
  fit_surrogate_opt1(pso);
}
