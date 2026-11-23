"""Count uses of the repeated 1,152-point p24 trial's exact dimension and cap."""
import json
from collections import Counter
from pathlib import Path

here = Path(__file__).resolve().parent
rows = json.loads((here.parents[2] / "qrh-campaign/agents/integration/transform_structural_manifest_20261111.json").read_bytes())["conductors"]
trial = next(line for line in (here / "panel.txt").read_text().splitlines() if line.startswith("1152 "))
n_test, precision, cap, width = map(int, trial.split()[:4])
assert (n_test, precision, cap, width) == (1152, 24, 1900544, 11)
rates = json.loads((here / "repeated.json").read_text())[str(n_test)]
counts = Counter()
for _, phi, _, _, last_index, axes, _ in rows:
    suffix, full, kept = phi, 1, 1
    for i, (n, omission) in enumerate(axes):
        suffix //= n
        if n == n_test and 32768 * full == cap:
            count = kept * suffix * (last_index + 41 + 640)
            counts["final" if i == len(axes)-1 else "interior"] += count
        full *= n
        kept *= n - (n // omission if omission else 0)
print(dict(counts))
for label, count in counts.items():
    print(label, "projected CPU hours saved", count * (rates["baseline"] - rates["fused"]) / 3600)
