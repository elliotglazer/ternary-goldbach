# Base-gap hybrid: pointwise eta2 input from Type I/II

Research only, 2026-11-10. Pinned source: `calr3/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Paths below are under `work/ternary-goldbach/TernaryGoldbach`. No Lean implementation or compilation in this round.

The existing first-choice Type I/II bounds supply a usable algebraic pointwise input for a hybrid treatment of the base gap. They apply inside the arcs as well as outside: their hypotheses concern a rational approximation to **2 alpha**, not membership in a minor-arc set. They currently carry `Fact PlattGRH` through separate prime and Möbius inputs. This note does not call the source theorem unconditional. The algebraic assembly itself needs only the displayed Type I/II inequalities; a future no-Platt theorem requires those separate inputs to be proved without Platt.

The relevant target is the **actual consumer allowance** `ghatY(y,150000)` from `MinorArcs/LinftyLevels.lean:351`, approximately .06027 at y=1e25 (the exact allowance and its uniform lower bounds are being handled by the major-constants worker). Reproducing the old `.0121*y` base-gap surrogate is not necessary. Numerical comparisons below distinguish this larger allowance from that stronger old theorem.

## 1. Exact rational-approximation interface

`MinorArcs/TypeI.lean:60` defines

```lean
def Approx2 (α x δ : ℝ) (a : ℤ) (q : ℕ) (Q₀ : ℝ) : Prop :=
  1 ≤ q ∧ IsCoprime a (q : ℤ) ∧
  (∃ k : ℤ, 2 * α = a / q + δ / x + k) ∧
  |δ / x| ≤ 1 / (q * Q₀) ∧ (q : ℝ) ≤ Q₀
