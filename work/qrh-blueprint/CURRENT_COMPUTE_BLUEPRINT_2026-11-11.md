# Current compute-minimizing proof blueprint

2026-11-11 research snapshot. This is a plan assembled from reviewed source arguments and conditional arithmetic models. It is not a completed informal or formal proof of ternary Goldbach. In particular the numerical certificates and several mathematical adapters below still have to be produced and proved. No new Lean/MM0 build or spectral evaluation has run.

The objective is total end-to-end cost: mathematical/library development, numerical discovery, certificate production, checked arithmetic, proof input/output and assembly. Eliminating the name PlattGRH is not itself the optimization criterion. QRH is optional; the leading comparison currently uses a smaller original finite-RH family.

## 1. Mathematical route and retained obligations

For odd N>=N0=989*10^24, retain the original circle-method estimates, with cutoff R=132900. The existing SmallMuPhi.c_132 certificate and nonnegative-sum monotonicity supply the improved mass lower bound at R. The reviewed joint major-minus-minor-minus-nonprime coefficient is greater than .0013565. This changes the final numerical interfaces; it does not preserve the old separate minor constant1.0376.

Required nonprincipal primitive conductors are odd c<=132900 or4|c<=265800. Their inclusive zero heights remain 1e8/c and max(1e8/c,200+7.5e7/c), respectively. Principal inputs, including RH through1e8, remain. The root independently counts4351723951 nonprincipal primitive labels. That count is not a zero count or a workload estimate.

The implementation must generalize the natural-R Qset pairing, preserve q-tilde geometry, localize the finite-RH estimates, rebuild J/I and base-gap consumers, replace the final numerical goal, prove the uniform nonprime bound and reassemble Main. Reusing the old blanket PlattGRH wrappers would not realize this reduction. Source and scalar reviews have not compiled these changes or certified the zeros.

The finite range still needs a complete binary Goldbach proof through some selected B and a checked prime-chain coverage argument reaching N0. The repository's existing route uses B=4*10^18; smaller B is an explicit redesign, not an already proved replacement. The entire inclusive base range, chain gaps, initial case and final endpoint must be covered. No BinaryGoldbachInput may remain as an unresolved hypothesis in the final result.

Primary evidence: [exact source-mass cutoff](../qrh-campaign/agents/prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md), [independent source review](../qrh-campaign/agents/major-constants/REVIEW_EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md), and `source_mass_root_checks_20261111.json`.

## 2. Spectral certificate production and checking

Use separate small-conductor and large-conductor algorithms. Do not add all-conductor character counts to a separately priced small-conductor theta/time branch.

For the large branch, the current architecture has these stages:

1. Produce certified shared Hurwitz coefficient jets and elementary head/phase values at the actual height grid.
2. Contract the jets at every required unit residue. These inputs are not reduced merely because fewer character outputs are retained.
3. Use mixed-radix character transforms, retaining only the primitive output tuples needed by the character manifest.
4. Prove the actual interpolation/sign or contour claims and Turing/count completeness, including central zeros, multiplicities, inclusive heights, auxiliary ranges and exceptional repairs.

The fixed nominal grid and error budgets are planning parameters. Successful strict signs and completeness have not been established. A bound for alpha truncation alone is not an L-value enclosure or proof of RH.

The reviewed primitive-output design deletes a dependency-closed subgraph: retained operations, inputs, coefficient boxes, summation order and rounding remain identical. With the original axis order, prior conservative precision and peak-width bounds transfer. At R138000 the fixed-order G count is1938924872313744 versus2736537742659260 for full-output mixed radix. The small additional saving from reordering axes is excluded from the conservative comparison until its changed prefix-width costs are checked. An R132900 inventory is being prepared; do not silently transfer the R138000 total.

The reviewed shared-seed alternative doubles the alpha mesh and contracts20 coefficients instead of24. Coarse jets of order27,28 or32 generate the new midpoint coefficients by finite Taylor shifts. Both the differentiated shift tail and the subsequent target-cell tail are charged. Fine coefficient errors must retain their individual differentiated bounds or a proved weighted aggregate; they cannot all be relabeled with the coarse seed radius.

At R138000's unchanged shared-height grid, P28 needs20093159204 independently generated coefficient slots and251132492800 dyadic-scale/add shift stages, versus28703416100 independent fine-P20 slots. P27 is a lower-work candidate with less tail reserve. A slot is not a special-function call or fixed-cost oracle. The deciding inequality is C_extra(P)+C_shift(P)<C_odd20. Actual shared seed production remains a major open cost; an explicit Euler–Maclaurin jet circuit is under research.

Primary evidence: [primitive-output pruning](../qrh-campaign/agents/zero-sum/PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md), [its review](../qrh-campaign/agents/major-constants/REVIEW_PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md), [shifted seed jets](../qrh-campaign/agents/integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md), [their review](../qrh-campaign/agents/independent-feasibility/REVIEW_SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md).

