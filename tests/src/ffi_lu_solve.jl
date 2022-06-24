module LU

using Test: @test, @testset
using Printf: @sprintf
using LinearAlgebra

include("TestUtils.jl")

const tu = TestUtils

function lu_solve(lib, N, A, b)
    GC.@preserve A b begin
        retcode = ccall(
            tu.lookup(lib, :lu_solve),
            Cint,
            (Cint, Ptr{Cdouble}, Ptr{Cdouble}),
            N, A, b
        )
    end
    return retcode
end

function LU_solve(lib, M::Matrix{Cdouble}, b::Vector{Cdouble})::Vector{Cdouble}
    @assert ndims(M) == 2
    @assert size(M, 1) == size(M, 2)
    N = size(M, 1) # M should be an NxN matrix

    Mp::AbstractArray = tu.alloc_aligned_vec(Cdouble, N * N)
    bp::AbstractVector = tu.alloc_aligned_vec(Cdouble, N)

    tu.fill_c_vec(M, Mp)
    tu.fill_c_vec(b, bp)

    retcode = lu_solve(lib, N, Mp, bp)
    @assert retcode == 0

    return bp
end

# --------------------------------------

function solve_tests(lib)
    @testset "LU Solve Tests" begin

        tu.starting_test("LU Solve")

        function test_lu_solve(A::Matrix, b::Vector)
            jx = A\b
            x = LU_solve(lib, A, b)
            @test A * x ≈ b
            @test jx ≈ x
        end

        test_lambda = (n) -> begin
            M = tu.sym_n(n)
            b = rand(n)
            test_lu_solve(M, b)
        end


        @testset "Random LU Solve Small" begin
            tu.@run_random_N 100 2^5 2^8 "small lu solve" test_lambda
            tu.@run_random_N 3 3^4 3^6 "small lu solve" test_lambda
        end


        @testset "Random LU Solve Large" begin
            tu.@run_random_N 2 2^8 2^11 "large lu solve" test_lambda
        end

    end
end

function setup(n, A, b)
    A_vec = tu.alloc_aligned_vec(Cdouble, n * n)
    b_vec = tu.alloc_aligned_vec(Cdouble, n)
    tu.fill_c_vec(A, A_vec)
    tu.fill_c_vec(b, b_vec)
    return (A_vec, b_vec)
end

function init(lb, n)
    ccall(tu.lookup(lb, :lu_initialize_memory), Cvoid, (Cint,), n)
end

function teardown(lb)
    ccall(tu.lookup(lb, :lu_free_memory), Cvoid, ())
end

function valid(lib, n, A, b)
    (A_vec, b_vec) = setup(n, A, b)
    0 == lu_solve(lib, n, A, b)
end

function perf_tests(lib, n, A, b)
    (A_vec, b_vec) = setup(n, A, b)
    # tu.starting_test(@sprintf "LU perf comparison with A[%d, %d]x = b[%d]" n n n)
    # NOTE this preserve shouldn't be necessary because
    # a Ptr{Cdouble} Base.unsafe_convert already exists.
    GC.@preserve A_vec b_vec begin
        retcode = ccall(
            tu.lookup(lib, :perf_test_lu_solve),
            Cint,
            (Csize_t, Ptr{Cdouble}, Ptr{Cdouble}),
            n, A_vec, b_vec
        )
        @assert retcode == 0
    end
end

end # module
