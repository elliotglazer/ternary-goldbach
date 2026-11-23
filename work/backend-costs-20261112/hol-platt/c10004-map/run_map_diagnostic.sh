#!/bin/sh
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?fresh diagnostic label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
mkdir "${label}_run"
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
heap="$(pwd -P)/C10004Map.map_num_qsort_fuel_correct.dumpedheap"
sha256sum "$heap" C10004MapScript.sml map_proof_diagnostic.sml run_map_diagnostic.sh \
 "$setup/run.sh" "$hol/bin/hol" > "${label}_run/inputs.sha256"
ulimit -v 4194304
ulimit -c 0
ulimit -f 32768
set +e
"$setup/run.sh" /usr/bin/time -v -o "${label}_run/time.txt" \
 timeout -k 15 120 "$hol/bin/hol" "--holstate=$heap" \
 < map_proof_diagnostic.sml > "${label}_run/output.log" 2>&1
code=$?
set -e
printf '%s\n' "$code" > "${label}_run/exit.txt"
sha256sum -c "${label}_run/inputs.sha256" > "${label}_run/input_check.log"
exit "$code"
