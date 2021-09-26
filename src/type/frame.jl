include("css.jl")
include("formats.jl")
include("index_iter.jl")
using Lathe.stats: mean
using Dates

#Binding(od::AbstractOddFrame, s::Symbol) = eval(df.)
#=============
OddFrame Type
=============#

mutable struct OddFrame <: AbstractOddFrame
        labels::Array{Symbol}
        columns::Array{Any}
        coldata::Array{Pair}
        head::Function
        drop::Function
        dropna::Function
        dtype::Function
        #==
        Constructors
        ==#
        function OddFrame(p::Pair ...)
                # Labels/Columns
                labels = [pair[1] for pair in p]
                columns = [pair[2] for pair in p]
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                # coldata
                coldata = generate_coldata(columns, types)
                # Head
                head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata, 5)
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
                """dox"""
                head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata, 5)
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
                labels = [pair[1] for pair in p]
                columns = [pair[2] for pair in p]
                length_check(columns)
                name_check(labels)
                types = [typeof(x[1]) for x in columns]
                # coldata
                coldata = generate_coldata(columns, types)
                # Head
                head(x::Int64) = _head(labels, columns, coldata, x)
                head() = _head(labels, columns, coldata, 5)
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
        function OddFrame(d::Dict)
                return(OddFrame([p => v for (p, v) in d]))
        end
        #==
        Supporting
                Functions
        ( Support constructors )
        ==#
        function generate_coldata(columns::Array, types::Array)
                pairs = []
                for (i, T) in enumerate(types)
                        if T == String
                                push!(pairs, T => string("Data-type: ",
                                T, "\nFeature Type: Categorical\n",
                                "Categories: ", length(Set(columns[i]))))
                        elseif T == Bool
                                push!(pairs, T => string("Data-type: ",
                                T, "\nFeature Type: Categorical\n",
                                "Categories: ", length(Set(columns[i]))))
                        elseif length(columns[i]) / length(Set(columns[i])) <= 1.8
                                push!(pairs, T => string("Data-type: ",
                                T, "\nFeature Type: Continuous\n", "Mean: ",
                                mean(columns[i])))
                        else
                                push!(pairs, T => string("Data-type: ",
                                T, "\nFeature Type: Categorical\n",
                                "Categories: ", length(Set(columns[i]))))
                        end
                end
                pairs
        end

        #==
        THROWS
        ==#
        function length_check(ps)
                ourlen = length(ps[1])
                [if length(x) != ourlen throw(DimensionMismatch("Columns must be the same size")) end for x in ps]
        end

        function name_check(labels)
                if length(Set(labels)) != length(labels)
                throw(ErrorException("Column names may not be duplicated!"))
                end
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
                head() = _head(labels, columns, coldata, 5)
        new(labels, columns, coldata, head, dtype)
    end

end
