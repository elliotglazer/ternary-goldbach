# Independent review of the simple-phase K0 interval plan

2026-11-11. **PASS as a paper-level finite certificate design and pointwise termination argument.** I found no blocking mathematical, domain, or error-budget defect. No correction to the frozen producer is requested. This verdict does not establish an implemented verified evaluator, a Lean theorem, a successful sign decision, or any new zero data.

The reviewed producer is `prime-estimates/PRINCIPAL_K0_INTERVAL_EVALUATION_PLAN_2026-11-11.md`, SHA256 `E3B6843DA11022ACBC0A7BBAFA5B8C125CF38B88127B69DCB3B8FF6EB90B157A`. Its exact diagnostic script is `principal_k0_interval_scalar_20261111.py`, SHA256 `F14C03BD72F13DC3DB570D9093A8920449D267121F8FD264BA61F2F391390892`; the frozen JSON is `3212347EBE306A61B8496DA3AD31BADB211B9CDD2D2F21A4BDD38FE42C94B328`. All paths here are relative to `work/qrh-campaign/agents/` unless stated otherwise.

I read the complete plan and script, checked the three pins, and replayed the producer's `run()` function read-only, without its file-writing main entry point. Its returned data matched the frozen JSON exactly. The independently constructed arithmetic checks described below are separate from that replay. No original report or receipt was changed, and no Lean/Lake command, dependency installation, full evaluator, or sign scan was run.

## 1. Fixed analytic and elementary contracts

The target is exactly the Khat in `independent-feasibility/PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6`. Its independent composition review is `prime-estimates/REVIEW_PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `A39ED6F31EE45499080BD95357B453F065F0FFEEE78AFDC9B794775460A73633`. That paper proof gives a strict .451*t^(-3/4) analytic error for the actual Mathlib hardyZ, for every real t>=1500, including the floor endpoints.

The numerical plan has the narrower input contract of exact rational t>=1500 and exact rational eps>0. Its arbitrary requested accuracy applies to **Khat**, not to hardyZ. It neither changes the analytic approximant nor asserts that its analytic error can be reduced by increasing arithmetic precision.

I also reread the elementary source plan at pin `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC` and its independent review at pin `4C773E1497C2C6F2D99D0A1F5A060A8029E9CC5EBCD85D5F3265914A13547181`. Their source-backed rational enclosure rules remain paper interfaces awaiting implementation. The new plan correctly uses that boundary: native results may supply candidate witnesses, while exact finite comparisons and proved interpretation lemmas must eventually justify acceptance.

## 2. Removable F and the denominator guard

For w=abs(z) in [0,1], put h=w-1/2. Then

```
A = (pi/2)*h*(w+1/2),        B=pi*h,
cos(pi*(w^2+3/4)/2) = -sin(A),
cos(pi*w) = -sin(B).
```

For w!=1/2, both A and B are nonzero, and sin(B)!=0 because B lies in [-pi/2,pi/2] and is nonzero. Thus the quotient is exactly

```
((w+1/2)/2) * sinc(A)/sinc(B).
```

At w=1/2, A=B=0 and the existing sinc value 1 gives exactly 1/2. Continuity identifies this with the source's removable extension. The original quotient is even off its two singular points and its prescribed values at both are equal, so passing to abs(z) is valid also at z=-1/2. There is no cancellation-sensitive division by h, no near-zero numerical switch, and no claim of differentiability of abs at zero is needed.

The integral identity sinc(x)=integral_0^1 cos(u*x)du follows from an antiderivative when x!=0 and from the constant integrand when x=0. The global cosine lower bound gives sinc(x)>=1-x^2/6. Consequently

```
sinc(B) >= 1-pi^2/24 > 7/12 > 1/2.
```

The strict comparison uses pi<22/7 and (22/7)^2<10. Numerator and denominator arguments respectively satisfy |A|<=3*pi/8<2 and |B|<=pi/2<2. These are closed-domain bounds covering z=0, z=+/-1, and both removable points.

Intersecting an interval for abs(z) with [0,1] preserves containment because exact z already has abs(z)<=1. The resulting interval is nonempty if the preceding enclosure is sound. The actual reciprocal guard is the computed rational lower bound >=1/2, which is strictly positive. The analytic 7/12 bound proves eventual success of refinement; it is not used as permission to invert an unchecked interval containing zero. Optional outward rounding must still respect the sinc input-domain check [-2,2], and sufficiently fine rounding will do so because the true arguments have strict slack below 2.

## 3. Sinc polynomial, tail, and midpoint enclosure

The source `Complex.exp_bound'` has degree n, denominator n!, and ratio condition norm(x)/(n+1)<=1/2. With n=2m, m>=2, and x=i*u*y for u in [0,1], |y|<=2, its ratio is at most 2/5. Taking real parts retains exactly the even powers 0,2,...,2m-2. Integrating their finite sum over u gives

