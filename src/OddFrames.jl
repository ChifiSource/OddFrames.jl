module OddFrames
#=========
o=o= Heirarchy overview =o=o
|AbstractOddFrame
|_____ OddFrame
|_____ ImmutableOddFrame
|_____ ImageOddFrame
=========#
import Base.Meta: parse
abstract type OddFrameContainer end
abstract type AbstractOddFrame end
abstract type AbstractMutableOddFrame <: AbstractOddFrame end
include("type/frame.jl")
export OddFrame, ImmutableOddFrame, Group
include("interface/index_iter.jl")
export getindex, setindex, columns, labels, names, pairs
# export length_check
include("interface/methods.jl")
export shape, show, length, merge, +
include("interface/basetools.jl")
export push!
end
