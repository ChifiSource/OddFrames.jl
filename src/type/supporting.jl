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
