#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef double (*blackbox_fun)(double const * const);


/*
    TODO:
    In order to implement OPUS, some changes are necessary:
    - keep record of all the evaluations f(x_i) and the associated x_i (used for re-fit step)
    - solve linear system: hand-rolled (LU?) or library
    - find minimum on neighborhood: hand-rolled or library (project Ceres)
    - find way to check "if minimizer of surrogate is far from previous points"
        + see https://en.wikipedia.org/wiki/Nearest_neighbor_search
        + high dim naive search can be best  
*/


// for other inertia choices, see https://ieeexplore.ieee.org/document/6089659
struct pso_data_constant_inertia
{
    blackbox_fun f;
    // positions x_i
    double ** x;
    // velocity v_i
    double ** v;
    // best position recorded y_i
    double ** y;
    double * bound_low;
    double * bound_high;
    double * vmin;
    double * vmax;
    double * y_eval;
    double inertia;
    double social;
    double cognition;
    int y_best_id;
    int dimensions;
    int population_size;
    int time_max;
    int time;
};

double rand_between(double a, double b)
{
    // see http://c-faq.com/lib/randrange.html
    return a + (double)rand() / ((double)RAND_MAX / (b - a));
}


double clamp(double v, double lo, double hi)
{
    if (v < lo)
    {
        return lo;
    }
    else if (v > hi)
    {
        return hi;
    }
    else
    {
        return v;
    }
}

void init_pso_constant_inertia(
    struct pso_data_constant_inertia * pso,
    blackbox_fun f,
    double inertia,
    double social, double cognition,
    int dimensions, int population_size, int time_max,
    double * bounds_low, double * bounds_high,
    double * vmin, double * vmax,
    double ** initial_positions
)
{
    pso->f = f;
    pso->inertia = inertia;
    pso->social = social, pso->cognition = cognition;
    pso->vmin = vmin, pso->vmax = vmax;
    pso->dimensions = dimensions, pso->population_size = population_size;
    pso->time_max = time_max;
    pso->time = 0;

    pso->x = malloc(pso->population_size * sizeof(double *));
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        pso->x[i] = malloc(pso->dimensions * sizeof(double));
    }

    pso->v = malloc(pso->population_size * sizeof(double *));
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        pso->v[i] = malloc(pso->dimensions * sizeof(double));
    }

    pso->y = malloc(pso->population_size * sizeof(double *));
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        pso->y[i] = malloc(pso->dimensions * sizeof(double));
    }


    pso->bound_low = malloc(dimensions * sizeof(double));
    pso->bound_high = malloc(dimensions * sizeof(double));

    pso->vmin = malloc(dimensions * sizeof(double));
    pso->vmax = malloc(dimensions * sizeof(double));

    pso->y_eval= malloc(pso->population_size * sizeof(double *));

    // setup x
    for (int i = 0 ; i < population_size ; i ++)
    {
        for (int k = 0 ; k < dimensions ; k++)
        {
            pso->x[i][k] = initial_positions[i][k];
        }
    }

    // setup bounds in space
    for(int k = 0 ; k < dimensions ; k++)
        pso->bound_low[k] = bounds_low[k];
    for(int k = 0 ; k < dimensions ; k++)
        pso->bound_high[k] = bounds_high[k];
    // setup bounds on velocity
    for(int k = 0 ; k < dimensions ; k++)
        pso->vmin[k] = vmin[k];
    for(int k = 0 ; k < dimensions ; k++)
        pso->vmax[k] = vmax[k];
}


void initialize_pso(struct pso_data_constant_inertia * pso)
{
    // Step 2. Initialize particle velocities
    for(int i = 0 ; i < pso->population_size ; i++)
    {
        for (int k=0 ; k < pso->dimensions ; k++)
        {
            double uk = rand_between(pso->bound_low[k], pso->bound_high[k]);
            pso->v[i][k] = 1. / 2 * (uk - pso->x[i][k]);
        }
    }

    // Step 3. Initialise best position for each particle 
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        for (int k = 0 ; k < pso->dimensions ;  k++)
        {
            pso->y[i][k] = pso->x[i][k];
        }
    }

    

    // Initialize ŷ and the list of f(y_i)
    
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        pso->y_eval[i] = pso->f(pso->y[i]);
    }
    
    pso->y_best_id = 0;
    double best_y_eval = pso->y_eval[0];
    for (int i = 1 ; i < pso->population_size ; i++)
    {
        if (pso->y_eval[i] < best_y_eval)
        {
            pso->y_best_id = i;
            best_y_eval = pso->y_eval[i];
        }
    }
}


