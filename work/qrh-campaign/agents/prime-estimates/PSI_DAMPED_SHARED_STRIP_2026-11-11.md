# The common psi envelope from the shared strip and the certified head

Paper/source derivation, 2026-11-11. No new zero or prime evaluations, scans, Lean declarations, builds, or changes to frozen packets. The scalar calculation is the separate exact-rational packet by major_constants, pinned below. This note supplies its source, multiplicity, symmetry, partial-summation and desmoothing joins.

The result is a conditional mathematical deduction from explicit spectral inputs, not a completed Lean theorem or a new finite spectral certificate:

\[
 |\psi_R(x)-x|<.01x/\log x\qquad(x\ge5\cdot10^9).
\]

It needs the already reviewed RH/count/reciprocal head through **1500**, the shared finite principal strip **[.445,.555] through H=60343058**, and genuine global **7/8 nonvanishing**. It does **not** need a separate narrow strip through one million, its weighted moment24, or head data between1500 and2000. The new finite-logarithm calculation gives the stronger constant .0096; the existing shared-strip calculation gives .0081 above exp35. This is a proposed removal of that extra input for the common psi consumer only. It does not change the campaign's selected strategy or claim that unrelated consumers no longer need their own inputs.

The notation is the actual source wrapper `psiR x = Helfgott.psi (Nat.floor x)`, from `Explicit/PsiSandwich.lean`; the conclusion is for real x. At natural x, `Prelim/ThetaExplicit.psiR_nat` supplies the integer envelope. The separately reviewed finite prime certificate on [1e9,5e9] is unchanged and can supply the lower interval once formally checked.

## 1. Precise inputs and their status

All zeros below mean the actual nontrivial zeros of `riemannZeta`, with their true analytic orders. Let

\[
 N(t)=\sum_{\substack{\zeta(\rho)=0,\ 0<\beta<1\\0<\gamma\le t}}m_\rho,
 \quad A=1500,\quad H=60343058.
\]

The inputs are:

1. Every zero with |gamma|<=A is on beta=1/2; the positive closed count is N(A)=1069; and
   \[
   Q_A=\sum_{0<\gamma\le A}m_\rho(1/\gamma-1/A)<1.668.
   \]
   Hence the **positive**, not both-sign, reciprocal head is
   \[
   \sum_{0<\gamma\le A}m_\rho/\gamma
      =Q_A+1069/1500<3571/1500=:H_A.
   \]
   The boundary correction is retained. RH and N(A) alone would not give this Q_A bound.
2. Every zero with A<|gamma|<=H has .445<=beta<=.555. It is harmless if the proposed shared certificate covers the whole |gamma|<=H rectangle. This finite certificate remains to be established; it is not inferred from global QRH.
3. `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re`, at the pinned OAI revision, yields beta<=7/8 for every nontrivial zero. Reflection yields beta>=1/8. The actual provider build and transitive kernel-axiom audit remain required.
4. The separately derived **unconditional analytic** count bound, for every real t>=A,
   \[
   N(t)\le B(t):=\frac{t}{2\pi}\left(\log\frac{t}{2\pi}-1\right)
                         +5\log t+167/8.
   \tag{1}
   \]
   This is the Jensen/argument-principle/Gamma proof, not a cited historical zero computation. Its proof includes closed-height passage and no finite-RH input. Its later narrow-strip moment application is not used here.

The existing head evidence is external, independently reviewed arithmetic and contour/sign evidence, still requiring formal certificate replay. The analytic count and provider bridges likewise retain their recorded paper/formalization status. None is silently promoted to a new axiom or a permissible extra hypothesis of final Goldbach.

| Input packet | SHA256 |
|---|---|
| `audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md` | `A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE` |
| `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` | `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491` |
| `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md` | `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303` |
| `major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md` | `82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418` |