```

`PointwiseBound.theorem_3_1_1` requires x≥2.16e20 and Q0=(3/4)x^(2/3). Its first branch requires q≤x^(1/3)/6; the second branch is irrelevant in the main large-q range considered here because y≥1e25 and q≤150000, whereas y^(1/3)/6≈35907244.8.

For the base gap put x_original=49y and write alpha=a0/q0+delta/y using the arc center. To feed `Approx2`, reduce 2a0/q0:

- if q0 is odd, q=q0, a=2a0;
- if q0 is even, q=q0/2, a=a0;
- in both cases Delta=2delta, and 2alpha=a/q+Delta/y exactly (hence the integer k may be zero).

Coprimality follows from gcd(a0,q0)=1 and the parity split. Do not feed the unreduced denominator to the theorem.

The parity-specific inequalities in the proof of `BaseGap2.gap_point` (line185) are stronger than its final, deliberately weakened common statement. Retain those stronger inequalities when constructing this new interface:

- odd q0≤150000: 600000/(49q0)≤|delta|<600000/q0;
- even q0≤300000: 1200000/(49q0)≤|delta|<1200000/q0.

After reduction both give the same exact interval

1≤q≤150000, and 1200000/49 ≤ u:=|Delta|q <1200000.       (1)

Thus, at scale y, with d=max(2,|Delta|/4) and t=dq,

t=max(2q,u/4),
max(2q,300000/49)≤t≤300000.                            (2)

For q≥10000 the minimum t is simply2q. The endpoints u=1200000 and t=300000 may safely be included for upper-bound estimates; the original arc upper inequality is strict.

The approximation-error condition at scale y is equivalent to

u≤(4/3)y^(1/3).

It holds with substantial room by (1): at y=1e25 the right side is approximately2.87257959e8. Thus these are valid rational approximations for the pointwise theorem even though they come from the base gap.

## 2. Exact rescaling for Mellin convolution

At z=wy with w>0 the same alpha and reduced rational center satisfy

2alpha=a/q+(w Delta)/(wy),
d_w=max(2,w|Delta|/4),
t_w=d_w q=max(2q,wu/4).

The explicit sufficient hypotheses for the first-choice pointwise bound are

1. z=wy≥2.16e20;
2. q≤z^(1/3)/6;
3. u≤(4/3)y^(1/3)w^(-2/3).

The third is the exact scale-dependent approximation-error constraint; treating Delta as unchanged at the new scale is wrong. Once 1 and2 hold, q≤(3/4)z^(2/3) follows directly. `EtaStarBound.Approx2.rescale` and `theorem_3_1_1_scaled` implement precisely this scaling convention.

At y=1e25, the first condition is w≥.0000216. This also implies condition2 for every q≤150000, since (6*150000)^3=7.29e17<2.16e20. Using the worst permitted u<1200000, condition3 holds for every w≤(4*y^(1/3)/(3*1200000))^(3/2), approximately3703.7037. More generally the lower and upper cutoffs are explicit functions of y and the actual u, not assumptions of a Mellin identity. Outside the valid window use a separately proved trivial/smoothing bound; the Mellin worker owns this integration step.

## 3. A sharper algebraic consumer before the final AM–GM simplification

Set z=wy, T=z^(1/3), d=d_w, t=dq, and

C(z,t)=log(1+log(4t)/(2log(9z^(1/3)/(2.004t)))).

All square-root and logarithm arguments below are positive: the first-choice hypotheses imply2≤t≤T/3 (`FirstChoiceTypeII.first_choice_t`, line306). In particular C≥0.

At U=floor(T²/(9sqrt t)) and V=floor(9T/2), use these exact source results:

- `FirstChoiceTypeI1.typeI1_first` (line227):
  |I1|/z≤7.6/(d phi(q)) +2(log t+2.96)/t +.014z^(-1/6).
- `FirstChoiceTypeI2c.typeI2_first` (line16):
  |I2|/z≤2.5257/sqrt t +5.6/(d phi(q)) +2(15.267log t+21.46)/t +.556z^(-1/6).
- `FirstChoiceTypeII.typeII_first` (line329):
  |II|/z≤sqrt(C(z,t)(log t+.002)+log(4t)/2)*sqrt(.30214log t+.7468)/sqrt(d phi(q)) +3.2z^(-1/6).
- `Assembly.norm_S_le_parts` (line64):
  |S_eta2(alpha,z)|≤|I1|+|I2|+|II|+3log z.

The assembly lemma itself is unconditional. Summing these inequalities gives the following exact algebraic consumer, with **no need for the final AM–GM step**:

B_raw(z,q,t) =
  sqrt(C(z,t)(log t+.002)+log(4t)/2)*sqrt(.30214log t+.7468)/sqrt((t/q)phi(q))
  +2.5257/sqrt t
  +13.2/((t/q)phi(q))
  +2(16.267log t+24.42)/t
  +3.77z^(-1/6)
  +3log z/z.

Then |S_eta2(alpha,z)|≤z B_raw(z,q,t).

This implication is a proved-paper algebraic sum of the three source bounds and the unconditional decomposition. No coefficient was estimated numerically in deriving it:13.2=7.6+5.6,16.267=1+15.267,24.42=2.96+21.46,3.77=.014+.556+3.2. A future Lean consumer can take the three inequalities as internal proof arguments; they must later be supplied by the actual no-Platt prime/Möbius work, not left as new assumptions on the final Goldbach theorem.

The existing published first-choice bound gives the alternative

B_final(z,q,t) = [( .27125C(z,t)+.41415 )log t+.8764]/sqrt((t/q)phi(q))
 +2.526/sqrt t
 +2/t*[q/phi(q)*(3.25log t+7.82)+13.66log t+37.55]
 +3.8z^(-1/6).

It is already the exact conclusion of `PointwiseBound.theorem_3_1_1`, first branch. The raw formula is often a few percent better at these parameters and is the preferred Mellin input. Neither formula is presently an unconditional source theorem.

## 4. Numerical diagnostics at y=1e25, w=1

The script `agents/moebius/base_gap_typeii_numeric.py` uses ordinary floating-point logarithms and roots and exact integer totients. It is a reproducible numerical diagnostic, not interval arithmetic or a Lean certificate.

At the smallest admissible t=2q for the requested q range:

| q | phi(q) | B_final | B_raw | raw Type II main term alone |
|---:|---:|---:|---:|---:|
|10000|4000|.113701060|.106044653|.067726407|
|20000|8000|.079498656|.075486331|.051936211|
|30000|8000|.076892790|.072578516|.054405837|
|50000|20000|.050938277|.049259248|.036451421|
|75000|20000|.049965076|.048154775|.038135979|
|100000|40000|.036995729|.036136524|.027837278|
|120000|32000|.040410011|.039254890|.031753379|
|150000|40000|.036601383|.035667711|.029104108|

At the upper endpoint t=300000, denominators with q/phi(q)=2.5 (the listed10000,20000,50000,100000) all give B_final≈.030852565 and B_raw≈.030272008. Those with ratio3.75 (the listed30000,75000,120000,150000) give.036601383 and.035667711 respectively. Keeping actual u, rather than replacing t by its minimum, can therefore materially improve the bound for smaller q when the arc offset is large.

A suffix scan over every actual integer q in the indicated range, at t=2q, gives:

| q range | worst sampled q | phi(q) | max B_raw at w=1 | multiplied by sqrt(pi/2) |
|---|---:|---:|---:|---:|
|[10000,150000]|10080|2304|.128649277|.161237958|
|[20000,150000]|20790|4320|.094659752|.118638406|
|[30000,150000]|30030|5760|.082607314|.103532915|
|[50000,150000]|51870|10368|.063663503|.079790368|
|[75000,150000]|78540|15360|.053587669|.067162183|
|[100000,150000]|101010|20736|.047109261|.059042703|
|[120000,150000]|120120|23040|.045003221|.056403173|
|[140000,150000]|140910|28800|.040931368|.051299862|

The last column is **not a Mellin integral bound**. It is a scale-frozen diagnostic using the Gaussian mass sqrt(pi/2). The actual bound must integrate B_raw(wy,q,t_w) with the correct weight, include the small/large-w tails, and control all y≥1e25. No monotonicity in t or y has been certified by this script. Its limited t-sampling found the maximum at t=2q for the displayed q, but that is only a clue for the analytic bound.

These values suggest a hybrid split with the direct Type I/II bound for sufficiently large reduced denominators, around1e5 or somewhat larger, and an analytic character bound below that cutoff. The threshold must be chosen after rigorous Mellin integration against the actual allowance ghatY(y,150000). Near q=1e5 the frozen-scale margin is small; q≥120000 or140000 provides more room at y=1e25. This conclusion is numerical guidance, not an established uniform threshold.

## 5. Totient treatment for a finite denominator interval

The exact formula preserves phi(q), so the analytic theorem need not replace q/phi(q) by a global asymptotic bound in its main term. The finite q range permits better certificates than a generic Mertens estimate.

For q≤150000, q has at most six distinct prime factors, since2*3*5*7*11*13*17=510510>150000. The product formula therefore gives

q/phi(q)≤product_(p=2,3,5,7,11,13) p/(p-1)=1001/192≈5.213541667,

hence phi(q)≥(192/1001)q. This elementary finite-range proof can use `Prelim.div_totient_eq_prod`; it requires no prime-number estimate or Platt assumption. Using the still weaker phi(q)≥3q/16 is also valid. However either uniform ratio loses useful information; a checked table or primorial interval proof for the actual denominator blocks is preferable near the final cutoff.

This finite main-term simplification does not by itself remove the existing use of `Prelim.div_totient_lt` inside `typeII_rest_le`, which bounded its lower-order terms by3.2z^(5/6). That source proof uses a bound at radiusT. One can either retain the separate product/totient replacement obligation, as the campaign currently does, or rework those lower-order estimates with the finite-range ratio. The3.2 coefficient must not be assumed unchanged after such a rework until its inequalities are checked.

## 6. Remaining analytic inputs behind the source Type I/II statements

The purpose of this section is to keep the hybrid estimate from concealing Platt. The source files explicitly retain `Fact PlattGRH`. To obtain their displayed constants with no Platt, these branches still need unconditional replacements (or new constants with a fresh end-to-end calculation):

1. **Möbius/Type I.** `Prelim.abs_sum_moebius_div_coprime_le_log` supplies2.8*(q/phi(q))/log(x/q) for q≥1 and q<x. It enters `TypeITotal.muBound` and `typeI2_mu_first`. The unconditional bound by1 and logarithm-weighted Möbius identities are separate elementary inputs. The proposed .10 m-profile/G2 work is documented in `BLUEPRINT_MINOR_FINITE.md`.
2. **Möbius/Type II.** `TypeIIS1.T2_le` uses T2(S)≤.37273 for S≥16, through the G2/Möbius profile branch. Keep this constant or recompute the factors downstream. Finite T2 and H2 data alone do not prove the unbounded range.
3. **Prime first moments.** `LambdaMu.sum_vonMangoldt_lt`: psi(y)<1.03883y for y>0; `sum_vonMangoldt_le_a14`: psi(y)≤1.0064y for y≥2.5e7; `sum_vonMangoldt_mul_lt_a17`: sum_(n≤y) Lambda(n)n<1.022y²/2 for y≥2.5e7. `TypeI2Proof`, `TypeI2Large`, and `TypeI2Sum` call these. The first-choice V=floor(9T/2) is at least2.7e7 in the theorem's full range, approximately9.6949561e8 at z=1e25. Their exact role is not replaced by the coarse1.4 bound proved for EBound.
4. **Prime harmonic moments.** `sum_vonMangoldt_div_le_log`: sum Lambda(n)/n≤log y for y≥1, and `log_sub_le_sum_vonMangoldt_div`: the same sum≥log y-log(3/sqrt2). These enter `GcdSums`, `TypeI2Proof`, and `TypeI2Large`; both are conditional source declarations.
5. **Prime powers in Type II.** `TypeIIReduction.lean:332`, `norm_IIsum_le`, uses P(W)≤1.4262sqrt W via `sum_vonMangoldt_nonprime_lt` (see lines329–388). This feeds the3.2 lower-order coefficient of `typeII_first`. The separate EBound paper proof establishes1.5 only on a large range; it is not an automatic substitute preserving3.2 or the full Type II range.
6. **Totient ratio.** `FirstChoiceTypeII.typeII_rest_le` invokes `Prelim.div_totient_lt` (line153). The main-term finite-q ratio can be proved elementarily as above, but the current lower-order source proof still needs its existing ratio estimate or a rechecked specialized version.

7. **Prime logarithmic squares in Type II.** `LambdaMu.sum_log_sq_primes_le` (line1884) gives the sum of `(log p)^2` over primes with `floor(y/2)<p<=floor(y)` at most `.5*y*log y` for `y>=2e6`. Its direct consumer is `TypeIITotal.logSqSum_le_half` (line35), then `pointwise637` and `pointwise_gen'`. Integration identified this additional interface; the prime-estimates blueprint already treats it.

