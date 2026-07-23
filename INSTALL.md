# INSTALL

Installation instructions for **HyTrig**, a model checker for bounded hybrid
games. HyTrig runs on Linux, macOS, and Windows. For full environment details
see [`REQUIREMENTS.md`](REQUIREMENTS.md).

There are two ways to install HyTrig. **Using Docker is recommended** — it
provides a self-contained, reproducible environment with every dependency
already in place, so there is nothing to configure on your machine.

## Option A — Docker (recommended)

Requires only [Docker](https://docs.docker.com/get-docker/).

```bash
# From the project root
docker build -t hytrig .
docker run -it --rm hytrig
```

The `run` command launches the interactive command-line interface (CLI). That's
it — no Julia installation or dependency management needed.

## Option B — Native installation

1. **Install Julia 1.10** from [julialang.org/downloads](https://julialang.org/downloads/).
   Using [`juliaup`](https://github.com/JuliaLang/juliaup):

   ```bash
   juliaup add 1.10
   juliaup default 1.10
   ```

2. **Install the dependencies** from the project root (exact versions are pinned
   in [`Project.toml`](Project.toml) and [`Manifest.toml`](Manifest.toml)):

   ```bash
   julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
   ```

3. **Start the CLI:**

   ```bash
   julia hytrig_cli.jl
   ```

## Testing the installation

To confirm HyTrig is installed and working, run one of the bundled
[`small_examples`](examples/hgt/small_examples/) — these are lightweight and
finish in a few seconds on most modern computers.

Start the CLI (`docker run -it --rm hytrig`, or `julia hytrig_cli.jl` for a
native install) and, at the interactive prompts, navigate into
`small_examples/` and select **`3_players_1_ball.json`**. The tool will load the
game, evaluate each of its Hybrid ATL queries, and print a result for each.

### Expected output

You should see output similar to the following (the exact **evaluation times
will differ** depending on your hardware):

```text
Loaded game from .../examples/hgt/small_examples/3_players_1_ball.json

<<A >> F (y > 6.0): false
  Evaluation time = 2.693

<<B C >> G (y <= 2.0): true
  Nodes = 32 | Tree depth = 32 | Max game time = 28.8213
  Evaluation time = 0.0813

<<B >> G (y <= 2.0): false
  Evaluation time = 0.0048

<<>> F Deadlock: false
  Evaluation time = 0.1185

************************************************************
Total evaluation time = 3.53
************************************************************
```

If you see per-query results like these, HyTrig is correctly installed and
working. What this tells you: for a ball bounced between three players, agents
**B** and **C** can *cooperate* to keep the ball's height `y` at or below `2`
forever (`true`), whereas **B** *alone* cannot (`false`) — HyTrig has decided
these strategic, real-valued properties automatically. You may optionally save
the full evaluation tree to a Markdown log when prompted.

Try the other models in `examples/` to explore further and compare the results 
to the ones shown in Table-I,II, and III in the attached paper.
