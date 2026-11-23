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
BASE_PYTHON = Path("C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe")
BASE_PIN = "4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9"
DLL_PIN = "0F9857FFDFE010FE6B99328D58C2E3C7472CE75F336BF9C2AD9BD5BCA3BCE700"
MEMORY = 2 * 1024**3
WALL = 300
CPU = 300


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest().upper()


def need(ok, message):
    if not ok:
        raise RuntimeError(message)


def original_identity_errors(current, previous, pid, expected_image,
                             exit_status, exit_query_ok, raw_exit):
    """Pure policy: retained-handle continuity after exit, full image while live."""
    expected = os.path.normcase(expected_image)
    if not previous:
        if not current.get("valid") or current.get("pid") != pid or \
                os.path.normcase(current.get("image", {}).get("path", "")) != expected:
            return ["initial original Python identity mismatch"]
        return []
    same_object = current.get("pid") == previous.get("pid") == pid and \
        current.get("times_success") is True and \
        current.get("creation_filetime") == previous.get("creation_filetime") and \
        previous.get("valid") is True
    if not same_object:
        return ["original Python retained-handle identity changed or unavailable"]
    if exit_status is not None and (exit_query_ok is not True or raw_exit != exit_status):
        return ["post-exit status query unavailable or inconsistent"]
    terminal = exit_status is not None and exit_query_ok is True and raw_exit == exit_status
    image = current.get("image", {})
    if terminal:
        # The original handle has never been replaced. A failed post-exit image
        # query is not evidence of a different image; a successful mismatch is.
        if image.get("success") and (not image.get("complete") or
                os.path.normcase(image.get("path", "")) != expected):
            return ["post-exit original Python image mismatch"]
        return []
    if not current.get("valid") or os.path.normcase(image.get("path", "")) != expected:
        return ["live original Python image unavailable or changed"]
    return []


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
    python = BASE_PYTHON
    worker = HERE / "worker_v2.py"
    need(python.is_file() and worker.is_file(), "missing local executable/worker")
    need(sha(python) == BASE_PIN and sha(python.parent / "python314.dll") == DLL_PIN,
         "base interpreter/runtime pin")
    runs = HERE / "runs"
    runs.mkdir(exist_ok=True)
    output = runs / args.label
    output.mkdir(exist_ok=False)
    worker_pin = sha(worker)
    command = [str(python), "-I", "-S", "-u", str(worker), str(output)]
    receipt = {"command": command, "worker_sha256": worker_pin,
               "runner_sha256": sha(__file__), "native_helper_sha256": NATIVE_PIN,
               "base_python_sha256": BASE_PIN, "python314_dll_sha256": DLL_PIN,
               "hard_job_commit_bytes": MEMORY, "hard_process_commit_bytes": MEMORY,
               "wall_limit_seconds": WALL, "sampled_cpu_limit_seconds": CPU,
               "active_process_limit": 2, "formal_proof": False,
               "process_roles": "one original Python evaluator plus at most one System32 conhost",
               "cpu_scope": "entire job, including console host; worker events separately report Python CPU",
               "memory_scope": "Windows committed process/job memory, not all OS memory"}
    job, process, started = None, None, time.perf_counter()
    diagnostics = (output / "job_diagnostics.jsonl").open("xb", buffering=0)
    diagnostic_count = diagnostic_bytes = poll_count = 0
    original_identity = console_identity = None

    def observe(stage, force=False):
        nonlocal diagnostic_count, diagnostic_bytes, poll_count, original_identity, console_identity
        before = process.poll() if process is not None else None
        snap = win.account_snapshot(job, "screen", stage)
        class IDS(ctypes.Structure):
            _fields_ = [("assigned", wintypes.DWORD), ("listed", wintypes.DWORD),
                        ("pids", ctypes.c_size_t * 8)]
        ids, returned = IDS(), wintypes.DWORD()
        ctypes.set_last_error(0)
        ids_ok = bool(win.QueryInformationJobObject(job, 3, ctypes.byref(ids),
                                                   ctypes.sizeof(ids), ctypes.byref(returned)))
        ids_error = ctypes.get_last_error() if not ids_ok else None
        member = wintypes.BOOL()
        member_ok = None
        member_error = None
        handle_pid = None
        raw_exit, raw_exit_ok = wintypes.DWORD(), None
        if process is not None:
            ctypes.set_last_error(0)
            member_ok = bool(win.IsProcessInJob(int(process._handle), job, ctypes.byref(member)))
            member_error = ctypes.get_last_error() if not member_ok else None
            handle_pid = int(win.GetProcessId(int(process._handle)))
            raw_exit_ok = bool(win.GetExitCodeProcess(int(process._handle), ctypes.byref(raw_exit)))
        after = process.poll() if process is not None else None
        record = {"stage": stage, "elapsed_seconds": time.perf_counter() - started,
                  "accounting": snap,
                  "pid_list": {"success": ids_ok, "error": ids_error,
                      "assigned": int(ids.assigned), "listed": int(ids.listed),
                      "returned_bytes": int(returned.value), "buffer_bytes": ctypes.sizeof(ids),
                      "raw_hex": ctypes.string_at(ctypes.byref(ids), ctypes.sizeof(ids)).hex(),
                      "pids": [int(ids.pids[i]) for i in range(min(int(ids.listed), 8))]},
                  "popen_pid": None if process is None else process.pid,
                  "handle_pid": handle_pid, "poll_before": before, "poll_after": after,
                  "raw_exit_query_success": raw_exit_ok, "raw_exit_code": int(raw_exit.value),
                  "membership_query_success": member_ok, "membership_error": member_error,
                  "member": bool(member.value) if member_ok else None}
        receipt["last_observation"] = record
        expected = 0 if process is None else 1
        anomalous = not snap["success"] or snap["decoded"].get("TotalProcesses") != expected or \
            not ids_ok or ids.assigned != ids.listed or ids.listed > 8 or \
            (process is not None and (not member_ok or not member.value or handle_pid != process.pid))
        if stage == "poll":
            poll_count += 1
        if True:  # Identity-check every poll, not just the observations written to disk.
            # Match the existing supervisor's retained-handle versus candidate-PID
            # distinction. No image/path observation admits an unknown process.
            record["pid_identities"] = []
            for pid in record["pid_list"]["pids"]:
                retained = process is not None and pid == process.pid
                entry = {"snapshot_pid": pid,
                         "continuity": "original_retained_handle" if retained else "later_opened_candidate_only"}
                record["pid_identities"].append(entry)
                handle = None
                try:
                    ctypes.set_last_error(0)
                    handle = int(process._handle) if retained else win.OpenProcess(0x101000, False, pid)
                    entry["open_success"] = bool(handle)
                    if not handle:
                        entry["open_error"] = ctypes.get_last_error()
                        continue
                    belongs = wintypes.BOOL()
                    ctypes.set_last_error(0)
                    member_success = bool(win.IsProcessInJob(handle, job, ctypes.byref(belongs)))
                    entry["membership_success"] = member_success
                    entry["membership_error"] = ctypes.get_last_error() if not member_success else None
                    entry["member"] = bool(belongs.value) if member_success else None
                    entry["identity"] = win.identity(handle)
                    entry["pid_matches_snapshot"] = entry["identity"].get("pid") == pid
                except Exception as error:
                    entry["identity_error"] = type(error).__name__ + ": " + str(error)
                finally:
                    if handle and not retained:
                        ctypes.set_last_error(0)
                        entry["close_success"] = bool(win.CloseHandle(handle))
                        entry["close_error"] = ctypes.get_last_error() if not entry["close_success"] else None
            errors = []
            host_new = False
            pids = record["pid_list"]["pids"]
            if not ids_ok or ids.assigned != ids.listed or ids.listed > 2 or \
                    returned.value < 8 + 8 * ids.listed or len(set(pids)) != len(pids) or \
                    any(pid <= 0 for pid in pids):
                errors.append("incomplete, duplicate, or excessive PID list")
            if not snap["success"]:
                errors.append("accounting unavailable")
            else:
                totals = snap["decoded"]
                if totals["TotalTerminatedProcesses"] != 0:
                    errors.append("job limit terminated a process")
                if process is None:
                    if totals["TotalProcesses"] != 0 or pids:
                        errors.append("nonempty fresh job")
                elif totals["TotalProcesses"] not in (1, 2):
                    errors.append("unexpected lifetime process count")
            if process is not None:
                current_original = win.identity(int(process._handle))
                terminal_raw = wintypes.DWORD()
                terminal_query_ok = bool(win.GetExitCodeProcess(int(process._handle), ctypes.byref(terminal_raw)))
                terminal_status = process.poll()
                record["current_original_identity"] = current_original
                record["identity_exit_query"] = {"success": terminal_query_ok,
                    "raw_code": int(terminal_raw.value), "popen_status": terminal_status}
                original_errors = original_identity_errors(current_original, original_identity,
                    process.pid, str(BASE_PYTHON), terminal_status,
                    terminal_query_ok, int(terminal_raw.value))
                errors.extend(original_errors)
                if original_identity is None and not original_errors:
                    original_identity = current_original
                if before is None and after is None and process.pid not in pids:
                    errors.append("live original Python absent from job list")
                if not member_ok or not member.value or handle_pid != process.pid:
                    errors.append("original Python membership mismatch")
            for entry in record["pid_identities"]:
                identity = entry.get("identity", {})
                if not entry.get("membership_success") or not entry.get("member") or \
                        not entry.get("pid_matches_snapshot"):
                    errors.append("listed PID identity/membership unavailable")
                    continue
                if process is not None and entry["snapshot_pid"] == process.pid:
                    entry["role"] = "original_python_evaluator"
                    errors.extend(original_identity_errors(identity, original_identity,
                        process.pid, str(BASE_PYTHON), terminal_status,
                        terminal_query_ok, int(terminal_raw.value)))
                    continue
                entry["role"] = "unaccepted_extra_process"
                if not identity.get("valid"):
                    errors.append("extra process identity unavailable")
                    continue
                expected_host = "C:\\Windows\\System32\\conhost.exe"
                if os.path.normcase(identity["image"]["path"]) != os.path.normcase(expected_host) or \
                        original_identity is None or \
                        identity["creation_filetime"] < original_identity["creation_filetime"]:
                    errors.append("extra process is not the expected new console host")
                elif console_identity is None:
                    console_identity = identity
                    host_new = True
                    entry["role"] = "console_host"
                elif not helper.identity_match(identity, console_identity):
                    errors.append("second or replaced console host")
                else:
                    entry["role"] = "console_host"
            if process is not None and snap["success"] and \
                    snap["decoded"]["TotalProcesses"] == 2 and console_identity is None:
                errors.append("second lifetime process not identified")
            record["role_errors"] = errors
            record["roles_valid"] = not errors
            receipt["original_python_identity"] = original_identity
            receipt["console_host_identity"] = console_identity
            anomalous = bool(errors)
        if force or anomalous or host_new or (stage == "poll" and poll_count <= 3):
            data = (json.dumps(record, sort_keys=True) + "\n").encode("utf-8")
            need(diagnostic_count < 16 and diagnostic_bytes + len(data) <= 64 * 1024,
                 "diagnostic cap")
            diagnostics.write(data)
            os.fsync(diagnostics.fileno())
            diagnostic_count += 1
            diagnostic_bytes += len(data)
        return record
    try:
        job = win.CreateJobObjectW(None, None)
        win.ok(job, "create job")
        limits = win.LIMIT()
        limits.BasicLimitInformation.LimitFlags = 0x2000 | 0x8 | 0x100 | 0x200
        limits.BasicLimitInformation.ActiveProcessLimit = 2
        limits.ProcessMemoryLimit = limits.JobMemoryLimit = MEMORY
        win.ok(win.SetInformationJobObject(job, 9, ctypes.byref(limits), ctypes.sizeof(limits)), "set limits")
        actual = win.LIMIT()
        win.ok(win.QueryInformationJobObject(job, 9, ctypes.byref(actual), ctypes.sizeof(actual), None), "read limits")
        need(actual.BasicLimitInformation.LimitFlags == limits.BasicLimitInformation.LimitFlags
             and actual.BasicLimitInformation.ActiveProcessLimit == 2
             and actual.ProcessMemoryLimit == actual.JobMemoryLimit == MEMORY, "limit mismatch")
        empty = observe("empty_before_launch", force=True)
        need(empty["accounting"]["success"] and
             empty["accounting"]["decoded"]["TotalProcesses"] == 0, "job not initially empty")
        with (output / "stderr.log").open("xb") as errors:
            process = subprocess.Popen(command, cwd=HERE, stdin=subprocess.PIPE,
                                       stdout=None, stderr=errors, creationflags=subprocess.CREATE_NO_WINDOW)
            # Direct base interpreter, no venv redirector; -I -S disables site hooks.
            # Worker runs only stdlib startup and waits. No FLINT import before GO.
            win.ok(win.AssignProcessToJobObject(job, int(process._handle)), "assign worker")
            assigned = observe("assigned_before_GO", force=True)
            need(assigned["accounting"]["success"], "pre-GO accounting query")
            need(assigned["roles_valid"], "pre-GO process-role rejection; see job_diagnostics.jsonl")
            need(assigned["poll_before"] is None and assigned["poll_after"] is None,
                 "worker exited before GO")
            in_job = wintypes.BOOL()
            win.ok(win.IsProcessInJob(int(process._handle), job, ctypes.byref(in_job)), "check job")
            need(in_job.value, "worker not in job")
            need(win.GetProcessId(int(process._handle)) == process.pid, "original process handle/PID")
            need(sha(worker) == worker_pin, "worker changed before GO")
            process.stdin.write(f"GO {process.pid}\n".encode("ascii"))
            process.stdin.flush()
            process.stdin.close()
            while process.poll() is None:
                observation = observe("poll")
                snap = observation["accounting"]
                need(snap["success"], "job accounting query")
                stats = snap["decoded"]
                need(observation["roles_valid"], "process-role rejection; see job_diagnostics.jsonl")
                cpu = (stats["TotalUserTime"] + stats["TotalKernelTime"]) / 10000000
                need(time.perf_counter() - started <= WALL, "wall limit")
                need(cpu <= CPU, "CPU limit")
                need((output / "stderr.log").stat().st_size <= 256 * 1024, "stderr cap")
                time.sleep(0.1)
            receipt["exit_code"] = process.wait()
        final_observation = observe("worker_exited_before_job_close", force=True)
        need(final_observation["roles_valid"], "final process-role rejection")
        snap = final_observation["accounting"]
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
        need(events[0]["kind"] == "start" and events[0]["pid"] == process.pid,
             "events not from original job worker")
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
        if job:
            try:
                closing = observe("finally_before_job_close", force=True)
                if not closing["roles_valid"]:
                    receipt["success"] = False
                    receipt["final_role_errors"] = closing["role_errors"]
            except Exception as error:
                receipt["success"] = False
                receipt["final_observation_error"] = type(error).__name__ + ": " + str(error)
        # Closing the kill-on-close job also handles an interrupted native call.
        if job:
            win.CloseHandle(job)
        if process is not None and process.poll() is None:
            process.kill()  # also handles an assignment failure before job membership
            process.wait()
        if process is not None:
            receipt["exit_code"] = process.returncode
        diagnostics.close()
        receipt["diagnostic_records"] = diagnostic_count
        receipt["diagnostic_sha256"] = sha(output / "job_diagnostics.jsonl")
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
