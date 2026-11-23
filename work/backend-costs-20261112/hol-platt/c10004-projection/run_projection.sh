#!/bin/sh
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_projection.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for suffix in uo dat; do test -f "../c10004-transform/.hol/objs/C10004TransformTheory.$suffix"; done
sha256sum -c source_expected.sha256 > "${label}_precheck.log"
sha256sum source_expected.sha256 C10004ProjectionScript.sml projection_audit.sml Holmakefile run_projection.sh > "${label}_source.sha256"
sha256sum ../c10004-transform/.hol/objs/C10004TransformTheory.uo \
 ../c10004-transform/.hol/objs/C10004TransformTheory.dat \
 "$setup/.hol/objs/BlockRoundTheory.uo" "$setup/.hol/objs/BlockRoundTheory.dat" \
 "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_dependency.sha256"
ulimit -v 4194304
phase () {
 key=$1; shift
 printf '%s\n' "$@" > "${label}_${key}.argv"
 set +e
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout -k 15 600 "$@" > "${label}_${key}.log" 2>&1
 status=$?
 set -e
 printf '%s\n' "$status" > "${label}_${key}.status"
 test "$status" -eq 0
}
phase theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 C10004ProjectionTheory.uo
phase audit_build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 projection_audit.uo
phase audit "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" projection_audit
test "$(grep -c '^PROJECTION_THEOREM,' "${label}_audit.log")" -eq 5
test "$(grep -c '^C10004_PROJECTION_AUDIT_DONE_GENERIC_ONLY$' "${label}_audit.log")" -eq 1
sha256sum .hol/objs/C10004ProjectionTheory.uo .hol/objs/C10004ProjectionTheory.dat .hol/objs/projection_audit.uo > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_postcheck.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_postcheck.log"
printf '%s\n' 'C10004_PROJECTION_RUN_COMPLETE_REQUIRES_RESULT_REVIEW'
