"""
- **From OddFrames**
- Base Tools
### ikeys(pairs::Vector{Pair}) -> Array{Any}
Parses keys of pairs into a 1-dimensional array.
##### example
```
pairs = [:A => [5, 10], :B => [5, 10]]
ikeys(pairs)
[:A, :B]
```
"""
ikeys(pairs::Any) = [p[1] for p in pairs]
"""
- **From OddFrames**
- Base Tools
### ivalues(pairs::Vector{Pair}) -> Array{Array}
Parses values of pairs into a 1-dimensional array.
##### example
```
pairs = [:A => [5, 10], :B => [5, 10]]
ivalues(pairs)
[[5, 10], [5, 10]]
```
"""
ivalues(pairs::Any) = [p[2] for p in pairs]
"""
- **From OddFrames**
- Base Tools
### getindex(x::AbstractArray, mask::BitArray) -> Array{Any}
Removes any indexes equal to zero on the mask on **x**
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
### getindex(x::AbstractArray, mask::Function) -> Array{Any}
Removes any indexes equal to zero on the mask function's return onto **x**.
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
### apply(array::AbstractArray, f::Function) -> ::Array
Applies a function to an iterable array.
##### example
```
array = [5, 10, 15]
map!(array, x -> x += 5)
array
[10, 15, 20]
```
"""
apply(array::AbstractArray, f::Function) = [f(x) for x in array]

"""
- **From OddFrames**
- Base Tools
### apply!(array::AbstractArray, f::Function) -> mutates array
Applies a function to an iterable array.
##### example
```
array = [5, 10, 15]
map!(array, x -> x += 5)
array
[10, 15, 20]
```
"""
apply!(array::AbstractArray, f::Function) = [push!(array, f(val), at = i) for (i, val) in enumerate(array)]
