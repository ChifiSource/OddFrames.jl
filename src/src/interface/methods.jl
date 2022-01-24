"""
- **Interface**
- Methods
### width(od::AbstractOddFrame)
Returns the length of the labels of the OddFrame. For observation/row length,
please use length(::AbstractOddFrame).
(width(od), length(od)).
- **posarg[1]** od::AbstractOddFrame => The OddFrame to get the
dimension of.

##### return
- **[1]** ::Int64 => Integer count of columns on **od**
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
width(od)

2
```
"""
width(od::AbstractOddFrame) = length(od.labels)
"""
- **Interface**
- Methods
### show(od::AbstractOddFrame)
Calls **od**.head() to show the OddFrame WITH the length of itself, thus
this function prints the entire OddFrame.
- **posarg[1]** od::AbstractOddFrame => The OddFrame to show.

##### return
display("text/html")
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

show(od)

:A :B
1   5
2   4
3   3
```
"""
show(od::AbstractOddFrame) = od.head(length(od))
"""
- **Interface**
- Methods
### axis(od::AbstractOddFrame, col::Symbol)
Returns the axis of **col**, an OddFrame label (Symbol), on the OddFrame **od**.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we want to find the axis
on.
- **posarg[2]** col::Symbol => The label we want to find the index of on the
OddFrame.

##### return
- **[1]** ::Int64 => The axis of label **col** on **od**
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

axis(od, :A)

1
```
"""
axis(od::AbstractOddFrame, col::Symbol) = findall(x->x==col, od.labels)[1]
"""
- **Interface**
- Copy Methods
### mutablecopy(od::AbstractOddFrame)
Creates a new mutable OddFrame from the OddFrame **od**'s data. Can be used to
make mutable copies of immutables, or of course mutable copies of mutables.
However, in that case you might want to look into the **copy** method.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we wish to copy.
##### return
- **[1]** ::OddFrame => New copy of **od**
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

newcop = mutablecopy(od)

typeof(newcop)
OddFrame

println(newcop.columns)
[[1, 2, 3], [5, 4, 3]]
```
"""
function mutablecopy(od::AbstractOddFrame)
        values = copy(Array{Pair}(od))
        return(OddFrame(values))
end
"""
- **Interface**
- Copy Methods
### mutablecopy(od::AbstractOddFrame)
Creates a new immutable OddFrame from the OddFrame **od**'s data. Can be used to
make immutable copies or mutables, or of course immutable copies of immutables.
However, in that case you might want to look into the **copy** method.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we wish to copy.
##### return
- **[1]** ::ImmutableOddFrame => New immutable copy of **od**.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

newcop = Immutablecopy(od)

typeof(newcop)
ImmutableOddFrame

println(newcop.columns)
[[1, 2, 3], [5, 4, 3]]
```
"""
function immutablecopy(od::AbstractOddFrame)
        values = copy(Array{Pair}(od))
        return(ImmutableOddFrame(values))
end
"""
- **Interface**
- Copy Methods
### copy(od::OddFrame)
Creates a copy of **od**.
- **posarg[1]** od::OddFrame => The OddFrame we wish to copy.
##### return
- **[1]** ::OddFrame => New immutable copy of **od**.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

newcop = copy(od)

typeof(newcop)
OddFrame

println(newcop.columns)
[[1, 2, 3], [5, 4, 3]]
```
"""
function copy(od::OddFrame)
    values = copy(Array{Pair}(od))
    return(OddFrame(values))
end
"""
- **Interface**
- Copy Methods
### copy(od::ImmutableOddFrame)
Creates a copy of **od**.
- **posarg[1]** od::ImmutableOddFrame => The OddFrame we wish to copy.
##### return
- **[1]** ::ImmutableOddFrame => New immutable copy of **od**.
##### example
```
od = ImmutableOddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

newcop = copy(od)

typeof(newcop)
ImmutableOddFrame

println(newcop.columns)
[[1, 2, 3], [5, 4, 3]]
```
"""
function copy(od::ImmutableOddFrame)
        values = copy(Array{Pair}(od))
        return(ImmutableOddFrame(values))
end
"""
- **Interface**
- Copy Methods
### copy(fg::OddFrameContainer)
Creates a copy of **fg**.
- **posarg[1]** fg::OddFrameContainer => The OddFrame container to be copied.
##### return
- **[1]** ::FrameGroup => New copy of **fg**.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

od2 = copy(od)

fg = FrameGroup(od, od2)

fg2 = copy(fg)
```
"""
function copy(fg::OddFrameContainer)
        ods = [copy(od) for od in frames(fg)]
        return(FrameGroup(ods))
