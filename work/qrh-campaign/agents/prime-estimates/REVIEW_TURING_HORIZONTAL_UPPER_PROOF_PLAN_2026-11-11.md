# Independent review of the Turing horizontal upper bound

2026-11-11. **PASS as a source-faithful conditional proof plan with exact scalar evidence.** No blocking defect was found. The analytic growth bound remains an explicit unresolved theorem. This review does not prove the complete horizontal estimate in Lean, the lower horizontal estimate, Littlewood's identity, or family completeness.

## Frozen inputs and scope

Paths are relative to `work/qrh-campaign/agents/` unless otherwise stated.

| Reviewed artifact | SHA256 |
| --- | --- |
| `audit/TURING_HORIZONTAL_UPPER_PROOF_PLAN_2026-11-11.md` | `23B77DFE289CE7265633AD97DA9017BB4552C3AC5DD824EEA2771B88427C8FC4` |
| `audit/turing_horizontal_upper_scalars_20261111.py` | `D11D64A27AABC18B9261B984F0EE89B336DDFC24F80E8AD7B272962572C7A495` |
| `audit/turing_horizontal_upper_scalars_20261111.json` | `089B5BCE9509BE2431CD5C67558D298FE10DE9349B166D859245726729DB3983` |

I read the relevant primary-source text of Trudgian Lemmas 3.4–3.6 from the local PDF extraction, checked the actual pinned Mathlib interfaces listed below, replayed the author's scalar program without writing its files, and independently constructed a second rational zeta bound. I also read and hash-checked the separate J-integral review. This review did not obtain a new copy of Rademacher's original paper or reconstruct its proof.

The source pin remains Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`, read in the existing local cache. No Lean/build command, prime or zero scan, canonical edit, dependency change or producer-file write occurred. The only new file from this assignment is this review.

## 1. Conductor, strip parameter and target

The statement keeps the conductor Q, an integer greater than 1, separate from the real strip parameter b=5/4. A primitive character of conductor Q>1 is nonprincipal. In the pinned source, `DirichletCharacter.IsPrimitive` means that the conductor equals the level; `conductor_one` supplies the exclusion of the principal character. The proof of `IsPrimitive.completedLFunction_one_sub` itself uses this deduction when the level is not 1.

Trudgian Lemma 3.5 states the Rademacher estimate for primitive characters of modulus Q>1, both parities, and `1<b<3/2`, throughout `1-b<=Re(s)<=b`. Substitution b=5/4 gives precisely

`|L(s,chi)| <= zeta(5/4)*(Q*|1+s|/(2*pi))^((5/4-Re(s))/2)`.

The compact integration interval [1/2,5/4] lies inside that strip. No principal zeta case, conductor upper bound, RH assertion, parity restriction or finite zero list is inserted. The note correctly leaves this exact weighted convexity estimate as a substantive analytic leaf. A maximum-modulus slogan or asymptotic Gamma quotient would not prove it.

The horizontal target is the real integral of `log norm` for actual `DirichletCharacter.LFunction`, not an arbitrarily chosen complex logarithm. Its intended range is every real t>50, including exceptional zero heights.

## 2. Compact integration and sign checks

Set `Z=log(Q*t/(2*pi))` and `alpha(sigma)=(5/4-sigma)/2`. On the integration interval alpha is nonnegative. At points where L is nonzero, taking logs of the Rademacher bound gives the stated upper bound. Since t>50 and 1+sigma<=9/4,

```
log(|1+sigma+it|/t)
 = (1/2)log(1+(1+sigma)^2/t^2)
 <= (1+sigma)^2/(2*t^2) < 81/80000.
