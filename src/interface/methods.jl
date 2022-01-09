import Base: show, size, length, -, merge
using Base.Docs: Binding
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])
width(od::AbstractOddFrame) = length(od.labels)
show(od::AbstractOddFrame) = od.head(length(od))
axis(od::AbstractOddFrame, col::Symbol) = findall(x->x==col, od.labels)[1]

function merge(od::AbstractOddFrame,
        od2::AbstractOddFrame; at::Any = 1)
        if typeof(at) == Symbol
                at = axis(od, col)
        end
        if at > width(od) || at < 1
                throw(BoundsError("Merge position is not an index on this OddFrame!"))
        end
        pairs = []
        for n in 1:width(od)
                if n == at
                        for z in 1:width(od2)
                                push!(pairs, od2.labels[z] => od2.columns[z])
                        end
                end
                push!(pairs, od.labels[n] => od.columns[n])
        end
        return(OddFrame(pairs))
end

function pivot!(od::AbstractMutableOddFrame; at::Any = 1)
        if typeof(at) == Symbol
                at = axis(od, col)
        end
        if length(od[at]) != length(names(od))
                throw(DimensionMismatch(string("Got names length of ",
                length(names(od)), " and at length of ", length(od[at]),
                ". These values must be equal.")))
        end
        labels = od.labels
        col = od.columns[at]
        od.labels = col
        od.col[at] = labels
end
