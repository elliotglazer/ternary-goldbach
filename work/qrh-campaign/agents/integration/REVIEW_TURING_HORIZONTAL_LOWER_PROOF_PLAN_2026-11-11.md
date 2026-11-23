# Independent review of the local horizontal lower bound

2026-11-11. Verdict: PASS as a reconstructed paper proof of the local lower bound and its conditional integrated-S consequence. No substantive correction is requested. The final frozen argument has coefficient 21, improving the preliminary coefficient 32 through the joint center budget. This review accepts the final version only.

The conclusions are

```
I_chi(t) > -127.184-21*Z(t) > -128-21*Z(t),
Z(t)=log(Q*t/(2*pi)), Q>1, t>50,
```

for the actual nonprincipal L-function, and, conditional on the convention-correct Littlewood identity and the separately reviewed upper bound,

```
abs(integral_(t1)^(t2) S_chi) < 42+6.93*Z(t2), 50<t1<t2.
```

The review proves no Lean theorem and accepts no finite spectral packet. No build, zero scan, dependency change, producer edit, or frozen-package edit occurred. The only computation was a reviewer-owned exact rational scalar check.

## Pins and source scope

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md` | `A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9` |
| `audit/turing_horizontal_lower_scalars_20261111.py` | `5FD8CC03CA21BE2028A6A68B6CB4021C71F13CEE49A802533E7FC95B16FCDECB` |
| `audit/turing_horizontal_lower_scalars_20261111.json` | `26E1E25DCC53F6D303622FD196CFE2422846559814C49A7CFABA1CFD07DC0B51` |
| `integration/review_turing_horizontal_lower_scalars_20261111.py` | `8AD8A8CAF1840CD3B5AB60D8915F50443612E850475309656F4D72D89EDD32E4` |
| `integration/review_turing_horizontal_lower_scalars_20261111.json` | `0061E51AC415652A638AD81745919BFBB036BB457EDDE51ACF25A3AF7E625477` |

The independent script ran with exit 0 and checks all producer hashes before and after its calculation. It does not run the producer script or alter its receipt. It derives the geometry, the joint coefficient, both difference signs, and rational rounding margins independently. It also checks exp(6)>96*pi using a direct degree-8 Taylor lower sum, in addition to checking the author's exp(1) route. These scalar checks do not prove complex analysis.

The actual source growth theorem was read in full during the immediately preceding upper-bound review. `TernaryGoldbach/Explicit/LGrowth.lean:179` at target `23b2d68ca344203d4384e0aff7affa4ec034bef9` has file SHA256 `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341`. Its binders are `[NeZero Q]`, an actual complex Dirichlet character chi, chi!=1, and Re(s)>0. It has no Platt hypothesis. The proof uses periodic character sums, an integral, and analytic continuation to the positive half-plane. This is source inspection, not a fresh compile or transitive axiom audit.

The companion upper-bound review is `integration/REVIEW_ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md`, SHA256 `696E6E8B9C73D3AE3593F2D5C1386E4B386048DA046915CD976C0A43425D7E94`. The accepted J supplement review is `integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md`, SHA256 `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2`. Their formal obligations remain dependencies.

This verdict concerns the new local derivation. The historical Hadamard/Gamma/Booker discussion is context, not a set of analytic results accepted by this review. Its sharp lower bound is unnecessary for the local proof.

## Disk geometry and the center

Set f(w)=L(3/2+it+w,chi), outer radius R=7/5, inner radius r=6/5, and M=16Qt. On the closed outer disk, Re(s)>=1/10 and |s|<=t+29/10. Since Q>=2, the source growth theorem gives

```
|f(w)| <= 15Q(t+29/10) < (1587/100)Qt < M.
```

The compact integration segment sigma in [1/2,3/2] is exactly w in [-1,0], strictly inside the inner disk. Nonprincipal L is entire, so all analytic neighborhoods needed here exist. No Gamma factor or completed function is involved.

At the center, the absolutely convergent Euler product gives

```
|f(0)| >= product_p (1+p^(-3/2))^(-1)
       = zeta(3)/zeta(3/2) > 1/3.
