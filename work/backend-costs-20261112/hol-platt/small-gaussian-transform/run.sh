#!/bin/sh
set -eu
run_bounded() {
label=$1
mode=$2
case "$label" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
case "$mode" in theory|actual|matchedtheory|matched|publish|consume|tables|direct|readback) ;; *) exit 2;; esac
cd "$(dirname "$0")"
local_dir=$(pwd)
root=$(cd ../../../.. && pwd)
setup=$(cd ../../hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local_dir" "$local_dir"
mount -o remount,bind,ro "$root"
test ! -e "$label.log"
ulimit -v 4194304
ulimit -c 0
sha256sum FusedScript.sml Holmakefile ../small-gaussian/GaussScript.sml ../small-character-kernel/SmallFFTScript.sml > "$label.sha256"
set +e
if [ "$mode" != actual ] && [ "$mode" != matched ]; then
  theory=Fused
  if [ "$mode" = matchedtheory ]; then theory=Matched; sha256sum MatchedScript.sml >> "$label.sha256"; fi
  if [ "$mode" = publish ]; then theory=GaussianTransfer; fi
  if [ "$mode" = consume ]; then
    theory=PrimitiveTransfer
    sha256sum .hol/objs/GaussianTransferTheory.dat MatchedScript.sml >> "$label.sha256"
  fi
  if [ "$mode" = readback ]; then
    theory=ReadTransfer
    sha256sum .hol/objs/DirectTransferTheory.dat >> "$label.sha256"
  fi
  if [ "$mode" = tables ]; then theory=ConductorTables; fi
  if [ "$mode" = direct ]; then
    theory=DirectTransfer
    sha256sum .hol/objs/ConductorTablesTheory.dat MatchedScript.sml >> "$label.sha256"
  fi
  case "$mode" in publish|consume|tables|direct|readback)
    sha256sum "${theory}Script.sml" encoding.sml meter.sml matched.txt >> "$label.sha256";; esac
  "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 420 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$label.log" 2>&1
  result=$?
else
  if [ "$mode" = matched ]; then
    sha256sum MatchedScript.sml meter.sml matched.sml matched.txt matched.json >> "$label.sha256"
  else sha256sum actual.sml actual.txt reference.json >> "$label.sha256"; fi
  "$setup/run.sh" "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "$mode.uo" > "$label.build" 2>&1
  result=$?
  if [ "$result" = 0 ]; then
    "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 900 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" "$mode" > "$label.log" 2>&1
    result=$?
  fi
fi
set -e
echo "$result" > "$label.status"
if [ -e "$label.log" ]; then tail -n 12 "$label.log"; else tail -n 10 "$label.build"; fi
test "$result" = 0
case "$mode" in actual|matched) grep -qx FUSED_DONE "$label.log";; esac
}
run_bounded "$@"
