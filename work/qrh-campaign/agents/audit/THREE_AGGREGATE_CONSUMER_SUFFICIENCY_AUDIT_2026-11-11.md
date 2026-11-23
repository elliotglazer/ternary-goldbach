# Three aggregate targets and the R132900 consumers

2026-11-11. Independent source-mathematics audit. No Lean declaration, build, axiom scan, prime or L-function evaluation was performed. This is a conditional sufficiency map, not an approved declaration graph or an assertion that the proposed quantitative bounds hold.

## Verdict

At the inspected source-mathematics boundary, the three proposed targets suffice to replace the genuinely nonprincipal uses of PlattGRH in the selected R132900 route, provided the principal RH input through the closed height 10^8 and the other original analytic and finite inputs are retained. No fourth genuinely nonprincipal estimate was found in the final consumer paths described below.

There is an important distinction in this statement. The proposed weighted star moment is an estimate of an actual full residual, not just its nonprincipal character component. Proving only a nonprincipal portion of that moment would leave an additional principal/removal assembly obligation. The target used here is exactly the full Wstar in the root contract.

None of the three quantitative targets is proved by this audit. The present Lean wrappers still require `Fact PlattGRH`; their conclusions cannot be reused without that premise merely because only one component is wanted. The localized refactors, natural-cutoff assembly, finite certificates, and compatible kernel validation remain work. A final unconditional theorem must discharge the new targets and the retained principal input internally. They are not permitted as new permanent premises of the final Statement.

## Exact replacement inputs

Fix R=132900, real x>=4.9e26 and y=x/49>=10^25. Keep the actual smoothing functions, von Mangoldt coefficients, coprime removals and source Fourier convention. All bounds below are uniform in the unbounded real scale; no sampled-grid interpretation is sufficient.

The plus target is the Gauss-weighted coprime character energy E_q<=7.02e-13 from `DIRECT_PLUS_RESIDUAL_ENERGY_TARGET`. It holds for every positive q with qt(q)<=265800 and every real delta with |delta|<=1063200/qt(q). It is a sum of squares over unit numerators after character Parseval, not a normalized average over those numerators. With the retained principal residual and removals it gives

    sum_(b in Bset q) |Sp(q,b,beta)-Ap(q,beta)|^2 <= (rho*x)^2,
    rho=8.85e-7, |beta*x|<=8R/qt(q).

Here Ap=(mu(q)/phi(q))*Fourier(etaPC)(-beta*x)*x, and Sp is the full source prime sum. The principal coprime error is at most 2.83e-7*x; the outer removal is at most 1e-15*x. The direct-energy proof supplies the smaller squared residual bound 7.83e-13*x^2, below rho^2*x^2. It does not need the older nonprincipal pointwise constant in `ArcChars`.

On the finite tagged arc space, define Ss as the full star sum, As=(mu(q)/phi(q))*Fourier(etaUC)(-beta*y)*y, rp=Sp-Ap and rs=Ss-As. The star target is

    49^2 * Wstar/x^3 <= 8.79*(3.67e-6)^2,
    Wstar = integral |Sp|^2*|rs|^2.

This is a genuine mixed moment. Separate unweighted second moments, character averages or a bound on a differently normalized residual cannot be substituted. Wplus=integral |As|^2*|rp|^2 follows from the plus target as explained below.

The base-gap target is E_U,m(y,d)<=.029^2, with the exact coprime coefficients and inverse-character labels in `AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET`. Its original modulus is m, not the reduced denominator m/gcd(m,2). Its ranges are

    odd m:  1<=m<=R,  4R/(49m)<=|d|<4R/m;
    even m: 2<=m<=2R, 8R/(49m)<=|d|<8R/m.

Both signs and the closed lower boundary are required. For m=1 or 2 the nonprincipal energy is zero, but the principal contribution still needs its estimate. The target does not assert an unrestricted primitive-conductor energy without the necessary coprime-removal conversion.

## Upper major energy and the cubic comparison

The root `PLUS_RESIDUAL_TO_MAJOR_L2_UPPER` argument supplies the upper major energy independently of the old bundled `L2Major` theorem. Put Z=integral |rp|^2, X=integral |Sp|^2 and Y=integral |Ap|^2. The interval lengths give

    Z <=16R*rho^2*x*sum_(q in Qset R) 1/qt(q).

