# Independent feasibility audit

Snapshot: 13 November 2026 UTC, 12 November local time. This is a read-only source/report audit. No Lean, HOL, native benchmark, numerical function evaluation, inventory fold or agent was started. The only new file is this note. Existing successful receipts are evidence, not fresh measurements by this audit.

## Conclusion

The existing chi4 result closes an actual positive-height sign, including its analytic source, truncation, rounding, completion and reality. It is stronger than an arithmetic checker fixture. It supplies no throughput law for the selected spectral algorithm. The next useful experiment is a complete, bounded production-circuit block with actual source and root certificates, two dependent height steps, and actual-function output radii. Repeating the direct chi4 sample or adding more dependent butterflies would leave the principal calibration gap intact.

A concrete entry block is the selected large conductor c=10004, at height indices 1 and 2, with the height-zero state initialized and certified internally. Use its saved ordered character-transform plan and precision assignment, all required unit-residue inputs, all retained primitive output channels, and the exact Delta=5/64 recurrence. This tests one whole character-transform/source join at manageable vector dimension. It does not, by itself, calibrate the much wider small-conductor time transforms, high-height source production, repair frequency or zero-count completeness. Those must remain separate forecast entries.

## What the closed sample proves

`work/lean-pilots/spectral/PositiveHeight.lean` exports `SpectralPilot.positive_height_chi4_certificate` with no hypotheses. For the actual character `ZMod.chi4` as expressed in the Lean source by `ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)`, and s=1/2+i*5/64, it proves

```
Re(4^(s/2) * chi4.completedLFunction(s)) > 0
Im(4^(s/2) * chi4.completedLFunction(s)) = 0.
```

The definition is Mathlib's completed L-function. The conductor factor is included explicitly. This is neither positivity at the central point nor positivity of a surrogate polynomial. The final source applies an unconditional actual-L box and the exact completion adapter. Its reality theorem proves primitivity, self-duality and root number 1; the central nonzero result used in that argument is itself proved.

The source chain is concrete:

* Eight actual powers n^(-s), for odd n from 1 through 15, have certified grid20 centers. Each radius is at most 1/500000. Exact rational Taylor polynomials are used internally; this is not the earlier production circuit with fixed-grid rounding at every gate.
* Their character sum has center `(572952 + i*51250)/1048576` and radius at most 1/62500. `SampleBox.lean` binds that center to the actual finite sum.
* `FiniteAbel` and `Tail.lean` bind the sum to analytic continuation. The partial sum at 16 vanishes, and the proved tail radius is 33/128. Consequently the actual L-value has real part greater than 1/4 and imaginary absolute value less than 1/2.
* `GammaEnclosure.lean` proves the actual Gamma/phase box, real part at least 3/4 and imaginary absolute value at most 1/4, through convexity and the Euler integral. `CompletionFactor.lean` proves the exact positive scale `exp(log(4)/4 - 3*log(pi)/4)` and the final positivity implication.

The strict whole-source build contains all eleven owned helper bodies, with external Mathlib and LGrowth imports. Its recorded wall/CPU times are 51.733959/63.031250 seconds. The imports-only run is 38.279340/37.937500 seconds. Neither subtraction nor division by eight is a production per-input price. The full proof object is 9,821,984 bytes. Exact-type and transitive-axiom probes report only `propext`, `Classical.choice`, `Quot.sound`; the changed n=3 center is rejected. The stored root reconciliation independently matches the eleven-file bundle. These establish semantic closure and one construction observation, not repeated throughput or a memory-scalable family implementation.

In particular, one strict sign proves no zero count, no sign change and no finite RH height. It gives no observed retry distribution. The same crude Abel estimate at general height t and truncation N is bounded by `2*sqrt(1/4+t^2)/sqrt(N)` when the same partial-sum bound applies. Making this estimate at most delta requires `N >= 4*(1/4+t^2)/delta^2`. Thus the N=16 experiment is not a cheap high-height evaluator hidden in the existing theorem.

## The smallest useful next block and its acceptance gates

Use c=10004 because it is an actual selected even large-conductor row, not a new artificial FFT dimension. The reviewed combined-height report identifies this row as the maximum-height row with H=6578 and J=84200. Its factorization is 4*41*61; the full unit vector has 4800 entries. The existing saved plan, primitive-output restriction, sign convention, cache contract and local precision must be pinned before implementation. This audit has not read or recomputed that row's precision or plan, and does not substitute a guessed plan or p343 fixture for it.

The minimum block has the following deliverables.

