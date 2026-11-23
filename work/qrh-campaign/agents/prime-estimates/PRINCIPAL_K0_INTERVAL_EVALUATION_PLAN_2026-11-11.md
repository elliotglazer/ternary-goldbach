# Finite rational interval evaluation of the simple-phase K0 formula

2026-11-11. This paper design gives a sound finite certificate format and a terminating witness-generation procedure for an exact rational input t>=1500 and an exact positive rational requested tolerance. It is not an implemented or Lean-checked evaluator. No sign scan, FFT, Lean build, or canonical source change was made.

## 1. Target and accepted inputs

The analytic target is the Khat in `independent-feasibility/PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6`. Its independent review is `prime-estimates/REVIEW_PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `A39ED6F31EE45499080BD95357B453F065F0FFEEE78AFDC9B794775460A73633`. All paths below are relative to `work/qrh-campaign/agents/`.

The accepted elementary interval design is `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md`, SHA256 `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC`, with independent review `independent-feasibility/REVIEW_INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md`, SHA256 `4C773E1497C2C6F2D99D0A1F5A060A8029E9CC5EBCD85D5F3265914A13547181`. Its rational arithmetic, squared-root bounds, Machin pi, atanh logarithm, and finite cosine polynomial bounds are reused. Their proofs still need implementation. The new work here is the nonsingular F representation, an explicit global error allocation, and a termination proof for rational inputs.

For a=sqrt(t/(2*pi)), N=floor(a), z=1-2*(a-N), and sigma=-(-1)^N, the exact finite expression is

```
thetahat = (t/2)*log(t/(2*pi)) - t/2 - pi/8 + 1/(48*t),
Khat = sum_(n=1..N) 2*cos(thetahat-t*log n)/sqrt n
       + sigma*F(z)/sqrt a.