There is no extra factor phi(q), since the residual hypothesis already sums over b. For natural 1<=R<=150000, the odd/even description of Qset gives this reciprocal sum at most H_R<=19. Thus Z<.006^2*x. The source Fourier integral and mass upper bounds give Y<=a*x with a=.640208*13.59756<2.951^2. Finite-measure L2 Minkowski gives X<2.957^2*x<8.79*x.

Since As is independent of b, the same plus hypothesis and the source star Fourier L2 estimate give

    Wplus <=rho^2*x^2*2.85*7.78*y,
    49^2*Wplus/x^3 <=49*rho^2*(7.78*2.85).

The actual identity

    Sp^2*Ss-Ap^2*As = Sp^2*rs+As*rp*(Sp+Ap)

then gives the integrated error bound

    sqrt(X*Wstar)+(sqrt(X)+sqrt(Y))*sqrt(Wplus).

The reviewed exact AM-GM comparison bounds this by the original cubic error allowance after normalization by x^2/49. The existing Fourier-tail allowance is unchanged. This bypasses the nonprincipal calls in `ArcCharsStar.arc_chars_star` and the old pointwise star interface in `MajorTotal.resid_star`, `pointwise_bound` and `per_modulus`. It does not bypass the main-term, singular-series or physical-arc assembly.

For the unchanged tail comparison, q in Qset R gives w_q*x=8R/qt(q)>=4. The source geometry inequalities 8R<=x and 16R^2<=x hold on the stated range. The periodic physical integral must still be identified with the tagged integral using disjoint arcs and integral N; tagged summation alone does not justify physical double-counting.

## The lower major energy needs no further nonprincipal bound

This is the main potential hidden dependency. `L2Major.Jq_bounds` returns both lower and upper bounds under a broad Fact. Its proof obtains a bundled `ArcChars.arc_chars` conclusion, so calling its lower projection unchanged would retain the unwanted premise. The mathematical lower proof is narrower.

`ArcChars.sum_units_sq_bounds:192` starts from exact finite character Parseval. The principal projection gives

    mPhi(q)*|principal coprime sum|^2
       <=sum_(b in Bset q) |coprime additive sum|^2

by nonnegativity of the omitted character squares. No upper bound on any nonprincipal character enters this inequality. In `L2Major.lean:169-224`, the lower proof combines this projection, the principal error Cp=(2.83e-7*x)^2, and the outer removal Cb=(1e-15*x)^2 with t=1e-4. The quantity Cn=(4.25e-7*x)^2 enters only the upper half. This is visible in the separate expressions A0lo and A0hi and in the final lower proof using `hlo` rather than `hhi`.

The principal approximation in `ArcChars.lean:445-469` comes from `Thm714.thm_7_1_4_one`, plus the same removal. The latter theorem uses only the principal character modulo 1 and a height at most 10^8. Its nonprincipal odd/even sibling theorems are unnecessary for the localized lower projection.

For a smaller natural cutoff, redo the source interval argument with w=8R/(qt(q)*x). The inequalities w*x>=4, 2w<=1200000/x and q<=300000 used in the per-modulus lower calculation remain valid. Hence one can retain

    J_R/x >=(.63907-.000962)*M_R-3.6e-9*300000,
    M_R=sum_(q in Qset R) mPhi(q).

The source-mass certificate supplies a positive lower bound on M_R at R132900. It is not legitimate to restrict the old lower bound 8.6296*x from the larger arc set. The new lower value is the one already used in `source_mass_joint_cutoff_20261111.py:78-83`.

`MinorTotal.I0_ge:277` needs only this lower J bound. Its other input is the nonprime coefficient energy E<=8e-11*x. The exact argument with t=1e-5 yields

    I_R/x >=(J_R/x-(1+1e5)*8e-11)/(1+1e-5).

Therefore neither a new nonprincipal lower-energy hypothesis nor the old nonprincipal upper constant is needed for I_R. The bundled `PartIICited.l2_major_14_7` must be replaced by this one-sided result.

## Base gap and the other minor-arc paths

The reviewed base-gap character expansion gives a nonprincipal contribution at most sqrt(E_U,m), after paying the exact character dimension. Retain the principal-only Cor933 estimate e1<2e-6 and the removal d0=2e-9. The source Fourier main term is less than .000544 on the parity-sensitive gap. The complete result is

    |S etaStar x alpha|/y < .029+.000544+.000002+.000000004
                            =.029546004 <.03<ghatY(y,R).

