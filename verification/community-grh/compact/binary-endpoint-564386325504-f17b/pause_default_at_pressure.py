"""Pause only the authenticated default checker during transient Windows memory pressure."""
import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import signal
import time

TARGET = "SmallGoldbach.ProductPrefix564386325504.binaryGoldbachUpTo"
SOLUTION = "a7bbbe8a275b78fcc31cad84ca0ac0c092468aa96a73df53ea4f8d0037dfb303"
ORIGIN = "b260cf72cfcb11b8511aa8efc9437f8064f22a4cc8a0293f5c3ea4375c880d5e"


def proc_stat(pid):
    raw = Path(f"/proc/{pid}/stat").read_text()
    head, rest = raw.rsplit(") ", 1)
    fields = rest.split()
    return head.split(" (", 1)[1], fields[0], int(fields[1]), int(fields[19])


def verify_child(pid, row, private):
    name, _, parent, ticks = proc_stat(pid)
    if name != "leanchecker" or ticks != row["start_ticks"]:
        return False
    permitted = {int(k) for k, p in private["stages"]["protected-kernels"]["sampled_processes"].items()
                 if p["exe"] == "lake"}
    for _ in range(8):
        if parent in permitted and parent == row["lake_ancestor"]:
            return proc_stat(parent)[0] == "lake"
        if parent <= 1:
            return False
        _, _, parent, _ = proc_stat(parent)
    return False


def main(control):
    paused = None
    lows = highs = 0
    stopped_at = 0.0
    last_resume = 0.0
    while True:
        try:
            status = json.loads((control / "status.json").read_bytes())
            phase = status.get("phase")
            if phase in {"accepted", "protected checker returned without acceptance", "protected helper failed before producing a receipt"}:
                return
            if phase != "protected checker active" or status.get("attempt", 0) < 2:
                time.sleep(1)
                continue
            job = Path(status["linux_output"])
            private = json.loads((job / "receipt.json").read_bytes())
            if (private.get("theorem") != TARGET or private.get("solution_sha256") != SOLUTION
                    or private.get("retained_nanoda", {}).get("prior_receipt_sha256") != ORIGIN):
                time.sleep(1)
                continue
            rows = json.loads((job / "kernel-process-observations.json").read_bytes())["processes"]
            found = [(int(pid), row) for pid, row in rows.items() if row["exe"] == "leanchecker"]
            if not found:
                time.sleep(1)
                continue
            pid, row = found[-1]
            if not verify_child(pid, row, private):
                time.sleep(1)
                continue
            host = json.loads((control / "host.json").read_bytes())
            if time.time() - host["updated_unix"] > 10:
                time.sleep(1)
                continue
            available = host["available_ram_gib"]
            commit = host["available_commit_gib"]
            lows = lows + 1 if available < 3.0 or commit < 6.0 else 0
            highs = highs + 1 if available >= 4.0 and commit >= 8.0 else 0
            owner = (pid, row["start_ticks"])
            op = None
            now = time.monotonic()
            if paused != owner and lows >= 2 and (now - last_resume >= 15 or available < 2.35 or commit < 5):
                os.kill(pid, signal.SIGSTOP)
                op = "paused"
                paused = owner
                stopped_at = now
            elif paused == owner and (highs >= 4 or (now - stopped_at >= 60 and available >= 2.65 and commit >= 7)):
                os.kill(pid, signal.SIGCONT)
                op = "resumed"
                paused = None
                last_resume = now
            if op:
                item = {"event": op, "utc": datetime.now(timezone.utc).isoformat(),
                        "pid": pid, "start_ticks": row["start_ticks"], "host": host}
                with (job / "default-checker-resource-events.jsonl").open("a") as log:
                    log.write(json.dumps(item) + "\n")
                print(json.dumps(item), flush=True)
            time.sleep(1)
        except (OSError, KeyError, ValueError):
            time.sleep(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("control", type=Path)
    main(parser.parse_args().control)
