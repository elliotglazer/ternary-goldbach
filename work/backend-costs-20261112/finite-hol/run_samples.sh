#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
cd "$task_base/finite-hol"
cp .hol/objs/PrimeCertificateResultsTheory.dat prime_sample1.dat
for task_sample in 2 3; do
  "$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "prime_run$task_sample.time" \
    timeout 600 ./primebench.exe > "prime_run$task_sample.log" 2>&1
  cp .hol/objs/PrimeCertificateResultsTheory.dat "prime_sample$task_sample.dat"
done
