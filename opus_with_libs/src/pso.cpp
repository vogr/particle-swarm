#include "pso.hpp"

#include <cstdio>
#include <cstdlib>
#include <cstdbool>
#include <cmath>

#include "helpers.hpp"

#include <Eigen/Dense>
#include <Eigen/LU>

namespace {

// for other inertia choices, see https://ieeexplore.ieee.org/document/6089659
struct pso_data_constant_inertia
{
    blackbox_fun f;
    // positions x_i, saved for all times
    double *** x;
    // f(x_i), for all times
    double ** x_eval;

    // velocity v_i
    double ** v;
    // best position recorded y_i
    double ** y;


    // Keep track of local refinement points.
    // max lenght of list = tmax
    // double ** local_refinement_points;
    // double * local_refinement_points_eval; 

    // storage for the trial positions and velocities before
    double ** x_trial;
    double ** v_trial;

    double * bound_low;
    double * bound_high;
    double * vmin;
    double * vmax;
    double * y_eval;

    // parameters of the surrogate
    double * lambda;
    double * p;

    double inertia;
    double social;
    double cognition;
    int y_best_id;
    int dimensions;
    int population_size;
    int n_trials;

    int nb_refinment_points;

    int time_max;
    int time;
};


void fit_surrogate(struct pso_data_constant_inertia * pso)
{

    //TODO: note that the matrix and vector barely change between the
    // iterations. Maybe there could be a way to re-use them?

    // the size of phi is the total number of points where
    // f has been evaluated
    // currently : n = population_size * (time + 1)
    size_t n_phi = pso->population_size * (pso->time + 1);

    // the size of P is n x d+1
    size_t n_P = pso->dimensions + 1;

    // the size of the matrix in the linear system is n+d+1
    size_t n_A = n_phi + n_P;

    Eigen::MatrixXd A = Eigen::MatrixXd::Zero(n_A,n_A);

    // Phi is the top left block
    Eigen::Ref<Eigen::MatrixXd> phi = A.block(0,0,n_phi,n_phi);



    // phi_p,q = || u_p - u_q ||
    // currently the {u_p} = {x_i(t=j)} i=0..pop_size, j=0..time+1

    size_t p = 0;
    for(int t1=0 ; t1 < pso->time+1 : t1++)
    {
        for (int i1 = 0 ; i1 < pso->population_size ; i1++)
        {
            double * u_p = pso->x[t1][i1];

            size_t q = 0;
            for (int t2 = 0 ; t2 = pso->time+1 ; t2++)
            {
                for (int i2 = 0 ; i2 < pso->population_size ; i2++)
                {
                    double * u_q = pso->x[t2][i2]

                    double s = 0;

                    for (int j = 0 ; j < pso->dimensions ; j++)
                    {
                        s = s + (u_p[j] - u_q[j]) * (u_p[j] - u_q[j]);
                    }

                    phi(p,q) = sqrt(s);

                    q++;
                }
            }
            p++;
        }
    }


    // P is a block in A
    Eigen::Ref<Eigen::MatrixXd> P = A.block(0,n_phi+1,n_phi,n_P);
    Eigen::Ref<Eigen::MatrixXd> tP = A.block(n_phi+1,0,n_P,n_phi);

    p = 0;
    for (int t = 0 ; t < pso->time + 1 ; t++)
    {
        for (int i = 0 ; i < pso->population_size ; i++)
        {
            double * u = pso->x[t][i];

            P(p,0) = 1;
            tp(0,p) = 1;
            for (int j = 0 ; j < pso->dimensions ; j++)
            {
                P(p,1+j) = u[j];
                tP(1+j,p) = u[j];
            }
            p++;
        }
    }

    // right hand side
    Eigen::VectorXd b = Eigen::VectorXd::Zero(n_phi);

    p = 0;
    for (int t = 0 ; t < pso->time_max + 1 ; t++)
    {
        for (int i = 0 ; i < pso->population_size < i ++)
        {
            b(p) = pso->x_eval[t][i];
        }
    }


    Eigen::VectorXd X = A.partialPivLu().solve(b);
    for (int i = 0 ; i < n_phi ; i++)
    {
        pso->lambda[i] = X(i);
    }
    for(int i = 0 ; i < n_P ; i++)
    {
        pso->p[i] = X(n_phi + i);
    }
}


void pso_constant_inertia_init(
    struct pso_data_constant_inertia * pso,
    blackbox_fun f,
    double inertia,
    double social, double cognition,
    int dimensions, int population_size, int time_max, int n_trials,
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
    pso->time_max = time_max, pso->n_trials = n_trials;
    pso->time = 0;

    pso->x = (double***)malloc(pso->time_max * sizeof(double **));
    for (int t = 0 ; t < pso->time_max ; t++)
    {
        pso->x[t] = (double**)malloc(pso->population_size * sizeof(double*));
        for (int i = 0 ; i < pso->population_size ; i++)
        {
            pso->x[t][i] = (double*)malloc(pso->dimensions * sizeof(double));
        }
    }

    pso->x_eval = (double**)malloc(pso->time_max * sizeof(double *));
    for (int t = 0 ; t < pso->time_max ; t++)
    {
        pso->x_eval[t] = (double*)malloc(pso->population_size * sizeof(double));
    }



    pso->v = (double**)malloc(pso->population_size * sizeof(double *));
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        pso->v[i] = (double*)malloc(pso->dimensions * sizeof(double));
    }

