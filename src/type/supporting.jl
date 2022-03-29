mean(x) = sum(x) / length(x)

axis(labels::Vector{Symbol}, col::Symbol) = findall(x->x==col, labels)[1]

#==
THROWS
==#
function length_check(ps)
        ourlen = length(ps[1])
[if length(x) != ourlen throw(DimensionMismatch("Columns must be the same size")) end for x in ps]
end

function name_check(labels)
        println(Set(labels))
        if length(Set(labels)) != length(labels)
                throw(ErrorException("Column names may not be duplicated!"))
                println(Set(labels))
        end
end
function _txthead(labels::AbstractVector, columns::AbstractVector,
        count::Int64, coldata::AbstractVector{Pair})
        println("Text version of head not written yet...")
end

function accumulatebits(bits::AbstractArray)
        newbits = []
        for (count, val) in enumerate(bits[1])
                mu = mean([bits[count] for bit in bits])
                if mu != 1
                        push!(newbits, 0)
                else
                        push!(newbits, mu)
                end
        end
        return(BitArray(newbits))
end
