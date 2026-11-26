#!/usr/bin/env python3
"""Dispatch the private stock Elan and Licensee setup to the existing retained host."""
import argparse
import base64
import hashlib
import importlib
import re
import shlex
import sys
import tempfile
import urllib.request
from pathlib import Path

PIN = "0b4f8c36092d95240e4ee5f0c2e68d1ec8b25c39"
POLICY = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
SHA = "cf7c9e67638a7b974266e70eb2a9ca203a831c3b27a034a9390d974704822cfc"
PYTHON_VERIFIED = "/opt/palomar-verifier-14aa8d6b/venv/bin/python"
SOURCE = "https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/"
URL = SOURCE+PIN+"/verification/community-grh/compact"
HASHES = {"warm_dispatch.py":"3b332604b176e351566374c12f11851c0f3fcd5f62bd6d0a7309b2f1e7d2ffb3",
          "warm_supervisor.py":"37a6b50079fdf31ffc2a075c3dc5b448f83307f1cc3e0e6a2f121a2e0b918c0c"}
STATE = "/var/lib/tg-palomar-lean-license-"+SHA[:12]
WORK = "/work/tg-palomar-lean-license-"+SHA[:12]
RUNTIME = "/opt/palomar-verifier-14aa8d6b/lean-license-runtime"
UNIT = "tg-palomar-lean-license-"+SHA[:12]
DEADLINE = 1795688244
PROBE = "/work/tg-palomar-stock-probe-bcb82c96512d/policy"

def service():
    return f"""#!/bin/bash
set -euo pipefail
umask 022
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
state={STATE}
work={WORK}
parent=/opt/palomar-verifier-14aa8d6b
policy={PROBE}
canonical={RUNTIME}
uid=$(id -u grhreplay)
gid=$(id -g grhreplay)
((uid > 0))
[[ -d $parent && ! -L $parent && $(stat -c %u "$parent") == 0 ]]
[[ ! -e $canonical && ! -L $canonical ]]
[[ -f /var/lib/tg-palomar-stock-bcb82c96512d/probe.ok ]]
[[ -x {PYTHON_VERIFIED} ]]
[[ -f /work/compact-joint-435-verified-tools/.ready ]]
owned_dir() {{
  if [[ ! -e $1 && ! -L $1 ]]; then mkdir -m 0755 "$1"; fi
  [[ -d $1 && ! -L $1 && $(stat -c %u:%a "$1") == 0:755 ]]
}}
owned_dir "$work"
owned_dir "$state/stage"
owned_dir "$state/license"
owned_dir "$parent/lean-license-installs"
attempt=$(mktemp -d "$parent/lean-license-installs/attempt-XXXXXXXX")
chown "$uid:$gid" "$attempt"
chmod 0755 "$attempt"
printf 'Attempt directory %s\\n' "$attempt"
archive="$state/installer.tgz"
curl -fsSL --proto '=https' --tlsv1.2 --retry 2 --max-time 60 '{URL}/stock-runtime/palomar-lean-license-runtime.tgz' -o "$archive"
printf '%s  %s\\n' '{SHA}' "$archive" | sha256sum -c -
tar --no-same-owner -xzf "$archive" -C "$state/stage" provision.py release_tree.py tool-inputs.json
curl -fsSL --proto '=https' --tlsv1.2 --retry 2 --max-time 60 '{SOURCE}f4bef05f58e4c4360e9ac78e506b61a4815537b5/LICENSE' -o "$state/license/LICENSE"
printf '%s  %s\\n' 'cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30' "$state/license/LICENSE" | sha256sum -c -
account_home=$(getent passwd grhreplay | cut -d: -f6)
as_prover() {{ runuser -u grhreplay -- env -i HOME="$account_home" PATH="$PATH" LANG=C.UTF-8 PYTHONDONTWRITEBYTECODE=1 "$@"; }}
as_prover /usr/bin/python3 -B "$state/stage/provision.py" --prefix "$attempt" --pipeline "$policy" \\
 --lean-root /work/compact-joint-435-verified-tools/lean-4.35.0-linux
as_prover /bin/bash -c 'set -eu; . "$1/activate.sh"; exec "$2" -B - "$3" "$1" "$4" "$5"' \\
 sh "$attempt" {PYTHON_VERIFIED} "$policy" "$state/license" "$attempt/host-stock-api.json" <<'PYTHON'
import hashlib,json,os,subprocess,sys
from pathlib import Path
policy,path,fixture,out=map(Path,sys.argv[1:])
sys.path.insert(0,str(policy))
from scripts import verify_submission as v
bundle=path/"bin"/"bundle"
spdx=v.detect_spdx_identifier(fixture,bundle)
prefix=Path(subprocess.check_output(["lean","--print-prefix"],cwd=path/"toolchain-selection",text=True).strip()).resolve()
tools=v.toolchain_tools(prefix)
primitives=v.primitive_targets(prefix)
assert os.geteuid()!=0 and spdx=="Apache-2.0" and len(primitives)==26 and len(tools)==6
out.write_text(json.dumps({{"uid":os.geteuid(),"spdx":spdx,"primitive_count":len(primitives),"tool_sha256":{{k:hashlib.sha256(f.read_bytes()).hexdigest() for k,f in tools.items()}}}},sort_keys=True,indent=2)+"\\n")
PYTHON
for file in toolchain-readiness.json host-stock-api.json; do
  [[ -f $attempt/$file && ! -L $attempt/$file ]]
  install -m 0644 "$attempt/$file" "$work/$file"
done
# Activation always points to the unique tested installation. A rerun never overwrites it.
ln -sT "$attempt" "$canonical"
(cd "$work" && sha256sum toolchain-readiness.json host-stock-api.json > SHA256SUMS)
install -m 0644 "$work/SHA256SUMS" "$state/complete"
date -u '+Provisioned %FT%TZ'
cat "$state/complete"
"""

