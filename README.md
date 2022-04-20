<div align="center">
  <img src="https://github.com/ChifiSource/OddFrames.jl/blob/Unstable/assets/logo.png" width = 300 height = 300>
  <h1>OddFrames.jl</h1>

 </div>
 
 
  **OddFrames.jl** is a new package for managing your data in Julia. Light enough to be a dependency on any project, yet rich enough to get the job done. OddFrames.jl is a selectively object-oriented data-management framework for manipulating, scaling, automating, and building data for scientific use. What makes OddFrames.jl unique, and why not just use the wonderfully robust [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl)? Good question. Although DataFrames.jl is a great, and more mature data-management interface, the goals of the package are inheritly different to the goals of this package. We start at the same base, in-memory tabular data, but looking at both methodology and features, things quickly change. As such, in some cases, DataFrames.jl may be the better tool for the job, and if this happens to be your first time using Julia, I would recommend learning DataFrames.jl **first**, though that certainly is not necessary. OddFrames.jl comes with the following special features, unlike DataFrames.jl:
- A multi-paradigm approach - DataFrames.jl mostly uses only multiple dispatch for handling operations with its types, we are in Julia afterall. OddFrames.jl uses some object-oriented syntax, some functional syntax, and some expression syntax.
- A core focus on mutability - Immutable and mutable types, as well as mutating and non-mutating methods, with clear distinctions between the two.
- Extendability - OddFrames makes it super easy to load and use extensions that might provide more functionality and capabilities.
- A significant effort for faster precompilation.
- Algebraic data - Data that can be modified via expressions and computed all in one go. This has a dramatic impact on memory.
- Linear algebra - More robust support for all the linear algebra calls that are provided by Julia, dispatched to the OddFrame types.
- Frame Grouping - A high-level grouping interface so you can interact with more than one OddFrame at the same time.
- Included IO - Input and output reading is included, and can easily be extended.
- Enhanced display output, feature descriptions.
- ML OddFrames - OddFrames that use ML to calculate data in a lazy fashion (only when it is needed!)
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

## Documentation
As this package has yet to be registered, or really have a stable release (it is almost here!), there is no web-based documentation for this module. That being said, you can still head over to the doc folder and read through the available MD, or generate your own documentation site. The documentation is also just not quite complete yet, nor is the testing. All of these words will be removed after 0.1.0, and in its place will be some links to documentation :)
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
### BIG Data
In terms of memory efficiency, OddFrames typically take up the same amount of memory as a DataFrame from DataFrames.jl. However, where things become different is with the AlgebraicOddFrame and other handy ways to manage memory.
