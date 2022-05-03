module PLU

# FFI stubs for LRU factorization

include("TestUtils.jl")

const tu = TestUtils

# PLU Factorization struct

struct PLU_factorization
    L::Ptr{Cdouble}
    U::Ptr{Cdouble}
    p::Ptr{Cint}
end

function alloc_PLU_factorization(N)::Ref{PLU_factorization}
    L = pointer(zeros(Cdouble, N, N))
    U = pointer(zeros(Cdouble, N, N))
    p = pointer(Vector{Cint}(undef, N))
    return PLU_factorization(L, U, p)
end

function PLU_factorize(M::Matrix)

    @assert ndims(M) == 2
    @assert size(M, 1) == size(M, 2)

    N = size(M, 1) # M should be an NxN matrix
    Mp = tu.column_major_to_ptr(M)
    plu = alloc_PLU_factorization(N)
    retcode = ccall(
        (:plu_factorize, :plu),
        Cint,                                         # return type
        (Cint, Ptr{Cdouble}, Ref{PLU_factorization}), # parameter types
        N, Mp, plu                                    # actual arguments
    )

    @assert retcode == 0

    plu = plu[]

    lr = tu.ptr_to_column_major(plu.L, N)
    ur = tu.ptr_to_column_major(plu.U, N)
    # C code is 0-base indexed but Julia is 1-base
    pr = unsafe_wrap(Array, plu.p, N) .+ 1

    return (lr, ur,  pr)
end

end # module
