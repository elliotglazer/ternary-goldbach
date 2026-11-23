# A smaller elementary Turing allowance from finite Blaschke factors

2026-11-11. New paper derivation, submitted for independent review. For the same actual primitive nonprincipal characters and canonical S as the accepted elementary assembly, this gives

    |integral_(t1)^(t2) S_chi(t) dt| < 10 + (9/8) log(Q*t2/(2*pi)),
    Q>1, 50<t1<t2.

At log(Q*t2/(2*pi))<18 the allowance is less than 121/4=30.25 per character. The old elementary allowance was 166.74 at that logarithmic cap. This refinement uses the same actual-L growth theorem, Euler center/tail estimates, finite zero factorization, maximum modulus, Poisson formula and canonical Littlewood identity. It uses no completed-function Hadamard product, zero resolvent, RH, zero list or simplicity assumption. No analytic values or spectral data were evaluated, and no Lean declaration or build was made. The new scalar lemma below still needs formal implementation.

## 1. Changed geometry and center budget

Let chi be nonprincipal of natural modulus Q>=2, and t>50. Set

    c=5/4, l=3/4, R=6/5, r=11/10,
    f(w)=L(c+it+w,chi), M=32Qt.

Thus 0<l<r<R<c, and the segment w=-x for 0<=x<=l represents sigma in[1/2,5/4]. On the closed outer disk Re(c+it+w)>=1/20 and |c+it+w|<=t+49/20. The actual source theorem `Explicit/LGrowth.norm_LFunction_le` therefore gives

    |f(w)| <= (Q+1)|c+it+w|/Re(c+it+w)
           <= 30Q(t+49/20) < 31.47Qt < M.

Here Q+1<=3Q/2. This is the existing nonprincipal positive-half-plane theorem, with no finite-RH premise. Nonprincipal L is entire.

The absolutely convergent Euler product at c=5/4 gives

    |f(0)| >= zeta(5/2)/zeta(5/4) > 1/5,

because zeta(5/2)>1 and zeta(5/4)<1+integral_1^infinity u^(-5/4)du=5. Factors omitted at primes dividing Q improve this inequality. In particular the center is not a zero. Put

    Z=log(Qt/(2*pi)), U=log(M/|f(0)|).

Then 0<=U<log(160Qt)=Z+log(320*pi)<Z+7. For the last inequality use pi<22/7, exp(1)>27/10 and the exact comparison (27/10)^7>320*(22/7). Also Z>0 and log M=Z+log(64*pi)>Z.

## 2. Preserve each zero's center weight

Remove every zero alpha in the closed inner disk |alpha|<=r, repeated by its actual positive analytic order. This is a finite multiset: f is analytic, not identically zero and defined on a neighborhood of a larger closed disk. All its alpha are nonzero. Define

    B_alpha(w)=R(w-alpha)/(R^2-conj(alpha)w),
    g(w)=f(w)/product_alpha B_alpha(w).

Exactly as in the reviewed finite-factor argument, local analytic factorization removes the apparent poles with their full orders. The extra numerator zeros of g lie outside the outer disk. Thus g is analytic on a neighborhood of the closed outer disk and nonzero on a neighborhood of the closed inner disk. This includes zeros exactly on its radius r. Zeros on the radius R need not be removed and cause no difficulty for maximum modulus.

On |w|=R each B has norm one, hence |g|<=M inside by maximum modulus. The real function h=log M-log|g| is nonnegative and harmonic on a neighborhood of the closed inner disk. At its center the exact joint budget is

    U = h(0) + sum_alpha log(R/|alpha|).                 (1)

The old proof replaced each logarithm by one common lower bound and paid a constant for each zero. The new proof retains every logarithm in (1). It does not require any estimate for the number of zeros.

## 3. Integrated harmonic bound

The radius-r Poisson formula gives, for 0<=x<=l<r,

    h(-x) <= (r+x)/(r-x) h(0).

Integrating the kernel bound rather than taking its maximum yields

    integral_0^l h(-x) dx
      <= [2r log(r/(r-l))-l] h(0)
       = [(11/5)log(22/7)-3/4] h(0) < 2h(0).          (2)

The scalar log(22/7)<5/4 follows from a positive rational Taylor lower bound for exp(5/4). Nonnegative boundary values and harmonicity on a neighborhood of the closed r disk meet the same source Poisson API as before. No boundary value of h at a zero is used.

