# Exact prerequisites for QrhPsi

This review applies to the owned scratch files after the dependency corrections on 2026-11-10. The two numerical lemmas have already passed compilation and an axiom audit. The analytic files below remain uncompiled.

## Ordered module list

1. Build `TernaryGoldbach.Explicit.PsiAsymp` and `TernaryGoldbach.Explicit.QrhNumeric` in the matched Lean 4.35.0 environment. The checked scanner lists 59 project modules for their union. This supplies `GaussSmooth`, `Xi`, `PsiLarge`, `ZeroSumGen`, and `XiPartial` as dependencies. The canonical numeric module contains the same declarations as the checked scratch numeric file.
2. Compile `ZeroSumStrip` from `agents/zero-sum/ZeroSumStrip.lean`.
3. Compile `QrhPsiAux` from this directory. Its sole project import is `TernaryGoldbach.Explicit.GaussSmooth`.
4. Compile `QrhPsiMid` from this directory. Its sole project import is `TernaryGoldbach.Explicit.PsiLarge`.
5. Supply a fully compiled, compatible `OAI.NumberTheory.DirichletL.Nonvanishing`. The pinned source exports the exact theorem used by the bridge, but currently targets Lean 4.34.1. Its closure comprises 2924 OAI modules plus the documented external dependencies. Compatible artifacts and a transitive axiom audit remain required.
6. Compile `QrhZetaBridge` from this directory. It imports `TernaryGoldbach.Explicit.Xi` and the OAI module in step 5.
7. Compile `QrhPsi` from this directory, then print the type and axioms of `TernaryGoldbach.Explicit.psi_asymp_qrh`.

Steps 2 through 4 are independent once the project imports exist; step 6 additionally needs step 5. This ordering is for serial execution with the integration worker's compiler slot. The scratch artifact directory must be on LEAN_PATH, with `ZeroSumStrip.olean`, `QrhPsiAux.olean`, `QrhPsiMid.olean`, and `QrhZetaBridge.olean` at its root. The project artifact root and matched Mathlib/package artifact roots are also required. The final proof now imports the canonical `TernaryGoldbach.Explicit.QrhNumeric`, so it no longer needs `QrhPsiNumeric.olean`.

The project closure can be verified without invoking Lean by running the integration scanner with the two roots in step 1 and `--scan-only`.

## Verified API and carrier matching

`Explicit/Datum.lean:81` defines `zerosRectD f T` as the zeros strictly inside the rectangle with real interval (-1/2,3/2), filtered from `zerosIn`. `Explicit/Datum.lean:85` defines `multRectD f T u` as `(divB f 2 (RT T) u).toNat`.

`Explicit/ZetaExplicit.lean:173`, `explicit_formula_zeta`, sums over exactly `zerosRectD zetaF (T k)` with coefficient `(multRectD zetaF (T k) u : ℂ)`. The proof draft applies the weighted helper at the same T and f=zetaF. Its local `m u` is exactly the real cast of that same natural multiplicity. The low-zero helper takes that real cast directly. No divisor conversion or equality of multiplicities between different functions is needed.

`sum_weight_zeta_low_le` in `ZeroSumStrip` takes a finite S, membership in `zerosRectD zetaF T`, real-part bounds [0,1], and the inclusive height bound abs(im)<=1e8. It concludes

sum over S of multRectD(zetaF,T,u)*g(u) <= 1e20*C,

when g is nonnegative, C is nonnegative, and g(u)*max(1/8,abs(im(u)))<=C. The draft now supplies T and C explicitly. Its g is norm(Mg a b delta u), and C is 2*exp(delta^2/2+abs(a)). This is exactly the conclusion supplied by `norm_Mg_qrh_strip_le`.

The helper's multiplicity estimate ultimately uses `sum_window_le` with the real cast of multRectD as its weight, the constant complex function 1, and derivative 0. It never assumes the zeros are simple.

## Origin, pole, and strip boundaries

`Explicit/ZetaGrowth.lean:17` defines zetaF by updating `(s-1)*zeta(s)` to 1 at s=1. Consequently the pole contributes to the explicit formula's separate main term `mellin(phi,1)*x`, and is absent from the zero sum.

`Explicit/ZetaZeroSums.lean:39`, `zerosRectD_zetaF_strip`, supplies zeta(u)=0, 0<re(u)<1, and xiF(u)=0. It excludes u=0 using `zetaF_zero_ne_zero`; `zetaF_one=1` excludes u=1. The negative real trivial zeros lie outside the rectangle and are also excluded by the strip classification.

`QrhZetaBridge` applies the exact OAI zeta theorem to obtain re(u)<=7/8. The existing identities `Xi.lean:24` (`xiF_one_sub`) and `Xi.lean:56` (`xiF_eq_zero_iff`) reflect the zero to 1-u. Both strict strip hypotheses for 1-u are now written explicitly. Applying the same upper bound to 1-u gives re(u)>=1/8. Equality at either QRH boundary is allowed throughout the Gaussian estimate.

The Gaussian estimate therefore remains valid at imaginary part zero, since its weight is at least 1/8. It needs no zero-free disk around the origin.

## Remaining exact APIs

| Draft use | Existing declaration owner |
|---|---|
| `norm_intExp_le'`, `norm_cexp_gauss`, `Mg_one` | Explicit/GaussSmooth.lean |
| `norm_cpow_x` | Explicit/ExplicitFormula.lean:765 |
| `norm_integral_hZeta_gsm` | Explicit/PsiExplicit.lean:51 |
| `mid_sum_le`, `MidB0`, `MidBH`, `TailBG` | Explicit/PsiLarge.lean |
| `tail_sum_gauss` | Explicit/ZetaZeroSums.lean:530 |
| `SsumG_one_ofReal` | Explicit/PsiSandwich.lean:181 |
| `exp_small_le`, `log_3e10_le`, `log_10_3_ge`, `Z3g_H_le` | Explicit/PsiPlateau.lean |
| `exp_nat_ge'`, `exp_split_ge'`, `log_le_of_le_exp''` | Explicit/LogNumerics.lean |
| `psi_asymp_of` | Explicit/PsiAsymp.lean:335 |
| `qrh_low_rpow_absorb` | Explicit/QrhNumeric.lean |

The low interval includes height1e8. The next three intervals are (1e8,3e10], (3e10,3e12], and (3e12,Gamma]. The final tail is (Gamma,infinity). Gamma>=3e12 makes these filters disjoint and exhaustive, including Gamma=3e12. The original middle and tail APIs take the same carrier and multiplicity.

## Remaining mathematical and validation work

The source-level review and the independent audit found no missing mathematical lemma in this far-asymptotic assembly. All used theorem names have actual source declarations, and the new helper proofs are present. Compilation can still expose elaboration or proof-script defects. The OAI source needs compatible compiled artifacts and its axiom audit. This is a substantive dependency build, not a replacement by a hypothetical QRH premise.

Once the final file compiles, the exact type must have only x and the lower bound exp(35000)<=x. Its axiom list must contain no sorryAx or new axiom. The finite-range psi/theta/Mertens obligations documented in REPORT.md remain beyond this theorem.

