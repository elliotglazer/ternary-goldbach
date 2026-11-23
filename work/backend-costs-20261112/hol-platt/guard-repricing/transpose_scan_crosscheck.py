"""Replace the pretransposed scan in the normalized terminal scenarios."""
import json
from pathlib import Path
from statistics import median

here = Path(__file__).resolve().parent
receipts = here.parent / "large-terminal-signs"
ledger = json.loads((here / "normalized_terminal.json").read_text())
full = ledger["full_grid_outputs"]


def scan_hours(name):
    assert (receipts / (name + ".status")).read_text().strip() == "0"
    groups = {}
    for line in (receipts / (name + ".log")).read_text().splitlines():
        if line.startswith("STREAM "):
            _, panel, repeats = line.split()
        elif line.startswith("JOIN_EVAL "):
            groups.setdefault((panel, repeats), []).append(float(line.split()[2]))
    result = []
    for panel, width in [("low", 32), ("high", 16)]:
        hot, cold = (groups[panel, repeats] for repeats in ["8", "0"])
        assert len(hot) == len(cold) == 2
        result.append((median(hot) - median(cold)) * full / (8 * 2301 * width * 3600))
    return sorted(result)


old = scan_hours("f07StreamPrice")
joint = scan_hours("even01TransposePrice")
assert all(abs(a - b) < 1e-7 for a, b in zip(old, ledger["count_hours"]))
print("Transpose and scan", joint)
for key in ["fused_zero_increment_for_long_only", "direct_terminal_on_all_outputs"]:
    print(key, [v - s + t for v, s, t in zip(ledger[key], old, joint)])
