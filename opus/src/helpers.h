#pragma once

#include <stdint.h>
#include <stdio.h>

// MATRIX UTILITIES USED WITHIN LU_SOLVING

// (deprecated) XXX Assume 'A' is an NxN defined in scope
#define AIX(ROW, COL) (A)[(N) * (ROW) + (COL)]
#define IX(ROW, COL) ((N) * (ROW) + (COL))

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

void print_matrixd(double const *M, int N, char const *name);
void print_rect_matrixd(double const *A, int n, int m, char const *name);

void print_vectord(double const *M, int N, char const *name);
void print_vectori(int const *M, int N, char const *name);
void print_vectoru64(uint64_t const *M, int N, char const *name);

int randrange(int N);
double rand_between(double a, double b);

double dist2(size_t dim, double const *x, double const *y);
double dist(size_t dim, double const *x, double const *y);
