#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/small-time-chirp-delivery
setup=$base/hol4-setup
hol=$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92
label=${1:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
cd "$local"
test ! -e "${label}_build.log"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local" "$local"
mount -o remount,bind,ro "$root"
for dep in small-time-selected-consumer raw-pair-round-proof source-state-error source-producer raw-analytic/dependency-build-win01; do
  d="$base/hol-platt/$dep/.hol/make-deps"
  dest="$local/metadata/$dep"
  mkdir -p "$dest"
  cp -a "$d/." "$dest/"
  mount --bind "$dest" "$d"
done
ulimit -v 4194304
export REPLAY_LABEL="$label"
phase() {
 key=$1; shift
 set +e
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout -k 10 1200 "$@" > "${label}_${key}.log" 2>&1
 code=$?
 set -e
 echo "$code" > "${label}_${key}.status"
 tail -n 12 "${label}_${key}.log"
 test "$code" -eq 0
}
phase theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 SharedChirpTheory.uo
phase build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 sharebench.uo
phase bench "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" sharebench
grep -qx SELECT_DONE "${label}_bench.log"