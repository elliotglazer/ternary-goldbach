#!/bin/sh
# Root-only theorem builds. No timed arithmetic workload is run here.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_round_build.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
test -f "$setup/.hol/objs/BlockRoundTheory.uo"
sha256sum RoundSpecializationScript.sml RoundSpecializationCVScript.sml \
  Holmakefile run_round_build.sh > "${label}_sources.sha256"
sha256sum "$setup/.hol/objs/BlockRoundTheory.uo" \
  "$setup/.hol/objs/BlockRoundTheory.dat" "$setup/run.sh" \
  "$hol/bin/Holmake" "$hol/bin/hol.state" > "${label}_support.sha256"
ulimit -v 4194304
for target in RoundSpecializationTheory.uo RoundSpecializationCVTheory.uo; do
  "$setup/run.sh" /usr/bin/time -v -o "${label}_${target}.time" \
    timeout 600 "$hol/bin/Holmake" --no_prereqs "$target" \
    > "${label}_${target}.log" 2>&1
done
sha256sum -c "${label}_sources.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_support.sha256" > "${label}_support_check.log"
for name in RoundSpecialization RoundSpecializationCV; do
  sha256sum ".hol/objs/${name}Theory.uo" ".hol/objs/${name}Theory.dat"
done > "${label}_artifacts.sha256"
printf '%s\n' 'ROUND_THEORIES_BUILT_NO_PERFORMANCE_CLAIM'
