# Independent review of the elementary interval source plan

2026-11-11. **PASS as a paper-level enclosure design and source-backed implementation plan.** No blocking mathematical defect was found in the stated domains, rational witness conditions or remainder formulas. The four displayed rational examples pass independent exact recomputation. This does not establish an implemented interval checker, a Lean proof of any new wrapper, or a spectral conclusion.

Reviewed `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md`, SHA256 `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC`. The author file and frozen packages were not changed. No Lean build, dependency installation, or canonical edit occurred.

## Source and arithmetic evidence

I checked the actual theorem signatures in Mathlib checkout `56a005855ea17e0b0958f73ec801ae140b0a1679` and Goldbach checkout `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The primary files inspected have no tracked diff from their stated HEAD. The new receipt records hashes for 17 source files, including the extra argument adapter sources described below. These are source checks, not elaboration or axiom-closure checks.

Independent files in this directory:

| Artifact | SHA256 |
|---|---|
| `review_interval_primitives_20261111.py` | `155D7D94C5C989F6E878CD9F5C61B382B9830781843E3F8C42D6C2C683102C1F` |
| `review_interval_primitives_20261111.json` | `C5BBF4FEFCE058B74EA5B2A7446A6271F6B4759382D968E4D90BE9EF067A6DC3` |

The script uses only standard-library exact fractions and integer arithmetic. It recomputes all four displayed pi, exp(1), log(2), and sqrt(2) witnesses and their containment comparisons. It also tests signed interval formulas on 325 rational intervals, including 156 reciprocal domains, and checks 6432 symmetric integer residue decompositions. These finite regressions supplement the mathematical audit; they do not prove generic soundness.

## Rational operations and domain guards

The dyadic comparison m*d<=n*2^p<=k*d is equivalent to the proposed outward bound when d>0. Signed integer arithmetic is necessary. Well-formed endpoints, positive denominators and references to earlier graph nodes are sufficient for the proposed finite induction, provided each tag identifies the exact source expression and carries all its domain guards. The witness generator need not be proved terminating or accurate.

The real reciprocal order [1/b,1/a] is correct on either strictly negative or strictly positive intervals. The requirement that zero is excluded cannot be replaced by a nonzero midpoint. For complex reciprocal, separate square lower bounds give a nonnegative enclosure of Re(z)^2+Im(z)^2. A strictly positive sum lower bound proves z is nonzero and validates conjugate(z)/normSq(z). Dependence between the numerator and denominator can widen this interval but cannot invalidate it. A box containing zero must fail this rule, even if a particular unknown point in it happens to be nonzero.

`Complex.norm_def:31` and `normSq_eq_norm_sq:149` support the norm conversion. `Real.le_sqrt:239`, `sqrt_le_left:223`, `sqrt_le_iff:227`, and `sq_sqrt:177` support the square-root checker with its stated nonnegativity guards, including input lower endpoint zero. A positive rational r whose square is at most the squared-norm lower bound gives the claimed norm lower bound. No totalized reciprocal or square-root value outside the declared domain is used.

## Pi, exponential and logarithm tails

`Real.hasSum_arctan` requires norm(t)<1, equivalent to abs(t)<1 here. For 0<=t<1, the positive term sequence is antitone and summable by a geometric majorant. The two `Antitone` alternating-series lemmas have precisely the even-lower and odd-upper orientations claimed. The error theorem requires summability of the positive term sequence, not just convergence of the alternating series; the plan supplies the stronger hypothesis. The t=0 case is sound and t=+/-1 is excluded from this series interface.

The actual Machin theorem is `4*arctan(1/5)-arctan(1/239)=pi/4`; multiplying by four yields the displayed expression. The negative coefficient requires the reversed endpoints, as used. The independent exact witness checks confirm the proposed 20-decimal interval without assuming a decimal pi value.

The real Taylor tail is t^N*(N+1)/(N!*N), with N positive and abs(t)<=1. Both denominator factors and the full factorial tail are retained. The positive lower bound comes from `Real.sum_le_exp_of_nonneg`, located at `Analysis/Complex/Exponential.lean:249`; the plan's nearby line-range reference 516–523 applies to the error lemmas, not this lower-bound lemma. This is a citation-location correction only. The real error theorems are at lines 517 and 523. Repeated squaring follows from `Real.exp_nat_mul:234`, and negative arguments use a positive reciprocal enclosure. For an interval input, monotonicity applied to independently certified endpoints gives uniform containment.

The complex theorem `Complex.exp_bound':407` has exactly the hypothesis norm(z)/(N+1)<=1/2 and error 2*norm(z)^N/N!. It does not need the extra N>0 restriction imposed by this plan, so that restriction is harmless. The unit-disc version at line 377 does require N>0. The source use in `Eta2DDTaylor.norm_cexp_sub_TN:110` confirms the intended interpretation. Neither error may be replaced by only the first omitted term.

