# Type Heirarchy
OddFrames are a name given to any type that is a sub-type of **AbstractOddFrame**.
AbstractOddFrames must all hold the following fields:
- labels::Array/Tuple{Symbol}
- columns::Array/Tuple{Any}
- types::Array/Tuple{Type}
- head::Function
- dtype::Function
- not::Function
- only::Function
- describe::Function
```@docs
AbstractOddFrame
```
# AbstractMutableOddFrame
**AbstractMutableOddFrame** is similar to **AbstractOddFrame**, only
requires that both the OddFrame and its values are mutable. Along with
this comes these additional features, some of which are shared with
**AbstractOddFrame**
- labels::Array{Symbol}
- columns::Array{Any}
- types::Array
- head::Function
- dtype::Function
- not::Function
- only::Function
- describe::Function
- drop!::Function
- dtype!::Function
- merge!::Function
- only!::Function
- apply!::Function
- fill!::Function
```@docs
OddFrames.AbstractMutableOddFrame
```
# Types
```@docs
OddFrame
```
```@docs
ImmutableOddFrame
```
# Indexing
Indexing in Oddframes.jl has a few key consistencies that are
universal in the package and important to note. The first of these
is the different types you can index with. The operation of the
indexing is going to change depending on what type we are providing. The first way to index an OddFrame is by using a symbol. This will
index the labels, and return the corresponding column of data.
### Indexing columns
```@docs
getindex(::AbstractOddFrame, ::Symbol)
```
The same functionality can also be achieved with a string.
```@docs
getindex(::AbstractOddFrame, ::Symbol)
```
We can also use the at key-word argument, which always denotes
that we would like to call a column. Otherwise, indexing with an
integer will always call the observation. We can also index in this
same way with a range.
```@docs
getindex(::AbstractOddFrame; at::UnitRange)
```
```@docs
getindex(::AbstractOddFrame; at::Int64)
```
### Indexing rows
Indexing full rows can be done by simply applying the same indexing but
replacing the key-word argument **at** with a positional argument.
```@docs
getindex(::AbstractOddFrame, ::Int64)
```
```@docs
getindex(::AbstractOddFrame, ::UnitRange)
```
### Indexing observations
Row indexes are done with three different types, the BitArray,
Integers, and UnitRanges. The latter two can be done using the same
indexing calls. We use the at key-word
here to denote which column we would like to call.
```@docs
getindex(::AbstractOddFrame, ::Int64; at::Any)
```
```@docs
getindex(::AbstractOddFrame, ::BitArray)
```
```@docs
getindex(::AbstractOddFrame, ::UnitRange)
```
These same indexing ideas carry into the member functions and the rest of the
module, so it is certainly something to pay attention to.
# Iteration
Iteration using OddFrames.jl is also incredibly simple. There are a few
ways we can iterate an OddFrame. By default, iterating over the OddFrame will
loop the columns of the OddFrame.
```@docs
iterate(::AbstractOddFrame)
```
However, in order to iterate names, or explicitly call the columns to be
iterated, you can use labels() and columns() respectively.
```@docs
columns(::AbstractOddFrame)
```
```@docs
labels(::AbstractOddFrame)
```
# Member Functions
OddFrames have member functions. These functions are provided as fields
of the OddFrame. That being said, you can access them how you normally
would with fields. The advantage to this is that we can mutate the
OddFrame internally. For example, here is a call of head:
```example
od = OddFrame(:A => [5, 10, 15, 20])
od.head(5)
```
## Non-mutating Member Functions
These functions can return a mutated frame, but will not mutate the data inside
of the OddFrame.
#### Introspective
##### head
The od.head() member function will show **x** number of
rows of the OddFrame.
```example
head(x::Int64; html = :show) = _head(labels, columns, types, x,
html = html)
head() = _head(labels, columns, types, 5)
```
##### dtype
od.dtype() reveals the data-type of a given column by symbol index.
```example
dtype(x::Symbol) = typeof(types[findall(x->x == x,
                        labels)[1]][1])
```
##### describe
od.describe() describes each column, or a particular column's
features.
```example
describe() = _describe(labels, columns, types)
describe(col::Symbol) = _describe(symb, labels, columns, types)
```
#### Filtering
##### not
Not excludes a symbol, range, or integer position from a column.
```@example
not(ls::Symbol ...) = _not(ls, labels, columns)
not(ls::UnitRange ...) = _not(ls, labels, columns)
not(ls::Int64 ...) = _not(ls, labels, columns)
```
##### only
Only excludes all of the values except for the one provided.
```@example
only(ls::Symbol ...) = _only(ls, labels, columns)
only(ls::UnitRange ...) = _only(ls, labels, columns)
only(ls::Int64 ...) = _only(ls, labels, columns)
```
#### Operations
##### apply
Apply will apply **f** to the columns.
```@example
apply(f::Function) = apply(f, labels, columns)
```
## Mutating Member Functions
These functions will mutate your type! Be careful!
#### drop!
The drop! function can drop a column, row, or values that meet certain parameters with a BitArray/Function.
```@example
drop!(x) = _drop!(x, columns)
drop!(x::Symbol) = _drop!(x, labels, columns, types)
drop!(x::String) = _drop!(Symbol(x), labels, columns, types)
drop!(;at = 1) = _drop!(labels, columns, types, at = at)
drop!(f::Function) = _drop!(f, labels, columns, types)
```
#### dtype!
The dtype! function will attempt to parse all of the values in **x**
to type **T**
```@example
dtype!(x::Symbol, T::Type) = _dtype!(columns[findall(x->x == x,
                        labels)[1]], T)
```
