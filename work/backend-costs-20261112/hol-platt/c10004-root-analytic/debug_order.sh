#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/c10004-root-analytic
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
"$setup/run.sh" "$hol/bin/hol" --holstate=C10004RootOrder.cosine_decreasing.dumpedheap