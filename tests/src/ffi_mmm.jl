module MMM

using Test: @test, @testset
using Printf: @sprintf
using LinearAlgebra

include("TestUtils.jl")

const tu = TestUtils

# --------------------------------------

function setup(m, n, k)
    A_vec = tu.alloc_aligned_vec(Cdouble, m * k)
    B_vec = tu.alloc_aligned_vec(Cdouble, k * n)
    C_vec = tu.alloc_aligned_vec(Cdouble, m * n)

    A = rand(m, k)
    B = rand(k, n)
    C = rand(m, n)

    tu.fill_c_vec(A, A_vec)
    tu.fill_c_vec(B, B_vec)
    tu.fill_c_vec(C, C_vec)

    return (A_vec, k, B_vec, n, C_vec, n)
end

function perf_tests(m, n, k)
    (A, LDA, B, LDB, C, LDC) = setup(m, n, k)
    tu.starting_test(@sprintf "LU perf comparison with A[%d, %d]x = b[%d]" n n n)
    # NOTE this preserve shouldn't be necessary because
    # a Ptr{Cdouble} Base.unsafe_convert already exists.
    GC.@preserve A B C begin
        ccall(
          (:perf_test_mmm, :libpso),
          Cvoid,
          (Cint, Cint, Cint, Cdouble,
            Ptr{Cdouble}, Cint,
            Ptr{Cdouble}, Cint,
            Cdouble, Ptr{Cdouble}, Cint),
          m, n, k, -1.0, A, LDA, B, LDB, 1.0, C, LDC
        )
    end
end


end # module
