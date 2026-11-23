# Independent review of the conditional moderate Turing allowance

2026-11-11. PASS for the stated conditional paper implication, with no mathematical correction requested. This binds `major-constants/TURING_MODERATE_ALLOWANCE_PROOF_PATH_2026-11-11.md`, SHA256 `A480D72440F4A5D2C2BF539EB6D3C152428772060A7BFAF35582BCCDB525707D`. The finite-resolvent assertion (F) is a premise of this bounded implication, not an accepted final theorem assumption. Its new producer is being reviewed separately. This review does not certify that producer or a numerical Turing packet.

I independently reconstructed the unpaired zero-ratio estimate, differentiated Binet bounds, Euler derivative bound, shift normalization and finite approximation limit. A separate standard-library checker passed 39 exact scalar/hash checks. There were no analytic values, zero scans, builds, Lean edits or frozen-file changes.

The author's opening statement that 166.74 is the current usable allowance is historical. The subsequently reviewed finite-Blaschke route already gives b=30.25 at Z<=18. This review compares the proposed b18 implication with that newer accepted paper proof.

## The scalar zero-ratio bound

For a in [1/2,3/2] and y real, the two log norms defining J are interval integrable. At y=0 there is at most one logarithmic singularity; finite values assigned at that point do not affect the integral. The squared-norm difference is 4au, so the integrand is nonnegative almost everywhere. Its expression as `log(1+4au/((a-u)^2+y^2))/2` shows that increasing y^2 decreases it.

Direct integration on the real axis gives

    F(a)=(a+1)log(a+1)+(a-1)log|a-1|-2a log a.

It is continuous at a=1. On each side its derivative is `log|1-1/a^2|`. This is positive up to a=1/sqrt(2) and negative thereafter, including throughout a>1. Substitution using `(sqrt(2)-1)(sqrt(2)+1)=1` gives maximum `2log(1+sqrt(2))<2`. The last strict bound follows from sqrt(2)<3/2 and exp(1)>=5/2, without logarithm evaluation.

Writing r2=a^2+y^2, the case r2<=2a gives J<2<=4a/r2. In the complementary case,

    y^2>r2(1-a/2)>=r2/4>0.

The inequality log(1+v)<=v then gives `J<=integral_0^1 2au/y^2 du=a/y^2<=4a/r2`. This case has no singularity. The equality r2=2a belongs to the first case, so the split is exhaustive. Negative y introduces no new condition. The substitution a=3/2-Re(rho), y=t-Im(rho) has the correct sign: the completed-function ratio integrated from 1/2 to 3/2 contributes -J for each zero.

This independently agrees with the frozen unpaired-ratio note D315AE5C and its review B42C9706. No zero pairing or separation is needed for the coefficient 4. True positive multiplicities and the critical-strip location remain essential when it is applied to actual zeros.

## Differentiated normalized Binet input

I read the accepted normalized Binet construction in `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md`, section 2, and the periodic-P2 conversion in `prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md`, sections 1–2. Their log Gamma is analytic on Re(z)>0, real on positive reals and normalized at 1. It is not the pointwise principal logarithm of Gamma. The real additive normalization constant disappears under differentiation.

For the actual remainder

    R(z)=1/(12z)-(1/2) integral_0^infinity P2bar(v)/(z+v)^2 dv,

differentiation gives `R'(z)=-1/(12z^2)+integral P2bar(v)/(z+v)^3 dv`. On a compact subset of Re(z)>0, the function and derivative have integrable majorants proportional to `(sigma0+v)^-2` and `(sigma0+v)^-3`. Thus differentiating under the integral is justified locally, not by a formal manipulation of a conditionally convergent expression.

For z=sigma+iy, sigma>0,y>0, split at v=y. The norm integral is at most `y*y^-3+integral_y^infinity v^-3 dv=3/(2y^2)`. Since |P2bar|<=1/6,

    |R'(z)|<=1/(12y^2)+(1/6)*3/(2y^2)=1/(3y^2).

