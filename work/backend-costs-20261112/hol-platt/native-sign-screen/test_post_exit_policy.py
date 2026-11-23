"""Synthetic pure-policy tests and integer-only review of saved screen04 data.

No process launch, Windows API, FLINT import or numerical function evaluation.
The runner module is imported for one pure function; its main is not invoked.
"""
from pathlib import Path
from copy import deepcopy
from fractions import Fraction
import hashlib
import importlib.util
import json

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("policy_only", HERE / "run_screen_v6.py")
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
check = module.original_identity_errors
path = "C:\\Users\\test\\python.exe"
prior = {"valid": True, "pid": 123, "times_success": True, "creation_filetime": 456,
         "image": {"success": True, "complete": True, "path": path}}
gone_image = deepcopy(prior)
gone_image["valid"] = False
gone_image["image"] = {"success": False, "complete": False, "path": "", "error_on_failure": 6}
cases = []


def test(name, current, previous=prior, status=None, ok=True, code=259, accepted=False):
    errors = check(current, previous, 123, path, status, ok, code)
    assert (not errors) == accepted, (name, errors)
    cases.append({"name": name, "accepted": not errors, "errors": errors})


test("initial live identity", prior, previous=None, accepted=True)
test("live identity unchanged", prior, accepted=True)
test("live image failure rejected", gone_image)
test("exit zero image failure permitted", gone_image, status=0, code=0, accepted=True)
test("exit nonzero identity only permitted; outer success still requires zero", gone_image,
     status=3, code=3, accepted=True)
test("exit full identity", prior, status=0, code=0, accepted=True)
test("missing exit query rejected", gone_image, status=0, code=0, ok=False)
test("inconsistent exit query rejected", gone_image, status=0, code=259)
for key, value in (("pid", 124), ("creation_filetime", 457), ("times_success", False)):
    changed = deepcopy(gone_image)
    changed[key] = value
    test("changed " + key + " rejected", changed, status=0, code=0)
wrong_image = deepcopy(prior)
wrong_image["image"]["path"] = "C:\\wrong.exe"
test("successful wrong post-exit image rejected", wrong_image, status=0, code=0)
incomplete = deepcopy(prior)
incomplete["image"]["complete"] = False
test("successful truncated post-exit image rejected", incomplete, status=0, code=0)
test("missing first identity cannot be recovered at exit", gone_image, previous=None, status=0, code=0)

# Recheck serialized numeric acceptance without computing any analytic values.
run = HERE / "runs/screen04"
pins = {
    "receipt.json": "3A5AE78330C70C0B8039430551455CCBD113F18E46E50F330400FB655DA246D5",
    "events.jsonl": "97EFF26D747057A442D1E2B07C75BF5AFE719F1C6C2ED94DFEC5215C66324795",
    "job_diagnostics.jsonl": "63D184F238AA760270097C9F9F229AC7D039510B2CD6262DD1CF1A38577ECC0F",
}
for name, pin in pins.items():
    assert hashlib.sha256((run / name).read_bytes()).hexdigest().upper() == pin
events = [json.loads(line) for line in (run / "events.jsonl").read_text().splitlines()]
points = [e for e in events if e["kind"] == "point"]
labels = [f"chi{c}_t{n}_{d}" for c in (1877, 2813)
          for n, d in ((0, 1), (5, 64), (3290, 1), (6580, 1))]
assert [e["label"] for e in points] == labels
assert events[-1]["kind"] == "complete" and events[-1]["completed"] == labels
eps = Fraction(1, 2**80 * 4 * 3**64)
radius = 3 * eps / (4 * Fraction(6, 40960)) + Fraction(524288 * 42 * (2 * 1250000**2 + 2), 2**160)
threshold = 2 * Fraction(44, 7 * 40960) * radius
saved = next(e["physical_threshold"] for e in events if e["kind"] == "threshold")
assert Fraction(int(saved["numerator"]), int(saved["denominator"])) == threshold
for point in points:
    m, e = point["lower_abs_Q"]
    lower = Fraction(int(m) * 2**e) if e >= 0 else Fraction(int(m), 2**(-e))
    assert lower > threshold and point["status"] == "pass" and point["strict_comparison"] is True
receipt = json.loads((run / "receipt.json").read_text())
assert receipt["success"] is False and receipt["exit_code"] == 0
assert receipt["last_observation"]["pid_list"]["pids"] == []
print(json.dumps({"synthetic_cases": cases, "recorded_integer_comparisons_passed": len(points),
                  "historical_success_flag_unchanged": receipt["success"],
                  "no_native_calls_or_process_launch": True}, indent=2))
