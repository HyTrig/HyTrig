#!/usr/bin/env python3
"""Generate HGT volleyball game JSON variations.

The generated games follow the structure of `volleyball.json`:
two teams of N players play on a `field_length x field_width` field,
each team has T target points on the opposite court, and players have
K hit-radius triggers.

The state machine has four locations per game:
    Team_1_Preparing  (initial)
    Team_1_Throwing
    Team_2_Preparing
    Team_2_Throwing

The full set of variables is generated automatically, including
target points (p<i>_<team>_x/y), per-player speeds (spd_<name>),
positions (<name>_x/y), and movement directions (dir_<name>_x/y).

Usage (programmatic):

    from generate_volleyball import generate_game, save_game

    game = generate_game(
        num_players_per_team=2,
        target_points_per_team=3,
        trigger_radii=[1, 0.5, 0.25],
    )
    save_game(game, "my_volleyball.json")

Usage (CLI):

    python generate_volleyball.py \\
        --players-per-team 2 \\
        --target-points 3 \\
        --triggers 1 0.5 0.25 \\
        --out my_volleyball.json
"""

from __future__ import annotations

import argparse
import json
import string
from pathlib import Path
from typing import Iterable, Sequence


# ---------------------------------------------------------------------------
# helpers
# ---------------------------------------------------------------------------

def _player_names(num_players_per_team: int) -> tuple[list[str], list[str]]:
    """Return (team1_names, team2_names)."""
    team1_names = [f"T1_A{i + 1}" for i in range(num_players_per_team)]
    team2_names = [f"T2_A{i + 1}" for i in range(num_players_per_team)]
    return team1_names, team2_names


