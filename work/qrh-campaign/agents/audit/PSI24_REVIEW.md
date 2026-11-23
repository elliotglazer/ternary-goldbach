# 23/24 far-asymptotic source audit

Reviewer: independent worker 8. Date: 2026-11-11 UTC.
Review status: source-level mathematical and statement comparison only. No Lean compiler was run.

## Identity checks

The four hashes recorded in DEPENDENCIES24.md match the current files exactly:

| File | SHA256 |
| --- | --- |
| QrhPsi24.lean | 592055E5CCB15D8F443B324A6DC77C40D67FCCE2E926C2342727C57017524D62 |
| QrhPsi24Numeric.lean | 533AF8E7B614361F289393D1144782D493232702D6DA1D00820B3556316A9D4C |
| QrhPsi24Aux.lean | 3F57A08207A228F2EA78AE247C9EC184AC06572A9C03268421AFBE4FF6CACB0C |
| QrhZeta24Bridge.lean | FA94E76A8617D2AB3C99E8273EBF369FE17E3CD76C8B46C7F9225914C47AA9C9 |

Additional reviewed dependencies:

| File | SHA256 |
| --- | --- |
| agents/zero-sum/ZeroSumStrip.lean | 01796745F1BB58E9F1F1200765DFE2666013D7FE8040008CB8DC492F8BCBE2FC |
| QrhPsiMid.lean | 15D2C00897D4518F5FC25DD1775E0C7B4412E7921C6BF6E8D8013B9AFDBA4912 |
| OAI/NumberTheory/DirichletL/RowCompletion/ZeroFreeRegion.lean | 11294CEF701D07CB76E088A4A01A182442E749FCADC3B7449C9D4C2C8EAC97C6 |

OAI checkout HEAD is 4eaee87548250b2682affda7d05d947c05554bae. The ternary source comparison remains pinned at 23b2d68ca344203d4384e0aff7affa4ec034bef9.

QrhPsiMid now imports PsiLarge rather than PsiAsymp. Its mathematical statement and reviewed half-budget proof remain unchanged. No author-approved frozen manifest was supplied; these file identities do not confer frozen or proved status.

## Verdict

No mathematical defect found in the displayed 23/24 variant. It preserves the exact far-asymptotic target, derives the necessary pole exclusions and closed zero strip, preserves divisor multiplicities, and fits the same consumer budget using the degree-20 exponential lower bound.

The smaller provider and full assembly remain uncompiled. No axiom-closure or proof-completion claim is made. Source dependency counts in DEPENDENCIES24.md were not independently re-enumerated in this review.

## Exact target and logical inputs

QrhPsi24 declares:

    TernaryGoldbach.Explicit.psi_asymp_qrh24
      {x : Real} (hx : exp(35000)<=x) :
      |psiR x-x| <= .2*x/(log x)^3.

This matches the original PsiAsymp.psi_asymp8 conclusion, real carrier, inclusive threshold, constant .2, exponent3, and existing psiR definition. The original scoped Fact PlattGRH is absent.

| Expanded input | Bin | Reason |
| --- | --- | --- |
| x : Real, implicit | TYPING | Same carrier and implicitness as original |
| exp(35000)<=x | SOURCE | Same inclusive domain as original |
| Other mathematical input | None | No QRH, error-bound, or Platt premise remains in the displayed final type |

Counts: SOURCE1, STANDING0, TYPING1, RULED0, EXCESS0. This is a source-fidelity comparison, not a passing frozen audit.

The generic smoothed-sum helpers retain delta>0, b<=a, b<=0, x>1, Gamma>=3e12, and delta^2/2+|a|<=1e-6. These are supplied by the unchanged psi_asymp_of interface inside the final proof. They are not added to its public conclusion.

## Provider and pole exclusion

The actual provider export at RowCompletion/ZeroFreeRegion.lean:210-213 is

    OAI.ShortDraft.riemannZeta_ne_zero_of_re_gt
      (s : Complex) (hs : 23/24 < Re(s)) (hs1 : s!=1) :
      riemannZeta(s)!=0.

The imported ShortDraft.DirichletTarget at Arithmetic/EisensteinCoordinates.lean:253 expands to nonvanishing for every positive modulus and character to the right of23/24, excluding the principal pole. It does not conceal a further source premise. The export is outside the earlier local-variable namespace/section, so no visible row-model or finite-type assumption leaks into its declaration.

The upper bridge assumes a zeta zero and Re(s)<1. If s=1, its real part is1, contradicting the strict inequality. Thus s!=1 is proved and the provider is applicable under the negation of Re(s)<=23/24.

For the lower bound, the bridge uses the existing facts

    xiF(s)=0 iff zeta(s)=0  when0<Re(s)<1,
    xiF(1-s)=xiF(s).

