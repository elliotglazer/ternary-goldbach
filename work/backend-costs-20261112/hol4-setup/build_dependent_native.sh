#!/bin/sh
set -eu
native_root="$(pwd)/../rocq-native-setup/sysroot"
./run.sh /usr/bin/time -v -o build_dependent_native.time \
  ./sysroot/usr/bin/g++ --sysroot="$(pwd)/sysroot" -O3 -std=c++17 \
  -I"$native_root/usr/include" dependent_native.cpp \
  "$native_root/usr/lib/libgmpxx.so.4.7.0" \
  "$native_root/usr/lib/libgmp.so.10.5.0" -o dependent_native
./run.sh /usr/bin/env LD_LIBRARY_PATH="$native_root/usr/lib:$(pwd)/sysroot/usr/lib:$(pwd)/sysroot/lib" \
  /usr/bin/time -v -o dependent_native.time \
  ./dependent_native 100 > dependent_native.log 2>&1
