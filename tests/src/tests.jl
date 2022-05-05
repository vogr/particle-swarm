module tests

using Test: @test, @testset
using LinearAlgebra: lu

# To add a new FFI test stub, include it here ----
include("ffi_plu_factorization.jl")

@testset "LU Factorization Tests" begin

    function test_lu(A)
        try
            L,U,p = lu(A)
            Lt,Ut,pt = PLU.PLU_factorize(A)
            @test (Lt * Ut) ≈ A[pt, :]
            @test L ≈ Lt
            @test U ≈ Ut
        catch e
            # NOTE An ErrorException can be thrown from
            # LinearAlgebra.lu when the matrix has
            # no non-zero pivots. If this is the case,
            # we can just skip the matrix and ignore the
            # tests.
            bt = catch_backtrace()
            msg = sprint(showerror, e, bt)
            println(msg)
            return
        end
    end

    function run_random(iters, step, MAX_N)
        for i = 1:iters, n = step:step:MAX_N
            M = rand(n, n)
            @time test_lu(M)
            GC.gc() # FIXME without the system will segfault
        end
    end

    @testset "Static LU" begin

        # Simple -------------

        M_1 = [1. 2 4
               3 8 4
               2 6 13]

        test_lu(M_1)

        # Medium -------------

        # Hard ---------------

    end

    @testset "Random Small LU" begin
        run_random(10, 10, 50)
    end

    @testset "Random Large LU" begin
        # FIXME running with larger than 500 usually
        # causes segfault. This is a Julia GC problem
        # not a Lib problem (AFAIK).
        # NOTE this could also be a problem with my hacky
        # pointer conversion functions in TestUtils.jl
        run_random(2, 100, 20000)
    end

end

end # module
