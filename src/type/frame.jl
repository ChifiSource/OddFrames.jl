include("css.jl")
using Lathe.stats: mean
using Dates
import Base: getindex
#=============
OddFrame Type
=============#
mutable struct OddFrame <: AbstractOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        coldata::Array{String}
        head::Function
        drop::Function
        #==
        Constructors
        ==#
        function OddFrame(p::Pair ...)
                # Labels/Columns
                labels = [p[1] for pair in p]
                columns = [p[2] for pair in p]
                length_check(columns)
                name_check(labels)
                # coldata
                coldata = generate_coldata(columns)
                # Head
                head(x::Int64) = _head(labels, columns, x)
                head() = _head(labels, columns, 5)
                # Drop
                drop(x::Int64) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                # type
                new(labels, columns, coldata, head, drop)
        end
        function OddFrame(file_path::String)
                # Labels/Columns
                extensions = Dict(".csv" => read_csv)
                extension = split(file_path, '.')[2]
                labels, columns = extensions[extension](file_path)
                length_check(columns)
                name_check(labels)
                # Coldata
                coldata = generate_coldata(columns)
                # Head
                head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata,  5)
                # Drop
                drop(x::Int64) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                # type
                new(labels, columns, coldata, head, drop)
        end
        #==
        Supporting
                Functions
        ( Support constructors )
        ==#
        function generate_coldata(columns::Array)
                coldatas = []
                for column in columns
                        feature_type = :Undetermined
                        if set(column[1]) >= length(columns[1]) * .25
                                feature_type = :Continuous
                                try
                                        Date(column[1])
                                        feature_type = :Date
                                catch
                                        if typeof(feature) == String
                                                feature_type = :Location
                                        end
                        else
                                feature_type = :Categorical
                        end
                        if feature_type = :Continuous
                                coldata = string("Feature Type: ",
                                feature_type, "\n Mean: ", mean(column),
                                "\n Minimum: ", minimum(column),
                                 "\n Maximum: ", maximum(column)
                                )
                        if feature_type = :Categorical
                                u=unique(column)
                                d=Dict([(i,count(x->x==i, column)) for i in u])
                                d = sort(collect(d), by=x->x[2])
                                maxkey = d[length(d)]
                                coldata = string("Feature Type: ",
                                feature_type, "\n Categories: ",
                                 length(set((column))),
                                "\n Majority: ", maxkey
                                )
                        else
                                coldata = string("Feature Type: ",
                                feature_type)
                        end
                        append!(coldatas, coldata)
                end
                return(coldatas)
        end

        #==
        THROWS
        ==#
        function length_check(ps)
                ourlen = length(ps[1])
                [if length(x) != ourlen throw(DimensionMismatch(
                "Columns must be the same size")) for x in ps]
        end

        function name_check(labels)
                if length(set(labels)) != length(labels)
                        throw(StringIndexError("Column names may not
                         be duplicated!"))
                end
        end
        #==
        Child
            methods
            ==#
        function _head(labels::Array{Symbol},
                columns::Array{Any}, coldata::Array{String}, count::Int64)
                # Create t-header and t-body tags
                thead = "<thead><tr>"
                tbody = "<tbody>"
                # populate row headers
                [thead = string(thead, "<th ","title = ",
                coldata[n], ">",  string(name),
                 "</th>") for (n, name) in enumerate(labels)]
                 # finish t-head
                 thead = string(thead, "</tr></thead>")
                 # populate each row iteratively.
                 for i in 1:count
                         obs = [row[i] for row in labels]
                         tbody = string(tbody, "<tr>")
                         [tbody = string(tbody, "<td ",
                         "title = ", coldata[count], ">"
                         , observ,
        "</td>") for (count, observ) in enumerate(obs)]
                        tbody = string(tbody, "</tr>")
                 end
                 # Finish tags:
                 tbody = string(tbody, "</tbody>")
                 final = string("<body><table>", thead, tbody,
                  "</table></body>", _css)
                 # Display
                 # TODO: Figure out how to determine whether one is in
                 #    the REPL, prefereably before any of this function is
                 # called.
                 display("text/html", final)
        end

        function _drop(column::Symbol, labels::Array{Symbol}, columns::Array,
                coldata::Array{String})
                pos = findall(x->x==col, labels)
                deleteat!(labels, pos)
                deleteat!(coldata, pos)
                deleteat!(columns, pos)
        end

        function _drop(row::Int64, columns::Array)
                [deleteat!(col, row) for col in columns]
        end


end



#===
Indexing
===#
function getindex(od::AbstractOddFrame, col::Symbol)
        return(od.columns[findall(x->x==col, od.labels)])
end
getindex(od::AbstractOddFrame, col::String) = od[Symbol(col)]
getindex(axis::Int64) =
function getindex(od::OddFrame, mask::BitArray)
    [if mask[i] == 0 drop(od, i) end for i in 1:length(mask)]
end

#===
Iterators
===#
# TODO Add column/row iterators for for loop iterator calls.
#===
Methods
===#
# TODO Move methods to different file, methods.jl
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
