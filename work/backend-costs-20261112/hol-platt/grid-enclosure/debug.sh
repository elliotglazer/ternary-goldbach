#!/bin/sh
set -eu
heap=$1
label=debug_session
case "$label" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
cd "$(dirname "$0")"
here=$(pwd)
root=$(cd ../../../.. && pwd)
setup=$(cd ../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$here" "$here"
mount -o remount,bind,ro "$root"
test -f "$heap"
ulimit -v 3145728
ulimit -c 0
exec "$setup/run.sh" "$hol/bin/hol" --gcthreads=1 --holstate="$heap"
