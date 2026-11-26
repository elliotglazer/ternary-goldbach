#!/usr/bin/env python3
"""Compile one replacement against a retained failed target, with all retained inputs read-only."""
import argparse
import base64
import gzip
import hashlib
import json
import os
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import sys
import tempfile
import time

COMMIT = "d6b1bfd523e2c54b6e4bb72844deeddf8341879a"
TREE = "ddc22b3144b7147ce91c5c767690d9d56aac50ee"
ATTEMPT = "33006912706042b49c1ddbc13515a4fb"
RUNNER = "d9b3b1a3b1b4a97e7766349c0c6dfcc5e0eab6071935321482d2d91bdbaccf67"
LEAN = "bf8d54e4714cc4b03d3f6bb34c83b7202b87e49c8bfcbff6895c085bb90ceb38"


def diagnostic_scope(receipt, run, module, proc_root, cgroups):
    """Allow one low-priority process in its own unit after a real source failure."""
    require(receipt.get("runner_sha256") == RUNNER and receipt.get("tool_sha256", {}).get("lean") == LEAN,
            "Unexpected original proof worker or stock Lean binary")
    scheduling = receipt.get("project_lake_threads", {})
    require(scheduling.get("requested") == 4 and scheduling.get("effective") == 4,
            "Attempt does not use the reviewed four-thread candidate setting")
    own_path = (proc_root / "self/cgroup").read_text().strip()
    require(own_path == "0::/system.slice/tg-warm-main.service", "Not inside the sole warm-main unit")
    own = cgroups / "system.slice/tg-warm-main.service"
    memory = int((own / "memory.max").read_text())
    quota, period = map(int, (own / "cpu.max").read_text().split())
    import resource
    address_cap = resource.getrlimit(resource.RLIMIT_AS)[0]
    require(0 < memory <= 64*2**30 and 0 < quota <= 16*period and (own / "memory.swap.max").read_text().strip() == "0"
            and len(os.sched_getaffinity(0)) == 1 and 0 < address_cap <= 12*2**30,
            "Warm service quota or serial per-process limits are missing")
    other = cgroups / "system.slice/tg-source-replay.service"
    members = (other / "cgroup.procs").read_text().split() if (other / "cgroup.procs").is_file() else []
    require(not members, "Another cold source replay is active")
    preflight = run / "evidence/source-preflight.log"
    require(preflight.is_file() and not preflight.is_symlink(), "Original source preflight log missing")
    failed = re.compile(r"✖\s+\[\d+/\d+\]\s+(?:Building|Running|Replaying)\s+" +
                        re.escape(module) + r"(?:\s|$)")
    with preflight.open(errors="replace") as log:
        require(any(failed.search(re.sub(r"\x1b\[[0-?]*[ -/]*[@-~]", "", s)) for s in log),
                "Target has no real failure header on this attempt")
    return {"own_unit": own.name, "cpu_quota": quota, "cpu_period": period, "memory_max": memory,
            "memory_swap_max": 0, "per_process_address_space_bytes": address_cap,
            "affinity_cpus": 1, "proof_unit": other.name, "observed_source_failure": module}


def require(ok, message):
    if not ok:
        raise ValueError(message)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def cpu_times():
    counts = list(map(int, Path("/proc/stat").read_text().splitlines()[0].split()[1:9]))
    return sum(counts), counts[3]


def free_capacity():
    available = int(re.search(r"^MemAvailable:\s*(\d+)", Path("/proc/meminfo").read_text(), re.M).group(1))
    require(available >= 16 * 1024 * 1024, "Less than 16 GiB of host memory is available")
    total1, idle1 = cpu_times()
    time.sleep(1)
    total2, idle2 = cpu_times()
    idle_cores = os.cpu_count() * (idle2 - idle1) / max(1, total2 - total1)
    require(idle_cores >= 3, f"Only {idle_cores:.1f} idle vCPUs observed")
    return {"available_KiB": available, "idle_vcpus": round(idle_cores, 1)}


def header(source):
    """The compact sources under test have contiguous import lines ahead of their public section."""
    lines = source.decode().splitlines()
    for index, line in enumerate(lines):
        if line.strip() in ("@[expose] public section", "public section"):
            return lines[:index]
    raise ValueError("No supported section boundary before the candidate body")


