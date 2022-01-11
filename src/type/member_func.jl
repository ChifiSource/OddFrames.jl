include("supporting.jl")
function _typefs(labels::Vector{Symbol}, columns::AbstractVector, types::AbstractVector)
        # Non-mutating
        # Head
        head(x::Int64; html = :show) = _head(labels, columns, types, x,
        html = html)
        head() = _head(labels, columns, types, 5)
#        Dtype
        dtype(x::Symbol) = typeof(types[findall(x->x == x,
                                labels)[1]][1])
        # Mutating
        # Drop
        drop!(x) = _drop!(x, columns)
        drop!(x::Symbol) = _drop!(x, labels, columns, types)
        drop!(x::String) = _drop!(Symbol(x), labels, columns, types)
        # Dropna
        dropna!() = _dropna!(columns)

        dtype!(x::Symbol, y::Type) = _dtype(columns[findall(x->x == x,
                                labels)[1]], y)
        # Merge
        merge!(od::OddFrame; at::Any = 0) = _merge!(labels, types,
                                columns, od, at)
        merge!(x::Array; at::Any = 0) = _merge!(labels, types,
                                columns, x, at)
        return(head, drop!, dropna!, dtype, dtype!, merge!)
end

#==
Child
    methods
    ==#
function _texthead(labels::AbstractVector, columns::AbstractVector,
        count::Int64, coldata::AbstractVector{Pair})
        println("Text version of head not written yet...")
end
function _head(labels::AbstractVector,
        columns::AbstractVector, types::AbstractVector, count::Int64;
        html = :show)

        coldata = generate_coldata(columns, types)
        if html == :none
                return(_head(labels, columns, count, coldata))
        end
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
         tbody = string(tbody, "</tbody>")
         final = string("<body><table>", thead, tbody,
          "</table></body>", _css)
         # Display
         # TODO: Figure out how to determine whether one is in
         #    the REPL, prefereably before any of this function is
         # called.
         if html == :show
                 display("text/html", final)
         elseif html == :return
                 return(final)
         end

end

function _drop!(column::Symbol, labels::Array{Symbol}, columns::Array,
        types::Array)
        pos = findall(x->x==column, labels)[1]
        deleteat!(labels, pos)
        deleteat!(types, pos)
        deleteat!(columns, pos)
end

function _drop!(row::Int64, columns::Array)
        [deleteat!(col, row) for col in columns]
end

function _drop!(row::Array, columns::Array)
        [deleteat!(col, row) for col in columns]
end

function _dropna!(columns::Array)
        for col in columns
                mask = [ismissing(x) for x in col]
                pos = findall(x->x==1, mask)
                _drop!(pos, columns)
        end
end

function _dtype!(column, y)
try
        [y(i) for i in column]
catch
throw(TypeError("column type casting",
         y, column[1]))
 end
end

function _merge!(labels::Vector{Symbol}, types::AbstractVector,
         columns::AbstractVector, od::AbstractOddFrame, at::Any)
        if typeof(at) == Symbol
                at = findall(x->x==at, labels)[1]
        end
        length_check([od[1], columns[1]])
        for val in names(od)
                push!(labels, val, at = at)
                push!(columns, od[val], at = at)
                push!(types, od.dtype(val))
                at += 1
        end
end
function _merge!(labels::Vector{Symbol}, types::AbstractVector,
         columns::AbstractVector, x::Any, at::Any)
        if typeof(at) == Symbol
                at = findall(x->x==at, labels)[1]
        end
        length_check([x, columns[1]])
        push!(labels, Symbol(at), at = at)
        push!(columns, x, at = at)
        push!(types, typeof(x[1]), at = at)
end
