using Test
include("../src/OddFrames.jl")
OD_LOAD = false
@testset "Loading Test" begin
try
    using OddFrames
    OD_LOAD = true
catch
    OD_LOAD = false
@test OD_LOAD == true

end

end
include("tests_type.jl")
include("tests_interface.jl")
