"""Generate a parameterised N-car / M-lane highway HGT instance.

Usage:
    python gen_highway.py [--cars N] [--lanes M] [--seed S]

Defaults: 4 cars, 6 lanes, random seed.

Lane centers are y in {10, 20, ..., M*10} (lanes are 10 wide).
The continuous lateral dynamics use a quintic (min-jerk) lane-change profile
that moves a car exactly one lane (10 units) over tau = 3 seconds with
vy(0) = vy(3) = 0.

Safe initial placement guarantees:
  - All cars start in valid lane centers.
  - Cars in the same lane are more than DSAFE apart longitudinally, so no
    tailing trigger fires at t=0.
  - All initial speeds are strictly below VMAX (with acc_i = +ACC > 0) and
    distinct, so no Vmax/Vmin trigger fires at t=0 and no two cars are forced
    to act at the same instant (which would deadlock the second).
"""

import json
import random
import argparse
from collections import OrderedDict, defaultdict

TIME_LIMIT = 90
MAX_STEPS = 15
NUM_CARS  = 12
NUM_LANES = 6
SEEDS = 10

random.seed(SEEDS)

CARS = [f"C_{i}" for i in range(1, NUM_CARS + 1)]

VMAX  = 8      # speed limit (upper)
VMIN  = 1      # speed limit (lower)
ACC   = 0.2      # |acceleration| applied by acc / dec
DSAFE = 10     # safe following distance threshold (tailing / clear triggers)
GOAL  = 40     # "far enough": each car must advance GOAL beyond its start x

LANE_WIDTH      = 10
LANE_MIN_CENTER = LANE_WIDTH                  # 10
LANE_MAX_CENTER = NUM_LANES * LANE_WIDTH      # e.g. 60 for 6 lanes
ROAD_LO = LANE_MIN_CENTER - LANE_WIDTH // 2  # 5
ROAD_HI = LANE_MAX_CENTER + LANE_WIDTH // 2  # e.g. 65 for 6 lanes

DY_HIT = 5   # lateral collision threshold (lanes overlap)
DX_HIT = 2   # longitudinal collision threshold

# ---------------------------------------------------------------- safe init
# Distinct speeds in [VMIN, VMAX) with 0.5-unit steps.
# We stay strictly below VMAX because acc starts at +ACC (positive), and
# vx = VMAX with acc > 0 would fire the Vmax trigger immediately.
speed_pool = [round(VMIN + 0.2 * k, 1)
              for k in range(int((VMAX - VMIN) / 0.2))]

if NUM_CARS > len(speed_pool):
    raise SystemExit(
        f"Cannot assign {NUM_CARS} distinct speeds from {len(speed_pool)} candidates "
        f"(VMIN={VMIN}, VMAX={VMAX}, step=0.5). Reduce --cars or widen the speed range."
    )

speeds = random.sample(speed_pool, NUM_CARS)

# Assign each car a random lane then space them safely within each lane.
# Same-lane separation is DSAFE + 1 .. DSAFE + 10 (strictly > DSAFE so
# tailing trigger does not fire at t=0).
lane_centers = [LANE_WIDTH * (k + 1) for k in range(NUM_LANES)]
car_lanes = {car: random.choice(lane_centers) for car in CARS}

by_lane = defaultdict(list)
for car, lane in car_lanes.items():
    by_lane[lane].append(car)

car_x = {}
for lane, lane_cars in by_lane.items():
    random.shuffle(lane_cars)
    x = random.randint(0, 10)
    for car in lane_cars:
        car_x[car] = x
        x += DSAFE + 1 + random.randint(0, 9)  # strictly > DSAFE gap

INIT = {
    car: {
        "x":  str(car_x[car]),
        "vx": str(speeds[i]),
        "y":  str(car_lanes[car]),
        "cy": str(car_lanes[car]),
    }
    for i, car in enumerate(CARS)
}

# ---------------------------------------------------------------- helpers
def others(i):
    return [j for j in CARS if j != i]

def pairs():
    return [(CARS[a], CARS[b])
            for a in range(len(CARS)) for b in range(a + 1, len(CARS))]

