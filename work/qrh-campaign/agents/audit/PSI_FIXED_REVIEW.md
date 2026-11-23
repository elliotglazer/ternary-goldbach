# Fixed-gap far-asymptotic psi assembly audit

Verdict: no mathematical or source-level hypothesis defect found. This is a source-only review; no Lean compiler or axiom printer was run. The local zero-free provider and its helpers still need compilation. No frozen theorem manifest was supplied.

## Reviewed snapshots

- PsiFixed.lean: F36AAFAA514A8BE3DCF93EBE38D44FB5CE5E305D5A5346609841D1F1242C657D
- PsiFixedAux.lean: 0754AAD090EF525B5AC7AF6018C9BD43C979D944FFD988A60266207B37A81416
- PsiFixedNumeric.lean: 40F9FD713CAFF453FD50348824C98E98466CB2D2E6634021E0252DEBD834EE09
- QrhPsiMid.lean: 15D2C00897D4518F5FC25DD1775E0C7B4412E7921C6BF6E8D8013B9AFDBA4912
- ZeroSumStrip.lean: 01796745F1BB58E9F1F1200765DFE2666013D7FE8040008CB8DC492F8BCBE2FC
- ZeroFreeFixedGap.lean: 1DECBC841B33388BCAD64C0B66E3C0FBECB818A376EBB40F1188C103F14FFFA0
- ZetaLowUnconditional.lean: 7FA18BA1662B103599B81B36606A626FF1F0240861D369CB0A1B1464842E46AE

The last two were independently reviewed in FIXED_GAP_REVIEW.md and LOW_ZERO_UNCONDITIONAL_REVIEW.md. Original source pin: calr3/ternary-goldbach 23b2d68ca344203d4384e0aff7affa4ec034bef9.

## Exact final target and assumptions

The final declaration is

    theorem psi_asymp_fixed {x : Real} (hx : Real.exp 35000 <= x) :
      |psiR x - x| <= 0.2 * x / Real.log x ^ 3

This preserves the real carrier, existing psiR definition, inclusive threshold exp35000, coefficient .2 and logarithm exponent3 of PsiAsymp.psi_asymp8. The original theorem's [Fact PlattGRH] is scoped specifically to psi_asymp8; it does not apply to psi_asymp_of at line335. The new declaration has only the threshold as a mathematical premise. Its generic smoothing hypotheses are all supplied from psi_asymp_of, not added to the final statement.

There is no OAI import or QRH call in these new proof bodies. QrhPsiMid retains an old filename but imports only PsiLarge and proves an unconditional numerical bound. Imports make the original conditional theorem available; the new proof never invokes psi_asymp8, rh_upto_1e8, or a Fact PlattGRH instance. This source inspection does not substitute for a transitive #print axioms check.

## Mellin bound without a lower real-part gap

PsiFixedAux.norm_Mg_im_le assumes only b<=0 and0<Re(s)<1 and concludes

    ||Mg(a,b,delta,s)|| * |Im(s)| <=2 exp(delta^2/2+|a|).

For sigma=Re(s), the Gaussian factor has norm exp(delta^2*(sigma^2-t^2)/2)<=exp(delta^2/2). The exact interval-exponential bound (GaussSmooth.lean:355) requires only s!=0, supplied by sigma>0; it does not require b<=a. Multiplying that bound by |t|<=||s|| cancels only the positive norm of s. The numerator is exp(a*sigma)+exp(b*sigma)<=2exp|a|, since0<sigma<1 and b<=0. The norm proof is therefore valid for the full open critical strip, with no uniform lower bound on sigma and no division by t.

When consumed, zerosRectD_zetaF_strip supplies strict-strip zeta zeros, and abs_im_ge_of_nontrivial_zero supplies |t|>=2.39. Therefore max(1/8,|t|)=|t|. This is the precise step allowing the existing weighted-zero helper to apply without proving Re(s)>=1/8.

## Low-zero sum and constants

