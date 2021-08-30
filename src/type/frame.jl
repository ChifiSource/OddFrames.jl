include("css.jl")
include("formats.jl")
using Lathe.stats: mean
using Dates
import Base: getindex, show, Meta
#=============
OddFrame Type
=============#
mutable struct OddFrame <: AbstractOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        coldata::Array{Pair}
        head::Function
        drop::Function
        dropna::Function
        #==
        Constructors
        ==#
        function OddFrame(p::Pair ...)
                # Labels/Columns
                labels = [pair[1] for pair in p]
                columns = [pair[2] for pair in p]
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                # coldata
                coldata = generate_coldata(columns, types)
                # Head
                head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata, 5)
                # Drop
                drop(x) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                dropna() = _dropna(columns)
                # type
                new(labels, columns, coldata, head, drop, dropna);
        end
        function OddFrame(file_path::String)
                # Labels/Columns
                extensions = Dict("csv" => read_csv)
                extension = split(file_path, '.')[2]
                labels, columns = extensions[extension](file_path)
                length_check(columns)
                name_check(labels)
                types, columns = read_types(columns)
                # Coldata
                coldata = generate_coldata(columns, types)
                # Head
                head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata, 5)
                # Drop
                drop(x) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                dropna() = _dropna(columns)
                # type
                new(labels, columns, coldata, head, drop, dropna);
        end
        #==
        Supporting
                Functions
        ( Support constructors )
        ==#
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
        #==
        Child
            methods
            ==#
        function _head(labels::Array{Symbol},
                columns::Array, coldata::Array, count::Int64)
                # Create t-header and t-body tags
                thead = "<thead><tr>"
                tbody = "<tbody>"
                # populate row headers
                [thead = string(thead, "<th ","title = \"",
                coldata[n][2], "\">",  string(name),
                 "</th>") for (n, name) in enumerate(labels)]
                 # finish t-head
                 thead = string(thead, "</tr></thead>")
                 # populate each row iteratively.
                 for i in 1:count
                         obs = [row[i] for row in columns]
                         tbody = string(tbody, "<tr>")
                         [tbody = string(tbody, "<td ",
                         "title = \"", coldata[count][2], "\">"
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
                coldata::Array)
                pos = findall(x->x==column, labels)[1]
                deleteat!(labels, pos)
                deleteat!(coldata, pos)
                deleteat!(columns, pos)
        end

        function _drop(row::Int64, columns::Array)
                [deleteat!(col, row) for col in columns]
        end

        function _drop(row::Array, columns::Array)
                [deleteat!(col, row) for col in columns]
        end

        function _dropna(columns::Array)
                for col in columns
                        mask = [ismissing(x) for x in col]
                        pos = findall(x->x==0, mask)
                        _drop(pos, columns)
                end
        end

end



#===
Indexing
===#
function getindex(od::AbstractOddFrame, col::Symbol)
        pos = findall(x->x==col, od.labels)[1]
        return(od.columns[pos])
end
getindex(od::AbstractOddFrame, col::String) = od[Symbol(col)]
getindex(od::AbstractOddFrame, axis::Int64) = od.columns[axis]
function getindex(od::OddFrame, mask::BitArray)
        pos = findall(x->x==0, mask)
        od.drop(pos)
end

#===
Iterators
===#
columns(od::OddFrame) = od.columns
labels(od::OddFrame) = od.labels
names(od::OddFrame) = od.labels
pairs(od::OddFrame) = [od.labels[i] => od.columns[i] for i in 1:length(od.labels)]
