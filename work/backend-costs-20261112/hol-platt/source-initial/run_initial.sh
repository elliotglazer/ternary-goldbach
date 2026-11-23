#!/bin/sh
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
stage=../raw-analytic/dependency-build-win01
test -f ../raw-pair-round-proof/.hol/objs/RawPairRoundTheory.uo
test -f ../raw-pair-round-proof/.hol/objs/RawPairRoundTheory.dat
sha256sum -c source_expected.sha256 > "${label}_precheck.log"
sha256sum source_expected.sha256 SourceInitialScript.sml initial_audit.sml Holmakefile \
 run_initial.sh run_initial_container.ps1 > "${label}_source.sha256"
sha256sum ../source-inverse-root/.hol/objs/SourceInverseRootTheory.uo ../source-inverse-root/.hol/objs/SourceInverseRootTheory.dat ../source-state-error/.hol/objs/SourceStateErrorTheory.uo ../source-state-error/.hol/objs/SourceStateErrorTheory.dat ../source-producer/.hol/objs/SourceArithmeticTheory.uo ../source-producer/.hol/objs/SourceArithmeticTheory.dat ../raw-pair-round-proof/.hol/objs/RawPairRoundTheory.uo ../raw-pair-round-proof/.hol/objs/RawPairRoundTheory.dat "$stage"/.hol/objs/*Theory.uo "$stage"/.hol/objs/*Theory.dat \
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
phase theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 SourceInitialTheory.uo
phase build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 initial_audit.uo
phase audit "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" initial_audit
test "$(grep -c '^SOURCE_INITIAL_ROOT,' "${label}_audit.log")" -eq 7
test "$(grep -c '^SOURCE_INITIAL_EXACT_AUDIT_DONE$' "${label}_audit.log")" -eq 1
sha256sum .hol/objs/SourceInitialTheory.uo .hol/objs/SourceInitialTheory.dat .hol/objs/initial_audit.uo > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_postcheck.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_postcheck.log"
printf '%s\n' SOURCE_INITIAL_ERROR_RUN_COMPLETE_REQUIRES_REVIEW
