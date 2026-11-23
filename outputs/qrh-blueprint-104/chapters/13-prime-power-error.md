# An unconditional proof of the existing EBound endpoint

Date: 2026-11-10. Source: `calr3/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`, branch `cde-moebius`. Source root: `C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach`. Mathlib source inspected at the matching pinned commit `56a005855ea17e0b0958f73ec801ae140b0a1679` in `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`.

This note supplies a complete paper-level unconditional derivation of the exact public conclusion of `TernaryGoldbach/MinorArcs/EBound.lean:278`, using existing unconditional source results and elementary inequalities. There is no QRH or finite-RH input. It is not a completed Lean formalization: no Lean implementation or compilation was performed in this round. The accompanying exact-rational audit ran successfully, with all 17 checks passing.

## 1. Exact target and definitions

Remove only the surrounding `Fact TernaryGoldbach.PlattGRH` from the following target, preserving its binders, endpoint, and expression:

```lean
theorem E_le_14_28 {x : ℝ} (hx : 4.9e26 ≤ x) :
    ∑' n : ℕ, (if n.Prime ∧ √x < n then 0 else
      (Λ n * etaPlus (n / x)) ^ 2) ≤ 8e-11 * x
```

Here Λ is the real-valued arithmetic von Mangoldt function, `etaPlus` is exactly `TernaryGoldbach.Helfgott.etaPlus`, and square root is `Real.sqrt`. In particular, the strict inequality `√x<n` inside the removed-prime condition is unchanged: a prime at exactly √x remains in the error sum.

Set

- X = 4.9e26 = 490000000000000000000000000;
- s = √x, L = log x;
- e(n) = `eTerm x n`, exactly the displayed summand;
- w(n) = `lamNP n = if n.Prime then 0 else Λ n`;
- ψ(t) = sum over integers 1≤n≤floor(t) of Λ(n);
- P(t) = sum over integers 1≤n≤floor(t) of w(n).

For t≥0 this ψ is exactly `Chebyshev.psi t`: Mathlib defines it using `Finset.Ioc 0 floor(t)`, and for naturals `Ioc 0 N = Icc 1 N`. For natural N, `Prelim.psiN N = Chebyshev.psi (N:ℝ)` by these definitions and `Nat.floor_natCast`. No analytic normalization factor appears. P(t) also equals ψ(t)-θ(t) by `Prelim.psiN_eq`, but the proof below only uses its finite sum definition.

All logarithms below are natural logarithms. Every division and real power used below has positive base or denominator, as checked explicitly. At x≥X, in particular x>1, s>0, and L>0.

## 2. Unconditional ψ(t)≤1.4t for t≥1e8

Mathlib `Chebyshev.psi_le` proves, for every real t≥1,

ψ(t) ≤ (log 4)t + 2√t log t.

This is the elementary Chebyshev bound; it has no Platt or QRH premise. We prove a convenient coarse consequence on the required range.

The function log t/√t is decreasing on [exp 2,infinity), by `Real.log_div_sqrt_antitoneOn`. Put t0=1e8. We have exp2≤t0 and log(t0)≤19, and √t0=10000. Thus for t≥t0,

log t/√t ≤ 19/10000.

For an implementation one may use the already proved `Prelim.log_le_lam_sqrt` with N0=1e8 and λ=19/10000. Its base inequality follows from `Prelim.log_1e8_le`, which is the stronger bound log(1e8)≤18.421. Both declarations have unconditional source proofs, despite living in a module that also contains conditional declarations.

Further, log4 = 2log2 ≤ 2*.6931471808 < 1.387, by `Real.log_two_lt_d9`. Since (√t)^2=t,

ψ(t) ≤ [1.387 + 2*(19/10000)]t = 1.3908t ≤ 1.4t.

This proves the required real-argument lemma, including t=1e8. It does not assert the same coefficient for smaller t, and no later use requires it there.

The audit independently checks the rational certificates exp2≤1e8 and log(1e8)≤19 using `2.7182818283<exp1<2.7182818286` and `(2.7182818283)^19≥1e8`. These are an alternative to invoking the stronger source logarithm certificate.

## 3. Unconditional P(y)≤1.5√y for y≥X

