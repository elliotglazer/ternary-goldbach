#!/bin/sh
# Prepared only. Root authorizes and launches after independent source review.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
PYTHON=${PYTHON:-python3}
setup="$(pwd)/../hol4-setup"
pa="$(pwd)/../mm0-pa"
checker="$(pwd)/../../formal-goldbach-bench/mm0/mm0-timed"
profiler="$(pwd)/../../formal-goldbach-bench/mm0/mm0-profile"
highwater="$(pwd)/../../formal-goldbach-bench/mm0/mm0-highwater"
test -f "$checker" && test -f "$pa/mm0-rs" && test -f "$profiler" && test -f "$highwater"
for n in 0 7 64; do
  for f in "signed$n.mm0" "signed$n.mm1" "direct$n.mmb" "frontend$n.mmb" \
    "spec$n.json" "frontend$n.json" "direct$n.json" "direct$n.audit.json" "frontend$n.audit.json"; do
    test ! -e "$f" || { echo "existing artifact: $f" >&2; exit 2; }
  done
done
sha256sum mmb.py prepare.py audit.py unit_format.py run.sh summarize.py \
  "$pa/fourbit0.mmb" "$pa/fourbit0.join.mm0" "$pa/arithmetic.mm1" \
  "$pa/arithmetic4.mm1" "$pa/mm0-rs" "$checker" "$profiler" "$highwater" \
  ../../lean-pilots/batched-transform/P343N64.json > "${label}_inputs.sha256"
ulimit -v 10485760
export RUST_MIN_STACK=33554432
phase () {
  key=$1; shift
  printf '%s\n' "$@" > "${label}_${key}.argv"
  set +e
  "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" \
    timeout 600 "$@" > "${label}_${key}.log" 2>&1
  status=$?
  set -e
  printf '%s\n' "$status" > "${label}_${key}.exit"
  test "$status" -eq 0 || exit "$status"
}
phase tiny_format "$PYTHON" unit_format.py
for n in 0 7 64; do
  phase "spec$n" "$PYTHON" prepare.py spec "$n"
  phase "frontend_source$n" "$PYTHON" prepare.py frontend "$n"
  phase "direct_source$n" "$PYTHON" prepare.py direct "$n"
  phase "frontend_compile$n" "$pa/mm0-rs" compile -W "signed$n.mm1" "frontend$n.mmb"
  for arm in direct frontend; do
    if test "$n" -eq 64; then
      phase "audit_${arm}$n" "$PYTHON" audit.py "$arm" "$n" --controls
    else
      phase "audit_${arm}$n" "$PYTHON" audit.py "$arm" "$n"
    fi
    sha256sum "${arm}${n}.mmb" "signed$n.mm0" "signed$n.mm1" \
      "spec$n.json" "frontend$n.json" "direct$n.json" "${arm}${n}.audit.json" \
      > "${label}_${arm}${n}_artifacts.sha256"
    repeats='1 2 3 4 5'
    if test "$n" -eq 7; then repeats='1'; fi
    for repeat in $repeats; do
      phase "check_${arm}${n}_$repeat" "$checker" "${arm}${n}.mmb" < "signed$n.mm0"
    done
    if test "$n" -ne 7; then
      phase "profile_${arm}${n}" "$profiler" "${arm}${n}.mmb" < "signed$n.mm0"
      phase "highwater_${arm}${n}" "$highwater" "${arm}${n}.mmb" < "signed$n.mm0"
    fi
  done
done
sha256sum direct64_bad_input.mm0 direct64_bad_sign.mm0 direct64_bad_result.mm0 \
  direct64_bad_proof.mmb direct64_bad_sign_conversion.mmb \
  frontend64_bad_input.mm0 frontend64_bad_sign.mm0 frontend64_bad_result.mm0 \
  frontend64_bad_proof.mmb frontend64_bad_sign_conversion.mmb \
  > "${label}_controls.sha256"
for arm in direct frontend; do
  for bad in input sign result proof sign_conversion; do
    binary="${arm}64.mmb";spec=signed64.mm0
    case "$bad" in proof|sign_conversion) binary="${arm}64_bad_${bad}.mmb";; *) spec="${arm}64_bad_${bad}.mm0";; esac
    printf '%s\n' "$checker" "$binary" "stdin=$spec" > "${label}_reject_${arm}_${bad}.argv"
    # Expected rejection, excluding timeout/kill as evidence of rejection.
    set +e
    "$setup/run.sh" /usr/bin/time -v -o "${label}_reject_${arm}_${bad}.time" \
      timeout 120 "$checker" "$binary" < "$spec" > "${label}_reject_${arm}_${bad}.log" 2>&1
    status=$?
    set -e
    printf '%s\n' "$status" > "${label}_reject_${arm}_${bad}.exit"
    case "$status" in 1|255) :;; *) echo 'nonlogical rejection status' >&2; exit 2;; esac
    log="${label}_reject_${arm}_${bad}.log"
    ! grep -Eiq 'overflow|out of memory|allocation|killed|timeout|resource limit|cannot allocate|segmentation' "$log"
    grep -Eq 'MM0_REJECT: (unify failure at (term|ref)|type mismatch|Refl unify failure)' "$log"
  done
done
sha256sum -c "${label}_inputs.sha256" > "${label}_inputs_unchanged.log"
for manifest in "${label}_controls.sha256" "${label}"_*_artifacts.sha256; do
  sha256sum -c "$manifest" > "${manifest%.sha256}_unchanged.log"
done
printf '%s\n' ALL_REQUIRED_PHASES_COMPLETED > "${label}_RUN_COMPLETE"
"$PYTHON" summarize.py "$label" > "${label}_collection.log"
