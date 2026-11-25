#!/usr/bin/env python3
"""Collect the compact proof worker's hash-checked summary from the EC2 console."""

import argparse
import base64
import binascii
import gzip
import hashlib
import io
import json
from pathlib import Path
import re
import subprocess
import sys
import zlib


REGION = "us-east-1"
MAX_COMPRESSED_BYTES = 48 * 1024
MAX_SUMMARY_BYTES = 192 * 1024
SUMMARY_MARKER = re.compile(r"\bTG435_RECEIPT_V1[ \t]+([0-9a-f]{64})[ \t]+([A-Za-z0-9+/=]+)")
REFERENCE_MARKER = re.compile(r"\bTG435_RECEIPT_REF[ \t]+(\S+)[ \t]+([0-9a-f]{64})")
GIT_HASH = re.compile(r"[0-9a-f]{40}")


def aws(*args):
    cmd = ["aws", "--region", REGION, "--no-cli-pager", "--output", "json", *args]
    return json.loads(subprocess.check_output(cmd, timeout=45))


def console_text(raw):
    if "TG435_RECEIPT_" in raw:
        return raw
    # Some EC2 clients return the console as base64 instead of decoded text.
    try:
        decoded = base64.b64decode("".join(raw.split()), validate=True).decode("utf-8", errors="replace")
    except (ValueError, binascii.Error):
        return raw
    return decoded if "TG435_RECEIPT_" in decoded else raw


def read_summary(console, commit, tree):
    console = console_text(console)
    matches = list(SUMMARY_MARKER.finditer(console))
    if not matches:
        raise ValueError("The available console output contains no completed receipt marker.")
    expected_digest, encoded = matches[-1].groups()
    if len(encoded) > 4 * ((MAX_COMPRESSED_BYTES + 2) // 3):
        raise ValueError("The encoded summary exceeds the accepted size.")
    compressed = base64.b64decode(encoded, validate=True)
    with gzip.GzipFile(fileobj=io.BytesIO(compressed)) as handle:
        payload = handle.read(MAX_SUMMARY_BYTES + 1)
    if len(payload) > MAX_SUMMARY_BYTES or hashlib.sha256(payload).hexdigest() != expected_digest:
        raise ValueError("The receipt summary has an invalid size or SHA-256.")
    summary = json.loads(payload)
    if not isinstance(summary, dict):
        raise ValueError("The receipt summary must be a JSON object.")
    if summary.get("commit") != commit or summary.get("tree") != tree:
        raise ValueError("The console summary belongs to a different proof commit or tree.")
    receipt_ref = (summary.get("receipt_path"), summary.get("receipt_sha256"))
    if receipt_ref not in REFERENCE_MARKER.findall(console):
        raise ValueError("The console lacks the matching full-receipt reference.")
    return summary, payload


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--commit", required=True)
    parser.add_argument("--tree", required=True)
    parser.add_argument("--stack", default="tg-grh-source-replay")
    parser.add_argument("--console-file", type=Path, help="read a saved console transcript instead of calling AWS")
    parser.add_argument("--out", type=Path, help="destination for the original summary JSON bytes")
    args = parser.parse_args()
    if not GIT_HASH.fullmatch(args.commit) or not GIT_HASH.fullmatch(args.tree):
        parser.error("Both pins must be full lowercase Git SHA-1 hashes.")
    if args.console_file:
        console = args.console_file.read_text(encoding="utf-8", errors="replace")
    else:
        resource = aws("cloudformation", "describe-stack-resource", "--stack-name", args.stack,
                       "--logical-resource-id", "Host")
        instance = resource["StackResourceDetail"]["PhysicalResourceId"]
        result = aws("ec2", "get-console-output", "--instance-id", instance, "--latest")
        console = result.get("Output") or ""
    try:
        summary, payload = read_summary(console, args.commit, args.tree)
    except (ValueError, OSError, EOFError, zlib.error) as exc:
        sys.exit(str(exc))
    out = args.out or Path(f"compact-receipt-{args.commit[:12]}-{summary['receipt_sha256'][:12]}.json")
    if out.exists() and out.read_bytes() != payload:
        sys.exit(f"A different summary already exists at {out}.")
    out.write_bytes(payload)
    print(f"Worker status: {summary.get('status', 'unknown')}")
    print(f"Full receipt SHA-256: {summary['receipt_sha256']}")
    print(f"Saved summary: {out}")


if __name__ == "__main__":
    main()
