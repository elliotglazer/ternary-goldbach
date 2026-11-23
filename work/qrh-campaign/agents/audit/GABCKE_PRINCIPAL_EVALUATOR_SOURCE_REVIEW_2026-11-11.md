# Gabcke principal evaluator: independent source review

2026-11-11. Verdict: **PASS for source transcription and the bounded evaluator plan.** This is not a proof of Gabcke's analytic theorem in Lean, an independently reconstructed proof of every lemma in the thesis, or a completed high-strip certificate. The high principal strip remains open. No Lean, high-zero scan, dependency edit, or frozen-package edit was performed.

## Pinned sources and inspection

Primary source: Wolfgang Gabcke, corrected electronic edition of the 1979 thesis, <https://d-nb.info/1072293277/34>. Local `agents/mellin/gabcke_1979_corrected_2015.pdf` SHA256:

`A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`.

I read the extracted primary text and visually checked equation 3.26 (printed p53), Satz 3.2.2(a) (p55, domain introduced p54), Satz 4.2.3(d) (p72), and Table III (p98). Rendered p53/p55/p72 images are retained beside this review. PDF page numbers are printed page plus eight when counted from one.

The reviewed production plan is `agents/mellin/PRINCIPAL_HIGH_STRIP_PRODUCTION_PLAN_2026-11-11.md`, SHA256 `D7D2A6ABB55D319A87B3C6167483B647DF1C4E031BF4F1DD36535DF919CC3BE2`; its scalar script is `principal_high_strip_plan_sizes_20261111.py`, SHA256 `568CE7583FE2D31A7C028B8C0011BAE406CA7E93581EAA317CA41FA5FCAE1B7C`. I read and reran that print-only script, redirecting output to this audit directory. It passed; no author artifacts were rewritten.

## Exact theorem and normalization

The source's phase is the imaginary part of the analytic log-Gamma at `1/4+it/2`, minus `(t/2) log pi`, normalized by continuation from the positive real axis. Its Hardy function is `Z(t)=exp(i theta(t))*zeta(1/2+it)`. The logarithm here is not the pointwise principal argument of the complex number Gamma. The source's contour identity establishes the real-valued Hardy normalization. Transport to Mathlib's existing real `hardyZ` remains a formal obligation; its existing continuity and zero-equivalence API does not by itself supply this phase formula.

For positive t, put `a=sqrt(t/(2*pi))`, `N=floor a`, and `z=1-2(a-N)`. Equation 3.26 states

```
Z(t) = 2 sum_{n=1}^N cos(theta(t)-t log n)/sqrt n
       + (-1)^(N-1)/sqrt a * sum_{k=0}^K C_k(z)/a^k + R_K(t).
```

For real `t>=200` and integers `0<=K<=10`, part (a) gives, in particular,

```
|R_0(t)| < .47*t^(-3/4)
|R_1(t)| < .43*t^(-5/4)
|R_4(t)| < 2.12*t^(-11/4).
```

All signs, powers, and domains in the production plan match. K is the last included correction index: K0 includes C0 and K4 includes C0 through C4. These are errors in Z itself; applying an additional `1/sqrt a` to the error would be wrong. The selected bounds are part (a), not the stronger part (b) relying on coefficient power-series investigations.

The floor is the greatest integer at most a. At integer a, N=a and z=1. The limiting preceding branch has z approaching -1. Gabcke explicitly discusses jumps of the finite approximation and remainder at such cutoffs. The theorem is valid at the cutoffs; continuity of the finite approximation must not be asserted. IVT uses continuity of actual Z. A point checker must certify the floor or cover all possible branches with their valid domains.

## Coefficients and removable points

Writing `F(z)=cos(pi*(z*z+3/4)/2)/cos(pi*z)`, Table III gives exactly:

```
C0 = F
C1 = F'''/(12*pi^2)
C2 = F^(6)/(288*pi^4) + F''/(16*pi^2)
C3 = F^(9)/(10368*pi^6) + F^(5)/(120*pi^4) + F'/(32*pi^2)
C4 = F^(12)/(497664*pi^8) + 11*F^(8)/(23040*pi^6)
     + 19*F^(4)/(1536*pi^4) + F/(128*pi^2).
```

These are derivatives, not Taylor coefficients. Factorials must be restored when using series arithmetic. On the relevant closed range [-1,1], the quotient's apparent poles are at +/-1/2, both removable with value 1/2; the endpoints +/-1 are ordinary points. Direct cancellation gives

```
F(1/2+u) = (1+u)/2 * sinc(pi*u*(1+u)/2)/sinc(pi*u).
```

