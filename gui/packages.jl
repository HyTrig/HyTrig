using Pkg

compat = Pkg.Types.read_project("Project.toml").compat

Pkg.activate(".")

if !haskey(compat, "CxxWrap")
    Pkg.add("CxxWrap")
    Pkg.compat("CxxWrap", "0.16")
end

dependencies = [
    "DataStructures",
    "DifferentialEquations",
    "JSON3",
    "Match",
    "QML"
]

Pkg.add(dependencies)