This meets the actual `MinorTotal.lean:395-403` requirement. It does not preserve the older sufficient .014 guard, and no statement should claim that it does. The old guard is used only to establish the ghat envelope, not as a separate factor in the final scalar budget. The R132900 lower ghat bound is 435635673/13700000000>.03. `BaseGap2.gap_point` must retain its original-modulus parity witness and both endpoint conventions.

The remaining paths were checked separately:

| Consumer path | Actual input retained | Consequence for nonprincipal replacement |
|---|---|---|
| `PartIICited.cor_7_1_3` to `BaseGap2` | Localize Cor933 to modulus 1 for the principal term; use E_U for the rest | No nonprincipal Cor713 call remains |
| `PartIICited.prop_7_1_5` to `MinorTotal.T_le:216` | `Prop715:365` uses principal RH only, and only height 500 | No additional family certificate |
| `MinorTotal.norm_sq_sum_a₂_le:138` through `EBound.E_le_14_28:278` | Principal Chebyshev/nonprime estimates and their finite arithmetic inputs | Preserve these inputs; no nonprincipal character estimate found |
| `LinftyLevels.norm_S_etaStar_le_ghat:358`, the off-arc levels in `MinorTotal:406` | Type I/II estimates, smoothing, and totient estimates | The Platt-bearing totient/psi route uses principal RH, not nonprincipal RH at the unbounded arithmetic modulus |
| `MinorTotal.norm_S_etaStar_le_uniform:49` | Unconditional 22.75*y bound | Used for coefficient-removal error; insufficient for the base gap itself |
| `Helfgott.Inputs.nonprime_input:126` and representation extraction | The existing elementary nonprime bound and positivity argument | No nonprincipal spectrum input |
| `Helfgott.SmallCases` | Original inclusive BinaryGoldbachInput and finite ladder/coverage | No PlattGRH dependency to replace |

The minor off-arc levels and arithmetic estimates have unbounded parameters. Their localization must retain those quantifiers; bounding their arithmetic moduli by R would change the theorem. Principal RH through 10^8 is used to prove some estimates uniform over arbitrarily large arithmetic moduli, which is different from assuming RH for characters at all those moduli.

## Principal localization and final assembly

The retained spectral premise is the actual source principal `GRHUpTo` through closed |Im s|<=10^8 on 0<Re s<1, or an explicitly proved equivalent zeta formulation. This audit does not establish that finite certificate. The following source uses require explicit replacements for the broad Fact accessor:

* `Thm714.thm_7_1_4_one:572-590` uses principal RH at a smaller required height, bounded by 10^8 over |delta|<=600000.
* `Cor713.cor_7_1_3':807-835` is localized through the explicit Cor933 theorem at modulus 1. The base-gap twists satisfy |d|<4R<1.2e6.
* `Prop715.prop_7_1_5:356-365` uses only principal RH through 500.
* `Explicit/ZetaZeroSums.rh_upto_1e8:29` supplies the principal Chebyshev, E1/Mertens and finite-calculus descendants. Those descendants and their finite numerical hypotheses remain required.

The targeted source-use trace through GRH accessors finds the nonprincipal extractions in the odd/even Thm714 and Cor713 branches already accounted for above. This is source triage supported by body inspection, not a machine-checked transitive dependency or axiom closure claim.

After these localizers, rebuild `MajorTotal.major_total`, `MinorTotal.minor_total`, `Helfgott.Inputs.major_arcs_input/minor_arcs_input` and the large-N assembly with the selected cutoff. The source still hardcodes R150000 and the separate 1.049/1.0376 bounds. The R132900 argument instead uses its checked mass, singular-series lower bound, nine minor cells and the asymptotic range in one joint budget. The integrated cubic replacement spends no additional reserve in that budget. The weaker base-gap target still proves its required ghat envelope.

The selected scalar route also retains the x,N scale relation and the lower threshold N0=989*10^24. Restricting a proved result at that threshold recovers the requested `TernaryGoldbachFrom(10^27)`. The original full Statement still has only its original inclusive BinaryGoldbachInput through 4e18. Other proposed finite-coverage efficiency schemes are not silently adopted here.

