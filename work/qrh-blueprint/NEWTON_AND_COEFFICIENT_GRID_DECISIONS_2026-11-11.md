# Newton initialization and coefficient-grid decisions

2026-11-11. Root has read the complete Newton author and independent review, the coefficient-grid author, its mandatory mixed-evaluator clarification and independent review, and the width-sensitive cost framework. Accept the two reviewed mathematical adapters at the conditional scopes below. No operation-ledger saving, kernel theorem, actual certificate or runtime improvement is admitted.

## Accepted Newton initializer

The degree-19 binomial-basis Horner recurrence initializes the exact forward differences using 190 general narrow-factor products, 357 complex additions and 357 shifted-operand occurrences. The old twenty-value/triangle initializer uses 380 general products and 570 additions/subtractions. Nineteen conductor-dependent coefficient prescales, factor setup, signed arithmetic and cache binding remain charged. A complex scale represents two coordinate products.

The proof tracks every partial Horner polynomial and bounds intermediate products before addition. Initialization updates descend; subsequent difference traversal updates ascend. The accepted domain remains the screened full-state circuit with c > 20F and the occupancy's ties-down anchors. Neither the artificial R > 10B product screen nor the new initializer alone extends that domain. The separate c > 10F extension awaits root review of its author and independent review.

For a bucket of length L, full-state initialization and traversal require 19L + 338 complex additions, versus 19L + 551 for the previous initializer. Nonunit advances remain included. These counts are not substituted into the separately pruned long-block schedule. The independent review checked 432 formal identities/counts/width specializations; the author checked 1,550. Neither checker evaluated actual analytic coefficients.

## Accepted optional b100/g100 coefficient adapter

An absolute coefficient-error contract does not prove a common denominator. The optional adapter explicitly rounds each of the twenty complex coefficient centers to grid 2^-100 and names a new polynomial. At consumed arguments |h| <= 1/4, this adds less than (4/3)2^-100; exact polynomial evaluation followed by one final coordinate rounding adds less than 2^-100. Their total fits within the previous (8/3)2^-100 per-residue allowance.

The all-adapter character-summed allowance is 1477u_H. A mixed schedule must use the clarification's subset-weighted bound, which is at most the old 1688u_H. Original Horner fallbacks retain the original coefficient array. The original first-four-band and final-band alpha error caps remain valid. The explicit source magnitude margins preserve C = 2^16 after conversion.

The optional b100 representation gives sufficient signed live/temporary widths of 499/500 for the pruned circuit and 500/501 for the c > 20F full-state/Newton circuit. The cancelled final-round divisor has at most 362 bits. This replaces the illustrative b122 widths only when the adapter or a direct grid-membership theorem is actually supplied. Charge twenty complex conversions per distinct retained coefficient array, actual source decoding and witnesses, cache reconstruction and binding. Conductor-dependent prescales remain separate. Independent review passed 2,906 exact checks; the author passed 1,915.

## Cost comparison still open

The width-sensitive framework correctly keeps the original rounded Horner stages separate from wider exact-integer operations. For the Newton full-state alternative, the uniform symbolic schedule is

    setup + 19B * prescale + 190B * general_product
      + (357B + 19A) * wide_add + 357B * shifted_operand
      + R * final_round + conversion + traffic_and_binding.

Prices must use the actual widths and the chosen objective: generation, proof construction or ordinary-rule checking. A new wide final quotient witness is not automatically cheaper than nineteen narrow Horner witnesses. The original-center fused rational Horner comparator must retain its own coefficient precision; the b100 adapter cannot silently reduce its costs without a separate error allocation.

The selected operation ledger continues to retain original Horner until a complete comparison and coverage policy pass. Integration and statement audit now own the joined comparison; major constants and moebius own the cost-aware occupancy frontier. Zero sum and prime estimates are checking conductor-specific fixed-divisor proof tables. Independent feasibility is reviewing the expanded domain. These are research tasks, not builds or numerical certificate generation.

Actual spectra and sign/count closure, principal certification, finite binary coverage and its prime ladder, analytic foundations, proof production and end-to-end calibration remain open. No final core-hour estimate is supplied. The compute-minimization goal remains active and incomplete.

## Frozen inputs

Paths below are relative to work/qrh-campaign/agents.

| Artifact | SHA256 |
|---|---|
| prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md | 55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC |
| moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md | 995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234 |
| integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md | 9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4 |
| integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md | B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815 |
| audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md | 793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D |
| zero-sum/RESIDUE_FINITE_DIFFERENCE_WIDTH_BREAK_EVEN_2026-11-11.md | 1A6976CAEC079B5745145780D344CAF63E4D3CC764440669DC103DFBEF6F2A10 |

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: no imports changed; repository-wide state not audited.
SEALED_THIS_TURN: 0.
