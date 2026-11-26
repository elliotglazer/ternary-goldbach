"""Small Linux flock control for the optional binary audit's admission lease."""
from pathlib import Path
import fcntl
import json
import os
import pwd
import signal
import subprocess
import tempfile

with tempfile.TemporaryDirectory(prefix="tg-admission-") as tmp:
    # The trusted caller can pass its O_RDONLY descriptor to the unprivileged worker.
    base = Path(tmp)
    lock = base / "dispatch.lock"
    lock.touch(mode=0o600)
    base.chmod(0o755)
    owner = pwd.getpwnam("nobody")
    old = os.open(lock, os.O_RDONLY)
    os.dup2(old, 8, inheritable=True)
    if old != 8:
        os.close(old)
    script = """set -eu
        test ! -r "$1"
        echo waiting
        read -r start
        flock -s 8
        echo held
        exec python3 -c 'import sys, time; print("executed", flush=True); time.sleep(30)'"""
    process = subprocess.Popen(
        ["setpriv", f"--reuid={owner.pw_uid}", f"--regid={owner.pw_gid}", "--clear-groups", "--",
         "bash", "-ec", script, "bash", str(lock)],
        pass_fds=(8,), stdout=subprocess.PIPE, stdin=subprocess.PIPE, text=True)
    os.close(8)
    def can_take_exclusive():
        with lock.open("rb") as f:
            try:
                fcntl.flock(f, fcntl.LOCK_EX | fcntl.LOCK_NB)
            except BlockingIOError:
                return False
            fcntl.flock(f, fcntl.LOCK_UN)
            return True
    try:
        assert process.stdout.readline().strip() == "waiting"
        assert can_take_exclusive()
        process.stdin.write("go\n")
        process.stdin.flush()
        assert process.stdout.readline().strip() == "held"
        assert process.stdout.readline().strip() == "executed"
        assert not can_take_exclusive()
    finally:
        process.send_signal(signal.SIGTERM)
        process.wait(timeout=5)
    assert can_take_exclusive()
    print(json.dumps({"status":"passed","uid_after_setpriv":owner.pw_uid,"lock_mode":"0600",
       "enqueuer_can_take_ex_before_endpoint":True,"exclusive_shutdown_waits_during_cpython_exec":True,
       "exclusive_admission_reopens_after_sigterm":True}))
