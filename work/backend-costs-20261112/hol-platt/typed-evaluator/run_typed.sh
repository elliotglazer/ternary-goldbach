#!/bin/sh
# Root execution only. No dependency builds, installed edits or trusted fast path.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_typed.sh fresh_label [build|smoke|full]}
mode=${2:-smoke}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$mode" in build) samples=0;; smoke) samples=1;; full) samples=3;; *) exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for name in StageCheck BlockRound DependentBlock; do
  test -f "$setup/.hol/objs/${name}Theory.uo"
  test -f "$setup/.hol/objs/${name}Theory.dat"
done
sha256sum -c source_expected.sha256 > "${label}_source_preflight.log" 2>&1
sha256sum TypedBlock.sml TypedWorkload.sml TypedStockCompute.sml TypedCvConfig.sml \
 typed_dependent.sml prepare_harness.py verify_sources.py validate_log.py validate_log.awk \
 source_binding.json source_expected.sha256 Holmakefile run_typed.sh \
 "$setup/dependent.sml" "$setup/DependentBlockScript.sml" "$setup/BlockRoundScript.sml" \
 "$setup/StageCheckScript.sml" "$hol/src/thm/Compute.sml" "$hol/src/thm/Thm.sml" \
 > "${label}_sources.sha256"
for name in StageCheck BlockRound DependentBlock; do
 sha256sum "$setup/.hol/objs/${name}Theory.uo" "$setup/.hol/objs/${name}Theory.dat"
done > "${label}_dependencies.sha256"
sha256sum "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_toolchain.sha256"
ulimit -v 4194304
phase () {
 key=$1; shift
 test ! -e "${label}_${key}.time"
 printf '%s\n' "$@" > "${label}_${key}.argv"
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" \
   timeout 600 "$@" > "${label}_${key}.log" 2>&1
}
phase build "$hol/bin/Holmake" --no_prereqs typed_dependent.exe
sha256sum typed_dependent.exe > "${label}_executable.sha256"
for sample in 1 2 3; do
 test "$sample" -le "$samples" || break
 case "$sample" in 1|3) orders='stock-first typed-first';; 2) orders='typed-first stock-first';; esac
 for order in $orders; do
  phase "${order}_${sample}" /usr/bin/env "TYPED_ORDER=$order" ./typed_dependent.exe
  "$setup/run.sh" awk -v "order=$order" -f validate_log.awk \
    "${label}_${order}_${sample}.log" > "${label}_${order}_${sample}_validated.log" 2>&1
  test ! -e "${label}_${order}_${sample}.dat"
  cp .hol/objs/TypedDependentResultsTheory.dat "${label}_${order}_${sample}.dat"
 done
done
sha256sum -c "${label}_sources.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_dependencies.sha256" > "${label}_dependency_check.log"
sha256sum -c "${label}_toolchain.sha256" > "${label}_toolchain_check.log"
sha256sum -c "${label}_executable.sha256" > "${label}_executable_check.log"
printf '%s\n' 'TYPED_RUN_FINISHED_REQUIRES_RESULT_AUDIT'
