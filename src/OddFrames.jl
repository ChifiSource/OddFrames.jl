module OddFrames
# Top of the type heirarchy :
abstract type OddFrameContainer end
abstract type AbstractOddFrame end
abstract type AbstractMutableOddFrame <: AbstractOddFrame end
abstract type AbstractAlgebraOddFrame <: AbstractMutableOddFrame end
# Deps :
import Base: show, size, length, +, merge, delete!, copy, deepcopy, Matrix
import Base: push!, getindex, setindex!, read, iterate
using Base: parse
using Base.Threads: @spawn
using Dates

# Includes/Exports :
export OddFrameContainer, AbstractOddFrame, AbstractMutableOddFrame

include("type/formats.jl")
# I/O
export read, read_csv, read_json, read_xl
export to_csv, to_json, to_xl
# Algebraic Stuff
export AlgebraicArray, compute, generate
export algebraic!
include("type/frame.jl")
# Frames
export OddFrame, ImmutableOddFrame, AlgebraicOddFrame, MLOddFrame
include("interface/grouping.jl")
export FrameGroup
include("interface/index_iter.jl")
export frames, columns, labels, names
include("interface/methods.jl")
# Basics
export width, show, axis
# Copy
export mutablecopy, immutablecopy, copy, deepcopy
# Methods
export merge, pivot!
# Mem_management
export delete!
include("interface/linalg.jl")
export shape, size, length
export Matrix
include("type/casts.jl")
include("interface/basetools.jl")
export apply, apply!
end
