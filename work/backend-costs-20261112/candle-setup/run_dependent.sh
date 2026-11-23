#!/bin/sh
set -eu
case "${1:-}" in
  0|1|2) sample="$1" ;;
  *) printf 'Expected fresh sample 0, 1 or 2.\n'; exit 2 ;;
esac
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112/candle-setup
for ext in log time sexp exit coordinates.csv; do
  if test -e "$task_base/dependent_sample_$sample.$ext"; then
    printf 'Refusing to overwrite a recorded sample.\n'; exit 3
  fi
done
cd "$task_base/candle-6a9acd58867610c78fee0f3dd9ed4c4c14087b18/candle/build"
export CML_HEAP_SIZE=3072
export CML_STACK_SIZE=1024
export CANDLE_KERNEL_OUTPUT="$task_base/dependent_sample_$sample.sexp"
set +e
/usr/bin/time -v -o "$task_base/dependent_sample_$sample.time" \
  timeout 600 ./cake-export --candle < "$task_base/reproduce_dependent.ml" \
  > "$task_base/dependent_sample_$sample.log" 2>&1
sample_status=$?
set -e
printf '%s\n' "$sample_status" > "$task_base/dependent_sample_$sample.exit"
if test -f "$task_base/dependent_coordinates.csv"; then
  cp "$task_base/dependent_coordinates.csv" "$task_base/dependent_sample_$sample.coordinates.csv"
fi
printf 'Candle dependent sample %s exited %s.\n' "$sample" "$sample_status"
exit "$sample_status"
