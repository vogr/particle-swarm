#pragma once

#if 0
/** @brief Perform a series of row interchanges, one for each row
 *         k1 - k2 of A.
 *
 * @param N The number of column in MxN matrix A.
 * @param A MxN real valued matrix.
 * @param LDA Leading dimension of A.
 * @param k1 The first element of ipiv to interchange rows.
 * @param k2 (k2 - k1) elements of ipiv to do row interchanges.
 * @param ipiv The array of vector pivot indices such that i <-> ipiv[i].
 * @param incx The increment between indices in ipiv.
 */
void dlaswp(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx);
#endif

void dlaswp_1(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx);
void dlaswp_2(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx);
void dlaswp_5(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx);
void dlaswp_6(int N, double *A, int LDA, int k1, int k2, int *ipiv, int incx);
