#!/bin/sh
set -eu
cd "$(dirname "$0")"
case "$1" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
test ! -e "$1.log"
here=$(pwd)
root=$(cd ../../../.. && pwd)
setup=$(cd ../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$here" "$here"
mount -o remount,bind,ro "$root"
for sub in raw-analytic/dependency-build-win01 large-terminal-signs full-height-count; do
  deps=../$sub/.hol/make-deps
  dst="$here/metadata/$1/$(basename "$sub")"
  mkdir -p "$dst"
  cp -a "$deps/." "$dst/"
  mount --bind "$dst" "$deps"
done
ulimit -v 3145728
ulimit -c 0
sha256sum FallbackScoreScript.sml Holmakefile ../large-terminal-signs/LargeTerminalScript.sml > "$1.sha256"
set +e
"$setup/run.sh" /usr/bin/time -v -o "$1.time" timeout -k 5 200 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 FallbackScoreTheory.uo > "$1.log" 2>&1
status=$?
set -e
echo "$status" > "$1.status"
tail -n 22 "$1.log"
exit "$status"
