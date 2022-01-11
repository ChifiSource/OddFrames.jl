import Base: getindex, setindex!
using Base: parse
#===
Iterators
===#
frames(fg::FrameGroup) = [od for od in ods]
columns(od::AbstractOddFrame) = od.columns
labels(od::AbstractOddFrame) = od.labels
labels(fg::AbstractOddFrame) = fg.labels
names(od::AbstractOddFrame) = [label for label in od.labels]
names(fg::OddFrameContainer) = [label for label in fg.labels]

#==
Casts
==#
Array{Pair}(od::AbstractOddFrame) = [lbl => od.columns[i] for (i, lbl) in enumerate(od.labels)]
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
        [od.drop!(p) for p in pos]
end
function setindex!(od::OddFrame, T::Type, i::Int64)
        for (iter, obs) in enumerate(od[i])
                try
                        if type != String
                                obs = parse(T, string(obs))
                        else
                                obs = string(obs)
                        end
                catch
                        throw(string("Unable to cast all observations, stopped at x̄-",
                         iter))
                end
        end
end
getindex(z::UnitRange) = [od.labels[i] for i in z]

getindex(fg::OddFrameContainer, axis::Int64) = fg.ods[axis])