The plan's formula is correct. F is even, so odd derivative signs change under reflection. For `|u|<=1/4`, the denominator exceeds 7/8 by the sine-series bound. Intervals containing a removable point require this analytic continuation, not division by an interval containing zero. A certified derivative jet also needs a derivative or analytic series-tail bound; merely bounding the value remainder of a truncated series is insufficient for C1 or C4. The plan retains this obligation.

## Phase substitution and exact scalar replay

Satz 4.2.3(d) gives, for `t>=10`,

```
theta = (t/2)*log(t/(2*pi))-t/2-pi/8
        +1/(48*t)+7/(5760*t^3)+31/(80640*t^5)+Rtheta,
|Rtheta| < 1/(3322*t^7).
```

It is an approximation to the actual normalized phase. It includes the phase corrections; substituting theta0 alone with this same remainder is invalid. On [1500,10^6], N<=398 and `2 sum n^(-1/2)<=4 sqrt N-2<80`. The cosine Lipschitz bound therefore gives the plan's additional error `80/(3322*t^7)`, below `1.5e-24` at the lower endpoint. The real correction polynomial is theta-independent.

An independent exact Fraction script, `gabcke_coarse_constants_review_20261111.py`, reduces the selected constants from the source's stated C_n supremum bounds and its R10 bound. It uses Machin/alternating-series rational pi bounds and exact root comparisons, with no floating acceptance decisions. If r bounds `(2*pi)^(1/4)` above and s bounds `sqrt(200)` below, the coefficient of `t^(-(2K+3)/4)` is at most

```
r^(2K+3) * sum_{n=K+1}^10 c_n*(r*r/s)^(n-K-1)
  +25966/s^(10-K).
```

Using `r=1583234/10^6` and `s=14142135/10^6` gives upper bounds approximately .466379323, .421935377, and 2.116566843 for K0, K1, and K4, strictly below .47, .43, and 2.12. Thus these advertised coarse constants do not need the decimal power-series coefficient tables. This computation is conditional on the analytic coefficient bounds and R10 theorem, not a replacement for their proofs.

Script SHA256 `E8FC84566BF4D22C541EC582A6015A559E35A05597426BE9102C3B6A9F043371`; output JSON SHA256 `C9443CC768C2B853438D4E6E153C023DDA392357643863459D4B4AC5F90BC1EE`. The output labels its analytic proof limitation explicitly.

## What was checked in the derivation, and what remains

I traced the proof of 3.2.2 on pp55–57: the S remainder and Gamma-factor remainder give a `1.41e9*tau^11` error; the Taylor/Cauchy truncation contributes below `1.1e8*tau^11`; their combined `1.52e9*tau^11`, with `tau=1/(2*sqrt(2*t))`, yields R10 below `25966*t^(-23/4)`. Lower orders follow by adding omitted C_n terms and freezing their decreasing factors at t=200. The latter reduction was independently replayed above.

This trace still relies on substantive source theorems: 3.1.5, 4.2.4(b), 4.4.4(b), and 2.3.4(a), together with the RS contour derivation and Gamma identities. In particular, 2.3.4(a) derives its bounds from 2.3.1 and the rational/integer d coefficients in Table II. Avoiding the decimal coefficient expansions does not eliminate these analytic or finite arithmetic obligations. I did not independently reconstruct all of those source proofs. No kernel theorem or manifest-bound Lean declaration has been validated here.

## Production-plan joins

The accepted external counts 1069 and 1747146 leave 1746077 positive-height zeros counted with multiplicity. A chain of 1746078 ordered nonzero samples spanning [1500,10^6] with strict alternating actual-Z signs supplies that many distinct zeros. Equality with the independent total count removes every additional off-line zero and every multiplicity excess. Endpoint nonvanishing and actual count transport are essential. Counts alone do not give location, and an incomplete sign search does not refute the allowed wider strip. The plan makes these distinctions.

The proposed direct-exclusion rectangle has bottom `[.5032,2]+1500*i`. Its nonvanishing follows from the accepted low critical-line location through the closed height 1500, plus the ordinary zero-free right-half-plane statement; it must not be inferred merely from N(1500)=1069. The reviewed head boundary data provide another compatible route. The top comes from the separately reviewed explicit-EM count boundary. No direct-exclusion certificate for the new left edge is supplied by this plan.

The scalar geometry checks pass, including 3994000 quarter blocks, 1746077 new changes, maximum main-sum length 398, and the stated conditional storage/work totals. They are workload counts, not measured runtimes or evidence that an eighth-unit grid succeeds. Gabcke's critical-line formula does not validate the earlier off-line Cauchy/RS evaluator.

**Final status:** source/evaluator-plan acceptance supports the authorized bounded point prototype. Actual high-strip coverage, the full sign chain, all analytic theorem formalizations, interval-checker soundness, and kernel replay remain uncompleted. This review introduces no new root premise and does not change either frozen blueprint package.
