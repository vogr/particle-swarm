#pragma once

#if 0
/** @brief compute C := alpha * A * B + beta * C
 *
 * @param M Number of rows (height) of A and C.
 * @param N Number of cols (width) of B and C.
 * @param K Number of cols (width) of A and rows (height) of B.
 * @param alpha Scalar alpha.
 * @param A Real valued MxK matrix A.
 * @param LDA Leading dimension of A.
 * @param B Real valued KxN matrix B.
 * @param LDB Leading dimension of B.
 * @param beta Scalar beta.
 * @param C Real valued MxN matrix C.
 * @param Leading dimension of C.
 */
void dgemm(int M, int N, int K, double alpha, double *A, int LDA, double *B,
           int LDB, double beta, double *C, int LDC);
#endif

void dgemm_initialize_memory(int max_n);
void dgemm_free_memory();

void dgemm_1(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC);
void dgemm_2(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC);
void dgemm_3(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC);
void dgemm_4(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC);
void dgemm_5(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC);
void dgemm_6(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC);

void dgemm_intel(int M, int N, int K, double alpha, double *A, int LDA,
                 double *B, int LDB, double beta, double *C, int LDC);
void dgemm_intelT(int M, int N, int K, double alpha, double *A, int LDA,
                  double *B, int LDB, double beta, double *C, int LDC);

#ifdef TEST_PERF

void register_functions_MMM();

#endif
