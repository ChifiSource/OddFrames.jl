module OddFrames
#=========
o=o= Heirarchy overview =o=o
|AbstractOddFrame
|_____ OddFrame
|_____ ImmutableOddFrame
|_____ ImageOddFrame
=========#
abstract type AbstractOddFrame end
abstract type AbstractMutableOddFrame <: AbstractOddFrame end
include("type/frame.jl")
export OddFrame, ImmutableOddFrame
include("type/index_iter.jl")
export getindex, setindex, shape
export read_csv
include("methods.jl")
export shape, show, length, merge!
end