A stronger elementary decomposition than the initial blueprint proposed is already present in `Prelim/LambdaMu.lean:129`:

For every natural N≥1,

P(N) ≤ psiN(Nat.sqrt N) + N^(1/3) log N.               (3.1)

This is `Prelim.nonprime_sum_le`. The declaration is unconditional. Its source proof uses `nonprime_term_le`, von Mangoldt support on prime powers, finite sum rearrangement, and a count of primes with p³≤N. No finite table or RH estimate occurs. In particular, it already resolves all exponent and endpoint bookkeeping; a new prime-power decomposition is unnecessary.

Fix a real y≥X, and put N=floor(y). Then N≥1 and N≤y. The source's natural square root satisfies

(Nat.sqrt N : ℝ) ≤ √N ≤ √y.

Consequently `Chebyshev.psi_mono` and the exact natural-argument normalization give

psiN(Nat.sqrt N) ≤ ψ(√y).

Also N^(1/3)≤y^(1/3), 0≤log N≤log y, so multiplication of nonnegative factors gives

N^(1/3)log N ≤ y^(1/3)log y.

Applying (3.1) therefore proves the real-argument inequality

P(y) ≤ ψ(√y) + y^(1/3)log y.                         (3.2)

This lifting causes no loss at a noninteger y. In particular, the left side remains exactly the sum through floor(y), and no lower bound is imposed on floor(√y) in order to use the real ψ estimate.

Now √y≥√X≥22135000000000>1e8, so section 2 gives ψ(√y)≤1.4√y.

For the second term, `Real.log_div_self_rpow_antitoneOn` with exponent a=1/6 proves that log y/y^(1/6) decreases for y≥exp6. We have exp6≤X. The following base certificates hold:

log X ≤ 61.5,
28000^6 ≤ X,
so X^(1/6)≥28000.

Hence, for every y≥X,

log y/y^(1/6) ≤ log X/X^(1/6) ≤ 61.5/28000 < .1.

The identity y^(1/3)y^(1/6)=y^(1/2)=√y is valid since y>0. It follows that

y^(1/3)log y = √y * [log y/y^(1/6)] ≤ .1√y.

Combining this with (3.2) proves

P(y) ≤ 1.5√y for every real y≥X.                     (3.3)

No interval below X is omitted from the finite sum P(y): inequality (3.1) handles all its summands. The large-argument condition is on the endpoint y, not on each summand n.

For the base logarithm certificate, reproduce the unconditional numeric argument already inside `EBound.E_le_14_28`:

exp(61.5) = exp(1)^61 exp(1/2)
          ≥ (2.7182818283)^61 * (1+1/2+(1/2)^2/2)
          = (2.7182818283)^61 * 13/8
          ≥ X.

The last inequality, exp6≤X from `(2.7182818286)^6≤X`, and 28000^6≤X are checked exactly by the audit. The exponential lower bound is `Real.quadratic_le_exp_of_nonneg`; the exponential identities are `Real.exp_add` and `Real.exp_nat_mul`.

## 4. Existing unconditional bounds for each energy term

The smoothing bounds are already unconditional:

|etaPlus(t)|≤A=1.94, and t|etaPlus(t)|≤B=2.32 for t≥0,

from `Helfgott/HHBound.lean:432,445`, `abs_etaPlus_le_A` and `mul_abs_etaPlus_le_B`. The source has no Platt variable for either theorem.

The following two inequalities are already proved unconditionally in `EBound.lean`.

For 1≤n≤floor x, `eTerm_low` (line46) gives

e(n) ≤ A²[(L/2) 1_[n≤√x] Λ(n) + L w(n)].             (4.1)

This deals with both cases of the exact strict prime cutoff. For n≤√x, Λ(n)≤log n≤L/2. For n>√x, a nonzero error term must have n nonprime, and Λ(n)≤log n≤L. The two nonnegative terms on the right may overcount small prime powers, which is harmless.

For integers j≥0, put a_j=floor(2^j x). If a_j<n≤a_(j+1), `eTerm_block` (line89) gives

e(n) ≤ w(n)*[( (j+1)log2+L ) B²/4^j].                (4.2)

