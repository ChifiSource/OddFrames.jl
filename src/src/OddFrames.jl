module OddFrames
# Top of the type heirarchy :
"""
- **Developer API**
- Type Heirarchy
## OddFrameContainer
OddFrameContainer is an abstract type that defines any sort of container with a
    loopable set of OddFrames in a vector.
### sub-types
- FrameGroup
"""
abstract type OddFrameContainer end
"""
- **Developer API**
- Type Heirarchy
## AbstractOddFrame
The abstract OddFrame is an abstract type for the standard OddFrame. All OD's
    have at least the non-mutating methods bound as properties. All OD's also
    have a labels, columns, and types vector.
### Consistent Properties
Here are the properties which all AbstractOddFrames will have.
- labels::Array{Symbol} Just an array of symbols that represent
the names of the columns in the OddFrame.
- columns::Array{Any} A vector of vectors that holds our column data in 1-D
values.
- types::Array{DataType} A vector of data-types, corresponding to each index
in labels/columns.
### Consistent Bindings
To view further documentation for consistent bindings, instead look at
    ImmutableOddFrame.
- AbstractOddFrame.**head**(count::Int64 = 5) => _head
The head function just does subsequent head() calls for each OddFrame in the
        group, providing headings with labels in between. This displays the
        OddFrames as HTML or text tables.
- AbstractOddFrame.**dtype**(::Symbol) => _dtype
The dtype function is used to check the data-type of a given column.
- AbstractOddFrame.**not**(::Symbol ...) => _not
Returns new OddFrame which only contains the column symbols provided.
- AbstractOddFrame.**not**(::UnitRange ...) => _not
Returns new OddFrame which does not contain the column axis position ranges
 provided.
- AbstractOddFrame.**not**(::Symbol ...) => _not
Returns new OddFrame which does not contain the column axis positions provided.
- AbstractOddFrame.**only**(::Symbol ...) => _only
Returns new OddFrame which only contains specified columns by label.
- AbstractOddFrame.**only**(::UnitRange ...) => _only
Returns new OddFrame which only contains column axis ranges specified.
- AbstractOddFrame.**only**(::Int64 ...) => _only
Returns new OddFrame which only contains column axises that are specified.
### sub-types
- AbstractMutableOddFrame
- ImmutableOddFrame
"""
abstract type AbstractOddFrame end
"""
- **Developer API**
- Type Heirarchy
## AbstractMutableOddFrame <: AbstractOddFrame
The AbstractMutableOddFrame is another abstraction layer that lies between
AbstractOddFrames, which can be both mutable and immutable, but are assumed to
be immutable unless specified by being this sub-type. This abstract type is a
sub-type of AbstractOddFrame, therefore it also inherits all of its bindings and
method calls.
### sub-types
- OddFrame
### Consistent Bindings
To view further documentation for consistent bindings, instead look at
    OddFrame.
- AbstractMutableOddFrame.**drop!**(::Any) => _drop!
Removes a given column based on the axis point, symbol, index, or even BitArray
mask.
- AbstractMutableOddFrame.**dropna!**() => _dropna!
Drops missings, nothings, and n/a values from an OddFrame.
- AbstractMutableOddFrame.**dtype!**(::Symbol, ::Type) => _dtype!
Casts column denoted by symbol in position one to type in position two.
- AbstractMutableOddFrame.**merge!**(::OddFrame, at::Int64 = 0) => _merge!
Merges another OddFrame into the current one at the index provided to the at
kwarg.
- AbstractMutableOddFrame.**merge!**(::Array, at::Int64 = 0) => _merge!
Adds a new column onto the Oddframe.
- AbstractMutableOddFrame.**only!**(::OddFrame, at::Int64 = 0) => _only!
Removes all other columns from the OddFrame
"""
abstract type AbstractMutableOddFrame <: AbstractOddFrame end
abstract type AbstractAlgebraOddFrame <: AbstractMutableOddFrame end
# Deps :
import Base: show, size, length, +, merge, delete!, copy, deepcopy, Matrix
import Base: push!, getindex, setindex!, read, iterate
using Base: parse

using Dates
using CSV
using JSON
using XLSX
# Includes/Exports :
export OddFrameContainer, AbstractOddFrame, AbstractMutableOddFrame
include("type/frame.jl")
# Frames
export OddFrame, ImmutableOddFrame, AlgebraicOddFrame, MLOddFrame
# Algebraic Stuff
export AlgebraicArray, compute, generate
export algebraic!
# I/O
export read, read_csv, read_json, read_xl, read_tb, read_fa, read_rs
export to_csv, to_json, to_xl, to_tb, to_fa, to_rs
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
