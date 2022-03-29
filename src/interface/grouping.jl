"""
- **Interface**
- Grouping
# FrameGroup(::AbstractVector{OddFrame}, ::AbstractVector{Symbol}, ::Function)
- FrameGroup(ods::AbstractOddFrame; labels::Vector{Symbol})
The Framegroup allows one to work with multiple OddFrames at once in similar
 contexts.
### Fields
- **ods**::AbstractVector{AbstractOddFrame} => A vector of OddFrames which we want to
comprise this frame group.
- **labels**::AbstractVector{Symbol} => Labels is a vector of labels that are used to
call, manipulate, and work with the OddFrames provided in this type.
- **head**::Function => Binded call to _head
### Bindings
#### FrameGroup.head(count::Int64 = 5) -> ::Nothing
The head function just does subsequent head() calls for each OddFrame in the
        group, providing headings with labels in between. This displays the
        OddFrames as HTML or text tables.
##### example
```
fg = FrameGroup(oddframes)
fg.head(5)
fg.head()
```

"""
mutable struct FrameGroup <: OddFrameContainer
        ods::AbstractVector{AbstractOddFrame}
        labels::AbstractVector{Symbol}
        head::Function
        function FrameGroup(ods::AbstractOddFrame ...;
                 labels = [Symbol(i) for i in 1:length(ods)])
                 ods = [od for od in ods]
                 head = _typefs(ods, labels)
                new(ods, labels, head)
        end
end

"""
- **Developer API**
- Grouping
### _typefs(ods::Vector{OddFrame}, labels::AbstractVector{Symbol}) -> ::Function
This method returns the binded functions for the FrameGroup type.
        As of right now, this is only _head().
##### example
```
labels = [Symbol(i) for i in 1:length(ods)])
ods = [od for od in ods]
head = _typefs(ods, labels)
```
"""
function _typefs(ods::Vector{OddFrame},
         labels::AbstractVector{Symbol})
         # Non mutating
        # Head
        head(count::Int64 = 5) = _head(ods, count, labels)
        return(head)
end
"""
- **Developer API**
- Grouping
### _head(ods::Vector{OddFrame}, count::Int64, labels::AbstractVector{Symbol})
Serves as a binded call for the function head() in the FrameGroup type. This
        function is not meant to be called directly, instead use FrameGroup.head
Documentation for this is available inside of ?(FrameGroup).
##### example
```
_head(ods, count, labels)
```
"""
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
