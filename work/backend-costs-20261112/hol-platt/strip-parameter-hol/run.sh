#!/bin/sh
set -eu
cd "$(dirname "$0")"
case "$1" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
test ! -e "$1.log"
case "${2:-base}" in base) target=StripParameterAcceptanceTheory.uo;; shift) target=StripShiftAcceptanceTheory.uo;; *) exit 2;; esac
here=$(pwd)
root=$(cd ../../../.. && pwd)
setup=$(cd ../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$here" "$here"
mount -o remount,bind,ro "$root"
ulimit -v 4194304
ulimit -c 0
sha256sum *Script.sml Holmakefile prepare.py ../guard-repricing/strip-repair-packets-stress.tsv ../guard-repricing/strip-parameter-witnesses.json ../guard-repricing/strip-repair-panel-stress.json > "$1.sha256"
set +e
"$setup/run.sh" /usr/bin/time -v -o "$1.time" timeout -k 10 600 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "$target" > "$1.log" 2>&1
status=$?
set -e
echo "$status" > "$1.status"
tail -n 18 "$1.log"
exit "$status"
