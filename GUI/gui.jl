include("../packages.jl")

using QML

include("../parsers/parser.jl")

function is_valid_expression(expr, vars)
    expr = String(expr)
    variables = Vector{String}()
    for i in eachindex(vars)
        push!(variables, vars[i])
    end
    try
        parse(expr, Bindings(Set(), Set(), Set(variables)), expression)
        return true
    catch
        return false
    end
end

function is_valid_constraint(constr, vars)
    constr = String(constr)
    variables = Vector{String}()
    for i in eachindex(vars)
        push!(variables, vars[i])
    end
    try
        parse(constr, Bindings(Set(), Set(), Set(variables)), constraint)
        return true
    catch
        return false
    end
end

function is_valid_state(state_formula, vars, locs)
    state_formula = String(state_formula)
    variables = Vector{String}()
    for i in eachindex(vars)
        push!(variables, vars[i])
    end
    locations = Vector{String}()
    for i in eachindex(locs)
        push!(locations, locs[i])
    end
    try
        parse(state_formula, Bindings(Set(), Set(locations), Set(variables)), state)
        return true
    catch
        return false
    end
end

function is_valid_strategy(strategy_formula, vars, locs, agns)
    strategy_formula = String(strategy_formula)
    print(str)
    variables = Vector{String}()
    for i in eachindex(vars)
        push!(variables, vars[i])
    end
    locations = Vector{String}()
    for i in eachindex(locs)
        push!(locations, locs[i])
    end
    agents = Vector{String}()
    for i in eachindex(agns)
        push!(agents, agns[i])
    end 
    try
        parse(strategy_formula, Bindings(Set(agents), Set(locations), Set(variables)), strategy)
        return true
    catch
        return false
    end
end

@qmlfunction is_valid_expression is_valid_constraint is_valid_state is_valid_strategy

qml_file = joinpath(dirname(@__FILE__), "qml", "gui.qml")

loadqml(qml_file, guiproperties = JuliaPropertyMap())

exec()
