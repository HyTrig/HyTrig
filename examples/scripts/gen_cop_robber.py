
import json
from collections import OrderedDict


### Star Graph
# GRAPH = "star"
## 7 nodes
# NODES = [(3, 0), (1.5, 2.598), (-1.5, 2.598), (-3, 0), (-1.5, -2.598), (1.5, -2.598), (0,0)]
# CONNECTIONS = [(0, 6), (1, 6), (2, 6), (3, 6), (4, 6), (5, 6)]

# 9 nodes
# NODES = [(3, 0), (2.121, 2.121), (0, 3), (-2.121, 2.121), (-3, 0), (-2.121, -2.121), (0, -3), (2.121, -2.121), (0, 0)]
# CONNECTIONS = [(0, 8), (1, 8), (2, 8), (3, 8), (4, 8), (5, 8), (6, 8)]

# COPS_STARTING_NODES = [0, 1]
# ROBBER_STARTING_NODES = len(NODES) - 1

## Cycle Graph
GRAPH = "cycle"
# # 6 Nodes
# NODES = [(3, 0), (1.5, 2.598), (-1.5, 2.598), (-3, 0), (-1.5, -2.598), (1.5, -2.598)]
# CONNECTIONS = [(0, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 0)]

# # ## 8 Nodes
NODES = [(3, 0), (2.121, 2.121), (0, 3), (-2.121, 2.121), (-3, 0), (-2.121, -2.121), (0, -3), (2.121, -2.121)]
CONNECTIONS = [(0, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 7), (7, 0)]

COPS_STARTING_NODES = [0]
ROBBER_STARTING_NODES = len(NODES) // 2

### Comb Graph
# GRAPH = "comb"
## 6 Nodes
# NODES = [(-3, 0), (-3, 3), (0, 0), (0, 3), (3, 0), (3, 3)]
# CONNECTIONS = [(0, 1), (0, 2), (2, 3), (2, 4), (4, 5)]

# 8 Nodes
# NODES = [(-3, 0), (-3, 3), (0, 0), (0, 3), (3, 0), (3, 3), (6, 0), (6, 3)]
# CONNECTIONS = [(0, 1), (0, 2), (2, 3), (2, 4), (4, 5), (4, 6), (6, 7)]

## 10 Nodes
# NODES = [(-3, 0), (-3, 3), (0, 0), (0, 3), (3, 0), (3, 3), (6, 0), (6, 3), (9, 0), (9, 3)]
# CONNECTIONS = [(0, 1), (0, 2), (2, 3), (2, 4), (4, 5), (4, 6), (6, 7), (6, 8), (8, 9)]

# COPS_STARTING_NODES = [1, 3]
# ROBBER_STARTING_NODES = len(NODES) - 1

COP_SPEED = 2.5
ROBBER_SPEED = 1

MAX_STEPS = 15
TIME_BOUND = 90


file_name = f"examples/hgt/cop_robber/2cops_{GRAPH}_{len(NODES)}_spd_{COP_SPEED}_cops_robber.json"

# ---------------------------------------------------------------- agents and actions
number_of_cops = len(COPS_STARTING_NODES)
agents = [{"name": f"cop_{i}"} for i in range(number_of_cops)] 
agents.append({"name": "robber"})

actions = [{"name": f"v{j}"}  for j in range(len(NODES))]
# ---------------------------------------------------------------- variables
variables = []
for (i, node) in enumerate(NODES):
    variables.append({"name": f"v{i}_x", "expression": f"{node[0]}"})
    variables.append({"name": f"v{i}_y", "expression": f"{node[1]}"})

variables.append({"name": f"cop_speed", "expression": f"{COP_SPEED}"})
variables.append({"name": f"robber_speed", "expression": f"{ROBBER_SPEED}"})

for (i, node) in enumerate(COPS_STARTING_NODES):
    variables.append({"name": f"cop_{i}_x", "expression": f"{NODES[node][0]}"})
    variables.append({"name": f"cop_{i}_y", "expression": f"{NODES[node][1]}"})

    variables.append({"name": f"target_cop_{i}_x", "expression": f"{NODES[node][0]}"})
    variables.append({"name": f"target_cop_{i}_y", "expression": f"{NODES[node][1]}"})

    variables.append({"name": f"cop_{i}_dir_x", "expression": "0"})
    variables.append({"name": f"cop_{i}_dir_y", "expression": "0"})

variables.append({"name": f"robber_x", "expression": f"{NODES[ROBBER_STARTING_NODES][0]}"})
variables.append({"name": f"robber_y", "expression": f"{NODES[ROBBER_STARTING_NODES][1]}"})

variables.append({"name": f"target_robber_x", "expression": f"{NODES[ROBBER_STARTING_NODES][0]}"})
variables.append({"name": f"target_robber_y", "expression": f"{NODES[ROBBER_STARTING_NODES][1]}"})

variables.append({"name": f"robber_dir_x", "expression": "0"})
variables.append({"name": f"robber_dir_y", "expression": "0"})

