#!/usr/bin/env python3
"""Queue stock tool setup and a delegated-cgroup probe on the already-running retained host."""
import base64
import datetime
import hashlib
import re
import shlex
import sys

RESEARCH_PIN = "bcb82c96512d888635668989c9fcab4b23ed5d5b"
POLICY = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
DEADLINE = int(datetime.datetime(2026, 11, 26, 10, 17, 24, tzinfo=datetime.timezone.utc).timestamp())
FILES = {
    "bootstrap-stock-tools.sh": "58862c1e18fa08e1fb20d77c8ddce53a34f67d5f767860087b1b89a5c41a1fef",
    "stock-user-session.sh": "901f17ca74898b81c1a91afce93b9a54dbcc477ba0cd79833fee7a8afadc28a1",
    "probe-stock-user.sh": "b2407cde6963e2c608abf7edb0a1ae5620467d707edad3491fa97a051dfcad49",
    "README.md": "6539feeb35d9ad0f69c4c297566047ae48e9d664756490155c9951b8e5f83197",
    "bootstrap-review.json": "447126414cc37389c02fdbfc1cfbcfe29b032b49493a85d37a6322a037847710",
}
URL = "https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/" + RESEARCH_PIN + "/verification/community-grh/compact/stock-runtime"
STATE = "/var/lib/tg-palomar-stock-" + RESEARCH_PIN[:12]
WORK = "/work/tg-palomar-stock-probe-" + RESEARCH_PIN[:12]
UNIT = "tg-palomar-stock-setup-" + RESEARCH_PIN[:12]

