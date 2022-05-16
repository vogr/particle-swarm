module TestUtils

using Printf: @printf

export alloc_aligned_vec,
    fill_c_vec,
    column_major_to_row,
    array_to_column_major,
    starting_test

# Changes the major order of the array memory layout.
# Row -> Column and vice-versa
# This functions works on *any* sized 2-dimensional array
# and not just square matrices.
change_major_order(X::AbstractArray, sizes...=size(X)...) =
    permutedims(reshape(X, sizes...), length(sizes):-1:1)

column_major_to_row(M::AbstractArray)::AbstractVector =
    collect(reshape(change_major_order(M), length(M)))

array_to_column_major(A::AbstractArray, sizes...)::AbstractArray =
    collect(change_major_order(reshape(A, sizes)))

function alloc_aligned_vec(::Type{T}, dims...) where T
    # @assert isbits(T)
    sz = sizeof(T) * prod(dims)
    align = 32
    @assert prod(dims) % align == 0
    pt = ccall(:aligned_alloc, Ptr{Cvoid}, (Base.Csize_t, Base.Csize_t), align, sz)
    # pt = Libc.calloc(prod(dims), sizeof(T))
    @assert pt != C_NULL
    return unsafe_wrap(Array, convert(Ptr{T}, pt), dims; own = true)

end

function fill_c_vec(A::AbstractArray, v::AbstractVector)
    @assert ndims(A) == 2
    @assert length(A) == length(v)
    (rows, cols) = size(A)
    for i in 0:(rows - 1)
        for j in 0:(cols - 1)
            v[(i * cols + j) + 1] = A[i + 1, j + 1]
        end
    end
end

function starting_test(msg)
    @printf "[starting]: %s\n" msg
end

end # module
