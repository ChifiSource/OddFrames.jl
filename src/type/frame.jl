#=============
OddFrame Type
=============#
include("css.jl")
include("supporting.jl")
include("algarray.jl")
mutable struct OddFrame <: AbstractMutableOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        types::Array
        head::Function
        dtype::Function
        not::Function
        only::Function
        describe::Function
        drop!::Function
        dtype!::Function
        merge!::Function
        only!::Function
        apply!::Function
        fill!::Function
        #==
        Constructors
        ==#
        #==
        Super Constructor
        ==#
        function OddFrame(labels::Vector{Symbol}, columns::Any,
                types::AbstractArray)
                length_check(columns)
                name_check(labels)
                head, dtype, not, only, describe = member_immutables(labels, columns,
                                                                types)
                drop!, dtype!, merge!, only!, apply!, fill! = member_mutables(labels,
                columns, types)
                return(new(labels, columns, types, head, dtype, not, only, describe,
                drop!,
                dtype!, merge!, only!, apply!, fill!))
        end

        function OddFrame()
                labels = Array{Symbol}([])
                types = Array{Type}([])
                columns = Array{Any}([])
                return(OddFrame(labels, columns, types))
        end

        function OddFrame(columns::Vector{Symbol}, values::AbstractArray)
                types = [typeof(column[1]) for column in values]
                OddFrame(columns, values, types)
        end

        function OddFrame(p::Pair ...)
                labels, columns = ikeys(p), ivalues(p)
                types = [typeof(x[1]) for x in columns]
                return(OddFrame(labels, columns, types))
        end

        function OddFrame(file_path::String)
                read(file_path, OddFrame)
        end

        function OddFrame(p::AbstractArray)
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
    function ImmutableOddFrame(labels::Tuple, columns::Tuple,
            types::Tuple)
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

    function ImmutableOddFrame(p::AbstractArray)
            labels, columns = Tuple(ikeys(p)), Tuple(ivalues(p))
            length_check(columns)
            name_check(labels)
            types = Tuple([typeof(x[1]) for x in columns])
            return(ImmutableOddFrame(labels, columns, types))
    end

    function ImmutableOddFrame(file_path::String)
            immutablecopy(OddFrame(file_path))
    end

    ImmutableOddFrame(d::Dict) = immutablecopy(OddFrame(d))
end

mutable struct AlgebraicOddFrame <: AbstractAlgebraOddFrame
        labels::Array{Symbol}
        columns::Vector{AlgebraicArray}
        types::Array{Type}
        head::Function
        dtype::Function
        not::Function
        only::Function
        drop!::Function
        dtype!::Function
        merge!::Function
        only!::Function
        compute::Function
        # Super
        function AlgebraicOddFrame(labels::Vector{Symbol},
                columns::Vector{AlgebraicArray},
                types::AbstractArray)
                length_check(columns)
                name_check(labels)
                head, dtype, not, only = member_immutables(labels, columns,
                                                                types)
                drop!, dtype!, merge!, only! = member_mutables(labels,
                columns, types)
compute() = OddFrame([label[i] => compute(columns[i]) for i in enumerate(labels)])
                compute(;at = 1) = [label[at] => compute(columns[at])]
                compute(r;at = 1) = [label[at] => compute(columns[at], r)]
compute(r) = OddFrame([label[i] => compute(columns[i], r) for i in enumerate(labels)])
                new(labels, columns, types, head, dtype, not, only, drop!,
                dtype!, merge!, only!, compute)
        end
        function AlgebraicOddFrame(n::Integer, fs::Function ...;
                labels = [Symbol(i) for i in 1:length(fs)])
                columns = [AlgebraicArray(f, n) for f in fs]
                types = [typeof(col[1]) for col in columns]
                AlgebraicOddFrame(labels, columns), types
        end
end


include("member_func.jl")
