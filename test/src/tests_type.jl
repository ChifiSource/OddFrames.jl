@testset "Frame Tests" begin
    @testset "OddFrames" begin
        @testset "Constructors" begin
            @testset "Pairs" begin
                od = OddFrame(:A => [5, 10], :B => [2, 3])
                @test od[:A] == [5, 10]
                @test od[:B] == [2, 3]
                @test typeof(od[:A]) == Int64
                @test typeof(od[:B]) == Int64
            end
            @testset "Array{Pair}" begin
                od = OddFrame([:A => [5, 10], :B => [5, 10]])
                @test od[:A] == [5, 10]
                @test od[:B] == [2, 3]
                @test typeof(od[:A]) == Int64
                @test typeof(od[:B]) == Int64
            end
            @testset "String (URI)" begin
                od = OddFrame("data/testdata.csv")
            end
        end
        @testset "Member Functions" begin

        end
        @testset "Casting" begin

        end
    end
    @testset "ImmutableOddframes" begin

    end
