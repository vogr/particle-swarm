module tests

# To add a new FFI test stub, include it here ----
include("ffi_lu_solve.jl")
include("ffi_gaussian_elimination.jl")


LU.solve_tests()

# PSO_GE.solve_tests()
# PSO_GE.perf_tests()

end # module