def payload(volume):
    if not re.fullmatch(r"vol-[0-9a-f]{17}",volume):
        raise ValueError("Unexpected evidence volume ID")
    child=service().encode(); encoded=base64.b64encode(child).decode(); digest=hashlib.sha256(child).hexdigest()
    shell=f"""set -euo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
mountpoint -q /work
dev=$(findmnt -n -o SOURCE --target /work)
[[ $(lsblk -dnro SERIAL "$dev" | tr -d '[:space:]-') == {volume.replace('-','')} ]]
[[ $(df -B1 --output=avail /opt | tail -1) -ge 1073741824 ]]
[[ $(df -B1 --output=avail /work | tail -1) -ge 1073741824 ]]
[[ -f /var/lib/tg-palomar-stock-bcb82c96512d/probe.ok ]]
state={STATE}
if [[ ! -e $state && ! -L $state ]]; then mkdir -m 0755 "$state"; fi
[[ -d $state && ! -L $state && $(stat -c %u:%a "$state") == 0:755 ]]
exec 9>/run/lock/tg-palomar-lean-license-{SHA[:12]}.lock
flock -x 9
if [[ -f $state/complete ]]; then cat "$state/complete"; exit 0; fi
if systemctl is-active --quiet {UNIT}.service; then echo '{UNIT} active'; exit 0; fi
remaining=$(({DEADLINE} - $(date -u +%s) - 60))
((remaining > 240))
if ((remaining > 900)); then remaining=900; fi
printf %s '{encoded}' | base64 -d > "$state/run.sh"
printf '%s  %s\\n' '{digest}' "$state/run.sh" | sha256sum -c --quiet -
systemd-run --quiet --collect --unit={UNIT} --property=CPUQuota=100% --property=CPUWeight=15 --property=IOWeight=15 --property=Nice=15 --property=MemoryHigh=1G --property=MemoryMax=2G --property=MemorySwapMax=0 --property=TasksMax=160 --property="RuntimeMaxSec=$remaining" --property=TimeoutStopSec=10 --property=KillMode=control-group --property="StandardOutput=append:$state/setup.log" --property="StandardError=append:$state/setup.log" /bin/bash "$state/run.sh"
printf 'Queued %s; log %s/setup.log\\n' '{UNIT}' "$state"
"""
    return "/bin/bash -c "+shlex.quote(shell)

def dispatch(mode,warm):
    if warm.SCHEDULE!="at(2026-11-26T10:17:24)" or warm.worker.DEADLINE!=DEADLINE:
        raise RuntimeError("Wrong retained-host deadline")
    state, volume=warm.validate_cloud()
    if state!="running":raise RuntimeError("Retained host is not running")
    if mode=="start":return warm.ssm(payload(volume))
    return warm.ssm("systemctl show "+UNIT+".service -p ActiveState -p Result; if test -f "+STATE+"/setup.log; then tail -16 "+STATE+"/setup.log; fi; if test -f "+STATE+"/complete; then cat "+STATE+"/complete; fi")

def main():
    parser=argparse.ArgumentParser();parser.add_argument("mode",choices=("start","status"));args=parser.parse_args()
    sys.dont_write_bytecode=True
    with tempfile.TemporaryDirectory(prefix="palomar-existing-worker-") as folder:
        for file,digest in HASHES.items():
            with urllib.request.urlopen(URL+"/warm-main/incremental/"+file,timeout=30) as response:body=response.read(240000)
            if hashlib.sha256(body).hexdigest()!=digest:raise RuntimeError("Warm operator digest mismatch")
            (Path(folder)/file).write_bytes(body)
        sys.path.insert(0,folder);print(dispatch(args.mode,importlib.import_module("warm_dispatch")))
if __name__=="__main__":main()
