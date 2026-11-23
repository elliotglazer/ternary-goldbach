# Complete scalar budget for an eight-center EM batching pilot

2026-11-11. Parameters coordinated with moebius_route and integration. This is a bounded scalar design, not a numerical run or a certificate of function values. Exact arithmetic verifies a full quotient-error allowance below `2^-44<2^-40` and an added coefficient/arithmetic allowance below `2^-60`. All finite input and arithmetic inequalities below remain obligations for the future producer.

## 1. Fixed target and parameters

Use the actual finite EM approximation to `zetaF(s)=(s-1)*zeta(s)` with

```
N=1024, B=N+1=1025, M=16,
K=16 retained Taylor coefficients, degrees 0,...,15,
outer radius R=1, target radius rho=1/16,
J=8 centers, transform length L=32, residual length p=24.
```

The exact centers are

```
c_j=629/1250+i*(31999/16-j/8),   j=0,...,7.
```

Thus `t0=2000-1/16` and `Delta=-1/8`. Each vertical panel has center c_j and half-length 1/16. Consecutive closed panels meet exactly and together cover the line segment with real part .5032 and imaginary part in [1999,2000]. This is an evaluator test on that segment, not a complete rectangle or zero count. Existing evidence through height 2000 supplies no coefficient enclosures to this new computation.

All target points have real part at least 1/2 and norm at most 2002. All radius-one outer disks have real part at least -1/2 and norm at most 2003. Throughout the target segment `|s-1|>=1999>2^10`. At every center, `|c_j-1|+1<2002`, and `|c_j-1|>3rho`.

## 2. Reviewed formula, with new parameters checked explicitly

The general EM identity and finite coefficient rules are those derived in `EM_SOURCE_PROOF_PLAN_2026-11-11.md`, SHA256 `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`, and the reviewed `EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md`. This pilot changes their finite parameters, not their function convention:

```
S(s)=sum_(n=1..1024)n^(-s),
C(s)=B^(-s)/2
    +sum_(k=1..16)[B_(2k)/(2k)!]*(s)_(2k-1)*B^(1-s-2k),
H(s)=B^(1-s),
g(s)=(s-1)*(S(s)+C(s))+H(s).
```

The rising-factorial correction lengths are 1,3,...,31, and the EM remainder uses length 32. Each stored jet coefficient is divided by its factorial exactly once. The finite-g function is entire. Only actual target points use the EM remainder; outer disks use the entire finite-g bound.

Put `A=2034`. Both sqrt(N) and sqrt(B) are less than 33. On an outer disk, all factors in a correction rising factorial have modulus below A. The bound `|B_(2k)|/(2k)!<=4/6^(2k)` and A/B<4 give a total correction multiplier below 4/5. The script independently verifies all sixteen Bernoulli inequalities by exact recurrence. Hence

```
|g(s)| <2004*[1024*33+33*(1/2+4/5)]+1025*33
       =339194823/5 <2^27.                              (O)
```

The actual EM denominator is `sigma+32-1>=63/2`, which is positive. Its bound is

```
E_EM <= [4*2003*33/(63/2)]*[2034/(6*1025)]^32 <2^-38.   (E)
```

This is a new exact rational check for N=1024 and M=16; it is not copied from the million-height M=32 result. The finite-g Taylor remainder from (O), with radius 1 and sixteen retained coefficients, is

```
E_Taylor <=2^27*(1/16)^16/(1-1/16)=2^-33/15.            (T)
```

## 3. Main-sum batching truncation

Use the reviewed frequency-bin construction of `EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md`, corrected SHA256 `44C53A6F71D9B00368568D35C08D2ED69EC9ECA746AE61E2DDC8A79C5BA2C52F`, reviewed by zero_sum at SHA256 `4A7FF42F81E202C7842BEF8A0F294D1CB11F3F9812D91ECC282D39DCE32B0126`.

That support note states positive Delta, but its bin proof extends unchanged to this signed Delta. Define `x_n=L*Delta*log(n)/(2*pi)` and choose an integer q_n by rounding a certified rational midpoint within 1/8 of x_n. Negative q_n are allowed. Then

```
r_n=J*(Delta*log(n)-2*pi*q_n/L),   |r_n|<55/56<1.
```

The moments are `n^(-c_0)*(-log n)^h/h!*(-i*r_n)^m/m!`, grouped by `q_n mod L`. A normalized positive DFT is read at `-j mod L`, multiplied by L, and contracted with `(j/J)^m`. This recovers the Taylor approximation of the exact factor `exp(-i*(j/J)*r_n)` at the exact desired center; no time-grid rounding is introduced.

The real-phase integral Taylor bound gives residual at most 1/24!. Here `sum n^(-sigma)<64` and `log(N)<7`, so for all h=0,...,15,

```
W_h=sum n^(-sigma)*(log n)^h/h! <64*7^h/h! <2^14.
```

For log(N)<7, an exact certificate is `(27/10)^7>1025` and `exp(1)>65/24>27/10`. The script checks every weight bound. Therefore each main jet's batching truncation is below `2^14/24!`. After forming retained g coefficients, the bound is at most `2002*2^14/24!<2^25/24!<2^-54` per coefficient.

A separate weighted check gives `sum_h rho^h W_h<128`, using `sum n^(-7/16)<(16/9)N^(9/16)<128`. Thus the batching-only quotient error is also below `2^8/24!<2^-70`. The complete ledger below uses the full coefficient enclosure, so this latter batching tail is not added a second time.

