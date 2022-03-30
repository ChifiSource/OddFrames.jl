module doc

using OddFrames
using Documenter

Documenter.makedocs(root = "../",
       source = "src",
       build = "build",
       clean = true,
       doctest = true,
       modules = [OddFrames],
       repo = "https://github.com/ChifiSource/OddFrames.jl",
       highlightsig = true,
       sitename = "OddFrames.jl",
       expandfirst = [],
       pages = [
                "Overview" => "README.md",
                "OddFrames" => "OddFrame.md",
                "Functions" => "Functions.md",
                "FrameGroups" => "FrameGroups.md",
                "Methods" => "Methods.md",
                "Internal API" => "Internals.md",
                "Extending OddFrames" => "ExtendingOddFrames.md",
                "Contributing" => "CONTRIBUTING.md",
                "Changelog" => "CHANGELOG.md"
               ]
       )


end
