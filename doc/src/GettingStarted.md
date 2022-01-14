# Getting Started
## Setup
Welcome to OddFrames.jl. In case you have not heard, this is a data-management framework for the Julia programming language. We have two options to chose from in terms of release.
- **main** We can add our package how we normally add packages, just by using Pkg.add, or using the Pkg REPL to add our package.
- **Unstable** The alternative is adding the Unstable branch. Which
will have non-breaking, but potentially not fully functional  or documented updates.
```@repl
using Pkg

Pkg.add("OddFrames")

] add OddFrames#Unstable
```
Once you have OddFrames.jl added to Pkg, you can now easily import it with using.

```@repl
using OddFrames
```
OddFrames is likely best experienced inside of a notebook session, but can certainly be applied to just about anywhere. Now that we have the package installed, lets get into how to use it on some data.
## Type Overview
We will start this tour through OddFrames by taking a look at the OddFrames types. We will of course start by looking at the type hierarchy. In Julia, sub-types can be dispatched to methods via their super-types. That in mind, this type system starts with those calls, for which every subsequent type below it now becomes bound to that dispatch call. The top of the frame heirarchy is **AbstractOddFrame**. Fortunately, unless we are developing with the package, we have no need to actually use this in any sort of calls, but we can still check its documentation in order to see a lot more information about it.
```@docs
AbstractOddFrame
```
We might need to define a bit of terminology for this to make a bit more sense. Especially since all of this naming will be recycled. The **Consistent Properties** section outlines values that will be
available in all sub-types of this abstract type. We have the same thing for something called Bindings, and below that we have a list of sub-types for this type.
- Sub-types inherit our methods.
- Bindings are function calls that are children of the struct, like a class.
- Properties are values that are stored within that type.
The sub-types below this are ImmutableOddFrame and AbstractMutableOddFrame, which adds a few more functions that
mutate the type or cannot be performed on an OddFrame that is not mutable. Lets get past the sub-types, now that we understand them, and look at the OddFrame type. If we do ?(OddFrame), we will receive a lot of information on constructors, every constructor
possible is listed with this syntax, however, it might make sense
to choose a more consistent dispatch. In order to only show the documentation for the dispatch we want to view, we provide the types as arguments just like if we were to be calling a method regularly.
```@example
?(OddFrame(::AbstractVector{Symbol}, ::AbstractVector{Any},
::Array{DataType}, ::Function, ::Function, ::Function, ::Function, ::Function,
::Function, ::Function, ::Function, ::Function))
```
Generally, this call would be called as ?(OddFrame), as the parameters for the actual user function is listed below the documentation on the type with the **Constructors** section. Lets go ahead and do that, so we can see ALL of the constructors available to us. Just a warning, there is about to be a lot of documentation here.

```@docs
OddFrame
```
