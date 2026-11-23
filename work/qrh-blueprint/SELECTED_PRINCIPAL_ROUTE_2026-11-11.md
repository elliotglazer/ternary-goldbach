# Selected principal route after the damped psi proof

2026-11-11. Research strategy amendment. This selects an independently reviewed conditional paper argument; it is not a Lean declaration, an approved declaration anchor, a proved dependency graph, or a new spectral certificate. Adoption is subject to the independent amendment review recorded in the research ledger.

## Change to the selected strategy

Replace section 4 and the principal-moment dependency in section 5 of the immutable [selected strategy](../../outputs/qrh-blueprint-next/SELECTED_STRATEGY.md) with the damped psi route below. All other requirements survive unless a separately accepted amendment explicitly replaces them. The frozen strategy's SHA256 is `E07683A017B922BC309E26763A821E97CAC7AE79938A19CCBF843E9205CABBF7`; its bytes are not changed.

The extra principal strip `[.4968,.5032]` through height `10^6`, the old intermediate `.49 <= beta <= .51` premise, and the weighted moment `W35 <= 24` cease to be selected requirements. Their historical proofs, evaluator plans and local numerical evidence remain intact. No claim is made that the omitted strip or moment has been proved.

This change follows from two independent results: the accepted complete replacement psi argument and the accepted conditional dependency cut. The latter showed that, after the separate P4 repair, the extra strip and moment had no other selected consumer. Its condition is now met at paper-proof scope. Neither result removes the shared principal strip through height `60343058`.

## Retained inputs and new analytic argument

Retain all three head facts, with actual analytic multiplicities and closed height `A=1500`:

* Every nontrivial principal zero with `|Im rho| <= A` lies on the critical line.
* The positive-ordinate count is `N(A)=1069`.
* The positive-ordinate sum `Q_A = sum m_rho * (1/Im rho - 1/A)` is strictly below `417/250 = 1.668`.

The last two imply the positive head reciprocal bound `sum m_rho/Im rho < 3571/1500`. Qualitative RH does not imply the quantitative head moment. Existing external evidence must still be replayed formally. The stronger external head through 2000 is optional; the selected new estimate needs no data on `(1500,2000]`.

Retain the shared principal strip `[89/200,111/200]` through `H=60343058`, the genuine global seven-eighths provider with reflection, and the unconditional analytic count majorant. No strip assertion at height above H is inferred from the count bound. Every one of these inputs is an internal proof obligation, not a new final theorem premise.

For `L=log x` in `[22.33,35]`, set `delta=.002/(L*sqrt(L+10))`. The [main proof](../qrh-campaign/agents/prime-estimates/PSI_DAMPED_SHARED_STRIP_2026-11-11.md) retains Gaussian ordinate damping in the finite zero sum. It enlarges each nonnegative finite majorant to a complete closed-height carrier, transports the true orders, and pairs `rho` with `1-conj(rho)`. It replaces `1/|rho|` by `1/|Im rho|` before pairing. Real zeros are excluded using the retained head and the existing nonvanishing at one half.

The finite Abel identity preserves both endpoints and the exact subtraction `N(A)=1069`. Extending a positive scalar integral to infinity bounds this finite sum only. Actual zeros above H are treated separately using the global bound. Both Mellin endpoints, both smoothing signs, the vertical term and both source psi sandwiches remain in the proof.

Analytic monotonicity bounds the complete continuum by the endpoint `L=22.33`; this is not a grid interpolation. Independent exact arithmetic gives the complete scaled error

`2392484205639/250000000000000 = .009569936822556 < .0096`.

Consequently the conditional paper proof gives

`|psiR(x)-x| < .0096*x/log(x)` for every real `5e9 <= x <= exp(35)`.

The previously accepted shared-strip/global argument gives `.0081*x/log(x)` for every real `x >= exp(35)`. Together they give the required `.01` envelope for every real `x >= 5e9`, including the join.

## Consumers and finite ranges

Retain the 6,439 finite prime windows covering `[1e9,5e9]`, their count/logarithm/theta-to-psi proofs, the finite nonprime repair and all existing smaller-range tables. The source natural specialization then gives the common integer envelope E for all natural `N >= 1e9`. For real cutoffs starting at `1e9`, retain the existing `.011` envelope and its floor-loss allowance. The finite integer result is not silently promoted to a real `.01` result.