## 4. The integrated factor lemma

For every complex alpha with 0<|alpha|<R, the new elementary estimate is

    integral_0^l -log|B_alpha(-x)| dx
        <= (7/2) log(R/|alpha|), R=6/5, l=3/4.        (3)

Finite assignments at a possible isolated logarithmic singularity do not affect the integral. All following comparisons are understood almost everywhere at such a point. The usual local logarithmic integrability supplies each integral.

Write a=|alpha|. Expanding squared norms gives the disk Green-function identity

    -log|B_alpha(-x)|
      = (1/2)log(1 + ((R^2-x^2)(R^2-a^2))
                         /(R^2*|x+alpha|^2)).          (4)

Both factors in the numerator are positive. Since |x+alpha|>=|x-a|, the maximum at fixed a is attained at alpha=-a. Thus it suffices to bound

    L(a)=integral_0^l log((R^2-a*x)/(R*|x-a|)) dx.

For 0<a<=l, the numerator is at most R^2. The exact logarithmic integral and the two-term entropy bound give

    L(a) <= l log R + l-a log a-(l-a)log(l-a)
         <= l[1+log(2R/l)].                            (5)

Here the continuous extension 0 log0=0 handles a=l. The entropy maximum is at a=l/2: differentiation gives log((l-a)/a), with strictly negative second derivative in the interior. Since log(R/a)>=log(R/l), (5) gives

    L(a)/log(R/a)
       <= (3/4)[1+log(16/5)]/log(8/5)
        < (3/4)(1+7/6)/(7/15)=195/56<7/2.            (6)

The rational exponential witnesses below prove log(16/5)<7/6 and log(8/5)>7/15. This bound includes zeros on the horizontal segment and at its left endpoint.

For l<=a<R, fix 0<x<l and put u=x/R and v=log(R/a). Then 0<v<=v0=log(R/l)<log(1/u). The normalized radial integrand equals

    1 + F_u(v)/v,
    F_u(v)=log(1-u exp(-v))-log(1-u exp(v)).

On this interval F_u(0)=0 and

    F_u''(v) = u exp(v)/(1-u exp(v))^2
                  -u exp(-v)/(1-u exp(-v))^2 >= 0.

Indeed y/(1-y)^2 is increasing on[0,1), with derivative (1+y)/(1-y)^3. Convexity and F_u(0)=0 imply F_u(v)/v<=F_u(v0)/v0. Consequently the normalized radial integrand for a>=l is at most that for a=l, pointwise for 0<x<l. This establishes the monotonicity used here on the entire continuum; it is not a sampled optimization.

Integrating, and then discarding the nonpositive numerator logarithm, gives

    L(a)/log(R/a) <= L(l)/log(R/l),
    L(l)=l log(R/l)+integral_0^l log(1-l*x/R^2)dx
                          -integral_0^l log(1-x/l)dx
         <= l log(R/l)+l.

The last logarithmic integral is exactly -l. Therefore

    L(a)/log(R/a) <= l[1+1/log(R/l)]
                    < (3/4)(1+15/7)=33/14<7/2.       (7)

The endpoint x=l has measure zero and its comparison function is integrable. Equations (4), (6) and (7) prove (3). There is no zero-free disk assumption in this scalar lemma. In its application alpha ranges only up to r<R, but the stronger stated range avoids a radius-dependent count penalty.

## 5. Lower horizontal integral and Turing composition

Finite factorization gives almost everywhere

    log M-log|f(-x)| = h(-x)+sum_alpha -log|B_alpha(-x)|.

Using (1)-(3), nonnegativity of h(0), and 2<=7/2,

    integral_0^l (log M-log|f(-x)|) dx <= (7/2)U.

It follows that

    integral_(1/2)^(5/4) log|L(sigma+it)| d sigma
       >= (3/4)log M-(7/2)U
        > -(11/4)Z-49/2.

Retain the accepted Euler-log tail bound from 5/4:

    integral_(5/4)^infinity log|L(sigma+it)| d sigma
       >= -J(5/4)>-148/125.

Thus the full, well-defined horizontal integral satisfies

    I(t)>-6421/250-(11/4)Z > -26-(11/4)Z.              (8)

The finite factors prove compact integrability, and the Euler-log majorant proves absolute integrability of the tail. No height is excluded because a zero lies on the horizontal path.

