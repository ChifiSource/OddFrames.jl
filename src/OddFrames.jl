module OddFrames
#=========
o=o= Heirarchy overview =o=o
|AbstractOddFrame
|_____ AbstractMutableOddFrame
       |_____ OddFrame
       |_____ ImageOddFrame
|_____ ImmutableOddFrame
|OddFrameContainer
|_____ FrameGroup
=========#
abstract type OddFrameContainer end
abstract type AbstractOddFrame end
abstract type AbstractMutableOddFrame <: AbstractOddFrame end
export OddFrameContainer, AbstractOddFrame, AbstractMutableOddFrame
include("type/frame.jl")
export OddFrame, ImmutableOddFrame
include("interface/grouping.jl")
export FrameGroup

include("interface/index_iter.jl")
export getindex, setindex, columns, labels, names, pairs
# export length_check
include("interface/methods.jl")
export shape, show, length, merge, +
include("interface/basetools.jl")
export push!
end
