"""
- **Functions**
- Fill Functions
### nothing(n::Any) -> ::nothing
A simple function bind for nothing (allowing one to use nothing as a function).
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

od2 = copy(od)

od3 = merge(od, od2, at = 2)

columns(od3)
[[1, 2, 3], [1, 2, 3], [5, 4, 3], [5, 4, 3]]
```
"""
function nothing(n)
        return nothing
end

"""
- **Functions**
- Fill Functions
### zeroes(n::Any) -> ::Int64
Returns 0 no matter what.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

od2 = copy(od)

od3 = merge(od, od2, at = 2)

columns(od3)
[[1, 2, 3], [1, 2, 3], [5, 4, 3], [5, 4, 3]]
```
"""
function zeros(n::Int64)
        return(0)
end

"""
- **Functions**
- Masking Functions
### na(n::Any) -> ::Bool
This function returns whether or not a given value is missing.
##### example
```
od = OddFrame(:A => [1, 2, 3], :B => [5, 4, 3])

od2 = copy(od)

od3 = merge(od, od2, at = 2)

columns(od3)
[[1, 2, 3], [1, 2, 3], [5, 4, 3], [5, 4, 3]]
```
"""
function na(x::Any)
    if ismissing(x)
        return(false)
    else
        return(true)
    end
end
