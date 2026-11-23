# Independent review of the elementary horizontal upper bound

2026-11-11. Verdict: PASS for the source-backed paper upper-bound reduction and the conditional integrated-S/completeness arithmetic. No substantive correction is requested. The proposal can replace the Rademacher leaf for this weaker upper bound. It does not prove the lower horizontal bound, Littlewood identity, a complete Turing theorem, or acceptance of any future production packet.

No Lean build, spectral scan, dependency change, producer edit, or frozen-package edit occurred. The scalar computation below uses exact rational arithmetic only. All analytic/formal proof obligations remain distinct from that computation.

## Pins and evidence

Producer directory: `work/qrh-blueprint/turing-scalars/`.

| File | SHA256 |
| --- | --- |
| `ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md` | `0875B2B87A02421B7B8CD6CAD0D1C33433A051E240F48EA4C5F45FE04558BD27` |
| `elementary_horizontal_upper.py` | `9369B77D2E46B5F90E9AEB0FD1641BD9D428C630CF4E1DA180BF0C41862FA0FB` |
| `elementary_horizontal_upper.json` | `0C3AE91CDC3A5D1A100679AC7DEF6F6E05D242F1468D2093864EB2B28D38AC07` |

Reviewer files beside this report:

| File | SHA256 |
| --- | --- |
| `review_elementary_horizontal_upper_20261111.py` | `B1FC4730524DD2316E7953DB01AB0912A3196F6362927057A47C74A762E31D54` |
| `review_elementary_horizontal_upper_20261111.json` | `D8E78CEC47754AC71662F5F7FE2508F55D40CABD11BF5EB9159499657930279F` |

The reviewer script ran with exit 0 using `python work/qrh-campaign/agents/integration/review_elementary_horizontal_upper_20261111.py`. It verifies producer hashes before and after, but never executes the producer or writes its receipt. It independently derives the exponential polynomial by recurrence, the bound coefficients, and both difference signs as affine expressions in Z2 and d=Z2-Z1. It checks positive exact margins, rather than testing selected heights or conductors.

## Actual source theorem and domain

I read the complete `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean`. The checkout HEAD is `23b2d68ca344203d4384e0aff7affa4ec034bef9`; this source file has SHA256 `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341`. At line 179 the declaration is

```
TernaryGoldbach.Explicit.norm_LFunction_le
  {q : Nat} [NeZero q] {chi : DirichletCharacter Complex q}
  (hchi : chi != 1) {s : Complex} (hs : 0 < s.re) :
  norm (chi.LFunction s) <= ((q : Real)+1)*norm(s)/s.re.
```

There is no primitivity, parity, height, conductor upper bound, or Platt binder in this statement. The file proves periodic partial-sum cancellation for nonprincipal characters, a q+1 partial-sum norm bound, integrability and differentiation of the partial-sum integral, and equality with the actual L-function by continuation from Re(s)>1. Its final estimate integrates the norm majorant. The paper proposal uses this actual function, not a surrogate series outside its convergence domain. Source inspection does not constitute a fresh compile or a transitive axiom audit.

For the proposal's primitive character at Q>1, nonprincipality follows from the pinned Mathlib `DirichletCharacter/Basic.lean:258`, `conductor_one`, and the definition `IsPrimitive` at line 291. A principal character has conductor 1 and cannot be primitive at Q>1. This excludes Q=1 from the proposed family theorem. No zeta pole correction is silently removed.

## Compact norm and logarithm bound

For Q>=2, t>50, and 1/2<=sigma<=5/4, all divisions are positive. The exact inequalities are

```
Q+1 <= 3*Q/2,
1/sigma <= 2,
(sigma/t)^2 < 1/1600,
sqrt(1+1/1600) < 1001/1000.
```

The last squared comparison has slack 43/31250. Applying the source theorem gives `norm L(sigma+i*t)<(3003/1000)*Q*t`. The strictness comes from t>50 and the norm-factor bound, so no strict version of the source theorem is required.

Let Z=log(Q*t/(2*pi)). It is positive because Q*t>100>2*pi. The exponential Taylor polynomial through degree 6 equals 1553/80, exceeding 19 by 33/80. Also

```
(6006/1000)*(22/7) = 4719/250 < 19,
```

with slack 31/250. Thus `(6006/1000)*pi<exp(3)`. For a nonzero L value,

```
log(norm L) < log(Q*t/(2*pi)) + 3 = Z+3.
```

There is no use of a Gamma ratio, functional equation, or weighted strip interpolation here. The standard rational pi comparisons have existing Mathlib support: `Real.pi_gt_d2` gives 157/50<pi, and `Real.pi_lt_d4` gives a stronger upper bound than 22/7. Their later arithmetic adapters remain to be instantiated.

The compact interval has length 3/4, so its integral is at most `(3/4)*Z+9/4`. A non-strict compact bound is sufficient because the tail estimate below is strict.

## Zeros, tail integrability, and the function being integrated

Log monotonicity above applies off the zero set. It is legitimate to integrate the inequality almost everywhere. Nonprincipal L is entire, and the Euler-product half-plane shows it is not identically zero. Thus the compact horizontal segment has finitely many zeros. Local factorization at each zero gives a finite multiple of log|sigma-sigma0| plus a continuous term, which is integrable, including at segment endpoints. Assigning any finite value at a zero does not change the integral. In particular the source convention Real.log(0)=0 causes no problem. Since Z+3>0, that assignment even satisfies the displayed pointwise upper bound at zeros.

