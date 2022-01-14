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
The abstract OddFrame is an abstract type for
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
be immutable unless specified by being this sub-type.
### sub-types
- OddFrame
"""
# Deps :

abstract type AbstractMutableOddFrame <: AbstractOddFrame end
# Includes/Exports :
export OddFrameContainer, AbstractOddFrame, AbstractMutableOddFrame
include("type/frame.jl")
export OddFrame, ImmutableOddFrame
include("interface/grouping.jl")
export FrameGroup
include("interface/index_iter.jl")
export getindex, setindex!, columns, labels, names, pairs
include("interface/methods.jl")
export shape, show, length, merge, +, names, pivot!, delete!
include("interface/linalg.jl")

include("interface/basetools.jl")
export push!
end
