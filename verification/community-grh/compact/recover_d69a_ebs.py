#!/usr/bin/env python3
"""Recover the stopped d69a attempt's evidence on a later, already-running EC2 boot."""
import base64
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
import re
import shlex
import stat
import subprocess
import sys
import tempfile
import time
import zipfile

HOST = "i-0e7d3f1a40dbca69c"
PIN = "0b68b493791e5f7569021f0cd13454151af47584"
TREE = "6d8764b58d1a41584cd5d43fd3e400f6ee55d18e"
ATTEMPT = "d69a0b0ad9464dbc84198f6c547221c7"
ROOT = Path("/work/compact-joint-runs") / (PIN + "-" + ATTEMPT)
WORKER = "70afda55bfd8f96bd8be043a092da4cd7d1d39aaf3438fe135a8e7964c4ff263"
INTENT = "518f8dd2d9ac0287483f80a6fcdcf629a79f1247d605f9a49e2061a4a2546eee"
PREFIXES = {81282: "bfd8836e864b164ae5820b7d83d943f9b97dd6211dff116fa648eca80d1f6577",
            242565: "5a85ff057e14f2e696f014a99285d12e883b4b8ece7ca2a3da9406d30db979ca"}
RECEIPT = "run/evidence/receipt.json"
INTENT_PATH = "operator-interrupt-joint-lake-intent-v1.json"
CHUNK = 11520
LIMIT = 2 * 1024**2


def need(test, message):
    if not test:
        raise ValueError(message)


def sha(raw):
    return hashlib.sha256(raw).hexdigest()


def pack(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":")).encode()


def inflate(raw, limit):
    with gzip.GzipFile(fileobj=io.BytesIO(raw)) as stream:
        result = stream.read(limit + 1)
    need(len(result) <= limit, "Decompressed bytes exceed bound")
    return result


def read(root, rel, maximum):
    path = root / rel
    need(path.resolve() == path and stat.S_ISREG(path.stat().st_mode), "Unexpected file " + rel)
    with path.open("rb") as stream:
        size = os.fstat(stream.fileno()).st_size
        need(size <= maximum, "File exceeds bound " + rel)
        raw = stream.read(size + 1)
    need(len(raw) == size, "File changed during retrieval " + rel)
    return raw


def identify(receipt):
    expected = (str(ROOT / "run"), PIN, TREE, WORKER, "failed")
    actual = tuple(receipt.get(key) for key in ("root", "pin", "git_tree", "runner_sha256", "status"))
    need(actual == expected, "Full receipt does not match the failed original attempt and worker")
    stages = [s for s in receipt["steps"] if s["name"] == "joint-source-build"]
    need(len(stages) == 1 and isinstance(stages[0].get("exit"), int) and stages[0]["exit"] != 0,
         "Missing failed terminal source build")
    return stages[0]


def collect(root):
    full = read(root, RECEIPT, LIMIT)
    stage = identify(json.loads(full))
    intent = read(root, INTENT_PATH, 128 * 1024)
    need(sha(intent) == INTENT, "Operator intent digest mismatch")
    json.loads(intent)
    driver_exit = read(root, "driver.exit", 64)
    need(re.fullmatch(rb"[1-9][0-9]{0,2}\s*", driver_exit), "Unexpected driver exit")
    log = read(root, "run/evidence/joint-source-build.log", 64 * 1024**2)
    for count, expected in PREFIXES.items():
        need(len(log) >= count and sha(log[:count]) == expected, "Saved log prefix mismatch")
    need(sha(log) == stage["log_sha256"], "Full source log digest mismatch")
    driver = read(root, "driver.log", 32 * 1024**2)
    refs = [r for r in driver.splitlines() if r.startswith(b"TG435_RECEIPT_REF ")]
    summaries = [r for r in driver.splitlines() if r.startswith(b"TG435_RECEIPT_V1 ")]
    files = {"receipt.json": full, INTENT_PATH: intent, "driver.exit": driver_exit}
    if refs:
        expected_ref = f"TG435_RECEIPT_REF {ROOT / RECEIPT} {sha(full)}".encode()
        need(all(line == expected_ref for line in refs), "Original on-disk REF disagrees")
        files["driver-receipt-ref.txt"] = refs[-1] + b"\n"
    if summaries:
        need(len(set(summaries)) == 1, "Ambiguous original summary")
        _, digest, encoded = summaries[0].split()
        summary = inflate(base64.b64decode(encoded, validate=True), LIMIT)
        need(sha(summary) == digest.decode(), "On-disk V1 digest mismatch")
        obj = json.loads(summary)
        keys = ("receipt_path", "receipt_sha256", "commit", "tree", "driver_exit", "status")
        expected_summary = (str(ROOT / RECEIPT), sha(full), PIN, TREE, int(driver_exit), "failed")
        need(tuple(obj.get(k) for k in keys) == expected_summary, "V1 differs from retained receipt or exit")
        files["summary.json"] = summary
    metadata = {"origin": "original attempt EBS files read on a later EC2 boot", "instance": HOST,
                "attempt": ATTEMPT, "commit": PIN, "tree": TREE, "worker_sha256": WORKER,
                "receipt_sha256": sha(full), "source_log_bytes": len(log), "source_log_sha256": sha(log),
                "verified_source_log_prefixes": PREFIXES, "driver_log_bytes": len(driver),
                "driver_log_sha256": sha(driver), "original_driver_ref_present": bool(refs),
                "original_driver_summary_present": bool(summaries), "driver_exit": int(driver_exit),
                "source_stage_exit": stage["exit"], "interpretation": "operator-interrupted after known source failures"}
    return {"metadata": metadata, "files": {name: {"bytes": len(raw), "sha256": sha(raw),
            "base64": base64.b64encode(raw).decode()} for name, raw in files.items()}}


