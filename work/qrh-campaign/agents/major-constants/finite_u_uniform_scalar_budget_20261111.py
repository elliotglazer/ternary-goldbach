"""Exact scalar checks only. No L-values, transforms, meshes, or models."""
from fractions import Fraction as F
from math import comb, factorial
from pathlib import Path
import json


def pow2(k):
    return F(2**k) if k >= 0 else F(1, 2**(-k))


def encode(x):
    if isinstance(x, F):
        return {"numerator": str(x.numerator), "denominator": str(x.denominator)}
    if isinstance(x, dict):
        return {k: encode(v) for k, v in x.items()}
    if isinstance(x, list):
        return [encode(v) for v in x]
    return x


checks = []


def check(label, condition):
    assert condition, label
    checks.append(label)


rho = F(1, 16)
sigma = F(111, 200) - rho
check("target sigma is 197/400", sigma == F(197, 400))
check("outer sigma exceeds -1/2", F(111, 200)-1 > -F(1, 2))
check("full-disk extra power is bounded by factor two", 27*(F(1, 2)-sigma) < 1)

# Verify every Bernoulli-number bound consumed by either finite rule.
bernoulli = [F(1)]
for n in range(1, 65):
    bernoulli.append(-sum(F(comb(n+1, j))*bernoulli[j] for j in range(n))/F(n+1))
for m in range(1, 33):
    check(f"Bernoulli coefficient m={m}", abs(bernoulli[2*m])/factorial(2*m) <= F(4, 6**(2*m)))
check("correction geometric series", F(4, 9)/(1-F(4, 9)) == F(4, 5))

primary = {}
Xcap = 100_000_000 + 38*300_000
check("primary Xmax bound", Xcap == 111_400_000 and Xcap < 2**27)
check("primary sqrt bound", Xcap < (2**14)**2)
check("primary outer prefactor", 1+F(23, 10*36) < 2)
outer = pow2(42)
em = F(8*2**14, 1)/(31+sigma)/6**32
taylor = outer*rho**30/(1-rho)
check("primary EM <2^-70", em < pow2(-70))
check("primary Taylor <2^-77", taylor < pow2(-77))
check("primary analytic norm <2^-69", em+taylor < pow2(-69))
check("primary analytic square norm <2^-68", F(3,2)*(em+taylor) < pow2(-68))
# Weighted main-sum truncation from the accepted character-height adapter.
check("weighted head sum <2^18", F(8,5)**8*F(2**27)**5 < F(2**18)**8)
batch = F(2**18, factorial(32))
check("optional p32 batching <2^-99", batch < pow2(-99))
arithmetic = pow2(-70)
complete = F(3,2)*(em+taylor)+batch+arithmetic
check("optional complete conditional norm <2^-68", complete < pow2(-68))
primary.update(M=16, K=30, N_rule="ceil(T)+36", Xmax_strict_cap=Xcap,
               outer_strict_bound=outer, em_upper=em, taylor_upper=taylor,
               analytic_norm_upper=em+taylor, analytic_square_norm_upper=F(3,2)*(em+taylor),
               optional_residual_length=32, optional_batch_upper=batch,
               optional_all_finite_arithmetic_norm_allowance=arithmetic,
               optional_complete_norm_upper=complete)

# Separate, less accurate smaller-N comparison. Not the primary parameters.
Xcap2 = F(100_000_000, 3)+24*300_000
check("comparison Xmax bound", Xcap2 < 2**26)
check("comparison sqrt bound", Xcap2 < 6400**2)
check("comparison outer prefactor", 1+F(23, 10*22) < 2)
em2 = F(8*6400)/(63+sigma)*pow2(-64)
tail2 = pow2(40)*rho**24/(1-rho)
check("comparison EM <2^-54", em2 < pow2(-54))
check("comparison Taylor <2^-55", tail2 < pow2(-55))
check("comparison analytic norm <2^-53", em2+tail2 < pow2(-53))
comparison = dict(M=32, K=24, N_rule="ceil((T+66)/3)", Xmax_strict_cap=Xcap2,
                  outer_strict_bound=pow2(40), em_upper=em2, taylor_upper=tail2,
                  analytic_norm_upper=em2+tail2)

examples = []
for c in (3, 4, 101, 100003, 300000):
    T = F(100_000_000, c)
    N = -(-T.numerator // T.denominator)+36
    v = sum(1 for a in range(1, c) if __import__('math').gcd(a, c) == 1)
    # This is only finite integer arithmetic, not a spectral scan.
    examples.append(dict(c=c, T=T, N=N, v=v, residue_head_terms=v*N,
                         Xmax=c*(N+1), normalized_coefficients_per_character=30))
    check(f"example Xmax c={c}", c*(N+1) < Xcap)

out = dict(scope="exact scalar implications only; no spectral or numerical function evidence",
           sigma_min=sigma, rho=rho, primary=primary, comparison=comparison,
           examples=examples, checks=checks, check_count=len(checks))
path = Path(__file__).with_suffix('.json')
path.write_text(json.dumps(encode(out), indent=2)+"\n", encoding="utf-8")
print(f"PASS {len(checks)} exact checks; primary analytic norm <2^-69; optional complete norm <2^-68.")
