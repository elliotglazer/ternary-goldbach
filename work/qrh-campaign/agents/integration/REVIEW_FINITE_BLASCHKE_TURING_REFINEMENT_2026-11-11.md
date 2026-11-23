# Independent review of the finite-Blaschke Turing refinement

2026-11-11. PASS at paper/source scope, with no correction requested. This review binds `independent-feasibility/FINITE_BLASCHKE_TURING_REFINEMENT_2026-11-11.md`, SHA256 `D9B3A7F28CA6EE49F203ECF1092F61E1FFD0DE79B017F0499A205EF2AD4A45DC`. I independently reconstructed the continuum factor estimate and its composition with the actual L-function bounds. An independent standard-library checker passed 39 exact hash, rational and polynomial checks. No producer script was imported, no analytic function value or zero was computed, and no Lean source or frozen artifact was changed.

The resulting statement is

    |integral_(t1)^(t2) S_chi(t) dt|
        < 10 + (9/8) log(Q*t2/(2*pi)),   50<t1<t2,

for the same canonical S of primitive nonprincipal characters of conductor Q>1 used by the accepted assembly. It is a new paper proof, not a formal theorem or a successful spectral certificate. Its local lower-bound proof needs neither a Hadamard product nor a zero-resolvent identity. The general analytic and counting interfaces inherited from the accepted assembly remain necessary.

## Actual disk and factorization

I reread `TernaryGoldbach/Explicit/LGrowth.lean:156–199`, including `norm_LFunction_le:179`. It bounds the actual continued L-function by `(Q+1)|s|/Re(s)` for a nonprincipal character and Re(s)>0. There is no finite-RH hypothesis. With c=5/4 and R=6/5, the whole closed disk has Re(s)>=1/20. Its norm is at most t+49/20. For Q>=2 and t>50 the uniform bound is strictly below `(3147/100)Qt<32Qt=M`. Thus the new disk remains in the theorem's domain; the saving does not come from applying a growth estimate across Re(s)=0.

The Euler product on Re(s)=5/4 bounds the center below by `zeta(5/2)/zeta(5/4)>1/5`. Each omitted prime factor improves the lower bound. The strict decreasing-integral comparison gives `zeta(5/4)<5`. Consequently the center is nonzero, the function is not identically zero, and `0<=U=log(M/|f(0)|)<Z+7`. The checker's rational exponential witness verifies the last constant independently.

Removing all zeros in the closed radius-11/10 disk is legitimate without discovering their positions. Analyticity and the nonzero center give a finite multiset of zeros with finite positive orders. Division by all corresponding linear factors has removable values. Multiplying by `R^2-conj(alpha)w` introduces zeros only outside radius R. The resulting g is analytic near the closed outer disk and nonzero near the closed inner disk. In particular, inner-circle zeros are removed; outer-circle zeros do not invalidate maximum modulus. All sums here are finite with their actual orders.

On the outer circle the Blaschke factors have norm one. Maximum modulus bounds g by M, and `h=log M-log|g|` is nonnegative and harmonic near the closed inner disk. The exact center identity is

    U = h(0) + sum_alpha log(R/|alpha|).

There is no separate zero-count estimate and no assumption that the listed zeros are simple. The uniform strict outer growth bound also gives h(0)>0. This justifies the strict inequality in the author's displayed integrated Harnack line; the weaker `integral h<=2h(0)` would already suffice.

## Independent continuum factor estimate

The squared-norm identity is

    |R^2+x*conj(alpha)|^2 - R^2|x+alpha|^2
      = (R^2-x^2)(R^2-|alpha|^2).

I expanded this as a polynomial in the four independent variables R, x, Re(alpha), Im(alpha). The exact checker finds zero residual coefficients. Since both right-hand factors are positive for the present segment and zero locations, the resulting Green function decreases with `|x+alpha|`. At a fixed a=|alpha| its maximum is therefore at alpha=-a. This is a pointwise identity and monotonicity argument, not a sampled extremum assertion.

For `0<a<=l=3/4`, dropping the numerator correction gives

    L(a) <= l log R + l - a log a - (l-a)log(l-a).

The entropy term has derivative `log((l-a)/a)` and negative second derivative in the interior. Its maximum is at a=l/2. Continuous extension of `u log u` handles the endpoint a=l. Since `log(R/a)>=log(R/l)`, the exact rational logarithmic brackets imply

    L(a)/log(R/a) < 195/56 < 7/2.

For `l<=a<R`, fix `0<x<l`, set u=x/R and v=log(R/a), and write the normalized Green function as `1+F_u(v)/v`, where

    F_u(v)=log(1-u exp(-v))-log(1-u exp(v)).

Both logarithm arguments stay positive for `0<=v<=log(R/l)`, because x<l. Its second derivative is

    u exp(v)/(1-u exp(v))^2 - u exp(-v)/(1-u exp(-v))^2 >= 0.

This follows from the positive derivative `(1+y)/(1-y)^3` of `y/(1-y)^2` on [0,1). Convexity and F_u(0)=0 make F_u(v)/v increasing. Hence the normalized integrand at any a>=l is bounded by its value at a=l. That comparison is integrable: its only endpoint singularity is a constant multiple of `-log(1-x/l)`. Integrating and dropping the nonpositive numerator logarithm gives

    L(a)/log(R/a) <= l[1+1/log(R/l)] < 33/14 < 7/2.

The proof covers the full continuum, including a approaching R. At x=l the comparison may be infinite, but this single endpoint has measure zero. For a zero on the segment the original logarithmic singularity is locally integrable. Finite values assigned by a totalized real logarithm do not change any integral. These arguments prove the claimed `7/2` factor on the full stated range `0<|alpha|<R`.

