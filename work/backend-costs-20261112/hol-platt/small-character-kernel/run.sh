#!/bin/sh
set -eu
label=$1
target=$2
export FFT_FIRST=${3:-0} FFT_LAST=${4:-1000}
case "$FFT_FIRST:$FFT_LAST" in *[!0-9:]*) exit 2;; esac
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$target" in theory|panels|actual) ;; *) exit 2;; esac
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
sha256sum SmallFFTScript.sml Holmakefile > "$label.sha256"
set +e
if [ "$target" = theory ]; then
  "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 900 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 SmallFFTTheory.uo > "$label.log" 2>&1
  result=$?
else
  sha256sum "$target.sml" "$target.txt" >> "$label.sha256"
  "$setup/run.sh" "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "$target.uo" > "$label.build" 2>&1
  result=$?
  if [ "$result" = 0 ]; then
    "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 1800 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" "$target" > "$label.log" 2>&1
    result=$?
  fi
fi
set -e
echo "$result" > "$label.status"
if [ -e "$label.log" ]; then tail -n 10 "$label.log"; else tail -n 10 "$label.build"; fi
test "$result" = 0
if [ "$target" != theory ]; then grep -qx FFT_DONE "$label.log"; fi
