import Base: getindex, setindex!
#===
Iterators
===#
columns(od::AbstractOddFrame) = od.columns
labels(od::AbstractOddFrame) = od.labels
names(od::AbstractOddFrame) = [label for label in od.labels]
pairs(od::AbstractOddFrame) = [lbl => od.columns[i] for (i, lbl) in enumerate(od.labels)]
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
function setindex!(od::OddFrame, T::Type, i::Int64)
        for (iter, obs) in enumerate(od[i])
                try
                        obs = parse(T, obs)
                catch
                        throw(string("Unable to cast all observations, stopped at x̄-",
                         iter))
                end
        end
end
getindex(z::UnitRange) = [od.labels[i] for i in z]
