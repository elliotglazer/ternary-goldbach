"""Ship a bounded progress or final receipt. Access fields never enter the receipt."""
import gzip
import hashlib
import json
from pathlib import Path
import subprocess
import sys
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parent


def tail(path, size):
    if not path.exists():
        return ""
    with path.open("rb") as f:
        f.seek(max(0, path.stat().st_size - size))
        return f.read().decode(errors="replace")


def collect(kind, code, root=ROOT):
    result = dict(kind=kind, utc=datetime.now(timezone.utc).isoformat(), exit_code=code,
                  phase=tail(root/"phase", 256).strip(), timings=tail(root/"timings.tsv", 8192),
                  hardware=tail(root/"hardware.txt", 8192), metrics=tail(root/"metrics.log", 16384),
                  log_tail=tail(root/"worker.log", 32768), fixtures={})
    for name in ("small", "large"):
        folder = root/"goldbach-wide"/("run-"+name)
        if (folder/"receipt.json").exists():
            raw = (folder/"receipt.json").read_bytes()
            result["fixtures"][name] = dict(receipt=json.loads(raw), sha256=hashlib.sha256(raw).hexdigest(),
                                            audit=tail(folder/"WideAudit.log", 8192),
                                            olean_bytes=sum(p.stat().st_size for p in folder.glob("*.olean")))
    return result


def main():
    kind, code = sys.argv[1:]
    cfg = json.loads((ROOT/"transfer.json").read_text())
    out = ROOT/("report-"+kind+".json.gz")
    out.write_bytes(gzip.compress(json.dumps(collect(kind, int(code))).encode(), mtime=0))
    if out.stat().st_size > 2**20:
        raise ValueError("receipt exceeded 1 MiB")
    # The fields are scoped to one private key, a six-hour maximum and a 1-MiB upload.
    request = cfg["post"][kind]
    args = ["curl", "-fsS", "--retry", "3", "--max-time", "45"]
    for key, value in request["fields"].items():
        args.extend(["--form-string", key+"="+value])
    args.extend(["-F", "file=@"+str(out), request["url"]])
    code = subprocess.run(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).returncode
    if code:
        raise RuntimeError(f"receipt upload failed with curl exit code {code}")


if __name__ == "__main__":
    main()
