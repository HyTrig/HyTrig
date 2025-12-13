using Pkg

Pkg.activate(".")

dependencies = [
    "CxxWrap",
    "QML"
]

Pkg.add(dependencies)
