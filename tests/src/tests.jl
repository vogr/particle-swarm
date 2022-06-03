module tests

# To add a new FFI test stub, include it here ----
include("ffi_lu_solve.jl")
include("ffi_gaussian_elimination.jl")
include("ffi_mmm.jl")
include("TestUtils.jl")
include("ffi_tri_sys_solve.jl")

const tu = TestUtils


function solve_tests()
  # PSO_GE.solve_tests()
  LU.solve_tests()
end

function solve_perf_tests_single(n)
  local A
  local b
  while true
      A = tu.sym_n(n)
      b = rand(n)
      (!LU.valid(n, A, b) ||
          !PSO_GE.valid(n, A, b)) ||
          break
  end
  PSO_GE.perf_tests(n, A, b)
  LU.perf_tests(n, A, b)
end

function solve_perf_tests_range(iterable)
    for i in iterable
        solve_perf_tests_single(i)
    end
end

# solve_tests()
# MMM.perf_tests(1024, 256, 256 * 2)
# solve_perf_tests_single(2^9)
# solve_perf_tests_range(100:500:1024)
# PSO_GE.solve_tests()
PSO_TRI_SYS.solve_tests()


end # module
