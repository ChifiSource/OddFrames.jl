shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])

function Matrix(od::OddFrame)
    return(reshape(od.labels, length(od), width(od)))
end
