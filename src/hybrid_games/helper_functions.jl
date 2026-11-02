"""
    helper_functions.jl

Helper utilities for working with valuations, expressions and constraints.

Besides the rounding / valuation-conversion helpers this file provides a small
"compiler" that turns the (fixed) expression and constraint trees of a game into
plain Julia closures. The compiled closures evaluate a value or a truth value
*without* re-walking the tree (no `@match` dispatch), *without* dictionary
lookups, and operate directly on a `Vector{Float64}` of current values whose
order matches the iteration order of the `Valuation` they were compiled against.

There is also a second, "partial" family of compilers (`compile_partial_*`) whose
closures take two vectors: a vector with the full valuation (in valuation order,
used for variables whose value is taken as given) and a second vector that holds
only the values of a designated subset of variables, in that subset's own order.
This is what the flow ODE uses (the subset being the flow variables and the
second vector being the solver's `u`), but it is not specific to flows.

# Functions:
- `round4(num::Float64, digits=4)::Float64`: Round a number to `digits` decimals.
- `valuation_to_string(valuation::Valuation, digits=5)::String`: Pretty-print a valuation.
- `valuation_from_vector(valuation::Valuation, vector::Vector{Float64})::Valuation`: Rebuild a valuation from a value vector in valuation order.
- `valuation_from_flow_vector(flow::Assignment, valuation::Valuation, vector::Vector{Float64})::Valuation`: Overlay flow-variable values onto a valuation.
- `variable_indices(valuation::Valuation)::Dict{Variable, Int}`: Map each variable to its valuation-order index.
- `partial_variable_indices(partial::Assignment)::Dict{Variable, Int}`: Map each variable of `partial` to its order index in `partial`.
- `compile_expression(expr, var_index)::Function`: Compile an expression to `vals -> Float64`.
- `compile_constraint(constr, var_index)::Function`: Compile a constraint to `vals -> Bool`.
- `compile_expressions(exprs, var_index)::Vector{FullFn}`: Compile a collection of expressions for fast repeated evaluation.
- `compile_partial_expression(expr, full_index, partial_index)::Function`: Compile to `(full, partial) -> Float64`.
- `compile_partial_constraint(constr, full_index, partial_index)::Function`: Compile to `(full, partial) -> Bool`.
- `compile_partial_expressions(exprs, full_index, partial_index)::Vector{PartialFn}`: Compile a collection for fast repeated evaluation.

# Authors:
- Author 1
- Author 2
"""

export round4, valuation_from_vector, valuation_to_vector, valuation_from_flow_vector, valuation_to_string
export variable_indices, partial_variable_indices
export compile_expression, compile_constraint, compile_partial_expression, compile_partial_constraint
export compile_expressions, compile_partial_expressions, FullFn, PartialFn

# TODO: add function documentation
function round4(num::Float64, digits=4)::Float64
    return round(num, digits=digits)
end

function round4(valuation::Valuation, digits=4)::Valuation
    new_valuation::OrderedDict{Symbol, Float64} = OrderedDict()
    for (var, value) in valuation
        new_valuation[var] = round4(value, digits)
    end
    return new_valuation
end

function valuation_to_string(valuation::Valuation, digits = 5)
    str = "{"
    for (var, val) in valuation
        str *= "$var = $(round4(val, digits))   "
    end
    str * "}"
end


function valuation_from_vector(valuation::Valuation, vector::Vector{Float64})::Valuation
    new_valuation::OrderedDict{Symbol, Float64} = OrderedDict()
    for (i, (var, _)) in enumerate(valuation)
        new_valuation[var] = vector[i]
    end
    return new_valuation
end

"""
    valuation_to_vector(valuation::Valuation)::Vector{Float64}

Extract the values of `valuation` into a plain vector in valuation order. This
is the inverse of [`valuation_from_vector`](@ref) and produces exactly the
layout expected by the closures returned by [`compile_expression`](@ref) and the
`full` argument of the `compile_partial_*` closures.
"""
function valuation_to_vector(valuation::Valuation)::Vector{Float64}
    return Float64[value for (_, value) in valuation]
end

function valuation_from_flow_vector(flow:: Assignment, valuation::Valuation, vector::Vector{Float64})::Valuation
    new_valuation::OrderedDict{Symbol, Float64} = OrderedDict()
    i = 1
    for (var, value) in valuation
        if !(var in keys(flow))
            new_valuation[var] = value
        else
            new_valuation[var] = vector[i]
            i += 1
        end
    end
    return new_valuation
end

