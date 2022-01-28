"""
- **Functions**
- Fill Functions
### nothing()
A simple function bind for nothing (allowing one to use nothing as a function).
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
function nothing(n)
        return nothing
end

function zeros(n::Int64)
        return(0)
end

function na(x::Any)
    if ismissing(x)
        return(true)
    else
        return(false)
    end
end
