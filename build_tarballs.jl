# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

# Collection of sources required to build BisonBuilder
sources = [
    "https://ftp.gnu.org/gnu/bison/bison-3.0.5.tar.xz" =>
    "075cef2e814642e30e10e8155e93022e4a91ca38a65aa1d5467d4e969f97f338",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd bison-3.0.5/
./configure --prefix=$prefix --host=$target
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, :glibc),
    Linux(:x86_64, :glibc),
    Linux(:aarch64, :glibc),
    Linux(:armv7l, :glibc, :eabihf),
    Linux(:powerpc64le, :glibc),
    Linux(:i686, :musl),
    Linux(:x86_64, :musl),
    Linux(:aarch64, :musl),
    Linux(:armv7l, :musl, :eabihf),
    MacOS(:x86_64),
    FreeBSD(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    ExecutableProduct(prefix, "", :bison)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "BisonBuilder", sources, script, platforms, products, dependencies)

