#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
cd "$task_base/finite-hol"
for task_sample in r2 r3; do
  test ! -e "batch_cover_run$task_sample.log"
  "$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "batch_cover_run$task_sample.time" \
    timeout 600 ./batchrootscoverbench.exe > "batch_cover_run$task_sample.log" 2>&1
  cp .hol/objs/BatchRootsCoverResultsTheory.dat "batch_cover_sample$task_sample.dat"
done
