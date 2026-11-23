"""Exact integer coverage/cost-interface calculations only."""
from pathlib import Path
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
N=10**27
rows=[]
for B, expected in [(10**16,10**11),(2*10**16,5*10**10)]:
    targets=(N-B-4)//2
    per_prime=B//2-1
    bound=(targets+per_prime-1)//per_prime
    assert bound==expected
    assert (N-B-4+ B-3)//(B-2)==expected
    rows.append({"B":B,"remaining_odd_targets":targets,
                 "max_targets_per_prime_window":per_prime,
                 "minimum_explicit_prime_windows":bound,
                 "first_x":3,"last_x":N-B-3})
margin=10**16-4-9750000000000000
assert margin==249999999999996 and margin>0
paths=[
    "work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean",
    "work/ternary-goldbach/TernaryGoldbach/Ladder/Main.lean",
    "work/qrh-campaign/agents/moebius/EFFICIENCY_JOINT_BINARY_FRONTIER_2026-11-11.md",
]
out={"scope":"Exact integer arithmetic and source byte pins only. No analytic theorem validation or prime evaluation.",
     "window_counts":rows,"conditional_theta_margin":margin,
     "pins":[{"path":p,"sha256":hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()} for p in paths]}
Path(__file__).with_suffix(".json").write_text(json.dumps(out,indent=2)+"\n",encoding="utf-8")
print("PASS: coverage indices, representation counts and conditional scalar margin only")
