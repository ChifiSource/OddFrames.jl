import Base: push!, getindex

function push!(iter::AbstractVector, val::Any; at::Int64 = length(iter))
    begin_vec = iter[1:at - 1]
    n_vec = iter[at:length(iter)]
    # Clears Array
    deleteat!(iter, 1:length(iter))
    [push!(iter, v) for v in begin_vec]
    push!(iter, val)
    [push!(iter, v) for v in n_vec]
    iter
end

ikeys(pairs) = [p[1] for p in pairs]
ivalues(pairs) = [p[2] for p in pairs]

function getindex(x::AbstractArray, mask::BitArray)
        pos = findall(x->x==0, mask)
        [deleteat!(x, p) for p in pos]
end
function getindex(x::AbstractArray, mask::Function)
    mask2 = [mask(x) for x in x]
    getindex(x, mask2)
end