Indeed n>2^j x≥x≥√x. If n is prime, the exact error summand is zero. Otherwise Λ(n)≤log n≤(j+1)log2+L and |etaPlus(n/x)|≤B/2^j. The floor implications used here are strict on the lower end and weak on the upper end, exactly matching `Finset.Ioc`.

Finally e(0)=0 since Λ(0)=0. The n=1 term also vanishes since Λ(1)=0. All e(n) and w(n) are nonnegative (`eTerm_nonneg` and `lamNP_nonneg`). No estimate for etaPlus at a negative input is used, since n/x≥0.

## 5. A uniform bound for every partial sum

Fix x≥X and any natural M, including M=0. We prove a bound independent of M.

The sequence a_j=floor(2^j x) is nondecreasing. Also M≤2^M≤2^M x, so M≤a_M. Therefore, using e(0)=0 and e(n)≥0,

sum_[n<M] e(n) ≤ sum_[1≤n≤a_M] e(n).

The finite right side splits exactly into 1≤n≤a_0 and the blocks a_j<n≤a_(j+1), j=0,...,M-1. This is `sum_Ioc_blocks` together with `Finset.sum_Ioc_consecutive`. For M=0 the block sum is empty; no exceptional case changes the bound.

Summing (4.1), the indicator sum is at most ψ(√x), by finite-set inclusion into [1,floor√x]. Since √x≥1e8, section 2 applies. Section 3 applies to P(x). Thus the low part is at most

A²[(L/2)*1.4s + L*1.5s] = A²*(.7+1.5)*sL.

For the j-th block, sum (4.2) and bound its w-mass by the complete nonnegative sum P(2^(j+1)x). The endpoint 2^(j+1)x≥x≥X, so (3.3) applies on every block. Since

√(2^(j+1)x) = (√2)^(j+1)s,

and r=√2/4 is in [0,1), the block bound is

1.5 B² √2 s [(j+1)log2+L] r^j.

`geom_sums_le` (line142) gives, for every M,

sum_[j<M] r^j ≤ 1/(1-r),
sum_[j<M] (j+1)r^j ≤ 1/(1-r)².

Both coefficients L and log2 are nonnegative. Hence every partial sum is bounded by

F(x) = A²*(.7+1.5)*sL
       + 1.5 B² √2 s [ log2/(1-√2/4)² + L/(1-√2/4) ].   (5.1)

This is the existing proof of `E_partial` with its two prime estimates replaced, and with the endpoint hypothesis x≥X. It does not assert that the old helper, whose domain is all x≥1, has been proved unconditionally with either its old constants or these new constants. A new internal large-range helper suffices; the final public theorem's domain is unchanged.

## 6. Convergence and the actual infinite sum

Equation (5.1) is a finite real bound for fixed x≥X. Its denominators are positive because 0≤√2/4<1. Since all e(n)≥0 and all initial partial sums are at most F(x), the nonnegative series is summable.

This is exactly Mathlib `summable_of_sum_range_le`, in `Mathlib/Topology/Algebra/InfiniteSum/Real.lean:89`. Its hypotheses are `forall n,0≤e(n)` and `forall M,sum_(n<M)e(n)≤F(x)`, which were established above. The conclusion then follows through `Real.tsum_le_of_sum_range_le` (line99):

sum'_n e(n) ≤ F(x).                                  (6.1)

Thus the argument does not exploit Lean's convention assigning zero to an unsummable `tsum`. It proves summability first. All rearrangements in section 5 are finite; the only infinite geometric sums used by the existing `geom_sums_le` have established summability because |r|<1. There is no exchange of an unverified infinite sum and an integral in this proof.

For the subsequent Fourier-integral consumer, no new convergence argument is needed. `MinorTotal.summable_a2` (line103) already gives absolute summability of the residual coefficient sequence for every x>0. `MinorTotal.norm_sq_sum_a2_le` (line138) identifies its squared coefficient norm with the same summands e(n). The later integral estimate uses the existing `TernaryGoldbach.setIntegral_norm_sq_expTsum`, with that absolute summability premise. Changing the proof of (6.1) changes none of these objects, identities, or hypotheses.

## 7. Exact constant audit: F(x)<8e-11*x

We retain simple rational rounding, close to the existing Lean proof. The following are valid:

√2≤1.41422,
log2≤.6931471808,
1/(1-√2/4)≤1.54693,
1/(1-√2/4)²≤2.393.

