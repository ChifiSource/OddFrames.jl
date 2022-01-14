#==
Casts
==#
"""
- **Interface**
- Casts
### Array{Pair}(od::AbstractOddFrame)
Casts type Array{Pair} to od.
- **posarg[1]** od::AbstractOddFrame => The OD we wish to cast to Array{Pair}.
##### return
- **[1]** ::Array{Pair} => Array of pairs from od.
##### example
```
pairs = [:A => [5, 6], :B => [7, 8]]
od = OddFrame(pairs)
pairs = Array{Pair}(od)

[:A => [5, 6], :B => [7, 8]]
```
"""
Array{Pair}(od::AbstractOddFrame) = [lbl => od.columns[i] for (i, lbl) in enumerate(od.labels)]
