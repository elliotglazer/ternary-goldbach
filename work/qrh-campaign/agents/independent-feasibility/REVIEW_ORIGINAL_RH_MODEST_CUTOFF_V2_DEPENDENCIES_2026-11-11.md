# Original-RH cutoff: second dependency review

2026-11-11. PASS for the proposed source-level dependency reduction, conditional on the listed local refactors. No additional omitted-conductor use was found. This is not a statement that the existing Lean theorem already has the reduced hypothesis.

The reviewed author is `major-constants/EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_V2_2026-11-11.md`, SHA256 `33A3D9645BD9A8F856DD13A40028FF314A2769E8938FA90050A194C048C84517`. I verified its 27 source/support pins. The separate full source/scalar review is `integration/REVIEW_EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_2026-11-11.md`, SHA256 `3DDA3A1073AD671AA418816D96966D07B0AA0B08D686C67E701B2B81302DC3A2`. I did not repeat its scalar arithmetic. This review accepts only V2, not the superseded cell-parser calculation.

## Conductor and height accounting

Put R=140000. For an arc denominator q the required invariant is qtilde<=2R, where qtilde=q for even q and 2q for odd q. The primitive inducing conductor c divides q, including when the character being induced is an inverse. If c is odd and q is odd, c<=q<=R. If c is odd and q is even, 2c divides q, so c<=q/2<=R. An even primitive conductor is divisible by four and satisfies c<=q<=2R. Thus the nonprincipal domain is exactly the claimed sufficient family: all primitive characters at odd c<=140000 or at 4|c<=280000. This does not assert that every such character is indispensable.

The heights remain the original ones: 1e8/c for odd c and max(1e8/c,200+7.5e7/c) for even c. `MajorArcs/GRH.lean:32–47` defines the actual L-function zero condition with inclusive height and exposes the direct Platt supplier. `Thm714.lean:581–670` uses conductor one, the odd branch, and the two even branches. `Cor713.lean:827` needs only 1e8/c. Its analytic consumer `Cor933.lean:490` and the plus consumer `Prop942.lean:76` already take local `GRHUpTo` hypotheses. Reducing R reduces the twist widths and does not increase their required heights.

The critical callsites are as follows.

| Consumer | Actual dependency and required refactor |
|---|---|
| `ArcChars.lean:383–449` | Primitive inducing conductor divides q; the proof already contains the odd-conductor parity argument. Supply localized Thm714 and retain conductor-one treatment. |
| `ArcCharsStar.lean:139–226` | The broad current Cor713 call must use the same parity argument, rather than only c<=300000. |
| `BaseGap2.lean:185–228,240–318` | Preserve qtilde<=2R from the witness construction. Its current exported q<=2r0 conclusion alone is insufficient for odd conductors. Reducing a modulo q leaves this denominator unchanged. Replace the broad `PartIICited.lean:45–50` Cor713 wrapper. |
| `L2Major.lean:99–175` and `MajorTotal.lean:233–278,760–1039` | Reuse the local character estimates at the smaller arc family, then recompute the finite sums and energy bounds. The old total major theorem is not an acceptable supplier. |

## The enlarged minor domain

`MinorTotal.I0_ge:277–316` currently calls the old fixed-cutoff L2 major estimate. The new proof must reproduce its norm-square comparison using J_R, not retain its old numerical lower bound or its old hypothesis supplier. Likewise `MinorTotal.minor_total:323` must be rebuilt using the new base-gap estimate and the generic `Thm1321.lean:153` argument.

The new annulus R<n<=150000 can use the type-I/II bound in `LinftyLevels.norm_S_etaStar_le_ghat:358–425`. Its proof uses the scaled eta2 estimates and integration, not Cor713 for characters of conductor n. The higher-level denominators are therefore not new finite-RH conductors. The telescoping comparison permits reuse of the old numerical chain above 150000 as scalar lemmas; it does not permit reuse of the old minor-total theorem on the enlarged domain.

I checked the possible indirect principal dependencies. `LSQuot3.lean:35–51` bounds the product of primes using psi, and its totient bound uses principal prime estimates. `EBound.lean:173–265` uses `Prelim.sum_vonMangoldt_lt` and `sum_vonMangoldt_nonprime_lt` in its low and dyadic parts. Its variable summation ranges do not instantiate a Dirichlet character of that modulus. The original coefficient energy `MinorTotal.T_le:216–263` uses `Prop715.lean:355–366`, whose finite-RH input is conductor one through height 500. The principal bridge `Explicit/ZetaZeroSums.lean:23–33` retains RH through 1e8. No reduction of this principal obligation follows from changing R.

## Route fidelity and remaining work

Targeted supplier/callsite searches and the proof-body reads above found no additional nonprincipal use beyond the plus, star and base-gap paths. This is a bounded source dependency audit, not a transitive axiom or elaboration audit. The existing `Helfgott/Inputs.lean:72–143` still invokes the old major/minor results; new wrappers must consume the refactored results on one common arc partition. A blanket `Fact PlattGRH` left in the final chain would invalidate the claimed hypothesis reduction, even if some of its fields were unused mathematically.

The proposed route retains the original finite-RH analysis. It does not consume global QRH, a .555/.56 strip, the later .65 energy bound, or the later major-arc constants. Principal estimates, type-I/II estimates, finite arithmetic lemmas and the original final nonprime comparison remain. No hidden replacement of these inputs by QRH was found. The optional lower analytic threshold is a separate accepted weakening and changes neither the conductor argument nor the retained principal height.

Remaining work consists of the parameterized arc geometry, localized finite-RH suppliers, the stronger base-gap witness interface, recomputed J_R/I_R and major sums, and the new minor numerical goal. Those are actual formalization tasks. No source was modified, no Lean build or analytic evaluation was performed, and this review adds no runtime or certificate-size claim.

## Additional source pins

Paths below are relative to `work/ternary-goldbach/TernaryGoldbach/`; the author manifest pins the other cited files.

| File | SHA256 |
|---|---|
| `MajorArcs/Cor933.lean` | `554F00DE4FA6F8F0B6B184F8E8535B8AC5C28C0DB47FA2A95119B6BA4899F66E` |
| `MajorArcs/Prop942.lean` | `35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716` |
| `MajorArcs/Prop715.lean` | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| `Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `MinorArcs/PartIICited.lean` | `0447F5A3D00DBB6B11CEA1A729FA4CCA2FEF993A8242574D2241A33195B14D30` |
| `MinorArcs/GBound.lean` | `79070A7DD3B3B755A34C3C39690674193CBCF439238D763EB4982889E5B52491` |
| `MinorArcs/EBound.lean` | `EB4A44BA2A0422BC346A73EED0828BDD32AF9597F24515ED763331DFF776F17F` |
| `MinorArcs/LinftyLevels.lean` | `12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409` |
