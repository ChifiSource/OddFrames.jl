#==
Algebraic types allow for expressions to store data. The only issue is that data
has to be sorted, and furthermore, expressions compounded. Lastly, the algebraic
expression to represent real-world data can be quite difficult to create. I want
to create an algorithm for this, but as such it is really hard to "invent" a
function that handles this sort of data.
==#
mutable struct AlgebraicArray
    f::Function
    n::Int64
    calls::Vector{Pair{Function, Tuple}}
    function AlgebraicArray(f::Function, n::Int64)
        new(f, n, [])
    end
end

function add_algebra(aa::Symbol, args::Any)
    aa = eval(aa)
    if length(args) > 1
        farguments = Tuple(eval(args[length(args)]))
        push!(aa.calls, eval(args[1]) => farguments)
    else
        push!(aa.calls, eval(args[1]) => [])
    end
end

function generate(aa::AlgebraicArray)
    [aa.f(n) for n in 1:aa.n]
end

function generate(aa::AlgebraicArray, mask::BitArray)
    if length(mask) != aa.n
        throw(DimensionMismatch("Mask must be the same size as AlgebraicArray!"))
    end
    vals = Array(1:aa.n)
    filter!(vals, mask)
    [aa.f(n) for n in vals]
end

function generate(aa::AlgebraicArray, range::UnitRange)
    if range[2] > aa.n
        throw(BoundsError(string("Invalid algebraic index, ", string(range[2],
                        " on algebraic expression of length ", string(aa.n)))))
    end
    [aa.f(n) for n in range]
end

function generate(aa::AlgebraicArray, index::Integer)
    if index > aa.n
        throw(BoundsError(string("Invalid algebraic index, ", string(range[2],
                        " on algebraic expression of length ", string(aa.n)))))
    end
    aa.f(index)[1]
end

function compute(aa::AlgebraicArray, r::Any) # <- range, bitarray
    gen = generate(aa, r)
    for call in aa.calls
        gen = [call[1](val, call[2]...) for val in gen]
    end
    return(gen)
end

function compute(aa::AlgebraicArray, r::Integer) # <- Index
    gen = generate(aa, r)
    for call in aa.calls
        gen = [call[1](gen, call[2]...)]
    end
    return(gen)
end

function compute(aa::AlgebraicArray)
    gen = generate(aa)
    for call in aa.calls
        gen = [call[1](val, call[2]...) for val in gen]
    end
    return(gen)
end

function compute(f::Function, aa::AlgebraicArray) # compute(aa) do _
    gen = generate(aa)
    for call in aa.calls
        gen = [call[1](gen, call[2]...)]
    end
    return(f(gen))
end

macro algebraic!(exp::Expr)
    args = copy(exp.args)
    aa = exp.args[2]
    deleteat!(args, 2)
    add_algebra(aa, args)
end

getindex(aa::AlgebraicArray, i::Any) = compute(aa, i)

function iterate(aa::AlgebraicArray)
    ret = Iterators.partition(compute(aa), 1)
end
