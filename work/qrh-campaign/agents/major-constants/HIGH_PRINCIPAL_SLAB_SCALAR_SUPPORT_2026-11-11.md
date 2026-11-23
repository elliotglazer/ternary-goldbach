# Independent scalar support for a short principal slab at one million

2026-11-11. PASS for the scalar bounds and exact geometry specified below. This check evaluates no zeta, L-function, xi, theta, coefficient model, or panel margin. It does not establish nonvanishing of the proposed slab. It is independent support for the forthcoming moebius-route design, not an acceptance of unproduced data.

## 1. Confirmed expression and conventions

The author confirmed `R=1` as the outer Taylor radius; a message reading “R1.7 new models” meant “R1; seven new models.” There is no radius 1.7. Let

```
T=1000000, N=333334=ceil(T/3), B=N+1=333335,
M=32, K=24, A=T+66=1000066.
```

The actual finite entire function is

```
D(s)=sum_(n=1..N) n^(-s) + B^(-s)/2
     +sum_(k=1..32) [B_(2k)/(2k)!]*(s)_(2k-1)*B^(1-s-2k),
g(s)=(s-1)D(s)+B^(1-s).
```

Here `(s)_r=product_(j=0..r-1)(s+j)`. The corrections retain lengths 1,3,...,63. The omitted EM remainder has rising-factorial length 64. The models retain coefficients `g^(j)(s0)/j!` for j=0,...,23, so K=24 is the first omitted Taylor index, not the polynomial degree.

This agrees term for term with the inspected `zero-sum/em_top_horizontal_20261111.py:10,28-60`, SHA256 `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10`, and with the independently reviewed `EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md`. The source actual function is `zetaF(s)=(s-1)*zeta(s)`, with its removable value 1 at s=1. The slab is far from s=1, so the final normalized function there is exactly zeta after division by s-1.

## 2. Regions and model count

The proposed closed rectangle is

```
[629/1250,2] + i*[T-1/8,T].
```

Its left endpoint is exactly .5032. There are six new bottom models with real centers `5/8,7/8,9/8,11/8,13/8,15/8` and imaginary part `T-1/8`; each has target radius 1/8 and outer radius 1. Their consecutive closed quarter blocks cover `[1/2,2]`, then the first block is clipped to `[629/1250,3/4]`. The six accepted top models at ordinate T have the same real centers and clipping. No new coefficients are implied by reuse; actual stored top enclosures must be carried through unchanged or re-enclosed soundly.

One new left-side model has center `629/1250+i*(T-1/16)` and target radius 1/16. It covers the complete left side including both corners. The right side uses the separate analytic `Re(zeta(2+it))>1/4` fact. Thus there are seven new and six reused models. All actual target points have real part at least 1/2, norm at most T+2, and `|s-1|>2^19`.

Every radius-one outer disk has real part at least -1/2 and norm at most T+3. These disks need only the entire finite-g bound. The EM theorem is not applied on the outer disks.

## 3. Entire finite-g outer bound

Both `sqrt(N)` and `sqrt(B)` are less than 578. On any outer disk, the main finite sum has norm at most `N*578`, the half term at most `578/2`, and the final pole-removal term at most `B*578`.

For the correction terms, `|(s)_(2k-1)|<=A^(2k-1)` because their last shift is at most 62. The reviewed Bernoulli bound gives `|B_(2k)|/(2k)!<=4/6^(2k)`. The companion script also checks every one of these 32 rational Bernoulli inequalities directly from the Bernoulli recurrence. Since A/B<4, the correction multiplier is bounded by

```
sum_(k=1..32) [4/6^(2k)]*(A/B)^(2k-1)
 <sum_(k>=1)(4/9)^k=4/5.
```

Therefore, using `|s-1|<=T+4`,

```
|g(s)| < (T+4)*[N*578+578*(1/2+4/5)] + B*578
       = 963343833694218/5
       < 2^48.                                           (O)
```

All comparisons here are rational except the elementary square-root implications, whose squared inequalities are checked exactly.

## 4. Actual EM remainder and Taylor remainder

At actual target points sigma>=1/2 and `|s|<=T+2`. The accepted EM formula supplies

```
|zetaF(s)-g(s)|
 <=4*|s-1|*|(s)_64|*B^(1-sigma-64)
                  /[6^64*(sigma+64-1)]
 <=[4*(T+3)*578/(127/2)]*[A/(6B)]^64.
```

The last shift is 63, so each rising-factorial factor is less than A. Exactly `A/(6B)<501/1000`, and rational powering verifies

```
E_EM < [4*(T+3)*578/(127/2)]*(501/1000)^64 <2^-38.        (E)
```

The ordinary Cauchy estimate for finite g on its radius-one disk, retaining indices 0,...,23, gives for target radius at most 1/8

```
E_Taylor <=2^48*(1/8)^24/(1-1/8)=2^-21/7.               (C)
```

The left vertical model has the smaller radius 1/16, so (C) still bounds it. The estimate concerns the Taylor tail of finite g. It is separate from (E); adding both is necessary.

## 5. Division and rectangular error insertion

For all points on this rectangle, `|s-1|>=|Im(s)|>=T-1/8>2^19`. Thus the norm of the analytic discrepancy after division by s-1 is less than

```
(2^-38+2^-21/7)/2^19 <2^-42.
```

The old producer inserts its analytic allowance as the square `[-E,E]+i[-E,E]`, not as a Euclidean disk. Every element of that square has norm at most `sqrt(2)*E<(3/2)*E`. Even allowing this square's whole radius, exact arithmetic proves

```
(3/2)*(2^-38+2^-21/7)/2^19 <2^-42.                      (Q)
```

Consequently the claimed analytic quotient allowance survives this convention. Division must still be performed soundly using the whole actual s-1 box. Coefficient enclosure errors, polynomial-evaluation rounding, re-import widening, and numerical division errors are not included in (Q); they remain in their own interval calculations. No conclusion about a total produced image radius or positive real part follows from this scalar check.

## 6. Bounded workload counts and remaining evidence

Seven new models require 168 retained coefficients; six reused top models contribute 144, giving 312 retained coefficients across all 13 models. The seven main sums contain exactly 2333338 summand occurrences. Computing all 24 entries of each main-sum exponential contributes 56000112 coefficient summand entries before any n=1 simplification or reuse. There are 224 correction polynomials and 441 affine rising-factorial updates in the straightforward seven-model construction.

These are algebraic counts. They do not count every multiplication, elementary-series term, interval refinement, serialization step, or proof operation, and imply no timing estimate. Shared log constants or previously computed data require their own valid reuse contract. There is no full-slab computation in this check.

To obtain an actual certificate, the author must produce all seven new coefficient enclosures, preserve the accepted top enclosures, evaluate the complete closed side images with the full analytic error and arithmetic propagation, and prove the intended strict half-plane comparisons. Exact geometric coverage does not prove those comparisons. If every boundary panel lies in the same right half-plane, the already reviewed polygon/argument-principle machinery can then give winding zero with shared surrogate vertices, subject to its existing carrier and analytic hypotheses. No such successful finite packet is claimed here.

The independent standard-library checker is `check_high_slab_scalars_20261111.py`; its receipt is the same basename with `.json`. It uses exact `Fraction`, integer powers, and the Bernoulli recurrence. It imports no evaluator or numerical special-function library, and does not run the existing top-path producer.
