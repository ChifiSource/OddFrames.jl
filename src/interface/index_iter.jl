#===
Iterators
===#
"""
- **Interface**
- Indexing and Iteration
### frames(fg::OddFrameContainer)
This quickly returns an iterable Array of the frames in a framegroup.
- **posarg[1]** fg::AbstractOddFrameContainer => The fg should be the frame
group you want to get the frames of.
##### return
- **[1]** ::Array{OddFrame} => Array of OddFrames that were contained in fg.
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
- Indexing and Iteration
### columns(od::AbstractOddFrame)
This quickly returns an iterable Array of the columns in an OddFrame.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we wish to get the columns
of.
##### return
- **[1]** ::Array{AbstractArray} => A 1-dimensional array of 1-dimensional
features.
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
- Indexing and Iteration
### labels(od::AbstractOddFrame)
This quickly returns an iterable Array of the labels in an OddFrame.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we wish to get the columns
of.
##### return
- **[1]** ::Array{Symbol} => A 1-dimensional array of labels, Symbols.
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
- Indexing and Iteration
### labels(fg::OddFrameContainer)
This quickly returns an iterable Array of the frames in a framegroup.
- **posarg[1]** fg::OddFrameContainer => The fg should be the frame
group you want to get the labels of.
##### return
- **[1]** ::Array{Symbol} => Array of the labels inside the FrameGroup.
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
"""
### from OddFrames names(od::AbstractOddFrame)
- **Interface**
- Indexing and Iteration
### names(od::AbstractOddFrame)
names() is just a binding for labels(). It returns an array of the labels
found on the OddFrame.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we wish to get the columns
of.
##### return
- **[1]** ::Array{Symbol} => A 1-dimensional array of labels, Symbols.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 8, 3])
names(od)

[:A, :B]
```
"""
names(od::AbstractOddFrame) = od.labels
"""
- **Interface**
- Indexing and Iteration
### names(fg::OddFrameContainer)
names() is just a binding for labels(). It returns an array of the labels
found on the OddFrame.
- **posarg[1]** fg::OddFrameContainer => The fg should be the frame
group you want to get the labels of.
##### return
- **[1]** ::Array{Symbol} => Array of the labels inside the FrameGroup.
##### example
```
labels = [:od1, :od2]
fg = FrameGroup(OddFrame(:y => [5, 8, 2]), OddFrame(:x => [5, 15]),
labels = labels)
names(fg)

[:od1, :od2]
```
"""
names(fg::OddFrameContainer) = [label for label in fg.labels]
#===
Indexing
===#
"""
- **Interface**
- Indexing and Iteration
### getindex(od::AbstractOddFrame, col::Symbol)
Gets the corresponding index of columns from col's position in labels. Returns a
1-D array of the column's data.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we are indexing.
- **posarg[2]** col::Symbol => The column we would like to select.
##### return
- **[1]** ::Array{Any} => Values corresponding to index col.
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
- Indexing and Iteration
### getindex(od::AbstractOddFrame, col::String)
Gets the corresponding index of columns from col's position in labels. Returns a
1-D array of the column's data.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we are indexing.
- **posarg[2]** col::String => The column we would like to select.
##### return
- **[1]** ::Array{Any} => Values corresponding to index col.
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
### getindex(od::AbstractOddFrame, axis::Int64)
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
getindex(od::AbstractOddFrame, axis::Int64) = od.columns[axis]
"""
- **Interface**
- Indexing and Iteration
### getindex(od::AbstractOddFrame, axis::UnitRange)
Indexing with UnitRange allows us to select multiple columns by axis.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we are indexing.
- **posarg[2]** col::UnitRange => Range of axises to select.
##### return
- **[1]** ::Array{Any} => Array of values corresponding to the columns given in
the range.
##### example
```
od = OddFrame(:A => [5, 10, 15], :B => [5, 10, 15])
od[1:2]
[[5, 10, 15], [5, 10, 15]]
```
"""
getindex(od::AbstractOddFrame, range::UnitRange) = columns(od.only())
"""
- **Interface**
- Indexing and Iteration
### getindex(od::AbstractOddFrame, mask::BitArray)
Drops values when mask's equivalent index is false. Can be used to filter data.
found on the OddFrame.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we are indexing.
- **posarg[2]** mask::BitArray => The mask we would like to apply
##### return
- **[1]** ::OddFrame => A post-filtered OddFrame. Always returns a mutable copy.
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
- Indexing and Iteration
### setindex!(od::AbstractMutableOddFrame, T::Type, i::Int64)
Sets the type of a given column to a new type based on the axis.
- **posarg[1]** od::AbstractMutableOddFrame => The OddFrame we are manipulating.
- **posarg[2]** T::Type => The type we wish to cast.
- **posarg[3]** i::Int64 => The axis which we would like to cast.
##### return
Mutates the AbstractMutableOddFrame, od.
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
- Indexing and Iteration
### getindex(fg::OddFrameContainer, axis::Int64)
Used to select individual OddFrames from an OddFrameContainer's ods vector.
- **posarg[1]** fg::OddFrameContainer => The OddFrameContainer we are indexing.
- **posarg[2]** axis::Int64 => The axis at which we would like to select from
our OddFrameContainer.
##### return
- **[1]** ::OddFrame => The OddFrame stored at the index of **axis**.
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

function getindex(od::AbstractOddFrame, observation::Int64, labels::Symbol ...)

end
