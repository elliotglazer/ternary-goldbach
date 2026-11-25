#!/bin/bash
set -Eeuo pipefail
exec > >(tee -a /var/log/tg-bootstrap.log /dev/console) 2>&1
systemd-run --unit=tg-deadline --on-active=12h /usr/bin/systemctl poweroff
device=/dev/disk/by-id/nvme-Amazon_Elastic_Block_Store___DATA_VOLUME__
for i in $(seq 1 120); do [[ -b "$device" ]] && break; sleep 2; done
[[ -b "$device" && "$(lsblk -dnro TYPE "$device")" == disk ]]
[[ -z "$(lsblk -nro MOUNTPOINT "$device" | tr -d '[:space:]')" ]]
[[ -z "$(wipefs --noheadings --output TYPE "$device")" ]]
mkfs.ext4 -q -m 1 -L tg-replay "$device"
mkdir -p /work
uuid=$(blkid -s UUID -o value "$device")
echo "UUID=$uuid /work ext4 defaults 0 2" >> /etc/fstab
mount /work
exec > >(tee -a /work/bootstrap.log /dev/console) 2>&1
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq elan bubblewrap git python3 time curl zstd build-essential ca-certificates jq unzip rsync apparmor iptables
useradd --create-home --home-dir /work/home --shell /bin/bash grhreplay
install -d -o grhreplay -g grhreplay /work/tmp
install -d -m 0755 /work/runner
chmod 1777 /work
sysctl -w vm.max_map_count=1048576
# Permit this installed binary to create the user namespace needed for upstream sandboxed builds.
if [[ -f /proc/sys/kernel/apparmor_restrict_unprivileged_userns ]] && [[ $(cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns) = 1 ]]; then
  cat >/etc/apparmor.d/tg-bwrap <<'PROFILE'
abi <abi/4.0>,
include <tunables/global>
profile tg-bwrap /usr/bin/bwrap flags=(unconfined) {
  userns,
}
PROFILE
  if [[ -f /etc/apparmor.d/bwrap ]]; then
    apparmor_parser -r /etc/apparmor.d/bwrap
  else
    apparmor_parser -r /etc/apparmor.d/tg-bwrap
  fi
fi
iptables -I OUTPUT -m owner --uid-owner grhreplay -d 169.254.169.254 -j REJECT
runuser -u grhreplay -- env HOME=/work/home elan toolchain install leanprover/lean4:v4.37.0-rc1
runuser -u grhreplay -- env HOME=/work/home elan default leanprover/lean4:v4.37.0-rc1
install -d -m 0700 /root/tg-upload
touch /work/bootstrap-ready
echo 'TG bootstrap ready'

