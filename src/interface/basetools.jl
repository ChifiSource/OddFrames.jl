import Base: push!

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
