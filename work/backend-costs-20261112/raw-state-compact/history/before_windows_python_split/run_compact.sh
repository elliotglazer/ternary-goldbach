#!/bin/sh
# Root-only launch. No old numerical executable is called.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_compact.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
sha256sum RawCompactSignsScript.sml prepare_compact.py run_compact.sh \
  summarize_compact.py Holmakefile predecessor_inputs.sha256 \
  > "${label}_source.sha256"
sha256sum -c predecessor_inputs.sha256 > "${label}_predecessor_before.log"
(cd ../raw-state-handoff && sha256sum -c handoff10_launch.sha256 && \
  sha256sum -c handoff10_support.sha256) > "${label}_historical_inputs.log"
cmp ../raw-state-handoff/handoff10_fused.dat \
  ../raw-state-handoff/.hol/objs/HandoffFusedTheory.dat
ulimit -v 4194304
phase () {
  key=$1
  shift
  printf '%s\n' "$setup/run.sh" /usr/bin/time -v -o \
    "${label}_${key}.time" timeout 600 "$@" > "${label}_${key}.argv"
  set +e
  "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" \
    timeout 600 "$@" > "${label}_${key}.log" 2>&1
  rc=$?
  set -e
  printf '%s\n' "$rc" > "${label}_${key}.exit"
  test "$rc" -eq 0
}
phase prepare python3 prepare_compact.py
sha256sum compact_fused.sml compact_binding.json > "${label}_generated.sha256"
phase generic "$hol/bin/Holmake" --no_prereqs RawCompactSignsTheory.uo
phase build "$hol/bin/Holmake" --no_prereqs compact_fused.exe
for f in compact_fused.exe .hol/objs/*; do
  if test -f "$f"; then sha256sum "$f"; stat -c 'FILE_BYTES_MTIME,%s,%Y,%n' "$f"; fi
done > "${label}_built.artifacts"
phase run ./compact_fused.exe
grep -Fx 'COMPACT_PRIMARY_COMPLETE,4,129,1032' "${label}_run.log" > "${label}_primary.log"
grep -Fx 'COMPACT_MATCHED_OLD_FULL_SIGNS,1032' "${label}_run.log" > "${label}_matched.log"
grep -Fx 'COMPACT_DONE' "${label}_run.log" > "${label}_done.log"
sha256sum -c predecessor_inputs.sha256 > "${label}_predecessor_after.log"
sha256sum -c "${label}_source.sha256" > "${label}_source_check.log"
sha256sum -c "${label}_generated.sha256" > "${label}_generated_check.log"
sha256sum .hol/objs/CompactFusedResultsTheory.* > "${label}_export.sha256"
printf '%s\n' 'COMPACT_RUN_COMPLETE' > "${label}_complete.log"
python3 summarize_compact.py "$label"