# ---------------------------------------------------------------------------
# Precompilation of expressions and constraints
#
# `compile_expression` / `compile_constraint` turn a (fixed) expression /
# constraint tree into a Julia closure. The tree is walked exactly once, at
# compile time; the resulting closure captures only plain integers (the
# precomputed index of each variable) and the closures of its sub-expressions.
# Evaluating the closure therefore performs no `@match` dispatch and no
# dictionary lookups -- it only reads from a `Vector{Float64}` of current
# values that is laid out in the same order as the `Valuation`.
#
# The internal `_compile_expr` / `_compile_constraint` are agnostic about how a
# variable obtains its value: every compiled closure takes two arguments `(a, b)`
# which the combinators (`Add`, `Mul`, ...) pass straight through, while the
# leaves built by `varleaf` decide which of the two to read from. This lets one
# set of combinators serve both forms with no per-call allocation:
#   * full (single-vector) form -- `a` is the value vector, `b` is unused;
#   * partial (two-vector) form -- `a` is the full valuation, `b` is the vector
#     of the designated subset of variables (e.g. a flow's `u`).
# Passing two plain arguments (rather than a tuple) is what keeps the hot loop
# allocation-free: a tuple `(a, b)` would escape into the closure chain and be
# heap-allocated on every evaluation.
# ---------------------------------------------------------------------------

"""
    variable_indices(valuation::Valuation)::Dict{Variable, Int}

Map every variable to its position in `valuation`'s iteration order. The
returned mapping is meant to be built once and reused to compile many
expressions / constraints; it is never consulted while a compiled closure runs.
"""
function variable_indices(valuation::Valuation)::Dict{Variable, Int}
    index = Dict{Variable, Int}()
    for (i, var) in enumerate(keys(valuation))
        index[var] = i
    end
    return index
end

"""
    partial_variable_indices(partial::Assignment)::Dict{Variable, Int}

Map every variable occurring in `partial` to its position in `partial`'s own
iteration order. For a flow this matches the layout of the `u` vector handed to
the ODE solver (`u[i]` is the value of the `i`-th variable of the flow).
"""
function partial_variable_indices(partial::Assignment)::Dict{Variable, Int}
    index = Dict{Variable, Int}()
    for (i, var) in enumerate(keys(partial))
        index[var] = i
    end
    return index
end

# Leaf builder for the full (single-vector) form: a variable reads `a[i]` (the
# second argument is unused) where `i` is the variable's valuation-order index.
_full_leaf(var_index::AbstractDict{Variable, <:Integer}) =
    name -> let i = var_index[name]
        (a, b) -> @inbounds a[i]
    end

# Leaf builder for the partial (two-vector) form: variables of the designated
# subset are read from `b` at their subset-order index, all other variables from
# the full valuation `a` at their valuation-order index.
function _partial_leaf(full_index::AbstractDict{Variable, <:Integer},
                       partial_index::AbstractDict{Variable, <:Integer})
    return name -> if haskey(partial_index, name)
            let i = partial_index[name]
                (a, b) -> @inbounds b[i]
            end
        else
            let i = full_index[name]
                (a, b) -> @inbounds a[i]
            end
        end
end

# Walk an expression tree once and return a closure `(a, b) -> Float64`.
# `varleaf` maps a variable name to the leaf closure that fetches its value.
function _compile_expr(expr::ExprLike, varleaf)::Function
    @match expr begin
        Const(value)        => let v = Float64(value);                                                    (a, b) -> v end
        Var(name)           => varleaf(name)
        Neg(inner)          => let f = _compile_expr(inner, varleaf);                                      (a, b) -> -f(a, b) end
        Add(left, right)    => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);   (a, b) -> l(a, b) + r(a, b) end
        Mul(left, right)    => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);   (a, b) -> l(a, b) * r(a, b) end
        Sub(left, right)    => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);   (a, b) -> l(a, b) - r(a, b) end
        Div(left, right)    => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);   (a, b) -> l(a, b) / r(a, b) end
        Expon(base, power)  => let bs = _compile_expr(base, varleaf), p = _compile_expr(power, varleaf);  (a, b) -> bs(a, b) ^ p(a, b) end
        Modulo(left, right) => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);   (a, b) -> l(a, b) % r(a, b) end
        Abs(base)           => let g = _compile_expr(base, varleaf);                                      (a, b) -> abs(g(a, b)) end
        Sin(base)           => let g = _compile_expr(base, varleaf);                                      (a, b) -> sin(g(a, b)) end
        CoSin(base)         => let g = _compile_expr(base, varleaf);                                      (a, b) -> cos(g(a, b)) end
        Tan(base)           => let g = _compile_expr(base, varleaf);                                      (a, b) -> tan(g(a, b)) end
        CoTan(base)         => let g = _compile_expr(base, varleaf);                                      (a, b) -> cot(g(a, b)) end
        Min(left, right)    => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);   (a, b) -> min(l(a, b), r(a, b)) end
        Max(left, right)    => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);   (a, b) -> max(l(a, b), r(a, b)) end
    end