```

The omitted local factors at primes dividing Q improve this lower bound. The identity follows factorwise from 1+x=(1-x^2)/(1-x), with absolutely convergent positive products. The strict estimate uses zeta(3)>1 and zeta(3/2)<3 by decreasing-series integral comparison. A weaker canonical Euler-log estimate would also suffice, but the displayed stronger bound is correct.

Consequently f is not identically zero and its center is not a zero. The quantity U=log(M/|f(0)|) is nonnegative and satisfies

```
U < log(48Qt) = Z+log(96*pi) < Z+6.
```

The independent direct Taylor sum for exp(6) is 1709/5, exceeding 96*(22/7) by 1403/35. The author's alternative inequalities exp(1)>27/10 and (27/10)^6>96*(22/7) also check exactly. Both M>1 and Z>0 hold on the full stated domain.

## All inner zeros, with multiplicity and boundaries

The set of zeros in the closed r disk is finite by local analyticity, nonidentity to zero, isolation of zeros, and compactness. Every analytic order is a finite positive natural number. Repeating each zero by its actual order defines a finite multiset of total cardinality N. No numerical inventory or simplicity assertion is used. The argument does not assume RH or restrict the real part of these zeros beyond the disk geometry.

For each alpha in that multiset, define

```
B_alpha(w)=R*(w-alpha)/(R^2-conj(alpha)*w).
```

Since |alpha|<=r<R, the denominator does not vanish on the closed R disk. Expanding the squared norms verifies |B_alpha(w)|=1 on |w|=R. At w=0, its norm is |alpha|/R, which is nonzero because f(0)!=0.

Dividing f by the finite product removes precisely the listed orders. Local analytic factorization makes g=f/product B analytic at every removed zero. Its newly introduced numerator zeros have modulus R^2/|alpha|>R and cannot reintroduce a zero in the inner disk. Every zero on |alpha|=r is included. Hence g is nonzero throughout the closed inner disk and on some neighborhood of it, by compactness and continuity. Zeros of f on the outer boundary are allowed; they cause no singularity of g.

On |w|=R, |g|=|f|<=M. Maximum modulus therefore gives |g|<=M inside. This argument requires no zero-free outer circle and no separate Jensen formula. The hypotheses are analyticity on a neighborhood of the closed disk and the stated boundary bound, both available here.

## The joint budget and Harnack estimate

The function h=log M-log|g| is nonnegative and harmonic on a neighborhood of the closed inner disk. Harmonicity follows locally from a holomorphic logarithm of a nonvanishing analytic function. A global argument branch is unnecessary.

At the center, the exact factorization yields

```
U = h(0) + sum_alpha log(R/|alpha|).
```

Each summand is at least log(R/r)=log(7/6)>=1/7. The last inequality follows by integrating 1/x on [1,7/6] and bounding it below by 6/7. Thus h(0)+N/7<=U, retaining the relation between the two losses. Counting multiplicities here is essential; using only distinct zeros would not bound the subsequent logarithmic sum.

For |w|<=1, the Poisson kernel on radius r is at most `(r+|w|)/(r-|w|)<=11`. Since the boundary values of h are nonnegative, its integral is at most eleven times their average, which equals h(0). Therefore h(w)<=11h(0).

I read the exact pinned source API `InnerProductSpace.HarmonicOnNhd.circleAverage_poissonKernel_smul` in Mathlib `Analysis/Complex/Harmonic/Poisson.lean:92`. It applies to a real-valued function harmonic on a neighborhood of a closed ball and a point in the corresponding open ball. The proof's |w|<=1<r and the preceding neighborhood conclusion meet these domain requirements. The elementary kernel inequality and averaging argument still need formal implementation. There is no attempted use of Harnack at the radius-r boundary.

## The integrated cost of one factor

For real w in [-1,0], using |alpha|<R gives

```
|R^2-conj(alpha)*w| <= R^2+R,
|B_alpha(w)| >= |w-alpha|/(R+1).
```

The author deliberately uses the coarser denominator ratio R+1=12/5. The stronger direct ratio 79/35 would also work, but is unnecessary. Since 12/5<exp(1), its logarithm is below 1.

Let a=Re(alpha). Away from the possible single point w=a, distance comparison gives `-log|w-alpha|<=-log|w-a|`. At w=a the totalized-real-log comparison need not hold, but that one point has measure zero and is irrelevant to the integral. The positive part of the right side is supported on |w-a|<1 and has whole-line integral 2. Discarding its negative part gives

```
integral_(-1)^0 -log|B_alpha(w)| dw <= log(12/5)+2 < 3.
```

All terms are integrable. If alpha is real and lies in the segment or at an endpoint, the only singular term is a multiple of log|w-a|. If alpha is not real, the numerator has no real zero. The denominator is nonzero on the segment in every case. Assigning finite values at isolated zero points changes no integral.

## Why the coefficient is 21

The factorization identity holds almost everywhere and is a finite sum with multiplicities. Hence

```
integral_(-1)^0 (log M-log|f|)
  <= 11*h(0)+3*N
  <= 21*(h(0)+N/7)
  <= 21*U.
