include("css.jl")
include("formats.jl")
include("supporting.jl")

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
        function OddFrame(labels::Vector{Symbol}, columns::Any,
                types::Vector{DataType})
                head, drop!, dropna!, dtype, dtype!, merge! = _typefs(labels,
                 columns, types)
                new(labels, columns, types, head, drop!, dropna!, dtype,
                dtype!, merge!);
        end
        function OddFrame(p::Pair ...)
                labels, columns = ikeys(p), ivalues(p)
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                return(OddFrame(labels, columns, types))
        end
        function OddFrame(file_path::String;
                fextensions::Pair{String, Function} = [])
                extensions = ["csv" => read_csv]
                [push!(extensions, fext) for fext in fextensions]
                extensions = OddFrame(extensions)
                extension = split(file_path, '.')[2]
                labels, columns = extensions[extension](file_path)
                length_check(columns)
                name_check(labels)
                types, columns = read_types(columns)
                return(OddFrame(labels, columns, types))
        end
        function OddFrame(p::AbstractVector)
                # Labels/Columns
                labels  = [x[1] for x in p]
                columns = [x[2] for x in p]
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                return(OddFrame(labels, columns, types))
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



include("member_func.jl")
