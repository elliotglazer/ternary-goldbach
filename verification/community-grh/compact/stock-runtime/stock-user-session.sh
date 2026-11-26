#!/usr/bin/env bash
# Run one command as grhreplay through a dedicated, nonpersistent systemd unit.
set -euo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
readonly user=grhreplay root=/opt/palomar-verifier-14aa8d6b
[[ $EUID == 0 && $(cat /proc/1/comm) == systemd ]] || { echo 'Expected a systemd host and a root launcher.' >&2; exit 1; }
[[ $# -ge 1 && $1 == /* ]] || { echo 'Usage: stock-user-session.sh /absolute/command [args...]' >&2; exit 2; }
uid=$(id -u "$user"); home=$(getent passwd "$user" | cut -d: -f6)
[[ $uid -gt 0 && -d $home ]]
unit="palomar-grhreplay-$(date +%s)-$$"
# The dependency access lasts for this unit. Do not enable linger or stop an
# existing manager. Preserve the command and all arguments verbatim.
exec systemd-run --quiet --wait --pipe --collect --unit="$unit" \
  --property="User=$user" --property="Requires=user@$uid.service" \
  --property="After=user@$uid.service" --property="WorkingDirectory=$home" \
  --setenv="HOME=$home" --setenv="XDG_RUNTIME_DIR=/run/user/$uid" \
  --setenv="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus" \
  --setenv="PATH=$root/venv/bin:$home/.elan/bin:/usr/local/bin:/usr/bin:/bin" \
  -- "$@"
