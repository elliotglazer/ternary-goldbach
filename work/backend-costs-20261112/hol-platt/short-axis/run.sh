#!/bin/sh
set -eu
label=$1
target=$2
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$target" in ShortAxis|ShortBench) ;; *) exit 2;; esac
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
sha256sum ShortAxisScript.sml "$target"Script.sml rows.txt plan.json Holmakefile > "$label.sha256"
if [ "$target" = ShortBench ]; then sha256sum real.txt real-inputs.json >> "$label.sha256"; fi
set +e
"$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 1100 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${target}Theory.uo" > "$label.log" 2>&1
result=$?
set -e
echo "$result" > "$label.status"
tail -n 12 "$label.log"
test "$result" = 0
if [ "$target" = ShortBench ]; then grep -qx SHORT_DONE "$label.log"; fi
