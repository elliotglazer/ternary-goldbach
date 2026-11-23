# Full far-asymptotic QRH assembly review

Reviewer: independent worker 8. Date: 2026-11-10. Source-only review; no compiler was launched.

Pinned ternary source: 23b2d68ca344203d4384e0aff7affa4ec034bef9.
Local OAI source checkout: 4eaee87548250b2682affda7d05d947c05554bae.

Reviewed scratch snapshots:
- QrhPsi.lean SHA256 EF2740BE924C2D962E2B99340A9D8768E0AC4757F987D4B665048479929BDC4E.
- QrhPsiMid.lean SHA256 825F05F329ACDC13F200E101466F191089B83188BE37C01BA9FEDE926CF8F6FE.
- QrhZetaBridge.lean SHA256 976DFA38D0EADC5A4ADD9F0CD72F1A01ED172B15450FA1AF606D6E21D68E2360.

## Result

No mathematical gap found in the displayed far-asymptotic assembly. The low-zero QRH estimate, zero partition, unchanged middle and tail estimates, contour limit, real-sum conversion, and consumption by psi_asymp_of are consistent.

This is not a successful frozen-declaration audit or compiled theorem claim. The complete QrhPsi and bridge imports remain unverified at term level. A compiled exact-type and axiom check is still required. This review also does not replace the separate audit of the imported OAI theorem's full proof closure.

## Exact theorem compared with original

Original PsiAsymp.lean:630-644 has the scoped input [Fact TernaryGoldbach.PlattGRH] for psi_asymp8 and concludes

    {x : Real} -> exp(35000)<=x ->
      |psiR x-x| <= 0.2*x/(log x)^3.

The proposed psi_asymp_qrh has the same explicit x and threshold, function psiR, constant 0.2, exponent 3, and inclusive endpoint. It has no Fact PlattGRH or supplied QRH binder.

psiR is the existing literal definition psi(floor_nat x), at PsiSandwich.lean:82. Its floor convention and carrier are unchanged.

| Expanded input | Classification | Source comparison |
| --- | --- | --- |
| x : Real, implicit | TYPING | Same as original psi_asymp8 |
| exp(35000)<=x | SOURCE | Same inclusive domain as original |
| Other mathematical input | None | Imported OAI theorem is used as a theorem, not assumed |

Counts: SOURCE 1, STANDING 0, TYPING 1, RULED 0, EXCESS 0 for the proposed explicit type. There is no manifest or author-frozen successor, so this table is source comparison only.

The intermediate SsumG_gsm_err_qrh and tsum_gsm_le_qrh are generic helpers. Their hypotheses are delta>0, b<=a, b<=0, x>1, Gamma>=3e12, and delta^2/2+|a|<=1e-6. The final proof supplies precisely these arguments from psi_asymp_of's quantified input interface. No generic helper estimate remains an added premise of psi_asymp_qrh.

## QRH and the functional equation

OAI/NumberTheory/DirichletL/Nonvanishing.lean:29-31 states, with no pole or character premise, that Re(s)>7/8 implies riemannZeta(s)!=0. Contraposition gives Re(s)<=7/8 for a zeta zero.

For a zero with 0<Re(s)<1, Xi.lean:56-60 equates xiF(s)=0 with riemannZeta(s)=0. Xi.lean:24-26 gives xiF(1-s)=xiF(s). Since 0<Re(1-s)<1, applying the same equivalence and the upper QRH bound to 1-s gives 1/8<=Re(s).

This reflection uses 1-s, not a conjugation convention. It is correct for the zeta xi function. No multiplicity transport is needed: reflection is used only to constrain the real part of each original zero.

ZetaZeroSums.lean:35-49 proves that every zero in zerosRectD zetaF T is a nontrivial zeta zero and xi zero. In particular zetaF(0)!=0. Thus the new low-zero proof does not omit an origin contribution. The zeta pole at 1 is also excluded by the existing strict critical-strip classification.

## Finite zero partition and multiplicity

The draft retains the original zerosRectD zetaF T and multRectD zetaF T throughout. Every finite sum uses the original natural divisor multiplicities, cast into Real or Complex. No simple-zero assumption, recounting, or change of surrounding rectangle occurs.

For every fixed real T, the filters partition its zero set into:

| Piece | Height interval | Estimate |
| --- | --- | --- |
| Low | |gamma|<=1e8 | New QRH and coarse weighted count |
| First middle | 1e8<|gamma|<=3e10 | mid_sum_le anchored at 1e8 |
| Second middle | 3e10<|gamma|<=3e12 | mid_sum_le anchored at 3e10 |
| Third middle | 3e12<|gamma|<=Gamma | mid_sum_le anchored at 3e12 |
| Tail | Gamma<|gamma| | tail_sum_gauss anchored at Gamma |

Every lower endpoint except the first is strict; every upper endpoint is inclusive. A zero on a cut belongs to exactly the preceding piece. Gamma>=3e12 ensures the tail covers the remaining set, and Gamma=3e12 makes the third middle piece empty. The filter identity remains valid for every T; no relation between T and the cuts is required.

## Low-zero estimate

The existing classification and new QRH bridge supply 1/8<=Re(u)<=7/8. The norm_Mg_qrh_strip_le helper supplies

    |Mg(u)|*max(1/8,|Im(u)|)
      <= 2 exp(delta^2/2+|a|).

The reviewed sum_weight_zeta_low_le then gives

    sum multiplicity(u)*|Mg(u)|
      <= 1e20*2 exp(delta^2/2+|a|).

The small-parameter hypothesis implies exp(delta^2/2+|a|)<=2, so the coefficient is at most 4e20, below 1e24. Since x>1, |x^u|=x^Re(u)<=x^(7/8). This gives the proposed 1e24*x^(7/8) low contribution.

