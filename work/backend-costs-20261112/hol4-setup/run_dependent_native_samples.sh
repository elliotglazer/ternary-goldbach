#!/bin/sh
set -eu
native_root="$(pwd)/../rocq-native-setup/sysroot"
for sample in 1 2 3; do
  ./run.sh /usr/bin/env LD_LIBRARY_PATH="$native_root/usr/lib:$(pwd)/sysroot/usr/lib:$(pwd)/sysroot/lib" \
    /usr/bin/time -v -o "dependent_native_sample_${sample}.time" \
    ./dependent_native 1000 > "dependent_native_sample_${sample}.log" 2>&1
done
