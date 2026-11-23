"""Opt-in, one-attempt Windows job runner. No FLINT import in this process."""
from pathlib import Path
import argparse
import ctypes
from ctypes import wintypes
import hashlib
import importlib.util
import json
import os
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
NATIVE = ROOT / "work/qrh-campaign/agents/integration/rational_j7_supervision_20261111_native.py"
NATIVE_PIN = "CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13"
MEMORY = 2 * 1024**3
WALL = 300
CPU = 300


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest().upper()


def need(ok, message):
    if not ok:
        raise RuntimeError(message)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run", action="store_true")
    parser.add_argument("--label", required=True)
    args = parser.parse_args()
    need(args.run and os.name == "nt", "explicit --run on Windows required")
    need(1 <= len(args.label) <= 48 and all(c.isascii() and (c.isalnum() or c in "_-")
         for c in args.label), "invalid run label")
    need(sha(NATIVE) == NATIVE_PIN, "native helper pin")
    spec = importlib.util.spec_from_file_location("native_sign_windows", NATIVE)
    helper = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(helper)
    win = helper.Win()
    python = ROOT / "work/qrh-campaign/interval-env/Scripts/python.exe"
    worker = HERE / "worker.py"
    need(python.is_file() and worker.is_file(), "missing local executable/worker")
    runs = HERE / "runs"
    runs.mkdir(exist_ok=True)
    output = runs / args.label
    output.mkdir(exist_ok=False)
    worker_pin = sha(worker)
    command = [str(python), "-I", "-u", str(worker), str(output)]
    receipt = {"command": command, "worker_sha256": worker_pin,
               "runner_sha256": sha(__file__), "native_helper_sha256": NATIVE_PIN,
               "hard_job_commit_bytes": MEMORY, "hard_process_commit_bytes": MEMORY,
               "wall_limit_seconds": WALL, "sampled_cpu_limit_seconds": CPU,
               "active_process_limit": 1, "formal_proof": False,
               "memory_scope": "Windows committed process/job memory, not all OS memory"}
    job, process, started = None, None, time.perf_counter()
    try:
        job = win.CreateJobObjectW(None, None)
        win.ok(job, "create job")
        limits = win.LIMIT()
        limits.BasicLimitInformation.LimitFlags = 0x2000 | 0x8 | 0x100 | 0x200
        limits.BasicLimitInformation.ActiveProcessLimit = 1
        limits.ProcessMemoryLimit = limits.JobMemoryLimit = MEMORY
        win.ok(win.SetInformationJobObject(job, 9, ctypes.byref(limits), ctypes.sizeof(limits)), "set limits")
        actual = win.LIMIT()
        win.ok(win.QueryInformationJobObject(job, 9, ctypes.byref(actual), ctypes.sizeof(actual), None), "read limits")
        need(actual.BasicLimitInformation.LimitFlags == limits.BasicLimitInformation.LimitFlags
             and actual.BasicLimitInformation.ActiveProcessLimit == 1
             and actual.ProcessMemoryLimit == actual.JobMemoryLimit == MEMORY, "limit mismatch")
        with (output / "stderr.log").open("xb") as errors:
            process = subprocess.Popen(command, cwd=HERE, stdin=subprocess.PIPE,
                                       stdout=None, stderr=errors, creationflags=subprocess.CREATE_NO_WINDOW)
            # Worker runs only stdlib startup and waits. No FLINT import before GO.
            win.ok(win.AssignProcessToJobObject(job, int(process._handle)), "assign worker")
            in_job = wintypes.BOOL()
            win.ok(win.IsProcessInJob(int(process._handle), job, ctypes.byref(in_job)), "check job")
            need(in_job.value, "worker not in job")
            need(sha(worker) == worker_pin, "worker changed before GO")
            process.stdin.write(b"GO\n")
            process.stdin.flush()
            process.stdin.close()
            while process.poll() is None:
                snap = win.account_snapshot(job, "screen", "poll")
                need(snap["success"], "job accounting query")
                stats = snap["decoded"]
                need(stats["TotalProcesses"] == 1, "unexpected job process")
                cpu = (stats["TotalUserTime"] + stats["TotalKernelTime"]) / 10000000
                need(time.perf_counter() - started <= WALL, "wall limit")
                need(cpu <= CPU, "CPU limit")
                need((output / "stderr.log").stat().st_size <= 256 * 1024, "stderr cap")
                time.sleep(0.1)
            receipt["exit_code"] = process.wait()
        snap = win.account_snapshot(job, "screen", "final")
        need(snap["success"], "final job accounting")
        receipt["accounting"] = snap["decoded"]
        win.ok(win.QueryInformationJobObject(job, 9, ctypes.byref(actual), ctypes.sizeof(actual), None), "final memory")
        receipt["peak_job_commit_bytes"] = int(actual.PeakJobMemoryUsed)
        receipt["peak_process_commit_bytes"] = int(actual.PeakProcessMemoryUsed)
        need(sha(worker) == worker_pin, "worker changed during run")
        events_path = output / "events.jsonl"
        need(events_path.is_file() and events_path.stat().st_size <= 256 * 1024, "missing/oversize events")
        events = [json.loads(line) for line in events_path.read_text(encoding="utf-8").splitlines()]
        receipt["events_sha256"] = sha(events_path)
        points = [e for e in events if e["kind"] == "point"]
        receipt["point_statuses"] = [{"label": e["label"], "status": e["status"]} for e in points]
        expected_labels = [f"chi{c}_t{n}_{d}" for c in (1877, 2813)
                           for n, d in ((0, 1), (5, 64), (3290, 1), (6580, 1))]
        need((output / "stderr.log").stat().st_size <= 256 * 1024, "final stderr cap")
        receipt["success"] = receipt["exit_code"] == 0 and len(points) == 8 and \
            [e["label"] for e in points] == expected_labels and \
            all(e["status"] == "pass" and e["strict_comparison"] is True for e in points) and \
            events[-1]["kind"] == "complete" and events[-1]["completed"] == expected_labels
    except Exception as error:
        receipt["success"] = False
        receipt["stop"] = type(error).__name__ + ": " + str(error)
    finally:
        # Closing the kill-on-close job also handles an interrupted native call.
        if job:
            win.CloseHandle(job)
        if process is not None and process.poll() is None:
            process.kill()  # also handles an assignment failure before job membership
            process.wait()
        if process is not None:
            receipt["exit_code"] = process.returncode
        receipt["wall_seconds"] = time.perf_counter() - started
        data = (json.dumps(receipt, indent=2, sort_keys=True) + "\n").encode("utf-8")
        need(len(data) <= 64 * 1024, "receipt cap")
        with (output / "receipt.json").open("xb") as target:
            target.write(data)
            target.flush()
            os.fsync(target.fileno())
        print(json.dumps(receipt, sort_keys=True), flush=True)
    return 0 if receipt.get("success") else 1


if __name__ == "__main__":
    raise SystemExit(main())
