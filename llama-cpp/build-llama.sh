#!/usr/bin/env bash
set -e

# PUT THIS SCRIPT INSIDE ~/AI/llama

# INSTALL C AND C++ COMPILER V15 FOR FEDORA 44 UNTIL CUDA TOOLKIT ADD V16 COMPATIBILITY
# sudo dnf install gcc15 gcc15-c++

sudo rm -r llama.cpp

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

cmake --build build -j$(nproc)
