module LU

using Test: @test, @testset
using Printf: @sprintf
using LinearAlgebra

include("TestUtils.jl")

const tu = TestUtils

function LU_solve(M::Matrix{Cdouble}, b::Vector{Cdouble})::Vector{Cdouble}
    @assert ndims(M) == 2
    @assert size(M, 1) == size(M, 2)
    N = size(M, 1) # M should be an NxN matrix

    Mp::AbstractArray = tu.alloc_aligned_vec(Cdouble, N * N)
    ipiv::AbstractVector = tu.alloc_aligned_vec(Cint, N)
    x::AbstractVector = tu.alloc_aligned_vec(Cdouble, N)
    bp::AbstractVector = tu.alloc_aligned_vec(Cdouble, N)

    tu.fill_c_vec(M, Mp)
    tu.fill_c_vec(b, bp)

    GC.@preserve Mp bp x begin
        retcode = ccall(
            (:lu_solve, :libpso),
            Cint,
            (Cint, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
            N, Mp, ipiv, bp, x
        )
    end

    @assert retcode == 0

    return x
end

# --------------------------------------

function solve_tests()
    @testset "LU Solve Tests" begin

        tu.starting_test("LU Solve")

        function test_lu_solve(A::Matrix, b::Vector)
            jx = A\b
            x = LU_solve(A, b)
            @test A * x ≈ b
            @test jx ≈ x
        end

        test_lambda = (n) -> begin
            M = rand(n, n)
            b = rand(n)
            test_lu_solve(M, b)
        end


        @testset "Random LU Solve Small" begin
            tu.@run_random_N 100 2^5 2^7 "small lu solve" test_lambda
        end


        # @testset "Random LU Solve Large" begin
        #     tu.@run_random_N 1 2^10 2^12 "large lu solve" test_lambda
        # end

    end
end

end # module
