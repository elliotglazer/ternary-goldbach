#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_setup="$task_base/hol4-setup"
task_hol="$task_setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
cd "$task_base/finite-hol"
task_label="${1:-cover_theory_build}"
task_target="${2:-FiniteCoverTheory.uo}"
test ! -e "$task_label.log"
"$task_setup/run.sh" /usr/bin/time -v -o "$task_label.time" \
  timeout 600 "$task_hol/bin/Holmake" -j1 "$task_target" > "$task_label.log" 2>&1