end
"""
- **Interface**
- Copy Methods
### deepcopy(fg::OddFrameContainer)
Creates a deep copy of **fg**.
- **posarg[1]** fg::OddFrameContainer => The OddFrame container to be copied.
##### return
- **[1]** ::FrameGroup => New deep copy of **fg**.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

od2 = copy(od)

fg = FrameGroup(od, od2)

fg2 = deepcopy(fg)
```
"""
function deepcopy(fg::OddFrameContainer)
        ods = [copy(od) for od in frames(fg)]
        return(FrameGroup(ods))
end
"""
- **Interface**
- Methods
### merge(od::AbstractOddFrame, od2::AbstractOddFrame; at::Int64, Symbol = 1)
The merge method is used to join two OddFrames, **od** and **od2**,
 together into one. In the future,
the name merge() will be replaced with the name join() for this arithmetic.
Same for the member functions _merge!() will become _join!
Instead, merge in its current form
 will be used to concatenate observations with mutual labels.
- **posarg[1]** od::AbstractOddFrame => The first OddFrame we that we want to
append our data to. This is also where the **at** key-word argument will be called.
- **posarg[2]** od2::AbstractOddFrame => The OddFrame we wish to concatenate
onto **od**.
- **kwarg** at::Int64, Symbol = 1 => The at key-word argument takes an index or
label, which then directs where the old features should lie in our OddFrame
**od**.
##### return
- **[1]** ::OddFrame => OddFrame with new columns merged.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

od2 = copy(od)

od3 = merge(od, od2, at = 2)

columns(od3)
[[1, 2, 3], [1, 2, 3], [5, 4, 3], [5, 4, 3]]
```
"""
function merge(od::AbstractOddFrame,
        od2::AbstractOddFrame; at::Any = 1)
        if typeof(at) == Symbol
                at = axis(od, col)
        end
        if at > width(od) || at < 1
                throw(BoundsError("Merge position is not an index on this OddFrame!"))
        end
        pairs = []
        for n in 1:width(od)
                if n == at
                        for z in 1:width(od2)
                                push!(pairs, od2.labels[z] => od2.columns[z])
                        end
                end
                push!(pairs, od.labels[n] => od.columns[n])
        end
        return(OddFrame(pairs))
end
"""
- **Interface**
- Methods
### pivot!(od::AbstractOddFrame, od2::AbstractOddFrame; at::Int64, Symbol = 1)
Pivots an OddFrame, **od**, based on the label provided in **at**.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we wish to pivot.
- **kwarg** at::Int64, Symbol, String = 1 => The at key-word argument takes an index or
label, which then directs where we be pivoting our OddFrame from.
##### return
Mutates the OddFrame.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
pivot!() has yet to be fully implemented, but will be a finished function soon.
It might work, I just have not tested it yet.
```
"""
function pivot!(od::AbstractMutableOddFrame; at::Any = 1)
        if typeof(at) == Symbol
                at = axis(od, col)
        end
        if length(od[at]) != length(names(od))
                throw(DimensionMismatch(string("Got names length of ",
                length(names(od)), " and at length of ", length(od[at]),
                ". These values must be equal.")))
        end
        labels = od.labels
        col = od.columns[at]
        od.labels = col
        od.col[at] = labels
end
"""
- **Interface**
- Management Methods
### delete!(od::AbstractMutableOddFrame)
Deletes a mutable OddFrame, turns its
components into nothing until alias is reassigned, helpful for quicker garbage
collection. If it is ever needed, it will certainly come in handy. Brings
OddFrames down to about 400 bytes of memory on average.
- **posarg[1]** od::AbstractMutableOddFrame =>
##### return
- **[1]** ::nothing => Nothing is returned, although this method is mutating, so
you do not need
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

delete!(od)

od.head()
nothing
```
"""
function delete!(od::AbstractMutableOddFrame)
    for name in names(od)
        od.drop!(name)
    end
    _deletefuncs!(od)
end
"""
- **Developer API**
- Management Methods
### _deletefuncs!(od::AbstractOddFrame)
Maps all the functions in a mutable OddFrame to the filter function
        **nothing**. Used to reduce memory usage and let the compiler know these
        are trash values.
- **posarg[1]** od::AbstractOddFrame => The OddFrame we wish to destroy the
functions on.
##### return
Mutates the OddFrame.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

_deletefuncs!(od)

od.head()
nothing
```
"""
function _deletefuncs!(od::AbstractMutableOddFrame)
        od.head = nothing()
        od.drop! = nothing()
        od.dropna! = nothing()
        od.dtype! = nothing()
        od.merge! = nothing()
end
