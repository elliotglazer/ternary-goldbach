"""Read-only strict receipt audit. Never invokes HOL or a compiler.

This checks recorded evidence, not universal evaluator equivalence. Requires
the reviewed manifest; a repaired harness must receive a newly reviewed pin.
"""
from pathlib import Path
from collections import Counter
from decimal import Decimal
import argparse
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
MANIFEST = "16121c4faeee89b7cdf0982b5226bd885a887ba619ec21cb1e8bd3235ce34e7f"
LABELS = ["depth1", "depth8", "depth32", "depth128"] + [
    "control_" + c for c in ("checksum", "bound", "depth", "input", "coefficient")]
CONTROLS = [s[8:] for s in LABELS[4:]]

def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def require(b, msg):
    if not b:
        raise ValueError(msg)

def resolve(name):
    if name.startswith("/mnt/host/c/"):
        return Path("C:/" + name[len("/mnt/host/c/"):])
    return HERE / name

def verify_snapshots(label):
    out = {}
    for kind in ("sources", "dependencies", "toolchain", "executable"):
        path = HERE / f"{label}_{kind}.sha256"
        entries = []
        for line in path.read_text().splitlines():
            match = re.fullmatch(r"([0-9a-fA-F]{64})  (.+)", line)
            require(match is not None, f"bad hash entry in {path.name}")
            pin, name = match.groups()
            require(digest(resolve(name)) == pin.lower(), f"changed file: {name}")
            entries.append(name)
        require(len(entries) == len(set(entries)), f"duplicate snapshot: {kind}")
        suffix = {"sources": "source", "dependencies": "dependency"}.get(kind, kind)
        checks = (HERE / f"{label}_{suffix}_check.log").read_text().splitlines()
        require(checks == [name + ": OK" for name in entries], f"bad postcheck: {kind}")
        out[kind] = len(entries)
    return out

def verify_exit(stem):
    lines = (HERE / (stem + ".time")).read_text().splitlines()
    require([s.strip() for s in lines if "Exit status:" in s] == ["Exit status: 0"],
            f"missing successful exit: {stem}")

def expected_timings():
    names = ["syntax_validation"]
    fixed = ["discover", "parse_code", "parse_request", "compile_code", "compile_request",
             "stock_first_raw", "compiled_first_raw", "stock_reconstruct", "compiled_reconstruct",
             "stock_kernel_reference", "fresh_compile_execute"]
    for label in LABELS:
        names += [label + ":" + s for s in fixed]
        names += [f"{label}:{s}:r{i}" for i in range(3) for s in
                  ("stock_raw", "compiled_raw", "stock_total", "compiled_total")]
    require(len(names) == 208, "internal expected-row mistake")
    return Counter(names)

def verify_process(prefix, order, sample):
    stem = f"{prefix}_{order}_{sample}"
    verify_exit(stem)
    argv = (HERE / (stem + ".argv")).read_text().splitlines()
    require(argv == ["/usr/bin/env", "COMPILED_ORDER=" + order, "./compiled_dependent.exe"],
            "unexpected process command")
    lines = (HERE / (stem + ".log")).read_text().splitlines()
    require([s for s in lines if s.startswith("COMPILED_SEMANTICS_PASS")] ==
            ["COMPILED_SEMANTICS_PASS,259"], "semantic marker/count")
    require([s for s in lines if s.startswith("COMPILED_ORDER,")] == ["COMPILED_ORDER," + order],
            "order marker")
    require(lines.count("HOL4_COMPILED_DEPENDENT_BENCHMARK_DONE") == 1, "completion marker")
    passes = [s.split(",") for s in lines if s.startswith("COMPILED_WORKLOAD_PASS,")]
    require([s[1] for s in passes] == LABELS, "workload label order/bijection")
    require(all(len(s) == 3 and re.fullmatch(r"cval_nodes=[1-9][0-9]*", s[2]) for s in passes),
            "invalid value count")
    require([s for s in lines if s.startswith("HOL4_REJECTED_")] ==
            ["HOL4_REJECTED_" + c for c in CONTROLS], "rejection order/bijection")
    times = [s.split(",") for s in lines if s.startswith("COMPILED_TIME,")]
    require(all(len(s) == 4 for s in times), "timing format")
    require(Counter(s[1] for s in times) == expected_timings(), "timing labels/count/duplicates")
    for row in times:
        for value in row[2:]:
            n = Decimal(value)
            require(n.is_finite() and n >= 0, "invalid time")
    for label in LABELS:
        require(sum(s.startswith("COMPILED_REQUEST," + label + ",") for s in lines) == 1,
                "request count")
        ast = [s.split(",") for s in lines if s.startswith("COMPILED_AST," + label + ",")]
        require(len(ast) == 1 and len(ast[0]) == 5, "AST metadata")
        code_count = int(ast[0][2])
        require(code_count >= 0 and all(int(x) >= 1 for x in ast[0][3:]), "AST sizes")
        eqs = [s.split(",", 3) for s in lines if s.startswith("COMPILED_EQUATION," + label + ",")]
        require([int(s[2]) for s in eqs] == list(range(code_count)), "equation index coverage")
    data = (HERE / (stem + ".dat")).read_bytes()
    for label in LABELS:
        require(("compiled_stock_reference_" + label).encode() in data, "missing exported reference")
    return {"stem": stem, "timing_rows": len(times), "log_sha256": digest(HERE / (stem + ".log")),
            "export_sha256": hashlib.sha256(data).hexdigest(),
            "scope": "recorded checks and export-name presence; not independent theorem decoding"}

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("label")
    parser.add_argument("--samples", type=int, choices=(1, 3), default=1)
    args = parser.parse_args()
    require(re.fullmatch(r"[A-Za-z0-9_]+", args.label) is not None, "bad label")
    require(digest(HERE / "harness_source_binding.json") == MANIFEST, "unreviewed manifest")
    manifest = json.loads((HERE / "harness_source_binding.json").read_text())
    for kind in ("output_pins", "support_pins"):
        for name, pin in manifest[kind].items():
            require(digest(HERE / name) == pin, "unreviewed source: " + name)
    snapshots = verify_snapshots(args.label)
    verify_exit(args.label + "_build")
    results = [verify_process(args.label, order, i) for i in range(1, args.samples + 1)
               for order in ("stock-first", "compiled-first")]
    print(json.dumps({"status": "PASS recorded strict result checks", "snapshots": snapshots,
                      "processes": results}, indent=2))

if __name__ == "__main__":
    main()
