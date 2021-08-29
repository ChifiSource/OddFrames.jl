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
                labels = [pair[1] for pair in p]
                columns = [pair[2] for pair in p]
                length_check(columns)
                name_check(labels)
                # coldata
                coldata = generate_coldata(columns)
                # Head
                head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata, 5)
                # Drop
                drop(x) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                # type
                new(labels, columns, coldata, head, drop);
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
                head() = _head(labels, columns, coldata, 5)
                # Drop
                drop(x) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                # type
                new(labels, columns, coldata, head, drop);
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
                        if length(Set(column)) >= length(column) * .5
                                feature_type = :Continuous
                                if typeof(column[1]) == Date
                                        feature_type = :Date
                                elseif typeof(column[1]) == String
                                        if cchar('-', column[1] >= 2)
                                                feature_type = :Date
                                        elseif cchar(':', column[1] >= 1)
                                                feature_type = :Time
                                        else
                                                feature_type = :Categorical
                                        end
                                end
                        else
                                feature_type = :Categorical
                        end
                        if feature_type == :Continuous
                                coldata = string("data-type: ",
                                typeof(column[1]), "\n Feature Type: ",
                                feature_type, "\n Mean: ", mean(column),
                                "\n Minimum: ", minimum(column),
                                 "\n Maximum: ", maximum(column)
                                )
                        elseif feature_type == :Categorical
                                u=unique(column)
                                d=Dict([(i,count(x->x==i, column)) for i in u])
                                d = sort(collect(d), by=x->x[2])
                                coldata = string("data-type: ",
                                typeof(column[1]), "\n Feature Type: ",
                                feature_type, "\n Categories: ",
                                 length(Set((column))),
                                "\n Majority: "
                                )
                        else
                                coldata = string("data-type: ",
                                typeof(column[1]),"\n Feature Type: ",
                                feature_type)
                        end
                        push!(coldatas, coldata)
                end
                print(coldatas)
                return(coldatas)
        end
        function cchar(t::Union{AbstractString,Regex,AbstractChar},
                 s::AbstractString; overlap::Bool=false)
           n = 0
           i, e = firstindex(s), lastindex(s)
           while true
               r = findnext(t, s, i)
               isnothing(r) && break
               n += 1
               j = overlap || isempty(r) ? first(r) : last(r)
               j > e && break
               @inbounds i = nextind(s, j)
           end
           return n
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
                        println(labels)
                        println(Set(labels))
                        println(length(labels))
                        println(length(Set(labels)))
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
                coldata[n], "\">",  string(name),
                 "</th>") for (n, name) in enumerate(labels)]
                 # finish t-head
                 thead = string(thead, "</tr></thead>")
                 # populate each row iteratively.
                 for i in 1:count
                         obs = [row[i] for row in columns]
                         tbody = string(tbody, "<tr>")
                         [tbody = string(tbody, "<td ",
                         "title = \"", coldata[count], "\">"
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
# TODO Add column/row iterators for for loop iterator calls.
#===
Methods
===#
# TODO Move methods to different file, methods.jl
shape(od::AbstractOddFrame) = [length(od.labels), length(od.columns[1])]
