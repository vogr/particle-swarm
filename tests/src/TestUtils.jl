module TestUtils

export column_major_to_row, array_to_column_major

# NOTE works on any size matrix
change_major_order(X::AbstractArray, sizes...=size(X)...) =
    permutedims(reshape(X, sizes...), length(sizes):-1:1)

column_major_to_row(M::AbstractArray)::AbstractVector =
    collect(reshape(change_major_order(M), length(M)))

# NOTE no default `sizes` is given because it would default to a vector
array_to_column_major(A::AbstractArray, sizes...)::AbstractArray =
    collect(change_major_order(reshape(A, sizes)))

# # NOTE M must be a square matrix
# function column_major_to_row(M::Matrix{T})::Vector{T} where {T}
#     return collect(reshape(transpose(M), length(M)))
# end

# # NOTE `N` is the side length of what should be an NxN matrix
# function array_to_column_major(A::Array{T}, N::Int64)::Matrix{T} where {T}
#     return collect(transpose(reshape(A, (N, N))))
# end


function ptr_to_column_major(A::Ptr{T}, N::Int64)::Matrix{T} where {T}
    return collect(transpose(reshape(
        unsafe_wrap(Array{Cdouble}, A, N * N),
        (N, N))))
end

function column_major_to_array(M::Matrix{T})::Vector{T} where {T}
    m::Matrix{T} = column_major_to_row(M)
    return reshape(m, length(m))
end

end # module
