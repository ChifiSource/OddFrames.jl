# API Reference
```@index
Pages   = ["APIReference.md", "DeveloperAPI.md"]
Modules = [OddFrames]
Order   = [:type, :function]
```

## Core

### Frames
#### OddFrame
- Sub-type of AbstractMutableOddFrame and AbstractOddFrame.
```@docs
OddFrame
```
#### ImmutableOddFrame
- Sub-type of AbstractOddFrame
```@docs
ImmutableOddFrame
```
### Casts
- Sub-type of AbstractOddFrame
```@docs
Array{Pair}(::AbstractOddFrame)
```
## From OddFrames

### Base Tools

## Interface

### Grouping
#### FrameGroup
##### FrameGroup Constructors
### Indexing and Iteration

### Linear Algebra
#### shape
```@docs
shape(::AbstractOddFrame)
```
#### size
```@docs
size(::AbstractOddFrame)
```
#### length
```@docs
length(::AbstractOddFrame)
```
#### Matrix
Oddframe -> Matrix
```@docs
size(::AbstractOddFrame)
```
### Methods
#### width
```@docs
width(::AbstractOddFrame)
width(::OddFrameContainer)
```
#### show
```@docs
show(::AbstractOddFrame)
```
#### axis
```@docs
axis(::AbstractOddFrame, ::Symbol)
```
### Copy Methods
#### mutablecopy
```@docs
mutablecopy(::AbstractOddFrame)
```
#### immutablecopy
```@docs
mutablecopy(::AbstractOddFrame)
```
### Management Methods

## Extras
### Fill Functions
#### nothing
#### mean
#### zeros