```

The source function F is the analytic removable extension of
`cos(pi*(z^2+3/4)/2)/cos(pi*z)`, with F(+/-1/2)=1/2. Evaluating the totalized quotient at a denominator zero would evaluate the wrong function.

## 2. One nonsingular formula for the whole coefficient range

Use the existing unnormalized real sinc, with sinc(0)=1 and sinc(x)=sin(x)/x otherwise. Put

```
w = abs z,                       0<=w<=1,
h = w-1/2,
A = (pi/2)*(w^2-1/4),
B = pi*(w-1/2),
Fstable(z) = ((w+1/2)/2) * sinc(A)/sinc(B).                 (1)
```

For w!=1/2, the numerator and denominator in the original quotient are respectively -sin(A) and -sin(B). Also A/B=(w+1/2)/2. This proves equality to (1). Both sides extend continuously to w=1/2, where (1) is exactly 1/2. The original coefficient is even, including its removable values, so using w=abs z preserves F on the entire [-1,1]. It is not a locally chosen approximation or a branch depending on distance from a removable point.

There is a fixed positive denominator margin. The identity

`sinc(x)=integral_(u=0..1) cos(u*x) du`                    (2)

follows by the elementary antiderivative for x!=0 and directly for x=0. Since cos(y)>=1-y^2/2, it gives sinc(x)>=1-x^2/6. Here |B|<=pi/2 and pi^2<10, whence

`sinc(B)>=1-pi^2/24>7/12>1/2`.                            (3)

Also |sinc(x)|<=1, already available in the source. The two arguments satisfy `-pi/8<=A<=3*pi/8` and `|B|<=pi/2`, hence both have absolute value less than 2. Thus neither near z=1/2 nor near z=-1/2 requires cancellation of small floating quantities or a heuristic division threshold. The true reciprocal in (1) is bounded above by 12/7.

An interval implementation first maps its z interval by the exact absolute-value interval rule and intersects with [0,1], using the established bound on exact z. It computes A and B with pi in [3,22/7]. Their rational interval bounds already lie in [-2,2]. It accepts a reciprocal only after the computed sinc(B) enclosure has lower endpoint at least 1/2. This is an exact rational test, not an assumption from (3). The strict margin in (3) proves that refinement eventually passes this test.

## 3. A uniform rational sinc checker

For integer m>=2 define

```
S_m(x) = sum_(j=0..m-1) (-1)^j*x^(2*j)/(2*j+1)!,
E_m = 2*2^(2*m)/(2*m+1)!.
```

For |x|<=2,

`abs(sinc(x)-S_m(x)) <= E_m`.                             (4)

One proof uses precisely the accepted complex-exponential tail. Apply it with degree 2m to i*u*x, 0<=u<=1. Its ratio hypothesis holds because |u*x|/(2m+1)<=2/5<1/2. Taking real parts gives a cosine error at most `2*|u*x|^(2m)/(2m)!`. Integrate this error over u and use (2). Integration of each finite polynomial coefficient produces the factorial (2j+1)! in S_m and the denominator (2m+1)! in (4). This argument is valid at x=0 and never divides an error estimate by x.

The tail decreases to zero with an explicit geometric bound:

`E_(m+1)/E_m=4/((2m+2)*(2m+3))<=2/21` for m>=2,
so `E_m<=(4/15)*(2/21)^(m-2)`.

The same integral identity and `abs(cos r-cos s)<=abs(r-s)` prove a global bound

`abs(sinc(x)-sinc(y))<=(1/2)*abs(x-y)`.                    (5)

For a rational input interval I=[l,u] within [-2,2], let c=(l+u)/2 and r=(u-l)/2. Evaluate the finite rational polynomial S_m(c) exactly, then return

`[S_m(c)-E_m-r/2, S_m(c)+E_m+r/2]`.                       (6)

This encloses sinc(x) for every x in I. Exact outward dyadic rounding may enlarge it further, with that inclusion checked by integer cross-multiplication. Formula (6) avoids the growing dependency width of interval Horner evaluation at increasing degree. Its radius is an explicit sum of a tail, an input-radius term, and any checked rounding enlargement.

## 4. Certifying the floor at an exact rational height

Let t be an exact rational with t>=1500. For a positive integer k, equality a=k would imply pi=t/(2*k^2), contradicting irrationality of pi. Thus a is not an integer. Its floor N has two strictly positive separation margins.

Given a rational pi enclosure [pL,pU], the certificate for N checks

`2*pU*N^2 < t < 2*pL*(N+1)^2`.                            (7)

Together with 0<pL<=pi<=pU, these inequalities prove N<a<N+1, hence the exact natural floor. N>=15 follows at the initial threshold from pi<22/7. The certificate must carry this integer N, and every finite term uses exactly n=1,...,N.

For a terminating search, pi>=3 supplies a finite initial upper bound on possible N from a^2<=t/6. Enumerate those candidate integers while successively refining the Machin interval. The true candidate eventually passes (7), since the Machin enclosure shrinks to pi and its two true inequalities are strict. All tests are finite rational comparisons. No decision procedure for equality of arbitrary computable reals is used.

After fixing N, enclose a by squared rational bounds and refine until its interval lies inside (N,N+1). Compute z from this interval with that fixed N; optionally intersect its enclosure with [-1,1]. This must never select a different branch from the midpoint of an uncertain a interval.

The analytic theorem covers irrational heights at which a is an integer, with its source indentation. The present terminating numerical procedure has the narrower declared input carrier of rational t, so those exact boundary heights do not occur. Rational heights can be arbitrarily close to them, and (7) can need arbitrarily high precision. There is no uniform bound on the needed precision in this plan. If an input is an interval of heights spanning a floor boundary, it is outside the point contract; one must split and prove coverage rather than use one floor for all its points.

## 5. Finite circuit and an explicit arithmetic budget

Let eps>0 be the requested rational absolute tolerance. Set

`eta=min(eps,19/(1000*t))>0`.                              (8)

Because t>=1, `eta<=.019/t<=.019*t^(-3/4)`. This conservative choice avoids evaluating a fractional power merely to choose a tolerance. A less conservative budget can be added later, but is not needed for termination or the stated error.

Once (7) is certified, the evaluator constructs a finite acyclic graph of exact source expressions and rational interval witnesses:

1. The input rational t and the certified pi interval; t itself is not replaced by an uncertain floating input.
2. Positive divisions, logarithms, and arithmetic for thetahat; positive square-root bounds for a and sqrt(a).
3. The fixed-N value z, its absolute value w, and (1) through the sinc checker (6).
4. For each integer 1<=n<=N, a log(n) enclosure, positive sqrt(n) enclosure, the cosine argument, its cosine enclosure, and the full term `2*cos(...)/sqrt(n)`.
5. The full correction `sigma*Fstable(z)/sqrt(a)` and the rational sum of the N+1 term intervals.

Repeated occurrences of pi or thetahat need not be treated as independent variables in the mathematics. Ordinary interval operations still give sound enclosures if that correlation is discarded. The loss affects width only.

One explicit sufficient acceptance rule requires every full term interval, including the correction, to have width at most `2*eta/(N+1)`. Add these intervals with exact rational arithmetic, obtaining [L,U] with U-L<=2*eta. The reported rational midpoint M=(L+U)/2 then satisfies

`abs(Khat(t)-M)<=eta<=eps`,
`abs(Khat(t)-M)<=.019*t^(-3/4)`.                            (9)

All intermediate roundings are already included in the term intervals. If the final sum is also rounded, the checker instead tests its final width U-L<=2*eta, after that rounding; it must not spend a second unrecorded allowance. It is also sound simply to use the final width test without the termwise sufficient rule.

Combining (9) with the strict assembled analytic error gives

`abs(hardyZ(t)-M)<.47*t^(-3/4)`.

This last expression is a consequence only after both analytic and arithmetic soundness proofs are available. It is not a claim that any existing floating point value, sign file, or interval package meets the allowance.

The arbitrary requested tolerance concerns Khat, not HardyZ. The analytic remainder does not vanish when arithmetic precision increases. A sign test may therefore remain unresolved forever even though evaluation of Khat terminates. For a rational enclosure of HardyZ, separately bound the positive power in the analytic allowance by squared-root or fourth-power rational comparisons, then enlarge the Khat interval; this is finite but does not promise that the result excludes zero.

## 6. Why the whole witness search terminates

This section proves existence and termination for the stated rational inputs, beyond soundness of a supplied finite witness. It does not give a runtime estimate.

Machin's alternating arctangent tails converge geometrically at 1/5 and 1/239. Thus pi intervals of any requested positive rational width can be produced by increasing finite truncation lengths. This already proves termination of the floor phase in section 4.

For a nonnegative rational q=A/B, B>0, dyadic square-root bounds can be generated by integer square comparisons. At precision p choose k with `k^2<=floor(A*2^(2p)/B)<(k+1)^2`. Then k/2^p<=sqrt(q)<(k+1)/2^p. Finite integer search or integer square root produces such k. This also works when sqrt(q) is rational or zero. For an input interval use the lower endpoint's lower bound and the upper endpoint's upper bound. As input widths and dyadic mesh shrink, these enclosures converge by continuity of sqrt. In the present circuit the reciprocal square roots have strictly positive arguments.

For positive rational logarithm endpoints, binary scaling to [1,2] and the accepted atanh series with ratio at most 1/9 give arbitrary finite accuracy. Log monotonicity extends this to intervals whose endpoints converge to a positive value. There is no fixed decimal approximation of exp(1) limiting the precision.

For a rational cosine argument c, choose an integer k and refine pi until a rational interval for c-2*k*pi lies strictly in [-4,4]. Such a k exists because a nearest integer to c/(2*pi) leaves a remainder of absolute value at most pi<4. A finite candidate range `abs(k)<=ceil(abs(c)/6)+1` suffices, using pi>3. Enumerating that range with increasing pi precision terminates, even at an exact halfway case, because the acceptance boundary 4 has strict slack. The accepted factorial tail then gives cos(c) to any rational accuracy. For a general small input interval, evaluate its rational midpoint c and enlarge by its radius using cosine's global Lipschitz bound 1. This accounts for the argument interval without any monotonicity assumption on cosine.

Sinc uses (6). At stage j choose m so E_m<2^(-j), and allow additional outward rounding less than 2^(-j) per endpoint. Its output radius tends to zero whenever the input radius tends to zero, by the explicit bound E_m+r/2. Hence its denominator enclosure eventually has lower endpoint greater than 1/2 by (3). No unsafe division occurs earlier.

After N is fixed, only finitely many nodes remain. Arithmetic, abs, sqrt, log, and the midpoint trigonometric enclosures above propagate shrinking widths through each node. Every division is away from zero at the exact input, including the uniformly protected sinc denominator. By induction over this finite graph, refinement makes each full term interval converge to its exact term. There are only N+1 terms, so eventually every width is strictly less than `2*eta/(N+1)`. The rational acceptance tests then halt successfully.

For specificity, an implementation may increase a global stage j, request all elementary point enclosures and dyadic roundings to error below 2^(-j), and reject a stage if a required reciprocal lower bound or width check fails. Within each stage, the cosine reduction search has the independent terminating procedure just described. The sinc midpoint bound controls its increasing degree explicitly, so there is no unsupported claim that interval Horner widths automatically shrink while the polynomial degree grows. The procedure never retries a failed mathematical equality as if refinement could make it true.

## 7. Existing interfaces and new proof work

The pinned source revision remains Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

| Existing source | Use |
| --- | --- |
| `Analysis/SpecialFunctions/Trigonometric/Sinc.lean:40,45,47,54,59,88` | `Real.sinc`, its value at zero, division formula off zero, evenness, norm bound, and continuity. |
| `Analysis/SpecialFunctions/Trigonometric/Bounds.lean:125,165,283` | `Real.one_sub_sq_div_two_le_cos`, `sin_ge_sub_cube`, and `abs_cos_sub_cos_le`; the first or second proves the sinc lower bound. |
| `Analysis/Real/Pi/Irrational.lean:282` | Global theorem `irrational_pi`, used only to prove termination of the rational-height floor search. |
| `Analysis/Complex/Exponential.lean:407` | `Complex.exp_bound'`, the factorial tail used to derive (4). |
| Accepted interval-primitives plan, sections 1-7 | Exact interval inclusion, dyadic rounding, square-root comparisons, Machin pi, atanh log and cosine argument reduction. |

