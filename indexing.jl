import Base: getindex
getindex(od::OddFrame, col::Symbol) = od.lookup[col]
getindex(od::OddFrame, col::String) = od.lookup[Symbol(col)]
function getindex(od::OddFrame, mask::BitArray)
    [if mask[i] == 0 drop(od, i) end for i in 1:length(mask)]
end
