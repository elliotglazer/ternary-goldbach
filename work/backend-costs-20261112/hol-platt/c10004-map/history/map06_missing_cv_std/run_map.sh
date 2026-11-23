#!/bin/sh
# Root-only launch, after source review. No dependency rebuilds.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_map.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for f in "$hol/src/sort/.hol/objs/sortingTheory.uo" "$hol/src/num/extra_theories/.hol/objs/gcdTheory.uo"; do test -f "$f"; done
sha256sum C10004MapScript.sml map_audit.sml propose_map.py Holmakefile run_map.sh > "${label}_source.sha256"
sha256sum "$hol/src/sort/.hol/objs/sortingTheory.uo" "$hol/src/sort/.hol/objs/sortingTheory.dat" \
 "$hol/src/num/extra_theories/.hol/objs/gcdTheory.uo" "$hol/src/num/extra_theories/.hol/objs/gcdTheory.dat" \
 "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_dependency.sha256"
ulimit -v 4194304
phase () {
 key=$1; shift
 test ! -e "${label}_${key}.time"
 printf '%s\n' "$@" > "${label}_${key}.argv"
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout 600 "$@" > "${label}_${key}.log" 2>&1
}
phase theory "$hol/bin/Holmake" --no_prereqs C10004MapTheory.uo
phase audit_build "$hol/bin/Holmake" --no_prereqs map_audit.exe
phase audit ./map_audit.exe
grep -q '^C10004_MAP_AUDIT_DONE_NO_CHARACTER_SEMANTICS$' "${label}_audit.log"
sha256sum .hol/objs/C10004MapTheory.uo .hol/objs/C10004MapTheory.dat map_audit.exe > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_check.log"
printf '%s\n' 'C10004_RUN_FINISHED_REQUIRES_RECEIPT_REVIEW'
