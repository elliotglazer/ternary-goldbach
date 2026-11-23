#!/bin/sh
# Root launches sequentially after source clearance. No dependency rebuilds.
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_handoff.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') echo 'invalid label' >&2; exit 2;; esac
setup="$(pwd)/../hol4-setup"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
for f in fixture_binding.json handoff_materialized.sml handoff_fused.sml handoff_compare.sml; do
  test -f "$f" || { echo "missing generated source $f" >&2; exit 2; }
done
test -f "$setup/.hol/objs/BlockRoundTheory.uo"
sha256sum RawStateHandoffScript.sml HandoffRuntime.sml Holmakefile \
  prepare_handoff.py summarize_handoff.py run_handoff.sh \
  fixture_binding.json handoff_materialized.sml handoff_fused.sml \
  handoff_compare.sml ../../lean-pilots/raw-head/state_fixture.json \
  > "${label}_launch.sha256"
# Record selected installed support, without rebuilding or claiming full closure.
sha256sum "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" \
  "$setup/.hol/objs/BlockRoundTheory.uo" \
  "$setup/.hol/objs/BlockRoundTheory.dat" \
  > "${label}_support.sha256"
snapshot () {
  stamp=$1
  for f in ./*.exe .hol/objs/*; do
    if test -f "$f"; then
      sha256sum "$f"
      stat -c 'FILE_BYTES_MTIME,%s,%Y,%n' "$f"
    fi
  done > "${label}_${stamp}.artifacts"
}
snapshot before
ulimit -v 4194304
phase () {
  key=$1
  shift
  test ! -e "${label}_${key}.time"
  printf '%s\n' "$setup/run.sh" /usr/bin/time -v -o \
    "${label}_${key}.time" timeout 600 "$@" > "${label}_${key}.argv"
  "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" \
    timeout 600 "$@" > "${label}_${key}.log" 2>&1
}
phase generic "$hol/bin/Holmake" --no_prereqs RawStateHandoffTheory.uo
snapshot generic_built
phase materialized_build "$hol/bin/Holmake" --no_prereqs handoff_materialized.exe
snapshot materialized_built
phase materialized ./handoff_materialized.exe
test ! -e "${label}_materialized.dat"
cp .hol/objs/HandoffMaterializedTheory.dat "${label}_materialized.dat"
phase fused_build "$hol/bin/Holmake" --no_prereqs handoff_fused.exe
snapshot fused_built
phase fused ./handoff_fused.exe
test ! -e "${label}_fused.dat"
cp .hol/objs/HandoffFusedTheory.dat "${label}_fused.dat"
phase compare_build "$hol/bin/Holmake" --no_prereqs handoff_compare.exe
snapshot compare_built
phase compare ./handoff_compare.exe
snapshot after
sha256sum -c "${label}_launch.sha256" > "${label}_source_check.log"
printf '%s\n' 'HANDOFF_RUN_FINISHED_NO_ANALYTIC_CLAIM'
