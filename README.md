<div align="center">
  <img src="https://github.com/ChifiSource/OddFrames.jl/blob/Unstable/assets/oddframes.png" width = 300 height = 300>
  <h1>OddFrames.jl</h1>

  
# Release Version
The next release version will be 0.1.0, with the release of OddFrames Basil.
```julia
julia> ]
pkg> add https://github.com/ChifiSource/OddFrames.jl.git
```
# Stable
Latest stable development (with some breaking changes, and potential missing documentation)
```julia
pkg> add https://github.com/ChifiSource/OddFrames.jl.git#Stable
```
# Unstable Branch:
Latest unstable developments, with potential bugs, missing features, etc. (Usually for developers)
```julia
julia> ]
pkg> add https://github.com/ChifiSource/OddFrames.jl.git#Unstable
```

  
  <div align = "left">
<br>


## A Julian approach to data-management 
OddFrames.jl is a data-management framework that is exactly as the name implies -- odd. What is great about OddFrames is that they are meant to be more Julian-1-D based. This is to say, your columns and respective data is a stacked array, not treated as a matrice. The OddFrames.jl framework handles more like a mutate mix between sonmething highly declarative like DataFrames.jl with method calls in functional style, but then also having some of the class-like features of Python's Pandas mixed in. Additionally, there are some other qualities that OddFrames.jl has. Let us quickly dive into the core methodology for OddFrames.jl.
### Selectively object-oriented
The first important thing to know about OddFrames.jl is that it is selectively object-oriented. This means that types do have member functions, and things of that nature, but also that there are method calls when applicable. For more information on this specifically, you will be able to refer to the future JuliaHub documentation. Many methods and syntax are derived from Pandas, with some functional paradigm mixed in when apt.
### Base Julia Types
    One thing that is often annoying about working with other data-management frameworks is often type conversion. It can be annoying to have all your data stored in these package-specific types. Instead, OddFrames.jl takes a Julian approach to extending the types Julia already has available to be used inside of one large struct.
### Immutability
A key focus of OddFrames.jl is keeping memory usage low while still allowing for easy transformation of data. The main reason why there is a strive to keep memory usage down is because OddFrames.jl has a focus on immutability. This is not so much in the traditional sense, where you might need to work around immutability in order to get things done. The difference here is that OddFrames is allowing the end-user to determine what data they wish to mutate and not mutate in a blatant way.
 ### Modern Data Science
I think that all UI components, especially for something like a table, should always be at least moderately tasteful in appearance. I want information on my data, but I do not want my data to scream about itself into my ear. I understand these concepts, therefore my design is geared towards such a thing. There are so many DataFrames packages that just do not at all have support for image-dataframes, which is ridiculously common now.
