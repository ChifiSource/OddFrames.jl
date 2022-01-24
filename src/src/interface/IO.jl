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

"""
## read(uri::String, T::Type) -> ::T
High-level binding call to read any data file into T. Other calls, and possible
data-files are
- read_csv (csv)
- read_json (json)
- read_xl (excel)
- read_tb (twobit)
- read_fa (fasta)
- read_rs (raw sequence)
"""
function read(uri::String, T::Type = OddFrame)

end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_csv(csv_path::String, T::Type = OddFrame)
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
    T(columns, values)
end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_json(uri::String, T::Type)

end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_xl(uri::String, T::Type)

end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_tb(uri::String, T::Type)

end
"""
## read_fa(uri::String, T::Type) -> ::T
Reads Fasta data.
"""
function read_fa(uri::String, T::Type)

end
"""
## read_rs(uri::String, T::Type) -> ::T
Reads raw sequence data
"""
function read_rs(uri::String, T::Type)

end


function naparse(T::Type, val::Any)
    if ismissing(val)
        return(missing)
    else
        return(parse(T, val))
    end
end



function to_csv(uri::String, od::AbstractOddFrame)

end
function to_json(uri::String, od::AbstractOddFrame)

end
function to_xl(uri::String, od::AbstractOddFrame)

end
function to_tb(uri::String, od::AbstractOddFrame)

end
function to_fa(uri::String, od::AbstractOddFrame)

end
function to_rs(uri::String, od::AbstractOddFrame)

end
