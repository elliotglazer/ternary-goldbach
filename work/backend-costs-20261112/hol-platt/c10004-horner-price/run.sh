#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/c10004-horner-price
setup=$base/hol4-setup
hol=$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92
mode=${1:?theory or audit required}
label=${2:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$mode" in theory|rows|audit) ;; *) exit 2;; esac
cd "$local"
test ! -e "${label}.status"
# The caller starts a fresh mount namespace. Isolate project writes before Holmake.
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local" "$local"
mount -o remount,bind,ro "$root"

ulimit -v 4194304
sha256sum PriceScript.sml > "${label}.sha256"
run() {
  "$setup/run.sh" /usr/bin/time -v -o "${label}_$1.time" timeout -k 10 300 "$2" "$3" "$4" "$5" "$6" "$7" "$8"
}
set +e
if test "$mode" != audit; then
  target=PriceTheory.uo
  if test "$mode" = rows; then target=RootRowsTheory.uo; fi
  run theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "$target" > "${label}.log" 2>&1
  code=$?
else
  run build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 root_audit.uo > "${label}.log" 2>&1 &&
  "$setup/run.sh" /usr/bin/time -v -o "${label}_audit.time" timeout -k 10 300 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" root_audit >> "${label}.log" 2>&1
  code=$?
fi
set -e
echo "$code" > "${label}.status"
tail -n 28 "${label}.log"
exit "$code"
