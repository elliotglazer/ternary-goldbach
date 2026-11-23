# The totient inequality in Zinoviev's Lemma 2.1, Case 2

For every integer `q ≥ 3991`, φ(q) > 14.1√q. This corrects the cutoff `q > 2330` recorded in `LeanLab/Zinoviev1997/Arith.lean`. The local Lean source attributes this inequality to page 348. I could access the [authors' outline](https://www.maths.tcd.ie/EMIS/journals/ERA-AMS/1997-01-015/1997-01-015.tex.html) and the [journal metadata](https://doi.org/10.1006/jnth.1997.2141). The publisher denied access to the full PDF during this check.

If q has at most five distinct prime factors, the product formula gives φ(q)/q ≥ (1−1/2)(1−1/3)(1−1/5)(1−1/7)(1−1/11) = 16/77. This suffices for q ≥ 4700. With six or more factors, each prime power pᵃ contributes p^((a−1)/2)(p−1)/√p to φ(q)/√q. The base factor increases with p, so the first six factors contribute at least φ(30030)/√30030 = 5760/√30030 > 33. Every further prime is at least 17 and contributes more than one.

Exact integer enumeration of the remaining interval gives the following 33 failures, each with 100φ(q)² ≤ 19881q.

```
2340 2352 2370 2394 2400 2430 2436 2460 2478 2490 2520
2550 2580 2610 2640 2670 2700 2730 2760 2772 2790 2820
2850 2940 2970 3060 3120 3150 3300 3360 3570 3780 3990
```

The following Python independently reproduces the finite calculation from the definition of the totient.

```python
from math import gcd

for q in range(2331, 4700):
    phi = sum(gcd(a, q) == 1 for a in range(1, q + 1))
    if 100 * phi**2 <= 19881 * q:
        print(q, phi)
```

With Q = floor(1.1 log² N), q > Q forces q ≥ 3991 once N ≥ exp(√(3990 / 1.1)), approximately 1.433 × 10²⁶. The original totient factor then gives log N / φ(q) < 1/(14.1√1.1) < 0.068. This restores the identified arithmetic step at that cutoff. At 10²⁰ all but the listed moduli satisfy the same inequality. The worst-case envelope √(q/1.1)/φ(q) exceeds 0.08 only at 2340, 2520, and 2730. A constant of 0.08 need not suffice for the full minor-arc estimate. The printed argument may contain further terms. No revised minor-arc estimate, all-n theorem, or Lean build follows from this calculation alone.
## A proposed repair at the original cutoff

The header of `Zinoviev1997/Arith.lean` (lines 19–25) records an earlier reader's account of the alternatives in (2.9). It says the larger error occurs only where 2πN|z| > 10. In that range |x| > 10/N, improving the principal-term estimate 1/(φ(q)|x|) by a factor of ten. For 2πN|z| ≤ 10 the reader reports a combined upper bound of about 0.171 N/log N. These are source comments. The module proves the numerical counterexamples but contains no proof of this repair.

Write L = log N. For q > floor(1.1 L²) one has L < √(q/1.1). The largest possible √(q/1.1)/φ(q) among the exceptional moduli occurs at 2730 and is less than 0.08649. At q = 2340 and 2520 the bounds are 0.080074 and 0.083097 respectively. Thus a sufficient uniform repair is a bound of 0.09351 N/L for the sum of all nonprincipal errors in the near regime and 0.17135 N/L in the far regime. Indeed 0.09351 + 0.08649 = 0.18 and 0.17135 + 0.008649 < 0.18. Establishing those error bounds for the precise smoothing, sign, and arc domains requires the original (2.9) or an independent proof. The candidate argument from the header could preserve the original cutoff for every exceptional modulus. It does not need a surviving factor 1/√q in the character sum.
