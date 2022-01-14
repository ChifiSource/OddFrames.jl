"""
# OddFrames.jl
OddFrames.jl is a one-dimensional array-based data-management framework. This
framework is different to most other options in a few ways...
- OddFrames.jl is multi-paradigm, using object-oriented and methodized
coding together.
- Although OddFrames have a focus on presenting data to you in one dimension,
I.E. it makes a lot of sense to process columns individually rather than as a
multi-dimensional matrice, there is still extended linear algebra syntax that is
applicable to OddFrames.
- OddFrames allows the user to control their environment. With rather low memory
usage used to store an OddFrame, and methods that can be used to mitigate memory
issues, it is hard to see scenarios where excessive memory use becomes a problem
- OddFrames lets the user control mutability. This is done through function
names and immutable equivalent types. The core is built on the idea of keeping
core data in tact while manipulating it. Even if a type is immutable, we can
    still make immutable copies, and so forth. Therefore, we can always keep
    samples in tact when we want, and manipulate them when we want -- and not
    have to worry about losing data when working declaratively.
## Type Heirarchy Overview
## AbstractOddFrame
- **ImmutableOddFrame**
### AbstractMutableOddFrame
- **OddFrame**
## OddFrameContainer
- **FrameGroup**
## Filesystem overview
- **OddFrames.jl**
### interface/
- **basetools.jl** - Contains extensions of base types via base method
this just means it has dispatches that work only with base types, but are handy
for working with data.
- **grouping.jl** - Grouping contains FrameGroup, and the member assets for the
framegroup type.
- **index_iter.jl** - Countains indexing and iteration calls for OddFrames.
- **linalg.jl** - Provides some linear algebra operators, expressions, methods,
and casts, making this package a bit more applicable for scientific computing.
### type/
- **css.jl** - Contains a global variable, _css, that is used to set global
Julia CSS to the OddFrames styling.
- **formats.jl** - Contains readers for default file formats for OddFrame
constructors.
- **frame.jl** - Holds the core OddFrame constructor, loads all the files from
types.
- **member_func.jl** - Defines all the member functions, and some supporting
functions for the constructors in frame.jl.
- **supporting.jl** - Holds some supporting functions that support the member
functions and the frame constructors.
"""
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
# Deps :
import Base: show, size, length, +, merge, delete!, copy, deepcopy, Matrix
import Base: push!, getindex, setindex!

using Base: parse
using Dates
# Includes/Exports :
export OddFrameContainer, AbstractOddFrame, AbstractMutableOddFrame
include("type/frame.jl")
export OddFrame, ImmutableOddFrame
include("interface/grouping.jl")
export FrameGroup
include("interface/index_iter.jl")
export frames, columns, labels, names
export Array{Pair}
include("interface/methods.jl")
export width, show, axis
export mutablecopy, immutablecopy, copy, deepcopy
export merge
export delete!, pivot!, apply!
include("interface/linalg.jl")
export shape, size, length
include("interface/basetools.jl")
end
