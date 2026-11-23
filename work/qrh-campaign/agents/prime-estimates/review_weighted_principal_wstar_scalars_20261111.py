"""Independent rational-only checks; no author import or analytic evaluation."""
from fractions import Fraction as Q
from pathlib import Path
import json

base = Path(__file__).resolve().parents[3] / "qrh-blueprint"
source = json.loads((base / "weighted_principal_wstar_20261111.json").read_text())
rho, u, j = Q(885, 10**9), Q(367, 10**8), Q(879, 100)
p1, d = Q(1502, 10**9), Q(2, 10**9)
checks = 0

def check(condition):
    global checks
    assert condition
    checks += 1

check(Q(49 * 10**25, 49) == 10**25)
check(Q(4 * 132900, 49) < 1200000)
check(Q(1, 10**12) <= d)
check(Q(1, 10**17) + Q(4700000, 3160000000000) < Q(15, 10**7))
check(3160000000000**2 < 10**25)
check(16 * 150000 * 19 * rho**2 < Q(6, 1000)**2)
check(Q(1, 8) * Q(3, 2) == Q(3, 16))
mass = 2 / (1 - Q(3, 16))
check(mass == Q(32, 13) == Q(source["M3_bound"]))
check(Q(640208, 10**6) * mass < Q(1256, 1000)**2)
check(Q(1256, 1000) + Q(6, 1000) == Q(1262, 1000))
check(Q(2964, 1000)**2 < j < 9)
principal = p1 * Q(1262, 1000) + 3 * d
budget = Q(1902, 10**9)
check(principal == Q(source["principal_intermediate"]))
check(principal < budget == Q(source["principal_budget"]))
rows = []
for i, (a, b) in enumerate([(Q(3, 10**6),45),(Q(2, 10**6),62),(Q(1, 10**6),81),(Q(0),102)]):
    room = u * Q(2964, 1000) - budget - a
    check(room > 0)
    # Squaring a positive reserve proves the square-root inequality directly.
    gap = room**2 - rho**2 * b
    check(gap > 0)
    old = source["allocations"][i]
    check(Q(old["A_bound"]) == a*a and old["B_bound"] == b)
    check(Q(old["sqrtB_upper_allowed"]) == room/rho)
    check(Q(old["squared_margin"]) == gap/rho**2)
    rows.append({"A":str(a*a),"B":b,"squared_norm_reserve":str(gap)})
ceiling = ((3*u-budget)/rho)**2
check(ceiling == Q(source["coarse_B_ceiling_for_this_allocation"]))
check(ceiling < Q(588,5))
out = Path(__file__).with_suffix('.json')
assert not out.exists(), 'Do not overwrite frozen independent receipt'
out.write_text(json.dumps({"status":"PASS_RATIONAL_ONLY", "checks":checks,
    "rows":rows,"coarse_B_ceiling":str(ceiling),
    "scope":"No actual A/B, prime, character, Fourier, or spectral values evaluated"}, indent=2)+'\n')
print(json.dumps({"checks":checks,"output":str(out)}))
