# HyTrig model checker — Julia 1.10 + Python 3 (>= 3.11) + Qt/X11 runtime for the QML GUI.
#
# Build:
#   docker build -t hytrig .
#
# Run the CLI (default):
#   docker run -it --rm hytrig
#
# Run the GUI (requires an X server on the host, e.g. XQuartz on macOS with
# "Allow connections from network clients" enabled and `xhost +localhost`):
#   docker run -it --rm -e DISPLAY=host.docker.internal:0 hytrig julia hytrig_gui.jl
# On Linux instead:
#   docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix hytrig julia hytrig_gui.jl

FROM julia:1.10-bookworm

# Debian 12 (bookworm) ships Python 3.11 as python3.
# The remaining packages are the OpenGL/X11/xcb runtime libraries that the
# Qt6 binaries bundled by QML.jl need to load, plus build tools for CxxWrap.
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        build-essential \
        libgl1 \
        libopengl0 \
        libegl1 \
        libglu1-mesa \
        libglx-mesa0 \
        libx11-6 \
        libx11-xcb1 \
        libxext6 \
        libxrender1 \
        libxkbcommon0 \
        libxkbcommon-x11-0 \
        libxcb1 \
        libxcb-cursor0 \
        libxcb-glx0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render0 \
        libxcb-render-util0 \
        libxcb-shape0 \
        libxcb-shm0 \
        libxcb-sync1 \
        libxcb-xfixes0 \
        libxcb-xinerama0 \
        libxcb-xkb1 \
        libfontconfig1 \
        libfreetype6 \
        libdbus-1-3 \
    && rm -rf /var/lib/apt/lists/*

# Make `python` resolve to python3 as well.
RUN ln -s /usr/bin/python3 /usr/local/bin/python

WORKDIR /app

# Install Julia dependencies first so this layer is cached across source edits.
COPY Project.toml Manifest.toml ./
RUN julia --project=/app -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'

# Copy the rest of the project.
COPY . .

ENV JULIA_PROJECT=/app

# Interactive command-line model checker by default.
CMD ["julia", "hytrig_cli.jl"]
