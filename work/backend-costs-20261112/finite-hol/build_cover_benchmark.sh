#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_setup="$task_base/hol4-setup"
task_hol="$task_setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
cd "$task_base/finite-hol"
task_label="${1:-cover_build01}"
task_program="${3:-coverbench}"
test ! -e "$task_label.log"
"$task_setup/run.sh" /usr/bin/time -v -o "$task_label.time" \
  timeout 600 "$task_hol/bin/Holmake" -j1 "$task_program.exe" > "$task_label.log" 2>&1
task_sample="${2:-1}"
test ! -e "cover_run$task_sample.log"
"$task_setup/run.sh" /usr/bin/time -v -o "cover_run$task_sample.time" \
  timeout 600 "./$task_program.exe" > "cover_run$task_sample.log" 2>&1
cp .hol/objs/FiniteCoverResultsTheory.dat "cover_sample$task_sample.dat"
