include("css.jl")
include("../interface/IO.jl")
include("supporting.jl")
include("algebraic.jl")
#=============
OddFrame Type
=============#
"""
- **Core**
- Frames
## OddFrame(::AbstractVector{Symbol}, ::AbstractVector{Any},
::Array{DataType}, ::Function, ::Function, ::Function, ::Function, ::Function,
::Function, ::Function, ::Function, ::Function) -> OddFrame
OddFrame outer constructor, not meant to be called directly.
#### Constructors
- **super** OddFrame(labels::Vector{Symbol}, columns::Any, types::AbstractArray))
- OddFrame()
- OddFrame(p::Pair ...)
- OddFrame(file_path::String)
- OddFrame(p::AbstractArray)
#### Properties
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
#### Bindings
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

#### OddFrame.only!(ls::Symbol, UnitRange, Int64 ...) -> _only!
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
"""
mutable struct OddFrame <: AbstractMutableOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        types::Array
        head::Function
        dtype::Function
        not::Function
        only::Function
        apply::Function
        fill::Function
        describe::Function
        drop!::Function
        dtype!::Function
        merge!::Function
        only!::Function
        apply!::Function
        #==
        Constructors
        ==#
        #==
        Super Constructor
        ==#
        """
        - **Core**
        - Frames
        #### OddFrame(labels::Symbol, columns::Any, types::AbstractArray)
        **Super** constructor for OddFrame. Should not be called directly. Is
        called by other constructors.
        ##### return
        - **[1]** ::OddFrame
        #### example
        ```
        od = OddFrame(labels, columns, types)
        ```
        """
        function OddFrame(labels::Vector{Symbol}, columns::Any,
                types::AbstractArray)
                length_check(columns)
                name_check(labels)
                head, dtype, not, only = member_immutables(labels, columns,
                                                                types)
                drop!, dtype!, merge!, only! = member_mutables(labels,
                columns, types)
                return(new(labels, columns, types, head, dtype, not, only, drop!,
                dtype!, merge!, only!))
        end
        """
        - **Core**
        - Frames
        #### OddFrame()
        Creates an OddFrame
        ##### return
        - **[1]** ::OddFrame
        #### example
        ```
        od = OddFrame()
        ```
        """
        function OddFrame()
                labels = Array{Symbol}([])
                types = Array{Type}([])
                columns = Array{Any}([])
                return(OddFrame(labels, columns, types))
        end

        function OddFrame(columns::Vector{Symbol}, values::AbstractArray)
                types = [typeof(column[1]) for column in values]
                OddFrame(columns, values, types)
        end
        """
        - **Core**
        - Frames
        #### OddFrame(p::Pair ...)
        Creates an OddFrame where the keys of p are labels, values are columns.
        ##### return
        - **[1]** ::OddFrame
        #### example
        ```
        od = OddFrame(:A => [5, 10, 15], :B => [5, 10, 15])
        ```
        """
        function OddFrame(p::Pair ...)
                labels, columns = ikeys(p), ivalues(p)
                types = [typeof(x[1]) for x in columns]
                return(OddFrame(labels, columns, types))
        end
        """
        - **Core**
        - Frames
        #### OddFrame(file_path::String)
        Creates an OddFrame from a file path. Uses the file extension, e.g. .csv
        to determine format reader. To avoid this, use read(::String, ::Symbol).
        ##### return
        - **[1]** ::OddFrame
        #### example
        ```
        od = OddFrame("example.csv")
        ```
        """
        function OddFrame(file_path::String)
                read(file_path, OddFrame)
        end
        """
        - **Core**
        - Frames
        #### OddFrame(p::AbstractArray)
        Creates an OddFrame from an array of pairs.
        ##### return
        - **[1]** ::OddFrame
        #### example
        ```
        od = OddFrame([:A => [5, 10], :B => [5, 10]])
        ```
        """
        function OddFrame(p::AbstractArray)
                # Labels/Columns
                labels, columns = ikeys(p), ivalues(p)
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                return(OddFrame(labels, columns, types))
        end
        """
        - **Core**
        - Frames
        #### OddFrame(d::Dict)
        Creates an OddFrame from a dictionary
        ##### return
        - **[1]** ::OddFrame
        #### example
        ```
        od = OddFrame(Dict(:A => [5, 10], :B => [5, 10]))
        ```
        """
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
    """
    - **Core**
    - Frames
    #### ImmutableOddFrame(file_path::String)
    **Super Constructor** for ImmutableOddFrame, called in all other constructors.
    ##### return
    - **[1]** ::ImmutableOddFrame
    #### example
    ```
    od = ImmutableOddFrame(labels, columns, types)
    ```
    """
    function ImmutableOddFrame(labels::Tuple, columns::Tuple,
            types::Tuple)
            head, dtype, not, only = member_immutables(labels, columns,
                                                            types)
            return(new(labels, columns, types, head, dtype, not, only))
    end
    """
    - **Core**
    - Frames
    #### ImmutableOddFrame(file_path::String)
    **Super Constructor** for ImmutableOddFrame, called in all other constructors.
    ##### return
    - **[1]** ::ImmutableOddFrame
    #### example
    ```
    od = ImmutableOddFrame(labels, columns, types)
    ```
    """
    function ImmutableOddFrame(p::Pair ...)
            labels, columns = Tuple(ikeys(p)), Tuple(ivalues(p))
            length_check(columns)
            name_check(labels)
            types = Tuple([typeof(x[1]) for x in columns])
            return(ImmutableOddFrame(labels, columns, types))
    end
    """
    - **Core**
    - Frames
    #### ImmutableOddFrame(p::AbsttractArray)
    Constructs an array from the pairs in **p**
    ##### return
    - **[1]** ::ImmutableOddFrame
    #### example
    ```
    od = ImmutableOddFrame(labels, columns, types)
    ```
    """
    function ImmutableOddFrame(p::AbstractArray)
            labels, columns = Tuple(ikeys(p)), Tuple(ivalues(p))
            length_check(columns)
            name_check(labels)
            types = Tuple([typeof(x[1]) for x in columns])
            return(ImmutableOddFrame(labels, columns, types))
    end
    """
    - **Core**
    - Frames
    #### ImmutableOddFrame(p::AbsttractArray)
    Constructs an array from the pairs in **p**
    ##### return
    - **[1]** ::ImmutableOddFrame
    #### example
    ```
    od = ImmutableOddFrame(labels, columns, types)
    ```
    """
    function ImmutableOddFrame(file_path::String)
            immutablecopy(OddFrame(file_path))
    end
    """
    - **Core**
    - Frames
    #### ImmutableOddFrame(d::Dict) -> ImmutableOddFrame
    Constructs an array from dictionary **d**.
    #### example
    ```
    od = ImmutableOddFrame(labels, columns, types)
    ```
    """
    ImmutableOddFrame(d::Dict) = immutablecopy(OddFrame(d))
