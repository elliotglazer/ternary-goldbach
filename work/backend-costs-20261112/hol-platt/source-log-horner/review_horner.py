"""Review recorded HOL results and bindings, not an independent kernel replay."""
from pathlib import Path
import hashlib
import json
import re

p = Path(__file__).resolve().parent
label = "horner02"


def read(path):
    return path.read_text(encoding="utf-8-sig")


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def manifest(name):
    lines = read(p / name).splitlines()
    for line in lines:
        expected, item = line.split("  ", 1)
        target = Path("C:/" + item[len("/mnt/host/c/"):]) if item.startswith("/mnt/host/c/") else p / item
        assert digest(target) == expected, (name, item)
    return len(lines)


def cpu(path):
    data = read(path)
    user = re.search(r"User time \(seconds\): ([0-9.]+)", data)
    system = re.search(r"System time \(seconds\): ([0-9.]+)", data)
    assert user and system, path
    return float(user[1]) + float(system[1])


receipt = json.loads(read(p / f"{label}_container_exit.json"))
assert receipt["exitCode"] == 0, receipt
phases = {}
for phase in ("theory", "build", "audit"):
    assert read(p / f"{label}_{phase}.status").strip() == "0", phase
    assert "Exit status: 0" in read(p / f"{label}_{phase}.time"), phase
    phases[phase] = cpu(p / f"{label}_{phase}.time")

counts = {name: manifest(name) for name in (
    "source_expected.sha256", f"{label}_source.sha256",
    f"{label}_dependency.sha256", f"{label}_output.sha256")}
assert list(counts.values()) == [17, 6, 49, 3], counts
construction = read(p / f"{label}_theory.log")
assert 'Created theory "SourceLogHorner"' in construction
assert "SOURCE_LOG_HORNER_PROOFS_DONE" in construction
audit = read(p / f"{label}_audit.log")
assert audit.count("SOURCE_LOG_HORNER_EXACT_AUDIT_DONE") == 1
assert audit.count("SOURCE_LOG_HORNER_AXIOMS,") == 1

original = read(p / "history/horner01/SourceLogHornerScript.sml")
current = read(p / "SourceLogHornerScript.sml")
pattern = r"Theorem\s+(\w+):\s*\n(.*?)\nProof\n"
assert re.findall(pattern, original, re.S) == re.findall(pattern, current, re.S)
assert re.findall(r"Definition .*?\nEnd", original, re.S) == re.findall(r"Definition .*?\nEnd", current, re.S)
assert (p / "horner_audit.sml").read_bytes() == (p / "history/horner01/horner_audit.sml").read_bytes()
names = [name for name, _ in re.findall(pattern, current, re.S)]
assert len(names) == 13
assert re.findall(r"^SOURCE_LOG_HORNER_ROOT,([^,]+),", audit, re.M) == names
types = re.findall(r"^SOURCE_LOG_HORNER_TYPE,([^,]+),", audit, re.M)
assert types == ["source_log_horner", "source_log_center", "slh_ideal"], types

times = list(p.glob("horner*_*.time")) + list(p.glob("hornerdiag*_run/time.txt"))
all_cpu = sum(cpu(path) for path in times)
outputs = ("SourceLogHornerScript.sml", "horner_audit.sml", "source_expected.sha256",
           ".hol/objs/SourceLogHornerTheory.uo", ".hol/objs/SourceLogHornerTheory.dat",
           f"{label}_audit.log")
result = {
    "accepted_run": label,
    "scope": "Actual integer Horner and reduced-logarithm center, including computed ln(2)",
    "exact_roots": names,
    "exact_program_types": types,
    "manifest_counts": counts,
    "phase_cpu_seconds": phases,
    "accepted_phase_cpu_seconds": sum(phases.values()),
    "container_elapsed_seconds": receipt["elapsedSeconds"],
    "all_recorded_experiment_phase_cpu_seconds": all_cpu,
    "recorded_time_files": [str(path.relative_to(p)) for path in sorted(times)],
    "hashes": {name: digest(p / name) for name in outputs},
}
(p / "review_result.json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8", newline="\n")
hashes = "\n".join(f"| {name} | {value} |" for name, value in result["hashes"].items())
report = f"""# Integer logarithm Horner result review

Run {label} is accepted for the actual integer Horner and reduced-logarithm
center scope. All thirteen frozen conclusions passed the recorded-result audit,
with empty hypotheses, permitted import tags and standard HOL ancestry. The
three exact program types passed. The original theorem statements, ideal
recurrence definition and fixed audit are unchanged. All seventeen expected-source,
six run-source, forty-nine dependency and three output hashes match. This run
rebuilt the theory and executed the audit; compiling the audit alone did not
qualify as acceptance.

The actual source_log_horner program differs from grid times the ideal real
recurrence by at most one integer unit, for any term count and starting index,
under 0 < B and 3*A <= B. The polynomial identity is proved. The actual
source_log_center program, including its final rounded multiplication, differs
from the corresponding polynomial by at most 7/(4*grid) after normalization,
with grid positive. No external approximate-value or rounding premise is assumed.

Combining this result with SourceLogTail gives the actual 45-term center bound

    abs (real_of_int (source_log_center grid A B 45) / &grid
         - ln ((1 + &A / &B) / (1 - &A / &B)))
      <= 7 / (4 * &grid) + 1 / 2 pow 135,

under 0 < grid, 0 < B and 3*A <= B. The computed ln(2) center is the A=1, B=3
specialization of that same program, with the same bound.

Successful construction and audit phases consumed {sum(phases.values()):.2f}
CPU seconds, with {receipt['elapsedSeconds']:.3f} container elapsed seconds.
All recorded experiment phases total {all_cpu:.2f} CPU seconds, including failed
and timed-out diagnostics, excluding untimed orchestration and file handling.
These are generic proof-development timings, not numerical production prices.

The repairs were a cast-rewrite orientation, use of the proved rational-square
identity, a direct power-cast proof, normalization of scalar error hypotheses,
and a directed absolute-value equality in the final triangle argument.
BUILD_NOTES.md preserves the failed and timed-out attempts. They receive no
campaign speed credit.

This is recorded-result review/reload, not independent whole-kernel replay.
Range reduction, the raw logarithm output regrid, exponential phase production,
complete source/sign/count blocks and the remaining campaign strata are open.
The campaign forecast is unchanged and the full goal remains active.

| Artifact | SHA256 |
|---|---|
{hashes}
"""
(p / "RESULT_REVIEW.md").write_text(report, encoding="utf-8", newline="\n")
print(json.dumps(result, indent=2))
