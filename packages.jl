using Pkg

compat = Pkg.Types.read_project("Project.toml").compat

Pkg.activate(".")

if !haskey(compat, "CxxWrap")
    Pkg.add("CxxWrap")
    Pkg.compat("CxxWrap", "0.16")
end

dependencies = [
    "DifferentialEquations",
    "IterTools",
    "Match",
    "JSON3",
    "DataStructures",
    "Plots",
    "QML"
]

Pkg.add(dependencies)
