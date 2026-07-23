# STATUS

The authors are applying for all three badges: **Available**, **Reviewed**, and
**Reproducible**.

Below we summarise why we believe the HyTrig artifact meets the criteria for
each.

## Available

The complete artifact source code, bundled example models, and documentation is 
provided in full, with no proprietary or missing components. It is released
as open source on GitHub at
[https://github.com/HyTrig/HyTrig](https://github.com/HyTrig/HyTrig).

The artifact is reasonable and complete: it includes the full implementation of
the model checker, a command-line and a graphical interface, a suite of example
games, installation and requirements documentation
([`INSTALL.md`](INSTALL.md), [`REQUIREMENTS.md`](REQUIREMENTS.md),
[`README.md`](README.md)), and a [`Dockerfile`](Dockerfile) for a reproducible
environment. This is sufficient to support reproducibility of the published
results.

## Reviewed

Beyond being complete, the artifact **runs to produce the outputs described**:

- It builds and runs from scratch on all major platforms via the pinned Julia
  1.10 environment ([`Project.toml`](Project.toml), [`Manifest.toml`](Manifest.toml))
  or, with no local setup, via the provided Docker image.
- [`INSTALL.md`](INSTALL.md) gives a concrete, self-checking usage example: a
  reviewer can run the bundled `3_players_1_ball` model and compare the tool's
  terminal output against the expected output documented there, confirming the
  installation works.
- The [`examples/`](examples/) directory contains the models used in the paper,
  so the reported experiments can be re-run directly.
- A [`test/`](test/) suite exercises the tokenizer, the formula and game
  parsers, and the continuous-evolution engine.

The documentation, examples, and expected outputs together make the artifact
straightforward to review and confirm as functional.

## Reproducible

The artifact is designed so that an independent party can regenerate the
published computational results:

- Every experiment reported in the paper corresponds to a model shipped in
  [`examples/`](examples/), evaluated through the same CLI that reviewers use.
- Running these examples reproduces the model-checking results (query outcomes
  and evaluation-tree metrics such as node counts and tree depth) summarised in
  **Tables I, II, and III** of the accompanying paper. Because outcomes are
  deterministic, the reported truth values and tree sizes regenerate exactly;
  only wall-clock evaluation times differ across hardware, as expected.
- The pinned dependency manifest and the Docker image fix the software
  environment, removing environment drift as a source of divergence.

Because the artifact has also been prepared to meet the Available and Reviewed
criteria, we believe it satisfies the additional requirement of the Reproducible
badge that the underlying research objects were reviewed.
