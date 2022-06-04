#pragma once

#include <math.h>
#include <stdlib.h>

// NOTE When working with a matrix inset in another, you must
// index into it using this macro. Explicitly specifying the
// leading dimension which *must* be available.
#define MIX(MAT, LDIM, ROW, COL) (MAT)[((LDIM) * (ROW) + (COL))]
// Memory accesses for transposed layout
#define TIX(MAT, LDIM, ROW, COL) MIX(MAT, LDIM, COL, ROW)
#define ONE 1.E0
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define ERR_THRESHOLD 1.0E-20
#define APPROX_EQUAL(l, r) (fabs((l) - (r)) <= ERR_THRESHOLD)

/** @brief Solve linear systems using LU factorization method.
 *
 * @param A: The segment of memory representing a row-major square
 *           matrix layed out sequentially in memory.
 * @param b: Column vector b in Ax=b
 * @param ipiv: Pivot indices, row i was interchanged with row ipiv[i].
 * @param x: Output buffer for column vector x in Ax=b
 * @param N: The length of one side.
 * @return: 0 on success. <0 for matrix singularity.
 */
int lu_solve(int N, double *A, double *b);
void lu_initialize_memory(int max_n);
void lu_free_memory();

void sgemm_1T(int M, int N, int K, double alpha, double *A, int LDA, double *B,
              int LDB, double beta, double *C, int LDC);
void sgemm_5(int M, int N, int K, double alpha, double *A, int LDA, double *B,
             int LDB, double beta, double *C, int LDC);

#ifdef TEST_PERF

void register_functions_LU_SOLVE();
void register_functions_MMM();

#endif
