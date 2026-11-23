# Current spectral operation budget

2026-11-11. This supplements the current compute blueprint with a composition of reviewed operation categories at R132900. It does not estimate runtime or total proof cost. The input hashes and exact arithmetic are in `compose_current_spectral_counts_20261111.py` and its JSON receipt.

## Accepted domain and circuit

The coordinator read the conditional R132900 pruning inventory and its independent review. This family has4351723951 primitive nonprincipal labels and99513098256768 large-branch residue-height inputs. The latter inputs remain necessary after output pruning. The fixed-original-order circuit has G=1849018578634950 general complex products and A=3808420069398260 complex additions/subtractions. It inherits the reviewed conservative precision and peak-width bounds under the identical-retained-gate contract.

The optimized axis order is a separate optional circuit. Its small additional operation saving is excluded here because the previous prefix-width comparison does not automatically transfer to a new order. The small-conductor branch is excluded throughout.

## Compose the actual operation categories

For residue count N and P Taylor coefficients, literal Horner contraction uses H=(P-1)N real-times-complex products and H complex additions. A real-times-complex product has two real products. Therefore:

| Complex product implementation | Real products, transform plus Horner | Real additions, transform plus Horner |
|---|---|---|
|Four real products|4G+2H|2A+2G+2H|
|Cached fixed-coefficient three products|3G+2H|2A+3G+2H|
|General Gauss three products|3G+2H|2A+5G+2H|

The cached method additionally needs its exact coefficient-sum setup and storage. Gauss pays its wider intermediates and additional additions. A gate's input widths, signed/rounding proofs and coefficient uncertainty remain part of its actual price. These formulas do not select a winner by counting all operations as equal.

The reference is the earlier reduced-R150000 whole-axis circuit with P24 contraction, N=114223068442718, G=4890157406463512 and A=11446911736111484. It is not the entire original PlattGRH computation, and it is not a measured historical implementation. The new script retains three comparisons at R132900: P24/four products, P20/four products, and both P20/three-product variants. This avoids attributing the whole change to one optimization.

P20 requires the denser alpha mesh and its separate seed proof. The shifted P27/P28 seed construction can provide those midpoint jets, subject to actual coarse coefficient certificates and the differentiated error budget. Restricting the reviewed R138000 family to R132900 preserves the same shared height union and band parameters. It changes the residue count in H, but does not shrink that fixed shared seed grid.

## Costs that must remain outside these subtotals

These rows exclude actual seed production, elementary heads/phases, full coefficient and kernel setup, quarter turns/negations/dyadic scalings, argument approximations, every rounding witness, interpolation, selected signs/contours, Turing completeness and repairs. They also exclude the binary proof, prime chain or uniform-gap alternative, analytic foundations, serialization and final proof assembly. No row is an end-to-end speedup.

The shared unscaled Hurwitz EM circuit has now passed independent mathematical and scalar review. It replaces an unspecified seed oracle with explicit elementary leaves, finite head and correction recurrences, a uniform EM remainder and a complete sufficient absolute-error allocation. Its conservative P28 raw-coefficient bounds require383 base-error bits and388 head-grid bits in the largest band; those are fractional thresholds, not a universal mantissa or measured cost. Rescaled jets are being studied to reduce this burden. That work is not credited in this budget.

The useful backend model is a sum over actual gate kinds and operand widths, plus the excluded phases. Reusing one scalar per-operation price across all these categories, or applying the product-count ratio to the entire proof, would undo the distinctions established by the reviews.

## Evidence

- [R132900 inventory](../qrh-campaign/agents/zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md) and [independent review](../qrh-campaign/agents/major-constants/REVIEW_CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md).
- [P20 alpha tradeoff](../qrh-campaign/agents/zero-sum/R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md) and [review](../qrh-campaign/agents/independent-feasibility/REVIEW_R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md).
- [Shared EM seed circuit](../qrh-campaign/agents/integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md) and [review](../qrh-campaign/agents/independent-feasibility/REVIEW_SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md).

No transforms, special-function values, prime certificates, prover builds or timing measurements were produced. DRAFT_ANCHORS:0 created; UNREGISTERED_SORRIES:0 introduced; DRAFT_IMPORT_VIOLATIONS:0 introduced; SEALED_THIS_TURN:0.
