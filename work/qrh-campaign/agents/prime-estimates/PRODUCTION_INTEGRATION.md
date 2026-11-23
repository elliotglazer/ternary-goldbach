# Production integration plan for the local fixed-gap psi theorem

Source audit against work/ternary-goldbach at23b2d68ca344203d4384e0aff7affa4ec034bef9. This plan does not edit canonical source. The fixed-gap proof scripts and their local analytic prerequisites are still awaiting compilation.

> Scope update: RANGE1_FIXED.md now describes an additional tight-coefficient proof that can also remove Platt from psi_range1_err8 and psi_range1_8 after compilation. The retained-Range1 entries below describe the earlier coarse exp(35000)-only tranche.

## Exact production consumers

A repository-wide Lean search found exactly one proof application of `psi_asymp8` outside its definition:

- `Prelim/ThetaExplicit.lean:691`: `have hA := psi_asymp8 hxe`, in the `log x >=35000` branch of `theta_explicit`.

The same file opens the name at line23 and documents it at line15. `TernaryGoldbach.lean:595` imports the module, but does not apply this theorem. No use of `@psi_asymp8` or an explicitly supplied Fact argument was found. Keeping the public name therefore avoids all caller edits.

Within `Explicit/PsiAsymp.lean`, the current `psi_asymp8` starts at632, with its local `variable [Fact TernaryGoldbach.PlattGRH] in` immediately above it. Its single Platt route is the `rh_upto_1e8` argument to `tsum_gsm_le_zf3H` at637. The generic `psi_asymp_of` at335 already has no Platt parameter. `sqrt_big` at313, also called directly by ThetaExplicit at692, is already unconditional.

## Recommended minimal, cycle-free integration

Preserve the existing `PsiAsymp` module, public name, generic proof, and all numeric helper names. Do not make it import the current complete scratch `PsiFixed`: that file imports PsiAsymp and would form a cycle.

1. Land the compiled local zero lemmas as upstream Explicit modules: `ZetaLowUnconditional`, `ZeroFreeFixedGap`, and `ZeroSumStrip`, preserving the audited statements and names. Their imports must not point to PsiAsymp.
2. Land the compiled `PsiFixedNumeric` and `PsiFixedAux` helpers as upstream modules. The numeric file needs only Mathlib. The Aux file needs only GaussSmooth.
3. Factor the first two declarations of scratch `PsiFixed.lean` (`SsumG_gsm_err_fixed`, `tsum_gsm_le_fixed`) into a production `Explicit/PsiFixedFormula.lean`. Its project imports can be `PsiLarge`, `PsiFixedAux`, `ZeroFreeFixedGap`, and `ZeroSumStrip`. It must not import `PsiAsymp`.
4. Import `PsiFixedFormula`, `PsiFixedNumeric`, and the existing draft half-middle estimate into `PsiAsymp.lean`. The latter can be landed as `Explicit/PsiFixedMid.lean`; it imports only `PsiLarge`. Alternatively add that one declaration next to the current `MidB0_8_asymp_le` without changing the old statement. Keep the old helper for API stability.
5. Replace only the final `psi_asymp8` proof by the body of scratch `psi_asymp_fixed`, and remove its local Fact binder. The final call to `psi_asymp_of` remains in the same module as that generic theorem. Update the final theorem's docstring to describe the local fixed-gap proof rather than RH below1e8.
6. If preserving the new name is useful, add an unconditional alias `psi_asymp_fixed := psi_asymp8` after the production theorem. The alias is optional; no current production consumer needs it.

No existing generic declaration needs to move. No PsiAsympCore split is required. No import or proof line in ThetaExplicit needs to change. The aggregate import file needs new lines only if repository convention requires importing every module explicitly; existing transitive imports already expose these declarations.

The dependency direction is:

    GaussSmooth -> PsiFixedAux
    ZeroFreeRegion + ZetaLowUnconditional -> ZeroFreeFixedGap
    PsiLarge + PsiFixedAux + ZeroFreeFixedGap + ZeroSumStrip -> PsiFixedFormula
    PsiLarge -> PsiFixedMid
    Mathlib -> PsiFixedNumeric
    PsiRange1 + PsiFixedFormula + PsiFixedMid + PsiFixedNumeric -> PsiAsymp
    PsiAsymp -> ThetaExplicit

Here arrows mean prerequisite-to-consumer. `PsiLarge` imports `PsiPlateau`, which imports `PsiExplicit` and `LogNumerics`; `PsiExplicit` imports `ZetaZeroSums`, `PsiSandwich`, and `ExplicitBoundGen`. These supply every pre-asymptotic API used in the two fixed formula declarations. `psi_asymp_of` and `sqrt_big` are needed only in the final assembly, not in PsiFixedFormula.

