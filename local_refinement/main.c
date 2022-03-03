#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "float.h"

typedef double (*blackbox_fun)(double const * const);

// Returns x_opt in R^d. The caller needs to take care of freeing the vector.
double* local_optimization(
    blackbox_fun f, // R^d -> R
    size_t dimensions, // R
    double* center, // R^d
    double xi, // R
    double* a, // R^d
    double* b // R^d
)
{
    // hyperparameter
    const size_t divisions = 10;

    /* Performing the intersection:
        [lo; hi] = [x-eta; x+eta] \and [a; b]
    */
    double* space_lo = malloc(sizeof(double) * dimensions);
    double* space_hi = malloc(sizeof(double) * dimensions);

    for(size_t it=0; it<dimensions; ++it) {
        if(a[it] <= center[it] - xi)
            space_lo[it] = center[it] - xi;
        else 
            space_lo[it] = a[it];
    }

    for(size_t it=0; it<dimensions; ++it) {
        if(b[it] >= center[it] + xi)
            space_lo[it] = center[it] + xi;
        else 
            space_lo[it] = b[it];
    }

    /*  Dividing the space [lo; hi] into a grid. 
        Each grid cube has side length (hi - lo) / divisions
        We then take the center as the representative of the cell
    */

    double** grid_centers = malloc(sizeof(double*) * divisions);
    for(size_t div_it=0; div_it<divisions; ++div_it) {
        grid_centers[div_it] = malloc(sizeof(double) * dimensions);

        for(size_t dim_it=0; dim_it<dimensions; ++dim_it) {
            double interval_length = (space_hi[dim_it] - space_lo[dim_it]) / divisions;
            
            grid_centers[div_it][dim_it] = space_lo[dim_it] + interval_length * (div_it + 0.5);
        }
    }

    /* We search for the grid_center that has the highest value under f
        Such grid_center will be our x_opt (return value)
    */
    size_t best_center_index = 0;
    double best_center_value = DBL_MAX;
    for(size_t div_it=0; div_it<divisions; ++div_it) {
        double v = f(grid_centers[div_it]);
        if(v < best_center_value) {
            best_center_index = div_it;
            best_center_value = v;
        }
    }

    /* Deallocating stuff:
        We do not deallocate grid_center[best_center_index]
        as this pointer is our return value.
        The caller will take care of deallocating the memory at this location.
    */

    free(space_lo);
    free(space_hi);

    for(size_t div_it=0; div_it<divisions; ++div_it) {
        if(div_it != best_center_index)
            free(grid_centers[div_it]);
    }
    free(grid_centers);

    return grid_centers[best_center_index]; 
}

double my_f(double const * const x)
{
    return (x[0] - 2) * (x[0] - 2) + (x[1] - 5) * (x[1] - 5);
}

void print_vector(double* vector, size_t dimensions) {
    printf("[");
    for(size_t it=0; it<dimensions; ++it) {
        printf("%lf ", vector[it]);
    }
    printf("]\n");
}

int main(int argc, char **argv)
{
    size_t dimensions = 2;
    double center[2] = {-3, 2};
    double xi = 0.1;
    double a[2] = {-5, 1};
    double b[2] = {-2, 5};

    double* x_opt = local_optimization(
        &my_f, 
        dimensions,
        center,
        xi,
        a,
        b
    );

    printf("estimated argmin:\n");
    print_vector(x_opt, dimensions);

    return 0;
}