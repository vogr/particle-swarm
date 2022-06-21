#pragma once

#if 0
// Equivalent to DGETRS (no-transpose).
/** @brief Solves system of linear equations A * x = b.
 *         After exit b is overwritten with solution vector x.
 *
 * @param N Number of rows and columns in A.
 * @param A Real valued NxN matrix A which has been factored into [L\U].
 * @param ipiv Pivot indices used when factoring A.
 * @param b Real valued vector with N elements.
 */
int dgetrs(int N, double *A, int *ipiv, double *b);
#endif

int dgetrs_1(int N, double *A, int *ipiv, double *b);
int dgetrs_2(int N, double *A, int *ipiv, double *b);
int dgetrs_5(int N, double *A, int *ipiv, double *b);
int dgetrs_6(int N, double *A, int *ipiv, double *b);
