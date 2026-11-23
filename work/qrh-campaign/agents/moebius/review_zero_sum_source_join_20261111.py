"""Source hashing and exact rational checks only; no analytic function evaluations."""
from fractions import Fraction as F
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
WORK = AGENTS.parent.parent
NOTE = AGENTS / "zero-sum/ZERO_SUM_SOURCE_JOIN_2026-11-11.md"
text = NOTE.read_text(encoding="utf-8-sig")
sources = {}
for rel, expected in re.findall(r"\| ([^|]+?) \| `([A-F0-9]{64})` \|", text):
    rel = rel.strip()
    root = WORK / "ternary-goldbach/TernaryGoldbach" if rel.split('/')[0] in {
        "Explicit", "MinorArcs", "MajorArcs", "Helfgott"
    } else AGENTS
    data = (root / rel).read_bytes()
    actual = hashlib.sha256(data).hexdigest().upper()
    assert actual == expected, rel
    sources[rel] = actual

d0, ds = F(2, 10**15), F(2, 10**12)
extra = 55000*d0 + 25*ds + 87*ds + 180000000000*d0*ds
mixed = (F(5, 10000) + F(16, 100000) + extra)**2
checks = {
    "low_normalization": 1-F(111,200) == F(89,200),
    "high_normalization": 1-F(7,8) == F(1,8),
    "first_mixed_norm": F(16,100000)**2 > F(25,10**9),
    "second_mixed_norm": 55000**2 > 300000*10000,
    "third_mixed_norm": 25**2 > 300000*F(2,1000),
    "fourth_mixed_norm": 87**2 > 300000*F(25,1000),
    "extra_exact": extra == F(4175009,12500000000000000),
    "extra_budget": extra < F(1,10**9),
    "mixed_budget": mixed < F(4357,10**10),
    "astar_plus_mixed": F(25,10**8)+mixed < F(95,10**8),
}
assert all(checks.values())
result = {
    "scope": "source hashes and exact scalar inequalities only",
    "note_sha256": hashlib.sha256(NOTE.read_bytes()).hexdigest().upper(),
    "source_pins": sources,
    "checks": checks,
    "extra": str(extra),
    "mixed_upper": str(mixed),
}
out = HERE / "review_zero_sum_source_join_20261111.json"
out.write_text(json.dumps(result, indent=2, sort_keys=True)+"\n", encoding="utf-8")
print(json.dumps({"status":"PASS", "source_count":len(sources), "checks":len(checks)}))
