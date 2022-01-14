module doc

using Documenter
using OddFrames
Documenter.makedocs(root = "./",
       source = "src",
       build = "build",
       clean = true,
       doctest = true,
       modules = Module[OddFrames],
       repo = "https://github.com/ChifiSource/OddFrames.jl",
       highlightsig = true,
       sitename = "OddFrames.jl",
       expandfirst = [],
       pages = [
               "OddFrames.jl" => "README.md",
               "Getting Started" => "GettingStarted.md",
               "Getting Experienced" => "GettingExperienced.md",
               "Framework Reference" => "APIReference.md",
               "Extending OddFrames" => "ExtendingOddFrames.md",
               "CONTRIBUTING" => "CONTRIBUTING.md",
               "Developer API" => "DeveloperAPI.md",
               "CHANGELOG" => "CHANGELOG.md"
               ]
       )

end