The last two follow by replacing √2 by1.41422, leaving a positive denominator, and cross-multiplying. The accompanying script checks the exact rational cross-products. They are the same rounding constants already used in `EBound.E_le_14_28`.

The low coefficient is exactly

A²*(.7+1.5) = 8.27992.

For the high coefficient,

1.5 B² √2 ≤ 1.5*(2.32)²*1.41422 = 11.417846592.

Consequently (5.1) implies

F(x) ≤ s*(alpha*L+beta),

where the chosen rational coefficients are

alpha = 8.27992 + 11.417846592*1.54693
      = 25.94252942856256 ≤ 25.943,
beta = 11.417846592*.6931471808*2.393
     = 18.9387958852916889858048 ≤ 18.94.

Therefore F(x)≤s*(25.943L+18.94).

The source's elementary logarithmic comparison, reproduced here, gives

s ≥ s0 := 22135000000000,
L/s ≤ 61.5/s0.

The first follows from s0²≤X≤x. For the second, use that log x/√x is decreasing on x≥X≥exp2, then the already established log X≤61.5 and √X≥s0. All terms are nonnegative, so decreasing the positive denominator from √X to s0 is a valid upper bound.

Dividing by x=s²>0 gives

F(x)/x ≤ 25.943*(L/s) + 18.94/s
       ≤ (25.943*61.5+18.94)/22135000000000
       = 3228869/44270000000000000
       < 8e-11.

The exact positive margin in this last comparison is

8e-11 - 3228869/44270000000000000
      = 312731/44270000000000000.

Numerically the upper bound is about7.29358256155410e-11 and the margin about7.06417438445900e-12. These decimal expansions are informational; the proof uses the displayed fractions. Combining this with (6.1) proves the exact required weak inequality, including x=X.

## 8. Precise source/API ledger

Paths under `TernaryGoldbach/` refer to the pinned project; Mathlib paths refer to the matching pinned dependency. Entries marked 'new glue' are short mathematical consequences proved in this note, not yet Lean declarations.

| Step | Existing source/API | Role and exact restriction |
|---|---|---|
| Exact summands | `MinorArcs/EBound.lean:23,27` `eTerm`, `lamNP` | Preserve definitions verbatim. |
| Nonnegativity | same:29,32 `eTerm_nonneg`, `lamNP_nonneg` | All real x / natural n. |
| ψ normalization | `Mathlib/NumberTheory/Chebyshev.lean:77` `Chebyshev.psi`; `Prelim/LambdaMu.lean:53` `psiN`; `Nat.floor_natCast` | New glue equality uses natural `Ioc 0 N=Icc 1 N`; no estimate. |
| ψ monotonicity | `Mathlib/NumberTheory/Chebyshev.lean:170` `Chebyshev.psi_mono` | Monotone on real arguments. |
| Elementary ψ upper | same:441 `Chebyshev.psi_le` | x≥1. |
| Root-log monotonicity | `Mathlib/Analysis/SpecialFunctions/Log/Monotone.lean:78` `Real.log_div_sqrt_antitoneOn` | Domain `[exp2,infinity)`. |
| General power-log monotonicity | same:60 `Real.log_div_self_rpow_antitoneOn` | Positive exponent a; domain `[exp(a^-1),infinity)`. Here a=1/6. |
| Existing root-log wrapper | `Prelim/LambdaMu.lean:1494` `log_le_lam_sqrt` | N0≥40000, N≥N0, supplied base log bound. |
| Existing base log | same:1515 `log_1e8_le` | log1e8≤18.421. |
| Prime-power decomposition | same:93,129 `nonprime_term_le`, `nonprime_sum_le` | N≥1; proof unconditional. |
| Floors and roots | `Nat.floor_le`, `Nat.le_floor`, `Nat.floor_lt`, `Real.nat_sqrt_le_real_sqrt`, `Real.sqrt_le_sqrt` | All positivity side conditions are supplied in sections2–5. |
| Powers and products | `Real.rpow_le_rpow`, `Real.rpow_add`, `Real.rpow_mul`, `Real.sqrt_eq_rpow` | Bases positive; exponents1/3,1/6 sum to1/2. Exact sixth-power comparison proves28000≤X^(1/6). |
| Numeric log/exponential | `Real.log_two_lt_d9`, `Real.exp_one_lt_d9`, `Real.exp_one_gt_d9`, `Real.quadratic_le_exp_of_nonneg`, `Real.exp_add`, `Real.exp_nat_mul`, `Real.log_le_iff_le_exp` | Same unconditional elementary numeric APIs already used by EBound. |
| Smoothing bounds | `Helfgott/HHBound.lean:432,445` `abs_etaPlus_le_A`, `mul_abs_etaPlus_le_B` | t≥0. |
| Low and high energy | `MinorArcs/EBound.lean:46,89` `eTerm_low`, `eTerm_block` | x≥1; finite Icc/Ioc membership as above. |
| Finite block partition | same:38 `sum_Ioc_blocks`; `Finset.sum_Ioc_consecutive` | Nondecreasing integer boundary sequence. |
| Root identity | same:163 `sqrt_two_pow_mul` | Real y≥0, integer j≥0. |
| Geometric control | same:142 `geom_sums_le` | 0≤r<1; every finite J. |
| Nonnegative infinite sum | `Mathlib/Topology/Algebra/InfiniteSum/Real.lean:89,99` `summable_of_sum_range_le`, `Real.tsum_le_of_sum_range_le` | Bounded initial partial sums and pointwise nonnegativity. |
| Existing final scalar reduction | `MinorArcs/EBound.lean:278` proof, beginning `have hLs` | Reuse algebra and base log certificate, with new coefficients. |
| Immediate consumer | `MinorArcs/MinorTotal.lean:138` `norm_sq_sum_a2_le` (source identifier contains subscript₂) | x≥4.9e26, same8e-11 coefficient. |

