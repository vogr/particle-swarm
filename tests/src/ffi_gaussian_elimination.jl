module PSO_GE


# FFI stubs for LRU factorization
include("TestUtils.jl")

const tu = TestUtils

# Note this cconvert function creates a copy: any modification done
# to the matrix by the C code will not be visible to Julia.
function Base.cconvert(t::Type{Ptr{Cdouble}}, x::Matrix{<:Real})
    return Base.cconvert(t, tu.column_major_to_row(x))
end

function GE_solve(A::Matrix{<:Real}, b::Vector{<:Real})
    @assert ndims(A) == 2
    @assert size(A, 1) == size(A, 2)

    N = size(A, 1)
    Ab = hcat(A, b)
    x = Vector{Cdouble}(undef, N)

    retcode = ccall(
        (:gaussian_elimination_solve, :libpso),
        Cint,                                           # return type
        (Csize_t, Ptr{Cdouble}, Ptr{Cdouble}), # parameter types
        N, Ab, x                                      # actual arguments
    )

    return x
end


function test_ge()
    A = rand(3,3)
    b = rand(3)

    println(A)
    println(b)
    println(A\b)

    println(GE_solve(A,b))
end


end #module