## 4. Complete finite-arithmetic acceptance contract

All radii in this paragraph are Euclidean norm radii. If an implementation stores coordinate boxes, it must convert their errors to these norm budgets before applying the formulas.

For each of the 16*24*32 moment entries, require a certified radius at most `2^-110` for the actual exact bucket sum. This includes baseline exponentials, logarithms, residuals, factorials and moment accumulation. For each normalized positive DFT output, separately require arithmetic error at most `2^-110` relative to the exact transform of the serialized bucket centers. The normalized DFT has infinity-norm operator bound 1, so the combined output radius is at most `2^-109`.

The factor L and all 24 terms are retained in the readout. Allow at most `2^-100` for the final residual-polynomial contraction arithmetic per main jet, including any numerical powers of j/J. Consequently

```
main-jet arithmetic <=32*24*2^-109+2^-100
                    =(5/2)*2^-100 <2^-98.               (A1)
```

The dyadic j/J permits exact rational contraction, but that optimization is not assumed in (A1).

For h=0,...,15 let C_h and H_h denote the exact normalized coefficients at c_j of the functions in section 2. Define the full correction block

```
R_h=(c_j-1)*C_h+C_(h-1)+H_h,   C_-1=0.
```

Require a certified error at most `2^-80` for this full R_h block. It includes the half term, all sixteen Bernoulli corrections, the B-dependent exponential phases, rising-factorial coefficients, products, and the entire H term. It is not a bound on C_h alone before multiplying by c_j-1.

Finally allow at most `2^-80` for assembling the main and correction blocks and rounding the output midpoint to an exact dyadic complex number. The resulting midpoint error relative to the actual normalized coefficient of finite g is less than

```
2^25/24! +2002*2^-98+2*2^-80 <2^-53.                    (A2)
```

Serialize every full-g coefficient as a square with that dyadic midpoint and coordinate halfwidth exactly `2^-52`. The error (A2) proves containment with room. No claim is made that an arbitrary fixed working precision meets the contracts. Under this pilot's fixed-attempt, no-retuning limits, the producer must reject if any required radius is unproved; this note does not authorize refinement beyond those limits.

An independent direct finite-g replay can validate all 128 coefficients by proving its own boxes are fully contained in the serialized output squares. Mere overlap does not prove the coefficient claim. The direct replay itself still needs sound elementary/series enclosures; its numerical library is not a Lean proof operation.

## 5. Whole-panel quotient ledger

The coefficient squares enclose all batching truncation and finite coefficient errors once. On the actual vertical panels, `z=i*y` with real `|y|<=1/16`. Every power of z is a real multiple of a quarter-turn, which preserves a coordinate square. Their polynomial-error square therefore has coordinate radius at most

```
2^-52*sum_(h=0..15)rho^h <=(16/15)*2^-52.
```

For arbitrary complex `|z|<=1/16`, the same coordinate-radius claim is not asserted: multiplication can rotate a square. Instead the norm triangle inequality gives Euclidean error at most `sqrt(2)*(16/15)*2^-52`, so the final norm budget below also remains valid on that disk whenever its other domain bounds hold.

Add the analytic EM and Taylor allowances as coordinate-square padding. A square of coordinate halfwidth e has Euclidean radius at most `sqrt(2)e<(3/2)e`. Dividing the whole expression by the actual s-1 box is valid because `|s-1|>2^10`. Reserve an additional Euclidean allowance `2^-64` for any remaining polynomial evaluation and quotient arithmetic. Exact rational interval operations could make this allowance unnecessary, but are not required.

The complete norm error allowance is therefore

```
(3/2)*[2^-38+2^-33/15+(16/15)*2^-52]/2^10+2^-64
 <2^-44<2^-40.                                         (F)
```

The part added by the coefficient squares and final arithmetic alone is

```
(3/2)*(16/15)*2^-52/2^10+2^-64 <2^-60.                 (F1)
```

These are scalar error budgets, not bounds on the width of a panel's true image. Natural interval variation across a panel is retained in its polynomial and denominator images. Dependency overestimation may prevent a nonvanishing test even when (F) is satisfied. The producer must report its actual complete enclosures; this note asserts no half-plane margin or sign.

## 6. Work and storage boundaries

The batch has 393216 moment contributions, 384 length-32 normalized transforms, 30720 radix-two butterflies, and 3072 output contraction terms. Dense moment storage has 12288 complex entries, or 768 if one jet order is processed at a time. It returns 128 full-g coefficient squares. The independent direct check has 8192 main-sum term occurrences and 131072 main coefficient contributions. The correction construction has 128 correction polynomials and 248 affine rising-factorial updates.

For this deliberately small case the batched moment count exceeds the naive separate-center coefficient count. The purpose is to test the identity, signs, normalization, enclosure propagation and serialization, not to demonstrate a speed advantage. Elementary primitive costs, interval refinement, input preparation, and proof records are not included in these counts. No runtime forecast follows.

The exact standard-library checker `em_small_batch_budget_20261111.py` and its JSON receipt verify the geometry, all sixteen Bernoulli bounds, weight/factorial inequalities, the three arithmetic contracts, and the complete quotient ledger. They evaluate no transcendental function, model, or FFT. This scalar packet does not authorize a numerical run or establish the finite records that a future run must provide.
