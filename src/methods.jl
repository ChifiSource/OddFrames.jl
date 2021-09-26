import Base: show, size, length
using Base.Docs: Binding
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
size(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
length(od::AbstractOddFrame) = length(od.columns[1])
width(od::AbstractOddFrame) = length(od.labels)
show(od::AbstractOddFrame) = od.head(length(od))
function merge!(od::AbstractOddFrame, od2::AbstractOddFrame, at = width(od))

end
function _dtype(column, y)
        try
                [y(i) for i in column]
        catch
                throw(TypeError("column type casting",
                y, column[1]))
        end
end