I checked the exact existing API `MeromorphicOn.intervalIntegrable_log_norm` in Mathlib `Analysis/SpecialFunctions/Integrability/Log.lean:48`. It applies to a real-variable map into a real normed space, including Complex, under real meromorphicity on the unordered compact interval. Applying it requires the scalar-restriction and real-affine composition adapters for the entire complex L-function. It does not require a finite certified zero list. Those wrappers are unimplemented here.

On Re(s)>1 the canonical Euler logarithm is the absolutely convergent sum of chi(p)^k/(k*p^(k*s)). The norm is bounded by the corresponding positive zeta logarithm. The identities exp(ell)=L and `Re ell=log(norm L)` then imply

```
abs(log(norm L(sigma+i*t))) <= log(zeta(sigma)).
```

This proves absolute integrability of the horizontal tail, not only an upper estimate of a possibly nonexistent improper integral. The actual-L-series identification uses `LFunction_eq_LSeries` on Re(s)>1. The pinned Euler-product source contains the exponential-log L-series and `log_riemannZeta_eq` interfaces; their normalization and convergence adapters remain formal work. No arbitrary principal-argument choice is needed for this real logarithm inequality.

The independently reviewed J packet supplies `integral_(5/4)^infinity log zeta <148/125` at paper/external-interval scope. Its review is `integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md`, SHA256 `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2`. Its formal EM, convexity, integration, and proved interval-replay obligations are inherited, not erased. Combining it with the compact estimate gives exactly

```
I_chi(t) < 1717/500 + (3/4)*Z(t).
```

## Conditional Turing reduction and both signs

Keep the lower horizontal bound and the canonical Littlewood identity as genuinely unfinished proof obligations on the stated domain. Denote the proposed upper coefficients by A=1717/500, a=3/4, and the lower-bound magnitude coefficients by C=34507/10000, c=6/25. Put Zj=Z(tj), with 50<t1<t2, so Z2>Z1>0.

Using the upper bound at t2 and lower bound at t1 gives

```
I(t2)-I(t1) < A+C+a*Z2+c*Z1.
```

Using the upper bound at t1 and lower bound at t2 gives

```
I(t1)-I(t2) < A+C+a*Z1+c*Z2.
```

Both are at most `68847/10000+(99/100)*Z2`. The respective slacks are `(6/25)*(Z2-Z1)` and `(3/4)*(Z2-Z1)`. Thus neither direction substitutes the wrong endpoint into a negative slope.

Assuming `pi*integral S=I(t2)-I(t1)` with the canonical horizontal-continuation convention, divide by positive pi. The exact differences

```
(11/5)*(157/50) - 68847/10000 = 233/10000,
(8/25)*(157/50) - 99/100 = 37/2500
```

are positive. Since Z2>0 and pi>157/50, this proves the sufficient conditional estimate

```
abs(integral_(t1)^(t2) S_chi) < 11/5+(8/25)*Z2.
```

This calculation does not establish Littlewood's identity or the lower bound, and cannot accept endpoint conventions that their eventual proofs fail to justify. Integrability of log norm across zeros alone is not a proof of canonical argument continuation or the almost-everywhere count identity. The same upper calculation applies to the inverse character because it has the same conductor and remains primitive nonprincipal.

## Completeness surcharge and unchanged acceptance test

I checked the companion production plan and its endpoint addendum. The integrated count upper bound is

```
U = (integral G - W + B_chi + B_inverse)/h,
```

with h>0, and acceptance still requires the strict integer-saturation test `U<K_main+1`. Replacing each old allowance `1.8397+.1242*Z(T+h)` by `2.2+.32*Z(T+h)` increases it by exactly

```
Delta = 3603/10000 + (979/5000)*Z(T+h).
```

The unchanged two-channel formula therefore increases the exact upper expression by `2*Delta/h`. For a real character, both S channels coincide but are still counted twice; halving this surcharge would be wrong. For a nonreal pair, each character contributes one channel. The same rule holds for the closed-count/a.e. endpoint addendum under its stated analytic hypotheses.

A previously successful fixed packet remains successful under this replacement only when its certified margin exceeds the actual surcharge, with enclosure rounding accounted for. If a rational overestimate of the surcharge is used, it must fit within the certified margin. Increasing h changes the auxiliary range, W, Gamma integral, and logarithmic allowance; it requires new checked data. This review gives no success, runtime, or evidence-size guarantee for those packets.

## Acceptance boundary

The elementary upper proof is a valid alternative that removes the need to prove the sharp Rademacher estimate for this particular upper-bound route. It does not remove analytic ingredients needed separately by the lower horizontal argument or the count theorem. The principal conductor-one row remains outside its scope.

Remaining work includes compiling and auditing the actual source provider, implementing the norm/log and integration adapters, formalizing the Euler-log tail and accepted J certificate, proving the lower horizontal bound and convention-correct Littlewood/a.e. count identities, and generating evidence that passes integer saturation with the larger allowance. No analytic premise is licensed at the final Goldbach root, and no existing spectral packet is certified by this review.