All packet paths in this note are relative to `work/qrh-campaign/agents/`. Repository source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`; OAI source is pinned at `4eaee87548250b2682affda7d05d947c05554bae`.

## 2. The finite carriers, orders, real axis and symmetries

`Explicit/Datum.lean:81,85` defines `zerosRectD f U` using an inner disk and the strict rectangle (-1/2,3/2) x (-U,U), with `multRectD` the natural value of the meromorphic divisor on its larger disk. `ZetaZeroSums.zerosRectD_zetaF_strip:39` unconditionally shows every selected element is an actual zeta zero with 0<beta<1 and a zero of xiF. The pole at1 and the possible origin case have already been excluded by this source theorem. In particular they cannot acquire spurious weights here.

For a complete **closed** height window through H, choose U=H+1 and filter `zerosRectD zetaF U` by |gamma|<=H. Every strict-strip zero in that closed window is in the inner disk: |rho-2|<2+H<U+3=RT(U)/2. Positive finite analytic order supplies divisor support and hence the converse membership, using `Datum.mem_zerosIn_of_zeroD`. This makes a complete finite set, not a list conjectured to contain every root.

The weights are independent of this enclosing U. `WeilBridge.analyticOrderAt_xiF_eq:38` and `divB_eq_of_analyticOrderAt_eq:55`, on the actual containing disks, identify `multRectD` with the finite analytic order of xiF and hence of zeta. This is the direct lower-level transport detailed in `zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md` (SHA `C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D`). We do not invoke a T>=1 corollary on an existential T>0. The finite-order comparison also transports each good-height explicit-formula weight to the fixed complete window.

There are no real nontrivial zeros. An elementary source proof is available without head computation: for real 0<sigma<1, `ZetaGrowth.saw` is nonpositive and the real power in `Izeta sigma` is positive. Its real integral is therefore nonpositive. The actual identity `ZetaGrowth.zetaF_eq:156` gives

`zetaF(sigma)=sigma+sigma*(sigma-1)*Izeta(sigma)>=sigma>0`.

Integrability is already in that source. This is the same argument as `Xi.re_zetaF_half_ge`, at general sigma. The source has xiF(0)=xiF(1)=1 and excludes xi zeros outside the strict strip. For the shortest selected proof, the retained RH head itself forces any real nontrivial zero to be1/2, contradicted by the existing `Xi.xiF_half_ne_zero`; the unconditional argument is therefore optional. The reviewed head contour's bottom edge also excludes the relevant real zeros. No gamma=0 term is discarded without justification.

The needed maps are conjugation C(rho)=conj(rho) and the same-positive-ordinate involution J(rho)=1-conj(rho). The source gives `Xi.xiF_one_sub:24` and `XiPartial.xiF_conj:669`. They preserve zeros **and their full orders**: locally write xiF(z)=(z-rho)^m h(z), with h(rho) nonzero. Conjugating the expansion gives order m at conj(rho), and substitution z->1-z multiplies the leading factor by (-1)^m without changing its order. Analyticity of the conjugated local function follows from its conjugated convergent power series. This proves order preservation even at multiple roots. A formal affine-composition ingredient already exists as Mathlib `analyticOrderAt_comp_of_deriv_ne_zero`; the conjugation specialization still needs to be written from local factorization/series. It is not supplied merely by zero membership.

The complete positive window A<gamma<=H is invariant under J. Conjugation is a weight-preserving bijection to the negative window. For a finite explicit-formula subset that is not visibly invariant, first enlarge the nonnegative absolute summands to that **complete** finite window. Never apply an averaged beta bound to a single unpaired zero, add a second copy of a full multiplicity, or assume two reciprocal norms agree. Fixed points of J on the critical line cause no difficulty: reindexing a sum by an involution and averaging works without dividing orbit sizes.

## 3. Actual Mellin terms and the paired estimate

For the finite logarithmic interval use

\[
 L=\log x\in[22.33,35],\quad K=\sqrt{L+10},\quad
 \delta=\frac{.002}{L\sqrt{L+10}},\quad a=\pm a_0,\quad a_0=.002/L,
 \quad b=\log1000-L,\quad q=\delta^2/2.
\]

Thus K delta=a0. `GaussSmooth.norm_cexp_gauss:317` and `norm_intExp_le':355`, applied directly to the source `Mg`, give for rho=beta+i gamma

\[
 \frac{\|Mg(a,b,\delta,\rho)x^\rho\|}{x}
 \le e^{q(\beta^2-\gamma^2)}
       \frac{e^{a\beta}+e^{b\beta}}{|\rho|}\,e^{(\beta-1)L}.
 \tag{2}
\]

