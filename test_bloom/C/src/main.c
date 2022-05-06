
#include <stdio.h>


#include "rounding_bloom.h"

int main(int argc, char ** argv)
{
    int ret;
    int dims = 3;
    double lower_bound[] = {1., 2., 3.};

    struct rounding_bloom b;
    rounding_bloom_init(&b, 4096, 0.01, 0.1, dims, lower_bound);

    rounding_bloom_print(&b);


    int N = 13;
    double x[] = {
        1.e10, 2.e10, 3.e10,
        1.e30,2e30,3e30,
        1.2,2,3,
        1.3,2,3,
        1.4,2,3,
        1.5, 2, 3,
        1.6, 2, 3,
        1.7, 2, 3,
        1.8, 2, 3,
        1.9,2,3,
        2.0,2,3,
        2.1,2,3,
        4.6,2,3
    };
    for (int i = 0 ; i < N ; i++)
    {
        ret = rounding_bloom_check_add(&b, dims, x + dims * i, 1);
        printf("check: %d\n\n", ret);
    }
}