# ---------------------------------------------------------------- variables
variables = []
for i in CARS:
    variables += [
        {"name": f"x_{i}",      "expression": INIT[i]["x"]},
        {"name": f"vx_{i}",     "expression": INIT[i]["vx"]},
        {"name": f"acc_{i}",    "expression": str(ACC)},
        {"name": f"y_{i}",      "expression": INIT[i]["y"]},
        {"name": f"vy_{i}",     "expression": "0"},
        {"name": f"tau_{i}",    "expression": "0"},  # lane-change timer
        {"name": f"lc_dir_{i}", "expression": "0"},
        {"name": f"cy_{i}",     "expression": INIT[i]["cy"]},
    ]

# ---------------------------------------------------------------- triggers
triggers = []
for i in CARS:
    tailing = " || ".join(
        f"(abs(y_{i} - y_{j}) < {DY_HIT} && x_{j} - x_{i} > 0 && "
        f"x_{j} - x_{i} <= {DSAFE} && vx_{i} > vx_{j})"
        for j in others(i)
    )
    # Vmax/Vmin triggers are gated by the sign of acc so they fire exactly once
    # at the boundary while the car is still driving into it.
    triggers += [
        {"agent": i, "trigger": tailing},
        {"agent": i, "trigger": f"vx_{i} >= {VMAX} && acc_{i} > 0"},
        {"agent": i, "trigger": f"vx_{i} <= {VMIN} && acc_{i} < 0"},
        {"agent": i, "trigger": f"tau_{i} >= 3"},
    ]

# ---------------------------------------------------------------- flow / invariant
flow = []
for i in CARS:
    flow += [
        {"expression": f"vx_{i}", "variable": f"x_{i}"},
        {"expression": f"acc_{i}", "variable": f"vx_{i}"},
        {"expression": f"vy_{i}", "variable": f"y_{i}"},
        {"expression": (
            f"lc_dir_{i} * "
            f"((200 / 9) * tau_{i}"
            f" - (200 / 9) * tau_{i} ^ 2"
            f" + (400 / 81) * tau_{i} ^ 3)"
        ), "variable": f"vy_{i}"},
        {"expression": f"abs(lc_dir_{i})", "variable": f"tau_{i}"},
    ]

invariant = " && ".join(
    f"(vx_{i} >= {VMIN} && vx_{i} <= {VMAX} && tau_{i} <= 3)" for i in CARS
)

locations = [{
    "name": "drive",
    "initial": True,
    "flow": flow,
    "invariant": invariant,
}]

# ---------------------------------------------------------------- edges
actions = ["acc", "dec", "cruise", "left", "right", "end_lc"]
edges = []
for i in CARS:
    edges.append({
        "guard": f"vx_{i} < {VMAX}",
        "source": "drive", "action": "acc", "target": "drive", "agent": i,
        "jump": [{"expression": str(ACC), "variable": f"acc_{i}"}],
    })
    edges.append({
        "guard": f"vx_{i} > {VMIN}",
        "source": "drive", "action": "dec", "target": "drive", "agent": i,
        "jump": [{"expression": str(-ACC), "variable": f"acc_{i}"}],
    })
    edges.append({
        "guard": "true",
        "source": "drive", "action": "cruise", "target": "drive", "agent": i,
        "jump": [{"expression": "0", "variable": f"acc_{i}"}],
    })
    edges.append({
        "guard": f"lc_dir_{i} == 0 && cy_{i} <= {LANE_MAX_CENTER - LANE_WIDTH}",
        "source": "drive", "action": "left", "target": "drive", "agent": i,
        "jump": [
            {"expression": "1", "variable": f"lc_dir_{i}"},
            {"expression": "0", "variable": f"tau_{i}"},
            {"expression": f"cy_{i} + {LANE_WIDTH}", "variable": f"cy_{i}"},
        ],
    })
    edges.append({
        "guard": f"lc_dir_{i} == 0 && cy_{i} >= {LANE_MIN_CENTER + LANE_WIDTH}",
        "source": "drive", "action": "right", "target": "drive", "agent": i,
        "jump": [
            {"expression": "-1", "variable": f"lc_dir_{i}"},
            {"expression": "0", "variable": f"tau_{i}"},
            {"expression": f"cy_{i} - {LANE_WIDTH}", "variable": f"cy_{i}"},
        ],
    })
    edges.append({
        "guard": f"lc_dir_{i} != 0 && tau_{i} >= 3",
        "source": "drive", "action": "end_lc", "target": "drive", "agent": i,
        "jump": [
            {"expression": "0", "variable": f"lc_dir_{i}"},
            {"expression": "0", "variable": f"tau_{i}"},
            {"expression": "0", "variable": f"vy_{i}"},
            {"expression": f"cy_{i}", "variable": f"y_{i}"},
        ],
    })

