#!/usr/bin/env bash
# Run as grhreplay in its own low-priority systemd unit. The original source workspace is read-only input here.
set -eu -o pipefail
runner=${1:?path to the immutable binary_endpoint.py}
state=${2:?new evidence directory owned by grhreplay}
test "$(id -un)" = grhreplay
test -d "$state"
test "$(readlink /proc/self/fd/8)" = /run/lock/tg-joint-dispatch.lock
exec 9>"$state/checker.lock"
flock -n 9 || exit 0
exec >>"$state/watcher.log" 2>&1
test ! -e "$state/proof" || exit 0
echo "65ce0a4ace395459efa319eba1bff721e0158c71e31f2b674827ac4b013bdaa7  $runner" | sha256sum -c -
readonly commit=24954b2814714e7fe324bcdc0304c0a9ddefb909
readonly tree=ffbd19a22cf91aab3933995029b20d5cbce0a246
readonly token=7ef89dafd4de4d2473336f60c2c16246
readonly original=33006912706042b49c1ddbc13515a4fb
readonly dir="/work/tg-warm-diagnostics/$commit-$token"
readonly repo="/var/lib/tg-warm-main/session-$original/jobs/$token/candidate.git"
readonly packages="/work/compact-joint-runs/d6b1bfd523e2c54b6e4bb72844deeddf8341879a-$original/run/source/.lake/packages"
readonly module=ProductPrefix564386325504
readonly tool=/work/compact-joint-435-verified-tools/lean-4.35.0-linux
readonly obj="$dir/source/.lake/build/lib/lean/$module"
# Warm_main launches the Ubuntu host's bwrap from PATH. Verify the root-owned, installed package before digest pinning.
readonly bw=/usr/bin/bwrap
test -x "$bw" && test "$(stat -Lc %u "$bw")" = 0
dpkg-query -S "$bw"
package_md5=$(awk '$2=="usr/bin/bwrap" {print $1}' /var/lib/dpkg/info/bubblewrap.md5sums)
test -n "$package_md5"
echo "$package_md5  $bw" | md5sum -c -
ldd "$bw"
sha256sum "$bw" "$tool/bin/leanchecker" "$tool/bin/nanoda_bin"
readonly bwsha=$(sha256sum "$bw" | cut -d' ' -f1)
readonly deadline=1795688244
readonly queue="/var/lib/tg-warm-main/session-$original"
readonly long_gate="$(dirname "$runner")/allow-long-after-primary-queue"
echo "$(date -u +%FT%TZ) Waiting for logged Lake completion and all stored proof facets"
while (( $(date +%s) < deadline - 65 )); do
  if [[ -s "$obj.olean" && -s "$obj.olean.private" && -s "$obj.olean.server" && -s "$obj.trace" ]] &&
     grep -Eq " (Built|Replayed) ${module}([[:space:]]|$)" "$dir/warm-main.log"; then
    # FD 8 was opened read-only by root before setpriv. It has not been locked while waiting.
    if ! flock -s -w 1 8; then sleep 2; continue; fi
    if [[ -f "$queue/closed" ]] && grep -qxF "$(cat /proc/sys/kernel/random/boot_id)" "$queue/closed"; then
      echo 'Supervisor already closed this boot; no proof verdict.'
      exit 3
    fi
    remaining=$((deadline - $(date +%s) - 60))
    if (( remaining <= 0 )); then exit 124; fi
    if [[ ! -f "$long_gate" || -L "$long_gate" || "$(stat -Lc %u "$long_gate")" != 0 ]] ||
       ! grep -qxF "$token" "$long_gate"; then
      # Regular warm enqueues also need the dispatch lock exclusively.
      if (( remaining > 240 )); then remaining=240; fi
    fi
    echo "$(date -u +%FT%TZ) Starting bounded stock replay, budget ${remaining}s"
    exec python3 -B "$runner" --repo "$repo" --commit "$commit" --tree "$tree" --source-tree "$dir/source" \
      --packages "$packages" --toolchain "$tool" --bwrap "$bw" --bwrap-sha256 "$bwsha" \
      --expected-object-sha256 "$(sha256sum "$obj.olean" | cut -d' ' -f1)" \
      --out "$state/proof" --deadline-seconds "$remaining"
  fi
  sleep 5
done
echo "$(date -u +%FT%TZ) Deadline preceded eligible endpoint. No proof verdict."
exit 124
