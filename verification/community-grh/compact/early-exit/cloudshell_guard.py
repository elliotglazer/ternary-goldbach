"""Run the pinned historical guard from CloudShell. With just a revision, report readiness."""
import argparse
import base64
import gzip
import hashlib
import importlib.util
import inspect
import json
from pathlib import Path
import re
import sys
import tempfile
from urllib.request import urlopen


RAW = "https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/"
BASE = "verification/community-grh/"
GUARDS = BASE + "compact/early-exit/"
HELPER_SHA = "cac0296b0528c8c5c43b0791f3b0c5516d6ce8f39d677904e8f027c7d4038031"
GUARD_HASHES = {
    "ready_0b68.py": "3fc367a3ff6c0163d22e13dd0943974756be98c36ab47cda660e4132dcf65758",
    "interrupt_0b68.py": "190e4bd2397599418d16f54b0eda8ce620b989b1f9823b0829110182502fb258",
}
STACK = "tg-grh-source-replay"
HOST = "i-0e7d3f1a40dbca69c"
ATTEMPT = "d69a0b0ad9464dbc84198f6c547221c7"
PIN = "0b68b493791e5f7569021f0cd13454151af47584"


def download(revision, path, digest):
    with urlopen(RAW + revision + "/" + path, timeout=20) as response:
        data = response.read(96 * 1024 + 1)
    if len(data) > 96 * 1024 or hashlib.sha256(data).hexdigest() != digest:
        raise ValueError("download failed SHA-256 check: " + path)
    return data


def remote_entry(args):
    """This function also runs as ordinary Python inside the worker's private /tmp directory."""
    import base64
    import gzip
    import hashlib
    import json
    import os
    from pathlib import Path
    import subprocess
    import sys
    import tempfile

    if os.geteuid() != 0:
        raise ValueError("expected root from AWS-RunShellScript")
    os.umask(0o077)
    with tempfile.TemporaryDirectory(prefix="tg-0b68-guard-", dir="/tmp") as folder:
        dest = Path(folder)
        if dest.stat().st_uid != 0 or dest.stat().st_mode & 0o777 != 0o700:
            raise ValueError("invalid private temporary directory")
        for name, (digest, packed) in args["files"].items():
            data = gzip.decompress(base64.b64decode(packed, validate=True))
            if hashlib.sha256(data).hexdigest() != digest:
                raise ValueError("transport failed SHA-256 check: " + name)
            (dest / name).write_bytes(data)
        opt_in = args["interrupt"]
        script = "interrupt_0b68.py" if opt_in else "ready_0b68.py"
        command = [sys.executable, "-E", "-s", "-B", str(dest / script)]
        if opt_in:
            command += ["--interrupt-after-recording", args["attempt"]]
        proc = subprocess.run(command, cwd=dest, capture_output=True, text=True)
        if not proc.stdout.strip():
            raise RuntimeError("guard returned no outcome; exit " + str(proc.returncode))
        result = json.loads(proc.stdout)
        if proc.returncode not in (0, 2):
            raise RuntimeError("unexpected guard exit " + str(proc.returncode))
        diagnosis = result.get("diagnosis")
        summary = {"attempt": args["attempt"], "mode": "interrupt" if opt_in else "probe",
                   "guard_exit": proc.returncode, "signal_sent": result.get("signal_sent", False)}
        if "reason" in result:
            summary["reason"] = result["reason"]
        if not opt_in:
            summary["ready"] = result["ready"]
        else:
            # An intent records the proposed action. It may also exist following a refusal.
            sidecar = Path("/work/compact-joint-runs") / (args["pin"] + "-" + args["attempt"]) / "operator-interrupt-joint-lake-intent-v1.json"
            if sidecar.exists() and sidecar.resolve(strict=True) == sidecar:
                with os.fdopen(os.open(sidecar, os.O_RDONLY | os.O_NOFOLLOW), "rb") as stream:
                    raw = stream.read(1024 * 1024 + 1)
                if len(raw) <= 1024 * 1024:
                    summary["observed_intent_sha256"] = hashlib.sha256(raw).hexdigest()
                    intent = json.loads(raw)
                    if intent.get("diagnosis", {}).get("attempt") == args["attempt"]:
                        diagnosis = intent["diagnosis"]
        if diagnosis:
            live = diagnosis["live"]
            lake = diagnosis["identity"]["lake"]
            uptime = float(Path("/proc/uptime").read_text().split()[0])
            summary.update(failed_target_count=len(live["errors"]), log_prefix_bytes=live["prefix_bytes"],
                           log_prefix_sha256=live["prefix_sha256"], pid=lake["pid"],
                           age_seconds_at_report=int(uptime - lake["start_ticks"] / os.sysconf("SC_CLK_TCK")))
        print(json.dumps(summary, sort_keys=True), flush=True)
        return proc.returncode


def render(sources, interrupt):
    files = {}
    for name, digest in GUARD_HASHES.items():
        data = sources[name]
        if hashlib.sha256(data).hexdigest() != digest:
            raise ValueError("guard input hash mismatch: " + name)
        files[name] = [digest, base64.b64encode(gzip.compress(data, mtime=0)).decode("ascii")]
    args = {"files": files, "interrupt": interrupt, "attempt": ATTEMPT, "pin": PIN}
    script = inspect.getsource(remote_entry) + "\nraise SystemExit(remote_entry(" + repr(args) + "))"
    return "set -eu\nexec /usr/bin/python3 -I -B - <<'TG_PINNED_GUARD'\n" + script + "\nTG_PINNED_GUARD"


def run(helper, revision, interrupt, fetch=download):
    host = helper.host_and_volume(STACK)["Instance"]
    if host != HOST or helper.REGION != "us-east-1":
        raise ValueError("expected the original us-east-1 stack and worker")
    info = helper.aws("ec2", "describe-instances", "--instance-ids", host)
    rows = [i for r in info["Reservations"] for i in r["Instances"]]
    if len(rows) != 1 or rows[0]["InstanceId"] != HOST:
        raise ValueError("unexpected describe-instances response")
    state = rows[0]["State"]["Name"]
    if state != "running":
        print(json.dumps({"attempt": ATTEMPT, "instance_state": state, "ssm_sent": False}))
        return 0 if state in ("stopped", "stopping", "terminated", "shutting-down") else 2
    sources = {name: fetch(revision, GUARDS + name, digest) for name, digest in GUARD_HASHES.items()}
    helper.ssm(host, render(sources, interrupt), timeout=90)
    return 0


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("revision", help="full public verifier Git commit")
    parser.add_argument("--interrupt-after-recording", metavar="EXACT_ATTEMPT")
    args = parser.parse_args(argv)
    if not re.fullmatch("[0-9a-f]{40}", args.revision):
        parser.error("expected a full lowercase 40-digit Git revision")
    if args.interrupt_after_recording not in (None, ATTEMPT):
        parser.error("wrong interruption token")
    with tempfile.TemporaryDirectory(prefix="tg-0b68-cloudshell-") as temp:
        path = Path(temp) / "cloudshell.py"
        path.write_bytes(download(args.revision, BASE + path.name, HELPER_SHA))
        spec = importlib.util.spec_from_file_location("verified_tg_cloudshell", path)
        helper = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(helper)
        return run(helper, args.revision, args.interrupt_after_recording == ATTEMPT)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
