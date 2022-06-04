module tests

# To add a new FFI test stub, include it here ----
include("ffi_lu_solve.jl")
include("ffi_gaussian_elimination.jl")
include("ffi_mmm.jl")
include("TestUtils.jl")
include("ffi_tri_sys_solve.jl")

const tu = TestUtils

function register_perf_tested_functions()
  ccall((:register_functions_TRI_SYS_SOLVE, :libpso), Cvoid, ()) 
  ccall((:register_functions_GE_SOLVE, :libpso), Cvoid, ()) 
  ccall((:register_functions_LU_SOLVE, :libpso), Cvoid, ()) 
  ccall((:register_functions_MMM, :libpso), Cvoid, ()) 
end

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

function solve_perf_tests_block_tri_single(n)
  local A
  local b
  local d
  local d
  while true
    # d = n ÷ 3
    d = 30
    c = n - d
    A = tu.build_block_triangular_matrix(c, d)
    b = rand(n)
    (!PSO_TRI_SYS.valid(n, d, A, b)) ||
        break
  end
  PSO_TRI_SYS.perf_tests(n, d, A, b)
end

function solve_perf_tests_block_tri_range(iterable)
  for i in iterable
    solve_perf_tests_block_tri_single(i)
  end
end

register_perf_tested_functions()

LU.init(2^15)

# solve_tests()
# MMM.perf_tests(1024, 1024, 1024)
# solve_perf_tests_range(2^10:2^10:(2^10)+1)

# solve_tests()
# MMM.perf_tests(1024, 256, 256 * 2)
# solve_perf_tests_single(2^9)
# solve_perf_tests_range(100:500:1024)
# PSO_GE.solve_tests()

# PSO_TRI_SYS.solve_tests()

start = round(Int, 100^(1/3))
# step = round(Int, 100^(1/3))
step = 1
stop = round(Int, 10000^(1/3))

range = [n^3 for n = start:step:stop]
print(range, '\n')
solve_perf_tests_range(range)
solve_perf_tests_block_tri_range(range)

# LU.teardown()

end # module
