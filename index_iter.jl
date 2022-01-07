import Base: getindex, setindex!
#===
Indexing
===#
function getindex(od::AbstractOddFrame, col::Symbol)
        pos = findall(x->x==col, od.labels)[1]
        return(od.columns[pos])
end
getindex(od::AbstractOddFrame, col::String) = od[Symbol(col)]
getindex(od::AbstractOddFrame, axis::Int64) = od.columns[axis]
function getindex(od::AbstractOddFrame, mask::BitArray)
        pos = findall(x->x==0, mask)
        od.drop(pos)
end
getindex(z::UnitRange) = [od.labels[i] for i in z]
#===
Iterators
===#
columns(od::AbstractOddFrame) = od.columns
labels(od::AbstractOddFrame) = od.labels
names(od::AbstractOddFrame) = [label for label in od.labels]
pairs(od::AbstractOddFrame) = [od.labels[i] => od.columns[i] for i in 1:length(od.labels)]
