#!/usr/bin/env bash
set -euo pipefail
umask 077
cd /var/lib/goldbach
export DEBIAN_FRONTEND=noninteractive
export HOME=/root
exec >>worker.log 2>&1
stamp() {
  {
    printf '%s %s\n' "$(date -u +%FT%TZ)" "$1"
    df -B1 / | tail -n1
    cat /proc/net/dev
    for d in /root/.elan /var/lib/goldbach/goldbach-wide/{.lake,run-small,run-large}; do
      if [[ -d "$d" ]]; then du -sb "$d"; fi
    done
  } >>/var/lib/goldbach/metrics.log
}
stage() {
  local label="$1"
  shift
  echo "$label" > /var/lib/goldbach/phase
  stamp "$label"
  /usr/bin/time -a -o /var/lib/goldbach/timings.tsv -f "$label %e %U %S %M %x" "$@"
}
submit() {
  python3 /var/lib/goldbach/report.py "$1" "${2:-0}"
}
finish() {
  local code=$?
  trap - EXIT
  if [[ -n "${publisher:-}" ]]; then kill "$publisher" 2>/dev/null || true; wait "$publisher" 2>/dev/null || true; fi
  stamp finished
  submit final "$code" || echo 'Final receipt upload failed' >/dev/console
  systemctl poweroff
}
trap finish EXIT
echo start > phase
submit progress
(while sleep 180; do submit progress || true; done) &
publisher=$!
{ uname -a; lscpu; } > hardware.txt
stamp apt
apt-get -o Acquire::Retries=3 update
apt-get -o Acquire::Retries=3 install -y --no-install-recommends elan build-essential git curl ca-certificates zstd unzip time
tar xzf goldbach-4e15-wide-linux.tar.gz
cd goldbach-wide
stage toolchain elan toolchain install leanprover/lean4:v4.35.0
stage bootstrap bash wide/bootstrap.sh
stage small python3 wide/run_wide.py wide/w8192 run-small
stage large python3 wide/run_wide.py wide/w262144 run-large
