#!/bin/sh
set -eu
cd "$(dirname "$0")"
setup=$(cd ../../../../backend-costs-20261112/hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
ulimit -v 4194304
ulimit -c 0
sha256sum packets.txt manifest.json Q10004ScanScript.sml Q10004ReceiptScript.sml Holmakefile > inputs.sha256
"$setup/run.sh" /usr/bin/time -v -o replay.time timeout -k 10 420 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 Q10004ScanTheory.uo Q10004ReceiptTheory.uo > replay.log 2>&1 || { tail -50 replay.log; exit 1; }
sha256sum .hol/objs/Q10004ScanTheory.dat .hol/objs/Q10004ReceiptTheory.dat > exports.sha256
tail -18 replay.log
