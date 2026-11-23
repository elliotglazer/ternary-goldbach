#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_setup="$task_base/hol4-setup"
task_hol="$task_setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
cd "$task_hol/examples/algebra/primality"
"$task_setup/run.sh" /usr/bin/time -v -o "$task_base/finite-hol/prime_support_build.time" \
  timeout 900 "$task_hol/bin/Holmake" -j2 primeCertificateLib.uo \
  > "$task_base/finite-hol/prime_support_build.log" 2>&1
