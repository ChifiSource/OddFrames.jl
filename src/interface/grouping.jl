"""
- **Interface**
- Grouping
# FrameGroup(::AbstractVector{OddFrame}, ::AbstractVector{Symbol}, ::Function)
The Framegroup allows one to work seemlessly by essentially creating what is an
OddFrame of OddFrames with labels corresponding to the OddFrames below. It
functions a lot like a dictionary. If you want to create this type, you should
be looking at the constructors, listed below, not this documentation.
### Properties
- ods::AbstractVector{AbstractOddFrame} => A vector of OddFrames which we want to
comprise this frame group.
- labels::AbstractVector{Symbol} => Labels is a vector of labels that are used to
call, manipulate, and work with the OddFrames provided in this type.
- head::Function => Binded call to
### Bindings
#### FrameGroup.head(count::Int64 = 5) => _head
The head function just does subsequent head() calls for each OddFrame in the
        group, providing headings with labels in between. This displays the
        OddFrames as HTML or text tables.
##### example
```
fg = FrameGroup(oddframes)
fg.head(5)
fg.head()
```
- count::Int64 The number of columns to print, defaults to 5.
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
a number of OddFrames. Provide the OddFrames as ongoing parameters. Optionally,
the labels key-word argument
- **posarg[1]** ods::AbstractOddFrame ... => An infinite list of AbstractOddFrames.
- **kwarg** labels::Array{Symbol} = [Symbol(i) for i in 1:length(ods)] => A list
 of names which we should index our OddFrames by.
##### return
- **[1]** ::FrameGroup => Structure of ods that can be indexed using labels.
##### example
```
labels = [:od1, :od2]
fg = FrameGroup(OddFrame(:y => [5, 8, 2]), OddFrame(:x => [5, 15]),
 labels = labels)
```
```
        """
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
### _typefs(ods::Vector{OddFrame}, labels::AbstractVector{Symbol})
This method returns the binded functions for the FrameGroup type.
        This function is just a supporting function for constructors.
the labels key-word argument
- **posarg[1]** ods::Vector{OddFrame} => Vector of OddFrames.
- **posarg[2]** labels::Vector{Symbol} => Vector of labels corresponding to the
OddFrames.
##### return
- **[1]** ::Function => Binded head function call.
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
- **posarg[1]** ods::Vector{OddFrame} => Vector of OddFrames.
- **posarg[2]** labels::Vector{Symbol} => Vector of labels corresponding to the
OddFrames.
##### return
- **[1]** ::Function => Binded head function call.
##### example
```
ods = [OddFrame]
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
