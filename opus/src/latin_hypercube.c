

#include "helpers.h"

#include <stdlib.h>

void shuffle(size_t a_t, int * a)
{
    // Fisher–Yates shuffle
    for(size_t i = a_t - 1 ; i != -1 ; i--)
    {
        int j = randrange(i+1);
        int t = a[j];
        a[j] = a[i];
        a[i] = t;
    }
}

void latin_hypercube(double * lh, size_t n, size_t d)
{
    // lh[i * d + k] i in 0..n, k in 0..d

    int * bin_ids = malloc(n * sizeof(int));
    for(size_t b = 0 ; b < n ; b++)
    {
        bin_ids[b] = (int)b;
    }

    double bin_size = 1. / n;

    for (size_t k = 0 ; k < d ; k++)
    {
        // distribute among 1st dimension
        shuffle(n, bin_ids);
        // determine position in each bin
        for(size_t i = 0 ; i < n ; i++)
        {
            int bid = bin_ids[i];
            double r = rand_between(bid * bin_size, (bid + 1) * bin_size);
            lh[i * d + k] = r;
        }
    }

    free(bin_ids);
}