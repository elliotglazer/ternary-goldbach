#!/bin/bash
set -Eeuo pipefail
exec > >(tee -a /work/driver.log /dev/console) 2>&1
finish() {
  rc=$?
  printf '%s\n' "$rc" > /work/driver.exit
  if [[ -f /work/replay/evidence/receipt.json ]]; then
    sha256sum /work/replay/evidence/receipt.json | tee /work/receipt.sha256
  fi
  sync
  systemctl --no-block poweroff
}
trap finish EXIT
[[ -f /work/bootstrap-ready ]]
ulimit -n 65536
runuser -u grhreplay -- env HOME=/work/home TMPDIR=/work/tmp PATH=/work/home/.elan/bin:/usr/local/bin:/usr/bin:/bin python3 /work/runner/grh_source.py --run-dir /work/replay

