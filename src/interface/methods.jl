import Base: show, size, length, merge!
using Base.Docs: Binding
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])
width(od::AbstractOddFrame) = length(od.labels)
show(od::AbstractOddFrame) = od.head(length(od))
axis(od::AbstractOddFrame, col::Symbol) = findall(x->x==col, od.labels)[1]

function merge(od::AbstractOddFrame,
        od2::AbstractOddFrame; at::Int64 = width(od) + 1)
        if at > width(od) || at < 1
                throw(BoundsError("Merge position is not an index on this OddFrame!"))
        end
        pairs = []
        for n in 1:width(od)
                if n == at
                        for n in 1:width(od2)
                                push!(pairs, od2.labels[n] => od2.columns[n])
                        end
                end
                push!(pairs, od.labels[n] => od.columns[n])
        end
        return(OddFrame(pairs))
end
function merge(od::AbstractOddFrame,
        od2::AbstractOddFrame; at::Symbol = od.labels[width(od)])
        pairs = []
        for n in 1:width(od)
                if od.labels[n] == at
                        for n in 1:width(od2)
                                push!(pairs, od2.labels[n] => od2.columns[n])
                        end
                end
                push!(pairs, od.labels[n] => od.columns[n])
        end
        return(OddFrame(pairs))
end
