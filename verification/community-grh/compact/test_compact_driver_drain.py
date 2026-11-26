"""Exercise the production driver's terminal output in Bash with a slow GNU tee."""
import base64
import gzip
import hashlib
import json
import os
from pathlib import Path
import random
import subprocess
import tempfile
import time

import compact_joint_stack as stack

PIN = "a" * 40
TREE = "b" * 40
ATTEMPT = "c" * 32
HEADER = stack.DRIVER[stack.DRIVER.index("exec > >("):stack.DRIVER.index("test -f /work/replay/evidence/receipt.json")]
TAIL = stack.DRIVER[stack.DRIVER.index('echo "$rc" > "$attempt/driver.exit"'):]

MOCKS = r"""
set -Eeuo pipefail
attempt=$1
rc=$2
busy=$3
tee() {
  python3 -c 'import os,time
while True:
    data=os.read(0,128)
    if not data:break
    time.sleep(.002)
    os.write(1,data)' | command tee "$@"
}
unit_busy() { [ "$busy" = yes ]; }
sync() { :; }
systemctl() {
  [ "$*" = "--no-block poweroff" ]
  cp "$attempt/driver.log" "$attempt/log-at-poweroff"
  cp "$attempt/test-console" "$attempt/console-at-poweroff"
}
"""


def exercise(root, status, rc, busy=False, discard_wait=False):
    root.mkdir()
    evidence = root / "run/evidence"
    evidence.mkdir(parents=True)
    padding = base64.b64encode(random.Random(179).randbytes(8600)).decode()
    full = (json.dumps({"status": status, "pin": PIN, "git_tree": TREE, "steps": [],
                        "root": str(root / "run"), "padding": padding}) + "\n").encode()
    (evidence / "receipt.json").write_bytes(full)
    header = HEADER.replace("/dev/console", '"$attempt/test-console"')
    if discard_wait:
        header = header.replace('wait "$logger_pid" || logger_status=$?', ":")
    tail = TAIL.replace("@COMMIT@", PIN).replace("@TREE@", TREE)
    result = subprocess.run(["bash", "-c", MOCKS + header + tail, "driver", str(root), str(rc),
                             "yes" if busy else "no"], stdout=subprocess.DEVNULL,
                            stderr=subprocess.DEVNULL, timeout=20)
    assert result.returncode == rc
    if discard_wait:
        # The old path asked for poweroff while the tail of the transcript was in the pipe.
        snap = (root / "log-at-poweroff").read_bytes()
        assert b"stopping this instance" not in snap
        for _ in range(100):
            if b"stopping this instance" in (root / "driver.log").read_bytes():
                break
            time.sleep(.02)
        return
    log = (root / "driver.log").read_bytes()
    console = (root / "test-console").read_bytes()
    assert (root / "driver-log.exit").read_text() == "0\n"
    assert log == console and len(log) > 8192
    if busy:
        assert not (root / "log-at-poweroff").exists()
        assert b"Active joint worker; no poweroff" in log
    else:
        assert (root / "log-at-poweroff").read_bytes() == log
        assert (root / "console-at-poweroff").read_bytes() == log
        assert b"stopping this instance" in log
    records = log.splitlines()
    assert records[0].split() == [b"TG435_RECEIPT_REF", os.fsencode(evidence / "receipt.json"),
                                  hashlib.sha256(full).hexdigest().encode()]
    label, digest, encoded = records[1].split()
    summary = gzip.decompress(base64.b64decode(encoded, validate=True))
    assert label == b"TG435_RECEIPT_V1" and hashlib.sha256(summary).hexdigest().encode() == digest
    assert json.loads(summary)["status"] == status
    frames = [r.split() for r in records if r.startswith(b"TG435_FULL_V1 ")]
    assert len(frames) >= 12
    assert [f[3].decode() for f in frames] == [f"{n}/{len(frames)}" for n in range(1,len(frames)+1)]
    assert gzip.decompress(base64.b64decode(b"".join(f[4] for f in frames),validate=True)) == full


def main():
    with tempfile.TemporaryDirectory() as tmp:
        for label, status, rc, busy, discard in (("success","verified",0,False,False),
                ("failure","failed",1,False,False),("busy","failed",1,True,False),
                ("old","failed",1,False,True)):
            parent = Path(tmp) / label
            parent.mkdir()
            exercise(parent / (PIN + "-" + ATTEMPT), status, rc, busy, discard)
    print("Paced Bash + GNU tee controls passed for complete success/failure frames, busy guard, and old-path truncation.")


if __name__ == "__main__":
    main()
