include("supporting.jl")
#==
Child
    methods
    ==#
function _head(labels::AbstractVector,
        columns::AbstractVector, types::AbstractVector, count::Int64)

        println(columns, types)
        coldata = generate_coldata(columns, types)
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
                pos = findall(x->x==1, mask)
                _drop(pos, columns)
        end
end

function _dtype(column, y)
try
        [y(i) for i in column]
catch
throw(TypeError("column type casting",
         y, column[1]))
 end
end
