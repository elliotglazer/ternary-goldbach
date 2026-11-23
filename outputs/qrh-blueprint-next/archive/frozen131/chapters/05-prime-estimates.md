# Prime estimates: research blueprint for removing PlattGRH

This chapter concerns the q = 1 prime-estimate dependencies of the original
Goldbach proof at source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.
The final threshold remains **10^27**, and the original `BinaryGoldbachInput`
is unchanged. This is a research plan, not a new theorem specification or a
claim that the original goal has been proved. In particular, no larger final
threshold, extra analytic hypothesis, or replacement binary input is proposed.

The strongest concrete progress in this branch is a source-audited, uncompiled
local fixed-gap argument covering the original psi targets from exp(20000)
onwards. It leaves genuine finite and intermediate analytic work. The two
main branches below are distinct: pointwise psi/theta estimates used by the
minor arcs and Mobius induction, and the weighted Mertens/product estimates.
A solution to the first branch need not be the cheapest solution to the second.
The principal major-arc kernel is treated in the Mellin chapter, not here.

## 1. Existing unconditional material to reuse

Source paths in this chapter are relative to `work/ternary-goldbach/TernaryGoldbach`.
Scratch paths are relative to `work/qrh-campaign/agents`.

| Existing source interface | Actual content | Role |
|---|---|---|
| `Prelim/SmallPsiTableMain.lean` via `SmallTab.small_table` | For 12 <= t < 10^6, the finite table gives the small psi and theta bounds used in `PsiTwoSided:79,95`. In particular abs(psi(n)-n) <= sqrt(n), and n-2.3662 sqrt(n) <= theta(n) <= n. | Do not import the conditional full-range wrapper for a finite use. |
| `Prelim/PsiSieveMain.lean:28160`, `sieve_table3` | For 10^6 <= t < 10^9, theta(t) <= t+0.1 sqrt(t) and t-theta(t) <= 2 sqrt(t). | Its full range is 10^9; the 5e7 range in nearby consumer comments is only a restriction. |
| `Prelim/SmallPsi700`, `Small.psi_lt_small_700` | psi(n) < 1.03883 n for 1 <= n <= 700. | Combined with the preceding small psi estimate, supplies the same linear bound below 10^6. |
| `Helfgott/Chebyshev.lean:24`, `theta_le` | theta(N) <= N log(4), all N. | Coarse domination and prime-power tails. |
| `Helfgott/Chebyshev.lean:207`, `psi_le` | psi(N) <= 1.387 N, but only for N >= 10^27. | Do not silently use at smaller arguments inside an integral or Type I sum. |
| `Explicit/PsiSandwich.lean:34,90`, `psi_le_four`, `psiR_le` | psi(N) <= 4N; psiR(y) <= 4y for y >= 0. | Unconditional all-range domination; much too weak for the existing sharp numerical consumers. |
| `Prelim/LambdaMu.lean:548,589`, `nonprime_final`, `nonprime_sum_le4` | Elementary prime-power bounds; their precise domains must be retained. | The global 1.4262 bound can be rebuilt by finite and large branches rather than inherit a global psi premise unnecessarily. |
| `Prelim/PNTMertens` | Definitions, convergence, and the E1/E2 integral identity. | The analytic conversion from an explicit E1 variation bound to a product estimate already exists. |
| `Explicit/XiPartial`, `ZeroFree`, `ZeroFreeRegion` | Zero counting, partial fraction approximation, and explicit zero-free inequalities. | Local fixed-gap and weighted-zero routes below. |

The finite cleanup is already drafted by the Mobius worker:
`moebius/FinitePsiCore.lean` and `FiniteBoundary.lean`. It preserves
`psi_le_two` on **12 <= n < 10^9** and `bTerm_le` on **12 <= Y < 10^9**.
The global calls inside `nonprime_mid` only use psi below 10^6 when N < 10^12;
replace those calls by their finite versions. These are uncompiled drafts,
not newly established library results. See `moebius/BLUEPRINT_MINOR_FINITE.md`.

## 2. Pointwise psi and theta contracts in the production proof

`Explicit/PsiRanges1e8.lean` proves 22 finite intervals by an explicit formula
whose low zeros are placed on Re(s)=1/2 using `rh_upto_1e8`. They are not
finite prime-sieve certificates merely because their x ranges are finite.
Each row below is `psi_range8_i`, with inclusive endpoints, and conclusion
abs(psiR(x)-x) <= c sqrt(x). The row starts at line 20+53*i.

