module PSO_GE

using Test: @test, @testset
using Printf: @sprintf

# FFI stubs for LRU factorization
include("TestUtils.jl")

const tu = TestUtils

function GE_solve(A::Matrix{<:Real}, b::Vector{<:Real})
    @assert ndims(A) == 2
    @assert size(A, 1) == size(A, 2)

    N = size(A, 1)
    Ab = hcat(A, b)
    Ab = tu.column_major_to_row(Ab)
    x = Vector{Cdouble}(undef, N)

    GC.@preserve Ab begin
        retcode = ccall(
            (:gaussian_elimination_solve, :libpso),
            Cint,                                  # return type
            (Csize_t, Ptr{Cdouble}, Ptr{Cdouble}), # parameter types
            N, Ab, x                               # actual arguments
        )
    end

    return x
end

# --------------------------------------

function solve_tests()
    @testset "GE Solve Tests" begin

        tu.starting_test("GE Solve")

        function test_ge_solve(A::Matrix, b::Vector)
            jx = A\b
            x = GE_solve(A, b)
            @test A * jx ≈ b
            @test A * x ≈ b
            @test jx ≈ x
        end


        function run_random(iters, step, MAX_N; msg::String="")
            tu.starting_test(@sprintf "%d random %s instances" ((MAX_N / step) * iters) msg)
            @time begin
                for i = 1:iters, n = step:step:MAX_N
                    M = rand(n, n)
                    b = rand(n)
                    test_ge_solve(M, b)
                end
            end
        end


        @testset "Static GE Solve" begin
            M_1::Matrix{Cdouble} = [2 1 -2; 1 -1 -1; 1 1 3]
            b_1::Vector{Cdouble} = [3; 0; 12]
            test_ge_solve(M_1, b_1)
        end


        @testset "Random GE Solve Small" begin
            run_random(100, 10, 100, msg="small ge solve")
        end


        @testset "Random GE Solve Large" begin
            run_random(2, 100, 2000, msg="large ge solve")
        end

    end
end

end #module
