#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_mm0="$task_base/mm0-pa"
task_case="$1"
task_run=/dev/shm/goldbach-mm0-pa-runs
mkdir -p "$task_run"
export RUST_MIN_STACK=33554432
export TMPDIR=/dev/shm/goldbach-mm0-pa-tmp
cd "$task_mm0"
case "$task_case" in
  *_all) cp "${task_case%_all}.mmb" "$task_run/" ;;
esac
"$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "$task_case.compile.time" \
  timeout 600 ./mm0-rs compile -W "$task_case.mm1" "$task_run/$task_case.mmb" \
  > "$task_case.compile.log" 2>&1
./mm0-rs join "$task_case.mm0" > "$task_run/$task_case.join.mm0"
cp "$task_run/$task_case.mmb" "$task_run/$task_case.join.mm0" "$task_mm0/"
"$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "$task_case.check.time" \
  timeout 120 "$task_base/../formal-goldbach-bench/mm0/mm0-timed" "$task_run/$task_case.mmb" \
  < "$task_run/$task_case.join.mm0" > "$task_case.check.log" 2>&1
cat "$task_case.compile.log" "$task_case.check.log"