From0<Re(s)<1 it derives0<Re(1-s)<1. This supplies both the reflected zero equivalence and the reflected pole exclusion. The upper bound at1-s becomes1-Re(s)<=23/24, hence Re(s)>=1/24. No conjugation or zero-multiplicity transport is assumed.

The source zerosRectD_zetaF_strip already supplies a zeta zero in the strict strip for each rectangle zero. It excludes the origin, trivial zeros, and the pole. The final theorem therefore has no residual pole premise.

## Mellin and denominator24

The auxiliary statement is

    ||Mg a b delta s||*max(1/24,|Im(s)|)
      <=2exp(delta^2/2+|a|)

for b<=0 and1/24<=Re(s)<=23/24.

Its proof is valid for every real delta. The closed strip implies s!=0, Re(s)^2<=1, and max(1/24,|Im(s)|)<=||s||. The source exact Gaussian norm formula bounds its exponential factor by exp(delta^2/2). The integral factor is bounded by
(exp(a Re(s))+exp(b Re(s)))/||s||, whose numerator is at most2exp(|a|). No assumption b<=a is needed for this isolated norm estimate, although the smoothing consumer separately has it.

The new weighted helper assumes g>=0, C>=0, and
g(u)*max(1/24,|Im(u)|)<=C. Consequently g(u)<=24C. With the unchanged rectangle multiplicity count at most1e18,

    sum multiplicity(u)*g(u)<=24*1e18*C<=1e20*C.

This is the same finite zero carrier and original natural divisor multiplicity as in the explicit formula. No factor24 is lost. The final low estimate uses C=2exp(delta^2/2+|a|)<=4, so its coefficient is at most4e20 and is safely bounded by1e24.

For x>1 the upper strip bound gives x^Re(u)<=x^(23/24), replacing the former exponent7/8 honestly.

## Degree20 numerical replacement

For L>=35000, the required absorption

    1e24*exp(23L/24)<=5e-5*exp(L)/L^3

is equivalent to

    2e28*L^3<=exp(L/24).

The nonnegative degree20 exponential term supplies

    exp(L/24)>=(L/24)^20/20!.

The exact integer comparison

    2e28*20!*24^20<=35000^17<=L^17

then gives the result after multiplication by L^3 and division by20!*24^20. I independently evaluated the first inequality using Python integers and Fraction; it is true, with right/left ratio approximately907.3551471296053. The floating-point ratio is diagnostic only; the inequality check was exact.

The rpow corollary correctly uses x>=exp35000 to derive x>0 and log(x)>=35000, then exp(log(x))=x and x^(23/24)=exp(23log(x)/24). No extra positivity or logarithm premise is hidden.

## Complete assembly and unchanged pieces

The reviewed QrhPsi24 body retains the five disjoint pieces

    |gamma|<=1e8,
    1e8<|gamma|<=3e10,
    3e10<|gamma|<=3e12,
    3e12<|gamma|<=Gamma,
    Gamma<|gamma|.

The lower endpoint of each later bin is strict and upper endpoint inclusive. Gamma=3e12 produces an empty fourth bin. Every term retains the original multiplicity. The bounds are uniform in the outer rectangle height, allowing the existing explicit-formula good-height limit to be used without an unjustified infinite-sum interchange.

The three middle-bin estimates, Gaussian tail, contour remainder, real-sum conversion, and final psi_asymp_of call agree with the previously reviewed7/8 assembly. They use the unconditional source interfaces documented in PSI_ASSEMBLY_REVIEW.md.

The new degree20 absorption gives5e-5*x/log(x)^3. The unchanged first-middle-bin half-budget gives another5e-5*x/log(x)^3. Their sum is exactly the existing1e-4 allowance in psi_asymp_of. Adding the nonnegative sqrt(x)*LineB term merely matches that interface; it does not claim the low zeros satisfy a critical-line estimate.

A scan of the four new files and the weighted helper finds no Fact PlattGRH, RHBelow input, custom axiom, or sorry. The direct source path does not call rh_upto_1e8 or psi_asymp8. Imports of modules containing conditional theorems are not themselves a hidden assumption.

## Remaining verification

The source-level result still needs:
- compilation of the degree20 numerical helpers and exact type/axiom inspection;
- compilation of the denominator24 weighted helper and Mellin bound;
- a compatible build and transitive axiom audit of the actual smaller OAI provider;
- compilation of the bridge and complete QrhPsi24 assembly;
- an exact-type composition witness for psi_asymp_qrh24 with only x and hx.

The compiled7/8 numerical theorem does not certify the new degree20 proof, and the presence of a complete script does not certify elaboration. Even a successful far-asymptotic theorem would not discharge the finite-range prime estimates or the Goldbach threshold1e27.

Only this audit report was written; other workers' source files were not edited.

