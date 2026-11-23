#!/bin/sh
set -eu
label=$1
case "$label" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
case "$2" in GroupedCount|GroupedBaseline|GroupedMargins|FusedCount|FusedBaseline|FusedMargins|PanelWeights[A-Z]|PanelTables|SparseHead|HeadPairEven|HeadPairOdd|HeadProjection) theory=$2;; *) exit 2;; esac
cd "$(dirname "$0")"
here=$(pwd)
root=$(cd ../../../../.. && pwd)
setup=$(cd ../../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$here" "$here"
mount -o remount,bind,ro "$root"
for dep in ../../grid-enclosure ../../sparse-head ../../stencil-perturbation ../../raw-analytic/dependency-build-win01 ../../interpolation-geometry; do
 if test -d "$dep/.hol/make-deps"; then
  dest="$here/metadata/$(basename "$dep")"
  mkdir -p "$dest"
  cp -a "$dep/.hol/make-deps/." "$dest/"
  mount --bind "$dest" "$dep/.hol/make-deps"
 fi
done
test ! -e "$label.log"
ulimit -v 3670016
ulimit -c 0
sha256sum "${theory}Script.sml" Holmakefile > "$label.sha256"
case "$theory" in
 HeadProjection) sha256sum retained.hex keptprojection.sml ../../grid-projection/.hol/objs/ProjectTheory.dat >> "$label.sha256";;
 SparseHead) sha256sum ../../grid-sign-join/.hol/objs/GridSignsTheory.dat >> "$label.sha256";;
 HeadPair*) sha256sum headobserve.sml inputs.json ../../grid-sign-join/replay.sml ../../grid-sign-join/.hol/objs/JoinTablesTheory.dat .hol/objs/SparseHeadTheory.dat >> "$label.sha256";;
esac
set +e
"$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 5 350 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$label.log" 2>&1
status=$?
set -e
echo "$status" > "$label.status"
tail -n 13 "$label.log"
exit "$status"
