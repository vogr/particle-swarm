module PSO_TRI_SYS

using Test: @test, @testset
using Printf: @sprintf
using TryCatch

# FFI stubs for LRU factorization
include("TestUtils.jl")

const tu = TestUtils

function tri_sys_solve(N, d, Ab, x)
    # NOTE this preserve shouldn't be necessary because
    # a Ptr{Cdouble} Base.unsafe_convert already exists.
    GC.@preserve Ab x begin
        retcode = ccall(
            (:triangular_system_solve, :libpso),
            Cint,                                  # return type
            (Csize_t, Csize_t, Ptr{Cdouble}, Ptr{Cdouble}), # parameter types
            N, d, Ab, x                               # actual arguments
        )
    end
    return retcode
end

function TRI_SYS_solve(A::Matrix{<:Real}, b::Vector{<:Real}, d::Int)
    @assert ndims(A) == 2
    @assert size(A, 1) == size(A, 2)
    N = size(A, 1)

    Ab = hcat(A, b)
    Ab_vec = tu.alloc_aligned_vec(Cdouble, length(Ab))
    tu.fill_c_vec(Ab, Ab_vec)
    x = tu.alloc_aligned_vec(Cdouble, N)
    retcode = tri_sys_solve(N, d, Ab_vec, x)
    @assert retcode == 0
    return x
end

# --------------------------------------

function solve_tests()
    @testset "TRI SYS Solve Tests" begin

        tu.starting_test("TRY SYS Solve")

        function test_tri_sys_solve(A::Matrix, b::Vector, d::Int)
            jx = A\b
            local x
            # The system is solvable if c > d
            x = TRI_SYS_solve(A, b, d)

            N = size(x, 1)

            # @test jx[N÷2+1:N] ≈ x[N÷2+1:N]
            # @test x - jx ≈ zeros(Float64, size(A, 1))
            @test A * x ≈ b
            @test jx ≈ x
        end

        test_lambda = (n) -> begin
        # plausible scenario: c = iter_max = 100 and d = dimensions = 30
            d = n ÷ 3
            c = n - d

            M = tu.build_block_triangular_matrix(c, d)
            b = rand(n)
            test_tri_sys_solve(M, b, d)
        end

        @testset "Random TRI SYS Solve Small" begin
            # tu.@run_random_N 100 2^5 2^7 "small try sis solve" test_lambda
            tu.@run_random_N 100 9 9 "small try sis solve" test_lambda
        end


        # @testset "Random GE Solve Large" begin
        #     tu.@run_random_N 1 2^10 2^12 "large ge solve" test_lambda
        # end

    end
end

function setup(n, A, b)
    ab_n = n * (n + 1)
    Ab = hcat(A, b)
    Ab_vec = tu.alloc_aligned_vec(Cdouble, ab_n)
    x = tu.alloc_aligned_vec(Cdouble, n)
    tu.fill_c_vec(Ab, Ab_vec)
    return (Ab_vec, x)
end

function valid(n, d, A, b)
    (Ab_vec, x) = setup(n, A, b)
    return 0 == tri_sys_solve(n, d, Ab_vec, x)
end

function perf_tests(n, d, A, b)
    (Ab_vec, x) = setup(n, A, b)
    tu.starting_test(@sprintf "TRI SYS perf comparison with A[%d, %d]x = b[%d]" n n n)
    # NOTE this preserve shouldn't be necessary because
    # a Ptr{Cdouble} Base.unsafe_convert already exists.
    GC.@preserve Ab_vec x begin
        retcode = ccall(
            (:perf_test_tri_sys_solve, :libpso),
            Cint,                                  # return type
            (Csize_t, Csize_t, Ptr{Cdouble}, Ptr{Cdouble}), # parameter types
            n, d, Ab_vec, x                           # actual arguments
        )
    end
    @assert retcode == 0
end

end #module
