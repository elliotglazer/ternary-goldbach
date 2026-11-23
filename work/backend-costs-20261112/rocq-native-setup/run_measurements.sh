#!/bin/sh
set -eu
# Keep shell variables in a file. An earlier inline WSL launch expanded the
# log suffix before the inner loop, so only its final samples were retained.
for sample in 1 2 3
do
  /usr/bin/time -v ./run-native.sh rocq c -q NativeP343N64.v \
    > "native_sample_${sample}.log" 2> "native_sample_${sample}.time"
done
for sample in 1 2 3
do
  /usr/bin/time -v ./run-native.sh rocq c -q VmP343N64.v \
    > "vm_sample_${sample}.log" 2> "vm_sample_${sample}.time"
done
