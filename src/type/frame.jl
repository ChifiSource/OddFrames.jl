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
        dtype::Function
        not::Function
        only::Function
        drop!::Function
        dropna!::Function
        dtype!::Function
        merge!::Function
        only!::Function
        #==
        Constructors
        ==#
        function OddFrame(labels::Vector{Symbol}, columns::Any,
                types::Vector{DataType})
                head, dtype, not, only = member_immutables(labels, columns,
                                                                types)
                drop!, dropna!, dtype!, merge!, only! = member_mutables(labels,
                columns, types)
                return(new(labels, columns, types, head, dtype, not, only, drop!,
                dropna!, dtype!, merge!, only!))
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
        function OddFrame(p::AbstractVector{Pair})
                # Labels/Columns
                labels, columns = ikeys(p), ivalues(p)
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
IMMUTABLE OddFrame
=============#
struct ImmutableOddFrame <: AbstractOddFrame
        labels::Tuple{Symbol}
        columns::Tuple{Any}
        types::Tuple{DataType}
        head::Function
        dtype::Function
        not::Function
        only::Function
    #==
    Constructors
    ==#
    function ImmutableOddFrame(labels::Tuple{Symbol}, columns::Any,
            types::Tuple{DataType})
            head, dtype, not, only = member_immutables(labels, columns,
                                                            types)
            return(new(labels, columns, types, head, dtype, not, only))
    end

    function ImmutableOddFrame(p::Pair ...)
            labels, columns = Tuple(ikeys(p)), Tuple(ivalues(p))
            length_check(columns)
            name_check(labels)
            types = Tuple([typeof(x[1]) for x in columns])
            return(ImmutableOddFrame(labels, columns, types))
    end
    
    function ImmutableOddFrame(p::AbstractVector{Pair})
            labels, columns = Tuple(ikeys(p)), Tuple(ivalues(p))
            length_check(columns)
            name_check(labels)
            types = Tuple([typeof(x[1]) for x in columns])
            return(ImmutableOddFrame(labels, columns, types))
    end
end



include("member_func.jl")
