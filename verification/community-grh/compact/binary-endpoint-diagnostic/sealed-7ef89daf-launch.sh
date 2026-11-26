#!/usr/bin/env bash
# Install both verified scripts into /run/tg-binary-7ef89daf before calling this as root.
set -eu -o pipefail
readonly bin=/run/tg-binary-7ef89daf
readonly store=/work/tg-binary-7ef89daf-evidence
readonly unit=tg-binary-7ef89daf
test "$(id -u)" = 0
echo "db49cab8004edfece9b8a6009d90e2b68fc7b508e008ceda03daa91fd8fcdb70  $bin/sealed-7ef89daf-watcher.sh" | sha256sum -c -
echo "65ce0a4ace395459efa319eba1bff721e0158c71e31f2b674827ac4b013bdaa7  $bin/binary_endpoint.py" | sha256sum -c -
install -d -m 0755 -o grhreplay -g grhreplay "$store"
if systemctl is-active --quiet "$unit" || test -e "$store/proof/receipt.json"; then exit 0; fi
runtime=$((1795688244 - $(date +%s) - 40))
if (( runtime <= 30 )); then exit 124; fi
systemd-run --collect --unit="$unit" -p CPUQuota=100% -p CPUWeight=idle -p Nice=15 -p IOWeight=10  -p MemoryHigh=12G -p MemoryMax=24G -p MemorySwapMax=0 -p OOMScoreAdjust=600 -p KillMode=mixed  -p TimeoutStopSec=10 -p "RuntimeMaxSec=$runtime" /bin/bash -ec  'exec 8</run/lock/tg-joint-dispatch.lock; exec setpriv --reuid=grhreplay --regid=grhreplay --init-groups -- /bin/bash "$1" "$2" "$3"'  bash "$bin/sealed-7ef89daf-watcher.sh" "$bin/binary_endpoint.py" "$store"
