

struct rounding_bloom end

function rounding_bloom_alloc()::Ptr{rounding_bloom}
    ccall(
        (:rounding_bloom_alloc, :libroundingbloom),
        Ptr{rounding_bloom},
        ()
      )
end


function rounding_bloom_init(bloom::Ptr{rounding_bloom}, entries::Int, error::Real, epsilon::Real, dim::Int, lower_bound::Vector{T}) where {T<:Real}
    ret = ccall(
        (:rounding_bloom_init, :libroundingbloom),
        Cint,
        (Ptr{rounding_bloom}, Cint, Cdouble, Cdouble, Cint, Ptr{Cdouble}),
        bloom, entries, error, epsilon, dim, lower_bound
      )
    ret
end


function rounding_bloom_check_add(bloom::Ptr{rounding_bloom}, x::Vector{T}, add::Bool) where {T<:Real}
    ret = ccall(
        (:rounding_bloom_check_add, :libroundingbloom),
        Cint,
        (Ptr{rounding_bloom}, Cint, Ptr{Cdouble}, Cint),
        bloom, length(x), x, add
      )
    ret
end


function rounding_bloom_print(bloom::Ptr{rounding_bloom})
    ret = ccall(
        (:rounding_bloom_print, :libroundingbloom),
        Cvoid,
        (Ptr{rounding_bloom},),
        bloom
      )
    ret
end



using Printf


b = rounding_bloom_alloc()

@printf "init: %d\n" rounding_bloom_init(b, 4096, 0.01, 0.3, 2, [-10., -10])

x = [1.,2.]
@printf "checkadd %s: %d\n" x rounding_bloom_check_add(b, x, true)

x = [1.,2.]
@printf "checkadd %s: %d\n" x rounding_bloom_check_add(b, x, true)


x = [1.,2.2]
@printf "checkadd %s: %d\n" x rounding_bloom_check_add(b, x, true)

x = [1,2.4]
@printf "checkadd %s: %d\n" x rounding_bloom_check_add(b, x, true)

x = [1,2.5]
@printf "checkadd %s: %d\n" x rounding_bloom_check_add(b, x, true)
