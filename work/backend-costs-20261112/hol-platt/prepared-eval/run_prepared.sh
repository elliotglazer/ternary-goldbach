#!/bin/sh
# Root runs only after source review; no dependency builds.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_prepared.sh fresh_label [smoke|full]}
size=${2:-smoke}
case "$label" in *[!A-Za-z0-9_]*|'') echo 'invalid label' >&2; exit 2;; esac
case "$size" in smoke) samples=1;; full) samples=3;; *) exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for name in StageCheck BlockRound DependentBlock; do
  test -f "$setup/.hol/objs/${name}Theory.uo"
  test -f "$setup/.hol/objs/${name}Theory.dat"
done
sha256sum PreparedEval.sml prepared_dependent.sml source_binding.json Holmakefile run_prepared.sh \
 "$setup/dependent.sml" "$setup/DependentBlockScript.sml" "$setup/BlockRoundScript.sml" \
 > "${label}_sources.sha256"
# Snapshot the actual cached project dependencies; imported HOL library stays read-only.
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
phase build "$hol/bin/Holmake" --no_prereqs prepared_dependent.exe
sha256sum prepared_dependent.exe > "${label}_executable.sha256"
for sample in 1 2 3; do
 test "$sample" -le "$samples" || break
 case "$sample" in 1) modes='stock fresh retained';; 2) modes='retained fresh stock';; 3) modes='fresh stock retained';; esac
 for mode in $modes; do
  phase "${mode}_${sample}" /usr/bin/env "PREPARED_MODE=$mode" ./prepared_dependent.exe
  grep -q '^HOL4_PREPARED_DEPENDENT_BENCHMARK_DONE$' "${label}_${mode}_${sample}.log"
  grep -q '^PREPARED_INCOMPATIBLE_CLOSURE_REJECTED$' "${label}_${mode}_${sample}.log"
  grep -q '^PREPARED_EQUATION_SET,' "${label}_${mode}_${sample}.log"
  grep -q '^PREPARED_EQUATION_IDENTITY_CONTROL_DONE$' "${label}_${mode}_${sample}.log"
  for control in checksum bound depth input coefficient; do
   grep -q "^HOL4_REJECTED_${control}$" "${label}_${mode}_${sample}.log"
  done
  test ! -e "${label}_${mode}_${sample}.dat"
  cp .hol/objs/PreparedDependentResultsTheory.dat "${label}_${mode}_${sample}.dat"
 done
done
sha256sum -c "${label}_executable.sha256" > "${label}_executable_check.log"
sha256sum -c "${label}_sources.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_dependencies.sha256" > "${label}_dependency_check.log"
sha256sum -c "${label}_toolchain.sha256" > "${label}_toolchain_check.log"
printf '%s\n' 'PREPARED_RUN_FINISHED_REQUIRES_RESULT_AUDIT'