```
S_m(y)=sum_(j<m) (-1)^j*y^(2j)/(2j+1)!.
```

The integrated error is at most

```
2*|y|^(2m)/((2m)!*(2m+1))
 <= 2*2^(2m)/(2m+1)! = E_m.
```

This derivation includes y=0 and does not divide an error bound by y. E_2=4/15, and E_(m+1)/E_m=4/((2m+2)(2m+3))<=2/21, so the stated geometric convergence follows with the correct starting constant.

Integrating the global inequality |cos(u*x)-cos(u*y)|<=u*|x-y| gives the global sinc Lipschitz constant 1/2. Thus an input interval with midpoint c and radius r is enclosed by S_m(c)+[-E_m-r/2,E_m+r/2]. The factor r/2 is correct. The use of a midpoint polynomial plus an explicit input-radius bound avoids an unsupported assumption that interval Horner widths shrink while the degree grows. All polynomial coefficients and all rounding checks are rational. A dyadic output may be wider, but its extra width remains part of the checked output interval.

## 4. Floor certification and rational input termination

If a=sqrt(t/(2*pi)) is an integer k, then k>0 because t>0. Squaring yields pi=t/(2*k^2), contradicting irrationality of pi for rational t. Hence the exact floor N satisfies the two strict inequalities N<a<N+1. No irrationality statement about the computable approximation to pi is involved.

For a sound positive pi interval [pL,pU], the certificate

```
2*pU*N^2 < t < 2*pL*(N+1)^2
```

implies 2*pi*N^2<t<2*pi*(N+1)^2, hence the exact natural floor. The direction of both interval endpoints is correct. The N=0 case would also be logically valid, although the declared threshold implies N>=15.

A finite initial candidate set follows from pi>=3. For example a<=sqrt(t/6)<t+1 at these inputs, so enumerating natural integers up to ceil(t)+1 is already enough; a square-root-based tighter bound is optional. For the true candidate, convergence of the Machin endpoints makes both strict certificate comparisons eventually pass. This is a terminating semidecision search at each permitted rational point, not a test for equality of arbitrary real numbers. No uniform precision bound follows when t can approach an excluded irrational transition height arbitrarily closely.

The squared dyadic-root construction in section 6 is sound. If k^2<=floor(A*2^(2p)/B)<(k+1)^2, integrality of the upper square implies A*2^(2p)/B<(floor value)+1<=(k+1)^2. Thus k/2^p<=sqrt(A/B)<(k+1)/2^p. It handles rational-square and zero arguments as claimed. Lower and upper endpoint constructions extend it to input intervals.

After N is certified, it stays fixed throughout the finite expression. Refining an interval for a until it lies inside (N,N+1) is possible by the same strict separation. An interval of heights crossing a transition is a different input problem; the point contract does not silently assign it one N. The all-real analytic theorem supplies the transition cases separately, without relying on this rational-input algorithm.

## 5. Error allocation, rounding, and the .47 bound

For exact eps>0 and t>=1500,

```
eta=min(eps,19/(1000*t))>0,
eta<=eps,       eta<=.019*t^(-3/4).
```

The latter uses t>=1, so t^(-1)<=t^(-3/4); equivalently the sufficient fourth-power comparison in the script has positive factors and the correct direction. This is a conservative rational budget, with no fractional-power oracle.

There are exactly N+1 full term intervals: N complete main-sum terms, each already including its factor 2 and reciprocal square root, and one complete correction including its sign and reciprocal sqrt(a). If each has width <=2*eta/(N+1), their exact rational sum has width <=2*eta. Its rational midpoint M therefore has |Khat-M|<=eta. Interval correlations can increase widths but cannot invalidate containment.

Every intermediate rounding is included in those intervals. If the final sum is rounded too, the plan correctly rechecks its **final** width; it does not silently spend a second rounding allowance. One may use only the final width test if termwise limits are inconvenient.

Triangle inequality with the strict assembled .451 bound gives

```
|hardyZ(t)-M| < (.451+.019)*t^(-3/4) = .47*t^(-3/4).
```

