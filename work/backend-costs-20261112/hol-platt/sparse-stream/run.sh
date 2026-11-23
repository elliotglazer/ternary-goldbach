#!/bin/sh
set -eu
label=$1
case "$label" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
case "$2" in StreamRaw|StreamReceipt) theory=$2;; *) exit 2;; esac
cd "$(dirname "$0")"
here=$(pwd)
root=$(cd ../../../.. && pwd)
setup=$(cd ../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$here" "$here"
mount -o remount,bind,ro "$root"
test ! -e "$label.log"
ulimit -v 3670016
ulimit -c 0
sha256sum "${theory}Script.sml" Holmakefile > "$label.sha256"
case "$theory" in
 StreamReceipt) sha256sum streamcheck.sml manifest.json stream.txt .hol/objs/StreamRawTheory.dat >> "$label.sha256";;
esac
set +e
"$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 5 300 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$label.log" 2>&1
status=$?
set -e
echo "$status" > "$label.status"
tail -n 14 "$label.log"
exit "$status"