First use |rho|>=|gamma| and beta^2<=1. The remaining ordinate weight is

\[
 f_\delta(t)=e^{-qt^2}/t\quad(t>0).
\]

For a same-positive-ordinate pair beta=1/2+v and1/2-v, the a-endpoint average in (2), without this common weight or e^q, is exactly

\[
 e^{-L/2}e^{a/2}\cosh(v(L+a)).
\]

For the b-endpoint it is exactly

\[
 \sqrt{1000}\,e^{-L}\cosh(v\log1000).
\]

This follows by cancelling L inside `(beta-1)L+b beta`; replacing that endpoint by the a-endpoint loses useful margin. On A<gamma<=H, |v|<=d:=11/200; L+a>0 and |L+a|<=L+a0. On the head v=0. Drop head damping only, retain all other damping, and use the positive head bound H_A. Define

\[
 D_\delta=\sum_{A<\gamma\le H}m_\rho f_\delta(\gamma).
\]

After doubling for conjugation, the entire through-H contribution is bounded by

\[
 E_{\le H}(L)\le2e^q\left[
 e^{-L/2+a_0/2}\{H_A+\cosh(d(L+a_0))D_\delta\}
 +\sqrt{1000}\,e^{-L}\{H_A+\cosh(d\log1000)D_\delta\}
 \right].\tag{3}
\]

All counts in D_delta are positive-ordinate counts; the factor2 in (3) is the only sign-doubling factor. This bound holds for either source smoothing a=+a0 or-a0. No cancellation among complex Mellin values is assumed.

## 4. Finite Abel summation with a damped tail

The exact finite identity, including all closed-height endpoints, is