def source_and_trace(run, module):
    relative = module.replace(".", "/") + ".lean"
    source = run / "source"
    candidates = [p for p in (relative, "CompactGRH/src/" + relative) if (source / p).is_file()]
    require(len(candidates) == 1, "Expected one source path for the module")
    path = candidates[0]
    trace_file = source / ".lake/build/ir" / relative.replace(".lean", ".setup.json")
    require(trace_file.is_file() and not trace_file.is_symlink(), "Original Lake setup file is absent")
    setup = json.loads(trace_file.read_text())
    require(setup["name"] == module, "Original setup belongs to a different module")
    traces = set()
    for logfile in ("source-preflight.log", "joint-source-build.log"):
        log = run / "evidence" / logfile
        if not log.is_file():
            continue
        with log.open(errors="replace") as stream:
            for line in stream:
                if "trace: .> LEAN_PATH=" in line and ("/project/" + path + " ") in line:
                    traces.add(line.split("trace: .> ", 1)[1].strip())
    require(len(traces) == 1, "No unique original failed Lake compiler invocation")
    words = shlex.split(traces.pop())
    require(words[0].startswith("LEAN_PATH=") and words[1] == "/tool/bin/lean", "Unexpected compiler trace")
    search_path = words[0].removeprefix("LEAN_PATH=")
    directories = search_path.split(":")
    require(all(re.fullmatch(r"/project/\.lake/(?:packages/[A-Za-z0-9_-]+/\.lake/)?build/lib/lean", name)
                for name in directories), "Unexpected import search path")
    source_word = "/project/" + path
    position = words.index(source_word)
    flags = words[2:position]
    require(flags in ([], ["--tstack=400000"]), f"Unsupported original frontend switches: {flags!r}")
    actual = words[position + 1:]
    require(actual and actual[-1] == "--json", "Unexpected compiler diagnostic mode")
    output_args = []
    expected = {flag: "/project/.lake/build/" + folder + "/" + relative[:-5] + suffix
                for flag, folder, suffix in [("-o", "lib/lean", ".olean"), ("-i", "lib/lean", ".ilean"),
                                             ("-c", "ir", ".c"), ("-b", "ir", ".bc"), ("--setup", "ir", ".setup.json")]}
    require(len(actual[:-1]) % 2 == 0, "Unexpected unpaired compiler option")
    seen = set()
    for flag, value in zip(actual[:-1:2], actual[1:-1:2]):
        require(flag in expected and flag not in seen and value == expected[flag], "Unexpected artifact path or option")
        seen.add(flag)
        if flag == "--setup":
            output_args.extend((flag, value))
        else:
            output_args.extend((flag, "/out/" + Path(value).name))
    require({"-o", "--setup"}.issubset(seen), "Missing original output or setup")
    return path, trace_file, setup, search_path, [*flags, source_word, *output_args, "--json"]


def sandbox(source, tool, path, replacement, output, search_path, command, bwrap):
    argv = [bwrap, "--unshare-all", "--die-with-parent", "--new-session", "--clearenv",
            "--proc", "/proc", "--dev", "/dev", "--tmpfs", "/tmp", "--dir", "/tmp/home"]
    for item in ["/usr", "/bin", "/lib", "/lib64"]:
        host = Path(item)
        if host.is_symlink():
            argv.extend(("--symlink", os.readlink(host), item))
        elif host.exists():
            argv.extend(("--ro-bind", item, item))
    argv.extend(("--ro-bind", str(tool), "/tool", "--ro-bind", str(source), "/project",
                 "--ro-bind", str(replacement), "/project/" + path, "--bind", str(output), "/out",
                 "--setenv", "PATH", "/tool/bin:/usr/bin:/bin", "--setenv", "HOME", "/tmp/home",
                 "--setenv", "LANG", "C.UTF-8", "--setenv", "LEAN_PATH", search_path,
                 "--setenv", "LEAN_NUM_THREADS", "1", "--setenv", "LEAN_ABORT_ON_PANIC", "1",
                 "--chdir", "/project"))
    return argv + command


