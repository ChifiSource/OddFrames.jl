function eachrow(of::OddFrame)
    cols = values(of.lookup)
    [[row[i] for row in cols] for i in 1:length(cols[1])]
end
eachcol(od::OddFrame) = values(od.lookup)
