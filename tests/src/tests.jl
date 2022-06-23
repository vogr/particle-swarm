module tests

import Printf: @info

include("ffi_lu_solve.jl")
include("ffi_gaussian_elimination.jl")
include("ffi_mmm.jl")
include("TestUtils.jl")
include("ffi_tri_sys_solve.jl")

const tu = TestUtils

function register_perf_tested_functions()
  ccall(tu.lookup(tu.libpso, :register_functions_TRI_SYS_SOLVE), Cvoid, ())
  ccall(tu.lookup(tu.libpso, :register_functions_GE_SOLVE), Cvoid, ())
  ccall(tu.lookup(tu.libpso, :register_functions_LU_SOLVE), Cvoid, ())
  ccall(tu.lookup(tu.libpso, :register_functions_MMM), Cvoid, ())
end

function solve_perf_tests_block_tri_single(n)
  local A
  local b
  local d
  local d
  while true
    # d = n ÷ 3
    d = 31
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

function solve_all_perf_tests_single(n)
  local A1
  local A2
  local b
  local d
  while true
      d = 31
      c = n - d

      A1, A2 = tu.build_matrices(c, d)
      b = rand(n)
      LU.valid(n, A1, b) && break
  end
  PSO_GE.perf_tests(n, A1, b)
  LU.perf_tests(tu.libpso, n, A1, b)
  PSO_TRI_SYS.perf_tests(n, d, A2, b)
end

function solve_all_perf_tests_range(iterable)
  for i in iterable
    solve_all_perf_tests_single(i)
  end
end

# ----------------------------
# ONLY MODIFY CODE BELOW THIS LINE

max_size = 2^20
mmm_results = "mmm_log.log"
solve_results = "solve_log.log"
autotune_results = "autotune_log.log"

# ------
# Uniform testing range
start = round(Int, 50^(1/3))
step = 1
stop = round(Int, 4097^(1/3))
range = [n^3 for n = start:step:stop]

function autotuning_lu_main(libs_to_perf)
    for lib_symbol in libs_to_perf
        tu.set_lib(lib_symbol)
        ccall(tu.lookup(tu.libpso, :register_functions_LU_SOLVE), Cvoid, ())
        ccall(tu.lookup(tu.libpso, :register_functions_MMM), Cvoid, ())
        LU.init(tu.libpso, max_size)
    end
    redirect_stdio(stdout=autotune_results) do
        for n in range
          A = tu.sym_n(n)
          b = rand(n)
          for lib_symbol in libs_to_perf
              tu.set_lib(lib_symbol) # XXX set new dylib
              MMM.perf_tests(tu.libpso, n, n, n)
              # LU.perf_tests(tu.libpso, n, A, b)
          end
        end
    end
    for lib_symbol in libs_to_perf
        tu.set_lib(lib_symbol)
        LU.teardown(lib_symbol)
    end
end

function main()

    # NOTE if you get a weird shared library
    # or dlopen error Gavin knows how to fix it.
    # He was too lazy to change it in all the
    # modules.
    tu.set_lib(:libpso)

    # ------
    # SETUP
    register_perf_tested_functions()
    LU.init(tu.libpso, max_size)

    # ------
    # For performance testing MMM
    redirect_stdio(stdout=mmm_results) do
        for n in range
            MMM.perf_tests(tu.libpso, n, n, n)
        end
    end

    # ------
    # For performance testing system solving
    redirect_stdio(stdout=solve_results) do
        solve_all_perf_tests_range(range)
    end

    LU.teardown()

end

function lu_test_main()
    tu.set_lib(:libpso)
    LU.init(tu.libpso, max_size)
    LU.solve_tests(tu.libpso)
    LU.teardown(tu.libpso)
end

# -----
# ENTRY

if ARGS[1] == "AUTO"
    files = map(f -> split(f, ".")[1], cd(readdir, ARGS[2]))
    @info "Autotuning with the following libs: $files"
    autotuning_lu_main(map(Symbol, files))
elseif ARGS[1] == "LUTEST"
    lu_test_main()
else
    @info "Default running performance tests"
    main()
end

end # module
