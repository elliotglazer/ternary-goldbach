#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/principal-ceiling-count
setup=$base/hol4-setup
hol=$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92
mode=${1:?theory or audit required}
label=${2:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
case "$mode" in theory|audit) ;; *) exit 2;; esac
cd "$local"
test ! -e "${label}.status"
# The caller starts a fresh mount namespace. Isolate project writes before Holmake.
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local" "$local"
mount -o remount,bind,ro "$root"
for dep in raw-analytic/dependency-build-win01; do
  d="$base/hol-platt/$dep/.hol/make-deps"
  dest="$local/metadata/$dep"
  mkdir -p "$dest"
  cp -a "$d/." "$dest/"
  mount --bind "$dest" "$d"
done
ulimit -v 4194304
sha256sum ZetaEtaSignScript.sml Holmakefile > "${label}.sha256"
run() {
  "$setup/run.sh" /usr/bin/time -v -o "${label}_$1.time" timeout -k 10 300 "$2" "$3" "$4" "$5" "$6" "$7" "$8"
}
set +e
if test "$mode" = theory; then
  run theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 ZetaEtaSignTheory.uo > "${label}.log" 2>&1
  code=$?
else
  run build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 eta_audit.uo > "${label}.log" 2>&1 &&
  "$setup/run.sh" /usr/bin/time -v -o "${label}_audit.time" timeout -k 10 300 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" eta_audit >> "${label}.log" 2>&1
  code=$?
fi
set -e
echo "$code" > "${label}.status"
tail -n 28 "${label}.log"
exit "$code"
