# Independent review of the downstream global-totient tail

Research review, 2026-11-10. Reviewer: zero-sum worker. No Lean compiler was run and no source was changed.

**Verdict: the downstream envelope and its complete numerical error bound pass the mathematical/source audit, conditional on the unchanged pointwise theorem and a finite exact totient theorem through B = 2^1000. This does not discharge all global totient dependencies of the pointwise theorem.** The author has now explicitly recorded this restriction in the tail note and in `TYPEII_TOTIENT.md`.

Reviewed artifacts under `agents/independent-feasibility`:

- `GLOBAL_TOTIENT_TAIL.md`, SHA256 `E2A499640BBDB727038BE784F1D3812172AE197A887E6D4835294923C7527574`.
- `global_totient_tail_check.ps1`, SHA256 `C143F5844B75A9605776E938E857A4B39B1BAAF81CE0277C97C3415B73D102F6`.
- The accompanying `GLOBAL_TOTIENT_ROUTE.md` and `TYPEII_TOTIENT.md` for scope and prerequisites.

Source references below are relative to the pinned `work/ternary-goldbach/TernaryGoldbach` tree. The source commit is `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

## 1. First-branch replacement

`MinorArcs/GBound.lean` defines Fr, Lg and gx and invokes the sharp totient bound in `norm_S_eta2_le_gx`. Its source proof establishes q <= r and 2r <= z^(1/3)/3, where r = max(1,|delta|/8)q. The replacement uses exactly those inequalities, with no assumption that q or r is bounded uniformly over convolution scales.

For q > B, the elementary product estimate q/phi(q) <= sqrt(2q) <= sqrt(2r) is valid: for every odd prime p, p/(p-1) <= sqrt(p), the prime 2 costs the extra sqrt(2), and rad(q) <= q. Write t = 2r and L = log t. The logarithm in R has denominator at least 2 log(27/2.004) > 4. Together with log(4t) <= 2 log t and log(1+u) <= u, this gives R(z,t) <= .135625 L + .41415 <= L.

The source first-branch expression, divided by z, is therefore at most 3.8 z^(-1/6) plus

    (L^2+.8764)t^(-1/4)
      +(6.5L+18.166)t^(-1/2)
      +(27.32L+75.1)t^(-1).

The coefficients match the source: the Lg/r term introduces a factor 2/t, and 18.166 = 15.64 + 2.526. Since t,L >= 1, the three terms are bounded by (2+25.5+103.32)L^2 t^(-1/4) < 132L^2 t^(-1/4). This is H(r) when q>B. The remaining source gx terms are algebraically nonnegative on this domain, without using the sharp totient theorem. For q<=B, the proposed finite theorem must allow arbitrary comparison radius r>=max(3,q); a theorem restricting r<=B would not suffice.

## 2. Scaling and convolution

For H(r) = 132 log^2(2 max(r,B))/(2 max(r,B))^(1/4), H is continuous at B, constant below it, and decreasing above it. The derivative sign above B is log(2r)(2-log(2r)/4). Also rH(r) is increasing, with derivative sign (3/4)log^2(2r)+2log(2r) above B. Consequently H(wn)<=H(n)/w for 0<w<=1, and the required correction is H(n) for w>=1.

This is the exact scale comparison used by `MinorArcs/LinftyLevels.lean:196` (`gx_scale_le`). `Prop1123b.lean:105` chooses a fresh approximation at z=wy and proves min(1,w)n <= r_w. Its first branch can use gx+H and its second branch remains unchanged, conditional on the pointwise theorem. Thus the added majorant is H(n) max(1,1/w).

`LinftyLevels.lean:358` integrates over all w>=670/n, using `integral_max_inv_phi_le` at line 406. Hence the addition is at most 1.398H(n). The small-w term 17(670/n)^3/3 is unchanged. There is no omitted large-w tail, and no assumption of bounded fresh denominators. Retaining the positive plateau even for small n is necessary for this argument.

The mixed family in `Thm1321.lean` has base level at scale x and higher levels at scale x/49. Raising g preserves its required monotonicity and nonnegative terminal value. The base-gap bound remains a separate obligation; nothing in this tail construction proves it. An existing bound by the old g at the base also implies the raised bound.

## 3. Exact discrete weights and terminal term

`MinorArcs/MinorTotal.lean:78` defines the exact expression with initial coefficient cL(150000)*sig/Dx-8.6294, middle coefficient log((n+1)/n)*sig/Dx on the open integer interval, and terminal coefficient sig-cL(r2-1)*sig/Dx. The note's difference formula matches every coefficient and endpoint. In particular, it does not replace the terminal coefficient by another middle weight or omit the initial subtraction.

The source definitions at lines 70-75 and `LargeSievePrimes.lean:33` give

    sig=(.640208+366.91/sqrt(x))log(x)-.021095,
    Dx=.5log(x)-log(14)+1.33258,
    cL(n)=log(2(n+1))+2.

For x>=4.9e26, 0<=sig<=log x, 0<=sig/Dx<=3 and cL(150000)<15. These generous estimates also hold with .65 replacing .640208. They do not assert that the .65 numerical replay is completed. Dropping the negative initial subtraction and bounding the terminal coefficient by sig are valid upper bounds, whether or not the initial coefficient is positive.

For each middle integer n,

    H(n) log((n+1)/n) <= H(n)/n
      <= integral_(n-1)^n H(t)/t dt.

The intervals cover only part of [150000,infinity), so extension to the full positive integral is valid. Writing L=log(2B), C=132(2B)^(-1/4), direct integration gives

    integral_150000^infinity H(t)/t dt
      =C[L^2 log(B/150000)+4L^2+32L+128]
      <=C[L^3+4L^2+32L+128].

The terminal estimate uses the actual source witnesses, not merely the abstract existence of a NumericsGoal witness. `NumericsFinal.lean` partitions the finite range through x=4.9e101; there log x<235. For the remaining range, `NumericsAsymp.lean:385-402` chooses m=floor((x/49)^(1/4)) and proves m>=(x/49)^(1/4)/2. Therefore log x<4+4log(2m). For m>=B the derivative of H(m)(4log(2m)+4) has sign -u^3+11u^2+8u, negative for u=log(2m)>=12. The cases m<=B and m>=B both yield C L^2(4L+4). This controls all x, including the range where the terminal index crosses B. Bounding H(m) alone by a constant would not have done so.

Combining the initial, middle, and terminal estimates produces exactly

    DeltaM <=1.398 C [7L^3+61L^2+96L+384].

All coefficients are positive, so L<701 and 1.398*132<185 give the stated bound. No change to the mixed-family weights or their geometric meaning is needed.

## 4. Arithmetic verification and consumer

I ran the author's script successfully. It reported 303 primes through 2000 and verified their product exceeds 2^1000 by integer arithmetic. This is a finite certificate ingredient, not yet a Lean proof of the finite totient theorem.

I independently checked the polynomial and final rational normalization:

    7*701^3+61*701^2+96*701+384 = 2441347848,
    numerator = 185*2441347848 = 451649351880,
    numerator*10^60 < 2^250.

Thus the correction is <1e-60; the displayed floating diagnostic is approximately 2.496332755606299e-64. The latter is not used as a certificate.

`MinorTotal.lean:368-379,515-525` uses the uniform 22.75 bound and small-coefficient energy 8e-11. With t=1/2000 and the inflated M=1.037001, the exact final value is

    (1+1/2000)*(1037001/1000000)
      +(1+2000)*(91/4)*(8/10^11)
      =1.03752314232 <1.0376.

Accordingly an existing or recomputed certificate M<=1.037 leaves sufficient room. One must adapt the consumer to the raised envelope and bound; applying the unchanged NumericsGoal theorem directly to a redefined g would be incorrect. The note correctly leaves the algebraic g and numerical cells unchanged.

## 5. Upstream dependencies: the essential scope restriction

The downstream result alone does not remove all uses of `Prelim.div_totient_lt`.

| Source call | Actual bound needed | Unbounded range remaining |
|---|---|---|
| `FirstChoiceTypeII.lean:153` | q/phi(q)<=7.2539 sqrt(T/6e6), 1<=q<=T | Elementary repair below removes this particular call, conditional on finite Fr. |
| `SecondTypeIIa.lean:172` | q/phi(q)<=1.7882 loglog(q)+.9549, q>=1e6 | Reapproximation denominator q' can exceed B. |
| `SecondTypeIIb.lean:216` | q/phi(q)<=a1F0(log T), q<=T/6 | q' can exceed B as T grows. |
| `SecondBridge.lean:58` | q/phi(q)<=1.948 loglog(T)+1, q<=T/6 | Same issue. |

`SecondFinal.lean:72-73` reapproximates with Q2(T)=T^2/349. Its case split includes q'>T/6 and two branches q'<=T/6. Thus finite Fr covers every internal denominator when T<=2^500, and also any particular q'<=B at arbitrary T, but not the full scale range. If q'>B, the only general lower scale bound from this approximation is T>sqrt(349B). The present H correction does not account for a changed second-choice theorem at those scales.

The first-choice repair in `TYPEII_TOTIENT.md` is valid. For p>=5,

    (p-1)^4-p^3=p^3(p-5)+6p^2-4p+1>=0.

The exceptional normalized factors at p=2,3 are 8 and 27/16. Therefore (q/phi(q))^4 <=(27/2)rad(q)<=16q, and q/phi(q)<=2q^(1/4). For q<=B apply finite Fr at comparison radius T. For q>B, T>B>10^12 gives

    2q^(1/4)<=2T^(1/4)<=.002sqrt(T)
      <=7.2539sqrt(T/6e6),

the last inequality following from .002^2*6e6=24<7.2539^2. This is exactly the source hF needed by `typeII_rest_le`; no change to its later constants is required.

The power estimate does not imply the three remaining logarithmic helper statements for unbounded q'. Those must be proved by another argument or their consumers re-estimated before claiming global totient removal. Nor does this audit remove unrelated prime, Mobius, energy, major-arc, or base-gap inputs.

## Status

No mathematical defect found in the scoped downstream tail, scaling, all-x integration, or final error allowance. First-choice internal totient repair also passes on paper. The finite theorem and all analytic adaptations remain to be formalized; second-choice unbounded totient uses remain separate open work. No declaration was compiled or certified axiom-free in this review.