\[
 D_\delta=f_\delta(H)N(H)-f_\delta(A)N(A)
          +\int_A^H[-f_\delta'(t)]N(t)\,dt.\tag{4}
\]

For clarity, (4) follows without an infinite zero measure: interchange the finite zero sum with the integral of the step indicator 1_{gamma<=t}. A zero with gamma<=A contributes zero after the three boundary terms cancel; a zero with A<gamma<=H contributes f_delta(gamma). Endpoints in the integral have measure zero. Thus a zero atA belongs wholly to the head, and a zero atH wholly to the tail; there are no half-weights.

Because -f_delta'>0, f_delta(H)>0, N<=B and N(A)=1069, integration by parts of the smooth B gives

\[
 D_\delta\le(B(A)-1069)f_\delta(A)
                     +\int_A^H f_\delta(t)B'(t)\,dt,
 \qquad B'(t)=\frac{\log(t/(2\pi))}{2\pi}+\frac5t>0.
\]

The boundary discrepancy B(A)-1069 is nonnegative. Bound f_delta(A)<=1/A, extend the **ordinary positive integral** to infinity, and bound its 5/t^2 part by5/A. This extension does not put any shared-beta restriction on actual zeros above H; those zeros remain in the separate global tail.

Let R=1/delta>A, Z=log(R/(2pi)), ell=log(A/(2pi)). Dropping damping only on [A,R] and substituting t=Rv afterwards gives

\[
 D_\delta\le\frac{B(A)-1069+5}{A}
             +\frac{Z^2-\ell^2}{4\pi}
             +\frac{Z I_0+I_{\log}}{2\pi},\tag{5}
\]

where I0=integral_1^infinity exp(-v^2/2)/v dv and Ilog has the extra factor log v. These converge absolutely. The following elementary proof avoids quadrature:

* Put w=v^2. On [1,2], 1/w<=(3-w)/2, since (w-1)(w-2)<=0; on [2,infinity), 1/w<=1/2. Thus I0 is at most `(1/4) integral_1^2 (3-w)exp(-w/2) dw +(1/4) integral_2^infinity exp(-w/2) dw =exp(-1)<.368`.
* For v>=1, log v<=v^2/2, so Ilog<=`(1/2) integral_1^infinity v exp(-v^2/2)dv =exp(-1/2)/2<.304`.

The displayed antiderivatives and vanishing exponential boundary terms justify both improper integrations. All domains are positive. Therefore define the entirely explicit majorant

\[
 \overline D(L)=\frac{B(A)-1069+5}{A}
       +\frac{Z^2-\ell^2}{4\pi}+\frac{.368Z+.304}{2\pi}.\tag{6}
\]

Unlike dropping damping on the whole interval, (6) grows only with log R, and R follows the actual L-dependent delta. Replacing delta everywhere by its value atL=35 would needlessly lose the present margin.

## 5. The scalar maximum and every remaining error

The companion scalar note proves a continuum maximum, not a sampled maximum. It uses

`Z'=1/L+1/(2(L+10))<3/(2L)`, `0<Z<11`, and `0<Dbar'<3/L`.

The rational left-endpoint check gives Dbar(22.33)>1, so Dbar'/Dbar<3/L. The logarithmic derivative of the main positive bracket in (3) is at most d+3/L, because the cosh logarithmic derivative is at most d. Both q and a0 decrease. Hence the first L-scaled term decreases, with logarithmic derivative at most `4/L+d-1/2<0`. The second term decreases with bound `4/L-1<0`. Thus evaluate only L=22.33, with rigorous rational pi/log/exp enclosures. The enclosing logarithmic endpoint satisfies exp(22.33)<5e9.

The resulting strict upper values are:

| Quantity | Upper bound |
|---|---:|
| Dbar(22.33) | 5.009700139059211 |
| L times main a-endpoint in (3) | .007379689772059 |
| L times lower b-endpoint in (3) | .000002225792506 |
| Total L E_{<=H} | .007381915564564 |

The **actual zeros above H** use global beta in[1/8,7/8] and the existing Gaussian high-tail proof. Its source window constants are Z3g(BPz2,H)<180 and c3g(10,H)<1e-6. The present delta is at least the old `.001/L^(3/2)` because 4L>=L+10. The Gaussian damping improves and the geometric-tail denominator improves. The Mellin endpoint coefficient remains bounded by2.001. The already checked `L E_high<2e-9` proof extends down to22.33: its lower-range part uses only L<=200, while its large-L polynomial/exponential part is unchanged. It has no low narrow-strip premise.

For the vertical line, use the actual `PsiExplicit.norm_logDeriv_zeta_left`, not a spectral estimate. The already derived integral bound for0<delta<=1 is

\[
 I_\delta=\int_\mathbb R\frac{40+2.6|t|}{\sqrt{1/4+t^2}}e^{-\delta^2t^2/2}dt
 \le240+80\log(1/\delta)+2.6\sqrt{2\pi}/\delta.
\]

Split the40-term at |t|=1 and1/delta, and use |t|/sqrt(1/4+t^2)<=1 for the other term. On Re(s)=-1/2 the two true endpoints give

\[
 E_{vert}\le\frac{2/\log2+4.8}{2\pi}e^{\delta^2/8}
       (e^{a_0/2}x^{-3/2}+x^{-1}/\sqrt{1000})I_\delta.
\]

The inherited uniform check `L E_vert<.00016` uses1/delta<120000, log(1/delta)<12, sqrt1000>31, sqrt(2pi)<2.51, and monotonicity of L exp(-cL). The lower endpoint is x^-1/sqrt1000, not x^-3/2.

Now `goodSmoothing_gsm`, `mellin_gsm`, `Mg_one`, and `explicit_formula_zeta_seq` pass the finite-carrier bounds through the **same** good-height sequence. Its sum tends to `Mg(1)x-SsumG-(1/(2pi))*vertical integral`; triangle inequality gives the actual smoothed real error x(E_{<=H}+E_high+E_vert). No RHBelow error theorem is reused. The classification/order steps above apply to every finite sequence member; the bound is uniform in its height. The existing integrability statements justify the vertical norm estimate. `SsumG_one_ofReal` identifies the natural von Mangoldt series consumed by the source sandwich.

With r=exp(-(L+10)/2), the exact source upper and lower relative errors are bounded by

\[
 U=4000e^{a_0-L}+\frac{e^{\delta^2/2+a_0}-1+E+2r}{1-2r},
 \qquad D=1-e^{-a_0}+2000e^{-L}+E+4r.
\]

Here E is the normalized smoothed error just described. The hypotheses of `PsiLarge.psi_upper_of_err:296` and `psi_lower_of_err:326` hold: delta>0, delta<=1, delta<=K, K>=0, x>=1, y0=1000>0, b<=-K delta and1000 exp(K delta)<=x, and2r<1. Their coarse psiR<=4y input is unconditional. Reuse the already checked finite-L scalar allowances:

| Other L-scaled cost | Allowance |
|---|---:|
| Global high tail | .000000002 |
| Vertical line | .00016 |
| Main shift | .002001 |
| Gaussian leakage | .000009 |
| Low cutoff | .000018 |
| Optional unused old intermediate slack | .000000000001 |
| Sum | .002188002001 |

The old intermediate slack is not a separate missing zero range: (3) already covers through H. Keeping it only enlarges the bound. Multiplying the entire sum, conservatively, by the upper-denominator factor1.000001 gives

\[
 L\max(U,D)<.009569927135481<.0096<.01.\tag{7}
\]

At x=exp35 the present proof and the prior tail overlap. For all larger x, `integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md` gives .0081 using only shared H/global QRH and unconditional translated-mass/window bounds. The latter true-order/digamma join now has its separate paper proof and review; no narrow-strip moment enters that tail. This completes the conditional **all-real-x** deduction at the stated threshold, rather than extending a finite-L estimate by assertion.

## 6. Frozen scalar packet, source pins, and remaining formal work

The companion is `major-constants/PSI_DAMPED_SCALAR_BUDGET_2026-11-11.md`, SHA `062E77E41EF43DC783A6CFAF319454C406897A322FA7D095BCC4C0E610F54209`. Its scalar-only script `psi_damped_scalar_budget_20261111.py` has SHA `FD27172A20940A71C4C1D5DEF0EFE5B140729BAD243562945A206F5CD9EFA4C5`, and its JSON SHA is `7D137201A4452F1C7E739EFB781C150DA2B8299720AFDF2718ADC06ECC107DFE`. The parallel exact-Gaussian symmetry derivation is `zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md`, SHA `7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE`; the present scalar choice bounds its beta-Gaussian factor by exp(q) before pairing. This task read the formulas and source; it did not rerun that script or any analytic-function evaluator. The elementary I0 estimate was supplied by root. The scalar packet and this source composition receive a separate independent review.

The inherited vertical/desmoothing/high-tail packet is `mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md`, SHA `33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61`; only its sections4–6 and common parameter/domain checks are used, **not** its section2 low spectral premise or section3 intermediate premise. The all-L>=35 packet is `integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md`, SHA `D4A026F5B7190F0AA577A70A88E7BFCB79740F9CA549EE9B7AC0EF0C782B3826`.

Fresh read-only source hashes, all under `TernaryGoldbach/Explicit/`:

| File | SHA256 |
|---|---|
| Datum.lean | `42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE` |
| Xi.lean | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |
| XiPartial.lean | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| WeilBridge.lean | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| ZetaGrowth.lean | `ED2158522FECDF70720AF464B28DE6E101666A3ED6AB7568729A5A8EA591E9E4` |
| GaussSmooth.lean | `40ACFCF56E61C411BAF8DD3E7B5504B3DB48F34740B256A4D03F1CDBE37FEBA8` |
| ZetaExplicit.lean | `A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2` |
| ZetaZeroSums.lean | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| PsiExplicit.lean | `33A24C9E1606011AAC8930EC978BA027E90A2A66E0888DB18915ACC2FBF85BB1` |
| PsiLarge.lean | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |

The remaining implementation is concrete: formally certify the retained finite head and shared strip; validate the real global provider; prove the unconditional analytic count; write the actual-order conjugation/reflection reindexing adapter, finite-step-function Abel identity and elementary damped integral bounds; insert (3) into the source good-height limit; prove the inherited vertical/high-tail/scalar adapters; and apply the existing two sandwiches. No new unknown mathematical estimate is being substituted for the consumer conclusion. These steps have not been checked by Lean here. The sharp numerical margin belongs to this explicit conditional calculation and is not evidence of runtime, spectral truth, or final Goldbach completion.