def response(raw, offset):
    need(0 <= offset < len(raw) <= 3 * LIMIT and offset % CHUNK == 0, "Invalid transfer offset")
    chunk = raw[offset:offset + CHUNK]
    return {"offset": offset, "bytes": len(raw), "sha256": sha(raw), "part_sha256": sha(chunk),
            "base64": base64.b64encode(chunk).decode()}


def receive(get_page):
    result = bytearray()
    first = None
    while first is None or len(result) < first[0]:
        page = get_page(len(result))
        identity = (page["bytes"], page["sha256"])
        if first is None:
            first = identity
        need(identity == first and 0 < first[0] <= 3 * LIMIT, "Transfer identity changed")
        chunk = base64.b64decode(page["base64"], validate=True)
        need(page["offset"] == len(result) and len(chunk) == min(CHUNK, first[0] - len(result))
             and sha(chunk) == page["part_sha256"], "Incomplete or corrupt chunk")
        result.extend(chunk)
    need(sha(result) == first[1], "Reassembled transfer digest mismatch")
    return json.loads(inflate(result, 4 * LIMIT))


def validated_files(envelope):
    result = {}
    allowed = {"receipt.json", "driver.exit", INTENT_PATH, "summary.json", "driver-receipt-ref.txt"}
    for name, spec in envelope["files"].items():
        need(name in allowed, "Unexpected artifact")
        raw = base64.b64decode(spec["base64"], validate=True)
        need(len(raw) == spec["bytes"] and sha(raw) == spec["sha256"], "Artifact length or hash mismatch")
        result[name] = raw
    stage = identify(json.loads(result["receipt.json"]))
    meta = envelope["metadata"]
    need(tuple(meta[k] for k in ("attempt", "instance", "receipt_sha256", "source_log_sha256")) ==
         (ATTEMPT, HOST, sha(result["receipt.json"]), stage["log_sha256"]), "Invalid recovery metadata")
    need(sha(result[INTENT_PATH]) == INTENT and int(result["driver.exit"]) == meta["driver_exit"], "Invalid intent or exit")
    meta["files"] = {k: {"bytes": len(v), "sha256": sha(v)} for k, v in result.items()}
    result["ebs-recovery.json"] = json.dumps(meta, indent=2, sort_keys=True).encode() + b"\n"
    return result


def aws(*args):
    return json.loads(subprocess.check_output(["aws", "--region", "us-east-1", "--no-cli-pager",
                                               "--output", "json", *args]))


def remote_page(script, offset):
    payload = base64.b64encode(gzip.compress(script, mtime=0)).decode()
    code = "import base64,gzip;exec(compile(gzip.decompress(base64.b64decode(%r)),'ebs_recovery.py','exec'))" % payload
    cmd = shlex.join(["timeout", "45", "nice", "-n", "19", "python3", "-B", "-c", code, "--worker", str(offset)])
    request = aws("ssm", "send-command", "--instance-ids", HOST, "--document-name", "AWS-RunShellScript",
                  "--parameters", json.dumps({"commands": [cmd], "executionTimeout": ["55"]}))
    cid = request["Command"]["CommandId"]
    for _ in range(36):
        rows = aws("ssm", "list-command-invocations", "--command-id", cid)["CommandInvocations"]
        if rows and rows[0]["Status"] not in {"Pending", "InProgress", "Delayed", "Cancelling"}:
            item = aws("ssm", "get-command-invocation", "--command-id", cid, "--instance-id", HOST)
            need(item["Status"] == "Success", str(item["Status"]) + " " + item.get("StandardErrorContent", "")[-512:])
            return json.loads(item["StandardOutputContent"])
        time.sleep(2)
    raise ValueError("No SSM response for " + cid)


def main():
    if len(sys.argv) == 3 and sys.argv[1] == "--worker":
        payload = gzip.compress(pack(collect(ROOT)), mtime=0)
        print(pack(response(payload, int(sys.argv[2]))).decode())
        return
    need(len(sys.argv) == 1, "Run without arguments in CloudShell")
    state = aws("ec2", "describe-instances", "--instance-ids", HOST)["Reservations"][0]["Instances"][0]
    need(state["InstanceId"] == HOST and state["State"]["Name"] == "running", "Original EC2 instance must already be running")
    for _ in range(30):
        rows = aws("ssm", "describe-instance-information", "--filters", "Key=InstanceIds,Values=" + HOST)["InstanceInformationList"]
        if any(row["InstanceId"] == HOST and row["PingStatus"] == "Online" for row in rows):
            break
        time.sleep(4)
    else:
        raise ValueError("No online SSM agent on the running host")
    script = Path(__file__).read_bytes()
    files = validated_files(receive(lambda offset: remote_page(script, offset)))
    os.umask(0o077)
    output = Path(tempfile.mkdtemp(prefix="tg-d69a-ebs-", dir=Path.home()))
    with zipfile.ZipFile(output / "tg-d69a-ebs.zip", "x", compression=zipfile.ZIP_DEFLATED) as archive:
        for name, raw in files.items():
            (output / name).write_bytes(raw)
            archive.writestr(name, raw)
    print("Download", output / "tg-d69a-ebs.zip")
    print("SHA-256", sha((output / "tg-d69a-ebs.zip").read_bytes()))
    print("Full receipt", sha(files["receipt.json"]), "driver exit", int(files["driver.exit"]))


if __name__ == "__main__":
    try:
        main()
    except (KeyError, OSError, ValueError, subprocess.CalledProcessError) as error:
        raise SystemExit("Original attempt recovery failed: " + str(error))
