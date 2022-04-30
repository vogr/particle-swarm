

#include <cstdio>

#include "pso_globals.hpp"
#include "pso.hpp"

#include "ceres/ceres.h"

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


class RBFSurrogate {
public:
    int n_points;
    // i = 0..n_points
    // U[i*dim + 0..dim] = u_i
    double * U;
    double * lambda;

    // j = 0..DIMENSION+1
    double * p_coeffs;

    RBFSurrogate(int n_points, double * U, double * lambda)
    : n_points{n_points}, U{U}, lambda{lambda}
    { }


    template <typename T>
    bool operator()(const T* parameters, T* cost) const {
        T s = 0;
        for(int i = 0 ; i < n_points ; i++)
        {
            T d2 = 0;
            for (int j = 0 ; j < DIMENSION ; j++)
            {
                T x_j = parameters[j];
                double ui_j = U[i * n_points + j];
                T diff = x_j - ui_j;
                d2 += diff * diff;
            }
            T d = std::sqrt(d2);
            s += lambda[i] * d * d *d;
        }

        s+= p_coeffs[0];
        for (int j = 0 ; j < DIMENSION ; j++)
        {
            T x_j = parameters[j];
            s += p_coeffs[j+1] * x_j;
        }

        *cost = s;

        return true;
    }

  static ceres::FirstOrderFunction* Create(int n_points, double * U, double * lambda) {
    return new ceres::AutoDiffFirstOrderFunction<RBFSurrogate, DIMENSION>(new RBFSurrogate(n_points, U, lambda));
  }
};

double my_f(double const * const x)
{
    return (x[0] - 2) * (x[0] - 2) + (x[1] - 5) * (x[1] - 5);
}


int main(int argc, char **argv)
{
    int n_points = 1;
    double U[] = {
        10., 20.
    };
    double lambda[] = {
        3.
    };

    ceres::GradientProblem problem(RBFSurrogate::Create(n_points, U, lambda));

    ceres::GradientProblemSolver::Options options;
    options.minimizer_progress_to_stdout = true;
    ceres::GradientProblemSolver::Summary summary;


    double x_min[] = {0.,0.};
    ceres::Solve(options, problem, x_min, &summary);

    std::cout << summary.FullReport() << "\n";
}

#if 0
    double inertia = 0.7;
    double social = 1., cognition = 1.;
    int population_size = 5;
    int time_max = 100;
    int n_trials = 5;
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
        population_size, time_max, n_trials,
        bounds_low, bounds_high,
        vmin, vmax,
        initial_positions       
    );

#endif
}