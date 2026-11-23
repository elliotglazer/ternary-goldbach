# Extended residue domain and rounding-proof reuse

2026-11-11. The preceding goal turn made progress by accepting the reviewed Newton initializer and optional b100 coefficient adapter and updating the checkpoint. This turn root read both the extended-domain author and review, and both the fixed-denominator author and review. Accept the results below as conditional mathematical and arithmetic-proof designs. No numerical certificate, implementation, runtime saving or selected operation-ledger deduction follows.

## Broader full-state domain

The exact full-state difference method and its Newton initializer extend from c > 20F to c > 10F. Here F = 2Dout is the delivered output grid, including F = 16384 in the final band. The same fixed anchor and ties-down rule apply. If B_c counts all nonempty integer-numerator buckets, phi(c) > 10B_c implies the new guard. Replacing B_c by useful-unit buckets would require another argument.

Auxiliary polynomial arguments satisfy |h| < 6/5. The finite degree-19 geometric sum is less than 256, so live differences and raw Newton temporaries are below 2^43Q and traversal additions below 2^44Q. The Newton proof bounds unadded products using partial-degree invariants. Its interior order is at most 18, which absorbs the extra factor two. General factors still fit 19 magnitude bits in the actual conductor/grid family.

At the accepted optional b100 grid, sufficient signed live/Newton and traversal capacities are 506/507 bits, six above the old-guard 500/501. Coefficient prescales fit 479 signed bits, and the final cancelled divisor remains at most 362 bits. The actual output is still in its original cell with |h| <= 1/4. No actual-function approximation is required at auxiliary polynomial points, so the source and quantization error bounds remain unchanged. Mixed schedules retain the previous whole-band error cap.

Accept this as an additional admissible domain with its own widths. Keep the c > 20F option and its narrower widths available. No newly eligible conductor count or priced selection has been adopted. The author checked 18,166 exact cases and bounds; the independent review checked 40,059 and seven input pins. These are paper/metadata evidence, not kernel proofs.

## Fixed-denominator final-round proof

At b = g = 100 let Q = (2c)^19 and write an exact coordinate as I/(2^100 Q). A rounded output m/2^100 is certified by one signed product p = mQ, residual R = I - p, and the range -Q <= 2R < Q. The asymmetric range correctly handles positive and negative half ties. Two independent endpoint multiplications are unnecessary.

The existing ordinary-arithmetic digit-table schema applies to this conductor-fixed Q. Certified facts T[d] = dQ for radix-256 digits, together with the checked digit decomposition of |m|, prove Q|m| by prefix accumulation. Signed interpretation then proves mQ. This table is independent of the coefficient array, height, fine anchor and coordinate. Reuse is valid within an actual checked cache lifetime.

The in-cell magnitude bound gives |m| < 2^117. Q has at most 362 bits, table entries 370 bits and products 479 bits. A padded unsigned product therefore uses 15 quotient digits, 46 divisor digits, 47 table digits and 60 product digits. The last bound uses the sharper bit hypotheses; arbitrary 46-by-15-digit products need not fit 60 digits.

Under the explicitly declared PA macro-event model, the table product subtotal is 1723 events versus 3481 rectangular schoolbook events, with setup 24739. Its first strict subtotal crossover is 15 scalar products, or 8 complex outputs. These are counts of different lemma/table events, not equal-time instructions. Terms, decomposition, theorem unification, signed residual/order checks, transport, cache lifetime and proof storage remain charged. Known powers of two can be removed by either method and require a fair matched comparison.

Accept this as an optional proof-producing arithmetic method. Native quotient discovery still costs work. Lean's direct numeral multiplication is a separate comparator and may be preferable. Local MM0 proof resets and separate shards require rebuilding or checked theorem transport, not hash-only provenance. The independent review checked 30,580 exact cases and twelve pins; the author checked 67,725. Neither generated actual residue outputs or an ordinary proof implementation.

## Next comparisons

Two additional proposals now affect the comparison and remain unaccepted here. First, after the same b100 coefficient conversion, Horner can round each product and add the same-grid coefficient exactly. Its proposed arithmetic error is less than (4/3)u_H, leaving another (4/3)u_H for coefficient conversion within the old allowance. The author and independent reviewer must establish all widths and source bindings before this becomes a priced baseline.

Second, exact divisibility may shrink finite-difference states. Root identified full normalization by F^j j!, which simplifies Newton initialization but adds small-factor multiplications to traversal. Independent feasibility has a powers-of-two variant with shifted traversal and a cell-dependent common-factor reduction. Those variants need raw-width proofs and complete operation counts before adoption. The research team is comparing both against the stronger Horner candidate.

Principal certification, finite binary coverage and its prime ladder, actual spectral signs and counts, analytic foundations, and ordinary-rule proof construction remain open. They retain their previous unpriced status. No final core-hour estimate is supplied. The end-to-end compute-minimization goal remains active and incomplete.

## Frozen inputs

Paths are relative to work/qrh-campaign/agents.

| Artifact | SHA256 |
|---|---|
| major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md | AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054 |
| independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md | 0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711 |
| zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md | E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF |
| prime-estimates/REVIEW_FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md | 314CE4EEF32B3E5C87D671E6221AA43FC50428F642F0C062A0FA94E392DB59CF |

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: no imports changed; repository-wide state not audited.
SEALED_THIS_TURN: 0.
