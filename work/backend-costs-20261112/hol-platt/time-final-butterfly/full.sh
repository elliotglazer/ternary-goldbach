#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/time-final-butterfly
setup=$base/hol4-setup
hol=$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92
label=${1:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
cd "$local"
test ! -e "${label}_theory.log"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local" "$local"
mount -o remount,bind,ro "$root"
for dep in grid-sign-join full-height-count small-gaussian-transform small-gaussian small-character-kernel; do
 case "$dep" in ../../*) d="$setup/.hol/make-deps";; *) d="../$dep/.hol/make-deps";; esac
 dest="$local/metadata/$(basename "$dep")"
 mkdir -p "$dest"
 cp -a "$d/." "$dest/"
 mount --bind "$dest" "$d"
done
ulimit -v 4194304
export REPLAY_LABEL="$label"
phase() {
 key=$1; shift
 set +e
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout -k 10 2400 "$@" > "${label}_${key}.log" 2>&1
 code=$?
 set -e
 echo "$code" > "${label}_${key}.status"
 tail -n 12 "${label}_${key}.log"
 test "$code" -eq 0
}
phase theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 FullButterflyTheory.uo
phase pilot "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 FullButterflyAuditTheory.uo
grep -qx FULL_BUTTERFLY_DONE "${label}_pilot.log"