end

# Walk a constraint tree once and return a closure `(a, b) -> Bool`. The atomic
# comparisons mirror `evaluate(::Constraint, ::Valuation)` exactly, including the
# `round4` applied to both sides before comparing.
function _compile_constraint(constr::Constraint, varleaf)::Function
    @match constr begin
        Truth(value)          => let v = value;                                                                       (a, b) -> v end
        Less(left, right)     => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);             (a, b) -> round4(l(a, b)) <  round4(r(a, b)) end
        LeQ(left, right)      => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);             (a, b) -> round4(l(a, b)) <= round4(r(a, b)) end
        Greater(left, right)  => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);             (a, b) -> round4(l(a, b)) >  round4(r(a, b)) end
        GeQ(left, right)      => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);             (a, b) -> round4(l(a, b)) >= round4(r(a, b)) end
        Equal(left, right)    => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);             (a, b) -> round4(l(a, b)) == round4(r(a, b)) end
        NotEqual(left, right) => let l = _compile_expr(left, varleaf), r = _compile_expr(right, varleaf);             (a, b) -> round4(l(a, b)) != round4(r(a, b)) end
        And(left, right)      => let l = _compile_constraint(left, varleaf), r = _compile_constraint(right, varleaf); (a, b) -> l(a, b) && r(a, b) end
        Or(left, right)       => let l = _compile_constraint(left, varleaf), r = _compile_constraint(right, varleaf); (a, b) -> l(a, b) || r(a, b) end
        Not(c)                => let f = _compile_constraint(c, varleaf);                                             (a, b) -> !f(a, b) end
        Imply(left, right)    => let l = _compile_constraint(left, varleaf), r = _compile_constraint(right, varleaf); (a, b) -> !l(a, b) || r(a, b) end
    end
end

"""
    compile_expression(expr::ExprLike, var_index::AbstractDict{Variable, <:Integer})::Function
    compile_expression(expr::ExprLike, valuation::Valuation)::Function

Compile `expr` into a closure `vals::Vector{Float64} -> Float64`. `vals` must
hold the current value of every variable in the order described by `var_index`
(or, equivalently, by `valuation`). When passing a `valuation` the index map is
built on the fly; pass a precomputed `var_index` from [`variable_indices`](@ref)
when compiling many expressions against the same valuation.
"""
# Bridge a two-argument internal closure `g` to the public full (single-vector)
# form. A function barrier (specialised on `typeof(g)`) so the returned closure
# captures `g` concretely; the unused second argument simply mirrors `vals`.
_make_full_wrapper(g) = vals::Vector{Float64} -> g(vals, vals)

compile_expression(expr::ExprLike, var_index::AbstractDict{Variable, <:Integer})::Function =
    _make_full_wrapper(_compile_expr(expr, _full_leaf(var_index)))

compile_expression(expr::ExprLike, valuation::Valuation)::Function =
    compile_expression(expr, variable_indices(valuation))

"""
    compile_constraint(constr::Constraint, var_index::AbstractDict{Variable, <:Integer})::Function
    compile_constraint(constr::Constraint, valuation::Valuation)::Function

Compile `constr` into a closure `vals::Vector{Float64} -> Bool`. The value
vector follows the same contract as in [`compile_expression`](@ref). The result
agrees with `evaluate(constr, valuation)` (the same `round4` is applied to both
sides of every atomic comparison).
"""
compile_constraint(constr::Constraint, var_index::AbstractDict{Variable, <:Integer})::Function =
    _make_full_wrapper(_compile_constraint(constr, _full_leaf(var_index)))

compile_constraint(constr::Constraint, valuation::Valuation)::Function =
    compile_constraint(constr, variable_indices(valuation))

"""
    FullFn

Concrete type of a compiled full (single-vector) closure once wrapped for
storage: a `FunctionWrapper` with signature `vals::Vector{Float64} -> Float64`.
Wrapping erases each closure's per-expression type behind one common concrete
type, so a heterogeneous collection can live in a plain `Vector{FullFn}` and be
applied in a loop with no dynamic dispatch, no boxing and no length limit (`map`
over a tuple, by contrast, falls back to a slow allocating path beyond 32
elements).
"""
const FullFn = FunctionWrapper{Float64, Tuple{Vector{Float64}}}

