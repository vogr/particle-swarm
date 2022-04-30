#include "plu_factorization.h"

#include <stdlib.h>
#include <stdio.h>
#include <math.h>


#define DEBUG_LU 0

static void print_matrix(double *M, int N, char *name)
{
  printf("=== %s matrix ===\n", name);
  int i, j;
  for (i = 0; i < N; i++)
  {
    for (j = 0; j < N; j++)
      printf("%.4f ", M[N * i + j]);
    printf("\n");
  }
  printf("\n");
}



int alloc_plu_factorization(int N, plu_factorization * plu_ft)
{
    plu_ft->L = malloc(N * N * sizeof(double));
    plu_ft->U = malloc(N * N * sizeof(double));
    plu_ft->P = malloc(N * sizeof(int));

    return 0;
}

int free_plu_factorization(plu_factorization * plu_ft)
{
    free(plu_ft->P);
    free(plu_ft->U);
    free(plu_ft->L);

    return 0;
}

static void swapi(int * a, int i, int j)
{
    int t = a[i];
    a[i] = a[j];
    a[j] = t;
}

static void swapd(double * a, int i, int j)
{
    double t = a[i];
    a[i] = a[j];
    a[j] = t;
}


// Textual transformation assumes matrix size `N` is in scope.
#define IDX(MAT, ROW, COL) (MAT)[N * (ROW) + (COL)]

int plu_factorize(int N, double const * const A, plu_factorization * plu_ft)
{
    // NOTE: does not allocate memory, assumes plu_ft already contains allocated arrays
    
    // see https://www.clear.rice.edu/comp422/assignments/assignment2.html
    // for a pseudocode implementation
    
    double * L = plu_ft->L;
    double * U = plu_ft->U;
    int * P = plu_ft->P;

    // Initialize L
    for(int i = 0 ; i < N ; i++)
    {
        P[i] = i;
    }

    // Initialize L
    for (int i = 0; i < N; i++)
    {
        // Diagonal entries are 1.0
        IDX(L, i, i) = 1.0;
        for (int j = i + 1; j < N; j++)
        IDX(L, i, j) = 0.0;
    }

    // Initialize U
    for (int i = 0; i < N; i++)
        for (int j = 0; j < i; j++)
        IDX(U, i, j) = 0.0;


    #if DEBUG_LU
    printf("before lu\n");
    print_matrix(L,N,"L");
    print_matrix(U,N,"U");
    #endif

    for (int i = 0; i < N; i++)
    {
        // Find largest possible pivot in submatrix
        double p = 0.;
        int pivot_row_idx = -1;
        for(int k = i ; k < N ; k++)
        {
            double v = IDX(A, P[k], i);
            if (fabs(v) > fabs(p))
            {
                p = v;
                pivot_row_idx = k;
            }
        }
        
        if (pivot_row_idx < 0)
        {
            // singular matrix
            return -1;
        }

        if (i != pivot_row_idx)
        {
            // move row with largest possible pivot to
            // the top of the submatrix
            swapi(P, i, pivot_row_idx);

            // also need to swap the values in L
            for(int k = 0 ; k < i ; k ++)
            {
                swapd(L, i * N + k, pivot_row_idx * N + k);
            }
        }


        for (int j = i; j < N; j++)
        {
            IDX(U, i, j) = IDX(A, P[i], j);
            for (int k = 0; k <= i - 1; k++)
                IDX(U, i, j) = IDX(U, i, j) - IDX(L, i, k) * IDX(U, k, j);
        }

        for (int j = i + 1; j < N; j++)
        {
            IDX(L, j, i) = IDX(A, P[j], i);
            for (int k = 0; k <= i - 1; k++)
                IDX(L, j, i) = IDX(L, j, i) - IDX(L, j, k) * IDX(U, k, i);
            IDX(L, j, i) = IDX(L, j, i) / IDX(U, i, i);
        }


        #if DEBUG_LU
        printf("step i=%d\n", i);
        print_matrix(L,N,"L");
        print_matrix(U,N,"U");
        printf("P=[");
        for(int k = 0 ; k < N ; k++)
        {
            printf("%d ", P[k]);
        }
        printf(" ]\n\n");
        #endif

    }

    return 0;
}


int plu_solve(int N, plu_factorization const * plu_ft, double const * b, double * x)
{
    /*
     * A x = b  iff  P A x = P b
     *          iff  L U x = P b
     */
    
    double * L = plu_ft->L;
    double * U = plu_ft->U;
    int * P = plu_ft->P;

    // temporary vector to store result of forward substitution
    // L y = Pb
    double * y = malloc(N * sizeof(double));

    // Forward substitution
    for(int i = 0 ; i < N ; i++)
    {
        double v = b[P[i]];
        for (int j = 0 ; j < i ; j++)
        {
            v -= IDX(L, i, j) * y[j];
        }
        y[i] = v / IDX(L, i, i);
    }

    // Backward substitution
    // U x = y
    for(int i = N-1 ; i >= 0 ; i--)
    {
        double v = y[i];
        for (int j = i+1 ; j < N ; j++)
        {
            v -= IDX(U, i, j) * x[j];
        }
        x[i] = v / IDX(U, i, i);
    }

    free(y);

    return 0;
}