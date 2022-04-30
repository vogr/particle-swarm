#ifndef LU_DECOMPOSITION_H_
#define LU_DECOMPOSITION_H_

/**
 * LU Decomposition.
 *
 * About:
 *   This file contains a small utility for finding the LU decomposition
 *   of a given NxN matrix.
 *
 * Implementaiton details:
 *   The current implementation uses the "doolittle algorithm", without row
 *   permutation. I believe this is expected to exist for square matrices but I
 *   could be wrong, so please say so.
 *
 * Blame to: Gavin Gray
 * Last modified: 06.03.2022
 */

#include <stdlib.h>

// Textual transformation assumes matrix size `N` is in scope.
#define IDX(MAT, ROW, COL) (MAT)[N * (ROW) + (COL)]

typedef struct lu_decomposition
{
  double *L;
  double *U;
} lu_decomposition;

/**
 * LU_DECOMPOSE:
 *   Given an NxN matrix `A`, find its LU decomposition.
 *   `L` is a lower-triangular matrix with 1's on its diagonal.
 *   `U` is a upper-triangular matrix.
 *   Both results have the same shape as parameter `A`.
 *
 * Warning:
 *   (I think) A LU decomposition is not guaranteed to exist.
 * On failure:
 *   (should) return NULL (but doesn't FIXME).
 *
 * NOTE: If `A` is no longer needed after the decomposition
 *   a simple space optimization is to reuse its space for [L, U].
 */
lu_decomposition *lu_decompose(double *A, int N)
{
  lu_decomposition *to_return = malloc(sizeof(lu_decomposition));
  double *L = malloc(sizeof(double) * N * N);
  double *U = malloc(sizeof(double) * N * N);
  int i, j, k;

  // Initialize L
  for (i = 0; i < N; i++)
  {
    // Diagonal entries are 1.0
    IDX(L, i, i) = 1.0;
    for (j = i + 1; j < N; j++)
      IDX(L, i, j) = 0.0;
  }

  // Initialize U
  for (i = 0; i < N; i++)
    for (j = 0; j < i; j++)
      IDX(U, i, j) = 0.0;

  for (i = 0; i < N; i++)
  {
    for (j = i; j < N; j++)
    {
      IDX(U, i, j) = IDX(A, i, j);
      for (k = 0; k <= i - 1; k++)
        IDX(U, i, j) = IDX(U, i, j) - IDX(L, i, k) * IDX(U, k, j);
    }

    for (j = i + 1; j < N; j++)
    {
      IDX(L, j, i) = IDX(A, j, i);
      for (k = 0; k <= i - 1; k++)
        IDX(L, j, i) = IDX(L, j, i) - IDX(L, j, k) * IDX(U, k, i);
      IDX(L, j, i) = IDX(L, j, i) / IDX(U, i, i);
    }
  }

  to_return->L = L;
  to_return->U = U;

  return to_return;
}

#endif // LU_DECOMPOSITION_H_
