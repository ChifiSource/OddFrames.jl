module OddFrames

include("type/frame.jl")
export OddFrame, getindex, eachrow, eachcol, drop

include("type/formats.jl")
export read_csv
end
