#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/c10004-hol-replay
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
for dep in c10004-traversal-cv c10004-traversal c10004-traversal-refinement c10004-transform c10004-projection ../../hol4-setup; do
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
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout -k 10 1200 "$@" > "${label}_${key}.log" 2>&1
 code=$?
 set -e
 echo "$code" > "${label}_${key}.status"
 tail -n 12 "${label}_${key}.log"
 test "$code" -eq 0
}
phase build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 replay.uo
phase replay "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" replay
grep -qx ACTUAL_REPLAY_DONE "${label}_replay.log"
