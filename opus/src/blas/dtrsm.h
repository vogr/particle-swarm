#pragma once

#if 0
/** @brief Solves matrix equation A * X = B
 *         A is assumed to be Non-transposed (L)ower
 *         triangular with a unit diagonal
 *         After exit, the matrix B is overwritten with
 *         the solution matrix X.
 *
 *  @param M Number of rows (height) of B.
 *  @param N Number of cols (width) of B.
 *  @param A Real valued matrix A.
 *  @param LDA Leading dimension of A.
 *  @param B Real valued matrix B.
 *  @param LDB Leading dimension of B.
 */
void dtrsm_L(int M, int N, double *A, int LDA, double *B, int LDB);

/** @brief equivalent to dtrsm_L except A is an (U)pper triangular matrix
 *         with a *Non-unit* diagonal. It is still assumed to be
non-transposed.
 */
void dtrsm_U(int M, int N, double *A, int LDA, double *B, int LDB);
#endif

void dtrsm_L_1(int M, int N, double *A, int LDA, double *B, int LDB);
void dtrsm_L_2(int M, int N, double *A, int LDA, double *B, int LDB);
void dtrsm_L_5(int M, int N, double *A, int LDA, double *B, int LDB);
void dtrsm_L_6(int M, int N, double *A, int LDA, double *B, int LDB);

void dtrsm_U_1(int M, int N, double *A, int LDA, double *B, int LDB);
void dtrsm_U_2(int M, int N, double *A, int LDA, double *B, int LDB);
void dtrsm_U_5(int M, int N, double *A, int LDA, double *B, int LDB);
void dtrsm_U_6(int M, int N, double *A, int LDA, double *B, int LDB);
