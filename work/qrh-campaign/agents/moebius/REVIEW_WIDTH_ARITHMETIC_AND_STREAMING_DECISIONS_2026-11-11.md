# Review of width, arithmetic and streaming decisions

2026-11-11. PASS for the stated reconciliation of conditional research results. No correction is required. This is not a runtime comparison, a completed ordinary-PA arithmetic implementation, or approval of a new MM0 checker.

Reviewed root artifacts, relative to `work/qrh-blueprint/`:

| Artifact | SHA256 |
| --- | --- |
| `WIDTH_ARITHMETIC_AND_STREAMING_DECISIONS_2026-11-11.md` | `5C61B6F843320482FC555EE54C0A3660FFBD55008DA7EAC1FACB0A390EE8C8F7` |
| `reconcile_width_streaming_20261111.py` | `79DF1147526BBB93DEF14E8A59291FFCC8495E4B8B336A2C39CD75EACD8FEDE2` |
| `reconcile_width_streaming_20261111.json` | `3569407CAD0B9288EB83317789AA175DEC2E1D9218B86F23050E26AA30B5770D` |

I read the root note and script, the seven author/review/clarification packets, the relevant actual C verifier bodies, and the arithmetic metadata used by the three displayed rows. Independent read-only checks verified all 30 distinct hashes in the receipt and the three support-table row counts 7, 9 and 8. The seven primary packets plus 24 supporting rows contain one duplicate, consistent with 30 distinct files. The root writer was not executed and no frozen file was changed. No transforms, primes, analytic values, proof streams or builds were evaluated.

## Width claim

The root accurately retains the premises of `MIXED_RADIX_INTERMEDIATE_WIDTH`, author hash `5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A`, and its independent review `A1D0815D5B186F0E07CCCFDD4EE3035D5E74D780CC4364ED49866AC30B56EF2F`.

The baseline safety and error constraints give the common fractional grid. The separate peak induction controls internal values, including the cached nonunit Bluestein kernel and the inverse transform before its division by the padding length. For a CT split, the semantic output bound of the first child is legitimately used as the input bound of the second child; it is not substituted for the first child's internal peak. The displayed recurrences match the source packet. Its exact identity case has `K_1=1`; the root's radix/direct formula is the sufficient bound for the nontrivial circuit nodes under discussion, not a redefinition of an identity transform.

The capacities `p+b+q+2`, `2p+b+q+2`, and the three-product temporary allowance `2p+b+q+5` retain the distinction between stored grid values and exact product numerators. The product bound depends on the actual circuit's operand norm product. It would not hold for an arbitrary multiplication of two values independently bounded only by the common peak. The note expressly uses the circuit bound and does not square or discard it incorrectly.

The comparison is between conservative allocations, under the accepted error contract. It does not say that every mixed gate is narrower than a corresponding old gate, or that an optimized old circuit cannot use smaller precision. Root enclosure generation, rounding witnesses, representations and proof terms remain outside these value-capacity bounds. The note correctly asks for the two input widths at each multiplication, since output capacity alone is insufficient for pricing a rectangular product.

The 13,943-axis and 149,999-layout checks are the prior independent metadata result. I verified the identity of that result, not a new full reconstruction of those inventories in this review.

## Arithmetic comparison

Acceptance includes `CLARIFICATION_COMPLEX_KARATSUBA_CHUNKS`, hash `788CB7708B95B05BB9FE12DD823CEE200E6D0468D2532A3963766A61C373278C`, alongside the original arithmetic author and review. The root preserves the repair: the chunk expression counts the multiplication and carry-addition skeleton, while initial/row/final proofs, zero handling, extraction and reassembly require additional cost. It does not promote the minimum over these subtotals to a minimum over complete proofs. The source review also checked that none of the displayed selected schedules uses the chunk branch, including recursive descendants.

I independently recomposed the three displayed rows from the stored equal, unequal and grown product subtotals and the specified addition lengths. This gives:

| Total operand bits | Four products | Cached runtime | Gauss | Cache setup |
| ---: | ---: | ---: | ---: | ---: |
| 128 | 5386 | 4348 | 4377 | 70 |
| 256 | 18562 | 14855 | 14601 | 134 |
| 1024 | 190350 | 145796 | 144974 | 518 |

At 128 bits the runtime difference is 29, so two uses save 58 and three save 87 against setup 70. At 256 and 1024 bits the cached runtime exceeds Gauss by 254 and 822 respectively. These are integer cost-model computations, not multiplication evaluations or measured execution times. I did not repeat the full recursive multiplication-schedule search.

The four-product column uses the same available product improvements as the other columns. It is not the old schoolbook-only comparison. All columns still omit signed arithmetic, representation, binding, rounding and proof-object overhead. The note neither multiplies one equal-width row by the entire spectral operation count nor silently grants exact cached pre-sums to an implementation that rounds them. Its proposed common complex-gate correctness/error interface is an implementation objective, not a claim that the interface has been proved or implemented.

## MM0 reuse and streaming

I checked `work/formal-goldbach-bench/mm0/src/verifier.c` at 233–239, 297–316, 479–517, 537–543, 600–606 and 770–807, plus the whole-file mapping at `main.c:38–76`. These files are bound by the receipt to hashes `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5` and `ECDE31379241E38CA0B375DF0F40B216E9108F6CFD45952CCB282658D883DE17` respectively.

The theorem instruction checks the prior theorem frontier, argument types, dependency restrictions and statement unification. It does not replay the old derivation. The declaration-end path resets local proof state, checks the final conclusion and all hypotheses, and advances the theorem frontier. Thus a mandatory replay of the entire library for every shard would be an incorrect model of a continuous merged run.

The root also preserves the critical limitations. A proof-tagged intermediate is insufficient while conversion obligations remain. `Conv` and `ConvCut` can leave guarded intermediate stack values, so a collector may not export them merely by inspecting a tag. The `Sorry` taint must survive resets or cause immediate rejection. Imported hashes and logs do not create theorem provenance. Definitions, binder information and reachable syntax may remain necessary after proof bodies are discarded.

Stock whole-file mapping and growing global descriptors do not provide the proposed bounded-state transport. The source packets' new storage policy is a same-rule implementation proposal, with exact lifetime, reference-integrity, failure and statement-binding obligations. The root labels it accordingly. Its live-state claim is conditional on bounded shards and a restricted surviving interface, not a constant-space claim for arbitrary targets or retained witness lists. The continuing-state cost formula still charges shard proofs, joins, representation, reclamation and final checking. It does not erase proof bytes or arithmetic inference counts.

Reusing checked declarations and reusing closed instantiated table facts are distinct. The latter may require persistent checked storage or repeated local instantiation. The root's general overhead terms and its requirement to retain the actual library/interface are consistent with this distinction; they should not be specialized to free persistent instances in a later implementation estimate.

## Bounded verdict

The reconciled note does not claim more than its reviewed sources. Its three decisions are valid conditional directions: use the common conservative width allocation, choose arithmetic using actual operand widths and all overhead, and avoid charging unnecessary prefix replay to a continuously running ordinary-MM0 checker.

Open work remains actual arithmetic and proof-object costs, root/cache construction, a correct bounded-state implementation, trusted parallel checking if selected, actual spectral certificates and the remaining mathematical/library translation. Neither spectral success nor end-to-end Lean/MM0 superiority follows from the accepted metadata. No new theorem, source declaration, axiom audit or numerical certificate is supplied by this review.