def _default_target_points(
    num_points: int, x_lo: float, x_hi: float, y_lo: float, y_hi: float
) -> list[tuple[float, float]]:
    """Spread `num_points` evenly across the rectangle [x_lo, x_hi] x [y_lo, y_hi]."""
    if num_points <= 0:
        return []
    if num_points == 1:
        return [((x_lo + x_hi) / 2, (y_lo + y_hi) / 2)]
    pts: list[tuple[float, float]] = []
    margin_x = (x_hi - x_lo) * 0.15
    margin_y = (y_hi - y_lo) * 0.15
    xs = _linspace(x_lo + margin_x, x_hi - margin_x, num_points)
    ys = _linspace(y_lo + margin_y, y_hi - margin_y, num_points)
    for i in range(num_points):
        pts.append((xs[i], ys[(i + num_points // 2) % num_points]))
    return pts


def _default_player_positions(
    names_team: Sequence[str], x_lo: float, x_hi: float, y_lo: float, y_hi: float
) -> list[tuple[float, float]]:
    """Spread players evenly along y, in the middle of their court."""
    n = len(names_team)
    if n == 0:
        return []
    x_mid = (x_lo + x_hi) / 2
    if n == 1:
        return [(x_mid, (y_lo + y_hi) / 2)]
    margin = (y_hi - y_lo) * 0.2
    ys = _linspace(y_lo + margin, y_hi - margin, n)
    return [(x_mid, y) for y in ys]


def _linspace(a: float, b: float, n: int) -> list[float]:
    if n == 1:
        return [(a + b) / 2]
    step = (b - a) / (n - 1)
    return [a + i * step for i in range(n)]


def _fmt(value: float) -> str:
    """Format a number cleanly: integers as '3', floats without trailing zeros."""
    if isinstance(value, bool):
        return str(int(value))
    f = float(value)
    if f.is_integer():
        return str(int(f))
    return ("%g" % f)


# ---------------------------------------------------------------------------
# variable layout
# ---------------------------------------------------------------------------

def _ordered_var_names(
    all_player_names: Sequence[str], num_targets: int
) -> list[str]:
    """Canonical variable order used in the volleyball JSON files."""
    names: list[str] = ["max_height", "g"]
    for i in range(num_targets):
        names += [f"p{i + 1}_1_x", f"p{i + 1}_1_y"]
    for i in range(num_targets):
        names += [f"p{i + 1}_2_x", f"p{i + 1}_2_y"]
    for n in all_player_names:
        names.append(f"spd_{n}")
    names += ["hitter", "target_x", "target_y",
              "spd_z", "flight_time", "spd_x", "spd_y"]
    for n in all_player_names:
        names += [f"{n}_x", f"{n}_y"]
    for n in all_player_names:
        names += [f"dir_{n}_x", f"dir_{n}_y"]
    names += ["x", "y", "z"]
    return names


def _identity_jump(var_names: Sequence[str]) -> list[dict]:
    return [{"expression": v, "variable": v} for v in var_names]


def _zero_flow(var_names: Sequence[str]) -> list[dict]:
    return [{"expression": "0", "variable": v} for v in var_names]


def _set(items: list[dict], variable: str, expression: str) -> None:
    """Mutate the entry for `variable` inside `items` to use `expression`."""
    for entry in items:
        if entry["variable"] == variable:
            entry["expression"] = expression
            return
    raise KeyError(f"variable {variable!r} not found in jump/flow list")


# ---------------------------------------------------------------------------
# component builders
# ---------------------------------------------------------------------------

def _build_variables(
    *,
    all_player_names: Sequence[str],
    num_targets: int,
    max_height: float,
    gravity: float,
    targets_team1: Sequence[tuple[float, float]],
    targets_team2: Sequence[tuple[float, float]],
    player_speeds: Sequence[float],
    initial_positions: Sequence[tuple[float, float]],
    initial_ball_position: tuple[float, float, float],
) -> list[dict]:
    out: list[dict] = []
    out.append({"name": "max_height", "expression": _fmt(max_height)})
    out.append({"name": "g", "expression": _fmt(gravity)})
    for i, (px, py) in enumerate(targets_team1):
        out.append({"name": f"p{i + 1}_1_x", "expression": _fmt(px)})
        out.append({"name": f"p{i + 1}_1_y", "expression": _fmt(py)})
    for i, (px, py) in enumerate(targets_team2):
        out.append({"name": f"p{i + 1}_2_x", "expression": _fmt(px)})
        out.append({"name": f"p{i + 1}_2_y", "expression": _fmt(py)})
    for n, spd in zip(all_player_names, player_speeds):
        out.append({"name": f"spd_{n}", "expression": _fmt(spd)})
    out.append({"name": "hitter", "expression": "1"})
    out.append({"name": "target_x", "expression": "0"})
    out.append({"name": "target_y", "expression": "0"})
    out.append({"name": "spd_z", "expression": "0"})
    out.append({"name": "flight_time", "expression": "0"})
    out.append({"name": "spd_x", "expression": "0"})
    out.append({"name": "spd_y", "expression": "0"})
    for n, (px, py) in zip(all_player_names, initial_positions):
        out.append({"name": f"{n}_x", "expression": _fmt(px)})
        out.append({"name": f"{n}_y", "expression": _fmt(py)})
    for n in all_player_names:
        out.append({"name": f"dir_{n}_x", "expression": "0"})
        out.append({"name": f"dir_{n}_y", "expression": "0"})
    bx, by, bz = initial_ball_position
    out.append({"name": "x", "expression": _fmt(bx)})
    out.append({"name": "y", "expression": _fmt(by)})
    out.append({"name": "z", "expression": _fmt(bz)})
    return out


def _build_triggers(
    *,
    team1_names: Sequence[str],
    team2_names: Sequence[str],
    trigger_radii: Sequence[float],
    num_targets: int,
    field_length: float,
) -> list[dict]:
    nt1 = len(team1_names)
    half = field_length / 2
    triggers: list[dict] = []

    for team_idx, names in enumerate((team1_names, team2_names), start=1):
        own_targets_team = team_idx
        if team_idx == 1:
            hitter_cond = f"hitter >= {nt1 + 1}"
        else:
            hitter_cond = f"hitter <= {nt1}"

        for name in names:
            for r in trigger_radii:
                triggers.append({
                    "agent": name,
                    "trigger": (
                        f"(x - {name}_x)^2 + (y - {name}_y)^2 <= {_fmt(r)}"
                    ),
                })
            triggers.append({
                "agent": name,
                "trigger": f"{hitter_cond} && x == {_fmt(half)}",
            })
            target_terms = [
                (
                    f"(p{i + 1}_{own_targets_team}_x - {name}_x)^2 + "
                    f"(p{i + 1}_{own_targets_team}_y - {name}_y)^2 <= 0.1"
                )
                for i in range(num_targets)
            ]
            triggers.append({
                "agent": name,
                "trigger": " || ".join(target_terms),
            })
    return triggers


def _build_locations(
    *,
    var_names: Sequence[str],
    team1_names: Sequence[str],
    team2_names: Sequence[str],
    field_length: float,
    field_width: float,
) -> list[dict]:
    nt1 = len(team1_names)
    field_invariant = (
        f"0 <= z && z <= max_height && "
        f"0 <= x && x <= {_fmt(field_length)} && "
        f"0 <= y && y <= {_fmt(field_width)}"
    )

    def make_flow(moving_names: Sequence[str]) -> list[dict]:
        flow = _zero_flow(var_names)
        _set(flow, "spd_z", "- g")
        _set(flow, "x", "spd_x")
        _set(flow, "y", "spd_y")
        _set(flow, "z", "spd_z")
        for n in moving_names:
            _set(flow, f"{n}_x", f"spd_{n} * dir_{n}_x")
            _set(flow, f"{n}_y", f"spd_{n} * dir_{n}_y")
        return flow

    locations = [
        {
            "name": "Team_1_Preparing",
            "initial": True,
            "flow": make_flow(team1_names),
            "invariant": field_invariant,
        },
        {
            "name": "Team_1_Throwing",
            "initial": False,
            "flow": make_flow(team2_names),
            "invariant": f"{field_invariant} && hitter <= {nt1}",
        },
        {
            "name": "Team_2_Preparing",
            "initial": False,
            "flow": make_flow(team2_names),
            "invariant": field_invariant,
        },
        {
            "name": "Team_2_Throwing",
            "initial": False,
            "flow": make_flow(team1_names),
            "invariant": f"{field_invariant} && hitter >= {nt1 + 1}",
        },
    ]
    return locations


def _throw_jump(
    *,
    var_names: Sequence[str],
    thrower_name: str,
    thrower_index_one_based: int,
    target_team_for_throw: int,
    target_point_idx_one_based: int,
) -> list[dict]:
    jump = _identity_jump(var_names)
    target_x_var = f"p{target_point_idx_one_based}_{target_team_for_throw}_x"
    target_y_var = f"p{target_point_idx_one_based}_{target_team_for_throw}_y"
    _set(jump, "hitter", str(thrower_index_one_based))
    _set(jump, "target_x", target_x_var)
    _set(jump, "target_y", target_y_var)
    _set(jump, "spd_z", "(2 * g * (max_height - z))^0.5")
    _set(jump, "flight_time", "(spd_z + ( spd_z^2 + 2 * g * z)^0.5) / g")
    _set(jump, "spd_x", "(target_x - x)  /  flight_time")
    _set(jump, "spd_y", "(target_y - y)  /  flight_time")
    _set(jump, f"dir_{thrower_name}_x", "0")
    _set(jump, f"dir_{thrower_name}_y", "0")
    return jump


def _move_jump(*, var_names: Sequence[str], mover_name: str) -> list[dict]:
    jump = _identity_jump(var_names)
    denom = (
        f"((target_x - {mover_name}_x)^2 + "
        f"(target_y - {mover_name}_y)^2)^0.5"
    )
    _set(jump, f"dir_{mover_name}_x",
         f"(target_x - {mover_name}_x) / {denom}")
    _set(jump, f"dir_{mover_name}_y",
         f"(target_y - {mover_name}_y) / {denom}")
    return jump


def _stop_jump(*, var_names: Sequence[str], stopper_name: str) -> list[dict]:
    jump = _identity_jump(var_names)
    _set(jump, f"dir_{stopper_name}_x", "0")
    _set(jump, f"dir_{stopper_name}_y", "0")
    return jump


def _build_edges(
    *,
    var_names: Sequence[str],
    team1_names: Sequence[str],
    team2_names: Sequence[str],
    num_targets: int,
    throw_radius: float,
) -> list[dict]:
    nt1 = len(team1_names)
    edges: list[dict] = []

    teams = [
        (1, team1_names, "Team_1_Preparing", "Team_1_Throwing", "Team_2_Throwing"),
        (2, team2_names, "Team_2_Preparing", "Team_2_Throwing", "Team_1_Throwing"),
    ]

    for team_idx, names, prep_loc, throw_loc, opp_throw_loc in teams:
        for local_pos, name in enumerate(names):
            global_idx = (
                local_pos + 1 if team_idx == 1
                else nt1 + local_pos + 1
            )
            for tp in range(1, num_targets + 1):
                edges.append({
                    "guard": f"(x - {name}_x)^2 + (y - {name}_y)^2 <= {_fmt(throw_radius)}",
                    "source": prep_loc,
                    "action": f"p{tp}",
                    "target": throw_loc,
                    "agent": name,
                    "jump": _throw_jump(
                        var_names=var_names,
                        thrower_name=name,
                        thrower_index_one_based=global_idx,
                        target_team_for_throw=team_idx,
                        target_point_idx_one_based=tp,
                    ),
                })

            edges.append({
                "guard": "",
                "source": opp_throw_loc,
                "action": "move",
                "target": prep_loc,
                "agent": name,
                "jump": _move_jump(var_names=var_names, mover_name=name),
            })

            edges.append({
                "guard": f"dir_{name}_x != 0 || dir_{name}_y != 0",
                "source": prep_loc,
                "action": "stop",
                "target": prep_loc,
                "agent": name,
                "jump": _stop_jump(var_names=var_names, stopper_name=name),
            })
    return edges


def _build_queries(
    *,
    team1_names: Sequence[str],
    team2_names: Sequence[str],
    field_length: float,
    field_width: float,
) -> list[dict]:
    nt1 = len(team1_names)
    half = field_length / 2
    t1 = ", ".join(team1_names)
    t2 = ", ".join(team2_names)
    return [
        {"formula": f"<<{t1}>> F (x > {_fmt(half)} && z == 0)"},
        {"formula": f"<<{t2}>> F (x < {_fmt(half)} && z == 0)"},
        {"formula": (
            f"<<{t1}>> G (x < {_fmt(half)} -> z > 0) && "
            f"((x == 0 || x == {_fmt(field_length)} || y == 0 || "
            f"y == {_fmt(field_width)}) -> hitter > {nt1})"
        )},
        {"formula": (
            f"<<{t2}>> G (x > {_fmt(half)} -> z > 0) && "
            f"((x == 0 || x == {_fmt(field_length)} || y == 0 || "
            f"y == {_fmt(field_width)}) -> hitter <= {nt1})"
        )},
    ]


# ---------------------------------------------------------------------------
# main entry point
# ---------------------------------------------------------------------------

def generate_game(
    *,
    num_players_per_team: int,
    target_points_per_team: int,
    trigger_radii: Sequence[float],
    field_length: float = 18.0,
    field_width: float = 9.0,
    max_height: float = 4.0,
    gravity: float = 9.8,
    player_speeds: Sequence[float] | None = None,
    target_points_team1: Sequence[tuple[float, float]] | None = None,
    target_points_team2: Sequence[tuple[float, float]] | None = None,
    initial_player_positions: Sequence[tuple[float, float]] | None = None,
    initial_ball_position: tuple[float, float, float] | None = None,
    max_steps: int = 10,
    time_bound: int = 30,
) -> dict:
    """Build a volleyball HGT game dict ready to be JSON-serialized.

    Notes on parameters:
      - `trigger_radii`: a list of values that go directly into the RHS of
        `(x - X_x)^2 + (y - X_y)^2 <= R`. The existing example files use
        [1, 0.5, 0.25] for "3 triggers" so we keep that convention.
      - `target_points_team1` are the points team 1 throws AT (they sit on
        team 2's court, with x in [field_length/2, field_length]).
      - `target_points_team2` are the points team 2 throws AT (they sit on
        team 1's court, with x in [0, field_length/2]).
    """
    if num_players_per_team < 1:
        raise ValueError("num_players_per_team must be >= 1")
    if target_points_per_team < 1:
        raise ValueError("target_points_per_team must be >= 1")
    if not trigger_radii:
        raise ValueError("trigger_radii must contain at least one value")

    team1_names, team2_names = _player_names(num_players_per_team)
    all_names = team1_names + team2_names
    n_total = len(all_names)
    half = field_length / 2

    if player_speeds is None:
        player_speeds = [2.5] * n_total
    elif len(player_speeds) != n_total:
        raise ValueError(
            f"player_speeds must have length {n_total}, got {len(player_speeds)}"
        )

    if target_points_team1 is None:
        target_points_team1 = _default_target_points(
            target_points_per_team, half + 1, field_length - 1, 1, field_width - 1
        )
    elif len(target_points_team1) != target_points_per_team:
        raise ValueError(
            f"target_points_team1 must have length {target_points_per_team}"
        )

    if target_points_team2 is None:
        target_points_team2 = _default_target_points(
            target_points_per_team, 1, half - 1, 1, field_width - 1
        )
    elif len(target_points_team2) != target_points_per_team:
        raise ValueError(
            f"target_points_team2 must have length {target_points_per_team}"
        )

    if initial_player_positions is None:
        positions_t1 = _default_player_positions(
            team1_names, 0, half, 0, field_width
        )
        positions_t2 = _default_player_positions(
            team2_names, half, field_length, 0, field_width
        )
        initial_player_positions = positions_t1 + positions_t2
    elif len(initial_player_positions) != n_total:
        raise ValueError(
            f"initial_player_positions must have length {n_total}"
        )

    if initial_ball_position is None:
        bx, by = initial_player_positions[0]
        initial_ball_position = (bx, by, 2.0)

    var_names = _ordered_var_names(all_names, target_points_per_team)

    actions = [{"name": f"p{i + 1}"} for i in range(target_points_per_team)]
    actions += [{"name": "move"}, {"name": "stop"}]

    game: dict = {
        "game_type": "HGT",
        "agents": [{"name": n} for n in all_names],
        "actions": actions,
        "variables": _build_variables(
            all_player_names=all_names,
            num_targets=target_points_per_team,
            max_height=max_height,
            gravity=gravity,
            targets_team1=target_points_team1,
            targets_team2=target_points_team2,
            player_speeds=player_speeds,
            initial_positions=initial_player_positions,
            initial_ball_position=initial_ball_position,
        ),
        "triggers": _build_triggers(
            team1_names=team1_names,
            team2_names=team2_names,
            trigger_radii=trigger_radii,
            num_targets=target_points_per_team,
            field_length=field_length,
        ),
        "locations": _build_locations(
            var_names=var_names,
            team1_names=team1_names,
            team2_names=team2_names,
            field_length=field_length,
            field_width=field_width,
        ),
        "edges": _build_edges(
            var_names=var_names,
            team1_names=team1_names,
            team2_names=team2_names,
            num_targets=target_points_per_team,
            throw_radius=trigger_radii[0],
        ),
        "queries": _build_queries(
            team1_names=team1_names,
            team2_names=team2_names,
            field_length=field_length,
            field_width=field_width,
        ),
        "termination_conditions": {
            "max_steps": str(max_steps),
            "time_bound": str(time_bound),
            "state_formula": (
                f"z <= 0 || x < 0 || x > {_fmt(field_length)} || "
                f"y < 0 || y > {_fmt(field_width)}"
            ),
        },
    }
    return game


def save_game(game: dict, path: str | Path) -> Path:
    out_path = Path(path)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w") as f:
        json.dump(game, f, indent=4)
    return out_path


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def _parse_pairs(values: Iterable[str]) -> list[tuple[float, float]]:
    out: list[tuple[float, float]] = []
    for raw in values:
        x_str, y_str = raw.split(",")
        out.append((float(x_str), float(y_str)))
    return out


def _build_argparser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(description=__doc__.split("\n", 1)[0])
    p.add_argument("--players-per-team", type=int, required=True,
                   help="Number of players per team (each team has the same).")
    p.add_argument("--target-points", type=int, required=True,
                   help="Number of target points per team.")
    p.add_argument("--triggers", type=float, nargs="+", required=True,
                   metavar="R",
                   help="Trigger threshold values (e.g. 1 0.5 0.25).")
    p.add_argument("--field-length", type=float, default=18.0)
    p.add_argument("--field-width", type=float, default=9.0)
    p.add_argument("--max-height", type=float, default=4.0)
    p.add_argument("--gravity", type=float, default=9.8)
    p.add_argument("--player-speeds", type=float, nargs="+", default=None,
                   help="One speed per player (team1 then team2).")
    p.add_argument("--targets-team1", type=str, nargs="+", default=None,
                   metavar="X,Y",
                   help="Target points team 1 throws at (on team 2's court).")
    p.add_argument("--targets-team2", type=str, nargs="+", default=None,
                   metavar="X,Y",
                   help="Target points team 2 throws at (on team 1's court).")
    p.add_argument("--player-positions", type=str, nargs="+", default=None,
                   metavar="X,Y",
                   help="Initial positions for each player (team1 then team2).")
    p.add_argument("--ball-position", type=str, default=None,
                   metavar="X,Y,Z",
                   help="Initial ball position (default: at first player, z=2).")
    p.add_argument("--max-steps", type=int, default=10)
    p.add_argument("--time-bound", type=int, default=30)
    p.add_argument("--out", type=str, required=True,
                   help="Output JSON path.")
    return p


def main(argv: Sequence[str] | None = None) -> None:
    args = _build_argparser().parse_args(argv)

    ball_pos = None
    if args.ball_position is not None:
        parts = [float(v) for v in args.ball_position.split(",")]
        if len(parts) != 3:
            raise SystemExit("--ball-position must be X,Y,Z")
        ball_pos = (parts[0], parts[1], parts[2])

    game = generate_game(
        num_players_per_team=args.players_per_team,
        target_points_per_team=args.target_points,
        trigger_radii=args.triggers,
        field_length=args.field_length,
        field_width=args.field_width,
        max_height=args.max_height,
        gravity=args.gravity,
        player_speeds=args.player_speeds,
        target_points_team1=(
            _parse_pairs(args.targets_team1) if args.targets_team1 else None
        ),
        target_points_team2=(
            _parse_pairs(args.targets_team2) if args.targets_team2 else None
        ),
        initial_player_positions=(
            _parse_pairs(args.player_positions) if args.player_positions else None
        ),
        initial_ball_position=ball_pos,
        max_steps=args.max_steps,
        time_bound=args.time_bound,
    )
    out_path = save_game(game, args.out)
    print(f"Wrote {out_path}")

def main_1():
    # game = generate_game(
    #     num_players_per_team=4,        # → 4 players total (A, B, C, D)
    #     target_points_per_team=7,      # → p1..p5 per team
    #     trigger_radii=[1, 0.5, 0.25],  # → 3 hit-distance triggers per agent
    #     # all of these have sensible defaults:
    #     field_length=18.0, field_width=9.0, max_height=4.0, gravity=9.8,
    #     player_speeds=[2.5, 2.5, 2.0, 2.0, 2.5, 2.5, 2.0, 2.0],
    #     target_points_team1=[(12,2),(12,7),(13,4.5),(16,1),(16,8),(13,1),(13,8)],
    #     target_points_team2=[(1,4.5),(4,1),(4,8),(8,3),(8,6),(1,1),(1,8)],
    #     initial_player_positions=[(7,2),(7,7), (4,2),(4,7), (16,2),(16,7), (11,2),(11,7)],
    #     initial_ball_position=(7,2,2),
    #     max_steps=10, time_bound=30,
    # )
    # save_game(game, "examples/hgt/my_volleyball_4-7-3.json")
    game = generate_game(
        num_players_per_team=4,        # → 4 players total (A, B, C, D)
        target_points_per_team=7,      # → p1..p5 per team
        trigger_radii=[0.5],  # → 3 hit-distance triggers per agent
        # all of these have sensible defaults:
        field_length=18.0, field_width=9.0, max_height=4.0, gravity=9.8,
        player_speeds=[2.5, 2.5, 2.0, 2.0, 2.5, 2.5, 2.0, 2.0],
        target_points_team1=[(12,2),(12,7),(13,4.5),(16,1),(16,8),(13,1),(13,8)],
        target_points_team2=[(1,4.5),(4,1),(4,8),(8,3),(8,6),(1,1),(1,8)],
        initial_player_positions=[(7,2),(7,7), (4,2),(4,7), (16,2),(16,7), (11,2),(11,7)],
        initial_ball_position=(7,2,2),
        max_steps=10, time_bound=30,
    )
    save_game(game, "examples/hgt/volleyball/volleyball_4-players-7-points-1-triggers.json")

if __name__ == "__main__":
    main_1()
