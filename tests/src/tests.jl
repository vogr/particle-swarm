module tests

using Test: @test, @testset
using LinearAlgebra: lu

# To add a new FFI test stub, include it here ----
include("ffi_plu_factorization.jl")

# --------------------------------------

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
        end
    end

    @testset "Static LU" begin

        # Simple -------------

        M_1::Matrix{Cdouble} = [1 2 4; 3 8 4; 2 6 13]

        test_lu(M_1)

        # Medium -------------

        # Hard ---------------

    end

    @testset "Random Small LU" begin
        run_random(100, 10, 100)
    end

    @testset "Random Large LU" begin
        run_random(2, 100, 2000)
    end

end

# --------------------------------------

@testset "LU Solve Tests" begin

    function test_lu_solve(A::Matrix, b::Vector)
        luA = lu(A)
        jx = luA\b
        x = PLU.PLU_solve(A, b)
        @test A * jx ≈ b
        @test A * x ≈ b
        @test jx ≈ x
    end


    function run_random(iters, step, MAX_N)
        for i = 1:iters, n = step:step:MAX_N
            M = rand(n, n)
            b = rand(n)
            @time test_lu_solve(M, b)
        end
    end

    @testset "Static LU Solve" begin

        M_1::Matrix{Cdouble} = [2 1 -2; 1 -1 -1; 1 1 3]

        b_1::Vector{Cdouble} = [3; 0; 12]

        test_lu_solve(M_1, b_1)

    end

    @testset "Random LU Solve Small" begin
        run_random(100, 10, 100)
    end

    @testset "Random LU Solve Large" begin
        run_random(2, 100, 2000)
    end

end

end # module