bool pso_loop_constant_inertia(struct pso_data_constant_inertia * pso)
{
    // Step 4. Update particle velocities
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        for (int j = 0 ; j < pso->dimensions ; j++)
        {
            // compute v_i(t+1) from v_i(t)

            double w1 = (double)rand() / RAND_MAX;
            double w2 = (double)rand() / RAND_MAX;
            double v =
                pso->inertia * pso->v[i][j] +
                pso->cognition * w1 * (pso->y[i][j] - pso->x[i][j]) +
                pso->social * w2 * (pso->y[pso->y_best_id][j] - pso->x[i][j]);

            pso->v[i][j] = clamp(v, pso->vmin[j], pso->vmax[j]);
        }
    }


    // Step 5. Update particle positions
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        for(int j = 0 ; j < pso->dimensions ; j++)
        {
            pso->x[i][j] = clamp(
                pso->x[i][j] + pso->v[i][j],
                pso->bound_low[j],
                pso->bound_high[j]
            );
        }
    }


    // Step 7. Update the best position

    for (int i = 0 ; i < pso->population_size ; i++)
    {
        double x_i_eval = pso->f(pso->x[i]);
        if (x_i_eval < pso->y_eval[i])
        {
            // y_i <- x_i
            for (int j = 0 ; j < pso->dimensions ; j++)
            {
                pso->y[i][j] = pso->x[i][j];
            }
            pso->y_eval[i] = x_i_eval;

            // is x_i(t+1) better than ŷ(t) ?
            if (x_i_eval < pso->y_eval[pso->y_best_id])
            {
                pso->y_best_id = i;
            }
        }
        
    }

    pso->time++;

    return (pso->time < pso->time_max);
}


void run_pso(
    blackbox_fun f,
    double inertia,
    double social, double cognition,
    int dimensions, int population_size, int time_max,
    double * bounds_low, double * bounds_high,
    double * vmin, double * vmax,
    double ** initial_positions
)
{
    struct pso_data_constant_inertia pso = {0};
    init_pso_constant_inertia(
        &pso,
        f,
        inertia, social, cognition,
        dimensions, population_size, time_max,
        bounds_low, bounds_high,
        vmin, vmax,
        initial_positions
    );

    initialize_pso(&pso);

    do {
        printf("t=%d  ŷ=[", pso.time);
        for (int j = 0 ; j < dimensions ; j++)
        {
            printf("%f", pso.y[pso.y_best_id][j]);
            if (j < dimensions - 1) printf(", ");
        }
        printf("]  f(ŷ)=%f\n", pso.y_eval[pso.y_best_id]);
    } while(pso_loop_constant_inertia(&pso));
}


double my_f(double const * const x)
{
    return (x[0] - 2) * (x[0] - 2) + (x[1] - 5) * (x[1] - 5);
}


int main(int argc, char **argv)
{
    int dimensions = 2;
    double inertia = 0.7;
    double social = 1., cognition = 1.;
    int population_size = 5;
    int time_max = 100;
    double bounds_low[2] = {-10., -10.};
    double bounds_high[2] = {10., 10.};
    double vmin[2] = {-10., -10.};
    double vmax[2] = {10., 10.};
    double initial_position_data[10] = {-1, 8, 5, -3, 5, 6, 7, 3, -9, -2};
    double * initial_positions[5];
    for(int i = 0; i < 5; i++)
        initial_positions[i] = initial_position_data + 2 * i;

    run_pso(
        &my_f,
        inertia, social, cognition,
        dimensions, population_size, time_max,
        bounds_low, bounds_high,
        vmin, vmax,
        initial_positions       
    );
}