#pragma once

/***
 * Partial pivoting into PLU factorization
 * PA = LU
 ***/

typedef struct plu_factorization
{
  // L is a unitary lower-diagonal matrix
  // U is an upper diagonal matrix
  // P is a permutation matrix represented as an integer vector
  double *L;
  double *U;
  int *P;
} plu_factorization;

// FIXME shouldn't it be a `size_t N`
int alloc_plu_factorization(int N, plu_factorization *plu_ft);
int free_plu_factorization(plu_factorization *plu_ft);

int plu_factorize(int N, double *A, plu_factorization *plu_ft);

int plu_solve(int N, plu_factorization const *plu_ft, double const *b,
              double *x);
