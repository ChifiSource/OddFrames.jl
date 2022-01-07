include("css.jl")
include("formats.jl")
include("member_func.jl")
include("supporting.jl")
using Dates

#Binding(od::AbstractOddFrame, s::Symbol) = eval(df.)
#=============
OddFrame Type
=============#

mutable struct OddFrame <: AbstractMutableOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        types::Array
        head::Function
        drop::Function
        dropna::Function
        dtype::Function
        merge!::Function
        #==
        Constructors
        ==#
        function OddFrame(p::Pair ...)
                # TODO Would be nice to combine these loops:
                labels  = [x[1] for x in p]
                columns = [x[2] for x in p]
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                # Head
                #== TODO, maybe the best approach to solving
                the TODO outlined in member_func : 35 is to check
                REPL or otherwise here?==#
                head(x::Int64) = _head(labels, columns, types, x, )
                head() = _head(labels, columns, types, 5)
                # Drop
                drop(x) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                # Dropna
                dropna() = _dropna(columns)
                # Dtype
                dtype(x::Symbol) = typeof(types[findall(x->x == x,
                                                labels)[1]][1])
                dtype(x::Symbol, y::Type) = _dtype(columns[findall(x->x == x,
                 labels)[1]], y)
                # Merge
                merge!(od::OddFrame; at::Any = 0) = _merge!(labels, types,
                columns, od, at)
                merge!(x::Array; at::Any = 0) = _merge!(labels, types,
                columns, x, at)
                # type
                new(labels, columns, types, head, drop, dropna, dtype, merge!);
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
                head(x::Int64) = _head(labels, columns, coldata, x, types)
                head() = _head(labels, columns, types, 5)
                # Drop
                drop(x) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                dropna() = _dropna(columns)
                dtype(x::Symbol) = typeof(coldata[findall(x->x == x,
                                                labels)[1]][1])
                dtype(x::Symbol, y::Type) = _dtype(columns[findall(x->x == x,
                 labels)[1]], y)
                # type
                new(labels, columns, coldata, head, drop, dropna, dtype);
        end
        function OddFrame(p::AbstractVector)
                # Labels/Columns
                labels  = [x[1] for x in p]
                columns = [x[2] for x in p]
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                # Head
                head(x::Int64) = _head(labels, columns, types, x)
                head() = _head(labels, columns, types, 5)
                # Drop
                drop(x) = _drop(x, columns)
                drop(x::Symbol) = _drop(x, labels, columns, coldata)
                drop(x::String) = _drop(Symbol(x), labels, columns, coldata)
                dropna() = _dropna(columns)
                dtype(x::Symbol) = typeof(coldata[findall(x->x == x,
                                                labels)[1]][1])
                dtype(x::Symbol, y::Type) = _dtype(columns[findall(x->x == x,
                 labels)[1]], y)
                # type
                new(labels, columns, types, head, drop, dropna, dtype);
        end
        function OddFrame(d::Dict)
                return(OddFrame([p => v for (p, v) in d]))
        end
end
#=============
IMMUTABLE OddFrame Type
=============#
struct ImmutableOddFrame <: AbstractOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        coldata::Array{Pair}
        head::Function
        dtype::Function
    #==
    Constructors
    ==#
    function ImmutableOddFrame(p::Pair ...)
        od = OddFrame(p)
        labels, columns = Tuple(od.labels), Tuple(od.columns)
        coldata = Tuple(od.coldata)
        dtype(x::Symbol) = typeof(coldata[findall(x->x == x,
             labels)[1]][1])
        head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata, 5)
        new(labels, columns, coldata, head, dtype)
    end
    function ImmutableOddFrame(file_path::String)
        od = OddFrame(file_path)
        labels, columns = Tuple(od.labels), Tuple(od.columns)
        coldata = Tuple(od.coldata)
        dtype(x::Symbol) = typeof(coldata[findall(x->x == x,
             labels)[1]][1])
        head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, types, 5)
        new(labels, columns, coldata, head, dtype)
    end

end