| i | x interval | c, exact |
|---|---|---|
|0|[10^6,3.2e6]|821/25|
|1|[3.2e6,10^7]|797/25|
|2|[10^7,3.2e7]|787/25|
|3|[3.2e7,10^8]|627/20|
|4|[10^8,3.2e8]|1583/50|
|5|[3.2e8,10^9]|804/25|
|6|[10^9,3.2e9]|1653/50|
|7|[3.2e9,10^10]|341/10|
|8|[10^10,3.2e10]|886/25|
|9|[3.2e10,10^11]|1847/50|
|10|[10^11,3.2e11]|968/25|
|11|[3.2e11,10^12]|4061/100|
|12|[10^12,3.2e12]|2141/50|
|13|[3.2e12,10^13]|1127/25|
|14|[10^13,3.2e13]|2379/50|
|15|[3.2e13,10^14]|5027/100|
|16|[10^14,3.2e14]|5489/100|
|17|[3.2e14,10^15]|3069/50|
|18|[10^15,3.2e15]|733/10|
|19|[3.2e15,10^16]|377/4|
|20|[10^16,3.2e16]|265/2|
|21|[3.2e16,10^17]|199|

`psi_mid8:1188` packages these with `cW8`. `Prelim/PsiTwoSided.lean:79`,
`psi_two_sided`, combines them with the small table into
abs(sum_{1<=m<=n} Lambda(m)-n) <= cB(n)sqrt(n), 12 <= n <= 10^17.
Useful downstream constants are cB <= 33 through 10^8, <= 35.5 through
3.2e10, <= 72 through 10^15, and <= 200 globally; the sharper 42.82 and
45.08 interval bounds are also used. These constants are ordinary numeric
facts about cB; it is the psi comparison that needs replacement.

| Existing theorem | Exact main range and conclusion | Status of replacement |
|---|---|---|
| `Explicit/PsiPlateau1e8.lean:120`, `psi_plateau8` | x >= 10^17: abs(psiR(x)-x) <= 4.91e-7 x + 1145 sqrt(x) + 4.2e10 | Open in the moderate range. |
| `Explicit/PsiRange1.lean:415`, `psi_range1_err8` | x >= exp(20000), with its exact a,b smoothing hypotheses: error <= 14990 sqrt(x)+7.61e-15 x+1e-17 x+1.82e12 | Complete local fixed-gap draft; uncompiled. |
| `Explicit/PsiRange1.lean:451`, `psi_range1_8` | x >= exp(20000): abs(psiR(x)-x) <= 2.1e-14 x | Same draft route. |
| `Explicit/PsiAsymp.lean:632`, `psi_asymp8` | x >= exp(35000): abs(psiR(x)-x) <= .2 x/log(x)^3 | Same draft route. |
| `Prelim/ThetaExplicit.lean:178`, `psi_sub_theta_le_cB` | 10^9 <= N <= 10^19: psi(N)-theta(N) <= sqrt(N)(1.036+.049 log N) | Open where it calls conditional small-argument theta estimates; audit each root argument before demanding the full psi range. |
| `ThetaExplicit:387`, `theta_mid` | 10^12 <= n <= 10^17: abs(theta(n)-n) < n/log(n)^3 | Open except any portions replaced by finite certificates. |
| `ThetaExplicit:512`, `theta_explicit` | n >= 10^12: abs(theta(n)-n) < n/log(n)^3+epl(n)n | Full result still open. |

Here `epl(x)=4.92e-7` exactly when 120 < log(x) < 20000, and zero otherwise.
The production theta proof uses finite psi below 10^17, the plateau above
10^17 with separate log(x)<=120 and 120<log(x)<20000 branches, range1 on
[20000,35000), and the asymptotic result from 35000. The fixed-gap drafts
therefore make the whole log(x)>=20000 part available in principle, while
leaving the original domain n>=10^12 unchanged and unresolved below that point.

## 3. Local fixed-gap route: a concrete tail replacement

The following are existing scratch proof scripts, source-reviewed but not
claimed kernel-validated here:

1. `zero-sum/ZetaLowUnconditional.lean`,
   `abs_im_ge_of_nontrivial_zero`: every nontrivial zeta zero has abs(Im)>=2.39.
2. `zero-sum/ZeroFreeFixedGap.lean:227`, `zeta_zero_re_le_fixed`:
   if zeta(rho)=0, 0<Re(rho)<1, and abs(Im(rho))<=10^8, then
   Re(rho)<=249/250. This uses local explicit zero-free primitives and the
   preceding low-height exclusion; no OAI provider is needed.
3. `zero-sum/ZeroSumStrip.lean:122`, `sum_mult_zeta_low_sharp_le`:
   for the actual finite zero subset of `zerosRectD zetaF T`, with the original
   `multRectD` multiplicities, the low-zero count is <=3e10. The argument uses
   Jl(10^8)<=3e7, a window count <=401, and hence 2.406e10<=3e10.
4. `prime-estimates/PsiFixedAux.lean:14`, `norm_Mg_im_le`:
   norm(Mg(a,b,delta,rho))*abs(Im rho) <= 2 exp(delta^2/2+abs(a))
   for b<=0 and 0<Re(rho)<1. If delta^2/2+abs(a)<=1e-6, the preceding
   2.39 lower bound implies norm(Mg)<=1. No lower real-part gap is needed.
5. `PsiFixedTightFormula.lean:12,131`, `SsumG_gsm_err_fixed_tight` and
   `tsum_gsm_le_fixed_tight`, replace only the low-zero contribution by
   **3e10*x^(249/250)**. The original middle bins, Gaussian tail and left
   contour remain. The proof uses the actual zero carrier, natural
   multiplicities, zeta-zero classification, and the explicit-formula limit;
   it does not assume a new error estimate as a hypothesis.

Writing L=log(x), the relative low error is 3e10 exp(-L/250).
`PsiFixedTightNumeric.lean` proves in draft that it is <=6e-25 for L>=20000.
At the range1 parameters delta=1.4e-15, Gamma=6.43e15 and
abs(a)<=1.26e-14, the existing unconditional estimates give:

| term | bound |
|---|---|
|low zeros|6e-25 x|
|first middle bin|1e-20 x|
|other middle bins|7.6e-15 x|
|tail|1e-17 x|
|left contour|1.82e12|

The unused allowance 7.61e-15-7.6e-15 exceeds 1e-20+6e-25.
`PsiRange1Fixed.lean` then invokes the existing unconditional
`psi_range1_of:345` to obtain the original 2.1e-14 result.
For L>=35000, `PsiFixedNumeric.lean` supplies the coarser absorption
1e24*x^(249/250) <=5e-5*x/L^3; the exact Taylor-degree-50 integer check has
margin factor about 7.764. `QrhPsiMid.lean` supplies the other 5e-5 allowance,
and `PsiAsympFixedTight.lean` uses the original `psi_asymp_of:335`.
The old 7/8 and 23/24 QRH drafts are alternatives, not required dependencies
of this local route.

Eventual integration should keep **one** tight explicit-formula proof upstream
of both `PsiRange1` and `PsiAsymp`. It imports `PsiLarge`, `PsiFixedAux`, the
local zero-gap and count helpers, not either final consumer. The final
wrappers stay in their original files, preserving names and callers. Importing
the complete scratch `PsiFixed` from `PsiAsymp` would create a cycle and is
not the integration plan. See `RANGE1_FIXED.md` for the detailed order.

## 4. Why the moderate range is not solved by this argument

The fixed-gap relative bound at the major-arc scale x=4.9e26,
L approximately 61.45645, is about **2.346e10**. It says nothing useful there.
Even a future improvement of the low coefficient from 3e10 to 10^4 would
leave fixed-gap decay far too slow. For orientation only, floating-point
crossovers of C exp(-a L)<=epsilon are:

| gap a | C | L for epsilon=1e-9 | L for epsilon=4.91e-7 |
|---|---|---|---|
|1/250|3e10|11211.94|9662.83|
|1/8|3e10|358.79|309.22|
|1/8|1e4|239.47|189.90|

These are diagnostic values, not certified replacement thresholds. Middle
and tail terms still have to fit the same total allowance. In particular,
coefficient improvement may extend the plateau overlap but does not bridge
all the way to 10^17, let alone the psi tables from 10^9.

