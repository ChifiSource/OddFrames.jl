#===
Iterators
===#
"""
- **Interface**
- Iteration
### frames(fg::OddFrameContainer) -> ::Array{OddFrame}
This quickly returns an iterable Array of the oddframes in a framegroup.
##### example
```
labels = [:od1, :od2]
fg = FrameGroup(OddFrame(:y => [5, 8, 2]), OddFrame(:x => [5, 15]),
labels = labels)
ods = frames(fg)
```
"""
frames(fg::OddFrameContainer) = fg.ods

"""
- **Interface**
- Iteration
### columns(od::AbstractOddFrame) -> ::Array{AbstractArray}
Returns an iterable Array of the columns in an OddFrame.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 8, 3])
columns(od)

[[1, 2, 3], [5, 8, 3]]
```
"""
columns(od::AbstractOddFrame) = od.columns

"""
- **Interface**
- Iteration
### labels(od::AbstractOddFrame) -> ::Vector{Symbol}
Returns an iterable Array of the labels in an OddFrame.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 8, 3])
labels(od)

[:A, :B]
```
"""
labels(od::AbstractOddFrame) = od.labels

"""
- **Interface**
- Iteration
### labels(fg::OddFrameContainer) -> ::Vector{Symbol}
This quickly returns an iterable Array of the frames' labels in a framegroup.
##### example
```
labels = [:od1, :od2]
fg = FrameGroup(OddFrame(:y => [5, 8, 2]), OddFrame(:x => [5, 15]),
labels = labels)
labels(fg)

[:od1, :od2]
```
"""
labels(fg::AbstractOddFrame) = fg.labels

#===
Indexing
===#
"""
- **Interface**
- Indexing
### getindex(od::AbstractOddFrame, col::Symbol) -> ::Array{Any}
Gets the corresponding index of columns from col's position in labels. Returns a
1-D array of the column's data.
##### example
```
od = OddFrame(:A => [5, 10, 15])
od[:A]
[5, 10, 15]
```
"""
function getindex(od::AbstractOddFrame, col::Symbol)
        pos = findall(x->x==col, od.labels)[1]
        return(od.columns[pos])
end

"""
- **Interface**
- Indexing
### getindex(od::AbstractOddFrame, col::String) -> ::Array{Any}
Gets the corresponding index of columns from col's position in labels. Returns a
1-D array of the column's data.
##### example
```
od = OddFrame(:A => [5, 10, 15])
od["A"]
[5, 10, 15]
```
"""
getindex(od::AbstractOddFrame, col::String) = od[Symbol(col)]

"""
- **Interface**
- Indexing and Iteration
### getindex(od::AbstractOddFrame, axis::Int64) -> ::Array{Any}
Gets the corresponding index of columns from col's position in on the axis.
1-D array of the column's data.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we are indexing.
- **posarg[2]** col::Int64 => The column we would like to select.
##### return
- **[1]** ::Array{Any} => Values corresponding to index col.
##### example
```
od = OddFrame(:A => [5, 10, 15])
od[1]
[5, 10, 15]
```
"""
getindex(od::AbstractOddFrame; at = axis::Int64) = od.columns[axis]

"""
- **Interface**
- Indexing
### getindex(od::AbstractOddFrame, axis::UnitRange) -> ::Vector{Array{any}}
Indexing Returns all columns within range **at**.
##### example
```
od = OddFrame(:A => [5, 10, 15], :B => [5, 10, 15])
od[1:2]
[[5, 10, 15], [5, 10, 15]]
```
"""
getindex(od::AbstractOddFrame; at = range::UnitRange) = columns(od.only(range))

"""
- **Interface**
- Indexing
### getindex(od::AbstractOddFrame, mask::BitArray) -> ::OddFrame
Drops values when mask's equivalent index is false. Can be used to filter data.
found on the OddFrame. Does not mutate the data, provides a return.
##### example
```
od = OddFrame(:A => [5, 10, 15])
od[od[:A] .== 5]
columns(od)

[5]
```
"""
function getindex(od::AbstractOddFrame, mask::BitArray)
        pos = findall(x->x==0, mask)
        od = mutablecopy(od)
        [od.drop!(p) for p in pos]
        return(od)
end

"""
- **Interface**
- Indexing
### setindex!(od::AbstractMutableOddFrame, T::Type, i::Int64) -> mutates od
Sets the type of a given column **i** on **od** to a new type based on the axis.
##### example
```
od = OddFrame(:A => [5, 10, 15])
od[1] = Float64
```
"""
function setindex!(od::AbstractMutableOddFrame, T::Type, i::Int64)
        for (iter, obs) in enumerate(od[i])
                try
                        if type != String
                                obs = parse(T, string(obs))
                        else
                                obs = string(obs)
                        end
                catch
                        throw(string("Unable to cast all observations, stopped at x̄-",
                         iter))
                end
        end
end

"""
- **Interface**
- Indexing
### getindex(fg::OddFrameContainer, axis::Int64) -> OddFrame
Used to select individual OddFrames from an OddFrameContainer's ods vector.
#### example
```
od = OddFrame(:A => [5, 10, 15])
od2 = OddFrame(:B => [5, 10, 11])
fg = FrameGroup(od, od2)

fg[1]

[5, 10, 15]
```
"""
getindex(fg::OddFrameContainer, axis::Int64) = fg.ods[axis]

"""
- **Interface**
- Indexing
### getindex(od::AbstractOddFrame, observation::Int64, at = 1) -> ::Any
Used to select an observation **observation** from column **at** on **od**.
#### example
```
od = OddFrame(:A => [5, 10, 15], :B => [8, 12, 10])
od[1, at = 1]

5
```
"""
getindex(od::AbstractOddFrame, observation::Int64; at = 1) = od[at][observation]

"""
- **Interface**
- Iteration
### iterate(fg::OddFrameContainer, axis::Int64) -> ::Any
Partitions OddFrame columns to be iterated.
#### example
```
od = OddFrame(:A => [5, 10, 15])
od2 = OddFrame(:B => [5, 10, 11])
fg = FrameGroup(od, od2)

fg[1]

[5, 10, 15]
```
"""
function iterate(od::AbstractOddFrame)
    Iterators.partition(od.columns, 1)
end
