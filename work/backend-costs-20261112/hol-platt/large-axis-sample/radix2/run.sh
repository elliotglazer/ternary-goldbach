#!/bin/sh
set -eu
label=$1
input=$2
first=$3
last=$4
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$input" in panel) ;; *) exit 2;; esac
cd "$(dirname "$0")"
base=$(cd ../../.. && pwd)
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
export AXIS_INPUT="$input.txt" AXIS_FIRST="$first" AXIS_LAST="$last"
sha256sum RadixScript.sml worker.sml "$AXIS_INPUT" > "$label.sha256"
set +e
"$setup/run.sh" "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 RadixTheory.uo worker.uo > "$label.build" 2>&1
result=$?
if test "$result" = 0; then
  "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 1800 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" worker > "$label.log" 2>&1
  result=$?
fi
set -e
echo "$result" > "$label.status"
if test -e "$label.log"; then tail -n 4 "$label.log"; else tail -n 8 "$label.build"; fi
test "$result" = 0
grep -qx AXIS_DONE "$label.log"
