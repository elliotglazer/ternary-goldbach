#!/bin/sh
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
sha256sum -c source_expected.sha256 > "${label}_source_precheck.log"
sha256sum -c cv01_output.sha256 > "${label}_benchmark_precheck.log"
sha256sum inspect_code.sml run_inspection.sh run_inspection_container.ps1 \
 source_expected.sha256 cv01_output.sha256 \
 .hol/objs/C10004TraversalCVTheory.uo .hol/objs/C10004TraversalCVTheory.dat \
 "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_inputs.sha256"
ulimit -v 4194304
phase () {
 key=$1; shift
 printf '%s\n' "$@" > "${label}_${key}.argv"
 set +e
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout -k 15 180 "$@" > "${label}_${key}.log" 2>&1
 status=$?
 set -e
 printf '%s\n' "$status" > "${label}_${key}.status"
 test "$status" -eq 0
}
phase build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 inspect_code.uo
phase inspect "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" inspect_code
test "$(grep -c '^CV_REACHABLE,' "${label}_inspect.log")" -eq 3
test "$(grep -c '^C10004_TRAVERSAL_CV_CODE_INSPECTION_DONE$' "${label}_inspect.log")" -eq 1
sha256sum -c "${label}_inputs.sha256" > "${label}_postcheck.log"
printf '%s\n' C10004_TRAVERSAL_CV_INSPECTION_RUN_COMPLETE
