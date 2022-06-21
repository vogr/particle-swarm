#pragma once

#if 0
// Assume No-transpose for both matrices
/** @brief Factor A = P * L * U in place using BLAS1 / BLAS2 functions
 *
 * @param M The number of rows (height) of A.
 * @param N The number of columns (width) of A.
 * @param A Real valued matrix in which to factor [L\U].
 * @param LDA The leading dimension of the matrix in memory A.
 * @param ipiv Pivot indices for A.
 */
int dgetf2(int M, int N, double *A, int LDA, int *ipiv);
#endif

int dgetf2_1(int M, int N, double *A, int LDA, int *ipiv);
int dgetf2_2(int M, int N, double *A, int LDA, int *ipiv);

int dgetf2_5(int M, int N, double *A, int LDA, int *ipiv);
int dgetf2_6(int M, int N, double *A, int LDA, int *ipiv);
