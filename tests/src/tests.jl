module tests

# To add a new FFI test stub, include it here ----
include("ffi_plu_factorization.jl")
include("ffi_gaussian_elimination.jl")


# PLU.factorization_tests()
# PLU.solve_tests()

# PSO_GE.solve_tests()
PSO_GE.perf_tests()

end # module
