#!/bin/sh
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
stage=../raw-analytic/dependency-build-win01
sha256sum -c source_expected.sha256 > "${label}_precheck.log"
sha256sum source_expected.sha256 SourceLogRangeScript.sml range_audit.sml Holmakefile \
 run_range.sh run_range_container.ps1 > "${label}_source.sha256"
sha256sum ../source-log-horner/.hol/objs/SourceLogHornerTheory.uo ../source-log-horner/.hol/objs/SourceLogHornerTheory.dat \
 ../source-producer/.hol/objs/SourceArithmeticTheory.uo ../source-producer/.hol/objs/SourceArithmeticTheory.dat \
 ../source-log-real/.hol/objs/SourceLogTailTheory.uo ../source-log-real/.hol/objs/SourceLogTailTheory.dat \
 ../raw-pair-round-proof/.hol/objs/RawPairRoundTheory.uo ../raw-pair-round-proof/.hol/objs/RawPairRoundTheory.dat \
 "$setup/.hol/objs/BlockRoundTheory.uo" "$setup/.hol/objs/BlockRoundTheory.dat" \
 "$stage"/.hol/objs/*Theory.uo "$stage"/.hol/objs/*Theory.dat \
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
phase theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 SourceLogRangeTheory.uo
phase build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 range_audit.uo
phase audit "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" range_audit
test "$(grep -c '^SOURCE_LOG_RANGE_TYPE,' "${label}_audit.log")" -eq 4
test "$(grep -c '^SOURCE_LOG_RANGE_ROOT,' "${label}_audit.log")" -eq 11
test "$(grep -c '^SOURCE_LOG_RANGE_EXACT_AUDIT_DONE$' "${label}_audit.log")" -eq 1
sha256sum .hol/objs/SourceLogRangeTheory.uo .hol/objs/SourceLogRangeTheory.dat .hol/objs/range_audit.uo > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_postcheck.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_postcheck.log"
printf '%s\n' SOURCE_LOG_RANGE_ERROR_RUN_COMPLETE_REQUIRES_REVIEW
