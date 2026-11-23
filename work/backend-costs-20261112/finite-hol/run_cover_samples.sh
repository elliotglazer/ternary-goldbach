#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
cd "$task_base/finite-hol"
for task_sample in b2 b3; do
  test ! -e "cover_run$task_sample.log"
  "$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "cover_run$task_sample.time" \
    timeout 600 ./coverbench_balanced.exe > "cover_run$task_sample.log" 2>&1
  cp .hol/objs/FiniteCoverResultsTheory.dat "cover_sample$task_sample.dat"
done
sh build_cover_benchmark.sh cover_build02 2
