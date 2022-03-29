"""
- **Interface**
- Linear Algebra
### size(od::AbstractOddFrame) -> ::Tuple{Int64, 2}
Returns a tuple representing the dimensions of the data within the OddFrame.
(x, y), (width(od), length(od)).
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
size(od)

(3, 3)
```
"""
size(od::AbstractOddFrame) = (width(od), length(od))

"""
- **Interface**
- Linear Algebra
### length(od::AbstractOddFrame) -> ::Int64
Returns n, the number of observations in the OddFrame.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
length(od)

3
```
"""
length(od::AbstractOddFrame) = length(od.columns[1])

"""
### from OddFrames Matrix(od::AbstractOddFrame) -> ::Matrix
- **Interface**
- Linear Algebra
### Matrix(od::AbstractOddFrame)
" Converts" od into type Matrix while retaining dimensionality of features.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
mat = Matrix(od)
Array([1, 2, 3]
[5, 4, 3])
```
"""
function Matrix(od::AbstractOddFrame)
    return(reshape(od.labels, length(od), width(od)))
end
