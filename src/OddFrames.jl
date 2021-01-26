module OddFrames
include("iter.jl")
include("indexing.jl")
_css = "
<style>
table.classic {
  width: 100%;
  height: 200px;
  text-align: left;
  border-collapse: collapse;
}
table.classic td, table.classic th {
  padding: 5px 4px;
}
table.classic tbody td {
  font-size: 13px;
}
table.classic tr:nth-child(even) {
  background: #F9F9F9;
}
table.classic thead {
  background: #CFCFCF;
  background: -moz-linear-gradient(top, #dbdbdb 0%, #d3d3d3 66%, #CFCFCF 100%);
  background: -webkit-linear-gradient(top, #dbdbdb 0%, #d3d3d3 66%, #CFCFCF 100%);
  background: linear-gradient(to bottom, #dbdbdb 0%, #d3d3d3 66%, #CFCFCF 100%);
  border-bottom: 3px solid #CDCDCD;
}
table.classic thead th {
  font-size: 15px;
  font-weight: bold;
  color: #424242;
  text-align: left;
}
table.jupyter {
  width: 100%;
  height: 200px;
  text-align: left;
  border-collapse: collapse;
}
table.jupyter td, table.jupyter th {
  padding: 5px 4px;
}
table.jupyter tbody td {
  font-size: 13px;
}
table.jupyter tr:nth-child(even) {
  background: #F9E5D0;
}
table.jupyter thead {
  background: #FC7A3D;
  background: -moz-linear-gradient(top, #fd9b6d 0%, #fc8750 66%, #FC7A3D 100%);
  background: -webkit-linear-gradient(top, #fd9b6d 0%, #fc8750 66%, #FC7A3D 100%);
  background: linear-gradient(to bottom, #fd9b6d 0%, #fc8750 66%, #FC7A3D 100%);
}
table.jupyter thead th {
  font-size: 15px;
  font-weight: bold;
  color: #FFFFFF;
  text-align: left;
}
</style>
"
abstract type AbstractOddFrame end
mutable struct OddFrame{head} <: AbstractOddFrame
    lookup::Dict
    head::head
    function OddFrame(lookup::Dict)
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
    display("text/html", compisition)
end

end
function drop(od::DataFrame, symb::Symbol)
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

export OddFrame, getindex, eachrow, eachcol, drop
end
