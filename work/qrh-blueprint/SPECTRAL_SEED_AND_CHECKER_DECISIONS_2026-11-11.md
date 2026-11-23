# Seed, arithmetic and checker decisions

2026-11-11. Supplement to CURRENT_COMPUTE_BLUEPRINT_2026-11-11.md, its scope addendum, and CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md. This records paper/source research accepted after reading the author and independent review reports. It introduces no Lean declarations, allowed axioms, generated spectral data or runtime estimates.

## Current numerical comparator

Retain the R132900 original finite-RH route, N0=989*10^24, fixed-order primitive-output pruning and the final P20 residue contraction. The independent elementary-enclosure audit now regenerates all nine cutoff bounds using exact rational log series and integer root witnesses. The remaining final coefficient is greater than .0013565. This closes the earlier independent-enclosure gap; finite RH itself remains an unproved input to the proposed formalization.

The scaled Hurwitz seed circuit is the default seed representation. Its 118-bit base-power and 122-bit internal error allocations are sufficient for the reviewed shared Euler-Maclaurin calculation, followed by the separately bounded midpoint shift. They are absolute error requirements, not total operand widths. SELECTED_SCALED_SEED_ORDER_2026-11-11.md proposes P27 rather than P28 within this fixed allocation; its separate review determines acceptance of that local selection.

The reviewed elementary leaf baseline supplies actual finite log/cis and inverse-root witness algorithms. The reviewed grid-anchor method is a supported alternative for shared log setup. The reviewed SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md composes the optional phase recurrence with the scaled interface. It requires stricter log accuracy2^-144 and update error2^-140. It uses27754497 initial leaves and step certificates,2068784623092 updates and2068812377589 output conversions. Its two dense numerical arrays have1998323784 raw bytes in the proposed layout; this is not a full prover memory estimate. Keep the direct leaf schedule as a comparator until arithmetic, proof and storage costs are priced.

## Three-product arithmetic is now a supported implementation option

The independent review of FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT accepts exact common-grid integer intermediates and one final rounding per coordinate. Exact cached sums of stored coefficient centers preserve their analytic uncertainty correctly, including the nonunit Bluestein kernel and the product of input errors. This discharges the paper refinement gap in the current operation budget.

Consequently its fixed-three-product row is a valid candidate circuit, with9328553469662034 real products and16945393608458554 real additions for the large-branch transform plus P20 contraction. Wider products, wide output additions, cache setup and final-rounding proofs are additional costs. The old four-product row remains a comparison; fewer products alone is not a measured speedup. Identical bits require identical final rounding semantics; no old-box containment is inferred.

## Finite coverage and full MM0 work remain explicit

The reviewed finite Goldbach frontier gives an exact admissible-cutoff rule for a supplied sorted certified-prime pool3=q0<...<qM<=T-4:

    Bpool=max(4,T-qM,max consecutive pool gaps+2), T=N0-1.

For even B, a path supported by that pool exists exactly when B>=Bpool. Farthest-reachable selection minimizes its rung count; additive weighted selection can instead minimize a supplied per-node cost. The producer's optimization need not be trusted by the final checker, which verifies the actual selected primes and all gaps. No prime pool or success rate has been supplied, and no B is selected. Preserve failed-search and discarded-candidate costs and nested binary-prefix reuse in the model.

The reviewed MM0 proof-volume report confirms that shared term references avoid re-traversing numeral digits during fixed-schema matching. It does not establish a full proof size. Actual arithmetic witnesses, materialized terms, macro expansion, unifier work, context imports and ordinary checking still need separate accounts. A generic correctness theorem never certifies arbitrary concrete outputs.

The reviewed MM0 foundation plan supplies two useful future translation tests: the actual complex exponential Taylor remainder joined to16!>2^44, and actual Mellin differentiability. Exact replacement proofs at opaque Prop boundaries can avoid translating expensive numerical proof bodies, provided the full translated type, theory, definitions and acyclic dependencies are preserved. There is still no validated full Lean4-to-MM0 translation or complete analytic foundation for this proof.

## Next mathematical research

Direct weighted residual-energy bounds might remove a whole character-output layer, but the required vectors concern actual smoothed prime residuals, not the current Hurwitz seed tables. Uniform mixed-energy and pointwise base-gap bounds remain necessary. The global spectral memo's inverse-conditioning statement needs its review correction: for residual norm at most q<1, an approximate inverse has lower bound(1-q)/min|L|;1/min|L| applies to an exact inverse. No aggregate-route savings are accepted yet.

A structured sparse ternary prime basis is being investigated as an alternative finite-coverage architecture. Its coverage and prime-availability conditions must be proved. The existing binary-prefix/prime-chain comparator remains in place until an alternative supplies those conditions and a complete cost comparison.

## Accepted report pairs

Paths below are relative to work/qrh-campaign/agents, except the root height note. Their exact hashes are recorded in seed_checker_acceptance_20261111.json.

- audit/REVIEW_R132900_ELEMENTARY_ENCLOSURES_2026-11-11.md, supplementing the already reviewed exact source-mass cutoff.
- zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md and independent-feasibility/REVIEW_GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md.
- moebius/ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md and integration/REVIEW_ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md.
- zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md and independent-feasibility/REVIEW_FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md.
- work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md and integration/REVIEW_SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md.
- prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md and independent-feasibility/REVIEW_FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md.
- audit/EFFICIENCY_MM0_SPECTRAL_PROOF_VOLUME_2026-11-11.md and moebius/REVIEW_EFFICIENCY_MM0_SPECTRAL_PROOF_VOLUME_2026-11-11.md.
- moebius/MM0_ANALYTIC_FOUNDATION_IMPLEMENTATION_PLAN_2026-11-11.md and zero-sum/REVIEW_MM0_ANALYTIC_FOUNDATION_IMPLEMENTATION_PLAN_2026-11-11.md.

Every acceptance above is limited to the named paper/source scope. No function values, primes, spectral signs, zero counts, formal theorem closures or end-to-end runtime claims follow from these reviews.
