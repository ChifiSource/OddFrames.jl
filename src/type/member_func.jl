include("supporting.jl")
function member_immutables(labels::Vector{Symbol},
         columns::AbstractVector, types::AbstractVector)
        # Non-mutating
        # head
        head(x::Int64; html = :show) = _head(labels, columns, types, x,
        html = html)
        head() = _head(labels, columns, types, 5)
        # dtype
        dtype(x::Symbol) = typeof(types[findall(x->x == x,
                                labels)[1]][1])
        # not
        not(ls::Symbol ...) = _not(ls, labels, columns)
        not(ls::UnitRange ...) = _not(ls, labels, columns)
        not(ls::Int64 ...) = _not(ls, labels, columns)
        # only
        only(ls::Symbol ...) = _only(ls, labels, columns)
        only(ls::UnitRange ...) = _only(ls, labels, columns)
        only(ls::Int64 ...) = _only(ls, labels, columns)
        return(head, dtype, not, only)
end

function member_mutables(labels::Vector{Symbol}, columns::AbstractVector,
        types::AbstractVector)
        # Mutating
        # drop!
        drop!(x) = _drop!(x, columns)
        drop!(x::Symbol) = _drop!(x, labels, columns, types)
        drop!(x::String) = _drop!(Symbol(x), labels, columns, types)
        # dropna!
        dropna!() = _dropna!(labels, columns, types)
        # dtype!
        dtype!(x::Symbol, y::Type) = _dtype!(columns[findall(x->x == x,
                                labels)[1]], y)
        # merge!
        merge!(od::OddFrame; at::Any = 1) = _merge!(labels, types,
                                columns, od, at)
        merge!(x::Array; at::Any = 1) = _merge!(labels, types,
                                columns, x, at)
        # only!
        only!(ls::Symbol ...) = _only!(ls, labels, columns, types)
        only!(ls::UnitRange ...) = _only!(ls, labels, columns, types)
        only!(ls::Int64 ...) = _only!(ls, labels, columns, types)
        return(drop!, dropna!, dtype!, merge!, only!)
end
#==
_not()
==#
function _not(i::Tuple{Symbol}, labels::Vector{Symbol}, columns::AbstractArray)
        mask = [! (val in i) for val in labels]
        nlabels = labels[mask]
        ncols = columns[mask]
        return(OddFrame([label => col for (label, col) in zip(nlabels, ncols)]))
end
function _not(i::Tuple{Int64}, labels::Vector{Symbol}, columns::AbstractArray)
        mask = [! (z in i) for z in 1:length(labels)]
        nlabels = labels[mask]
        ncols = columns[mask]
        return(OddFrame([label => col for (label, col) in zip(nlabels, ncols)]))
end
function _not(ranges::Tuple{UnitRange}, labels::Vector{Symbol},
        columns::AbstractArray)
        badindexes = []
        for range in ranges
                badindexes = vcat(badindexes, Array(range))
        end
        __not(Tuple(badindexes))
end

#==
_only()
==#
function _only(i::Tuple{Symbol}, labels::Vector{Symbol}, columns::AbstractArray)
        mask = [val in i for val in labels]
        nlabels = labels[mask]
        ncols = columns[mask]
        return(OddFrame([label => col for (label, col) in zip(nlabels, ncols)]))
end
#==
_only!()
==#
function _only!(i::Tuple{Symbol}, labels::Vector{Symbol},
         columns::AbstractArray, types::Vector{Type})
        mask = [label in i for label in labels]
        columns = _drop!(mask, labels, columns, types)
end

#==
Child
    methods
    ==#
function _txthead(labels::AbstractVector, columns::AbstractVector,
        count::Int64, coldata::AbstractVector{Pair})
        println("Text version of head not written yet...")
end
function _head(labels::AbstractVector,
        columns::AbstractVector, types::AbstractVector, count::Int64;
        html = :show)
        coldata = generate_coldata(columns, types)
        if html == :none
                return(_txthead(labels, columns, count, coldata))
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
function  _drop!(mask::BitArray, labels::Vector{Symbol},
         columns::AbstractArray, types::AbstractArray)
        pos = findall(x->x==0, mask)
        _drop(pos, column, labels, types)
end
function _drop!(row::Int64, columns::Array, labels::Vector{Symbol},
        types::Array{Type})
        [deleteat!(col, row) for col in columns]
end

function _drop!(rows::Array, columns::Array, labels::Vector{Symbol},
        types::Array{Type})
        [_drop!(value, columns, labels, types) for value in rows]
end
# TODO In the future, I would like to replace this call instead with a drop(na) where
#   na is a filter function.
function _dropna!(labels::Vector{Symbol}, columns::Array, types::Array)
        drops = []
        pos = [vcat(findall(x->ismissing(x), column), drops) for column in columns(od)]
        _drop!(pos, columns, labels, types)
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

function _fill!(f::Function, labels::Symbol ...)

end

function _fill!(f::Function, labels::Symbol ...)

end

function _fillna!(f::Function)

end