New small mathematical adapters are (2), the stable identity (1) including removable values, the uniform denominator bound (3), the integrated tail (4), and the Lipschitz inequality (5). Further proof tasks are the rational-height floor certificate and its termination, the finite circuit's source-expression semantics, width propagation and termination, and the final budget (9). The sinc lower bound can be proved directly from `sin_ge_sub_cube` plus evenness, while (2) remains useful for its tail and Lipschitz proofs.

Certificate fields must include exact t and eps, N, the pi witness supporting (7), ordered operation records with earlier references, all truncation and reduction integers, checked rational endpoint bounds, the source-expression identity for Fstable, and the final midpoint/width comparisons. The checker must reject malformed indices, wrong term counts, nonpositive denominators, unmet elementary domains, and failed endpoint inclusions. Hashes identify files but prove none of these mathematical assertions. Final rational comparisons are intended for ordinary kernel checking; no native_decide or external numerical oracle is authorized.

## 8. Bounded arithmetic evidence

The separate script `prime-estimates/principal_k0_interval_scalar_20261111.py`, SHA256 `F14C03BD72F13DC3DB570D9093A8920449D267121F8FD264BA61F2F391390892`, and receipt with the same basename ending `.json`, SHA256 `3212347EBE306A61B8496DA3AD31BADB211B9CDD2D2F21A4BDD38FE42C94B328`, passed with exit code zero.

It uses only Fraction arithmetic, factorials, integer comparisons, and checked outward 128-bit dyadic rounding. Six coefficient examples cover w=0, w=1, the exact removable point w=1/2, a narrow interval crossing it, and nearby intervals on each side. Both original removable points are covered by the even w representation. The computed sinc denominator intervals all have lower endpoint greater than 1/2, and the resulting F widths are less than 10^(-7). The exact removable-point intervals contain 1/2.

Three exact floor witnesses cover t=1500 and rational heights on opposite sides of the a=16 boundary. The two near-boundary heights are constructed from certified Machin bounds, not floating pi. All satisfy (7). The script checks their budget by the equivalent positive fourth-power inequality `eta^4*t^3<=(19/1000)^4`. Eighteen exact tail-ratio tests also pass.

An initial unrounded diagnostic produced enormous rational strings and hit Python's decimal-output size limit. The saved final script uses the intended checked outward dyadic representation and completed without that issue. This was a representation issue, not a failed mathematical inequality. No Python safety limit or Lean resource setting was increased.

These checks test concrete rational witnesses for the proposed lemmas. They do not prove the generic checker or termination theorem. No Khat value, HardyZ sign, new prime count, or new zero data was computed. The plan is ready for independent mathematical and source-interface review.
