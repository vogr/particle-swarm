module tests

# To add a new FFI test stub, include it here ----

using Test
using LinearAlgebra

include("ffi_plu_factorization.jl")

@testset "LU Factorization Tests" begin

    @testset "LU Static Tests" begin

        # Simple -------------

        A = [1. 2 4
             3 8 4
             2 6 13]
        L,U,p = lu(A)
        F = plu.PLU_factorize(A)
        @test (F.L * F.U) == A[F.p, :]
        @test L == F.L
        @test U == F.U

        # Medium -------------

        # Hard ---------------

    end

    @testset "LU Random Tests" begin

        iterations = 50

        # TODO
        @test true

    end

end

end # module
