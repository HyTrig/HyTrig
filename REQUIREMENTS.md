# REQUIREMENTS

This document describes the hardware and software environment required to build
and run **HyTrig**, a model checker for bounded hybrid games. HyTrig is
implemented in the [Julia](https://julialang.org) programming language and runs
on all major platforms (Linux, macOS, and Windows).

## Hardware requirements

HyTrig has **no strict hardware requirements** and imposes no need for
non-commodity peripherals, specialised accelerators, or unusual amounts of
storage. It runs on commodity hardware and does not depend on a GPU. A
disk footprint of a few gigabytes is sufficient for the Julia runtime together
with all package dependencies (see below).

That said, model checking bounded hybrid games is computationally intensive.
The core algorithm explores the game tree and evaluates real-valued constraints,
so its cost grows quickly with the size of the model (number of agents,
triggers, variables, and the bound). In practice this means:

- **Simple examples** (such as the smaller models in [`examples/hgt/small_examples`](examples//hgt/small_examples))
  are expected to run comfortably on **most modern computers**, including
  laptops, within seconds to minutes.
- **Larger / more complex examples** exercise the high computational complexity
  of the underlying problem and can be **slow on older or resource-constrained
  machines**. On such systems they may take considerably longer and benefit
  from more CPU performance and RAM. No specific minimum is enforced, but a
  recent multi-core CPU and several gigabytes of free RAM are recommended for
  the bigger models.

The graphical user interface (GUI) additionally requires a working display /
windowing environment (see the Docker notes below for headless setups), but
this is standard on any desktop operating system.

## Software requirements

### Native installation (recommended)

- **Julia 1.10.** This is the version HyTrig targets (`[compat] julia = "1.10"`
  in [`Project.toml`](Project.toml)). It can be installed and selected with
  [`juliaup`](https://github.com/JuliaLang/juliaup):

  ```bash
  juliaup add 1.10
  juliaup default 1.10
  ```

- **Python 3 (≥ 3.11).** Required by the Qt/QML runtime used for the GUI and for using the scripts to generate new examples.
- **Operating system:** any platform supported by Julia 1.10 — Linux, macOS,
  or Windows. No platform-specific features are required.

All Julia package dependencies are pinned in [`Project.toml`](Project.toml), which together play the role that a
`requirements.txt` plays in a Python-only project: they provide explicit,
reproducible versioning. Install them from the project root with:

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
```

Key dependencies include:

- `DifferentialEquations` — numerical integration of the continuous dynamics
- `QML` and `CxxWrap` (0.16) — the Qt6-based graphical user interface
- `JSON3` / `StructTypes` — model serialisation
- `DataStructures`, `ResumableFunctions`, `Match`, and others — core algorithms

Running `Pkg.instantiate()` reproduces the exact dependency versions used for this artifact.

### Containerised installation (Docker)

A [`Dockerfile`](Dockerfile) is provided for a fully reproducible, self-contained
environment. It is based on the official `julia:1.10-bookworm` image (Debian 12,
which ships Python 3.11) and installs the OpenGL/X11/xcb runtime libraries that
the bundled Qt6 binaries need for the GUI.

```bash
# Build the image
docker build -t hytrig .

# Run the CLI (default entry point)
docker run -it --rm hytrig
```

The GUI can also be run from the container, but because it needs a display it
requires an X server on the host:

```bash
# macOS (XQuartz with "Allow connections from network clients" + `xhost +localhost`)
docker run -it --rm -e DISPLAY=host.docker.internal:0 hytrig julia hytrig_gui.jl

# Linux
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix hytrig julia hytrig_gui.jl
```

## Deviations from standard environments

There are no deviations from standard environments. HyTrig relies only on a
standard Julia 1.10 installation (plus a standard Python 3 and, for the GUI, a
standard desktop display / X server). The Docker image documents the exact
system libraries needed so that the environment can be reproduced on any host
without manual configuration.