"""
    compile_expressions(exprs, var_index)::Vector{FullFn}
    compile_expressions(exprs, valuation::Valuation)::Vector{FullFn}

Compile a collection of expressions into a `Vector{FullFn}` of full
(single-vector) closures (see [`compile_expression`](@ref) and [`FullFn`](@ref)).
Iterate the result and call each entry as `fns[i](vals)` (type-stable,
allocation-free), where `vals` holds every variable in valuation order. The
construction is meant to run once.
"""
function compile_expressions(exprs, var_index::AbstractDict{Variable, <:Integer})::Vector{FullFn}
    return FullFn[FullFn(compile_expression(e, var_index)) for e in exprs]
end

compile_expressions(exprs, valuation::Valuation)::Vector{FullFn} =
    compile_expressions(exprs, variable_indices(valuation))

"""
    compile_partial_expression(expr, full_index, partial_index)::Function
    compile_partial_expression(expr::ExprLike, valuation::Valuation, partial::Assignment)::Function

Compile `expr` into a closure `(full, partial)::Vector{Float64} -> Float64`.
Variables in the designated subset (`partial_index`) are read from the second
vector `partial` (in subset order); every other variable is read from `full` (the
full valuation, in valuation order). The flow ODE uses this with the subset being
the flow variables and `partial` being the solver's `u`.
"""
function compile_partial_expression(expr::ExprLike,
                                    full_index::AbstractDict{Variable, <:Integer},
                                    partial_index::AbstractDict{Variable, <:Integer})::Function
    return _compile_expr(expr, _partial_leaf(full_index, partial_index))
end

compile_partial_expression(expr::ExprLike, valuation::Valuation, partial::Assignment)::Function =
    compile_partial_expression(expr, variable_indices(valuation), partial_variable_indices(partial))

"""
    PartialFn

Concrete type of a compiled partial (two-vector) closure once wrapped for
storage: a `FunctionWrapper` with signature `(full, partial)::Vector{Float64} -> Float64`.
Wrapping erases each closure's per-expression type behind one common concrete
type, so a heterogeneous collection can live in a plain `Vector{PartialFn}` and be
applied in a loop with no dynamic dispatch, no boxing and no length limit (`map`
over a tuple, by contrast, falls back to a slow allocating path beyond 32
elements).
"""
const PartialFn = FunctionWrapper{Float64, Tuple{Vector{Float64}, Vector{Float64}}}

"""
    compile_partial_expressions(exprs, full_index, partial_index)::Vector{PartialFn}
    compile_partial_expressions(exprs, valuation::Valuation, partial::Assignment)::Vector{PartialFn}

Compile a collection of expressions into a `Vector{PartialFn}` of two-vector
closures (see [`compile_partial_expression`](@ref) and [`PartialFn`](@ref)).
Iterate the result and call each entry as `fns[i](full, partial)` (type-stable,
allocation-free). The flow ODE passes `values(flow)` (one closure per flow
variable, in flow order, matching the solver's `u`). The construction is meant to
run once, before solving.
"""
function compile_partial_expressions(exprs,
                                     full_index::AbstractDict{Variable, <:Integer},
                                     partial_index::AbstractDict{Variable, <:Integer})::Vector{PartialFn}
    return PartialFn[PartialFn(compile_partial_expression(e, full_index, partial_index)) for e in exprs]
end

compile_partial_expressions(exprs, valuation::Valuation, partial::Assignment)::Vector{PartialFn} =
    compile_partial_expressions(exprs, variable_indices(valuation), partial_variable_indices(partial))


"""
    compile_partial_constraint(constr, full_index, partial_index)::Function
    compile_partial_constraint(constr::Constraint, valuation::Valuation, partial::Assignment)::Function

Compile `constr` into a closure `(full, partial)::Vector{Float64} -> Bool` using
the same two-vector convention as [`compile_partial_expression`](@ref).
"""
function compile_partial_constraint(constr::Constraint,
                                    full_index::AbstractDict{Variable, <:Integer},
                                    partial_index::AbstractDict{Variable, <:Integer})::Function
    return _compile_constraint(constr, _partial_leaf(full_index, partial_index))
end

compile_partial_constraint(constr::Constraint, valuation::Valuation, partial::Assignment)::Function =
    compile_partial_constraint(constr, variable_indices(valuation), partial_variable_indices(partial))
