#pragma once

#if 0
/** @brief Swap interchanges two vectors.
 *
 * @param N The number of elements in vectors X and Y to swap.
 * @param X The first vector of real valued elements to swap.
 * @param incx The storage stride between elements in X.
 * @param Y The second vector of real valued elements to swap.
 * @param incy The storage stride between elements in Y.
 */
void dswap(int N, double *X, int incx, double *Y, int incy);
#endif

void dswap_1(int N, double *X, int incx, double *Y, int incy);
void dswap_2(int N, double *X, int incx, double *Y, int incy);

void dswap_6(int N, double *X, int incx, double *Y, int incy);
