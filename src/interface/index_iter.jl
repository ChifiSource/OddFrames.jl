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
function getindex(od::AbstractOddFrame, col::Symbol)
        pos = findall(x->x==col, od.labels)[1]
        return(od.columns[pos])
end
getindex(od::AbstractOddFrame, col::String) = od[Symbol(col)]
getindex(od::AbstractOddFrame, axis::Int64) = od.columns[axis]
getindex(od::AbstractOddFrame, range::UnitRange) = columns(od.only())
function getindex(od::AbstractOddFrame, mask::BitArray)
        pos = findall(x->x==0, mask)
        [od.drop!(p) for p in pos]
end
function setindex!(od::OddFrame, T::Type, i::Int64)
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
getindex(z::UnitRange) = [od.labels[i] for i in z]

getindex(fg::OddFrameContainer, axis::Int64) = fg.ods[axis])
