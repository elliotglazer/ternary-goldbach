# Independent review of the positive, Gauss, normalizer and primitive frontier

2026-11-11. **PASS at the stated bounded source-research scope; no correction requested.** This is a review of the synthesis and its inspected mathematical implications, not validation of the full QRH provider or a Lean proof.

Reviewed synthesis: `work/qrh-blueprint/QRH_POSITIVE_GAUSS_NORMALIZER_PRIMITIVE_FRONTIER_2026-11-11.md`, SHA256 `FFA99DC3C9651FB013E9D4F5D4947D6A6ED45C98E6FED32B390487C939366AAD`. The coordinator's positive-band review is pinned at `7127B184C524803EEA8DB8EAEC899B5915F0EF567D286F35EF5565C239325344`. Both files are unchanged by this review.

## Evidence and source scope

I read the ten author/reviewer reports cited by the synthesis and checked their stated hashes. I independently reconciled their source tables: 163 Lean entries, retaining repetitions, and six supporting-report entries. The author/reviewer Lean-entry counts are respectively 46/0, 13/15, 22/24, 18/0 and 22/3. These are table counts, not distinct declarations or proof coverage.

The separately cited cached Mathlib `NumberTheory/GaussSum.lean` matches `52C08C68A0CC5CCE8018EBC526650788C5C0F8C4B33F07AE9377BC6E84E5B404`. I read and independently rehashed all 28 author entries and three additional sources in the masked-Poisson receipt, without running its writer. The receipt matches `F7977954AE1CBD4073707F9B19A748BD5A9EB6B652EB258733400CE84F617F76`; its hashing script matches `41A3AE0977142C2A15C8E9A91B607F1E4192F6507644E408CFBCB1B0315301A3`.

Provider source references below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL` at the pinned revision `4eaee87548250b2682affda7d05d947c05554bae`.

## Positive-band core checked against bodies

`Energy/CanonicalLowColumn.lean:122–198,263–336` retains the child `ZeroAt` and `PositiveAt` assumptions and admissions. `Moments/FirstSecondInputGates.lean:23–34` supplies geometric readiness, not the missing energy bound. The synthesis preserves the low-column inequalities and the stronger natural-state regime in `Energy/NaturalLowStage.lean:37–128`; it does not turn a local width condition into an induction proof.

In `Energy/FirstPhysicalNormalization.lean:1–78`, each square-root pair is bounded by the common nonnegative bound H, giving 16H, not 16H squared. For positive K and q and Z>1, the logarithmic exponent pays the physical K*q factor exactly. `Moments/FirstCommonReferencePower.lean:1–83` retains the conductor and volume factors. `Moments/FirstReferenceEnergy.lean:33–134` defines mass through absolute original blocks and divides the extra exponent between the block estimate and counting/mass costs. This does not establish a detector lower bound merely from nonnegativity of mass.

`Energy/ZeroComparison.lean:22–112` and `Energy/FixedRadialReduction.lean:22–62` preserve the exact vanishing comparison row and the diagonal/tail error terms. `Energy/PositiveLowBandSource.lean:24–100` uses the old band for width <= rho, including equality, and physical control for the complementary case. No seam is omitted. The synthesis correctly accepts only this bounded core from the longer positive-band author report.

## Cross-packet compatibility

The local-character summary keeps exact sextic order separate from the order-three powers needed by the cubic consumer. It retains the distinction between a finite transform with arbitrary additive character and a Gauss-norm result needing additive primitivity. Neither CRT phases nor the zero values at nonunits are silently discarded.

The ray-normalizer implication uses the separate line-one nonvanishing/pole input, not the desired QRH conclusion. Its eventual constants and threshold are for fixed modulus, exclusions and weights. Positivity is obtained from the radial Mellin identity and positive input weights, not pointwise positivity of the Fourier transform. It provides neither moving-modulus uniformity nor an effective finite verification.

The primitive-associate paragraph agrees with the independently reviewed finite construction: maximal quotient descent, image-character extension, exact old-modulus mask, and a character chosen independently of s. It makes no least-conductor, uniqueness or unit-map-surjectivity claim. The zero-ring convention is not confused with the separately defined zero-ideal coefficient.

The masked-Poisson summary retains the actual quotient/mask conditions, strict shell endpoint, unit-column zero puncture, all four error contributions and the summability needed for infinite splitting. The old sieve-exponent assumption remains an input; the desired sharpened output is not recycled into its proof.

## Remaining gates

No scoped local PASS is promoted to complete B1–B5 closure. The separate Smooth/whole-product, middle-frequency, live-allocation and signal reports are explicitly outside this acceptance. The named specialized analytic producers, child/admission and base/recovery inputs remain obligations. Standard library inputs are conditional on their exact hypotheses and compatible kernel validation; the differing requested and inspected Mathlib revisions remain material.

This synthesis changes neither the unconditional large-range target nor the full theorem's original binary input. It supplies no finite spectral data, finite-prime Lean replay, transitive axiom validation or completed Goldbach consumer proofs. No source file, frozen evidence, Lean declaration or build artifact was changed, and no analytic evaluator or Lean build was run.
