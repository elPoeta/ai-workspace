#!/usr/bin/env bash
set -e

# PUT THIS SCRIPT INSIDE ~/AI/llama
#
# Usage:
#   ./build.sh          -> CUDA
#   ./build.sh cpu      -> CPU
#
# INSTALL C AND C++ COMPILER V15 FOR FEDORA 44 UNTIL CUDA TOOLKIT
# ADD V16 COMPATIBILITY
#
# sudo dnf install gcc15 gcc15-c++

BUILD_MODE="${1:-cuda}"

case "$BUILD_MODE" in
    cpu)
        echo "=== Building llama.cpp with CPU ==="

        rm -rf llama.cpp
        git clone git@github.com:ggml-org/llama.cpp.git

        cd llama.cpp

        export CC=/usr/bin/gcc-15
        export CXX=/usr/bin/g++-15

        cmake -B build \
            -DGGML_CUDA=OFF \
            -DCMAKE_C_COMPILER=/usr/bin/gcc-15 \
            -DCMAKE_CXX_COMPILER=/usr/bin/g++-15

        cmake --build build -j"$(nproc)"
        ;;

    cuda)
        echo "=== Building llama.cpp with CUDA ==="

        rm -rf llama.cpp
        git clone git@github.com:ggml-org/llama.cpp.git

        cd llama.cpp

        export CC=/usr/bin/gcc-15
        export CXX=/usr/bin/g++-15
        export CUDAHOSTCXX=/usr/bin/g++-15

        cmake -B build \
            -DGGML_CUDA=ON \
            -DCMAKE_C_COMPILER=/usr/bin/gcc-15 \
            -DCMAKE_CXX_COMPILER=/usr/bin/g++-15 \
            -DCMAKE_CUDA_HOST_COMPILER=/usr/bin/g++-15 \
            -DCMAKE_CUDA_ARCHITECTURES=120

        cmake --build build -j"$(nproc)"
        ;;

    *)
        echo "Usage: $0 [cpu]"
        echo
        echo "  $0       Build with CUDA (default)"
        echo "  $0 cpu   Build with CPU"
        exit 1
        ;;
esac

echo
echo "=== Build completed: $BUILD_MODE ==="
