import Base: show, size, length
using Base.Docs: Binding
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])
width(od::AbstractOddFrame) = length(od.labels)
show(od::AbstractOddFrame) = od.head(length(od))
axis(od::AbstractOddFrame, col::Symbol) = findall(x->x==col, labels)[1]
function merge!(od::AbstractMutableOddFrame,
        od2::AbstractMutableOddFrame, at = width(od))
        if typeof(at) == Symbol
                at = axis(od, at)
        end
        for (col, val) in pairs(od2)
                insert!(od.labels, at, col)
                insert!(od.columns, at, val)
                at += 1
        end
end