The absolute smallest temporary sidecar integration would keep scratch PsiFixed importing PsiAsymp and change ThetaExplicit's import/call to the new theorem. That avoids a cycle but leaves the public `psi_asymp8` conditional and performs less useful API cleanup. The recommended split above removes its premise while preserving every production caller.

## Which existing signatures can lose Platt now?

Once the new proofs compile and pass exact-type and axiom audits:

| Declaration | Result of this integration |
| --- | --- |
| Explicit.psi_asymp8 | Remove Fact PlattGRH; exact x-range and conclusion unchanged. |
| Explicit.psi_asymp_of | Already unconditional; unchanged. |
| Explicit.sqrt_big, MidB0_8_asymp_le, LineBH_le_LineB | Already unconditional; unchanged. The last two may become unused by psi_asymp8, but need not be removed. |
| Explicit.psi_range1_err8 / psi_range1_8 | Retain Fact. Their range starts at exp20000 and they directly use rh_upto_1e8. |
| Explicit.psi_plateau8 | Retain Fact. Its range starts at1e17 and directly uses low-height RH. |
| Prelim.psi_two_sided | Retain Fact for its full12<=n<=1e17 statement; generated finite-range branches use RH. Separate small-range removals are another worker's work. |
| Prelim.theta_le_cB, psi_sub_theta_le_cB, theta_mid | Retain Fact because of psi_two_sided and finite-range inputs. |
| Prelim.theta_explicit | Retain Fact; only its last branch is made unconditional by this change. |
| Prelim.thetaN_large | Retain Fact; it wraps theta_explicit on the fulln>=1e12 range. |
| Sch.rho_le and rho_le_epl / rho_C5 path | Retain Fact for their full ranges; they use theta_explicit and finite psi bounds. |
| MertensProduct.psi_err, E1_core, E1_diff, E1_local, E1_var, F_large, F_mid, div_totient_lt | No premise removal follows from this change alone. |

These statements do not claim that every retained premise is mathematically unavoidable. They mean the unchanged production proof still invokes conditional facts or contains unhandled ranges. Removing a Fact annotation from a file or imported module is not enough: the exact final theorem type must be checked.

## ThetaExplicit branch audit

`theta_explicit` has domain n>=1e12 and bound

    |theta(n)-n| < n/log(n)^3 + epl(n)*n.

Its proof branches are:

| Range | Source input | After psi_asymp8 integration |
| --- | --- | --- |
| 1e12<=n<=1e17 | theta_mid (line527), using psi_two_sided and psi_sub_theta_le_cB | Still conditional. |
| n>1e17, logn<=120 | psi_plateau8 (line568) | Still conditional. |
| 120<logn<20000 | psi_plateau8 (line662), epl=4.92e-7 | Still conditional. |
| 20000<=logn<35000 | psi_range1_8 (line674) | Still conditional. |
| logn>=35000 | psi_asymp8 (line691), sqrt_big (line692), unconditional psi-theta comparison | Unconditional. |

The fixed theorem does not cover [exp20000,exp35000). Merely using it on the upper tail of psi_range1_8 cannot remove that theorem's Fact parameter. If needed later, the last ThetaExplicit branch can be extracted as a new unconditional far-asymptotic theta theorem, for example with `exp35000 <= (n:Real)`. Such an extracted theorem would be a new restricted-range API, not the full existing theta_explicit statement.

## Why Mertens remains conditional

The direct wrappers from theta_explicit are LambdaMu.thetaN_large at82, SchoenfeldJ.rho_le's large branch at59, and SchoenfeldTailAux.rho_le_epl at159. LambdaMu also directly uses psi_two_sided throughout its finite-range bounds. Therefore its downstream Mertens statements retain those dependencies.

In addition, MertensProduct.E1_win_num at531 invokes Explicit.rh_upto_1e8 directly at545 in its window calculation. Replacing far-asymptotic psi does not touch that independent input. E1_diff begins atlog M>=20000, below the new theorem's threshold, and derives from global psi_err. F_mid explicitly covers1e5<=x<1e12. Thus no complete Mertens product or totient-bound signature loses Platt merely from this integration.

## Focused validation after landing

First compile the audited new upstream modules and the modified PsiAsymp. Print the type and axioms of `psi_asymp8` and optional alias. The expected public type contains only x and exp35000<=x; checking axioms alone does not detect a retained Fact binder.

Then compile the only direct consumer ThetaExplicit, confirming its retained Fact parameter is intentional and its final branch elaborates unchanged. Existing broader builds can proceed through the integration scheduler; no full rebuild was launched for this planning task.

