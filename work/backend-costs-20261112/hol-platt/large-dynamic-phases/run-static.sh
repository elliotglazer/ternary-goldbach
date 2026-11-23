#!/bin/sh
set -eu
case "$1" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
case "${2:-DynamicStatic}" in DynamicStatic) theory=${2:-DynamicStatic};; *) exit 2;; esac
cd "$(dirname "$0")"
here=$(pwd)
root=$(cd ../../../.. && pwd)
setup=$(cd ../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$here" "$here"
mount -o remount,bind,ro "$root"
test ! -e "$1.log"
deps=../raw-analytic/dependency-build-win01/.hol/make-deps
mkdir -p "coordinate-metadata/$1"
cp -a "$deps/." "coordinate-metadata/$1/"
mount --bind "$here/coordinate-metadata/$1" "$deps"
ulimit -v 3145728
ulimit -c 0
sha256sum "${theory}Script.sml" Holmakefile > "$1.sha256"
set +e
"$setup/run.sh" /usr/bin/time -v -o "$1.time" timeout -k 5 180 "$hol/bin/Holmake" -I ../raw-analytic/dependency-build-win01 --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$1.log" 2>&1
status=$?
set -e
echo "$status" > "$1.status"
tail -n 25 "$1.log"
exit "$status"
