# Linear Algebra bindings for OddFrames (As Matrices)
import Base: Matrix
function Matrix(od::OddFrame)
    return(reshape(od.labels, length(od), width(od)))
end
