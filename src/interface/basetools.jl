"""
- **From OddFrames**
- Base Tools
### push!(iter::Any, val::Any; at::Int64 = length(iter))
This version of the push!() method is dispatched to take the kwarg at. At allows
us to change the index of the array we are pushing to mutably.
- **posarg[1]** iter::Any => Iter is any iterable that will be able to have **val**
 added to it.
- **posarg[2]** val::Any => The value we would like to push to our collection.
This should **not** be an iterable.
- **kwarg** at::Int64 => The index position we would like to push the value to.
##### return
Mutates **iter**.
##### example
```
array = [5, 10, 15, 20]
push!(array, 1, at = 2)
# pushed value 1 at index 2:
[5, 1, 10, 15, 20]

```
"""
function push!(iter::Any, val::Any; at::Int64 = length(iter))
    begin_vec = iter[1:at - 1]
    n_vec = iter[at:length(iter)]
    # Clears Array
    deleteat!(iter, 1:length(iter))
    [push!(iter, v) for v in begin_vec]
    push!(iter, val)
    [push!(iter, v) for v in n_vec]
    iter
end
"""
- **From OddFrames**
- Base Tools
### ikeys(pairs::Vector{Pair})
Parses keys of pairs into a 1-dimensional array.
- **posarg[1]** pairs::Vector{Pair} => Vector of pairs we would like to get the
keys of.
#### return
- **[1]** ::Array{Any} => Keys of **pairs** in a 1-D vector.
##### example
```
pairs = [:A => [5, 10], :B => [5, 10]]
ikeys(pairs)
[:A, :B]
```
"""
ikeys(pairs::Vector{Pair}) = [p[1] for p in pairs]
"""
- **From OddFrames**
- Base Tools
### ivalues(pairs::Vector{Pair})
Parses values of pairs into a 1-dimensional array.
- **posarg[1]** pairs::Vector{Pair} => Vector of pairs we would like to get the
values of.
#### return
- **[1]** ::Array{Any} => Values of **pairs** in a 1-D vector.
##### example
```
pairs = [:A => [5, 10], :B => [5, 10]]
ivalues(pairs)
[[5, 10], [5, 10]]
```
"""
ivalues(pairs::Vector{Pair}) = [p[2] for p in pairs]
"""
- **From OddFrames**
- Base Tools
### getindex(x::AbstractArray, mask::BitArray)
Removes any indexes equal to zero on the mask on **x**
- **posarg[1]** x::AbstractArray => Array we would like to apply our mask to.
- **posarg[2]** mask::BitArray => The boolean mask we would like to filter **x**
with.
#### return
- **[1]** ::Array{Any} => Post-filtered Array
##### example
```
array = [5, 10, 15]
array = array[array .== 5]
array

[5]
```
"""
function getindex(x::AbstractArray, mask::BitArray)
        pos = findall(x->x==0, mask)
        [deleteat!(x, p) for p in pos]
end
"""
- **From OddFrames**
- Base Tools
### getindex(x::AbstractArray, mask::Function)
Removes any indexes equal to zero on the mask function's return onto **x**.
- **posarg[1]** x::AbstractArray => Array we would like to apply our mask to.
- **posarg[2]** mask::Function => The bool-returning function we would like to
use to filter our data.
#### return
- **[1]** ::Array{Any} => Post-filtered Array
##### example
```
array = [5, 10, 15]
array = array[array .== 5]
array

[5]
```
"""
function getindex(x::AbstractArray, mask::Function)
    mask2 = [mask(x) for x in x]
    getindex(x, mask2)
end
"""
- **From OddFrames**
- Base Tools
### map!(array::AbstractArray, f::Function)
Maps a function to an iterable array. In this case, the special thing here is
        that it will mutate the provided **array**, not copy it.
- **posarg[1]** array::AbstractArray => The array we would like to apply
the function **f** to.
- **posarg[2]** f::Function => The function we wish to apply to **array**.
##### return
Mutates the provided **array**.
##### example
```
array = [5, 10, 15]
map!(array, x -> x += 5)
array
[10, 15, 20]
```
"""
map!(array::AbstractArray,
 f::Function) = [array[c] = f(x) for (c, x) in enumerate(array)]
