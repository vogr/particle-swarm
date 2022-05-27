module tests

# To add a new FFI test stub, include it here ----
include("ffi_lu_solve.jl")
include("ffi_gaussian_elimination.jl")
include("TestUtils.jl")

const tu = TestUtils


function solve_tests()
  # PSO_GE.solve_tests()
  LU.solve_tests()
end

function solve_perf_tests()
    n = 2^9
    local A
    local b
    while true
        A = tu.sym_n(n)
        b = rand(n)
        (!LU.valid(n, A, b) && !PSO_GE.valid(n, A, b)) || break
    end
  # PSO_GE.perf_tests(n, A, b)
  LU.perf_tests(n, A, b)
end

solve_tests()
# solve_perf_tests()


end # module
