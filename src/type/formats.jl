function read_csv(csv_path::String)
    readstr = open(f->read(f, String), csv_path, "r")
    rows = split(readstr, '\n')
    columns = split(rows[1], ',')
    values = [[] for col in columns]
    columns = Array{Symbol}(columns)
    deleteat!(rows, 1)
    for row in rows
        data = (split(row, ','))
        for col in 1:length(columns)
            push!(values[col], data[col])
        end
    end
    return(columns, values)
end
