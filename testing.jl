using Pkg

Pkg.activate(".")
Pkg.instantiate()

using Dates

include("src/hytrig.jl")
using .HyTrig


println(constraint_to_string(And(Greater(Const(5), Var(:x)), LeQ(Var(:y), Const(6)))))