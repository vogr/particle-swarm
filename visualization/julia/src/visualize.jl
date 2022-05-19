

include("run_pso_ffi.jl")

DIMENSIONS=2

function my_f(a_ptr::Ptr{Cdouble})::Cdouble
    x = unsafe_wrap(Array, a_ptr, DIMENSIONS; own = false)
    return (x[1] - 2) * (x[1] - 2) + (x[2] - 5) * (x[2] - 5);
end
    

params = RUN_PSO.PsoParams(
    @cfunction(my_f, Cdouble, (Ptr{Cdouble},)),
    0.7, 1., 1.,
    1., 1.,
    DIMENSIONS, 5, 100, 5,
    [-10., -10.], [10., 10.],
    [-10., 10.], [10., 10.],
    [-1., 8., 5., -3., 5., 6., 7., 3., -9., -2.]
)

pso = RUN_PSO.pso_alloc()

RUN_PSO.pso_init(params, pso)

cur_pos = RUN_PSO.pso_current_positions(pso, params.pop_size, params.dimensions)

RUN_PSO.pso_first_steps(pso)

cur_pos = RUN_PSO.pso_current_positions(pso, params.pop_size, params.dimensions)
for k in 1:params.pop_size
    println("x_$k(0): $(cur_pos[:, k])")
end


for i in 1:100

    RUN_PSO.pso_mainloop(pso)

    cur_pos = RUN_PSO.pso_current_positions(pso, params.pop_size, params.dimensions)
    
    for k in 1:params.pop_size
        println("x_$k($i): $(cur_pos[:, k])")
    end
end

