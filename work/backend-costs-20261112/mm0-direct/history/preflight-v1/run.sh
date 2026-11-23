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
for f in signed0.mm0 signed64.mm0 direct0.mmb direct64.mmb frontend0.mmb frontend64.mmb; do
  test ! -e "$f" || { echo "existing artifact: $f" >&2; exit 2; }
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
  "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" \
    timeout 600 "$@" > "${label}_${key}.log" 2>&1
}
phase tiny_format "$PYTHON" unit_format.py
for n in 0 64; do
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
    sha256sum "${arm}${n}.mmb" "signed$n.mm0" > "${label}_${arm}${n}_artifacts.sha256"
    for repeat in 1 2 3 4 5; do
      phase "check_${arm}${n}_$repeat" "$checker" "${arm}${n}.mmb" < "signed$n.mm0"
    done
    phase "profile_${arm}${n}" "$profiler" "${arm}${n}.mmb" < "signed$n.mm0"
    phase "highwater_${arm}${n}" "$highwater" "${arm}${n}.mmb" < "signed$n.mm0"
  done
done
for arm in direct frontend; do
  for bad in input sign result proof; do
    binary="${arm}64.mmb";spec=signed64.mm0
    if test "$bad" = proof; then binary="${arm}64_bad_proof.mmb"; else spec="${arm}64_bad_${bad}.mm0"; fi
    # Expected rejection, excluding timeout/kill as evidence of rejection.
    set +e
    "$setup/run.sh" /usr/bin/time -v -o "${label}_reject_${arm}_${bad}.time" \
      timeout 120 "$checker" "$binary" < "$spec" > "${label}_reject_${arm}_${bad}.log" 2>&1
    status=$?
    set -e
    printf '%s\n' "$status" > "${label}_reject_${arm}_${bad}.exit"
    test "$status" -ne 0 && test "$status" -ne 124 && test "$status" -ne 137
  done
done
sha256sum -c "${label}_inputs.sha256" > "${label}_inputs_unchanged.log"
phase summary "$PYTHON" summarize.py "$label"
