#pragma once

#if 0
// NOTE these functions have no declaration. However, a
// corresponding <name>_XXX  definition is made for each
// iteration XXX. This way performance testing is consistent.
// Forward declaration are here merely to have useful doc
// comments in one place.
// And YES, they are incorrectly using an (s) for single
// precision floats when they should be using a (d) for
// double precision (but I didn't notice until too late).

/** @brief Finds the index of the first element having maximum
 *         absolute value.
 *
 * @param N Number of elements in A.
 * @param A Real valued vector.
 * @param stride Space between elements
 * @return Index of the first element with the maximum absolute value.
 */
int idamax(int N, double *A, int stride);
#endif

int idamax_1(int N, double *A, int stride);
int idamax_2(int N, double *A, int stride);