```

The middle inequality has difference 10h(0)>=0; its N coefficients agree exactly. It spends the center bound only once. Bounding h(0) and N separately would give the weaker coefficient 32, which is not the final packet's result. Empty zero multisets cause no problem: the product is one and the same inequalities hold with N=0.

Since the interval length is one and log M>0, the compact integral is at least log M-21U, which is strictly above -21(Z+6). The canonical Euler-log majorant gives an absolutely integrable tail from 3/2 with lower bound -J(3/2). Positivity of log zeta implies J(3/2)<J(5/4)<1.184. The final lower bound is therefore strictly greater than -127.184-21Z. Rounding 127.184 up to 128 leaves slack 102/125.

Compact logarithmic integrability can either be obtained from the preceding finite factorization or from the existing real-meromorphic log-norm integrability API. The tail estimate proves absolute integrability, not just a one-sided estimate of an undefined improper integral. This lower bound needs no exclusion of zero ordinates.

## Conditional integrated-S consequence

Use the separately reviewed upper bound I(t)<3.434+.75Z and the rounded local lower bound. With Z2>=Z1>0, the estimates for the two signs are

```
I(t2)-I(t1) < 131.434+.75*Z2+21*Z1,
I(t1)-I(t2) < 131.434+.75*Z1+21*Z2.
```

Both are at most 131.434+21.75Z2. Their respective slacks are 21(Z2-Z1) and .75(Z2-Z1). Dividing by pi under the canonical Littlewood identity gives the proposed bound because

```
42*(157/50)-131.434 = 223/500 > 0,
(693/100)*(157/50)-21.75 = 51/5000 > 0,
pi > 157/50.
```

These are exact rational comparisons. Littlewood's normalized-log identity, S-integrability, and the a.e./closed-count endpoint adapter remain separate analytic obligations. The local existence of logarithms used for h does not establish any of them.

The completeness test still uses both character channels. Its allowance contribution becomes `2*(42+6.93*Z(T+h))/h`, including for a real character whose channels coincide but are counted twice. This is a new allowance, not the surcharge alone and not permission to reuse a previously passing upper bound. Gamma enclosures, auxiliary sign weights, and strict integer saturation must be recomputed. Larger h requires new evidence over the larger auxiliary interval. No packet success or computational cost follows from this proof.

## Remaining obligations

The local proof removes the specialized completed-product, Gamma-ratio, Booker/Lehman, zeta-derivative, and sharp Euler-integral leaves from this lower-bound route. General complex analysis remains substantial work: actual-L analyticity and Euler estimates; finite analytic orders and removable Blaschke division; maximum modulus and harmonic log norm; quantitative Poisson/Harnack; finite logarithmic integral comparisons; and the accepted J certificate's formal replay. All source adapters and exact exported axiom checks remain open.

This review accepts a complete paper argument for the local lower estimate, not an implementation or an added analytic premise at the Goldbach root. A complete Turing producer still needs Littlewood and the convention-correct count theorem, followed by actual finite evidence that passes the chosen allowance.
