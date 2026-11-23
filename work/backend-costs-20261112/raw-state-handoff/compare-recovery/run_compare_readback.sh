#!/bin/sh
# Readback recovery only. Never invokes numerical wrappers or rewrites exports.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_compare_readback.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
sha256sum compare_readback.sml Holmakefile run_compare_readback.sh frozen_inputs.sha256 > "${label}_source.sha256"
sha256sum -c frozen_inputs.sha256 > "${label}_inputs_before.log"
(cd .. && sha256sum -c handoff10_launch.sha256 && sha256sum -c handoff10_support.sha256) > "${label}_historical_binding.log"
cmp ../handoff10_materialized.dat ../.hol/objs/HandoffMaterializedTheory.dat
cmp ../handoff10_fused.dat ../.hol/objs/HandoffFusedTheory.dat
printf '%s
' 'ARCHIVED_EXPORTS_BYTE_IDENTICAL' > "${label}_dat_binding.log"
ulimit -v 4194304
phase () {
  key=$1
  shift
  printf '%s
' "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout 600 "$@" > "${label}_${key}.argv"
  set +e
  "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout 600 "$@" > "${label}_${key}.log" 2>&1
  result=$?
  set -e
  printf '%s
' "$result" > "${label}_${key}.exit"
  test "$result" -eq 0
}
phase build "$hol/bin/Holmake" --no_prereqs compare_readback.exe
for f in compare_readback.exe .hol/objs/*; do
  if test -f "$f"; then sha256sum "$f"; stat -c 'FILE_BYTES_MTIME,%s,%Y,%n' "$f"; fi
done > "${label}_built.artifacts"
phase readback ./compare_readback.exe
grep -Fx 'HANDOFF_MATCHED_EXACT_FINAL_THEOREM,516' "${label}_readback.log" > "${label}_matched.log"
grep -Fx 'HANDOFF_READBACK_ONLY_DONE' "${label}_readback.log" > "${label}_completed.log"
sha256sum -c frozen_inputs.sha256 > "${label}_inputs_after.log"
sha256sum -c "${label}_source.sha256" > "${label}_source_check.log"
printf '%s
' 'READBACK_RECOVERY_COMPLETE_NO_NUMERICAL_RERUN'
