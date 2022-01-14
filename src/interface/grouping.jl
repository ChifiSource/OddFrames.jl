"""
- **Interface**
- Grouping
# FrameGroup(::AbstractVector{OddFrame}, ::AbstractVector{Symbol}, ::Function)
The Framegroup allows one to work seemlessly by essentially creating what is an
OddFrame of OddFrames with labels corresponding to the OddFrames below. It
functions a lot like a dictionary.
### Properties
- ods::AbstractVector{AbstractOddFrame} A vector of OddFrames which we want to
comprise this frame group.
- labels::AbstractVector{Symbol} Labels is a vector of labels that are used to
call, manipulate, and work with the OddFrames provided in this type.
- head::Function Binded call to **_head(::AbstractVector{OddFrame}, ::Int64,
::AbstractVector{Symbol}**
### Bindings
Bindings are functions that are held as properties of the struct.
#### FrameGroup.head(count::Int64)
The head function just does subsequent head() calls for each OddFrame in the
        group, providing headings with labels in between. This displays the
        OddFrames as HTML or text tables.
## Constructors
Here are the various constructors which return this type.
"""
mutable struct FrameGroup <: OddFrameContainer
        ods::AbstractVector{AbstractOddFrame}
        labels::AbstractVector{Symbol}
        head::Function
        """
        ### FrameGroup(ods::AbstractOddFrame ...; labels = Symbol(i) for i in 1:length(ods))
        This constructor returns the FrameGroup <: OddFrameContainer type from
        a number of OddFrames. Provide the OddFrames as ongoing parameters.
        """
        function FrameGroup(ods::AbstractOddFrame ...;
                 labels = [Symbol(i) for i in 1:length(ods)])
                 ods = [od for od in ods]
                 head = _typefs(ods, labels)
                new(ods, labels, head)
        end
end
function _typefs(ods::Vector{OddFrame},
         labels::AbstractVector{Symbol})
         # Non mutating
        # Head
        head(count::Int64 = 5) = _head(ods, count, labels)
        return(head)
end
function _head(ods::AbstractVector{OddFrame} , count::Int64,
         labels::AbstractVector{Symbol})
        text = "<div>"
        for (i, od) in enumerate(ods)
                text = string(text,"<h2>", labels[i], "</h2>")
                text = string(text, od.head(count, html = :return))
        end
        text = string(text, "</div>")
        display("text/html", text)
end
