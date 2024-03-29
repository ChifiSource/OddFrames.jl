function naparse(T::Type, val::Any)
    if ismissing(val)
        return(missing)
    else
        return(parse(T, val))
    end
end
function read_csv(csv_path::String)
    readstr = open(f->read(f, String), csv_path, "r")
    rows = split(readstr, '\n')
    columns = split(rows[1], ',')
    values = [[] for col in columns]
    columns = [Symbol(c) for c in Array{String}(columns)]
    deleteat!(rows, 1)
    for row in rows
        data = (split(row, ','))
        for col in 1:length(columns)
            try
                push!(values[col], data[col])
            catch
                push!(values[col], missing)
            end
        end
    end
    return(columns, values)
end

function read_types(columns)
    types = []
    for col in columns
        try
            parse(Bool, col[1])
            parse(Bool, col[2])
            push!(types, Bool)
        catch
            try
                parse(Int64, col[1])
                parse(Int64, col[2])
                push!(types, Float64)
            catch
                try
                    parse(Float64, col[1])
                    parse(Float64, col[2])
                    push!(types, Int64)
                catch
                    push!(types, String)
                end
            end
        end
    end
    newcolumns = []
    for (n, col) in enumerate(columns)
        if types[n] != String
            push!(newcolumns, [naparse(types[n], val) for val in col])
        else
            push!(newcolumns, col)
        end

    end
    return(types, newcolumns)
end
