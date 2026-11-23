#!/bin/sh
set -eu
cd "$(dirname "$0")"
setup=$(cd ../../../../backend-costs-20261112/hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
ulimit -v 4194304
ulimit -c 0
sha256sum -c exports.sha256
sha256sum -c window-export.sha256
sha256sum compressed-*.txt compression.json Q10004CompressedScript.sml > compressed-inputs.sha256
"$setup/run.sh" /usr/bin/time -v -o compressed.time timeout -k 10 600 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 Q10004CompressedTheory.uo > compressed.log 2>&1 || { tail -35 compressed.log; exit 1; }
sha256sum .hol/objs/Q10004CompressedTheory.dat > compressed-export.sha256
tail -24 compressed.log
