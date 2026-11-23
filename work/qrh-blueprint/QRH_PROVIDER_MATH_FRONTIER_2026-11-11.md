# Global QRH provider: bounded mathematical audit and remaining work

2026-11-11. Three independently reviewed source audits found no local defect in their inspected arguments. They do not validate the global QRH provider. This is a research frontier, not an approved Lean dependency graph or a theorem-completion record. The provider remains at `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`; no source, toolchain, dependency or build artifact was changed.

## Accepted bounded findings

| Argument inspected | Author and independent review | What this establishes at source-reading scope |
|---|---|---|
| Energy induction | [Audit](../qrh-campaign/agents/major-constants/QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md), [review](../qrh-campaign/agents/independent-feasibility/REVIEW_QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md) | The finite width schedule reaches its cap; total loss is paid; low, high and zero stages use the previous band in the stated order; branch coverage and radial restriction are valid. The inspected four physical exponent costs fit the reserve. |
| Certified bands to actual moments | [Audit](../qrh-campaign/agents/zero-sum/QRH_CERTIFIED_MOMENT_TRANSFER_MATH_AUDIT_2026-11-11.md), [review](../qrh-campaign/agents/audit/REVIEW_QRH_CERTIFIED_MOMENT_TRANSFER_MATH_AUDIT_2026-11-11.md) | The transfer retains the actual polynomial and energy definitions, source-ideal gates, exceptional-row restrictions, height factors and quantifier order. Inverse fields are separate analytic inputs, not consequences of the positive band. |
| Moments to zero exclusion | [Audit](../qrh-campaign/agents/integration/QRH_DETECTOR_CONTRADICTION_MATH_AUDIT_2026-11-11.md), [review](../qrh-campaign/agents/moebius/REVIEW_QRH_DETECTOR_CONTRADICTION_MATH_AUDIT_2026-11-11.md) | A uniform exponent is chosen before the character, so a common positive saving is available. The sentinel cannot supply the near-supremum zero. The actual regularized Mellin identity yields the stated contradiction, conditional on its analytic inputs. |

The coordinator read all six reports in full and verified every source-table hash: 35,41,31 entries in the author reports and34,9,5 in the corresponding reviews. These overlap; they are not counts of independent proved lemmas. The coordinator also inspected the actual assembly, schedule, supremum, continuation and signal-identity bodies and independently checked the displayed four-cost algebra.

The corrected detector report distinguishes a nonzero source window and eventual nonzero normalization denominator from a nonzero probe function. The first two facts do not prove the third. The contradiction needs the actual approximation to the reciprocal-L signal, even if a probe were zero. No separate nonzero-probe theorem is being claimed.

The core upper argument is now explicit. Under beta>7/8, choose common omega>0 and sigma>0 and put `a=beta-min(beta-7/8-omega,sigma)`, so `7/8<a<beta`. The low probe and its error imply that the actual signal has growth exponent `a-11/16`. Its Mellin transform is analytic on Re(s)>a. A primitive zero rho with Re(rho)>a survives the finite-prime mask. At rho, continuation of

`Lregular(s)*signalMellin(s)=R(s)*exp((s-5/6)^2)*H(s)`

gives zero on the left and a nonzero right side. Here R is the pole regularizer and `norm(H-1)<=1/2`. This reconstructs the upper implication. It does not establish the deep estimates that supply the low probe, approximation error, or Mellin identity.

## Next substantive source work

Do not repeat the induction wrapper or `source_moments` combination as if that would validate their inputs. The immediate priorities are:

1. **Actual prime-polynomial estimate.** Follow `Moments/PrimeGlobal.lean:28`, `ray_prime_global_squared`, through `Hecke/PrimeRay.lean` to `Hecke/PrimeBin.lean` and its actual analytic bound. PrimeGlobal itself squares a bin estimate after bounding the finite zero maximum by the global supremum. PrimeRay averages genuine twisted prime polynomials. The unreviewed work is the analytic bin estimate and its conductor, frequency, window and beta dependence, with no circular use of the desired beta<=7/8 conclusion.
2. **Actual inverse total energy.** Audit `Inversion/InitialTotalEnergy.lean:20`, `original_input_bound`, with its finite physical estimate, zero-mode estimate and passage to the full energy. Pair this with `Dictionary/InverseMarkedReferencePaddedEnergy.lean:15`, `padded_source_energy`, where required. The final source-moment transfer cannot supply these bounds.
3. **Actual normalized nonempty-cell saving.** Audit `Detector/FinalAssemblyNormalized.lean:18`, `actual_normalized_nonfloor_cube`, together with its immediate moment/count and integral estimate. Preserve both adaptive count regimes, all normalization factors and actual nonempty row conditions. Its later finite row summation and exponent comparison have been inspected; the cell inequality itself has not.

Further required branches remain explicit in the pinned reports: `Energy/CanonicalLowColumn.actual_admitted_subsets_low_column`, `Moments/FirstReferenceEnergy.actual_physical_mass`, physical-to-low conversion, genuine initial floor bounds, high/zero contour recovery, physical-probe transport, source normalizer and low-probe estimates, and the actual Fourier/Mellin, Euler and primitive-character foundations. Some arguments share dependencies; passing one audit does not close the others by name or by import.

Every next task should derive a concrete inequality or source identity from its actual proof body, state exactly where its independent reconstruction stops, and receive independent review. No additional final spectral, QRH, moment or checker premise is permitted. No new Lean declarations or source edits are authorized by this research note.

## Evidence pins and unchanged completion gates

| Artifact | SHA256 |
|---|---|
| Energy author | `C04D05F95C1747652F28576AC41372702F586F5D85E2849F12CD3E4D28A8D695` |
| Energy review | `70B618789695E16ECD8F78F81E951D9A7AB02FA6ED55B78CE9A46CD7203C3877` |
| Transfer author | `3F5E25D0EC07E868F6DCAC85ADCFFF7D73D50E42A35F40F3BE8E33167F85E6C5` |
| Transfer review | `5DA173029DD03FFAC3322C1D771B287448867A802C4C8FBE253F48B81D49515B` |
| Contradiction author | `B28B9982BEAD587411C9FC10F5D61C06A03073E59B3701F85B8B328C6CF48ABC` |
| Contradiction review | `6F5A1D26DAA6B4BCB271694F40BB6D82BE046D879288B4F93E26E980CBFA6505` |

The global provider still needs genuine target-toolchain elaboration, expanded-type checks, and actual transitive standard-axiom validation. The selected finite spectral family, retained principal head, finite-prime replay and all new Goldbach consumer proofs remain separate unfinished work. The final roots remain unconditional `TernaryGoldbachFrom (10^27)` and the full statement with only its original inclusive `BinaryGoldbachInput` through4*10^18. The final numerical reserve remains `.00009*x^2/49`.

`DRAFT_ANCHORS: 0 created; UNREGISTERED_SORRIES: 0 introduced; DRAFT_IMPORT_VIOLATIONS: 0 introduced; SEALED_THIS_TURN: 0`.
