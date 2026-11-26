#!/usr/bin/env python3
"""Queue one stock prepare-only source rehearsal, or retrieve its receipt, on the retained host."""
import argparse
import hashlib
import importlib
from pathlib import Path
import re
import shlex
import sys
import tempfile
import urllib.request

BOOTSTRAP = "0b4f8c36092d95240e4ee5f0c2e68d1ec8b25c39"
PROBE = "bcb82c96512d"
POLICY = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
WORKER = "8d292e16165ab800b5895dd944d1bcd66e1340b65c7af3e5090f969030d5d32c"
F850 = "f85040a7a5263b32cce873ac345010a7d0f1f2b9"
TREE = "728ed945f3e4e2a7c48d7ff0c01412cf43cc2ff9"
BASE = "https://raw.githubusercontent.com/elliotglazer/ternary-goldbach"
PATH = "verification/community-grh/compact"
DEADLINE = 1795688244
HELPERS = {"warm_dispatch.py":"3b332604b176e351566374c12f11851c0f3fcd5f62bd6d0a7309b2f1e7d2ffb3",
           "warm_supervisor.py":"37a6b50079fdf31ffc2a075c3dc5b448f83307f1cc3e0e6a2f121a2e0b918c0c"}
def payload(release,commit,tree,volume,mode):
    if not all(re.fullmatch("[0-9a-f]{40}", value) for value in (release,commit,tree)) or not re.fullmatch("vol-[0-9a-f]{17}",volume):
        raise ValueError("Invalid immutable commit, tree or retained volume")
    if commit==F850 and tree!=TREE:
        raise ValueError("Wrong f850 tree")
    state="/var/lib/tg-stock-intake-"+commit[:12]
    head=f"""set -euo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
state='{state}'
cutoff={DEADLINE}
unit=tg-stock-intake-{commit[:12]}
mountpoint -q /work
dev=$(findmnt -n -o SOURCE --target /work)
[[ $(lsblk -dnro SERIAL "$dev" | tr -d '[:space:]-') == '{volume.replace("-","")}' ]]
"""
    if mode=="status":
        return "/bin/bash -c "+shlex.quote(head+'''systemctl show "$unit.service" -p ActiveState -p Result || :
if test -f "$state/last"; then
  r=$(cat "$state/last")
  if test -f "$r/console.log"; then tail -18 "$r/console.log"; fi
  if test -f "$r/user/attempt/SHA256SUMS"; then cat "$r/user/attempt/SHA256SUMS"; fi
  printf 'Evidence: %s\n' "$r"
fi''')
    if mode!="start":
        raise ValueError("Unknown mode")
    shell=head+f"""umask 022
remaining=$((cutoff-$(date -u +%s)-60))
((remaining>240))
((remaining<=1200)) || remaining=1200
[[ -f /var/lib/tg-palomar-stock-{PROBE}/probe.ok ]]
[[ -f /var/lib/tg-palomar-lean-license-cf7c9e67638a/complete ]]
[[ $(df -B1 --output=avail /work | tail -1) -ge 21474836480 ]]
exec 9>/run/lock/tg-stock-intake-{commit[:12]}.lock
flock -x 9
if systemctl is-active --quiet "$unit.service"; then echo "Already running $unit"; exit 0; fi
if [[ ! -e $state && ! -L $state ]]; then mkdir -m 0755 "$state"; fi
[[ -d $state && ! -L $state && $(stat -c %u:%a "$state") == 0:755 ]]
top=/work/tg-palomar-stock-source-rehearsals
if [[ ! -e $top && ! -L $top ]]; then mkdir -m 0755 "$top"; fi
[[ -d $top && ! -L $top && $(stat -c %u:%a "$top") == 0:755 ]]
attempt=$(mktemp -d "$top/{commit[:12]}-XXXXXXXX")
chmod 0755 "$attempt"
start=$(date -u +%s)
printf '{{"mode":"prepare","commit":"{commit}","tree":"{tree}","job_started_at_epoch":%s,"host_deadline_epoch":{DEADLINE},"setup_basis":"preprovisioned"}}\n' "$start" > "$attempt/clock.json"
printf '%s\n' "$attempt" > "$state/last"
install -d -o grhreplay -g grhreplay -m 0700 "$attempt/user"
curl -fsSL --proto '=https' --tlsv1.2 --max-time 60 --retry 2 '{BASE}/{release}/{PATH}/stock-runtime/stock_rehearsal_job.py' -o "$attempt/job.py"
printf '%s  %s\n' '{WORKER}' "$attempt/job.py" | sha256sum -c --quiet -
cat > "$attempt/prepare.sh" <<'INNER'
set -euo pipefail
root=/opt/palomar-verifier-14aa8d6b
export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null GIT_TERMINAL_PROMPT=0 PYTHONDONTWRITEBYTECODE=1
. "$root/lean-license-runtime/activate.sh"
cd "$1/user"
git init -q policy
git -C policy -c core.hooksPath=/dev/null fetch -q --no-tags --depth=1 https://github.com/PalomarRegistry/PalomarSubmission.git {POLICY}
git -C policy -c core.hooksPath=/dev/null checkout -q --detach FETCH_HEAD
exec "$root/venv/bin/python" -B "$1/job.py" prepare \
 --directory "$1/user/attempt" --policy "$1/user/policy" --clock "$1/clock.json" \
 --bundle "$root/lean-license-runtime/bin/bundle" --commit '{commit}' --tree '{tree}'
INNER
systemd-run --quiet --collect --unit="$unit" --property=User=grhreplay --property=CPUQuota=100% --property=CPUWeight=10 \
 --property=IOWeight=10 --property=Nice=15 --property=MemoryMax=2G --property=MemorySwapMax=0 --property=TasksMax=100 \
 --property="RuntimeMaxSec=$remaining" --property=KillMode=control-group --property="StandardOutput=append:$attempt/console.log" \
 --property="StandardError=append:$attempt/console.log" -- /bin/bash "$attempt/prepare.sh" "$attempt"
printf 'Queued stock source preparation as grhreplay. Evidence %s\n' "$attempt"
"""
    return "/bin/bash -c "+shlex.quote(shell)

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("mode",choices=("start","status"))
    p.add_argument("--release",required=True,help="Immutable commit containing this script and its worker.")
    p.add_argument("--commit",default=F850)
    p.add_argument("--tree",default=TREE)
    args=p.parse_args()
    sys.dont_write_bytecode=True
    with tempfile.TemporaryDirectory(prefix="stock-intake-") as tmp:
        for file,sha in HELPERS.items():
            with urllib.request.urlopen(f"{BASE}/{BOOTSTRAP}/{PATH}/warm-main/incremental/{file}",timeout=30) as r:
                data=r.read(240000)
            if hashlib.sha256(data).hexdigest()!=sha:
                raise ValueError("Operator helper digest did not match")
            (Path(tmp)/file).write_bytes(data)
        sys.path.insert(0,tmp)
        warm=importlib.import_module("warm_dispatch")
        if warm.worker.DEADLINE!=DEADLINE or warm.SCHEDULE!="at(2026-11-26T10:17:24)":
            raise ValueError("Original host deadline mismatch")
        active,vol=warm.validate_cloud()
        if active!="running":
            raise ValueError("Retained host is not running")
        print(warm.ssm(payload(args.release,args.commit,args.tree,vol,args.mode)))

if __name__=="__main__":
    main()