This is a coarse estimate, but its constants and inequality directions are valid. It does not rely on any critical-line Mellin identity or RHBelow predicate.

## Middle and Gaussian-tail pieces

PsiLarge.lean:80-117 states mid_sum_le with only b<=0, x>1, the lower anchor H>=1e8, membership in zerosRectD, and H<|Im(u)|<=Gamma. All three calls supply these exact hypotheses.

Its proof uses the unconditional norm_Mg_strip_le, count_mid, and rpow_re_le_zf. The latter, at PsiLarge.lean:42-57, follows from the explicit zero-free region zero_free, at ZeroFreeRegion.lean:546. No PlattGRH, Fact, or RHBelow input appears in this path.

ZetaZeroSums.lean:530-589 states tail_sum_gauss with positive anchor, delta>0, b<=0, x>=1, finite-set membership, and height above the anchor. The draft's Gamma>=3e12 supplies positivity and all other hypotheses match. The proof uses the Gaussian envelope, the original multiplicity window count, and geometric sums. It does not require a critical-line hypothesis.

The sum of the second and third middle pieces is definitionally MidBH a delta 3e10 Gamma x, which is definitionally MidB a delta Gamma x. The first middle piece remains separately MidB0 a delta 1e8 3e10 x until its new half-budget bound is applied.

## Limit and contour contribution

ZetaExplicit.lean:173-182 supplies a sequence of good heights and convergence of the exact finite zero sums to

    mellin(phi,1)*x - SsumG(1,phi,x)
      - (1/(2*pi))*I0.

The new bound is independent of outer rectangle height T, so applying it at each sequence height and using norm continuity is valid. The proof does not interchange an uncontrolled infinite sum or drop a tail.

PsiExplicit.lean:51 gives the left-line integral bound x^(-1/2)*Vg a b delta. Multiplication by 1/(2*pi) produces exactly the draft's last term. The final sign identity reconstructs SsumG-Mg(1)*x correctly; the norm absorbs its minus sign.

GoodSmoothing is supplied by goodSmoothing_gsm with delta>0 and b<=a. mellin_gsm identifies the Mellin transform. The real-sum theorem then uses SsumG_one_ofReal and Mg_one to preserve the same normalized main term as psi_asymp_of.

## Half-budget and final consumption

PsiAsymp.lean:335-340 expects its quantified smoothing estimate in this exact shape:

    absolute smoothed error
      <= sqrt(x)*LineB
         + x*(MidB + 1e-4/(log x)^3)
         + x*TailBG
         + x^(-1/2)*Vg/(2*pi).

The numerical absorption theorem gives

    1e24*x^(7/8) <= 5e-5*x/(log x)^3.

The new MidB0_8_asymp_half_le gives

    x*MidB0(a,delta,1e8,3e10,x)
      <= x*5e-5/(log x)^3.

Their sum is exactly x*1e-4/(log x)^3. The draft proves sqrt(x)*LineB>=0 and adds this as slack to match the old consumer. It never asserts that low zeros still contribute sqrt(x)*LineB.

MidB0_8_asymp_half_le preserves the earlier reviewed argument. Its intermediate exact constants yield a bound around 7.34e-21 before the final comparison to 5e-5. It is therefore a legitimate tightening of the original MidB0_8_asymp_le.

The complete existing psi_asymp_of proof then remains unchanged. Its chosen Gamma=(log x)^4/5 and delta=5*(log(log x)+5)/(log x)^4 are internal to that consumer. It uses MidB<=0.01/(log x)^3, TailBG<=1e-4/(log x)^3, and the new supplied 1e-4 allowance, totaling 0.0102*x/(log x)^3. Its 14990*sqrt(x) line allowance and 2.54e-3*(log x)^4 contour allowance are unchanged, as are the upper/lower smoothing sandwich and final constant 0.2.

## Source-level Platt dependency checks

The old psi_asymp8 explicitly calls rh_upto_1e8 and is the declaration under the scoped Fact PlattGRH at PsiAsymp.lean:630. The new proof calls neither.

The used contour, Mellin, zero classification, xi reflection, zero-free-region, midpoint-count, Gaussian-tail, and smoothing-sandwich APIs were inspected at source. None of their displayed declarations requires Fact PlattGRH or RHBelow. The numerical LineB bound is an inequality about an explicit scalar definition; it does not assert a line-zero estimate and requires no RH premise.

The files PsiAsymp and ZetaZeroSums import and define other conditional theorems, but imports alone do not supply or require those hypotheses. The inspected dependency path uses the unconditional helpers. A targeted source search found no global Platt instance or Platt axiom.

This is evidence about the displayed path, not a substitute for the compiled theorem's transitive axiom closure. Imported OAI compatibility and its full theorem closure remain the integration audit's responsibility.

## Compilation evidence and next check

The numerical helper's existing numeric-audit.log was read. It prints the exact exp and rpow statements and only propext, Classical.choice, Quot.sound. Parent and prime worker report the compiled numerical source hash 600B3F9F7E1CD2FF568EF4FCE268D02B44357F4D8C1FC00BA2BDC5F4A003CE7B. This compilation evidence applies only to that numeric helper, not to QrhPsi.

Next, once project and OAI artifacts are available, compile the complete bridge and QrhPsi chain. Print the full psi_asymp_qrh type and axioms, and compile an exact-type witness

    example {x : Real} (hx : exp(35000)<=x) :
      |psiR x-x| <= 0.2*x/(log x)^3 := psi_asymp_qrh hx.

Do not add Fact PlattGRH while testing. Only a successful check of the complete export establishes the far-asymptotic replacement. Even then, it handles x>=exp(35000), not the remaining prime estimates or Goldbach at 10^27.

