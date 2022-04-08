#!/bin/sh

# Build and install abseil-cpp
set -o errexit
set -o verbose
sudo apt-get install stow

cd abseil-cpp
git checkout d902eb869bcfacc1bad14933ed9af4bed006d481
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_INSTALL_PREFIX=/usr/local/stow/absl \
  ..
ninja
sudo ninja install
cd /usr/local/stow
sudo stow absl


# Build and install Ceres.
cd -
cd ../../ceres-solver
mkdir build
cd build
cmake .. -G Ninja -DCXX11=ON
ninja
#CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install

# Build and install proto3.
cd ../../protobuf
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -Dprotobuf_BUILD_TESTS=OFF \
  ../cmake
ninja
sudo ninja install

# Build and install Cartographer.
cd ../../cartographer
mkdir build
cd build
cmake .. -G Ninja
ninja
#CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install

