#!/bin/sh
# Root-only reviewed execution. Never invokes a dependency build.
# All candidate results remain raw; exported references use the stock kernel.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_compiled.sh fresh_label [build|smoke|full]}
size=${2:-smoke}
case "$label" in *[!A-Za-z0-9_]*|'') echo 'invalid label' >&2; exit 2;; esac
case "$size" in build) samples=0;; smoke) samples=1;; full) samples=3;; *) exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for name in StageCheck BlockRound DependentBlock; do
  test -f "$setup/.hol/objs/${name}Theory.uo"
  test -f "$setup/.hol/objs/${name}Theory.dat"
done
sha256sum CompiledComputeBenchmark.sml CvBenchmarkConfig.sml CompiledEvalChecks.sml \
 CompiledWorkload.sml compiled_dependent.sml ClosureCompiler.sml.inc \
 prepare_harness.py harness_source_binding.json Holmakefile run_compiled.sh \
 "$setup/dependent.sml" "$setup/DependentBlockScript.sml" "$setup/BlockRoundScript.sml" \
 "$hol/src/thm/Compute.sml" "$hol/src/thm/Thm.sml" \
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
phase build "$hol/bin/Holmake" --no_prereqs compiled_dependent.exe
sha256sum compiled_dependent.exe > "${label}_executable.sha256"
for sample in 1 2 3; do
  test "$sample" -le "$samples" || break
  case "$sample" in 1|3) orders='stock-first compiled-first';; 2) orders='compiled-first stock-first';; esac
  for order in $orders; do
    phase "${order}_${sample}" /usr/bin/env "COMPILED_ORDER=$order" ./compiled_dependent.exe
    log="${label}_${order}_${sample}.log"
    grep -q '^COMPILED_SEMANTICS_PASS,' "$log"
    grep -q '^HOL4_COMPILED_DEPENDENT_BENCHMARK_DONE$' "$log"
    for depth in 1 8 32 128; do
      grep -q "^COMPILED_WORKLOAD_PASS,depth${depth}," "$log"
    done
    for control in checksum bound depth input coefficient; do
      grep -q "^COMPILED_WORKLOAD_PASS,control_${control}," "$log"
      grep -q "^HOL4_REJECTED_${control}$" "$log"
    done
    test ! -e "${label}_${order}_${sample}.dat"
    cp .hol/objs/DependentBlockResultsTheory.dat "${label}_${order}_${sample}.dat"
  done
done
sha256sum -c "${label}_sources.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_dependencies.sha256" > "${label}_dependency_check.log"
sha256sum -c "${label}_toolchain.sha256" > "${label}_toolchain_check.log"
sha256sum -c "${label}_executable.sha256" > "${label}_executable_check.log"
printf '%s\n' 'COMPILED_RUN_FINISHED_REQUIRES_RESULT_AUDIT'
