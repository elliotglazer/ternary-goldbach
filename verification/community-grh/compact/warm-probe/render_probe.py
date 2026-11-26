#!/usr/bin/env python3
"""Render a bounded command for one retained worker. This program never calls AWS."""
import argparse
import base64
import gzip
import hashlib
from pathlib import Path
import shlex

parser = argparse.ArgumentParser(description=__doc__)
for name in ("commit", "tree", "attempt", "module", "sha256"):
    parser.add_argument("--" + name, required=True)
parser.add_argument("--source", required=True, type=Path)
args = parser.parse_args()
source = args.source.read_bytes()
if hashlib.sha256(source).hexdigest() != args.sha256:
    parser.error("Replacement SHA-256 mismatch")
worker = Path(__file__).with_name("warm_probe.py").read_bytes()
encode = lambda data: base64.b64encode(gzip.compress(data, mtime=0)).decode()
worker_sha = hashlib.sha256(worker).hexdigest()
program = (
    "import base64,gzip,hashlib;"
    f"source=gzip.decompress(base64.b64decode('{encode(worker)}'));"
    f"assert hashlib.sha256(source).hexdigest()=='{worker_sha}';"
    "exec(compile(source,'warm_probe.py','exec'))"
)
cli = [
    "systemd-run", "--quiet", "--wait", "--pipe", "--collect", "--unit=tg-warm-patch-probe",
    "--uid=grhreplay", "--gid=grhreplay", "-p", "CPUQuota=80%", "-p", "CPUWeight=1",
    "-p", "Nice=19", "-p", "IOWeight=1", "-p", "MemoryHigh=8G", "-p", "MemoryMax=10G",
    "-p", "MemorySwapMax=0", "-p", "RuntimeMaxSec=240", "-p", "TasksMax=48",
    "-p", "LimitFSIZE=134217728", "-p", "KillMode=control-group", "-p", "TimeoutStopSec=3",
    "--", "/usr/bin/python3", "-B", "-c", program,
    "--commit", args.commit, "--tree", args.tree, "--attempt", args.attempt,
    "--module", args.module, "--sha256", args.sha256, "--data", encode(source),
]
text = shlex.join(cli)
if len(text.encode()) >= 23000:
    parser.error("Rendered command exceeds the single-transfer size bound")
print(text)
