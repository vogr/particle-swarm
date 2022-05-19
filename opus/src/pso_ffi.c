#include "pso.h"


double * get_current_particle_positions(struct pso_data_constant_inertia * pso)
{
    return PSO_X(pso, pso->time, 0);
}


double * get_current_particle_velocities(struct pso_data_constant_inertia * pso)
{
    return PSO_V(pso, 0);
}