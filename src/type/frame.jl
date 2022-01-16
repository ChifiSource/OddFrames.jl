include("css.jl")
include("formats.jl")
include("supporting.jl")
#=============
OddFrame Type
=============#
"""
- **Core**
- Frames
# OddFrame(::AbstractVector{Symbol}, ::AbstractVector{Any},
::Array{DataType}, ::Function, ::Function, ::Function, ::Function, ::Function,
::Function, ::Function, ::Function, ::Function)
The OddFrame type is the **mutable** form of data storage in OddFrames.jl. This
structure should not be called directly. If you want to create this type,
you should be looking at the constructors, listed below, not this documentation.
### Properties
- labels::AbstractVector{Symbol} => A vector of names that correspond to each
column on the OddFrame.
- columns::Vector{Any} => A vector of 1-D vectors for each feature in the OddFrame.
- types::Vector{Type} => The types of each column in a 1-D vector.
- head::Function => Binded call to _head.
- dtype::Function => Binded call to _dtype.
- not::Function => Binded call to _not.
- only::Function => Binded call to _only
- drop!::Function => Binded call to _drop!
- dropna!::Function => Binded call to _dropna!
- dtype!::Function => Binded call to _dtype!
- merge!::Function => Binded call to _merge!
- only!::Function => Binded call to _only!
## Bindings
These are the bindings for all the methods stored in this type. An important
        note is that methods ending with ! will mutate the OddFrame, whereas
        methods that do not contain this are consistent to Immutables.
#### OddFrame.head(count::Int64; html = :show) => _head
This will return a display, HTML text, or regular text version of an OddFrame
depending on the parameters provided to it.
- **posarg[1]** count::Int64 => The number of columns to visualize.
- **kwarg** html::Symbol => The type of return we want from the head function.
This can be :none, :show, or :return. :none will display text. Return will
return the HTML. Finally, :show will simply display the HTML.
##### return
- **[1]** ::String => The return of this function is not always existent, only
when the kwarg html is set to :return. The return will be a string of HTML.
##### example
```
od.head(5)
```

#### OddFrame.dtype(x::Symbol) => _dtype
Returns the data-type of a given column.
- **posarg[1]** x::Symbol => The label corresponding to which column we would
like to get the type of.
##### return
- **[1]** ::DataType => The type of od[x]
##### example
```
od.dtype(:year)
Int64
```

#### OddFrame.not(ls::Symbol, UnitRange, Int64 ...) => _not
Depending on the ranges, which is a range of axises, provided axises, or symbols,
we will get a return of a new OddFrame that does not include those values.
- **posarg[1]** ls::Symbol, UnitRange, Int64 ... => The symbol, range, or axis(s)
 we would like to remove.
##### return
- **[1]** ::OddFrame => A new OddFrame that does not contain the values provided.
##### example
```
od = OddFrame(:A => [5, 10, 15], :B => [1, 2, 3])
justb = od.not(:A)
```

#### OddFrame.only(ls::Symbol, UnitRange, Int64 ...) => _only
Depending on the ranges, which is a range of axises, provided axises, or symbols,
we will get a return of a new OddFrame that does not include any other values.
- **posarg[1]** ls::Symbol, UnitRange, Int64 ... => The symbol, range, or axis(s)
 we would like to extract.
##### return
- **[1]** ::OddFrame => A new OddFrame of only the provided values.
##### example
```
od = OddFrame(:A => [5, 10, 15], :B => [1, 2, 3])
justb = od.only(:B)
```

#### OddFrame.drop!(x::Symbol, String, Int64, UnitRange, BitArray, Array) => _drop!
Can be used to drop a column by label or axis, or by a direct call
(od.drop(od[:column])). Bitarrays will drop observations, however, not columns.
- **posarg[1]** x::Symbol, String, Int64, UnitRange, BitArray, Array =>
The symbol, axis, range, array, or bit array we are using to index our column to
drop.
##### return
Mutates the OddFrame.
#### example
```
od = OddFrame(:A => [5, 10, 15], :B => [1, 2, 3])
justb = od.drop!(:B)
columns(od)

[5, 10, 15]
```

#### OddFrame.dropna!() => _dropna!
Removes missing, null, and n/a values from the OddFrame by dropping observations.
 If you want to do this, but keep your observations, see fill!() and fillna!()
##### return
Mutates the OddFrame.
#### example
```
od = OddFrame(:A => [5, missing, 15], :B => [1, 2, 3])
od.dropna!(:B)
columns(od)

[[5, 15], [1, 3]]
```

#### OddFrame.dtype!(x::Symbol, y::Type) => _dtype!
Sets the data-type of a column specified with type **y** casted onto array **x**
.
- **posarg[1]** x::Symbol => The column we wish to parse as type y.
- **posarg[2]** y::Type => The type we wish to parse the column x as.

##### return
Mutates the OddFrame.
##### example
```
od = OddFrame(:A => [5, 10, 15], :B => [1, 2, 3])
# Sets column :B to type Float64:
od.dtype!(:B, Float64)
```

#### OddFrame.merge!(od::OddFrame, Array; at::Int64, Symbol = 1) => _merge!
Used to insert features from od into the OddFrame, at position determined by
kwarg at.
- **posarg[1]** od::OddFrame, String, Array => This argument is the data we
would like to merge with our OddFrame. It can be in the form of an array or
an OddFrame if there is more than one feature.
- **kwarg** at::Int64, Symbol = 1 => The axis at which to insert the data from
od.
##### return
Mutates the OddFrame.
#### example
```
od = OddFrame(:A => [5, 10, 15])
od2 = OddFrame(:B => [1, 2, 3])
od.merge!(od2)
columns(od)

[:A => [5, 10, 15], :B => [1, 2, 3]]
```

#### OddFrame.only!(ls::Symbol, UnitRange, Int64 ...) => _merge!
Removes all columns in OddFrame besides the ones specified.
- **posarg[1]** ls::Symbol, UnitRange, Int64 ... => ls should be values provided
as arguments representing the label, axis, or axis range at which to index.
##### return
Mutates the OddFrame.
#### example
```
od = OddFrame(:A => [5, 10, 15], :B => [3, 8, 4])
OddFrame.only!(:A)
columns(od)

[:A => [5, 10, 15]]
```
## Constructors
Here are the various constructors which return this type.
"""
mutable struct OddFrame <: AbstractMutableOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        types::Array
        head::Function
        dtype::Function
        not::Function
        only::Function
        drop!::Function
        dropna!::Function
        dtype!::Function
        merge!::Function
        only!::Function
        #==
        Constructors
        ==#
        function OddFrame(labels::Vector{Symbol}, columns::Any,
                types::Vector{DataType})
                head, dtype, not, only = member_immutables(labels, columns,
                                                                types)
                drop!, dropna!, dtype!, merge!, only! = member_mutables(labels,
                columns, types)
                return(new(labels, columns, types, head, dtype, not, only, drop!,
                dropna!, dtype!, merge!, only!))
        end
        function OddFrame(p::Pair ...)
                labels, columns = ikeys(p), ivalues(p)
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                return(OddFrame(labels, columns, types))
        end
        function OddFrame(file_path::String)
                extensions = Dict("csv" => read_csv)
                extension = split(file_path, '.')
                println("tried 1")
                ext = extension[2]
                println(ext)
                println("tried 2")
                labels, columns = extensions[ext](file_path)
                println("tried 3")
                length_check(columns)
                name_check(labels)
                println("tried 4")
                types, columns = read_types(columns)
                println("tried 5")
                return(OddFrame(labels, columns, types))
        end
        function OddFrame(p::AbstractArray)
                # Labels/Columns
                labels, columns = ikeys(p), ivalues(p)
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                return(OddFrame(labels, columns, types))
        end
        function OddFrame(d::Dict)
                return(OddFrame([p => v for (p, v) in d]))
        end
