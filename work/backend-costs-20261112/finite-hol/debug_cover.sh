#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_setup="$task_base/hol4-setup"
cd "$task_base/finite-hol"
"$task_setup/run.sh" timeout 90 "$task_setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/bin/hol" \
  --holstate=FiniteCover.checked_cover_sound.dumpedheap < debug_cover.sml > debug_cover.log 2>&1
