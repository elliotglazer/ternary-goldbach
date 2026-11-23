#!/bin/sh
set -eu
bounded() {
  label=$1
  case "$label" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
  case "$2" in FullCount|CountReceipt|StencilReceipt|ShortGuard|KernelWeights) theory=$2;; *) exit 2;; esac
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
  sha256sum "${theory}Script.sml" Holmakefile > "$label.sha256"
  if [ "$theory" = CountReceipt ]; then
    sha256sum packets.txt FullCountScript.sml .hol/objs/FullCountTheory.dat >> "$label.sha256"
  fi
  if [ "$theory" = StencilReceipt ]; then
    sha256sum stencils.txt ../small-gaussian-transform/encoding.sml >> "$label.sha256"
  fi
  if [ "$theory" = ShortGuard ]; then
    sha256sum short.txt .hol/objs/CountReceiptTheory.dat >> "$label.sha256"
  fi
  if [ "$theory" = KernelWeights ]; then
    sha256sum stencils.txt .hol/objs/StencilReceiptTheory.dat >> "$label.sha256"
  fi
  set +e
  "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 420 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$label.log" 2>&1
  status=$?
  set -e
  echo "$status" > "$label.status"
  tail -n 18 "$label.log"
  test "$status" = 0
}
bounded "$@"