1. A small parameter packet defines the conductor, ordered unit/character maps, height-zero initial state, and indices 1 and 2. Prove exact input identity and dimensional coverage. No externally asserted source-radius premise may remain in the concrete export.
2. Produce and certify the actual source data for those heights using the selected full-P20 source, admitted grid conversions and raw head assembly. Preserve the distinction between the finite translated stored polynomial and the true fine jet. Certify raw `(a/c)^(-s)` heads separately from the EM seed's internal finite head. Include initial inverse roots, logarithms, cis/step objects, Bernoulli constants, truncation/translation and recurrence errors actually used. The second height must consume the first retained state if recurrence reuse is being priced.
3. Certify roots and the normalized Bluestein kernel for every visited plan node, including K/P stored on the selected runtime grid, its uncertainty, and exact cached sums. Execute the real ordered CT/Blue circuit, not the rotate-and-pair fixture. Prove its output enclosures against the actual character transform, with the original normalization and full intermediate dependency closure.
4. Apply conductor scale, root phase and canonical real normalization, or the specifically admitted sign-only adapter. Produce strict positive/negative certificates where the interval excludes zero and an explicit inconclusive result elsewhere. Bind every result to the actual character and height. No generic coefficient assumptions, sign margins or oracle labels may remain. At least one actual nonreal character and its inverse should be exercised; chi4's self-dual/root-number-one shortcut is not a general phase producer.
5. Export a short theorem for the complete block and record producer time, certificate translation, first acceptance, optional independent replay, shared setup, output and peak live memory separately. Include corruptions of one source center, root/kernel coefficient, character index, normalization and final radius/sign. A checksum alone is not an output enclosure or identity proof.

This is an entry block, not a claim that low heights are representative. A subsequent window near t=6000 lies inside this row's stated main-height domain and exercises the final source band. However, the reviewed raw-head proposal starts at t=0. A high-height window cannot be priced as two updates while importing an uncertified starting state. Either charge its complete dependency prefix, or implement and check a direct/restarted high-height seed with its own error budget. A conditional initial-state theorem would be useful library work but would not finish this calibration.

The other minimum calibration class is one actual small-family time-transform block, using a selected row's full N or a proved pruned dependency closure. It must include the Gaussian/radial coefficients, bucket and character transforms, prefactors, raw time polynomial, roots, and the raw-sign radius. An arbitrary 128-point time transform does not replace a row's much larger required N. Process one channel at a time if needed, but charge the shared character-source work and cache lifetimes once. The selected small branch has time fractions 241–343, raw magnitude exponents 54–69, other precision requirements up to 415, and both character and time work. The low-precision large block cannot supply its prices.

For a completeness calibration, extend one actual channel through a complete height prefix with all prescribed auxiliary and guard samples. Prove disjoint critical-line brackets from strict endpoint signs, including the realness/continuity adapter and actual multiplicity convention. Separately produce the canonical upper-count/Turing data and the final strict surplus on the correct closed carrier. The accepted two-zero surplus relaxation belongs only to its reviewed RH consumer; it is not exact zero-list saturation. A local pair of opposite signs establishes a lower-count contribution, not exclusion of unseen off-line zeros. No fixed auxiliary length guarantees success. This is a distinct acceptance gate, not work silently supplied by the initial block.

## What may be priced now

| Item | Existing evidence and admissible use | Remaining limitation |
|---|---|---|
| Actual chi4 source-to-sign construction | Complete one-sample Lean source/receipt, standard-axiom audit, rejected wrong center | Direct eight-term low-height algorithm; no FFT/cache/high-height amortization |
| Signed dependent arithmetic | Lean, HOL4 and Candle execute the same dependent rotate-and-pair contract; native reference is separate | It is not an FFT. Roots, source values and global spectral error are absent; actual magnitude/width and operation mix must match before using its prices |
| Local rounding | Proved output-producing floor-round contract in the new block design | Actual normalization, global propagation, complex-real interpretation and source identities are additional |
| Complete finite prime/coverage block | Batched HOL checks all 1537 nodes and 393 roots and closes the same 1024-target interval | Source/anchor sharing, larger blocks, optimized ladder and fallback workload remain unmeasured; no spectral multiplier follows |
| Selected spectral operation counts | Reviewed saved ledgers distinguish source, large transforms, wider small branch, guards and setup | Conditional schedules and typed counts are not completed certificates or measured per-category prices |
| Gamma/completion | Actual low-height analytic helper is proved and reusable as a theorem | No high-height enclosure/cache/phase recurrence producer has been calibrated by that proof |
| Sign repair and completeness | Mathematical paper interfaces and explicit budget slots | No observed family margins, complete count packet, successful refinement distribution or termination bound |
| Principal and global finite coverage | Separate required tasks with local implementation evidence | Principal RH through 1e8 is not the chi4 theorem; do not add a separate N1500/Q1500 consumer obligation. Binary cutoff/ladder tradeoff and final TG assembly remain separate |

The chosen cost model must also preserve the exact circuit version. The current spectral estimate prices the combined8828 large baseline and credits no runtime saving to the later mean186/runtime692 assignment without its corresponding width-price fold. It retains full small time transforms; half-time and dense-polyphase alternatives cannot be credited simultaneously without their full setup and query-set joins. Source generation and proof of the source are not counted twice when the evaluator computes and checks them in one accepted execution.