E supplies the existing P1, P5 and P7 replacements and the repaired Mobius induction and tail estimates. The 214-cell Mobius profile, its M1/M2 consumers, and the Type I/II and high-twist base-gap consumers retain their selected constants and domains. P4 retains its separately accepted shared-strip proof, which does not require quantitative head data. P2, P3 and P6 retain their separate replacements.

The major arcs and finite base-gap branch still need the entire selected finite spectral family. For odd primitive conductors `c <= 150000` and conductors divisible by four with `c <= 300000`, retain

`qt(c)=2*c` for odd c, and `qt(c)=c` otherwise;

`D_c=1200000/qt(c)`;

`Hp_old(c)=ceil(200+max(1000,(704/7)*D_c))`;

`Hcert(c)=min(Hp_old(c),10^8/c)`.

The minimum is the actual rational cutoff, inclusive, not a rounded-up height. The family includes conductor one and inverse characters. The full nonprincipal family contains 5,543,640,187 primitive characters. Nothing in this amendment certifies it or reduces its coverage obligation. The actual-square minor-energy argument still needs the global provider and the sharp xi mass; it has no independent need for the removed narrow strip.

## Unchanged final targets and completion conditions

The large target remains `TernaryGoldbachFrom (10^27)` with no mathematical premise. The full `Statement` retains only the original inclusive `BinaryGoldbachInput` through `4*10^18`. Spectral hypotheses, QRH, head data and checker acceptance cannot be added as explicit, implicit, instance or bundled final premises.

The selected final constants remain major `1.0404`, minor `1.0376`, and nonprime `.00271`, leaving `.00009` in the normalization `x^2/49`. Existing accepted major, minor and base-gap source joins still require formalization.

Completion still requires actual shared-family certificates, formal replay of the head and finite prime evidence, validated global-provider proof terms and allowed transitive axioms, Lean proofs of the new analysis and every consumer adapter, and final expanded-type and axiom checks. This amendment introduces no declarations and no proof-status promotion. PlattGRH remains in the current compiled source development.

## Evidence pins

Paths below are relative to `work/qrh-campaign/agents/`. These are independent proof and dependency reviews, not merely file-hash checks.

| Evidence | SHA256 |
|---|---|
| [Main damped proof](../qrh-campaign/agents/prime-estimates/PSI_DAMPED_SHARED_STRIP_2026-11-11.md) | `8764E3EFDC940A4F302A761CFD2DE51778A91A5BF30F059F39CD0911F00CF5D0` |
| [Scalar budget](../qrh-campaign/agents/major-constants/PSI_DAMPED_SCALAR_BUDGET_2026-11-11.md) | `062E77E41EF43DC783A6CFAF319454C406897A322FA7D095BCC4C0E610F54209` |
| [Independent full proof review](../qrh-campaign/agents/independent-feasibility/REVIEW_PSI_DAMPED_SHARED_STRIP_2026-11-11.md) | `7D1315865B59B1CA84A8AB0676FF698121B665F54E2F84F81FFEA0A1B6FC7537` |
| [Symmetry and Abel proof](../qrh-campaign/agents/zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md) | `7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE` |
| [Independent symmetry review](../qrh-campaign/agents/moebius/REVIEW_PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md) | `8337D4EF50E27F37C20C16C59E04F3664886B21DBCE13CCFDCCC924B3F6C8D20` |
| [Conditional dependency cut](../qrh-campaign/agents/integration/PRINCIPAL_STRIP_DEPENDENCY_CUT_2026-11-11.md) | `4CAD8A442E44AD05382EFAF9CC282017ACD6BA645027FCC1CE9394AB5D71EDAF` |
| [Independent dependency review](../qrh-campaign/agents/audit/REVIEW_PRINCIPAL_STRIP_DEPENDENCY_CUT_2026-11-11.md) | `746B744F56E3243A6241377CC5765B81BB3C9E204FB28A6A712F94020B3DF54B` |

The new independent scalar script and receipt have hashes `2D58F1A3ABD679F74CEB043B40A7A6C05E50CA674E4A13CD36B7B16B280F9774` and `45E80E90DA51AF9C04DA068B19EBCC9000868CDAEE457972A29698C89CECF151`. Its original receipt states the looser .0099 cap. The separate final pin/comparison receipt, `237C11C8C84CBE072C2000E6D5F6C980B2637D63A14E1978161BF0CE11EE9E75`, checks 23 input pins and the stronger exact .0096 inequality without altering that receipt.