At x=4.9e26, a bare C*x^(7/8) estimate would need C about .001065 or less
to supply a relative 4.91e-7 budget by itself. Thus uniform QRH zero-freeness
cannot simply be substituted for the existing RH-below-height call in an
absolute zero-sum estimate. This is a limitation of the proposed estimate,
not a proof that QRH logically fails to imply a suitable theorem.

Plausible research routes, with explicit tests before formalization:

* **Finite certificates plus a genuine explicit PNT envelope.** Extend the
  current finite sieve only to an affordable overlap point. Use blockwise
  rational bounds for theta/psi with monotonic interpolation, not evaluation
  at every real x. A finite interval [A,B] is certified if the endpoint
  inequalities and interpolation allowance fit the required c sqrt(x) or
  x/log^3(x) envelope throughout. Direct sieving to 10^17 is not presently a
  feasible agreed plan. The analytic upper range must therefore be made
  quantitatively effective well below that endpoint, or the consumers must
  be rederived from weaker input.
* **Explicit low-zero localization plus zero-free/density estimates.** A
  kernel-checked enclosure and completeness argument for a finite set of
  zeros could replace the strongest low-frequency contributions without
  assuming PlattGRH. This is new finite analytic verification, not permission
  to introduce RHBelow as an axiom or silently reuse an external verified
  height. Determine a modest sufficient height from the weighted transform
  and error budget first. Above it use QRH or local zero-free/density bounds.
* **Retain signed zero information.** Absolute summation discards both
  conjugation and functional-equation pairing. A signed or quadratic
  estimate can be far better for a weighted consumer, but a uniform
  pointwise psi bound still needs its own explicit proof. The Mellin
  principal-kernel result cannot automatically be reused as theta_explicit.
* **Reprove exported minor-arc estimates directly.** Many consumers need a
  one-sided linear or weighted Lambda sum, not theta_explicit itself.
  Elementary identities and finite certificates may establish these with
  their present slack (1.0064 and 1.022) even if the full pointwise contract
  is expensive. Every revised constant must be propagated through the
  original minor-arc budget at 10^27 before acceptance.

Published explicit PNT estimates require a dependency audit: a statement
phrased under QRH may also use a finite RH verification in its proof of a
moderate interval. No such published constant is accepted as a substitute
in this chapter.

## 5. Exported Lambda estimates that must ultimately be justified

These are distinct production obligations in `Prelim/LambdaMu.lean`.
All sums use the exact floor endpoints shown; strict inequalities matter.
The present proofs depend on the pointwise contracts or finite wrappers
above. They may be replaced directly rather than reconstruct every internal
lemma, provided all original consumers remain proved.

| declaration and line | exact numerical contract |
|---|---|
|`sum_vonMangoldt_lt:337`|for y>0, sum_{1<=n<=floor y} Lambda(n) <1.03883 y|
|`sum_vonMangoldt_div_le_log:535`|for x>=1, sum Lambda(n)/n <=log x|
|`sum_vonMangoldt_nonprime_lt:761`|for y>0, sum over nonprime n<=floor y of Lambda(n) <1.4262 sqrt(y)|
|`log_sub_le_sum_vonMangoldt_div:1170`|for x>=1, log x-log(3/sqrt2) <=sum Lambda(n)/n|
|`sum_vonMangoldt_mul_lt_a17:1362`|for y>=2.5e7, sum n Lambda(n) <1.022 y^2/2|
|`sum_vonMangoldt_le_a14:1375`|for y>=2.5e7, sum Lambda(n) <=1.0064 y|
|`sum_log_sq_primes_le:1884`|for y>=2e6, sum over primes floor(y/2)<p<=floor(y) of log(p)^2 <=y log(y)/2|

Direct consumers include `MinorArcs/EBound`, `GcdSums`, `TypeI2Proof`,
`TypeI2Large`, `TypeI2Sum`, `TypeIIReduction`, and `TypeIITotal`.
Internal affected families include `psi_bounds`, `psiN_le`, `psi_upper_of`,
`psi_lower3`, `mertens_lower_nat`, `psi_lower_big`, `psi_mul_a17`,
`thetaN_large`, `thetaN_close`, `thetaN_ge_cB`, `thetaN_close_cB`,
`thetaN_ge_cB'`, and `logsq_r1/r2/r3/large/ge`. This list identifies proof
routes; it does not certify an exhaustive transitive final-root audit.