The derivative of the main Binet expression is `Log z-1/(2z)`. For 1/4<=sigma<=7/4, y>25, its real part differs from log y by at most

    1/(2y)+49/(32y^2)+1/(3y^2)
      <1/50+49/20000+1/1875<1/20.

The compact Gamma ratio uses arguments `(sigma+a+u+it)/2`, with sigma in [1/2,3/2], parity a in {0,1} and u in [0,1]. These fill exactly a subset of the claimed real-part interval [1/4,7/4], with y=t/2>25. Integration over a half-unit Gamma shift multiplies the 1/20 error by 1/2; integration over sigma has length one. The resulting compact-ratio error is 1/40. At s*=3/2+it, taking half the real digamma gives the same 1/40 error. No t-dependent branch adjustment or missing factor of two occurs.

## Euler derivative and the two tails

Actual source `Explicit/ExplicitFormula.lean:726–764` defines C3 as the convergent von Mangoldt series and proves `norm_logDeriv_L_right:739`, bounding |L'/L| at 3/2+it by C3. The body uses the twisted von Mangoldt series with the correct minus sign and |chi(n)|<=1. It has no RH hypothesis.

The additional C3<5/2 argument is sound. Absolute convergence and differentiated Euler/Dirichlet identities identify C3 with `sum_(n>=1) log(n)n^-3/2 / sum_(n>=1)n^-3/2`. The denominator is strictly greater than the integral 2. The numerator's real function is nonnegative and unimodal, its integral is 4 and its maximum is 2/(3e)<1, so the sum is less than 5.

There is also a short way to make the sum-integral step precise here. The positive integrated-geometric expansion gives log 2>2/3, hence `log(x)x^-3/2` decreases for x>=2. Leave its n=2 term below 1, note its n=1 term is zero, and bound every n>=3 term by the integral on [n-1,n]. The resulting upper bound is less than 1+4. This avoids any ambiguity about rounding the location of the maximum. Differentiated series convergence and the Euler identity remain ordinary formalization obligations; a numerical C3 value is not being imported.

The unit-shift decomposition has two Euler terms: the compact interval [3/2,5/2] and the full tail [3/2,infinity). Each is bounded below by -J(3/2), which is greater than -J(5/4)>-148/125. The loss 296/125 is therefore valid. The positive log-zeta(2sigma) contribution may safely be discarded. The inherited J certificate remains at its reviewed paper/external interval scope, not newly kernel checked here.

## What (F) must supply, and its exact consumption

Fix the actual primitive nonprincipal completed function f with conductor factor `(c/pi)^(s/2)` and parity Gamma factor. It must be entire, nonzero as a function, and have only actual nontrivial zeros in the open critical strip. These are completed-function source adapters, not consequences of C3. For every compact disk K centered at 1/2 and every epsilon>0, (F) supplies one finite set of actual zeros with their exact orders, containing every zero in K, such that the real logarithmic derivative differs from the finite real resolvent by at most epsilon uniformly at nonzero points of K. A list of apparent roots or lower bounds on their orders would not meet this condition.

Choose K with the whole shifted segment in its interior and divide f by that finite polynomial. Local factorization makes the quotient g analytic and nonzero near the segment, including any central or horizontal zeros that were removed. The residual bound extends through the removed zeros by continuity. Along every unit horizontal segment it implies

    log|g(s)|-log|g(s+1)|>=-epsilon.

After integration and the finite scalar J bound, the result is at least `-4*sum resolvent-epsilon`. Applying (F) at s* bounds the sum above by `Re(f'/f)(s*)+epsilon`, yielding exactly `-4Re(f'/f)(s*)-5epsilon`. The finite set may depend on epsilon and K. The actual ratio integral and logarithmic derivative do not, so letting epsilon decrease to zero proves the required inequality. There is no infinite zero-sum/integral interchange, and no assumed nonvanishing at the central point.

At s* the completion logarithmic derivative has real part at most

    Z_t/2 + 1/40 + 5/2 = Z_t/2+101/40.