## Harmonic integral and horizontal composition

I checked the actual Mathlib API `HarmonicOnNhd.circleAverage_poissonKernel_smul`, `Analysis/Complex/Harmonic/Poisson.lean:92–97`. It requires harmonicity on a neighborhood of the closed disk and evaluation inside it, exactly what the construction supplies. Nonnegative boundary values permit the Poisson-kernel upper bound. Integrating `(r+x)/(r-x)` on [0,l] gives

    2r log(r/(r-l))-l = (11/5)log(22/7)-3/4 < 2.

The same center budget therefore controls both parts:

    integral_0^l(log M-log|f(-x)|)dx
      <= 2h(0)+(7/2)sum_alpha log(R/|alpha|)
      <= (7/2)U.

Keeping the positive term `l log M` matters. Since `log M>Z` and `U<Z+7`, the compact lower bound is `-(11/4)Z-49/2`. Adding the inherited Euler-log tail from 5/4, greater than `-148/125`, gives

    I(t)>-6421/250-(11/4)Z > -26-(11/4)Z.

The inherited J(5/4)<148/125 input has reviewed paper/external interval evidence; this review does not upgrade it to a rational Lean certificate. Compact integrability and Euler-tail absolute integrability are both preserved.

The unchanged upper bound is `I(t)<1717/500+(3/4)Z`. Each difference of horizontal integrals is consequently less than `14717/500+(7/2)Z2`. The constant 14717/500 uses the rounded lower intercept 26, so it is deliberately larger than the sum using 6421/250. Exact comparison with pi>157/50 gives the positive margins

    10*(157/50)-14717/500 = 983/500,
    (9/8)*(157/50)-7/2 = 13/400.

The accepted canonical Littlewood identity then proves the claimed absolute allowance. That identity includes exceptional endpoints; no resetting of the Euler logarithm or principal-argument branch is permitted. Both character parities are covered. The count consumer still applies the allowance separately to chi and its inverse, including two contributions for a real character. Conductor one retains its separate normalization.

## What the smaller allowance buys

At Z_H<=18 a valid non-strict replacement is b=121/4. The RH-only count condition remains

    Gamma_2/h = 2-D-2b/h > 0,
    D=(Abar-W)/h-K.

K must count only certified critical-line multiplicity. For h=50 and a future actual D<=1/2, the reserve is exactly 29/100. At this same D upper bound the sufficient width condition is h>121/3, compared with h>5558/25 for the old b=166.74. These are conditional arithmetic thresholds. The actual D depends on h, the sign intervals, their upper endpoints, the canonical phase integral and all enclosures. Neither a favorable D nor strict grid signs are supplied here.

The +1 exact-count condition at h=50,D=1/2 would have reserve -71/100. Thus this example proves neither exact count nor a complete zero list. Principal exact-head and reciprocal-moment consumers cannot use it as exact saturation. The separately reviewed pair-deficit argument supplies finite RH only, with actual critical support and same-character reflection; central lower count zero is allowed under that contract.

On the existing step-5/64 large-branch schedule, h50 adds 640 nodes per conductor instead of h200's 2560. Under an otherwise identical fixed circuit this quarters the incremental transform node count, not the main computation or all end-to-end work. Even h50 goes above the old V10000 range near conductor 10001. New seed arguments, actual magnitudes, output radii, sign projections, interpolation guards, canonical Abar and the successful surplus still need checked evidence. No runtime ratio follows, and no previous packet automatically passes. The newer auxiliary inventory records these costs separately; this review does not independently regenerate that conductor inventory.

## Evidence and remaining implementation boundary

The independent checker uses a different scalar construction from the author: it integrates a finite geometric expansion of `1/(1-t^2)` to enclose the three needed real logarithms by exact rationals. The tail is bounded by replacing `1/(1-t^2)` by `1/(1-z^2)` on [0,z]. It also verifies the full four-variable Green polynomial identity, disk constants, center budget, final pi margins and conditional count thresholds. The continuum convexity, entropy and analytic-factorization arguments are the paper proofs above, not conclusions of finite tests.

| Owned evidence | SHA256 |
|---|---|
| integration/review_finite_blaschke_turing_20261111.py | 5BD1F8E089E91B0BD0134E642785ADA78DFBB8F1D0AD7992381D42CACAAB5EA9 |
| integration/review_finite_blaschke_turing_20261111.json | EE5D1D50E7176CEFBEE62E65485847AD921E18E1A4C71BC91B63785F6151AD0E |

All 12 input pins listed in the checker/receipt match. Besides the frozen author note and its script/receipt, they bind the two actual Lean source files, the prior lower proof/review, the upper proof/review, the J review, the canonical assembly and the pair-deficit review. The key source hashes are LGrowth `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341` and Poisson `9F8B08BA2691E698428516F465B373D2212DAA8509D67EDEA9F4DCCF2473C195`. Paths are resolved explicitly in the receipt. The conditional cost context is `zero-sum/AUXILIARY_FIXED_ORDER_SPECTRAL_INVENTORY_2026-11-11.md`, SHA256 `80DB1F3EF97114F332D4A23A96DFE585E234ACA87D01FC50234B95C1B576F186`, read without executing its producer.

Formal work still includes actual Euler-product bounds, finite analytic-order factor removal, harmonic log and maximum modulus, the new integrated Green lemma, real integral identities, the J acceptance bridge, canonical Littlewood and the completed-L closed-count adapters. The new allowance is available at the same paper scope as the earlier elementary assembly. It requires no unresolved Hadamard/resolvent premise, but does not make those formal or finite-data obligations disappear. No final root assumption changes.
