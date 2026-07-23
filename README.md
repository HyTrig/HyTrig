# HyTrig: A Model Checker for Bounded Hybrid Games

**HyTrig** is a high-performance **model checker and simulation tool** for the
verification and analysis of **bounded hybrid games**.

It provides a practical toolchain for specifying and analysing hybrid game
models against properties expressed in **Alternating-time Temporal Logic (ATL)**
extended with real-valued constraints (**Hybrid ATL**).

HyTrig implements a novel model-checking algorithm for **Hybrid Games with
Triggers (HGT)**, which incorporates the agents' rationale directly into the
model to make the verification of bounded scenarios decidable.

The tool is implemented in the [**Julia**](https://julialang.org) programming
language and runs on Linux, macOS, and Windows.

## ⚙️ Installation

HyTrig is a Julia-based tool. To get started, first install the Julia
programming language.

**1. Install Julia.**
Download and install Julia from the official website:
[https://julialang.org/downloads/](https://julialang.org/downloads/)

**2. Select the correct Julia version.**
HyTrig targets **Julia 1.10**. Using [`juliaup`](https://github.com/JuliaLang/juliaup),
run:

```bash
juliaup add 1.10
juliaup default 1.10
```

**3. Install the dependencies.**
From the project root, instantiate the exact package versions pinned in
[`Project.toml`](Project.toml):

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
```

> The CLI and GUI scripts also instantiate the environment automatically on
> first launch, so this step is optional but makes the first run faster.

For a fully reproducible, containerised environment, a [`Dockerfile`](Dockerfile)
is also provided — see the [Docker](#-docker) section below. Detailed hardware
and software requirements are documented in [`REQUIREMENTS.md`](REQUIREMENTS.md).

## 🚀 Usage

HyTrig can be run using either a command-line interface (CLI) or a graphical
user interface (GUI).

### Command-Line Interface (CLI)

Start the CLI and follow the text-based prompts to select a model and evaluate
its queries:

```bash
julia hytrig_cli.jl
```

The CLI lets you browse the bundled [`examples/`](examples/) directory (or type
an arbitrary file path), runs every query declared in the selected model, prints
a per-query summary with timing information, and optionally writes the resulting
evaluation trees to a Markdown log under `logs/`.

### Graphical User Interface (GUI)

Launch the GUI to define game models visually, specify Hybrid ATL properties,
inspect models, and explore generated game trees:

```bash
julia hytrig_gui.jl
```

The GUI requires a working desktop display environment.

## 📂 Examples

The [`examples/`](examples/) directory contains ready-to-run HGT models grouped
by scenario:

- [`examples/hgt/small_examples/`](examples/hgt/small_examples/) — small models
  (e.g. a bouncing ball, a player in the middle) that run quickly on most modern
  computers and are a good starting point.
- [`examples/hgt/cop_robber/`](examples/hgt/cop_robber/),
  [`examples/hgt/highway/`](examples/hgt/highway/), and
  [`examples/hgt/volleyball/`](examples/hgt/volleyball/) — larger, more complex
  scenarios.

The Python scripts in [`examples/scripts/`](examples/scripts/) can be used to
generate additional parametrised examples (they require Python 3, ≥ 3.11).

## 🐳 Docker

A [`Dockerfile`](Dockerfile) provides a self-contained environment based on the
official `julia:1.10-bookworm` image, with all system libraries needed by the
Qt6-based GUI preinstalled.

```bash
# Build the image
docker build -t hytrig .

# Run the CLI (default entry point)
docker run -it --rm hytrig
```

Running the GUI from the container requires an X server on the host:

```bash
# macOS (XQuartz with "Allow connections from network clients" + `xhost +localhost`)
docker run -it --rm -e DISPLAY=host.docker.internal:0 hytrig julia hytrig_gui.jl

# Linux
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix hytrig julia hytrig_gui.jl
```

## 🧪 Tests

The [`test/`](test/) directory contains tests covering the tokenizer, the
formula and game parsers, and the continuous-evolution engine. Individual test
files can be run directly, for example:

```bash
julia --project=. test/test_formula_parser.jl
```

## 📄 License

HyTrig is released under the terms of the [CC0 1.0 Universal](LICENSE) public
domain dedication.

## 📚 Citation

If you use HyTrig in your research, please cite it. Citation metadata is provided
in [`CITATION.cff`](CITATION.cff):

> Hamarneh, Q., Maas, M., & Schwammberger, M. *HyTrig*.
> DOI: [10.5281/zenodo.21519099](https://doi.org/10.5281/zenodo.21519099)
