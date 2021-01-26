include("css.jl")
import Base: getindex
#=========
o=o= Heirarchy overview =o=o
|AbstractOddFrame
|_____ OddFrame
|_____ ImageOddFrame
=========#
abstract type AbstractOddFrame end
#=============
OddFrame Type
=============#
mutable struct OddFrame{head} <: AbstractOddFrame
    lookup::Dict
    head::head
    function OddFrame(lookup::Dict)
        """Docstring test"""
        head(count; style = "classic") = _head(lookup, count, style = style)
        new{typeof(head)}(lookup, head)
    end
function _head(lookup::Dict, count::Int64 = 5; style::String = "classic")
    thead = "<thead>
<tr>"
    tbody = "<tbody>"
    [thead = string(thead, "<th>", string(name), "</th>") for name in keys(lookup)]
    thead = string(thead, "</thead>")
    cols = values(lookup)
    features = [push!(val) for val in cols]
    for i in 1:length(features[1])
        obs = [row[i] for row in features]
        tbody = string(tbody, "<tr>")
        [tbody = string(tbody, "<td>", observ, "</td>") for observ in obs]
        tbody = string(tbody, "</tr>")
    end
    tbody = string(tbody, "</tbody>")
    compisition = string(_css,"<table class = \"", style, "\">",
     thead, tbody,"</table>")
     try
         display("text/html", compisition)
     catch
         md = ""
         throw("Terminal display has not yet been implemented.")
    end
end

end
#=====
Methods
Many of these functional options will soon be replaced for their
object-oriented counter-parts -- but not all!
=====#
function drop(od::OddFrame, symb::Symbol)
    new_cop = Dict()
    for (key, val) in od.lookup
        if key != symb
            push!(new_cop, key => val)
        end
    end
    return(OddFrame(new_cop))
end
function drop(od::OddFrame, row::Int64)
    vals = d.lookup
    [splice!(val[2], row) for val in vals]
    return(OddFrame(vals))
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
function eachrow(of::OddFrame)
    cols = values(of.lookup)
    [[row[i] for row in cols] for i in 1:length(cols[1])]
end
eachcol(od::OddFrame) = values(od.lookup)
