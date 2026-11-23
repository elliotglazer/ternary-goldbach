#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_mm0="$task_base/mm0-pa"
task_run=/dev/shm/goldbach-mm0-pa-replay
mkdir -p "$task_run"
cp "$task_base/../formal-goldbach-bench/mm0/mm0-timed" "$task_base/../formal-goldbach-bench/mm0/mm0-profile" "$task_run/"
cd "$task_mm0"
for task_case in products0 products1 products8 products16 products32 fourbit0 fourbit8 fourbit32 fourbit64 fourbit64_all; do
  "$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "$task_case.copy.time" \
    cp "$task_case.mmb" "$task_case.join.mm0" "$task_run/"
  for task_rep in 1 2 3 4 5; do
    "$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "$task_case.replay$task_rep.time" \
      timeout 120 "$task_run/mm0-timed" "$task_run/$task_case.mmb" \
      < "$task_run/$task_case.join.mm0" > "$task_case.replay$task_rep.log" 2>&1
  done
  "$task_run/mm0-profile" "$task_run/$task_case.mmb" < "$task_run/$task_case.join.mm0" \
    > "$task_case.profile.log" 2>&1
  printf '%s complete\n' "$task_case"
done
for task_control in bad_input bad_result bad_conclusion; do
  cp "$task_control.mm0" "$task_run/"
  set +e
  timeout 120 "$task_run/mm0-timed" "$task_run/fourbit64.mmb" < "$task_run/$task_control.mm0" \
    > "$task_control.check.log" 2>&1
  task_status=$?
  set -e
  printf '%s\n' "$task_status" > "$task_control.exit"
  [ "$task_status" -ne 0 ] && [ "$task_status" -ne 124 ]
  grep -q MM0_REJECT "$task_control.check.log"
done
cp bad_proof.mmb "$task_run/"
set +e
timeout 120 "$task_run/mm0-timed" "$task_run/bad_proof.mmb" < "$task_run/fourbit64.join.mm0" \
  > bad_proof.check.log 2>&1
task_status=$?
set -e
printf '%s\n' "$task_status" > bad_proof.exit
[ "$task_status" -ne 0 ] && [ "$task_status" -ne 124 ]
grep -q MM0_REJECT bad_proof.check.log
printf 'all controls rejected\n'
