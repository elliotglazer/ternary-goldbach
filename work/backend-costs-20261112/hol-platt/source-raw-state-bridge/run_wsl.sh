#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/source-raw-state-bridge
setup=$base/hol4-setup
hol=$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92
mode=${1:?theory, script or audit required}
label=${2:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$mode" in theory|script|audit) ;; *) exit 2;; esac
cd "$local"
test ! -e "${label}.status"
# The caller starts a fresh mount namespace. Isolate project writes before Holmake.
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local" "$local"
mount -o remount,bind,ro "$root"
for dep in raw-pair-round-proof source-log-real source-log-horner source-log-range source-phase-range source-exp-horner source-state-error source-state-bounds source-inverse-root source-initial source-phase-taylor source-producer raw-analytic/dependency-build-win01; do
  d="$base/hol-platt/$dep/.hol/make-deps"
  dest="$local/metadata/$dep"
  mkdir -p "$dest"
  cp -a "$d/." "$dest/"
  mount --bind "$dest" "$d"
done
ulimit -v 4194304
sha256sum ../source-log-range/.hol/objs/SourceLogRangeTheory.dat ../source-phase-range/.hol/objs/SourcePhaseRangeTheory.dat ../source-exp-horner/.hol/objs/SourceExpHornerTheory.dat ../source-producer/.hol/objs/SourceArithmeticTheory.dat ../source-phase-taylor/.hol/objs/SourceRawStepTheory.dat ../source-initial/.hol/objs/SourceInitialTheory.dat ../source-state-bounds/.hol/objs/SourceStateBoundsTheory.dat SourceRawStateBridgeScript.sml Holmakefile bridge_audit.sml > "${label}.sha256"
run() {
  "$setup/run.sh" /usr/bin/time -v -o "${label}_$1.time" timeout -k 10 300 "$2" "$3" "$4" "$5" "$6" "$7" "$8"
}
set +e
if test "$mode" = script; then
  "$setup/run.sh" /usr/bin/time -v -o "${label}_script.time" timeout -k 10 280 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" "$hol/sigobj/holmake_not_interactive.uo" "$local/.hol/objs/SourceRawStateBridgeScript.uo" > "${label}.log" 2>&1
  code=$?
elif test "$mode" = theory; then
  run theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 SourceRawStateBridgeTheory.uo > "${label}.log" 2>&1
  code=$?
else
  run build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 bridge_audit.uo > "${label}.log" 2>&1 &&
  "$setup/run.sh" /usr/bin/time -v -o "${label}_audit.time" timeout -k 10 300 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" bridge_audit >> "${label}.log" 2>&1
  code=$?
fi
set -e
if test "$code" -eq 0; then
  sha256sum -c "${label}.sha256" > "${label}_postcheck.log"
  if test "$mode" = audit; then
    test "$(grep -c '^SOURCE_RAW_STATE_ROOT,' "${label}.log")" -eq 4
    test "$(grep -c '^SOURCE_RAW_STATE_AUDIT_DONE$' "${label}.log")" -eq 1
    sha256sum .hol/objs/SourceRawStateBridgeTheory.uo .hol/objs/SourceRawStateBridgeTheory.dat > "${label}_output.sha256"
  fi
fi
echo "$code" > "${label}.status"
tail -n 28 "${label}.log"
exit "$code"