The harmonic squarefree sums and zeta(3/2) constants used by Type II have their own existing source proofs; the zeta_three_halves_le / zeta3_le step in `FirstChoice.lean` is elementary and does not use a finite-RH verification. `Assembly.norm_S_le_parts` also has no Platt hypothesis. Nevertheless the seven listed analytic branches prevent calling the present pointwise result unconditional.

## 7. Handoff for the hybrid proof

The Mellin worker should consume the exact pair

z=wy, t=max(2q,wu/4), |S_eta2(alpha,z)|≤z B_raw(z,q,t),

with1≤q≤150000,1200000/49≤u≤1200000 and the validity window of section2. It must integrate the **actual** phi(q) dependence or a rigorously bounded finite block, rather than sampling a prime denominator or replacing the 2alpha denominator by the original alpha denominator.

The major-constants worker supplies a proved allowable coefficient from ghatY(y,150000), including its y-dependence. At y=1e25, the value around.06027 makes the large-q route plausible even though it cannot reproduce the old.0121 surrogate. A weaker uniform lower bound such as.0404 need not settle the y=1e25 comparison: both allowance and pointwise envelope vary with y, and they should be compared on the same scale.

A successful hybrid proof must therefore certify: the parity-aware conversion (1), the Mellin validity window and tails, a uniform comparison between its integrated envelope and the actual allowance, the complementary small-q character estimate, and the separate no-Platt Type I/II inputs enumerated above. The note provides the exact algebraic pointwise envelope and reproducible finite-q diagnostics; those remaining analytic and integration steps are not claimed complete.


