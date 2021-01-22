import Base: getindex
getindex(od::OddFrame, col::Symbol) = od.lookup[col]
getindex(od::OddFrame, col::String) = od.lookup[Symbol(col)]
