include("css.jl")
using Lathe.stats: mean
import Base: getindex
#=========
o=o= Heirarchy overview =o=o
|AbstractOddFrame
|_____ OddFrame
|_____ ImmutableOddFrame
|_____ ImageOddFrame
=========#
abstract type AbstractOddFrame end
#=============
OddFrame Type
=============#
mutable struct OddFrame <: AbstractOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        coldata::String
        head::Function
        drop::Function
        #==
        Constructors
        ==#
        function OddFrame(p::Pair ...)
                labels = [p[1] for pair in p]
                columns = [p[2] for pair in p]
                length_check(columns)
                coldata = generate_coldata(columns)
                head(x::Int64) = _head(labels, columns, x)
                head() = _head(labels, columns, 5)
                new(lookup, head, drop)
        end
        function OddFrame(file_path::String)
                extensions = Dict(".csv" => read_csv)
                extension = split(file_path, '.')[2]
                values, columns = extensions[extension](file_path)
                coldata = generate_coldata(columns::Array)
                head(x::Int64) = _head(labels, columns, x)
                head() = _head(labels, columns, 5)
        end
        #==
        Supporting
                Functions
        ( Support constructors )
        ==#
        function generate_coldata(columns::Array)

        end
        #==
        Child
            methods
            ==#
        function _head(labels::Array{Symbol},
                columns::Array{Any}, count::Int64)
                thead = "<thead><tr>"
                tbody = "<tbody>"
                [thead = string(thead, "<th>", string(name),
                 "</th>") for name in keys(lookup)]
                 thead = string(thead, "</tr></thead>")
                 cols = values(lookup)
                 features = [push!(val) for val in cols]
                 for i in 1:count)
                         obs = [row[i] for row in features]
                         tbody = string(tbody, "<tr>")
                         for observ in obs

                         end
                         [tbody = string(tbody, "<td>", observ,
        "</td>") for observ in obs]
                        tbody = string(tbody, "</tr>")
                 end
                 tbody = string(tbody, "</tbody>")
                 final = string("<table>", thead, tbody, "</table")
                 display("text/html", final)
        end

        function _drop(lookup::Dict, column::Symbol)
                delete!(lookup, column)
        end

        function _drop(lookup::Dict, row::Int64)
                [splice!(val[2], row) for val in lookup]
        end

        #==
        THROWS
        ==#
        function length_check(lookup)
                ourlen = length(ps[1])
                [if length(x) != ourlen throw(DimensionMismatch(
                "Columns must be the same size")) for x in ps]
        end
end



#===
Indexing
===#
getindex(od::OddFrame, col::Symbol) = od.lookup[col]
getindex(od::OddFrame, col::String) = od.lookup[Symbol(col)]
function getindex(od::OddFrame, mask::BitArray)
    [if mask[i] == 0 drop(od, i) end for i in 1:length(mask)]
end

#===
Iterators
===#
# TODO Add column/row iterators for for loop iterator calls.
