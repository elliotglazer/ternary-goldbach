#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_setup="$task_base/hol4-setup"
task_hol="$task_setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
cd "$task_base/finite-hol"
"$task_setup/run.sh" /usr/bin/time -v -o benchmark_build.time \
  timeout 600 "$task_hol/bin/Holmake" -j2 primebench.exe > benchmark_build.log 2>&1
"$task_setup/run.sh" /usr/bin/time -v -o prime_run1.time \
  timeout 600 ./primebench.exe > prime_run1.log 2>&1
