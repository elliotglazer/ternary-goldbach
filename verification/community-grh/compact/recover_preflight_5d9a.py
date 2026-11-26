#!/usr/bin/env python3
"""Recover the completed GRH preflight receipt and full log on the next worker boot."""
import base64
import gzip
import inspect
import json
import os
from pathlib import Path
import re
import stat
import tempfile
import zipfile

import recover_d69a_ebs as wire

PIN = "e9f3c8adb418f4e497787ef93175066acb1c8f72"
TREE = "5666784d088ba92460d084ddd8ac9ab8ac568a99"
ATTEMPT = "5d9ac7f8089149f5a3f9b9852ceb43df"
WORKER = "d9b3b1a3b1b4a97e7766349c0c6dfcc5e0eab6071935321482d2d91bdbaccf67"
ROOT = Path("/work/compact-joint-runs") / (PIN + "-" + ATTEMPT)
FILES = {"receipt.json": "run/evidence/receipt.json",
         "source-preflight.log": "run/evidence/source-preflight.log", "driver.exit": "driver.exit"}


def validate(files):
    receipt = json.loads(files["receipt.json"])
    expected = {"root": str(ROOT / "run"), "pin": PIN, "git_tree": TREE,
                "runner_sha256": WORKER, "status": "failed"}
    wire.need(all(receipt.get(key) == value for key, value in expected.items()), "Receipt identity mismatch")
    stages = [step for step in receipt["steps"] if step["name"] == "source-preflight"]
    wire.need(len(stages) == 1 and int(stages[0]["exit"]) > 0, "Missing terminal preflight failure")
    wire.need(stages[0]["log_sha256"] == wire.sha(files["source-preflight.log"]), "Log digest mismatch")
    wire.need(re.fullmatch(rb"[1-9][0-9]{0,2}\s*", files["driver.exit"]), "Missing nonzero driver exit")
    return receipt, stages[0]


def collect():
    files = {name: wire.read(ROOT, path, wire.LIMIT) for name, path in FILES.items()}
    validate(files)
    return {name: base64.b64encode(data).decode() for name, data in files.items()}


def worker_script():
    # The remote interpreter receives only the pinned read/validate and paging routines.
    imports = "import base64,gzip,hashlib,json,os,re,stat,sys\nfrom pathlib import Path\nfrom types import SimpleNamespace\n"
    common = "\n".join(inspect.getsource(f) for f in [wire.need, wire.sha, wire.pack, wire.read, wire.response])
    conf = f"CHUNK={wire.CHUNK}\nLIMIT={wire.LIMIT}\nPIN={PIN!r}\nTREE={TREE!r}\nWORKER={WORKER!r}\n"
    conf += f"ROOT=Path({str(ROOT)!r})\nFILES={FILES!r}\n"
    body = "\nwire=SimpleNamespace(need=need,sha=sha,read=read,LIMIT=LIMIT)\n"
    body += inspect.getsource(validate) + "\n" + inspect.getsource(collect)
    body += "\nprint(pack(response(gzip.compress(pack(collect()), mtime=0), int(sys.argv[-1]))).decode())\n"
    return (imports + conf + common + body).encode()


def main():
    wire.need(wire.sha(Path(wire.__file__).read_bytes()) ==
              "71a265eae31f0c926aae7cdce24eabab07426267a68a11decd8a8fd275e1c4fa", "Transport digest mismatch")
    host = wire.aws("ec2", "describe-instances", "--instance-ids", wire.HOST)["Reservations"][0]["Instances"][0]
    wire.need(host["InstanceId"] == wire.HOST and host["State"]["Name"] == "running", "Waiting for the next proof boot")
    script = worker_script()
    encoded = wire.receive(lambda offset: wire.remote_page(script, offset))
    wire.need(set(encoded) == set(FILES), "Unexpected recovery files")
    files = {name: base64.b64decode(data, validate=True) for name, data in encoded.items()}
    receipt, stage = validate(files)
    os.umask(0o077)
    directory = Path(tempfile.mkdtemp(prefix="tg-5d9a-ebs-", dir=Path.home()))
    output = directory / "tg-5d9a-ebs.zip"
    with zipfile.ZipFile(output, "x", compression=zipfile.ZIP_DEFLATED) as archive:
        for name, data in files.items():
            archive.writestr(name, data)
    print("Download", output)
    print("SHA-256", wire.sha(output.read_bytes()))
    print("Full receipt", wire.sha(files["receipt.json"]), "driver exit", int(files["driver.exit"]))
    print("Full preflight log", stage["log_sha256"], "reported errors", receipt.get("failure_details", {}).get("source_error_count"))


if __name__ == "__main__":
    main()