For the Mobius induction, `SchoenfeldJ.rho_le:34` uses the additive envelope
2 sqrt(v) + 1[v>=1e9]35.5 sqrt(v) + 1[v>=32000000001]72 sqrt(v)
+ 1[v>=1e12]v(1/log^3(v)+4.92e-7+1.4262/sqrt(v)).
Only one term is needed in each branch, so there is some unused additive
slack. The full theorem starts at v>=12; the finite repair covers v<1e9.
`SchoenfeldTailAux.rho_C5:186` additionally needs
abs(psi(v)-v)<=.00985 v/log(v) for every v>=1e12, and the tail separately
uses `sum_Lambda_div_Ioc`. A tail-only asymptotic result leaves the cell
induction unproved. The Mobius chapter gives the exact regenerated-profile
criterion and the possible .10/log(x) target; no new profile is assumed here.

## 6. Mertens product and totient branch

Put E1(x)=sum_{n<=x}Lambda(n)/n-log x and use the source definition of E2.
The existing unconditional `MertensProduct.E2_le_of:36` turns a uniform
variation bound abs(E1(t)-c)<=D for t>=x into abs(E2(x))<=2D/log x.
The problem is supplying D with the required small constant.

Current conditional steps in `Prelim/MertensProduct.lean` are:

* `psi_err:69`: for n>=1e12, abs(psiN(n)-n)<=n/log^3 n+epl(n)n+7.04 sqrt(n).
* `E1_core:124`, `E1_local:262`, and `E1_diff:224`. The last has log(M)>=20000
  and bounds the E1 difference by
  3/M +2(1/log^3 M+7.04/sqrt M)+2/log^2 M+14.08/sqrt M.
* **Independent direct RH use:** `E1_win_num:531` invokes `rh_upto_1e8` at
  line 545, with smoothing a=2,b=0,delta=8e-8. For x>=1e12, Y>=x and
  log(Y/x)<=20001, its output is
  1443/sqrt(x)+13/x+16/log^3(x)+8.4e-6.
* `E1_var:639` supplies Dvar(x); in the moderate branch its form is
  1443/sqrt(x)+13/x+16/log^3(x)+8.5e-6.
* `E2_1e18:1294`, `tail_sum_le17`, `tail_sum_le`, `E2_le_bin`, and `psi_cE`
  propagate finite/mid-range errors; E2_1e18's target is .0000683.
* `F_large:942` (x>=1e12), `F_mid:1997` (1e5<=x<1e12), and `F_all:2220`
  (prime x>=5) prove product_{p<=x}p/(p-1)
  < exp(gamma) log(thetaN(x))+2.50637/log(thetaN(x)). The prime range below
  1e5 has an existing finite kernel in `SmallMertensProd`.
* `div_totient_lt:2258` applies the unconditional exchange argument to obtain,
  for 1<=q<=r and r>=3,
  q/phi(q)<exp(gamma)log(log r)+2.50637/log(log r).

The totient inequality feeds `BaseGap2`, `FirstChoiceTypeII`, `GBound`,
`LSQuot3`, `SecondBridge`, `SecondTypeIIa/b`. It is a real second route into
the minor arcs even after the pointwise tail has been repaired.

The fixed tail can plausibly remove the log(M)>=20000 **restricted** E1_diff
premise after deriving the needed restricted psi_err directly. It does not
remove the current global `psi_err` premise, E1_win_num's independent input,
or the F_mid/F_large product contracts. Restricting a theorem's domain is
not counted as solving its original statement.

A promising separate research route is to integrate the zero expansion before
taking absolute values. `Prelim/MertensZeros.lean` already has
`norm_integral_cpow_le:217`, whose denominator is norm(rho-1), and
`norm_Mg_div_le:151`, which exposes the combined weight
norm(Mg(rho))/norm(rho-1). On the critical line the latter is bounded by
exp(delta^2/2)(exp(a/2)+exp(b/2))/max(2.39,abs(Im rho))^2.
Generalize this weight to the QRH strip with the real exponential factors
retained; use functional-equation pairing or xi mass to obtain a small
weighted sum. Do not reuse the critical-line formula by changing its premise.
The sharp decay now concerns a 1/t^2 weight, unlike the divergent unweighted
zero count or the much larger 1/t estimate.

