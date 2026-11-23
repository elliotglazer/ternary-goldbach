#!/bin/sh
# Source-only prepared runner. Execute only after root review and authorization.
# Does not build project dependencies; core and CV theories must already exist.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_round_dependent.sh fresh_label [smoke|full]}
size=${2:-smoke}
case "$label" in *[!A-Za-z0-9_]*|'') echo 'invalid label' >&2; exit 2;; esac
case "$size" in smoke) samples=1;; full) samples=3;; *) exit 2;; esac
setup="$(cd ../../../hol4-setup && pwd -P)"
prepared="$(cd ../../prepared-eval && pwd -P)"
core="$(cd .. && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for name in StageCheck BlockRound DependentBlock; do
 test -f "$setup/.hol/objs/${name}Theory.uo"
 test -f "$setup/.hol/objs/${name}Theory.dat"
done
for name in RoundSpecialization RoundSpecializationCV; do
 test -f "$core/.hol/objs/${name}Theory.uo"
 test -f "$core/.hol/objs/${name}Theory.dat"
done
test -f "$prepared/.hol/objs/PreparedEval.uo"
sha256sum RoundDependentScript.sml round_dependent.sml prepare_driver.py source_binding.json \
 Holmakefile run_round_dependent.sh "$core/RoundSpecializationScript.sml" \
 "$core/RoundSpecializationCVScript.sml" "$prepared/PreparedEval.sml" \
 "$prepared/prepared_dependent.sml" "$setup/dependent.sml" \
 "$setup/DependentBlockScript.sml" "$setup/BlockRoundScript.sml" > "${label}_sources.sha256"
{
 for name in StageCheck BlockRound DependentBlock; do
  sha256sum "$setup/.hol/objs/${name}Theory.uo" "$setup/.hol/objs/${name}Theory.dat"
 done
 for name in RoundSpecialization RoundSpecializationCV; do
  sha256sum "$core/.hol/objs/${name}Theory.uo" "$core/.hol/objs/${name}Theory.dat"
 done
 sha256sum "$prepared/.hol/objs/PreparedEval.uo"
} > "${label}_dependencies.sha256"
sha256sum "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_toolchain.sha256"
# Same bounded ceiling as the predecessor runner, no raised resource limits.
ulimit -v 4194304
phase () {
 key=$1; shift
 test ! -e "${label}_${key}.time"
 printf '%s\n' "$@" > "${label}_${key}.argv"
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" \
  timeout 600 "$@" > "${label}_${key}.log" 2>&1
}
phase theory "$hol/bin/Holmake" --no_prereqs RoundDependentTheory.uo
phase build "$hol/bin/Holmake" --no_prereqs round_dependent.exe
sha256sum round_dependent.exe .hol/objs/RoundDependentTheory.uo \
 .hol/objs/RoundDependentTheory.dat > "${label}_newobjects.sha256"
for sample in 1 2 3; do
 test "$sample" -le "$samples" || break
 case "$sample" in
  1) cells='old:stock one:stock old:retained one:retained';;
  2) cells='one:retained old:retained one:stock old:stock';;
  3) cells='one:stock old:stock one:retained old:retained';;
 esac
 for cell in $cells; do
  impl=${cell%:*}; mode=${cell#*:}
  key="${impl}_${mode}_${sample}"
  phase "$key" /usr/bin/env "ROUND_IMPL=$impl" "PREPARED_MODE=$mode" ./round_dependent.exe
  grep -q '^HOL4_ROUND_DEPENDENT_BENCHMARK_DONE$' "${label}_${key}.log"
  grep -q '^PREPARED_INCOMPATIBLE_CLOSURE_REJECTED$' "${label}_${key}.log"
  grep -q '^PREPARED_EQUATION_IDENTITY_CONTROL_DONE$' "${label}_${key}.log"
  grep -q '^PREPARED_EQUATION_SET,' "${label}_${key}.log"
  for depth in 1 8 32 128; do
   grep -q "^HOL4_BLOCK_CONCLUSION,depth${depth}," "${label}_${key}.log"
   for repeat in 0 1 2; do
    grep -q "^HOL4_TIME,depth${depth}_r${repeat}," "${label}_${key}.log"
   done
  done
  for control in checksum bound depth input coefficient; do
   grep -q "^HOL4_REJECTED_${control}$" "${label}_${key}.log"
  done
  test ! -e "${label}_${key}.dat"
  cp .hol/objs/RoundDependentResultsTheory.dat "${label}_${key}.dat"
 done
done
sha256sum -c "${label}_sources.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_dependencies.sha256" > "${label}_dependency_check.log"
sha256sum -c "${label}_toolchain.sha256" > "${label}_toolchain_check.log"
sha256sum -c "${label}_newobjects.sha256" > "${label}_newobject_check.log"
printf '%s\n' 'ROUND_DEPENDENT_RUN_FINISHED_REQUIRES_RESULT_AUDIT'
