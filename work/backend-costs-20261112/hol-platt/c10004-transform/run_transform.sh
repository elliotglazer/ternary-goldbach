#!/bin/sh
# Root-only, source-reviewed diagnostics. No dependency rebuilding.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_transform.sh fresh_label small_or_full}
mode=${2:?usage: sh run_transform.sh fresh_label small_or_full}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$mode" in small) theory=C10004TransformSmallDiagnostics; title=Small;;
  full) theory=C10004TransformFullDiagnostics; title=Full;; *) exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
sha256sum -c SOURCE_MANIFEST.sha256 > "${label}_prepared_source_check.log"
test ! -e ".hol/objs/${theory}Theory.dat"
for base in BlockRound StageCheck; do
  test -f "$setup/.hol/objs/${base}Theory.uo"
  test -f "$setup/.hol/objs/${base}Theory.dat"
done
sha256sum SOURCE_MANIFEST.sha256 C10004TransformScript.sml C10004TransformTestsScript.sml \
  transform_audit.sml Holmakefile run_transform.sh > "${label}_source.sha256"
sha256sum "$setup/.hol/objs/BlockRoundTheory.uo" \
  "$setup/.hol/objs/BlockRoundTheory.dat" \
  "$setup/.hol/objs/StageCheckTheory.uo" \
  "$setup/.hol/objs/StageCheckTheory.dat" "$setup/run.sh" \
  "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_dependency.sha256"
for file in .hol/objs/C10004TransformTheory.uo \
  .hol/objs/C10004TransformTestsTheory.uo transform_audit.exe; do
  if test -f "$file"; then sha256sum "$file"; else printf 'ABSENT %s\n' "$file"; fi
done > "${label}_prior_artifacts.txt"
ulimit -v 4194304
phase () {
  key=$1; shift
  printf '%s\n' "$@" > "${label}_${key}.argv"
  set +e
  "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" \
    timeout 900 "$@" > "${label}_${key}.log" 2>&1
  status=$?
  set -e
  printf '%s\n' "$status" > "${label}_${key}.status"
  test "$status" -eq 0
}
phase theory "$hol/bin/Holmake" --no_prereqs C10004TransformTestsTheory.uo
phase audit_build "$hol/bin/Holmake" --no_prereqs transform_audit.exe
phase audit env C10004_TRANSFORM_MODE="$mode" ./transform_audit.exe
if test "$mode" = small; then expected=10; else expected=16; fi
test "$(grep -c '^TRANSFORM_CONTROL,' "${label}_audit.log")" -eq "$expected"
grep -q "^C10004_TRANSFORM_${title}_DIAGNOSTICS_DONE_INTEGER_ONLY$" \
  "${label}_audit.log"
sha256sum .hol/objs/C10004TransformTheory.uo \
  .hol/objs/C10004TransformTheory.dat \
  .hol/objs/C10004TransformTestsTheory.uo \
  .hol/objs/C10004TransformTestsTheory.dat transform_audit.exe \
  ".hol/objs/${theory}Theory.dat" > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_check.log"
printf '%s\n' 'C10004_TRANSFORM_RUN_COMPLETE_REQUIRES_RESULT_REVIEW'
