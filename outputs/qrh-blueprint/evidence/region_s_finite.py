"""Rigorous Arb checks for an elementary LSQuot3.regionS replacement.

This is external interval evidence, not a Lean proof. Prime enumeration is
exhaustive trial division; all transcendental comparisons use Arb balls.
"""
from pathlib import Path
from math import isqrt
import json
from flint import arb, ctx

ctx.prec = 256
ps = [n for n in range(2, 3001)
      if all(n % d for d in range(2, isqrt(n) + 1))]
small = [(3, "1.39953"), (5, "1.36194"), (7, "1.3115"),
         (11, "1.24148"), (13, "1.21777"), (17, "1.18326"),
         (19, "1.17031"), (23, "1.14988"), (29, "1.12806"),
         (31, "1.12235")]
theta = arb(0)
S = arb(0)
G = arb(1)
certified = []
for k, p in enumerate(ps, 1):
    theta += arb(p).log()
    if theta > 2000:
        excluded = {"k": k, "p": p, "theta": str(theta)}
        break
    g = next((arb(v) for cutoff, v in small if p <= cutoff), None)
    if g is None:
        g = arb(p) / (p - 1) * (1 + arb(p) ** (-arb(2) / 3))
    G *= g
    S += arb(3).log() / 3 if p == 2 else arb(p).log() / p
    low = theta if theta > arb("23.8143") else arb("23.8143")
    kap = arb("0.3726") * (low - S) + arb("0.0274177")
    assert kap > 0
    lam = (arb("7.4527") * G / kap) ** 3
    assert lam < 20000, (k, p, str(lam))
    certified.append({"k": k, "p": p, "lambda_bound": str(lam)})
else:
    raise AssertionError("prime enumeration cutoff too small")

g1000 = arb(1)
for p in ps:
    if p > 1000:
        break
    g1000 *= arb(p) / (p - 1) * (1 + arb(p) ** (-arb(2) / 3))
assert g1000 < 5000
assert arb(1) / 999 + arb(1) / 100 < arb("0.0017") * arb(1000).log()

# For L>=2000, the derivative of .015L - log(lambda upper bound)
# is .0099+3/L>0, so this base inequality proves the whole tail.
L = arb(2000)
log_lam = 3 * (arb("7.4527").log() + arb(5000).log()
               - arb("0.18").log() - L.log()) + arb("0.0051") * L
assert log_lam < arb("0.015") * L
assert L < (arb("0.01") * L).exp()
assert arb(3) < (arb("0.005") * L).exp()
assert arb(2000).log() < arb("0.02") * L
assert arb(2000).log() > 7
assert arb(4) / 3 * (8 + arb(18) / 7) < 15

# On each interval [p,next_prime), theta is constant and 1.039t increases.
# Therefore these prime endpoints certify the whole real interval [0,20000].
small_primes = [n for n in range(2, 20001)
                if all(n % d for d in range(2, isqrt(n) + 1))]
theta_small = arb(0)
for p in small_primes:
    theta_small += arb(p).log()
    assert theta_small < arb("1.039") * p

out = {"kind": "external rigorous Arb checks; not Lean verification",
       "precision_bits": ctx.prec,
       "finite_logq_max": 2000,
       "finite_lambda_cap": 20000,
       "finite_cases": len(certified),
       "first_excluded_prime_count": excluded,
       "last_finite_case": certified[-1],
       "all_finite_cases": certified,
       "small_prime_gp_product": str(g1000),
       "tail_loglambda_at_L2000": str(log_lam),
       "tail_loglambda_cap_at_L2000": "30",
       "finite_logP_cap_using_theta_le_2R": 42000}
out["finite_theta_range"] = [0, 20000]
out["finite_theta_prime_endpoint_checks"] = len(small_primes)
out["theta_at_20000"] = str(theta_small)
path = Path(__file__).with_name("region_s_finite.json")
path.write_text(json.dumps(out, indent=2) + "\n")
print(json.dumps({k: v for k, v in out.items() if k != "all_finite_cases"}, indent=2))
