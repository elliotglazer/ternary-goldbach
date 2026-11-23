#!/bin/sh
# Root-only, serialized run. Existing map theory must already be accepted/built.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_layout.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for suffix in uo dat; do test -f "../c10004-map/.hol/objs/C10004MapTheory.$suffix"; done
sha256sum -c source_expected.sha256 > "${label}_source_preflight.log"
sha256sum C10004LayoutScript.sml layout_audit.sml Holmakefile run_layout.sh source_expected.sha256 \
 > "${label}_source.sha256"
sha256sum ../c10004-map/C10004MapScript.sml ../c10004-map/.hol/objs/C10004MapTheory.uo \
 ../c10004-map/.hol/objs/C10004MapTheory.dat \
 "$hol/src/sort/.hol/objs/sortingTheory.uo" "$hol/src/sort/.hol/objs/sortingTheory.dat" \
 "$hol/src/num/extra_theories/.hol/objs/gcdTheory.uo" "$hol/src/num/extra_theories/.hol/objs/gcdTheory.dat" \
 "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_dependency.sha256"
ulimit -v 4194304
phase () {
 key=$1; shift
 test ! -e "${label}_${key}.time"
 printf '%s\n' "$@" > "${label}_${key}.argv"
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout 600 "$@" \
  > "${label}_${key}.log" 2>&1
}
phase theory "$hol/bin/Holmake" --no_prereqs C10004LayoutTheory.uo
phase audit_build "$hol/bin/Holmake" --no_prereqs layout_audit.exe
phase audit ./layout_audit.exe
test "$(grep -c '^C10004_LAYOUT_AUDIT_DONE_NO_CHARACTER_DFT_ANALYTICS$' "${label}_audit.log")" -eq 1
test "$(grep -c '^C10004_LAYOUT_THEOREM,' "${label}_audit.log")" -eq 8
sha256sum .hol/objs/C10004LayoutTheory.uo .hol/objs/C10004LayoutTheory.dat layout_audit.exe \
 > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_check.log"
printf '%s\n' 'C10004_LAYOUT_RUN_FINISHED_REQUIRES_RECEIPT_REVIEW'