Converting the completed ratio back to the L ratio contributes `+(1/2)log(c/pi)` and the positive-direction Gamma shift. Combined, their main term is +Z_t/2, with error -1/40. This produces

    I(t)>Z_t/2-1/40-4(Z_t/2+101/40)-296/125
         =-(3/2)Z_t-12493/1000.

Together with the unchanged upper bound, both horizontal differences are less than `15927/1000+(9/4)Z_top`. Canonical Littlewood, with the already fixed Euler-log continuation and exceptional-endpoint convention, gives the claimed allowance. At Z_top<=18 its numerator is 56427/1000. The strict rational slack below `18*(157/50)` is 93/1000. At Z_top<=20 the analogous b20 slack is 1873/1000. Both parities and both character channels retain the same normalization.

## Source reuse and formalization burden

I inspected the actual interfaces at `XiPartial.lean:776–831`, `Datum.lean:18–55,699–715`, and `ZeroSums.lean:17–69`, alongside the C3 proof. The existing `xi_partial_approx` is a zeta-xi theorem. Its quantifier order and finite zero carrier are useful, but it does not itself instantiate (F) for general characters. The existing `ldatum_L` uses BT; the polynomial BP bound needed for logarithmic rather than linear height growth is a different source theorem. Neither a theorem name nor the displayed asymptotic notation closes that change.

The proposed general-character proof needs polynomial-growth good heights, actual completion and reflection identities, nonvanishing contour boundaries, a two-basepoint finite residue formula, compact-uniform vanishing error and exact analytic-order transport. Reflection for a nonreal character is `s -> 1-conj(s)` at the same character. It is not holomorphic symmetry `f(1-s)=f(s)`. Anchoring factorization at 2 avoids a central-nonvanishing premise. These requirements match the stated (F) boundary. This review leaves their separate producer and independent review untouched.

Compared with the accepted b30.25 finite-Blaschke route, b18 adds that global finite-resolvent construction and the present coarse digamma/Euler estimates. Some normalized Gamma work is already needed by the count phase, so it should not be charged twice; differentiation and its quantitative bounds are still additional proofs. Both routes retain canonical Littlewood, the actual closed-count interface, J acceptance and finite arithmetic/sign evidence. The conditional b9 paragraph also needs its separately stated paired zero inequality; it is not proved by this review. No development or verification time is inferred from the size of these descriptions.

For measured D<=1/2, b18 needs h>24; h25 gives RH-only reserve 3/50. The accepted b30.25 needs h>121/3 at that same D bound; h50 gives reserve 29/100. The candidate h25 schedule would add 320 step-5/64 nodes per conductor instead of 640 for h50, but D changes with h and is not guaranteed to satisfy either bound. Neither example proves exact count. New seed ranges, projections, interpolation guards and strict count evidence remain required. Thus this proof can lower a conditional auxiliary bill; it does not establish an end-to-end speedup or supersede b30.25 until (F) is separately supplied and accepted.

## Frozen evidence

| Owned artifact | SHA256 |
|---|---|
| integration/review_moderate_turing_scalars_20261111.py | 94CA0FE59EAD53260F3774A55C3E7C14791E8BD4A372E10E094A49ED5B2B5316 |
| integration/review_moderate_turing_scalars_20261111.json | DF420D1AC4AB341A58E5385CC3E803B5A5AF57AE075AB4449E340B1A0650D49F |

The receipt verifies 13 exact source/report pins, including the author, unpaired lemma/review, both normalized Binet inputs, accepted assembly/J review, b30.25 review and four actual source files. It records 39 total checks. The source file hashes are XiPartial `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770`, Datum `42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE`, ZeroSums `3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D`, and ExplicitFormula `8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35`. The complete resolved paths are in the receipt.

The rational tests check constants and algebra; the continuum and limit arguments are reconstructed above. This is a conditional source/paper acceptance only. No new axiom, final root premise, numerical success or kernel-validity claim is introduced.