# ---------------------------------------------------------------- triggers
triggers = [
    {"agent": f"cop_{i}", "trigger": f"target_cop_{i}_x == v{j}_x && target_cop_{i}_y == v{j}_y && cop_{i}_x == v{j}_x && cop_{i}_y == v{j}_y"} for i in range(number_of_cops) for j in range(len(NODES))
] + [{"agent": f"robber", "trigger": f"target_robber_x == v{j}_x && target_robber_y == v{j}_y && robber_x == v{j}_x && robber_y == v{j}_y"} for j in range(len(NODES))]

# ---------------------------------------------------------------- locations
running_flow = (
    [{"expression": f"cop_speed * cop_{i}_dir_x", "variable": f"cop_{i}_x"} for i in range(number_of_cops)] +
    [{"expression": f"cop_speed * cop_{i}_dir_y", "variable": f"cop_{i}_y"} for i in range(number_of_cops)] +
    [{"expression": f"robber_speed * robber_dir_x", "variable": f"robber_x"}, 
     {"expression": f"robber_speed * robber_dir_y", "variable": f"robber_y"}]
)
running_invariant = " && ".join([f"(cop_{i}_x >= {min([node[0] for node in NODES])} && " \
                                 f"cop_{i}_x <= {max([node[0] for node in NODES])} && " \
                                 f"cop_{i}_y >= {min([node[1] for node in NODES])} && " \
                                 f"cop_{i}_y <= {max([node[1] for node in NODES])})"
                                for i in range(number_of_cops)]) + \
                                f" && (robber_x >= {min([node[0] for node in NODES])} && " \
                                f"robber_x <= {max([node[0] for node in NODES])} && " \
                                f"robber_y >= {min([node[1] for node in NODES])} && " \
                                f"robber_y <= {max([node[1] for node in NODES])})" 


locations = [
    {"name": "running", "initial": True,
     "flow": running_flow, "invariant": running_invariant}
]

# ---------------------------------------------------------------- edges

def get_guard(agent:str, node:int) -> str:
    return f"{agent}_x == v{node}_x && {agent}_y == v{node}_y"

def get_jump(agent:str, node:int) -> list:

    return [{"expression": f"(v{node}_x - {agent}_x) / ((v{node}_x - {agent}_x)^2 + (v{node}_y - {agent}_y)^2)^0.5", "variable": f"{agent}_dir_x"}, 
            {"expression": f"(v{node}_y - {agent}_y) / ((v{node}_x - {agent}_x)^2 + (v{node}_y - {agent}_y)^2)^0.5", "variable": f"{agent}_dir_y"},
            {"expression": f"v{node}_x", "variable": f"target_{agent}_x"}, 
            {"expression": f"v{node}_y", "variable": f"target_{agent}_y"}]

edges = []
for (v1, v2) in CONNECTIONS:
    edges.append({
        "guard": get_guard("robber", v1),
        "source": "running", "action": f"v{v2}", "target": "running", "agent": "robber",
        "jump": get_jump("robber", v2),
    })
    for i in range(number_of_cops):
        edges.append({
            "guard": get_guard(f"cop_{i}", v1),
            "source": "running", "action": f"v{v2}", "target": "running", "agent": f"cop_{i}",
            "jump": get_jump(f"cop_{i}", v2),
        })

    edges.append({
        "guard": get_guard("robber", v2),
        "source": "running", "action": f"v{v1}", "target": "running", "agent": "robber",
        "jump": get_jump("robber", v1),
    })
    for i in range(number_of_cops):
        edges.append({
            "guard": get_guard(f"cop_{i}", v2),
            "source": "running", "action": f"v{v1}", "target": "running", "agent": f"cop_{i}",
            "jump": get_jump(f"cop_{i}", v1),
        })

# ---------------------------------------------------------------- queries
cops_names = ", ".join([f"cop_{i}" for i in range(number_of_cops)])
robber_caught = " || ".join([f"(cop_{i}_x == robber_x && cop_{i}_y == robber_y)" for i in range(number_of_cops)])

queries = [
    # Can Cinderella keep every pocket within capacity for the whole (bounded) game?
    {"formula": f"<<{cops_names}>> F ({robber_caught})"},
    # Dual view: can the Stepmother force some pocket to overflow?
    {"formula": f"<<robber>> G ! ({robber_caught})"},
]

# ---------------------------------------------------------------- termination
termination = {
    "max_steps": str(MAX_STEPS),
    "time_bound": str(TIME_BOUND),
    "state_formula": robber_caught,   # a pocket overflowed: the Stepmother has won
}



game = OrderedDict([
    ("game_type", "HGT"),
    ("description", f"A cop-and-robber pursuit game on a {len(NODES)}-vertex graph. Both run along edges at different speeds. The cops win by reaching the robber's position."),
    ("agents", agents),
    ("actions", actions),
    ("variables", variables),
    ("triggers", triggers),
    ("locations", locations),
    ("edges", edges),
    ("queries", queries),
    ("termination_conditions", termination),
])


with open(file_name, "w") as f:
    json.dump(game, f, indent=4)
    f.write("\n")


print("wrote", file_name)
print("variables:", len(variables), "\n", 
      "agents:", 2, "\n", 
      "actions:", len(actions), "\n", 
      "triggers:", len(triggers), "\n", 
      "edges:", len(edges), "\n", 
      "locations:", len(locations), "\n", 
      "queries:", len(queries))