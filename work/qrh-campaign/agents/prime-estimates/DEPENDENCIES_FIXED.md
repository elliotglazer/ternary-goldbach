# Local fixed-gap far-asymptotic psi variant

Status: complete scratch proof scripts, not compiled. Both earlier QRH variants and the checked7/8 numeric source are preserved. This variant imports no OAI module.

## Exact final declaration

PsiFixed.lean defines TernaryGoldbach.Explicit.psi_asymp_fixed:

    {x : Real} (hx : Real.exp 35000 <= x) :
      |psiR x - x| <= 0.2*x/Real.log x^3

This matches the existing psi_asymp8 conclusion and threshold without its Fact PlattGRH binder. No fixed-gap or low-zero estimate is assumed as a new final premise: both are invoked from the local proof files supplied by zero_sum.

## New analytic interfaces and how they are consumed

ZeroFreeFixedGap.zeta_zero_re_le_fixed (namespace TernaryGoldbach.Explicit):

    (h : riemannZeta rho = 0) (h0 : 0 < rho.re) (h1 : rho.re < 1)
    (hT : abs rho.im <=1e8) : rho.re <=249/250.

ZetaLowUnconditional.abs_im_ge_of_nontrivial_zero:

    (h : riemannZeta rho = 0) (h0 : 0 < rho.re) (h1 : rho.re < 1) :
      2.39 <=abs rho.im.

The existing zerosRectD_zetaF_strip gives all zero and strict-strip hypotheses. Low-set membership gives hT. No multiplicity changes occur: the set is the same zerosRectD zetaF T used in the explicit formula, and the weight is the same real cast of multRectD zetaF T rho.

PsiFixedAux.norm_Mg_im_le proves, using only0<Re(s)<1 and b<=0,

    norm(Mg a b delta s)*abs(s.im) <=2exp(delta^2/2+abs(a)).

Since abs(s.im)>=2.39, max(1/8,abs(s.im))=abs(s.im). Thus the original ZeroSumStrip.sum_weight_zeta_low_le applies unchanged, with constant1e20. Neither a lower real-part gap nor a new weighted-count theorem is needed.

The low-zero contribution is at most1e24*x^(249/250). All three middle bins, the tail, the explicit-formula limit, and the final psi_asymp_of budget are unchanged from the previously audited assembly.

## Numeric absorption

PsiFixedNumeric.fixed_low_exp_absorb proves

    1e24*exp(249L/250) <=5e-5*exp(L)/L^3 for L>=35000.

It uses Taylor degree50 and the exact integer inequality

    2*10^28*50!*250^50 <=35000^47.

An independent JavaScript BigInt calculation confirmed the inequality, with integer quotient7 (actual ratio about7.76). The explicit norm_num proof script is present; this arithmetic replay does not replace Lean checking.

fixed_low_rpow_absorb converts to x>=exp35000. This consumes the same5e-5 low-zero allowance as before. QrhPsiMid supplies the other5e-5 to the first middle interval; the final .2 coefficient remains unchanged.

## Ordered build and audit list

1. PsiFixedNumeric, then PsiFixedNumericAudit. Only matched Mathlib package artifacts are required.
2. Project roots TernaryGoldbach.Explicit.PsiAsymp, TernaryGoldbach.Explicit.ZetaLowZeroFree, and TernaryGoldbach.Explicit.ZeroFreeRegion, with their dependencies. Some roots may already belong to the PsiAsymp closure; integration should deduplicate them.
3. ZeroSumStrip and ZetaLowUnconditional from agents/zero-sum. Independently, PsiFixedAux from this directory and the unchanged QrhPsiMid can compile once their project imports exist.
4. ZeroFreeFixedGap from agents/zero-sum, after ZetaLowUnconditional and the project ZeroFreeRegion.
5. PsiFixed, then PsiFixedAudit. Print the exact final type and transitive axioms before any theorem-completion claim.

The integration worker owns the compiler schedule. No compiler was started by this worker. No OAI, Rellich, provider compatibility port, or new dependency version is required for this variant. This does not assert that the new local analytic proofs have compiled; they remain the critical checked-proof obligations.

## Source hashes before compilation

- PsiFixed.lean: F36AAFAA514A8BE3DCF93EBE38D44FB5CE5E305D5A5346609841D1F1242C657D
- PsiFixedNumeric.lean: 40F9FD713CAFF453FD50348824C98E98466CB2D2E6634021E0252DEBD834EE09
- PsiFixedAux.lean: 0754AAD090EF525B5AC7AF6018C9BD43C979D944FFD988A60266207B37A81416

All finite-range prime estimates and major/minor-arc obligations remain outside this far-asymptotic theorem.
