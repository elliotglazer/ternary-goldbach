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
sha256sum source_expected.sha256 RawPairRoundScript.sml Holmakefile run_proof.sh run_proof_container.ps1 > "${label}_source.sha256"
sha256sum "$stage"/.hol/objs/*Theory.uo "$stage"/.hol/objs/*Theory.dat "$stage"/.hol/objs/realLib.uo "$stage"/.hol/objs/RealField.uo "$setup/.hol/objs/BlockRoundTheory.uo" "$setup/.hol/objs/BlockRoundTheory.dat" "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_dependency.sha256"
ulimit -v 4194304
printf '%s\n' "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 RawPairRoundTheory.uo > "${label}_theory.argv"
set +e
"$setup/run.sh" /usr/bin/time -v -o "${label}_theory.time" timeout -k 15 600 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 RawPairRoundTheory.uo > "${label}_theory.log" 2>&1
status=$?
set -e
printf '%s\n' "$status" > "${label}_theory.status"
test "$status" -eq 0
test "$(grep -c '^RAW_PAIR_ROUND_ANALYTIC_BRIDGE_DONE$' "${label}_theory.log")" -eq 1
sha256sum .hol/objs/RawPairRoundTheory.uo .hol/objs/RawPairRoundTheory.dat > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_postcheck.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_postcheck.log"
printf '%s\n' RAW_PAIR_ROUND_PROOF_RUN_COMPLETE_REQUIRES_RELOAD_AUDIT
