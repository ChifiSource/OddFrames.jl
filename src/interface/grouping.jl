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
function _typefs(ods::Vector{OddFrame},
         labels::Vector{Symbol})
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