There are two independent analytic tasks: (i) the integrated smoothed error,
(ii) the unsmoothing edge corrections. `MertensWindow.E1_window` and
`edge_le` make this separation explicit. The existing edges call `E1_local`
and hence pointwise theta estimates at the ends. A successful weighted-zero
argument must also bound the edges directly, or provide the finite/moderate
pointwise estimate they need. In particular, the unsmoothed E1 zero expansion
does **not** simply inherit the extra 1/rho denominator: Abel summation can
cancel it. This prevents an unjustified immediate deduction from xi mass.

For a first quantitative test, preserve the exact E1_win_num envelope above
at x=1e12 and prove its monotonic propagation for larger x; optimize window
length/delta and paired-zero weight jointly. If it misses, work directly
with E2 or the product, whose additional smoothing may be better, and replay
F_large's 2.50637 budget. No successful numerical bound for all these terms
has yet been established in this chapter.

## 7. Xi mass interface shared with the Mellin chapter

`prime-estimates/XiMass.lean` is an uncompiled complete draft of the
assumption-free bound Re(logDeriv xiF(2))<=.07. It uses the exact existing
identity `Explicit/ZeroFreeRegion.re_vM_eq:192` at s=2:

    D = 3/2 - log(pi)/2 - gamma/2 - Re LSeries(Lambda,2).

The rational replay `XiMassCertificate.py` independently checks the same
Taylor certificates used by `Prelim.Small.chkLow` and `chkStep`:

* 303 lower logarithm entries and 333 prime-power terms n<=2000 give
  sum Lambda(n)/n^2 >= .56945 (replay lower value .5694599657696959).
* harmonic(1000)>=7.48547086 and log(1001)<6.908755 give gamma>=.576715.
* Existing `log_pi_ge` gives log(pi)>=1.1447.

The resulting upper bound is .0698425, leaving .0001575 below .07.
The proof reuses the actual `IsPrimePow`/`Nat.minFac` definition of Lambda,
`hasSum_re_vM`, nonnegative omission via `sum_le_hasSum`,
`Real.eulerMascheroniSeq_lt_eulerMascheroniConstant`, and
`Complex.digamma_one`. No infinite prime-power interchange is required.
Imports are `Explicit.ZeroFreeRegion`, `Prelim.SmallMertens`, and Mathlib's
harmonic Euler-constant module. `XiMassAudit.lean` is prepared but not run.
No heartbeat or recursion overrides are present. Computation may require
small certificate chunks under default limits; this remains a validation
issue rather than a missing analytic premise.

Normalization matters: `ZeroFree.pair_approx` approximates a paired Phi sum
by **twice** Re(logDeriv xiF), so its limit is bounded by .14. The unpaired
mass sum Re(1/(2-rho)), with multiplicities, is bounded by .07. The Mellin
chapter owns the principal-kernel inequality built from this interface.
The same mass may be useful for the weighted Mertens route, but neither
application is automatically proved by the derivative bound alone.

## 8. Research order and acceptance checks

1. Resolve the finite wrapper contamination using existing certificates;
   preserve each strict endpoint, especially 10^6 and 10^9.
2. Validate the local fixed-gap tail chain when implementation resumes;
   preserve the original range1/asymptotic conclusions and one acyclic formula
   module. The current planning phase launches no Lean processes.
3. Independently search for a moderate-range psi envelope **and** direct
   proofs of the seven exported Lambda contracts. Reject an envelope unless
   the induced Mobius cells, Type I/II estimates, and original 10^27 budget
   can be quantified. Coarse all-range Chebyshev alone is not enough.
4. Evaluate the weighted Mertens route with its edge corrections; retain the
   product/totient branch as a separate open obligation until its full domain
   and constants are justified.
5. For any eventual proof claim, print the exact theorem type and transitive
   axioms, then check every production call. Absence of a Platt axiom alone
   does not detect a retained Fact binder, a narrowed range, or a new missing
   estimate hypothesis. The original BinaryGoldbachInput remains the only
   original external binary premise; this work introduces no substitute.

Current conclusion: finite cleanup and the exp(20000) tail are concrete
proof candidates. The interval between the finite certificates and that tail,
together with the direct Mertens window/product branch, remains open research.