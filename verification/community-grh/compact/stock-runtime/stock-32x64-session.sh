#!/usr/bin/env bash
# Enter the 32 CPU / 64 GiB profile for the trusted verifier as grhreplay.
set -euo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
user=grhreplay
root=/opt/palomar-verifier-14aa8d6b
[[ $EUID == 0 && $(cat /proc/1/comm) == systemd && $# -ge 1 && $1 == /* ]]
uid=$(id -u "$user")
home=$(getent passwd "$user" | cut -d: -f6)
[[ $uid -gt 0 && -d $home ]]
exec systemd-run --quiet --wait --pipe --collect --unit="palomar-32x64-$(date +%s)-$$" \
  --property="User=$user" --property="Requires=user@$uid.service" --property="After=user@$uid.service" \
  --property="WorkingDirectory=$home" --property=CPUQuota=3200% --property=MemoryMax=64G \
  --property=MemorySwapMax=0 --setenv="HOME=$home" --setenv="XDG_RUNTIME_DIR=/run/user/$uid" \
  --setenv="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus" \
  --setenv="PATH=$root/venv/bin:$home/.elan/bin:/usr/local/bin:/usr/bin:/bin" \
  --setenv=PALOMAR_EXECUTION_PROFILE=palomar-namespace-32x64-v1 -- "$@"
