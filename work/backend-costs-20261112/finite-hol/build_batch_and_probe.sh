#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
cd "$task_base/finite-hol"
sh build_cover_theory.sh batchprime_build06 BatchPrimeTheory.uo
sh batch_probe.sh