This conclusion is about the actual function after the paper soundness chain, not about an arbitrary floating result. A rational interval for hardyZ additionally needs a rational upper bound for its analytic radius, as the plan states. Increasing arithmetic precision drives |Khat-M| toward zero, not the fixed analytic remainder. Consequently the procedure can always finish evaluating Khat to eps while its hardyZ interval still contains zero. Successful sign detection, a chain of alternating signs, and completeness require separate proofs and data.

## 6. Whole-circuit termination

The plan supplies the missing distinction between soundness of a witness and existence of a terminating witness search. After the floor phase, the number of nodes is finite. Positive-base logarithms, positive reciprocal square roots, and the sinc denominator all have strict domain margins at the exact point. A sufficiently late refinement stage therefore satisfies their guards.

For cosine at a rational midpoint c, an integer nearest to c/(2*pi) gives a reduced value of absolute value <=pi<4. The candidate bound abs(k)<=ceil(abs(c)/6)+1 is sufficient since 2*pi>6. Refining pi eventually certifies the strict [-4,4] domain even if the exact point is midway between two multiples of 2*pi. The reduction error includes the multiplier 2*abs(k) on pi's uncertainty. Finite factorial tails then give the midpoint cosine to arbitrary rational accuracy; adding the input radius uses its global Lipschitz constant 1.

The sinc midpoint output has explicit radius E_m+r/2 plus recorded rounding. Hence shrinking inputs and increasing degrees do yield shrinking outputs. Root and log interval convergence follow by continuity on their stated domains. Arithmetic convergence follows from the finite field operations with denominators away from zero. Induction on the finite acyclic expression graph therefore makes every full term width smaller than its positive target. Finitely many terms can be brought below their targets at one sufficiently late global stage.

This proves pointwise termination of the proposed mathematical search. It does not bound complexity, memory, numerator growth, the size of the certificate, or Lean checking time. The diagnostic's fixed 128-bit rounding is a finite example only; the general termination argument explicitly increases precision. No claim about unbounded accuracy follows from keeping those 128 bits fixed.

## 7. Source checks and independent exact diagnostics

I inspected the actual pinned Mathlib source signatures at revision `56a005855ea17e0b0958f73ec801ae140b0a1679`:

* `Sinc.lean`: Real.sinc has value 1 at zero, the off-zero division identity, evenness, |sinc|<=1, and continuity.
* `Trigonometric/Bounds.lean:125`: `Real.one_sub_sq_div_two_le_cos` is global, with no small-angle condition. `sin_ge_sub_cube` requires nonnegative input, and the proposed alternative uses evenness for negative inputs. `abs_cos_sub_cos_le` is global in both real arguments.
* `Analysis/Real/Pi/Irrational.lean:282`: the existing global `irrational_pi` supplies exactly the irrationality used for the rational-input floor argument.
* `Analysis/Complex/Exponential.lean:407`: `Complex.exp_bound'` has the degree and ratio condition used above. `Trigonometric/Series.lean` independently confirms the sine/cosine coefficient conventions, though the new integrated-tail proof does not require a separate sinc-series theorem.

Own diagnostic files:

| Artifact | SHA256 |
|---|---|
| `independent-feasibility/review_k0_interval_plan_20261111.py` | `D615374AAA3114609F01849FC9584E7A7AC4B47F8139202BB5BA171F6D3CC3A7` |
| `independent-feasibility/review_k0_interval_plan_20261111.json` | `EC24340A867690BF160CB5FF2F7CC34B3DB019F0B4EBE833DE82DBB2858F1E75` |

The independent run passed **454 exact checks**. It used only integer operations, Fraction arithmetic, factorials and integer square roots. These include both sinc tail-ratio formulations, the uniform denominator and argument-radius comparisons, the .451+.019 allocation, rational tolerance comparisons, and five independently generated Machin floor certificates: t=1500, 2000, 1000000, and rational points just below/above the a=16 transition. The Machin truncation counts used for those floor certificates were 4,4,4,16,8 respectively. The receipt records five source-file hashes and the three producer pins.

The separate read-only producer replay reproduced its six F intervals, three floor tests and eighteen ratio checks. Neither run evaluated Khat or hardyZ or generated a sign. These diagnostics check concrete finite arithmetic and help expose indexing errors; the generic function-enclosure and termination arguments are the paper proofs above.

## Disposition

Accept the design in its declared scope. The remaining deliverables are the actual source-faithful declarations, kernel-checked primitive and graph soundness proofs, sinc and floor adapters, the verified witness checker, and the final analytic/arithmetic composition. The research plan and its exact examples are not substitutes for those implementations. No completed Lean proof, production evaluator, or spectral certificate is inferred.