## 3. Finite-range certificates

Treat B, binary block width, anchor portfolio and prime-chain format as joint choices. Cheaper binary anchors can favor a larger B; cheaper ladder verification can favor a smaller one. Necessary chain counts are not forecasts of successful prime searches.

The binary plan needs a fully justified source-prime bitmap, actual certified anchor primes and an exact residual-coverage invariant. Compare residual word operations, span-normalized packed multiplication and finite-field NTT coverage using the same source and anchor evidence. Bounded NTT caches can reuse transforms across rows/tiles, but each input identity, last partial cell, residual update, prime/root certificate and final composition still requires proof. A broad cached transform can lose to a narrow uncached one.

For the chain, direct supplied-root prime certificates are a leading baseline. Under the reviewed ordinary-PA model they avoid the large-width penalty of multiplying many candidates into one modulus. Logical proof packs can still group many narrow checks. Keep the smooth-factor/cyclotomic portfolio where it improves discovery or checking. Charge root construction, all failed searches, factor proofs, certificate bytes and actual gaps. The mathematical sufficiency of a format is not evidence that the required chain has been found.

Primary evidence: [composed arithmetic and route choices](COMPOSED_ARITHMETIC_AND_ROUTE_CHOICES_2026-11-11.md), [adaptive certificate reconciliation](ADAPTIVE_CERTIFICATE_RECONCILIATION_2026-11-11.md), and [cutoff/precision/reuse reconciliation](RECONCILED_CUTOFF_PRECISION_AND_REUSE_2026-11-11.md).

## 4. Arithmetic and prover boundaries

Preserve two input widths at every multiplication. Use the reviewed common absolute precision and peak bounds for a conservative design, then refine by actual stage where useful. Choose four-product, fixed-coefficient three-product or Gauss complex arithmetic by total proof cost, including signed operations, grown operands, cache setup, exact alignment, final rounding and normalization. The minimum of unsigned subtotals is not automatically the minimum of complete proofs.

The signed-dyadic bridge now gives explicit natural-equation witnesses for sign routing and rounding. It requires its separate current-exponent clarification and final review before incorporation. Its named wrapper counts are not primitive MM0 opcode counts. Ordinary PA arithmetic templates remain proof schemas requiring implementation; the previous hex-coercion axioms are not admissible numerical facts.

Lean should check finite certificates using proved bounded checkers and kernel-supported reduction, keeping huge concrete powers out of exported theorem types. All nonstandard computational hypotheses must be discharged. Native unchecked answers do not count as standard-axiom proofs.

For a full MM0 result, distinguish the numerical PA sublibrary from the foundation needed for the analytic proof. A matching type-theory translation or a separately formalized foundation is still required. LeanExport provides source proof data, not a completed Lean4-to-MM0 translator. The arithmetical final statement does not automatically supply a PA formalization of the analytic argument.

Primary evidence: [width/arithmetic/streaming decisions](WIDTH_ARITHMETIC_AND_STREAMING_DECISIONS_2026-11-11.md) and [MM0 analytic-library routes](../qrh-campaign/agents/integration/MM0_ANALYTIC_LIBRARY_ROUTE_DECISION_2026-11-11.md).

## 5. Proof assembly and the cost model

A continuous ordinary-MM0 checker can reuse a checked library and theorem schemas without replaying old proof bodies. A bounded-state successor must retain exact live syntax/definitions, commit only completed untainted proofs, and reject stale or forged references. Parallel trusted checker workers can establish exact schemas once and feed ordinary dependent joins without a second serial arithmetic pass. These are reviewed same-rule designs, not features implemented by the pinned stock mm0-c.

For either prover, account for total core work as

    library/foundation + discovery + certificate/proof generation
      + numerical checking + decoding/I/O + joins + final audit.

Use one shared library check or the actual number of independently checked copies. Count retries and deliberately redundant verification explicitly. Wall time depends on the dependency graph, worker count, memory, input bandwidth and serial joins; total work divided by cores is only an ideal lower bound. Do not add overlapping bandwidth and compute lower bounds as mandatory sequential delays.

The future Fermi estimate should report generation, verification and one-time foundation costs separately, plus the assumptions controlling each. None of the historical Lean/MM0 headline estimates is a calibration for this architecture. The current evidence supports operation models and possible implementation choices; it does not yet determine a defensible measured per-operation rate or successful numerical repair frequency.

Primary evidence: [parallel MM0 design](../qrh-campaign/agents/audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md) and [independent review](../qrh-campaign/agents/independent-feasibility/REVIEW_EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md).

DRAFT_ANCHORS:0 created; UNREGISTERED_SORRIES:0 introduced; DRAFT_IMPORT_VIOLATIONS:0 introduced; SEALED_THIS_TURN:0.