No call to `Prelim.sum_vonMangoldt_lt`, `Prelim.psiN_le`, `Prelim.sum_vonMangoldt_nonprime_lt`, `theta_explicit`, `psi_two_sided`, or a finite prime table is needed in the replacement proof.

## 9. Future Lean task and review boundary

A future implementation can consist of:

1. New glue proving ψ(t)≤1.4t for t≥1e8 and lifting `nonprime_sum_le` to real endpoints.
2. The large-range P(y)≤1.5√y consequence with the exact base inequalities above.
3. A private or clearly named new partial-sum lemma at x≥X, following the existing `E_partial` proof and changing only the prime inputs and coefficients.
4. The unchanged public `E_le_14_28` conclusion, with its Platt instance removed, using the exact rational final reduction.

The original helper `E_partial` has the larger domain x≥1 and different constants. This note does not narrow it silently. It can remain conditional and unused by the new endpoint theorem, or be addressed separately. No new hypothesis is added to the public target. Subsequent `MinorTotal.norm_sq_sum_a2_le` can also shed its Platt instance if it was used only through this target; `I0_ge` still has the separate major-L2 input.

Run `python work/qrh-campaign/agents/moebius/ebound_rational_audit.py` from the workspace to reproduce the 17 exact rational checks. The script contains no floating inputs and uses `Fraction` for every comparison. Decimal conversion is only for printing. It checks numerical certificates, not the analytic theorems or Lean elaboration. A future formalization must still elaborate the glue, inspect its actual assumptions and axioms, and validate the unchanged endpoint expression. This note closes the paper-level mathematical estimate, not the formal verification task.


## 10. Independent review and resumed-run verification

The independent statement-audit agent reviewed the full note, inspected the source of `Prelim.nonprime_sum_le` and Mathlib `Chebyshev.psi_le`, and reran all 17 exact rational checks. It reported no mathematical defect in the floor lift, the exact prime-cutoff endpoint, the range of the P(y) estimate, the finite block partition, or summability. Its review is recorded in the companion audit artifact `agents/audit/MINOR_REPLACEMENT_AUDIT.md` (location as maintained by the audit agent).

The review explicitly preserves the distinction between the new internal helper at x≥4.9e26 and the original `E_partial` at x≥1. It approves the paper-level route, not Lean elaboration. A resumed-run execution of `ebound_rational_audit.py` again passed all 17 checks and reproduced exactly `3228869/44270000000000000`, or approximately 7.29358256155410e-11. The final report and script therefore agree.
