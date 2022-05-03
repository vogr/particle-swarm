module TestUtils

export column_major_to_ptr, ptr_to_column_major

# NOTE M must be a square matrix
function column_major_to_ptr(M::Matrix{T})::Ptr{T} where {T}
    pointer(collect(reshape(transpose(M), length(M))))
end

# NOTE `N` is the side length of what should be an NxN matrix
function ptr_to_column_major(p::Ptr{T}, N::Int64)::Matrix{T} where {T}
    collect(transpose(reshape(unsafe_wrap(Array, p, N * N), (N, N))))
end


end # module
