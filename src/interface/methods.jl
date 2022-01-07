import Base: show, size, length, +, -
using Base.Docs: Binding
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])
width(od::AbstractOddFrame) = length(od.labels)
show(od::AbstractOddFrame) = od.head(length(od))
axis(od::AbstractOddFrame, col::Symbol) = findall(x->x==col, od.labels)[1]

function merge(od::AbstractOddFrame,
        od2::AbstractOddFrame; at::Any = width(od) + 1)
        if typeof(at) == Symbol
                at = findall(x->x==at, labels)[1]
        end
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

+(od::AbstractOddFrame, od2::AbstractOddFrame) = merge(od, do2)
