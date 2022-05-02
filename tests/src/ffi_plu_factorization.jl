module plu

using Printf

# FFI stubs for LRU factorization

# PLU Factorization struct

# immutable PLU_factorization

# end

struct CPLU_factorization
    L::Ptr{Cdouble}
    U::Ptr{Cdouble}
    p::Ptr{Cint}
end

struct PLU_factorization
    L::Matrix{Float64}
    U::Matrix{Float64}
    p::Vector{Int32}
end

function column_major_to_ptr(M::Matrix{Float64})::Ptr{Float64}
    pointer(collect(reshape(transpose(M), length(M))))
end

function ptr_to_column_major(p::Ptr{Float64}, N::Int64)::Matrix{Float64}
    collect(transpose(reshape(unsafe_wrap(Array, p, N * N), (N, N))))
end

function alloc_PLU_factorization(N)::Ref{CPLU_factorization}
    L = pointer(zeros(Cdouble, N, N))
    U = pointer(zeros(Cdouble, N, N))
    p = pointer(Vector{Cint}(undef, N))
    return CPLU_factorization(L, U, p)
end

function PLU_factorize(M::Matrix)::PLU_factorization

    @assert ndims(M) == 2
    @assert size(M, 1) == size(M, 2)

    N = size(M, 1) # M should be an NxN matrix
    Mp = column_major_to_ptr(M)
    plu = alloc_PLU_factorization(N)
    retcode = ccall(
        (:plu_factorize, :plu),
        Cint,                                          # return type
        (Cint, Ptr{Cdouble}, Ref{CPLU_factorization}), # parameter types
        N, Mp, plu                                     # actual arguments
    )

    @assert retcode==0

    plu = plu[]

    lr = ptr_to_column_major(plu.L, N)
    ur = ptr_to_column_major(plu.U, N)
    pr = unsafe_wrap(Array, plu.p, N) .+ 1

    return PLU_factorization(lr, ur,  pr)
end

end # module
