shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])
width(od::AbstractOddFrame) = length(od.labels)
show(od::AbstractOddFrame) = od.head(length(od))
