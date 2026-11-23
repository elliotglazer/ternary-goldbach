#!/bin/sh
# Root-only serialized generic construction. No concrete source evaluation.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_source.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
# mkdir supplies a fresh-label gate. A failure keeps this directory and all logs.
mkdir "${label}_run"
sha256sum -c source_run_inputs.sha256 > "${label}_run/input_precheck.log"
sha256sum source_run_inputs.sha256 > "${label}_run/manifest.sha256"
ulimit -v 4194304
ulimit -c 0
ulimit -f 32768
unset HOLBUILD
phase () {
 key=$1; shift
 test ! -e "${label}_run/${key}.time"
 printf '%s\n' "$@" > "${label}_run/${key}.argv"
 set +e
 "$setup/run.sh" /usr/bin/time -v -o "${label}_run/${key}.time" \
   timeout -k 15 600 "$@" > "${label}_run/${key}.log" 2>&1
 code=$?
 set -e
 printf '%s\n' "$code" > "${label}_run/${key}.exit"
 sha256sum -c source_run_inputs.sha256 > "${label}_run/${key}_input_postcheck.log"
 test "$code" -eq 0 || exit "$code"
}
phase theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 SourceArithmeticTheory.uo
phase audit_build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 source_audit.exe
phase audit ./source_audit.exe
test "$(grep -c '^SOURCE_THEOREM,' "${label}_run/audit.log")" -eq 3
test "$(grep -c '^SOURCE_AUDIT_DONE_GENERIC_ONLY_NO_ANALYTIC_PRODUCER$' "${label}_run/audit.log")" -eq 1
sha256sum .hol/objs/SourceArithmeticTheory.uo .hol/objs/SourceArithmeticTheory.dat \
 source_audit.exe > "${label}_run/outputs.sha256"
sha256sum -c "${label}_run/manifest.sha256" > "${label}_run/manifest_postcheck.log"
printf '%s\n' 'SOURCE_GENERIC_CONSTRUCTION_AND_AUDIT_PASS_NO_THROUGHPUT_CLAIM'