The same original zerosRectD zetaF T and multRectD zetaF T occur throughout. The fixed-gap theorem is used only for zeros with |t|<=1e8, obtaining Re(s)<=249/250. The weighted helper sum_weight_zeta_low_le requires only the closed strip0<=Re(s)<=1, the height ceiling, nonnegative weights, and g(s)*max(1/8,|t|)<=C. All are discharged, with g=||Mg|| and C=2exp(delta^2/2+|a|).

The helper's count is sum multiplicities<=1e18, and its generic weight estimate gives sum multiplicities*g<=1e20*C. Under delta^2/2+|a|<=1e-6, exp_small_le yields exp(...)<=2. Thus the sum is<=4e20. Since x>1, x^Re(s)<=x^(249/250), giving<=4e20*x^(249/250), safely enlarged to1e24*x^(249/250). All multipliers are nonnegative. No multiplicity is discarded or assumed to equal1.

## Degree50 numeric absorption

For L>=35000 the proof uses the single nonnegative Taylor term

    exp(L/250)>=(L/250)^50/50!.

The exact integer inequality

    2*10^28*50!*250^50 <=35000^47

was replayed independently by check_psi_fixed_numeric.py. It passed; the ratio of right side to left side is approximately7.764129718715679. Exact integers and the rational ratio are saved in psi_fixed_numeric_results.json. This is arithmetic validation, not a Lean check.

Since L^47>=35000^47 and L^3>0, the inequality gives exp(L/250)>=2e28*L^3. Multiplying by exp(249L/250)>0 and using exp addition yields

    1e24*exp(249L/250)<=5e-5*exp(L)/L^3.

Substitution L=log x is valid because x>=exp35000>0. The real-power identity uses this same strict positivity. The change from degree20/denominator24 in the earlier variant to degree50/denominator250 is mathematically sufficient, including the threshold endpoint.

## Partition, limit and remaining budget

For every real rectangle parameter T, the filters split the original finite set into the disjoint intervals

1. |t|<=1e8;
2. 1e8<|t|<=3e10;
3. 3e10<|t|<=3e12;
4. 3e12<|t|<=Gamma;
5. Gamma<|t|.

Gamma>=3e12 includes the empty fourth interval at equality. Every boundary zero is included once. No relation between T and the cuts is assumed. The three middle estimates use PsiLarge.mid_sum_le, whose hypotheses are b<=0, x>1, lower cut>=1e8, set inclusion and the displayed height interval. Its high-zero region is unconditional. The tail uses the unchanged tail_sum_gauss with Gamma>0 and delta>0. Its denominator is controlled by rhoG<1 under exactly those hypotheses.

The bound is uniform in T, so it passes to the good-height sequence in explicit_formula_zeta. The existing contour remainder bound, triangle inequality, SsumG_one_ofReal and Mg_one retain the same normalization and signs. There is no exchange of an unjustified infinite zero sum.

QrhPsiMid supplies MidB0(a,delta,1e8,3e10,x)<=5e-5/log(x)^3. Its import and proof are unconditional. The newly absorbed low sum contributes another5e-5*x/log(x)^3. Their sum is exactly x*(1e-4/log(x)^3), the allowance in psi_asymp_of. MidBH(a,delta,3e10,Gamma,x) is definitionally MidB(a,delta,Gamma,x). The unused nonnegative sqrt(x)*LineB term supplies permitted slack, so no critical-line estimate is invoked to obtain it. This closes precisely the old psi_asymp_of premise on paper.

## Remaining work and scope

Compile and print types/axioms for the numeric helper, local low-zero and fixed-gap providers, weighted-count helper, Mellin helper, middle helper and final assembly. Their source-level correctness is not a compiled-proof claim.

The only review nit is stale QRH wording in two comments; it does not affect declarations or proofs. The author was informed. This theorem addresses the far-asymptotic psi range only. Finite prime-estimate ranges and the major/minor-arc root argument remain separate obligations.
