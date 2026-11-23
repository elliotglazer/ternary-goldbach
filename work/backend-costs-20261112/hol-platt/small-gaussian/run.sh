#!/bin/sh
set -eu
label=$1
target=$2
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$target" in Gauss|UnitBounds|bench) ;; *) exit 2;; esac
cd "$(dirname "$0")"
base=$(cd ../.. && pwd)
root=$(cd "$base/../.." && pwd)
local_dir=$(pwd)
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local_dir" "$local_dir"
mount -o remount,bind,ro "$root"
setup=$base/hol4-setup
hol=$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92
test ! -e "$label.log"
ulimit -v 4194304
ulimit -c 0
sha256sum GaussScript.sml Holmakefile > "$label.sha256"
set +e
if [ "$target" = bench ]; then
  sha256sum bench.sml bench.txt full.txt sample.json >> "$label.sha256"
  "$setup/run.sh" "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 bench.uo > "$label.build" 2>&1
  result=$?
  if [ "$result" = 0 ]; then
    "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 1200 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" bench > "$label.log" 2>&1
    result=$?
  fi
else
  sha256sum "${target}Script.sml" >> "$label.sha256"
  "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 600 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${target}Theory.uo" > "$label.log" 2>&1
  result=$?
fi
set -e
echo "$result" > "$label.status"
if [ -e "$label.log" ]; then tail -n 10 "$label.log"; else tail -n 10 "$label.build"; fi
test "$result" = 0
if [ "$target" = bench ]; then grep -qx GAUSS_DONE "$label.log"; fi