end
"""
- **Core**
- Frames
# ImmutableOddFrame(::Tuple{Symbol}, ::Tuple{Any},
::Tuple{DataType}, ::Function, ::Function, ::Function, ::Function)
The immutable OddFrame is an OddFrame that cannot be mutated. It can be used
on any conventional OddFrame methods that do not use the ! point naming scheme.
### Properties
- labels::Tuple{Symbol} => A vector of names that correspond to each
column on the OddFrame.
- columns::Tuple{Any} => A tuple of 1-D vectors for each feature in the OddFrame.
- types::Tuple{Type} => The types of each column in a 1-D vector.
- head::Function => Binded call to _head.
- dtype::Function => Binded call to _dtype.
- not::Function => Binded call to _not.
- only::Function => Binded call to _only
## Bindings
These are the bindings for all the methods stored in this type. An important
        note is that methods ending with ! will mutate the OddFrame, whereas
        methods that do not contain this are consistent to Immutables.
#### ImmutableOddFrame.head(count::Int64; html = :show) => _head
This will return a display, HTML text, or regular text version of an OddFrame
depending on the parameters provided to it.
- **posarg[1]** count::Int64 => The number of columns to visualize.
- **kwarg** html::Symbol => The type of return we want from the head function.
This can be :none, :show, or :return. :none will display text. Return will
return the HTML. Finally, :show will simply display the HTML.
##### return
- **[1]** ::String => The return of this function is not always existent, only
when the kwarg html is set to :return. The return will be a string of HTML.
##### example
```
od.head(5)
```

#### ImmutableOddFrame.dtype(x::Symbol) => _dtype
Returns the data-type of a given column.
- **posarg[1]** x::Symbol => The label corresponding to which column we would
like to get the type of.
##### return
- **[1]** ::DataType => The type of od[x]
##### example
```
od.dtype(:year)
Int64
```

#### ImmutableOddFrame.not(ls::Symbol, UnitRange, Int64 ...) => _not
Depending on the ranges, which is a range of axises, provided axises, or symbols,
we will get a return of a new OddFrame that does not include those values.
- **posarg[1]** ls::Symbol, UnitRange, Int64 ... => The symbol, range, or axis(s)
 we would like to remove.
##### return
- **[1]** ::ImmutableOddFrame => A new OddFrame that does not contain the values provided.
##### example
```
od = ImmutableOddFrame(:A => [5, 10, 15], :B => [1, 2, 3])
justb = od.not(:A)
```

#### ImmutableOddFrame.only(ls::Symbol, UnitRange, Int64 ...) => _only
Depending on the ranges, which is a range of axises, provided axises, or symbols,
we will get a return of a new OddFrame that does not include any other values.
- **posarg[1]** ls::Symbol, UnitRange, Int64 ... => The symbol, range, or axis(s)
 we would like to extract.
##### return
- **[1]** ::ImmutableOddFrame => A new OddFrame of only the provided values.
##### example
```
od = ImmutableOddFrame(:A => [5, 10, 15], :B => [1, 2, 3])
justb = od.only(:B)
```
## Constructors
Here are the various constructors which return this type.
"""
struct ImmutableOddFrame <: AbstractOddFrame
        labels::Tuple{Symbol}
        columns::Tuple{Any}
        types::Tuple{DataType}
        head::Function
        dtype::Function
        not::Function
        only::Function
    #==
    Constructors
    ==#
    function ImmutableOddFrame(labels::Tuple{Symbol}, columns::Any,
            types::Tuple{DataType})
            head, dtype, not, only = member_immutables(labels, columns,
                                                            types)
            return(new(labels, columns, types, head, dtype, not, only))
    end

    function ImmutableOddFrame(p::Pair ...)
            labels, columns = Tuple(ikeys(p)), Tuple(ivalues(p))
            length_check(columns)
            name_check(labels)
            types = Tuple([typeof(x[1]) for x in columns])
            return(ImmutableOddFrame(labels, columns, types))
    end

    function ImmutableOddFrame(p::AbstractVector{Pair})
            labels, columns = Tuple(ikeys(p)), Tuple(ivalues(p))
            length_check(columns)
            name_check(labels)
            types = Tuple([typeof(x[1]) for x in columns])
            return(ImmutableOddFrame(labels, columns, types))
    end
    ImmutableOddFrame(file_path::String;
    fextensions::Pair{String, Function} = []) = immutablecopy(OddFrame(file_path,
    fextensions = fextensions)
    )
    ImmutableOddFrame(d::Dict) = immutablecopy(OddFrame(d))
end



include("member_func.jl")
