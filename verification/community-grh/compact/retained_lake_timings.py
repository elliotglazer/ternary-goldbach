#!/usr/bin/env python3
"""Summarize one immutable-length read of the retained joint Lake build log."""
import base64
from collections import Counter
from datetime import datetime, timezone
from decimal import Decimal
import gzip
import hashlib
import json
import os
from pathlib import Path
import re


PIN = "0b68b493791e5f7569021f0cd13454151af47584"
TREE = "6d8764b58d1a41584cd5d43fd3e400f6ee55d18e"
ATTEMPT = "d69a0b0ad9464dbc84198f6c547221c7"
BEFORE = "bfd8836e864b164ae5820b7d83d943f9b97dd6211dff116fa648eca80d1f6577"
UTC = "2026-11-26T00:42:20.463657+00:00"
ANSI = re.compile(r"\x1b\[[0-?]*[ -/]*[@-~]")
HEADER = re.compile(r"^\S+\s+\[(\d+)/(\d+)\]\s+(Built|Building|Running|Replaying|Ran|Replayed|Compiled|Compiling)\s+(\S+)(?:\s+\((\d+(?:\.\d+)?)(ms|s|m|h)\))?\s*$")
LOCATION = re.compile(r"^(?:error:\s+(.+?\.lean):(\d+):(\d+):\s*(.*)|(.+?\.lean):(\d+):(\d+):\s*error:\s*(.*))$")
PHASES = ("printed_before_snapshot", "printed_after_snapshot", "unclassified")
MULTIPLIER = {"ms": 1, "s": 1000, "m": 60000, "h": 3600000}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def json_bytes(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=True).encode()


def prefix_length(data, expected, snapshot=None):
    if snapshot is not None and sha(snapshot) == expected and data.startswith(snapshot):
        return len(snapshot)
    digest = hashlib.sha256()
    end = 0
    if digest.hexdigest() == expected:
        return 0
    for part in data.splitlines(keepends=True):
        digest.update(part)
        end += len(part)
        if digest.hexdigest() == expected:
            return end
    # A snapshot can end mid-write, outside a complete line. Bound the slow fallback.
    if len(data) <= 4 * 1024**2:
        digest = hashlib.sha256()
        for end, byte in enumerate(data, 1):
            digest.update(bytes((byte,)))
            if digest.hexdigest() == expected:
                return end
    return None


def namespace(module):
    parts = module.split(".")
    return ".".join(parts[:2]) if len(parts) > 1 else "Goldbach (top-level)"


def analyze(data, expected, project_module, snapshot=None):
    boundary = prefix_length(data, expected, snapshot)
    groups = {p: {} for p in PHASES}
    timed = {p: [] for p in PHASES}
    errors = []
    failed = []
    seen_errors = set()
    lines_total = Counter()
    position = 0
    progress = None
    partial = 0
    in_failure_footer = False
    for raw in data.splitlines(keepends=True):
        position += len(raw)
        if not raw.endswith((b"\r", b"\n")):
            partial = len(raw)
            continue
        phase = PHASES[2] if boundary is None else (PHASES[0] if position <= boundary else PHASES[1])
        line = ANSI.sub("", raw.decode("utf-8", "replace").strip())
        if line == "Some required targets logged failures:":
            in_failure_footer = True
            continue
        if in_failure_footer:
            footer = re.fullmatch(r"- (\S+)", line)
            if footer:
                if not any(module == footer[1] for _, module in failed):
                    failed.append([phase, footer[1]])
                continue
            in_failure_footer = False
        result = HEADER.fullmatch(line)
        if result:
            job, total, verb, module, value, unit = result.groups()
            progress = [int(job), int(total)]
            if line.startswith("✖") and verb in ("Building", "Running", "Replaying", "Compiling"):
                item = [phase, module]
                if item not in failed:
                    failed.append(item)
            if verb == "Built" and value and project_module(module):
                duration = int(Decimal(value) * MULTIPLIER[unit])
                timed[phase].append((duration, module))
                fields = groups[phase].setdefault(namespace(module), [0, 0, 0])
                fields[0] += 1
                fields[1] += duration
                fields[2] = max(fields[2], duration)
            continue
        error = LOCATION.fullmatch(line)
        if error:
            path, row, col, message = error.groups()[:4] if error[1] else error.groups()[4:]
            path = path.removeprefix("/project/").removeprefix("./")
            lines_total[phase] += 1
            key = (phase, path, int(row), int(col), message)
            if key not in seen_errors:
                seen_errors.add(key)
                errors.append([phase, path, int(row), int(col), message[:240]])
    ranking = {
        p: [[module, ms] for ms, module in sorted(timed[p], key=lambda x: (-x[0], x[1]))[:12]]
        for p in PHASES if timed[p]
    }
    return {
        "before_sha256_expected": expected,
        "before_sha256_verified": sha(data[:boundary]) if boundary is not None else None,
        "before_bytes": boundary, "current_bytes": len(data), "current_sha256": sha(data),
        "trailing_incomplete_bytes": partial, "last_lake_header_jobs": progress,
        "phases": {
            p: {"namespace_count_sum_max_ms": groups[p], "timed_headers": len(timed[p]),
                "top_modules_ms": ranking.get(p, []), "source_error_headers": lines_total[p]}
            for p in PHASES if timed[p] or lines_total[p] or any(x[0] == p for x in failed)
        },
        "failed_targets": failed, "error_locations": errors, "unique_error_count": len(errors),
        "scope": "Times are Lake's rounded module build milliseconds. Sums include overlapping jobs. "
                 "The verified prefix ends at the pre-change snapshot, before the memory settings were changed. "
                 "Later completions may include work under both limits. "
                 "Unclassified entries have no authenticated pre-change prefix.",
    }


