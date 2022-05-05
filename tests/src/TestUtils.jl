module TestUtils

export column_major_to_row, array_to_column_major

# NOTE M must be a square matrix
function column_major_to_row(M::Matrix{T}) where {T}
    collect(reshape(transpose(M), length(M)))
end

# NOTE `N` is the side length of what should be an NxN matrix
function array_to_column_major(A::Array{T}, N::Int64)::Matrix{T} where {T}
    collect(transpose(reshape(A, (N, N))))
end

end # module
