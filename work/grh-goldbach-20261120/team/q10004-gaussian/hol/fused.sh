#!/bin/sh
set -eu
cd "$(dirname "$0")"
setup=$(cd ../../../../backend-costs-20261112/hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
ulimit -v 4194304
ulimit -c 0
sha256sum -c exports.sha256
sha256sum -c window-export.sha256
sha256sum all-*.txt compressed-*.txt compression.json Q10004FusedScript.sml > fused-inputs.sha256
"$setup/run.sh" /usr/bin/time -v -o fused.time timeout -k 10 600 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 Q10004FusedTheory.uo > fused.log 2>&1 || { tail -35 fused.log; exit 1; }
sha256sum .hol/objs/Q10004FusedTheory.dat > fused-export.sha256
tail -24 fused.log
