include("css.jl")
include("formats.jl")
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
        drop!::Function
        dropna!::Function
        dtype::Function
        dtype!::Function
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
                head, drop!, dropna!, dtype, dtype!, merge! = _typefs(labels,
                 columns, types)
                new(labels, columns, types, head, drop, dropna!, dtype,
                dytype!, merge!);
        end
        function OddFrame(file_path::String)
                # Labels/Columns
                extensions = Dict("csv" => read_csv)
                extension = split(file_path, '.')[2]
                labels, columns = extensions[extension](file_path)
                length_check(columns)
                name_check(labels)
                types, columns = read_types(columns)
                head, drop!, dropna!, dtype, dtype!, merge! = _typefs(labels,
                 columns, types)
                new(labels, columns, types, head, drop, dropna!, dtype,
                dytype!, merge!);
        end
        function OddFrame(p::AbstractVector)
                # Labels/Columns
                labels  = [x[1] for x in p]
                columns = [x[2] for x in p]
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                head, drop!, dropna!, dtype, dtype!, merge! = _typefs(labels,
                 columns, types)
                new(labels, columns, types, head, drop, dropna!, dtype,
                dytype!, merge!);
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

mutable struct Group <: OddFrameContainer
        ods::AbstractVector{AbstractOddFrame}
        labels::AbstractVector{Symbol}
        head::Function
        function Group(ods::AbstractOddFrame ...;
                 labels = [n for i in 1:length(ods)])
                 head = _typefs(ods, labels)
                new(ods, labels)
        end
end

include("member_func.jl")