## Forecast correction and concrete decision rule

The opening finite checkpoint in `REPORT.md` and the end of `NEXT_BLOCK_PLAN.md` still describe recursive-prime batching as the next experiment. `finite-hol/BATCH_REPORT.md` supersedes that pending status. The completed batch checks the same 1537-node graph, proves all 393 roots, rejects nine controls and exports the same closed 1024-target interval. Median primality time falls to 0.064050 CPU seconds, but the complete process is 13.09 CPU seconds rather than the earlier 18.27. The isolated improvement is about 138-fold, while the whole-process improvement is about 1.40-fold. Translation and the 3.324970-second median export remain substantial. This is direct evidence against a universal backend multiplier.

For the next spectral experiment, let S be shared root/source-library initialization, I the cost of constructing and binding a fresh payload, E the dependent execution plus mathematical acceptance, O the actual export/transport cost, and R the cost of failed work and repairs. Charge

```
cost = S + sum_over_distinct_payloads I + sum_over_accepted_blocks(E + O) + R.
```

Imported generic library checking, proof development and optional independent replay must have explicitly stated lifetimes. Repeated calls on the same named literals do not establish I for fresh data. The difference between acceptance-time computation and untrusted proposal generation must remain visible.

A concrete go/no-go test for an internally generated block versus imported literals is possible without a forecast. After both close the same mathematical contract, compare their measured cold overhead S_new/S_old and complete warm block cost W_new/W_old, including lookup, binding and export. If W_new<W_old, the new path amortizes after q blocks exactly when `q*(W_old-W_new) > S_new-S_old`, for the actually justified reuse lifetime. If fresh data require extra per-block source proof, that belongs in W_new. If the cache cannot persist for q blocks under the memory limit, the inequality does not authorize the saving. Record positive and inconclusive signs separately; neither a low fixed-point residual nor successful arithmetic execution demonstrates a spectral sign margin.

Until the actual source/root/error block and one count closure exist, the previous core-year calculations remain explicitly conditional sensitivity exercises. They cannot select a universal winning backend, establish a full TG completion time, or justify porting the whole analytic development on arithmetic timing alone.

## Snapshot evidence

Paths are relative to the worktree. Hashes bind the report versions read here; root may subsequently update living summaries.

| Artifact | SHA256 |
|---|---|
| `work/backend-costs-20261112/REPORT.md` | `C923C965BD1DFBDF0DB02BFD374E96A0919012B310B2E89F5E84E323D0F87C60` |
| `work/backend-costs-20261112/NEXT_BLOCK_PLAN.md` | `5846C827368AB4E22C0A6FF568D0D3A9AA5134047FFAD227647B34D3CA7F28A9` |
| `work/backend-costs-20261112/finite-hol/BATCH_REPORT.md` | `762D3FEC345D6914498C798ED3A09BDA3C0E417089625806281309F9878A61D7` |
| `work/backend-costs-20261112/finite-hol/BATCH_RESULTS.json` | `D59E4C1E38CA8455B12C2EF806708B3079C714DDD985410020A7ED1C231BF2E6` |
| `work/lean-pilots/spectral/REPORT.md` | `06E423C98CADCB94A372872E8D1CF9D9B7F142F007350C9A08F058D82B064A08` |
| `work/lean-pilots/spectral/PositiveHeight.lean` | `955866564A49B21DC9B6436B7B830305ED569C167474CB9E592486CB2355309A` |
| `work/lean-pilots/spectral/SampleBox.lean` | `3DF9542AB3DEBB4F2AAB7BF660401757E697E2774BCB396006B82CF3A3A663D6` |
| `work/lean-pilots/spectral/pilot_receipt.json` | `673500D6324DDB8047C2CFAB5B489A18D6FB5109E3F541A1AEE0850147CC54A3` |
| `work/qrh-blueprint/estimates-20261111/SPECTRAL_COST_ESTIMATE.md` | `48F721494509A7EDF164210C91DA0FDAD8140E05F85E7EA3C01A6E16EA567D43` |
| `work/qrh-campaign/agents/major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md` | `6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C` |
| `work/qrh-campaign/agents/prime-estimates/SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md` | `C1D2C360A296C961BD2FA46576521FEDB1AFE01527610DF1D21CC145E5565918` |

Additional direct reads: spectral `Tail.lean`, `FiniteInputs.lean`, `Elementary.lean`; spectral-reality `Chi4Reality.lean`; spectral-completion helper report; audit `positive_height_export_probe.log` and `root_full_spectral_source_check.json`; backend `hol4-setup/DEPENDENT_BLOCK_REPORT.md` and `finite-lean/REPORT.md`; root `RESEARCH_CHECKPOINT_2026-11-11.md`; the selected source/guard join and the principal-head scope erratum. The old target file's pending Gamma status is historical and does not override the completed sample.
