# The 23/24 far-asymptotic psi variant

Status: complete proof scripts are present, but none of the new 23/24 files has been compiled. No new axiom or sorry was introduced. The original checked 7/8 Numeric source is unchanged (SHA256 600B3F9F7E1CD2FF568EF4FCE268D02B44357F4D8C1FC00BA2BDC5F4A003CE7B). The full original 7/8 proof files are also preserved.

## Exact target and change

`QrhPsi24.lean` defines `TernaryGoldbach.Explicit.psi_asymp_qrh24`:

    {x : Real} (hx : Real.exp 35000 <= x) :
      |psiR x - x| <= 0.2 * x / Real.log x ^ 3

The lower threshold and numerical conclusion match the original psi_asymp8 exactly. The proof has no PlattGRH binder. Compared with the 7/8 draft, only the low-zero strip, its matching weighted helper, and the numerical absorption are changed. The higher-zero bins, explicit-formula limit, first middle-bin half-budget, and final psi_asymp_of call are unchanged.

The new low-zero bound is

    1e24 * x^(23/24) <= 5e-5 * x / log(x)^3, x >= exp35000.

`QrhPsi24Numeric.lean` proves it via

    exp(L/24) >= (L/24)^20 /20! >= 2e28 * L^3, L>=35000.

The exact rational check is 2e28 *20! *24^20 <=35000^17. Its multiplicative margin is over907. The proof is the same structure as the already checked 7/8 Numeric, with Taylor degree20 and residual degree17. This arithmetic check does not substitute for Lean compilation.

## Smaller provider and pole handling

Pinned provider revision: 4eaee87548250b2682affda7d05d947c05554bae.
Module: OAI.NumberTheory.DirichletL.RowCompletion.ZeroFreeRegion.
Exact exported declaration (source lines210-213):

    OAI.ShortDraft.riemannZeta_ne_zero_of_re_gt (s : Complex)
      (hs : (23/24 : Real) < s.re) (hs1 : s != 1) : riemannZeta s != 0.

The zero_sum worker's source-closure count is286 OAI modules,190290 lines, plus Mathlib and RellichKondrachov. The previous7/8 provider had2924 OAI modules. These are source counts, not successful-build claims.

`QrhZeta24Bridge` restricts its upper-bound helper to zeros with re(s)<1, deriving s!=1 explicitly. Reflection through xiF(1-s)=xiF(s), with both strict strip hypotheses proved, yields 1/24<=re(s)<=23/24. The exact zerosRectD_zetaF_strip interface already supplies zero status and0<re(s)<1. Thus pole exclusion is discharged rather than added as a final assumption. The same classification excludes the origin and trivial zeros.

`QrhPsi24Aux.norm_Mg_qrh24_strip_le` gives

    norm(Mg a b delta s)*max(1/24,abs(s.im)) <=2exp(delta^2/2+abs(a)).

`ZeroSumStrip.sum_weight_zeta_low_twenty_four_le` now exists with the exact same finite carrier, multiplicity and subset interface as the1/8 helper. Its conclusion remains <=1e20*C, since total multiplicity<=1e18 and the pointwise factor24 still fits. `QrhPsi24` supplies T and C explicitly and uses the same real cast of multRectD zetaF T as the explicit formula.

## Small ordered build list

1. Compile `QrhPsi24Numeric` from this directory, then `QrhPsi24NumericAudit`. These only need the matched Mathlib package artifacts. Inspect both exact types and their transitive axiom lists.
2. Build project `TernaryGoldbach.Explicit.PsiAsymp` and its dependency closure in the matched Lean4.35.0 environment. This supplies GaussSmooth, PsiLarge, Xi, ZeroSumGen and XiPartial. Unlike the earlier variant, canonical QrhNumeric is not an import of the new assembly.
3. Compile `ZeroSumStrip` from agents/zero-sum, `QrhPsi24Aux` from this directory, and existing `QrhPsiMid`. These are independent after step2.
4. Build a compatible `OAI.NumberTheory.DirichletL.RowCompletion.ZeroFreeRegion`, including its actual dependencies. The pinned source targets Lean4.34.1; compatibility and a transitive axiom audit remain open. Source availability alone is not sufficient.
5. Compile `QrhZeta24Bridge`, importing project Xi and the actual provider from step4.
6. Compile `QrhPsi24`, then `QrhPsi24Audit`. The final printed type must have only x and exp35000<=x, and its axiom list must not contain sorryAx or a new unproved analytic input.

The integration worker owns the compiler schedule. No compiler was launched by prime-estimates during this variant preparation. The project artifact root, matched package artifact roots, smaller provider artifact root, and scratch roots for this directory and zero-sum must all be on LEAN_PATH.

## Source hashes before compilation

- QrhPsi24Numeric.lean: 533AF8E7B614361F289393D1144782D493232702D6DA1D00820B3556316A9D4C
- QrhPsi24Aux.lean: 3F57A08207A228F2EA78AE247C9EC184AC06572A9C03268421AFBE4FF6CACB0C
- QrhZeta24Bridge.lean: FA94E76A8617D2AB3C99E8273EBF369FE17E3CD76C8B46C7F9225914C47AA9C9
- QrhPsi24.lean: 592055E5CCB15D8F443B324A6DC77C40D67FCCE2E926C2342727C57017524D62

All finite-range psi/theta/Mertens and major/minor arc obligations remain. This variant targets the far-asymptotic psi theorem only.
