#!/bin/sh
set -eu
cd "$(dirname "$0")"
setup=$(cd ../../../backend-costs-20261112/hol4-setup && pwd)
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
ulimit -v 4194304
ulimit -c 0
for theory in "$@"; do
 case "$theory" in ShortKernel|ShortUnary|ShortBatch|PanelKernel|PanelUnary|PanelBatch|ActualSign|PanelFast|ShortFast|PanelJoin) ;; *) exit 2;; esac
 "$setup/run.sh" /usr/bin/time -v -o "$theory.time" timeout -k 10 420 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$theory.log" 2>&1 || { tail -35 "$theory.log"; exit 1; }
 sha256sum ".hol/objs/${theory}Theory.dat" > "$theory.sha256"
 tail -5 "$theory.log"
done