The accepted upper estimate is I(t)<1717/500+(3/4)Z. For 50<t1<t2, put Zj=log(Qtj/(2*pi)). Then 0<Z1<Z2. The two differences are bounded respectively by

    I(t2)-I(t1) < 14717/500+(3/4)Z2+(11/4)Z1,
    I(t1)-I(t2) < 14717/500+(3/4)Z1+(11/4)Z2.

Both are less than or equal to 14717/500+(7/2)Z2. The accepted canonical identity pi*integral S=I(t2)-I(t1), including exceptional endpoints, now implies the stated allowance since

    10*(157/50)>14717/500,
    (9/8)*(157/50)>7/2, pi>157/50.

No branch of S is reset or changed. Primitivity is needed by the existing count consumer; the lower horizontal proof itself works for every nonprincipal character. Conductor one remains outside this nonprincipal packet.

## 6. Conditional count use and limits

Under the original-height log cap Z_H<18, use b=121/4 for each of chi and its inverse. The two-channel upper count still contains 2b. For the independently reviewed RH-only gate, h=50 and a future certified D=(Abar-W)/h-K<=1/2 would give

    2-D-2b/h >= 29/100 > 0.

This is a conditional example. No actual D, sign interval, central count, interpolation guard or seed-domain extension is supplied. Changing h changes the required main integral and weights. Exact-count/list/head-moment consumers retain their stronger acceptance. In particular the new paper bound does not reclassify an old numerical receipt as passing.

The refinement adds a finite-factor scalar integral lemma and better scalar geometry to the already accepted local route. General analytic factorization, harmonic logarithms, maximum modulus, the actual Euler estimates, the J integral certificate, canonical Littlewood identity and closed count adapter remain formal tasks. It removes none of their costs. The result gives no measured or guaranteed computational saving. No lower claim about the best possible local constant is made.

## 7. Exact evidence and source pins

The owned `finite_blaschke_turing_scalars_20261111.py` ran 21 rational checks. A degree-n positive Taylor sum bounds exp(q) below; adding the first omitted term divided by 1-q/(n+2) bounds it above. All later term ratios are at most q/(n+2). Degree12 witnesses prove the three logarithmic comparisons in (2), (6) and (7), and degree5 at q=1 proves exp(1)>27/10. No logarithm, exponential, L-value or zero evaluator is called. These scalar checks supplement, rather than replace, the continuum arguments above.

| New artifact | SHA256 |
|---|---|
| finite_blaschke_turing_scalars_20261111.py | 46188842B33F488DCEFFBED46A39D3C5AE11DDC25BFB7A63D966243FD30CACF3 |
| finite_blaschke_turing_scalars_20261111.json | 80CCFFC89B3C0131CFFECB13E21324B9DC3C2484CB0F4D78659B173498619A23 |

Agent paths below start at `work/qrh-campaign/agents`. The root upper note is under `work/qrh-blueprint/turing-scalars`. Actual source was read at `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean:179` and Mathlib `Analysis/Complex/Harmonic/Poisson.lean:92` in the local z-in-q Mathlib checkout.

| Source or inherited proof input | SHA256 |
|---|---|
| Explicit/LGrowth.lean | 5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341 |
| Mathlib Analysis/Complex/Harmonic/Poisson.lean | 9F8B08BA2691E698428516F465B373D2212DAA8509D67EDEA9F4DCCF2473C195 |
| audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md | A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9 |
| integration/REVIEW_TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md | B4CAE7485D7BB6655D207BEB2E1716A904F637E36753C48EF5D15FD1A6B41992 |
| Root ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md | 0875B2B87A02421B7B8CD6CAD0D1C33433A051E240F48EA4C5F45FE04558BD27 |
| integration/REVIEW_ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md | 696E6E8B9C73D3AE3593F2D5C1386E4B386048DA046915CD976C0A43425D7E94 |
| integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md | 262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2 |
| integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md | 72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C |
| independent-feasibility/REVIEW_FINITE_RH_PAIR_DEFICIT_2026-11-11.md | 97645AB7A3A9EC3B807DD4BFDD022175455A0F1DEF46F676141E6C587164C7E5 |

The assembly's ledger pins the separately reviewed canonical Littlewood proof and endpoint adapter. This report reuses those exact conventions and only changes the lower horizontal estimate. Old files and theorem assumptions are unchanged; independent review of this new derivation is pending.