end

mutable struct AlgebraicOddFrame <: AbstractAlgebraOddFrame
        labels::Array{Symbol}
        columns::Vector{AlgebraicArray}
        types::Array{Type}
        head::Function
        dtype::Function
        not::Function
        only::Function
        drop!::Function
        dtype!::Function
        merge!::Function
        only!::Function
        compute::Function
        # Super
        function AlgebraicOddFrame(labels::Vector{Symbol},
                columns::Vector{AlgebraicArray},
                types::AbstractArray)
                length_check(columns)
                name_check(labels)
                head, dtype, not, only = member_immutables(labels, columns,
                                                                types)
                drop!, dtype!, merge!, only! = member_mutables(labels,
                columns, types)
compute() = OddFrame([label[i] => compute(columns[i]) for i in enumerate(labels)])
                compute(;at = 1) = [label[at] => compute(columns[at])]
                compute(r;at = 1) = [label[at] => compute(columns[at], r)]
compute(r) = OddFrame([label[i] => compute(columns[i], r) for i in enumerate(labels)])
                new(labels, columns, types, head, dtype, not, only, drop!,
                dtype!, merge!, only!, compute)
        end
        function AlgebraicOddFrame(n::Integer, fs::Function ...;
                labels = [Symbol(i) for i in 1:length(fs)])
                columns = [AlgebraicArray(f, n) for f in fs]
                types = [typeof(col[1]) for col in columns]
                AlgebraicOddFrame(labels, columns), types
        end
end

mutable struct MLOddFrame <: AbstractAlgebraOddFrame
        labels::Array{Symbol}
        columns::Vector{AlgebraicArray}
        types::Array{Type}
        head::Function
        dtype::Function
        not::Function
        only::Function
        drop!::Function
        dtype!::Function
        merge!::Function
        only!::Function
        compute::Function
        # Super
        function MLOddFrame(labels::Vector{Symbol},
                columns::Vector{AlgebraicArray},
                types::AbstractArray)
                length_check(columns)
                name_check(labels)
                head, dtype, not, only = member_immutables(labels, columns,
                                                                types)
                drop!, dtype!, merge!, only! = member_mutables(labels,
                columns, types)
compute() = OddFrame([label[i] => compute(columns[i]) for i in enumerate(labels)])
                compute(;at = 1) = [label[at] => compute(columns[at])]
                compute(r;at = 1) = [label[at] => compute(columns[at], r)]
compute(r) = OddFrame([label[i] => compute(columns[i], r) for i in enumerate(labels)])
                new(labels, columns, types, head, dtype, not, only, drop!,
                dtype!, merge!, only!, compute)
        end
        function MLOddFrame(n::Integer, fs::Function ...;
                labels = [Symbol(i) for i in 1:length(fs)])
                columns = [AlgebraicArray(f, n) for f in fs]
                types = [typeof(col[1]) for col in columns]
                AlgebraicOddFrame(labels, columns), types
        end
end

include("member_func.jl")