    pso->y = (double**)malloc(pso->population_size * sizeof(double *));
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        pso->y[i] = (double*)malloc(pso->dimensions * sizeof(double));
    }


    pso->x_trial = (double**)malloc(pso->n_trials * sizeof(double *));
    for (int l = 0 ; l < pso->n_trials ; l++)
    {
        pso->x_trial[l] = (double*)malloc(pso->dimensions * sizeof(double));
    }

    pso->v_trial = (double**)malloc(pso->n_trials * sizeof(double *));
    for (int l = 0 ; l < pso->n_trials ; l++)
    {
        pso->v_trial[l] = (double*)malloc(pso->dimensions * sizeof(double));
    }

    pso->bound_low = (double*)malloc(dimensions * sizeof(double));
    pso->bound_high = (double*)malloc(dimensions * sizeof(double));

    pso->vmin = (double*)malloc(dimensions * sizeof(double));
    pso->vmax = (double*)malloc(dimensions * sizeof(double));

    pso->y_eval= (double*)malloc(pso->population_size * sizeof(double *));


    pso->lambda = (double*)malloc(pso->)

    // setup x
    for (int i = 0 ; i < population_size ; i ++)
    {
        for (int j = 0 ; j < dimensions ; j++)
        {
            pso->x[0][i][j] = initial_positions[i][j];
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


void pso_constant_inertia_first_steps(struct pso_data_constant_inertia * pso)
{
    //TODO: step 1 and 2 "space-filling design"

    // Step 3. Initialize particle velocities
    for(int i = 0 ; i < pso->population_size ; i++)
    {
        for (int k=0 ; k < pso->dimensions ; k++)
        {
            double uk = rand_between(pso->bound_low[k], pso->bound_high[k]);
            pso->v[i][k] = 1. / 2 * (uk - pso->x[0][i][k]);
        }
    }

    // Step 4. Initialise y, y_eval, and x_eval for each particle 
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        for (int k = 0 ; k < pso->dimensions ;  k++)
        {
            pso->y[i][k] = pso->x[0][i][k];
        }

        double x_eval = pso->f(pso->x[0][i]);
        pso->y_eval[i] = x_eval;
        pso->x_eval[0][i] = x_eval;

    }

    // find ŷ
    
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


bool pso_constant_inertia_loop(struct pso_data_constant_inertia * pso)
{
    int const t = pso->time;
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
                pso->cognition * w1 * (pso->y[i][j] - pso->x[t][i][j]) +
                pso->social * w2 * (pso->y[pso->y_best_id][j] - pso->x[t][i][j]);

            pso->v[i][j] = clamp(v, pso->vmin[j], pso->vmax[j]);
        }
    }


    // Step 5. Update particle positions
    for (int i = 0 ; i < pso->population_size ; i++)
    {
        for(int j = 0 ; j < pso->dimensions ; j++)
        {
            pso->x[t+1][i][j] = clamp(
                pso->x[t][i][j] + pso->v[i][j],
                pso->bound_low[j],
                pso->bound_high[j]
            );
        }
    }


    // Step 7. Update the best position

    for (int i = 0 ; i < pso->population_size ; i++)
    {
        double x_i_eval = pso->f(pso->x[t+1][i]);
        pso->x_eval[t][i] = x_i_eval;
        if (x_i_eval < pso->y_eval[i])
        {
            // y_i <- x_i
            for (int j = 0 ; j < pso->dimensions ; j++)
            {
                pso->y[i][j] = pso->x[t+1][i][j];
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

} // end namespace


void run_pso(
    blackbox_fun f,
    double inertia,
    double social, double cognition,
    int dimensions, int population_size, int time_max, int n_trials,
    double * bounds_low, double * bounds_high,
    double * vmin, double * vmax,
    double ** initial_positions
)
{
    struct pso_data_constant_inertia pso;
    pso_constant_inertia_init(
        &pso,
        f,
        inertia, social, cognition,
        dimensions, population_size, time_max, n_trials,
        bounds_low, bounds_high,
        vmin, vmax,
        initial_positions
    );

    pso_constant_inertia_first_steps(&pso);

    do {
        printf("t=%d  ŷ=[", pso.time);
        for (int j = 0 ; j < dimensions ; j++)
        {
            printf("%f", pso.y[pso.y_best_id][j]);
            if (j < dimensions - 1) printf(", ");
        }
        printf("]  f(ŷ)=%f\n", pso.y_eval[pso.y_best_id]);
    } while(pso_constant_inertia_loop(&pso));
}