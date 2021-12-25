import Base: show, size, length, merge!
using Base.Docs: Binding
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])
width(od::AbstractOddFrame) = length(od.labels)
show(od::AbstractOddFrame) = od.head(length(od))
axis(od::AbstractOddFrame, col::Symbol) = findall(x->x==col, od.labels)[1]
function merge!(od::AbstractMutableOddFrame,
        od2::AbstractOddFrame; at::Int64 = width(od))
        # Od2 column (for indexing) ,column number in at:width(od2)
        # Columns identified by index position.
        # This will mean the indexes are in order before they
        #                            touch the OD.
        if at < width(od)
                after_push = [od.labels(at:width(od)), ]
        end
        for label in od2.labels

        end
end
# function merge!(od::AbstractMutableOddFrame,
#        od2::AbstractOddFrame; at::Symbol = :A)
#        at = axis(od, at)
#

#end