# ---------------------------------------------------------------- queries
coalition = ", ".join(CARS)
# safe = " && ".join(
#     f"(abs(x_{i} - x_{j}) >= {DX_HIT} || abs(y_{i} - y_{j}) >= {DY_HIT})"
#     for (i, j) in pairs()
# )
# queries = [] #[{"formula": f"<<{coalition}>> G ({safe})"}]
# for i in CARS:
#     goal_x = int(INIT[i]["x"]) + VMAX * 5
#     queries.append({"formula": f"<<{coalition}>> F (x_{i} >= {goal_x})"})

queries = [{"formula": f"<<{coalition}>> F " + " && ".join(f"(x_{i} >= {int(INIT[i]['x']) + VMAX * 5})" for i in CARS)}]

# ---------------------------------------------------------------- termination
collision = " || ".join(
    f"(abs(x_{i} - x_{j}) < {DX_HIT} && abs(y_{i} - y_{j}) < {DY_HIT})"
    for (i, j) in pairs()
)
offroad = " || ".join(f"(y_{i} < {ROAD_LO} || y_{i} > {ROAD_HI})" for i in CARS)

termination = {
    "max_steps": f"{MAX_STEPS}",
    "time_bound": f"{TIME_LIMIT}",
    "state_formula": f"{collision} || {offroad}",
}

# ---------------------------------------------------------------- description
init_summary = "; ".join(
    f"{car} lane {car_lanes[car] // LANE_WIDTH} x={car_x[car]} vx={speeds[i]}"
    for i, car in enumerate(CARS)
)

# ---------------------------------------------------------------- assemble
game = OrderedDict([
    ("game_type", "HGT"),
    ("description",
     f"A one-way {NUM_LANES}-lane highway with {NUM_CARS} car(s) "
     f"({', '.join(CARS)}). Lanes are {LANE_WIDTH} wide with centers "
     f"y in {{{', '.join(str(c) for c in lane_centers)}}}. "
     "Cars accelerate/decelerate longitudinally and perform quintic (min-jerk) "
     "lane changes that move exactly one lane over tau=3 s. "
     "Triggers (tailing, speed-limit, end-of-maneuver) give a car a decision "
     "point; guarded edges supply the available maneuvers. "
     f"Initial placement (safe, no triggers at t=0): {init_summary}. "
     f"The coalition of all cars looks for a jointly safe strategy in which "
     f"every car advances {GOAL} beyond its starting x."),
    ("agents", [{"name": i} for i in CARS]),
    # cruise listed first so the search tries speed-preserving choice before
    # more disruptive ones (affects exploration order only, not semantics).
    ("actions", [{"name": a} for a in ["cruise", "acc", "dec", "left", "right", "end_lc"]]),
    ("variables", variables),
    ("triggers", triggers),
    ("locations", locations),
    ("edges", edges),
    ("queries", queries),
    ("termination_conditions", termination),
])

out = f"examples/hgt/highway/highway_{NUM_CARS}-cars_{NUM_LANES}-lanes.json"
with open(out, "w") as f:
    json.dump(game, f, indent=4)
    f.write("\n")

print("Wrote:", out)
print(f"  seed:      {SEEDS}")
print(f"  cars:      {NUM_CARS}  {CARS}")
print(f"  lanes:     {NUM_LANES}")
print()
print("  Initial placements (x | lane | vx):")
for i, car in enumerate(CARS):
    print(f"    {car}: x={car_x[car]:>3} lane {car_lanes[car] // LANE_WIDTH}  vx={speeds[i]}")
print()
print(f"  variables: {len(variables)}")
print(f"  triggers:  {len(triggers)}")
print(f"  edges:     {len(edges)}")
print(f"  queries:   {len(queries)}")
