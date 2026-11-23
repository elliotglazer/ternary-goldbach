"""Exact cost-ratio examples and byte pins only. No prime/function evaluation."""
from fractions import Fraction
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
paths = [
    "work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md",
    "work/qrh-blueprint/HYBRID_LADDER_COST_FRONTIER_2026-11-11.md",
    "work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md",
    "work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md",
]
B0, K0, N, F = 4*10**18, 254638308, 10**27, 2**45
rows = []
for B,W,expectedK,lowden,highden in [
    (10**16,128,181029996372,712,711),
    (2*10**16,256,90804183483,358,357),
]:
    stride_units = (B-2)//F-(W-1)
    K = (N-5)//(stride_units*F)
    assert K == expectedK and stride_units >= W
    assert (stride_units+W-1)*F+2 <= B
    assert stride_units*K < F
    qcrit = (1-Fraction(B,B0))/(Fraction(K,K0)-1)
    assert Fraction(1,lowden) < qcrit < Fraction(1,highden)
    rows.append({"B":B,"W_lad":W,"S_lad":stride_units,"K":K,
                 "qcrit_num":qcrit.numerator,"qcrit_den":qcrit.denominator,
                 "strict_lower_den":lowden,"strict_upper_den":highden})
assert Fraction(2**19,2**32) == Fraction(1,8192)
assert 2**19//8 == 65536
# Exact finite algebra check of the shrink test on arbitrary rational costs.
for s in (2,10,400):
    binary, ladder = Fraction(137,3), Fraction(5,7)
    change = binary/s + ladder*s - binary-ladder
    assert change == (s-1)*(ladder-binary/s)
receipt = {
    "scope":"Exact rational cost identities, geometry and byte pins; no new prime evidence or timing.",
    "ladder_examples":rows,
    "halo_max_bytes_saved_at_fixed_L":65536,
    "pins":[{"path":p,"sha256":hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()} for p in paths],
}
Path(__file__).with_suffix(".json").write_text(json.dumps(receipt,indent=2)+"\n",encoding="utf-8")
print("PASS: exact break-even ratios/geometry only")
