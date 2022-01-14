
"""
- **Interface**
- Linear Algebra
### shape(od::AbstractOddFrame)
Returns a tuple representing the dimensions of the data within the OddFrame.
(width(od), length(od)).
- **posarg[1]** od::AbstractOddFrame => The OddFrame to get the
dimensions of.

##### return
- **[1]** ::Tuple{Int64, 2} => Two values representing the length and width of
the OddFrame in that order.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
shape(od)

(3, 3)
```
"""
shape(od::AbstractOddFrame) = (width(od), length(od))
"""
- **Interface**
- Linear Algebra
### size(od::AbstractOddFrame)
Size is just an alternate binding for shape()
- **posarg[1]** od::OddFrame => The OddFrame to get the
dimensions of.

##### return
- **[1]** ::Tuple{Int64, 2} => Two values representing the length and width of
the OddFrame in that order.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
size(od)

(3, 3)
```
"""
size(od::AbstractOddFrame) = shape(od)
"""
- **Interface**
- Linear Algebra
### size(od::AbstractOddFrame)
Returns n, the length of the features in the OddFrame.
- **posarg[1]** od::OddFrame => The OddFrame to get the
length of.

##### return
- **[1]** ::Int64 => The length of the provided OddFrame.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])
length(od)

3
```
"""
length(od::AbstractOddFrame) = length(od.columns[1])

"""
- **Interface**
- Linear Algebra
### Matrix(od::AbstractOddFrame)
Casts od into type Matrix while retaining dimensionality of features.
- **posarg[1]** od::OddFrame => The OddFrame to turn to a matrix.

##### return
- **[1]** ::Matrix => **od** as a Matrix.
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
