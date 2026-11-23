#!/bin/sh
set -eu
label=$1
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case ${2:-SeedReplay} in SeedReplay|SeedCases|SeedPhases|SeedLinked|NormalizedSeed|NormalizedLinked) theory=${2:-SeedReplay};; *) exit 2;; esac
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
ulimit -v 4194304
ulimit -c 0
sha256sum "${theory}Script.sml" Holmakefile > "$label.sha256"
if test "$theory" = SeedCases; then sha256sum cases.txt >> "$label.sha256"; fi
if test "$theory" = SeedPhases; then sha256sum phase-cases.txt >> "$label.sha256"; fi
if test "$theory" = SeedLinked; then sha256sum linked.txt >> "$label.sha256"; fi
if test "$theory" = NormalizedSeed; then sha256sum normalized-cases.txt >> "$label.sha256"; fi
if test "$theory" = NormalizedLinked; then sha256sum normalized-linked.txt >> "$label.sha256"; fi
if test "$theory" != SeedReplay; then sha256sum seedbench.sml >> "$label.sha256"; fi
set +e
"$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 5 300 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$label.log" 2>&1
status=$?
set -e
echo "$status" > "$label.status"
tail -n 16 "$label.log"
exit "$status"
