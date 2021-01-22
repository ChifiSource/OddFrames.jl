<div align="center">
  <img src="https://github.com/ChifiSource/OddFrames.jl/blob/oddframe_base/oddframes.png">
  <h1>OddFrames.jl</h1>
  <h2>A lightweight approach to working with data</h2>
<p>  OddFrames.jl is a package targeted at those who want to work with labeled, single-dimensional data, rather than multi-dimensional data. The implementation is a relatively basic wrapper with algorithms designed around dictionary-based data. In other words, OddFrame data is stored with Key => Value rather than [x, y]. While this approach might be great for many applications, you might also want to check-out the much more prominent and well-supported JuliaData/DataFrames.jl. The advantage that OddFrames holds to this package is that it can be used as more of a stepping-stone away from some of the ecosystems that we might be used to. OddFrames combines both the functional and object-oriented paradigm to create simple, dynamic, and recognizable results that make sense with easy API calls. Best of all, data is stored in simple, basic-datatypes, and functionality is extended using algorithms with those datatypes!</p>
  </div>

# Stable, Main branch:
```julia
julia> ]
pkg> add https://github.com/ChifiSource/OddFrames.jl.git
```
# Unstable Branch:
```julia
julia> ]
pkg> add https://github.com/ChifiSource/OddFrames.jl.git#Unstable
```
