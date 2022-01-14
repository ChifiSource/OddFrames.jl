
mean(x) = sum(x) / length(x)
axis(labels::Vector{Symbol}, col::Symbol) = findall(x->x==col, labels)[1]
function generate_coldata(columns::Array, types::Array)
        pairs = []
        for (i, T) in enumerate(types)
                if T == String
                        push!(pairs, T => string("Data-type: ",
                        T, "\nFeature Type: Categorical\n",
                        "Categories: ", length(Set(columns[i]))))
                elseif T == Bool
                        push!(pairs, T => string("Data-type: ",
                        T, "\nFeature Type: Categorical\n",
                        "Categories: ", length(Set(columns[i]))))
                elseif length(columns[i]) / length(Set(columns[i])) <= 1.8
                        push!(pairs, T => string("Data-type: ",
                        T, "\nFeature Type: Continuous\n", "Mean: ",
                        mean(columns[i])))
                else
                        push!(pairs, T => string("Data-type: ",
                        T, "\nFeature Type: Categorical\n",
                        "Categories: ", length(Set(columns[i]))))
                end
        end
        pairs
end
#==
THROWS
==#
function length_check(ps)
        ourlen = length(ps[1])
[if length(x) != ourlen throw(DimensionMismatch("Columns must be the same size")) end for x in ps]
end

function name_check(labels)
        if length(Set(labels)) != length(labels)
        throw(ErrorException("Column names may not be duplicated!"))
        end
end