For log reduction x=2^k*y with 1<=y<=2, both factors are positive even when k is negative. `Real.log_mul` and `log_zpow` therefore give the exact claimed identity. At y>1, alpha=1/(y-1)>0 gives 1+alpha^(-1)=y and 1/(2*alpha+1)=(y-1)/(y+1). The existing `RamPf.log_one_add_inv_bounds:31` has the displayed finite sum and geometric tail with denominator (2N+1)*(1-t^2), including N=0. Handle y=1 directly rather than substituting an invalid infinite alpha. Negative k is ordinary signed interval multiplication. The alternative exponential-inversion inequalities have the correct direction: an upper bound for exp(l) proves a lower bound for log(x), while a lower bound for exp(u) proves an upper bound.

## Uniform trig reduction and complex values

The range-reduction integer is a witness, not an unchecked nearest-integer computation. With pi in P and x in X, the interval operations enclose the exact y=x-2*k*pi. The periodicity lemmas at `Trigonometric/Basic.lean:273,356` then identify the actual sine and cosine. Propagating pi uncertainty is essential for large or negative k. As an exact stress check, x=+/-1000000 and k=+/-159155 give reduced intervals inside [-4,4]; their widths equal 31831/10^19, precisely 2*abs(k) times the proposed pi interval width. Replacing pi by a midpoint would lose that uncertainty.

For all y in Y subset [-R,R], norm(I*y)=abs(y)<=R. Under R/(N+1)<=1/2, the complex Taylor theorem gives the two coordinate error bounds after taking real and imaginary parts. The parity formulas retain exactly those powers whose exponent is below N. The R=4,N=7 boundary satisfies equality in the theorem's hypothesis, so N>=7 is valid, although that smallest degree need not be accurate enough for an application. Interval Horner evaluation over Y deals correctly with nonmonotonicity. Endpoint sine/cosine values alone would not.

`Complex.exp_re` and `exp_im` at lines 522 and 526 give the real-exp/trig construction. Alternatively, a complex norm error E gives a square coordinate error [-E,E]^2. It is not valid to turn an arbitrary square of that size back into a norm error E; its corner has squared norm 2E^2. The plan keeps the direction correct.

The positive-base power identity follows from `cpow_def_of_ne_zero` and `ofReal_log` under r>0. This includes n=1 and excludes base zero. Varying positive bases require a uniform real-log enclosure, as stated. Root-of-unity residues use division after casts, exact integer equality k=j*m+r, m>0, and periodicity. Primitivity is a separate exact coprimality theorem in `RootsOfUnity/Complex.lean:46,60,64`; proximity to a root is insufficient. Numerical root tables do not identify actual Dirichlet characters or their indexing.

## Finite coefficients and the remaining top-count adapter

Horner evaluation is sound for the exact finite polynomial with the stated coefficient order. `Polynomial.eval_eq_sum_range'` and `eval₂_eq_sum_range'` require `p.natDegree<n`, exactly as the plan warns. A supplied list does not establish that degree bound or identify its entries with Taylor coefficients. In particular, the spectral EM programs still need proofs that their recurrence and truncated series products enclose the coefficients of the actual finite entire g. Their Cauchy and EM remainders are additional analytic theorems. The plan does not claim otherwise.

One consumer boundary should remain explicit in future implementation work: the current plan does not yet specify a checker for the principal complex logarithm used in the top-count S value. That omission is consistent with its stated real-log scope, so it is not a defect in the elementary enclosures reviewed here. A small source-backed extension is available for right-half-plane rectangles:

1. Prove a>0 for the input real interval [a,b], then use the rational reciprocal and multiplication rules to enclose u=Im(z)/Re(z).
2. `Complex.tan_arg:217` and `abs_arg_lt_pi_div_two_iff:399`, followed by `Real.arctan_tan:133`, give arg(z)=arctan(u). `Complex.log_im:35` identifies this with Im(log z).
3. Certify arctan at the two rational endpoints of the u interval and use `Real.arctan_mono:172`. For abs(u)<1 use the reviewed series; u=+/-1 uses `arctan_one:200` and `arctan_neg:221`; abs(u)>1 uses the reciprocal formulas `arctan_inv_of_pos:258` and `arctan_inv_of_neg:264`, reducing to an argument strictly inside (-1,1). The pi/2 term is enclosed using the same pi certificate.

This derives a uniform right-half-plane argument enclosure without a general complex-log implementation. The global continuous-argument initialization and panel coverage still belong to the separate top-count proof; pointwise principal arguments cannot replace them. This paragraph is a paper/source derivation, not a new proved Lean wrapper.

## Disposition

Accept the plan within its declared scope. No formula or domain correction is required. Keep the small citation-location correction and the missing consumer adapters above in the implementation ledger. Kernel decisions, rational interpretation, graph soundness, elementary wrappers, formal coefficient semantics and the analytic spectral bridges must all be implemented and checked before the external numerical reports become Lean theorems. The finite example checks make no claim about kernel memory, runtime, global memoization, or completed axiom closure.
