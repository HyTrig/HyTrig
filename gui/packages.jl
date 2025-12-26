using Pkg

Pkg.activate(".")

Pkg.add("CxxWrap")
Pkg.compat("CxxWrap", "0.16")

dependencies = [
    "DataStructures",
    "DifferentialEquations",
    "Match",
    "QML"
]

Pkg.add(dependencies)
