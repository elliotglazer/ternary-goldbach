#!/bin/sh
set -eu
label=$1
case "$label" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
case "$2" in SparseHead|HeadPairEven|HeadPairOdd|HeadProjection|SparseHeadLink|SparseRepair|SparsePreserve|SparseAllRepairs|FusedCount|FusedBaseline|FusedMargins|RetainedTransfer|ChannelInvariant|ProducedHead|PackedLoad|ProducedRange|CheckedDigits|DigitControls) theory=$2;; *) exit 2;; esac
cd "$(dirname "$0")"
here=$(pwd)
root=$(cd ../../../.. && pwd)
setup=$(cd ../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$here" "$here"
mount -o remount,bind,ro "$root"
if test "$theory" = SparseHeadLink || test "$theory" = SparseRepair || test "$theory" = SparsePreserve || test "$theory" = SparseAllRepairs || test "${theory#Fused}" != "$theory" || test "$theory" = RetainedTransfer || test "$theory" = ChannelInvariant || test "$theory" = ProducedHead || test "$theory" = PackedLoad || test "$theory" = ProducedRange || test "$theory" = CheckedDigits || test "$theory" = DigitControls; then
  mkdir -p "$here/metadata/grid-enclosure"
  cp -a "$here/../grid-enclosure/.hol/make-deps/." "$here/metadata/grid-enclosure/"
  mount --bind "$here/metadata/grid-enclosure" "$here/../grid-enclosure/.hol/make-deps"
fi
if test "$theory" = SparseRepair || test "$theory" = SparsePreserve || test "$theory" = SparseAllRepairs || test "${theory#Fused}" != "$theory" || test "$theory" = RetainedTransfer || test "$theory" = ChannelInvariant || test "$theory" = ProducedHead || test "$theory" = PackedLoad || test "$theory" = ProducedRange || test "$theory" = CheckedDigits || test "$theory" = DigitControls; then
  for d in ../stencil-perturbation ../raw-analytic/dependency-build-win01 ../interpolation-geometry ../sparse-stream ../small-time-selected-consumer; do
    mkdir -p "$here/metadata/$(basename "$d")"
    cp -a "$d/.hol/make-deps/." "$here/metadata/$(basename "$d")/"
    mount --bind "$here/metadata/$(basename "$d")" "$d/.hol/make-deps"
  done
fi
test ! -e "$label.log"
ulimit -v 3670016
ulimit -c 0
sha256sum "${theory}Script.sml" Holmakefile > "$label.sha256"
case "$theory" in
 SparseHeadLink) sha256sum .hol/objs/HeadProjectionTheory.dat .hol/objs/SparseHeadTheory.dat ../grid-enclosure/.hol/objs/EnclosureTheory.dat >> "$label.sha256";;
 HeadProjection) sha256sum retained.hex keptprojection.sml ../grid-projection/.hol/objs/ProjectTheory.dat >> "$label.sha256";;
 SparseHead) sha256sum ../grid-sign-join/.hol/objs/GridSignsTheory.dat >> "$label.sha256";;
 HeadPair*) sha256sum headobserve.sml inputs.json ../grid-sign-join/replay.sml ../grid-sign-join/.hol/objs/JoinTablesTheory.dat .hol/objs/SparseHeadTheory.dat >> "$label.sha256";;
esac
set +e
"$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 5 350 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$label.log" 2>&1
status=$?
set -e
echo "$status" > "$label.status"
tail -n 13 "$label.log"
exit "$status"