def main():
    run = Path("/work/compact-joint-runs") / (PIN+"-"+ATTEMPT) / "run"
    receipt = json.loads((run/"evidence/receipt.json").read_text())
    require((receipt.get("root"), receipt.get("pin"), receipt.get("git_tree")) == (str(run), PIN, TREE),
            "Retained receipt does not match the requested instance attempt scope")
    stage = next((s for s in receipt["steps"] if s["name"] == "joint-source-build"), None)
    require(stage is not None, "Joint build not present in receipt")
    log = run/"evidence/joint-source-build.log"
    require(log.is_file() and not log.is_symlink(), "Retained joint build log absent")
    out_time = datetime.now(timezone.utc).isoformat()
    with log.open("rb") as stream:
        length = os.fstat(stream.fileno()).st_size
        require(length <= 64 * 1024**2, "Source timing log exceeds 64 MiB read bound")
        data = stream.read(length)
        require(len(data) == length, "Log changed length during read")
    source = run/"source"
    def project_module(name):
        if not re.fullmatch(r"[A-Za-z_0-9]+(?:\.[A-Za-z_0-9]+)*", name):
            return False
        relative = Path(*name.split(".")).with_suffix(".lean")
        return (source/relative).is_file() or (source/"CompactGRH/src"/relative).is_file()
    snapshot = None
    candidates = []
    for folder in (run / "evidence", run.parent):
        for item in folder.iterdir():
            if item.is_file() and ("before" in item.name or "prechange" in item.name or "pre-change" in item.name):
                candidates.append(item)
            elif item.is_dir() and ("operator" in item.name or "diagnostic" in item.name):
                candidates.extend(p for p in item.glob("*.log*") if p.is_file())
    for candidate in candidates[:15]:
        if candidate.is_symlink() or candidate.stat().st_size > 16 * 1024**2:
            continue
        raw = candidate.read_bytes()
        if sha(raw) == BEFORE:
            snapshot = raw
            break
    result = analyze(data, BEFORE, project_module, snapshot)
    if snapshot is not None and result["before_bytes"] is None:
        prior = analyze(snapshot, BEFORE, project_module, snapshot)
        result["separate_pre_change_log"] = {
            "bytes": len(snapshot), "sha256": BEFORE, "phases": prior["phases"],
            "failed_targets": prior["failed_targets"], "error_locations": prior["error_locations"][:60],
        }
    completed = stage.get("log_sha256")
    require(not completed or completed == result["current_sha256"], "Terminal receipt disagrees with source log")
    result.update(attempt=ATTEMPT, commit=PIN, tree=TREE, observed_utc=out_time, receipt_status=receipt.get("status"),
                  change_record_utc=UTC, stage_exit=stage.get("exit"), terminal_log_sha256=completed,
                  original_memory_high_max_bytes=[65283502080,67345084416], new_requested_high_max_bytes=[163208757248,188978561024])
    def encode(value):
        raw = json_bytes(value)
        return "TG_LAKE_TIMINGS_V1 "+sha(raw)+" "+base64.b64encode(gzip.compress(raw,mtime=0)).decode()
    result["omitted_error_locations"] = 0
    response = encode(result)
    while len(response) >= 21500 and result["error_locations"]:
        result["error_locations"].pop()
        result["omitted_error_locations"] += 1
        response = encode(result)
    require(len(response) < 21500, "Summary exceeds SSM stdout bound")
    print(response)


if __name__ == "__main__":
    main()
