shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
show(od::OddFrame) = od.head(5)