The exact remaining targets are therefore: prove the full-domain plus energy; prove the full mixed Wstar moment; prove the parity-domain base-gap energy; discharge the principal closed-height certificate and retained finite inputs; implement and validate the localized source implications and R132900 joint assembly. There is no identified need to construct the global QRH provider, the full nonprincipal RH family, or a separate pointwise star residual for this conditional replacement route. This conclusion is not evidence that the three proposed bounds are true or cheap to prove.

## Evidence binding

The following source and report hashes bind this audit. Source line references above refer to these exact bytes. Paths are relative to the workspace unless otherwise indicated. Existing frozen reports remain unchanged.

| Report or source | SHA256 |
|---|---|
| [DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md) | E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1 |
| [PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md) | F3EBC1B68CC57B607496D9E6445137A08A0F17C3202D986301F8EC25F14F4663 |
| [INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md) | 943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128 |
| [REVIEW_INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/REVIEW_INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md) | 9F9A63CE08823181851D0C169039CD79AF00295C1B4666ED5B7D799F05946197 |
| [AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md) | CFDA417AFFF112EBDF7BBB822FE7C884F3F8FCB4307BBC2F5AAC3B6856D5D264 |
| [REVIEW_AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/REVIEW_AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md) | 6CCB25A6C2736504943926B09A2DFB9BEA6D0F00BDB2BF96C74844F4FC66C06F |
| [EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md) | 429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D |
| [ORIGINAL_RH_CONSUMER_DOMAIN_RESEARCH_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/independent-feasibility/ORIGINAL_RH_CONSUMER_DOMAIN_RESEARCH_2026-11-11.md) | AC14194BAB999170E7444DD0EDAA0285A3758942681AB44E4E2047CF8A87D48C |
| [EFFICIENCY_REDUCED_RH_REFACTOR_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/EFFICIENCY_REDUCED_RH_REFACTOR_2026-11-11.md) | 727DD8FD825FE1089FFED3B9E69AAD34528F2F8B37AC1741B238708A7E40DAE1 |
| [MajorArcs/GRH.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/GRH.lean) | 89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070 |
| [MajorArcs/ArcChars.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean) | 0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF |
| [MajorArcs/ArcCharsStar.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcCharsStar.lean) | B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10 |
| [MajorArcs/L2Major.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/L2Major.lean) | 8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC |
| [MajorArcs/MajorTotal.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean) | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| [MajorArcs/Thm714.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean) | 7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F |
| [MajorArcs/Cor713.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor713.lean) | 11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433 |
| [MajorArcs/Prop715.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop715.lean) | CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0 |
| [Explicit/ZetaZeroSums.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaZeroSums.lean) | 21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA |
| [MinorArcs/BaseGap.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap.lean) | ABF8667E1A8D5C72AA81F1B3F40481933A1ABC5A1CE3FAA0BE9705AC8CAF418B |
| [MinorArcs/BaseGap2.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean) | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| [MinorArcs/PartIICited.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/PartIICited.lean) | 0447F5A3D00DBB6B11CEA1A729FA4CCA2FEF993A8242574D2241A33195B14D30 |
| [MinorArcs/MinorTotal.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/MinorTotal.lean) | 6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742 |
| [MinorArcs/EBound.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/EBound.lean) | EB4A44BA2A0422BC346A73EED0828BDD32AF9597F24515ED763331DFF776F17F |
| [MinorArcs/LinftyLevels.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/LinftyLevels.lean) | 12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409 |
| [MinorArcs/GBound.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/GBound.lean) | 79070A7DD3B3B755A34C3C39690674193CBCF439238D763EB4982889E5B52491 |
| [Prelim/LambdaMu.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Prelim/LambdaMu.lean) | 45A40A3209665061FF2F4F28F7CDDD1C012BCEE66FA90E555859A22D38D8568E |
| [Prelim/MertensProduct.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Prelim/MertensProduct.lean) | 8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F |
| [Helfgott/Inputs.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean) | 5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83 |
| [Helfgott/Main.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Helfgott/Main.lean) | DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D |
| [Helfgott/SmallCases.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean) | 61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359 |
| [MainTheorems.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MainTheorems.lean) | 4B2BDB187A2D9AC485239611EEE99D1C716C5BC0F57F1946DAA32CBD22FECFFF |
| [source_mass_joint_cutoff_20261111.py](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/prime-estimates/source_mass_joint_cutoff_20261111.py) | F243DD01285D8FA78F72A38AFFF1F2842436D4110F1E7B616B2111DB6712488A |
