#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_setup="$task_base/hol4-setup"
task_native="$task_base/rocq-native-setup/sysroot"
cd "$task_base/finite-hol"
test ! -e native_batch_build.log
"$task_setup/run.sh" /usr/bin/time -v -o native_batch_build.time \
  timeout 180 "$task_setup/sysroot/usr/bin/g++" --sysroot="$task_setup/sysroot" -O3 -std=c++17 \
  -I"$task_native/usr/include" native_batch.cpp "$task_native/usr/lib/libgmpxx.so.4.7.0" \
  "$task_native/usr/lib/libgmp.so.10.5.0" -o native_batch > native_batch_build.log 2>&1
for task_sample in 1 2 3; do
  test ! -e "native_batch_run$task_sample.log"
  "$task_setup/run.sh" /usr/bin/env LD_LIBRARY_PATH="$task_native/usr/lib:$task_setup/sysroot/usr/lib:$task_setup/sysroot/lib" \
    /usr/bin/time -v -o "native_batch_run$task_sample.time" \
    timeout 180 ./native_batch native_batch_data.txt 500 > "native_batch_run$task_sample.log" 2>&1
done