def create_payload(volume):
    if not re.fullmatch(r"vol-[0-9a-f]{17}", volume):
        raise ValueError("Invalid retained volume")
    headers = f"base={shlex.quote(STATE)}\nwork={shlex.quote(WORK)}\ncutoff={DEADLINE}\nunit={UNIT}\n"
    validate = r"""
set -euo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
mountpoint -q /work
[[ $(date -u +%s) -lt $((cutoff-120)) ]]
[[ $(df -B1 --output=avail / | tail -1) -ge 2147483648 ]]
[[ $(df -B1 --output=avail /work | tail -1) -ge 21474836480 ]]
"""
    checksums = "".join(f"{h}  {name}\n" for name,h in FILES.items())
    body = "#!/usr/bin/env bash\n" + headers + validate + f"""
cd "$base"
for name in {' '.join(FILES)}; do
  curl --fail --silent --show-error --location --proto '=https' --tlsv1.2 --retry 2 \
    --max-time 75 '{URL}/'"$name" -o "$name.download"
  mv -T "$name.download" "$name"
done
sha256sum --check - <<'SUMS'
{checksums}SUMS
date -u '+setup-start %FT%TZ'
df -h / /work
/bin/bash "$base/bootstrap-stock-tools.sh"
id grhreplay
uid=$(id -u grhreplay)
[[ $uid -gt 0 ]]
"""+r"""
if [[ ! -e $work ]]; then mkdir -m 0755 "$work"; fi
[[ -d $work && ! -L $work && $(stat -c %u:%a "$work") == 0:755 ]]
for n in policy scratch; do
  p="$work/$n"
  if [[ ! -e $p && ! -L $p ]]; then install -d -o grhreplay -g grhreplay -m 0700 "$p"; fi
  [[ -d $p && ! -L $p && $(stat -c %u "$p") == "$uid" ]]
done
as_user() { runuser -u grhreplay -- env GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null GIT_TERMINAL_PROMPT=0 "$@"; }
"""+f"""
if ! as_user git -C "$work/policy" rev-parse --verify HEAD >/dev/null 2>&1; then
  as_user git -C "$work/policy" init -q
  as_user git -C "$work/policy" fetch -q --no-tags --depth=1 https://github.com/PalomarRegistry/PalomarSubmission.git {POLICY}
  as_user git -C "$work/policy" checkout -q --detach FETCH_HEAD
fi
[[ $(as_user git -C "$work/policy" rev-parse HEAD) == {POLICY} ]]
[[ -z $(as_user git -C "$work/policy" status --porcelain --untracked-files=normal) ]]
as_user test -w "$work/scratch"
"""+r"""
# Bound the nested, unprivileged probe even if its outer transient unit expires.
remaining=$((cutoff-$(date -u +%s)-45))
(( remaining >= 65 ))
(( remaining <= 120 )) || remaining=120
/bin/bash "$base/stock-user-session.sh" /usr/bin/timeout -k 5 "$remaining" \
  /usr/bin/nice -n 15 /usr/bin/prlimit --as=2147483648:2147483648 --cpu=90:90 -- \
  /bin/bash "$base/probe-stock-user.sh" "$work/policy" "$work/scratch"
printf 'Ruby/Bundler visible on service host\n'
for tool in ruby bundle; do command -v "$tool" || true; done
for bin in /opt/hostedtoolcache/Ruby/3.3.12/x64/bin/ruby /opt/hostedtoolcache/Ruby/3.3.12/x64/bin/bundle; do
  if [[ -x $bin ]]; then printf '%s\n' "$bin"; fi
done
date -u '+setup-and-delegation-pass %FT%TZ' | tee "$base/probe.ok"
"""
    raw = body.encode()
    encoded = base64.b64encode(raw).decode()
    top = headers + validate + f"""
dev=$(findmnt -n -o SOURCE --target /work)
[[ $(lsblk -dnro SERIAL "$dev" | tr -d '[:space:]-') == '{volume.replace('-','')}' ]]
exec 9>/run/lock/tg-palomar-stock-bootstrap.lock
flock -x 9
if [[ ! -e $base && ! -L $base ]]; then mkdir -m 0755 "$base"; fi
[[ -d $base && ! -L $base && $(stat -c %u:%a "$base") == 0:755 ]]
if [[ -s $base/probe.ok ]]; then cat "$base/probe.ok"; exit 0; fi
if systemctl is-active --quiet "$unit.service"; then printf 'Already running %s\n' "$unit.service"; exit 0; fi
printf '%s' '{encoded}' | base64 -d >"$base/host.sh"
echo '{hashlib.sha256(raw).hexdigest()}  '"$base/host.sh" | sha256sum --check --quiet
remaining=$((cutoff-$(date -u +%s)-60)); ((remaining>=180)); ((remaining<=1200)) || remaining=1200
systemd-run --quiet --collect --unit="$unit" --property=CPUQuota=200% --property=CPUWeight=15 \
 --property=IOWeight=15 --property=Nice=15 --property=MemoryHigh=2G --property=MemoryMax=3G \
 --property=MemorySwapMax=0 --property=TasksMax=160 --property="RuntimeMaxSec=$remaining" \
 --property=TimeoutStopSec=10 --property=KillMode=control-group \
 --property="StandardOutput=append:$base/setup.log" --property="StandardError=append:$base/setup.log" \
 -- /bin/bash "$base/host.sh"
printf 'Queued %s (max %ss). Log %s/setup.log\n' "$unit.service" "$remaining" "$base"
"""
    return body, "/bin/bash -c " + shlex.quote(top)


def main():
    import warm_dispatch as warm
    if warm.SCHEDULE != "at(2026-11-26T10:17:24)" or warm.worker.DEADLINE != DEADLINE:
        raise SystemExit("Existing warm helper refers to a different deadline.")
    mode = sys.argv[1] if len(sys.argv) == 2 else ""
    if mode not in {"start", "status"}:
        raise SystemExit("Usage: stock_runtime_dispatch.py start|status")
    if mode == "status":
        print(warm.ssm("systemctl show "+UNIT+".service -p ActiveState -p Result; if test -f "+STATE+"/setup.log; then tail -24 "+STATE+"/setup.log; fi; if test -f "+STATE+"/probe.ok; then cat "+STATE+"/probe.ok; fi"))
        return
    state, volume = warm.validate_cloud()
    if state != "running":
        raise SystemExit("The retained host is not running. No start was requested.")
    _, cmd = create_payload(volume)
    print(warm.ssm(cmd))

if __name__ == "__main__":
    main()
