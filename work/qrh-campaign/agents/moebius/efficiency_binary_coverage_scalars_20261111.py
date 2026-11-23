"""Only exact integer/rational size checks and read-file hashes; no prime data."""
from pathlib import Path
from fractions import Fraction
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
READ = [
    "work/qrh-blueprint/COMPUTE_FIRST_RESEARCH_AGENDA_2026-11-11.md",
    "work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md",
    "work/formal-goldbach-bench/FORECAST.md",
    "work/mm0-efficient/SCOPE.md",
    "work/formal-goldbach-bench/architecture.md",
    "work/formal-goldbach-bench/prime-cover/PACKED_REPORT.md",
    "work/formal-goldbach-bench/mm0/REPORT.md",
]
W, word, anchors, radix_bits = 2**18, 64, 512, 10
n = W // word
assert n == 4096 and anchors * n == 2097152
sample_updates = Fraction(447, 40) * n
assert sample_updates == Fraction(228864, 5)
assert 8*n + 8*1625 < sample_updates <= 8*n + 8*1626
v, span = 2**19, 4096
old_bits = radix_bits * (W+2*v)
new_bits = radix_bits * (W+2*span)
assert (old_bits, new_bits) == (13107200, 2703360)
assert Fraction(old_bits, new_bits) == Fraction(160, 33)
assert radix_bits*(W+v) == 7864320
assert radix_bits*(W+span) == 2662400
assert anchors <= 2**(radix_bits-1)
rows = []
for L in (2**32, 2**34, 2**36):
    E = 10**16//2
    R = E//L
    final_width = E-R*L+1
    assert 1 <= final_width <= L
    assert (L-2)+(R-1)*L+final_width == E-1
    rows.append({"L": L, "blocks": R, "final_width": final_width,
                 "initial_targets": L-2, "total_targets": E-1})
# Divisible final endpoint and the empty initial interval are explicit cases.
assert (2-2)+(4-1)*2+(8-4*2+1) == 8-1
out = {
    "scope": "Exact size arithmetic and file hashes only; not a coverage run or formal proof.",
    "word_count": n, "full_pool_updates": anchors*n,
    "historical_mean_comparison": {"numerator": sample_updates.numerator,
                                   "denominator": sample_updates.denominator,
                                   "largest_strictly_improving_U": 1625},
    "product_bit_bounds": {"maximum_offset": old_bits, "normalized_span": new_bits,
                           "ratio_numerator": 160, "ratio_denominator": 33},
    "range_counts": rows,
    "read_evidence": [{"path": p, "sha256": hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()}
                      for p in READ],
}
Path(__file__).with_suffix(".json").write_text(json.dumps(out, indent=2)+"\n", encoding="utf-8")
print("PASS: exact size/range arithmetic only; no coverage or prime evaluation")
