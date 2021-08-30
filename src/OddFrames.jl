module OddFrames
#=========
o=o= Heirarchy overview =o=o
|AbstractOddFrame
|_____ OddFrame
|_____ ImmutableOddFrame
|_____ ImageOddFrame
=========#
abstract type AbstractOddFrame end
include("type/frame.jl")
export OddFrame, getindex, setindex, shape
export read_csv
include("methods.jl")
export shape, show
end
