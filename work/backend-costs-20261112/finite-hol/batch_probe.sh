#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_setup="$task_base/hol4-setup"
cd "$task_base/finite-hol"
task_label="${1:-batch_probe}"
test ! -e "$task_label.log"
"$task_setup/run.sh" /usr/bin/time -v -o "$task_label.time" \
  timeout 90 "$task_setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/bin/hol" \
  < batch_probe.sml > "$task_label.log" 2>&1