def probe(run, module, patch, tool, bwrap):
    source = run / "source"
    path, setupfile, setup, search_path, command = source_and_trace(run, module)
    original = (source / path).read_bytes()
    require(header(original) == header(patch), "Patch changed the import header; fresh Lake setup is required")
    parents = {}
    for line in header(original):
        match = re.fullmatch(r"(?:public )?(?:meta )?import (?:all )?([A-Za-z0-9_.]+)", line.strip())
        if not match:
            continue
        name = match.group(1)
        file = source / ".lake/build/lib/lean" / (name.replace(".", "/") + ".olean")
        if file.is_file():
            trace = file.with_suffix(".trace")
            require(trace.is_file() and file.stat().st_size, "Direct parent has no completed Lake trace: " + name)
            with file.open("rb") as stream:
                parent_hash = hashlib.file_digest(stream, "sha256").hexdigest()
            parents[name] = {"bytes": file.stat().st_size, "olean_sha256": parent_hash,
                             "trace_sha256": sha(trace.read_bytes())}
        else:
            require(not (source / (name.replace(".", "/") + ".lean")).exists() and
                    not (source / "CompactGRH/src" / (name.replace(".", "/") + ".lean")).exists(),
                    "Direct project parent is missing: " + name)
    with tempfile.TemporaryDirectory(prefix="tg-one-module-") as tmp:
        scratch = Path(tmp)
        patchfile = scratch / "candidate.lean"
        patchfile.write_bytes(patch)
        out = scratch / "output"
        out.mkdir()
        cmd = sandbox(source, tool, path, patchfile, out, search_path, ["/tool/bin/lean", *command], bwrap)
        logfile = scratch / "lean.log"
        start = time.monotonic()
        with logfile.open("wb") as log:
            result = subprocess.run(cmd, stdout=log, stderr=subprocess.STDOUT)
        messages = []
        with logfile.open(errors="replace") as log:
            for line in log:
                try:
                    row = json.loads(line)
                    if row.get("severity") in ("error", "warning"):
                        messages.append({k: str(row[k])[:420] for k in ("severity", "pos", "data") if k in row})
                except ValueError:
                    messages.append({"message": line.strip()[:420]})
                if len(messages) >= 8:
                    break
        output = out / (module.rsplit(".", 1)[-1] + ".olean")
        require(result.returncode or (output.is_file() and output.stat().st_size), "Compiler omitted output")
        return {"kind": "disposable full-module frontend diagnostic", "module": module, "source_path": path,
                "original_sha256": sha(original), "replacement_sha256": sha(patch),
                "setup_sha256": sha(setupfile.read_bytes()), "original_import_entries": len(setup["importArts"]),
                "direct_project_parents": parents, "elapsed_seconds": round(time.monotonic()-start, 3),
                "exit": result.returncode, "messages": messages,
                "output_sha256": sha(output.read_bytes()) if result.returncode == 0 else None}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for option in ("commit", "tree", "attempt", "module", "patch-commit", "sha256", "data"):
        parser.add_argument("--" + option, required=True)
    args = parser.parse_args()
    require(os.geteuid() != 0, "Run under the qualified unprivileged worker account")
    for value, length in [(args.commit, 40), (args.tree, 40), (args.attempt, 32), (args.patch_commit, 40), (args.sha256, 64)]:
        require(re.fullmatch("[0-9a-f]{" + str(length) + "}", value), "Invalid immutable identifier")
    require(re.fullmatch(r"[A-Za-z0-9_]+(?:\.[A-Za-z0-9_]+)*", args.module), "Invalid module identifier")
    require(len(args.data) <= 24000, "Encoded source too large")
    patch = gzip.decompress(base64.b64decode(args.data, validate=True))
    require(len(patch) <= 512*1024 and sha(patch) == args.sha256, "Patch SHA-256 mismatch or input too large")
    run = Path("/work/compact-joint-runs") / (args.commit + "-" + args.attempt) / "run"
    require((args.commit,args.tree,args.attempt) == (COMMIT,TREE,ATTEMPT), "Unknown warm diagnostic attempt")
    receipt = json.loads((run / "evidence/receipt.json").read_text())
    require(receipt["pin"] == args.commit and receipt["git_tree"] == args.tree, "Unmatched receipt pins")
    require(str(run) == receipt["root"], "Unmatched receipt path")
    limits = diagnostic_scope(receipt, run, args.module, Path("/proc"), Path("/sys/fs/cgroup"))
    tool = Path(receipt["toolchain_path"])
    require(sha((tool / "bin/lean").read_bytes()) == receipt["tool_sha256"]["lean"], "Wrong Lean binary")
    source = run / "source"
    commit, tree = subprocess.check_output(["git", "-C", str(source), "rev-parse", "HEAD", "HEAD^{tree}"], text=True).split()
    require((commit, tree) == (args.commit, args.tree), "Retained source tree changed")
    relative = source_and_trace(run, args.module)[0]
    tracked = subprocess.check_output(["git", "-C", str(source), "show", "HEAD:" + relative])
    require(tracked == (source/relative).read_bytes(), "Retained module differs from fixed Git content")
    capacity = free_capacity()
    result = probe(run, args.module, patch, tool, shutil.which("bwrap") or "/usr/bin/bwrap")
    result.update(commit=commit, tree=tree, attempt=args.attempt, patch_commit=args.patch_commit,
                  capacity=capacity, limits=limits)
    print(json.dumps(result, sort_keys=True), flush=True)
    return 0 if result["exit"] == 0 else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as exc:
        print(json.dumps({"kind": "diagnostic unavailable", "reason": str(exc)[:700]}), flush=True)
        sys.exit(2)