```

The positive sign of alpha is necessary when multiplying this inequality and is recorded. The exact integrals are length 3/4 and

`integral_(1/2)^(5/4) alpha = (3/4)^2/4 = 9/64`.

Thus the norm correction contributes `(9/64)*(81/80000)=729/5120000`. All denominator and exponent directions are correct. The displayed compact inequality may be weakened to non-strict without affecting the final strict conclusion, since the zeta and J scalar inputs are strict.

Q>=2, t>50 and pi<4 imply `Q*t/(2*pi)>1`, so Z>0. Therefore replacing the positive coefficient 9/64 by .15 is an upper-bound relaxation. This positivity is essential and is not inferred merely from t>0.

## 3. Zeros and real log-norm integrability

The phrase "zero abscissa" means a zero on the fixed horizontal line, viewed as a singular point of the real variable sigma. It does not mean a real-axis zero of L. Nonprincipal L is entire and is not identically zero because its Euler-product half-plane is nonzero. Hence there are only finitely many zeros on the compact horizontal segment, each with finite multiplicity.

Local analytic factorization gives, off a zero beta+it,

`log|L(sigma+it)|=m*log|sigma-beta|+log|g(sigma+it)|`,

with g nonzero nearby. The logarithmic singularity is locally integrable, including when beta is the left or right endpoint, and the second term is continuous. Equality need only hold almost everywhere. Finite assigned values at the zeros, including Mathlib's totalized log of zero, do not change the integral. One must not invoke logarithm monotonicity at a zero without this qualification; the note does not do so.

A stronger existing API makes the compact proof shorter. I directly inspected `Analysis/SpecialFunctions/Integrability/Log.lean:48`:

`MeromorphicOn.intervalIntegrable_log_norm`.

For a map from the real numbers to a real normed space, real meromorphicity on the unordered compact interval implies interval integrability of log norm. Its codomain may be the complex numbers considered over the reals. `AnalyticAt.restrictScalars` and `AnalyticOnNhd.restrictScalars` in `Analysis/Analytic/Constructions.lean:831,840`, followed by composition with the real affine map `sigma -> sigma+i*t`, provide the proposed route from entire L. The remaining wrappers are genuine instantiations, not a claimed compiled theorem. This theorem handles zeros directly and needs no exceptional-height exclusion.

## 4. Euler-log tail and actual source functions

On Re(s)>1 the double Euler-log series converges absolutely. Its absolute value is bounded by the positive prime-power series for log zeta(Re s). Its exponential is L. Therefore

`log|L(s)|=Re ell_chi(s)` and `|log|L(s)||<=log zeta(Re s)`.

The last statement supplies absolute integrability of the tail, not merely a one-sided upper estimate. The canonical Euler log also fixes the later S normalization. It does not provide a global logarithm across the compact segment's zeros, and none is needed for the real upper integral.

The following pinned APIs were inspected directly:

| Source | Exact relevant content |
| --- | --- |
| `NumberTheory/LSeries/DirichletContinuation.lean:74,97` | `LFunction_eq_LSeries` when Re(s)>1; `differentiable_LFunction` when chi is nonprincipal. |
| Same file `:283` | Primitive completed functional equation; it is an ingredient of a future Rademacher proof, not the weighted estimate itself. |
| `NumberTheory/EulerProduct/DirichletLSeries.lean:139` | `LSeries_eulerProduct_exp_log` identifies the exponential of the prime-log sum with the L-series. |
| Same file `:260` | `LSeries_eq_exp_LSeries` gives the corresponding von-Mangoldt/log series formulation. |
| Same file `:273` | `log_riemannZeta_eq` is a real-log statement for the real part of actual zeta at real s>1. Positivity and the positive Dirichlet series identify it with the real zeta used in the note. |

The double-series expansion, absolute majorant and interchange still require their convergence adapters. The note does not pretend that the printed API names already discharge them.

The coarse finiteness argument is correct: positivity, Tonelli and `log zeta<=zeta-1` give

`J<=sum_(n>=2) n^(-5/4)/log n <= (zeta(5/4)-1)/log 2 < infinity`.

No convergence at s=1 is required; the lower tail endpoint is 5/4.

## 5. Independent rational certificate for zeta(5/4)

The monotone tail comparison has the correct endpoint convention:

`sum_(n>256) n^(-5/4) < integral_256^infinity x^(-5/4) dx = 1`.

The finite sum contains n=256 exactly once. Strict decrease makes the tail inequality strict. For each lower fourth-root approximation `r_n/S<=n^(1/4)`, positivity gives the upper term `n^(-5/4)<=S/(n*r_n)`. The author's checked integer inequalities certify that direction. Nested integer square roots are only witness generation; the fourth-power checks are what the finite certificate needs.

I replayed the author script with `Path.write_text` intercepted, compared the resulting text to the frozen receipt, and confirmed that Windows newline encoding reproduces its bytes. Both original files remained unchanged. All 256 root checks, the rational sum, the degree-20 positive exponential lower sum and final constants passed.

An independent inline calculation used ordinary integer binary search, not integer square roots, with scale S=10^9 rather than 10^12. For each n=1,...,256 it searched between 0 and 4*S+1, checking `r^4<=n*S^4<(r+1)^4`. It proved exactly

```
1+sum_(n=1..256) S/(n*r_n) < 11489/2500 = 4.5956
                                      < 1149/250 = 4.596.
```

The SHA256 of the compact JSON array of its 256 integers was `6A8F244DB1CCAFC59D8F2B535029094940510C8068589BC0C6CE197232BC3140`. This was a read-only, short scalar calculation, not a prime or spectral scan. Its proof of the looser rational bound is independent of the author's tighter rounded value.

The positive Taylor polynomial through degree 20 at 763/500 was also independently summed as exact fractions and exceeds 1149/250. Since zeta(5/4)>0, monotonicity gives `log zeta(5/4)<763/500`. No special-function evaluator or floating acceptance comparison was used.

## 6. Separate J input and final scalar assembly

The separate integral input is bound to `integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md`, SHA256 `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2`. I read that report and verified its hash. It accepts the analytic reduction and external elementary interval evidence for J<1.184, with a different cutoff, grid and precision in its independent calculation. This review did not rerun that quadrature and does not broaden its scope to a Lean proof.

Combining the accepted paper/external J input with the rational log bound and compact correction gives

```
(3/4)*(763/500) + 148/125 + (9/64)*(81/80000)
 = 11922649/5120000 = 2.3286423828125 < 2.3288.
```

The independent exact calculation reproduced this fraction and 9/64<.15. Hence the intended upper target follows from the stated Rademacher and Euler/analytic bridges. The older .0011 correction gives `1490339/640000=2.3286546875`, also safe. Neither computation hides a bound on the conductor size.

## Verdict limits

The final note accurately separates proved-in-source ingredients, new paper reductions, exact finite arithmetic and remaining formal work. Its main unresolved analytic producer is the fixed-strip Rademacher estimate with its primitive functional equation, Gamma ratio and growth hypotheses. The separate J bound retains its formal interval and analytic obligations. The lower horizontal estimate, Littlewood identity, normalized S continuation and almost-everywhere endpoint adapter are not consequences of this upper bound alone.

No correction to the final frozen version is required. Acceptance is for this conditional analytic reduction and its scalar certificates, not for a completed Turing theorem or removal of all outstanding family spectral obligations.
