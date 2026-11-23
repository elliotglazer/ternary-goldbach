"""Review recorded HOL results and file bindings; not an independent kernel."""
from pathlib import Path
import hashlib
import json
import re

p = Path(__file__).resolve().parent
label = "logtail05"


def read(path):
    return path.read_text(encoding="utf-8-sig")


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_manifest(name):
    lines = read(p / name).splitlines()
    for line in lines:
        expected, item = line.split("  ", 1)
        if item.startswith("/mnt/host/c/"):
            target = Path("C:/" + item[len("/mnt/host/c/"):])
        else:
            target = p / item
        assert digest(target) == expected, (name, item)
    return len(lines)


def cpu(path):
    value = read(path)
    user = re.search(r"User time \(seconds\): ([0-9.]+)", value)
    system = re.search(r"System time \(seconds\): ([0-9.]+)", value)
    assert user and system, path
    return float(user[1]) + float(system[1])


receipt = json.loads(read(p / f"{label}_container_exit.json"))
assert receipt["exitCode"] == 0, receipt
phase_cpu = {}
for phase in ("theory", "build", "audit"):
    assert read(p / f"{label}_{phase}.status").strip() == "0", phase
    assert "Exit status: 0" in read(p / f"{label}_{phase}.time"), phase
    phase_cpu[phase] = cpu(p / f"{label}_{phase}.time")

counts = {name: verify_manifest(name) for name in (
    "source_expected.sha256", f"{label}_source.sha256",
    f"{label}_dependency.sha256", f"{label}_output.sha256")}
assert list(counts.values()) == [5, 6, 41, 3], counts
theory_log = read(p / f"{label}_theory.log")
assert 'Created theory "SourceLogTail"' in theory_log
assert "SOURCE_LOG_TAIL_PROOFS_DONE" in theory_log
audit_log = read(p / f"{label}_audit.log")
assert audit_log.count("SOURCE_LOG_TAIL_EXACT_AUDIT_DONE") == 1

original = read(p / "history/logtail01/SourceLogTailScript.sml")
current = read(p / "SourceLogTailScript.sml")
statements = r"Theorem\s+(\w+):\s*\n(.*?)\nProof\n"
assert re.findall(statements, original, re.S) == re.findall(statements, current, re.S)
assert re.findall(r"Definition .*?\nEnd", original, re.S) == re.findall(r"Definition .*?\nEnd", current, re.S)
original_audit = read(p / "history/logtail01/log_tail_audit.sml")
current_audit = read(p / "log_tail_audit.sml")
foreign_start = original_audit.index('val ancestry = "SourceInitial"')
foreign_end = original_audit.index('val _ = List.app', foreign_start)
assert current_audit == original_audit[:foreign_start] + original_audit[foreign_end:]
assert current_audit.count("val roots = [") == 1
assert current_audit.count("val ancestry =") == 1
names = [n for n, _ in re.findall(statements, current, re.S)]
audited = re.findall(r"^SOURCE_LOG_TAIL_ROOT,([^,]+),", audit_log, re.M)
assert names == audited and len(names) == 12, audited
assert "SOURCE_LOG_TAIL_AXIOMS," in audit_log

attempt_times = list(p.glob("logtail*_*.time")) + list(p.glob("log*diag*_run/time.txt"))
all_recorded_cpu = sum(cpu(path) for path in attempt_times)
outputs = ("SourceLogTailScript.sml", "log_tail_audit.sml", "source_expected.sha256",
           ".hol/objs/SourceLogTailTheory.uo", ".hol/objs/SourceLogTailTheory.dat",
           f"{label}_audit.log")
result = {
    "accepted_run": label,
    "scope": "Analytic logarithm polynomial tail only; no integer producer or campaign timing",
    "exact_roots": names,
    "manifest_counts": counts,
    "phase_cpu_seconds": phase_cpu,
    "accepted_phase_cpu_seconds": sum(phase_cpu.values()),
    "container_elapsed_seconds": receipt["elapsedSeconds"],
    "all_recorded_experiment_phase_cpu_seconds": all_recorded_cpu,
    "recorded_time_files": [str(path.relative_to(p)) for path in sorted(attempt_times)],
    "hashes": {name: digest(p / name) for name in outputs},
}
(p / "review_result.json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8", newline="\n")
hash_rows = "\n".join(f"| {name} | {value} |" for name, value in result["hashes"].items())
report = f"""# Logarithm tail result review

Run {label} is accepted for its stated analytic scope. All twelve original exact
conclusions passed the recorded-result audit with empty hypotheses, allowed
import tags and standard HOL ancestry. The two definitions, all theorem
statements and twelve expected audit statements are unchanged from the candidate frozen before the
first build. All {counts['source_expected.sha256']} expected-source,
{counts[f'{label}_source.sha256']} run-source,
{counts[f'{label}_dependency.sha256']} dependency and
{counts[f'{label}_output.sha256']} output hashes match current files. The actual
theory was rebuilt; compiling an audit module alone was not treated as running it.

The accepted result proves, for 0 <= v <= 1/3, the error bound

    abs (ln ((1+v)/(1-v)) - sl_log_partial n v)
      <= (9/4) * (1/3) pow (2*n+1).

The 45-term specialization is at most 2^-135, including ln(2) at v=1/3. The proof
uses the exact remainder derivative, the real mean-value theorem and an exact
rational inequality. No new analytic assumption or imported Lean theorem is used.

Successful construction, audit compilation and audit execution consumed
{sum(phase_cpu.values()):.2f} CPU seconds, with {receipt['elapsedSeconds']:.3f}
container elapsed seconds. All recorded proof-build and diagnostic phase times
in this directory sum to {all_recorded_cpu:.2f} CPU seconds, including the retained
failed and redundant attempts. This sum excludes untimed orchestration and file
handling. Neither timing is a production-source or campaign throughput price.

The derivative induction required explicit denominator cancellation and
distributivity. Endpoint positivity and the already-introduced existential
witness were made explicit in the remainder proof. BUILD_NOTES.md records the
failed integration attempts, which received no theorem or speed credit. The audit
wrapper also contained a leftover SourceInitial ancestry/root block, which stopped
the audit before any root checks ran. That foreign block was removed; the twelve
expected logarithm statements and validation loop are unchanged. The review checks
that this is the only difference from the original audit source.

This is a recorded-result review/reload, not an independent whole-kernel replay.
The actual integer Horner refinement, its rounding, range-reduced logarithm,
exponential step and complete source/sign/count blocks remain open.
NEXT_INTEGER_CONNECTION.md records the next precise source contract. The frozen
campaign forecast is unchanged and the full active goal remains incomplete.

| Artifact | SHA256 |
|---|---|
{hash_rows}
"""
(p / "RESULT_REVIEW.md").write_text(report, encoding="utf-8", newline="\n")
print(json.dumps(result, indent=2))
