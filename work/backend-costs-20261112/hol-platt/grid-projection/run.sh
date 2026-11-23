#!/bin/sh
set -eu
run_bounded() {
  label=$1
  case "$label" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
  case "$2" in Project|ProjectionPilot|ProjectionAll) theory=$2;; *) exit 2;; esac
  cd "$(dirname "$0")"
  here=$(pwd)
  root=$(cd ../../../.. && pwd)
  setup=$(cd ../../hol4-setup && pwd)
  hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
  mount --make-rprivate /
  mount --bind "$root" "$root"
  mount --bind "$here" "$here"
  mount -o remount,bind,ro "$root"
  test ! -e "$label.log"
  ulimit -v 3145728
  ulimit -c 0
  sha256sum "${theory}Script.sml" Holmakefile > "$label.sha256"
  if [ "$theory" != Project ]; then sha256sum projection.sml source.hex .hol/objs/ProjectTheory.dat >> "$label.sha256"; fi
  set +e
  "$setup/run.sh" /usr/bin/time -v -o "$label.time" timeout -k 10 800 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "${theory}Theory.uo" > "$label.log" 2>&1
  status=$?
  set -e
  echo "$status" > "$label.status"
  tail -n 14 "$label.log"
  test "$status" = 0
}
run_bounded "$@"
