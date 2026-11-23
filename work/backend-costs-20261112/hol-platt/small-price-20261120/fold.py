from collections import Counter, defaultdict
from itertools import permutations
from math import prod
from pathlib import Path
import json, hashlib

base = Path("work/qrh-campaign/agents/prime-estimates")
producer = (base / "small_family_minimal_theta_20261111.py").read_text()
# Reuse the original pure axis prices and factorization without executing its scenario writer.
exec(producer[:producer.index("for f,h in PINS.items()")])
meta = json.loads((base/"sign_only_minimal_theta_nonprincipal_schedule_20261111.json").read_bytes())
cohorts = defaultdict(Counter)
for c, m, N, bits_, exp_ in meta["scenarios"][0]["small_sign_only_conditional_candidate"]["raw_metadata"]:
    v, n, dims = cdata(c)
    retained = []
    for p, e in factors(c):
        if p == 2:
            retained.extend([1] if e == 2 else [2, 2**(e-3)])
        else:
            retained.append(p-2 if e == 1 else (p-1)**2*p**(e-2))
    assert prod(retained) == n and len(retained) == len(dims)
    h = 1 if c in (3,4,12) else 2
    reps = h*((50*N+383)//384+1)
    def charge(order, prune):
        states = v
        butterflies = points = 0
        for i in order:
            d = dims[i]
            b, pp, *_ = axis(d)
            butterflies += states//d*b
            points += states//d*pp
            if prune:
                states = states//d*retained[i]
        return butterflies, points
    # Restrict to orders saving both types relative to dense; optimize butterfly count.
    dense = charge(range(len(dims)), False)
    reduced = min(charge(order, True) for order in permutations(range(len(dims))))
    original = charge(range(len(dims)), True)
    values = dict(original_projected_b=original[0]*reps, original_projected_points=original[1]*reps, rows=1, dense_b=dense[0]*reps, dense_points=dense[1]*reps,
                  projected_b=reduced[0]*reps, projected_points=reduced[1]*reps)
    for cohort in ("total", f"{len(dims)} axes", f"{h} parity inputs"):
        cohorts[cohort].update(values)
    if c == 10000:
        cohorts["c10000"].update(values)
assert cohorts["total"]["dense_b"] == 128941391789290
assert cohorts["total"]["dense_points"] == 25399177848072
print(json.dumps(cohorts, indent=2))

