# Independent root and strip-estimate review

Source: calr3/ternary-goldbach at 23b2d68ca344203d4384e0aff7affa4ec034bef9. Date: 2026-11-10. Reviewer: worker 8.

## Status

This is a source comparison and mathematical review, not a passing frozen-declaration audit. No manifest-bound author-approved successor declarations were supplied. No Lean source was changed or compiled, no declarations were frozen, and no axiom check was run. Source files were fetched through GitHub at the pinned commit after sandboxed shell reads stalled. Existing comments claiming axiom closure remain unverified here.

The applicable skills were lean-statement-audit, lean-workflow, and unslop.

## Refute-first findings

1. Substituting QRH for PlattGRH in the existing proof fails. Explicit/ZeroSumGen.lean:203 needs Re(rho)=1/2. Lines 256-266 use equality both for x^rho and the Mellin transform's critical-line value.
2. Radius 2.3 cannot cover the full strip using windows of height 3.48. The horizontal distance to the Jensen center can approach 2. The required radius is at least sqrt(4+1.74^2), approximately 2.65096. Radius 2.7 works.
3. Critical-line Plancherel constants alone do not bound Mellin values at off-line zeros. A strip estimate needs an actual producer.
4. An assumed strip envelope or error estimate is acceptable in an internal generic helper but not at the final root. Bundling such estimates does not remove the excess hypotheses.
5. Raising the large-case threshold creates a coverage gap. The existing small-case route stops at 10^27; BinaryGoldbachInput alone does not extend that route automatically.

## Exact root types

The desired types are recorded as text only, not approved or frozen declarations:

```text
TernaryGoldbach.ternary_goldbach_large_of_hypotheses :
  TernaryGoldbach.TernaryGoldbachFrom (10 ^ 27)

TernaryGoldbach.ternary_goldbach_of_hypotheses
  (hBG : TernaryGoldbach.BinaryGoldbachInput) :
  TernaryGoldbach.Statement
```

Current roots: TernaryGoldbach/MainTheorems.lean:16-19 and 23-26. The requested change removes hGRH and retains hBG in the full theorem. Names may be decided at author approval.

Statement.lean:14-15 defines IsSumOfThreePrimes n as three natural prime witnesses p,q,r with p+q+r=n. Repeated primes are allowed. The public predicate imposes no oddness, distinctness, or additional size restriction on the witnesses.

Statement.lean:22-23 defines Statement as forall n : Nat, Odd n -> 5 < n -> IsSumOfThreePrimes n. Lines 34-35 define TernaryGoldbachFrom C with inclusive C <= n. Lines 26-27 and 64 expand BinaryGoldbachInput to forall m : Nat, Even m -> 4 <= m -> m <= 4*10^18 -> exists p q : Nat, p.Prime and q.Prime and p+q=m. Both binary endpoints are inclusive.

The proposed root types expand to:

```text
forall n : Nat, Odd n -> 10^27 <= n ->
  exists p q r : Nat, p.Prime /\ q.Prime /\ r.Prime /\ p+q+r=n

(forall m : Nat, Even m -> 4 <= m -> m <= 4*10^18 ->
  exists p q : Nat, p.Prime /\ q.Prime /\ p+q=m) ->
forall n : Nat, Odd n -> 5 < n ->
  exists p q r : Nat, p.Prime /\ q.Prime /\ r.Prime /\ p+q+r=n
```

### Expanded binder classification

The following is a source-fidelity comparison, not author approval or manifest validation.

| Large-case input | Bin | Source |
| --- | --- | --- |
| n : Nat | TYPING | Statement.lean:34-35 |
| Odd n | SOURCE | Statement.lean:35 |
| 10^27 <= n | SOURCE | MainTheorems.lean:17; Statement.lean:35 |

Counts: SOURCE 2, STANDING 0, TYPING 1, RULED 0, EXCESS 0.

| Full-root input | Bin | Source |
| --- | --- | --- |
| hBG, completely expanded above | SOURCE | MainTheorems.lean:23; Statement.lean:26-27,64 |
| n : Nat | TYPING | Statement.lean:22-23 |
| Odd n | SOURCE | Statement.lean:23 |
| 5 < n | SOURCE | Statement.lean:23 |

Counts: SOURCE 3, STANDING 0, TYPING 1, RULED 0, EXCESS 0.

For completeness, hBG's internal quantified domain has the following binders. These are inside the one external proposition, not additional outer assumptions:

| Internal hBG binder | Bin | Source |
| --- | --- | --- |
| m : Nat | TYPING | Statement.lean:27 |
| Even m | SOURCE | Statement.lean:27 |
| 4 <= m | SOURCE | Statement.lean:27 |
| m <= 4*10^18 | SOURCE | Statement.lean:27,64 |

Internal counts: SOURCE 3, STANDING 0, TYPING 1, RULED 0, EXCESS 0. Its conclusion has two existential natural prime witnesses and the sum equation.

Residual [Fact PlattGRH] would be EXCESS at either root. [Fact BinaryGoldbachInput] would be EXCESS at the large-case root. An unproved QRH, strip envelope, zero-count improvement, or major/minor-arc estimate would be EXCESS at either public root. The actual imported QRH theorem should be applied inside the proof.

### Definition checks

The direct predicates IsSumOfThreePrimes, IsSumOfTwoPrimes, Statement, BinaryGoldbachUpTo, TernaryGoldbachUpTo, and TernaryGoldbachFrom match their pinned source prose and Challenge.lean text:

BODY_MATCH: OK
PUBLIC_CARRIER: OK
WELL_DEFINEDNESS: N/A_LITERAL
CHARACTERIZATION: N/A_LITERAL
CHOICE_INDEPENDENCE: N/A
DEFINITION_VERDICT: Source text match only; manifest and compiled checks unavailable.

BinaryGoldbachInput is intentionally an external proposition, not a claim that the published computation has been formalized. It remains visibly conditional in the full result. PlattGRH must disappear from the final theorem's inputs and proof dependencies.

## Assembly and coverage

Helfgott/Main.lean:5 declares a file-level [Fact PlattGRH]. Lines 68-75 prove the current large-case result using repSum_lower_bound, nonprime_input, and final_inequality_crude.

Lines 77-80 explicitly omit [Fact PlattGRH] from the small-case theorem while retaining [Fact BinaryGoldbachInput]. Statement.lean:39-44 combines TernaryGoldbachUpTo C and TernaryGoldbachFrom C. Both include C, so C=10^27 gives overlap with no gap. Helfgott/Main.lean:93-94 performs the full assembly.

Final verification must compile one exact-type witness applying the new large-case theorem and the existing small-case result, with only hBG supplied externally.

## Review of zero_sum's generic estimate

The worker supplied this derivation directly. Let hp : PolyDatum f B kappa, S a finite subset of zerosRectD f T, T0 >= 0, x >= 1, K >= 0, a > 0. Every u in S must satisfy 0 <= Re(u) <= 1, Re(u) <= theta, and |Im(u)| <= T0. Assume ||M(u)|| <= K exp(-a|Im(u)|) for every u in S. Set

```text
h = 3.48
J = Jl T0 = floor(T0/h) + 1
Z = log(B(T0+h)/0.355) / log(10/2.7).
```

Then the proposed bound is

```text
||sum_(u in S) multRectD(f,T,u) * M(u) * x^u||
 <= x^theta * 2*K*Z * (1-exp(-a*h*J))/(1-exp(-a*h)).
```

Independent derivation:

1. Use floor bins j <= Im(u)/h < j+1 for j=-J,...,J-1. ZeroSumBound.lean:289-294 gives T0<Jh. All zeros have exactly one bin, including integer T0/h and Im(u)=0.
2. Its center is c=(j+1/2)h. Squared distance from u to 2+ic is at most 4+1.74^2=7.0276<2.7^2. ZeroSumGen.lean:60-75 bounds each bin's total original multiplicity.
3. For a nonempty bin |c|<=T0+h/2<=T0+h. PolyDatum.B_mono upgrades its bound to Z. Empty bins satisfy the same bound since Z>0 follows from PolyDatum.log_pos and log_ratio_pos.
4. The positive bin j=k and negative bin j=-k-1, k=0,...,J-1, satisfy |Im(u)|>=kh. Each therefore contributes at most K exp(-ahk) times its multiplicity count. Im(u)=0 belongs only to j=0. The factor 2 comes from two bins, with no conjugation symmetry assumption.
5. norm_cpow_x and x>=1 give ||x^u||=x^Re(u)<=x^theta. Natural multiplicities are nonnegative. The finite geometric sum gives the formula, with denominator positive because a,h>0.

Verdict: mathematically valid under the stated explicit assumptions; CONDITIONAL internal helper. No Lean proof was inspected or compiled. The looser 2*J*K*Z*x^theta bound also follows.

Datum.lean:81-86 defines zerosRectD with a strictly interior rectangle filter, and multRectD as a natural cast of its divisor. Using S subset zerosRectD and sum_multRectD_le preserves both zero multiplicities and rectangle boundaries. No simple-zero assumption is permitted.

For the concrete transform Gr s delta 0, ZeroSumBound.lean:39-41 states the existing unconditional envelope with K=112 and a=thetaD delta on -1<=Re(s)<=1; line 21 proves a>0. That supplies a candidate producer for this particular transform. It does not identify or bound every other downstream smoothing.

The finite low-zero estimate does not control the omitted origin/high-zero pieces or justify an infinite limit. The original split is at ZeroSumGen.lean:227-228; the exact good-height finite-sum limit interface is Datum.lean:591-595. Keep both other pieces until separately proved, and justify the limit using an estimate uniform in the outer rectangle height. If QRH bounds every nontrivial zero at every height, it may also replace the tail x factor by x^(7/8), but that is another proof obligation.

## Minimal rigorous next target

First prove and compile the radius-2.7 strip-window count, preserving the exact finite zero set, multRectD, and floor index from count_line_windowG. Replace its Re(u)=1/2 premise by 0<=Re(u)<=1 and its denominator by log(10/2.7). This statement needs neither QRH nor an assumed Mellin estimate.

Next prove the finite geometric bound and instantiate it using an actual checked QRH-to-zero-strip theorem plus norm_G_uniform. Then handle every relevant smoothing, the origin and tails, and the good-height limit before recomputing the final numerical inequalities.

At x=4.9e26, x^(7/8)/sqrt(x)=x^(3/8) is approximately 1.0205e10, and x^(-1/8) is approximately 0.00046103. These JavaScript floating-point scale checks neither certify the analytic constants nor prove that the approach fails. The coefficient and all downstream consumers determine whether the existing 0.0114 margin survives.

## Required closure evidence

The exact approved successor roots still need compiled exact-type witnesses, term-level composition supplying all premises, and #print axioms. Inspect new project predicates and instances for hidden assumptions. Verify the imported QRH theorem's pinned version and axiom closure. Preserve natural-number carriers, witness scope, fixed constants, inclusive cutoffs, and BinaryGoldbachInput.

No new proof or root closure is claimed by this report.

