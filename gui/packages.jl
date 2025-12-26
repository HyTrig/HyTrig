using Pkg

Pkg.activate(".")

Pkg.add("CxxWrap")
Pkg.compat("CxxWrap", "0.16")

dependencies = [
    "QML"
]

Pkg.add(dependencies)
