# Independent audit of the efficient MM0 estimate

Research estimate, 2026-11-10. No implementation, proof generation, MM0 benchmark, or Goldbach computation was performed for this review. Arithmetic below uses 31,557,600 seconds per year and decimal storage units.

## Verdict and planning estimate

The segmented-prime-bitmap plus selected-cover architecture is a credible way to avoid separate proofs for every even integer. It does not justify treating a native word instruction, a derived arithmetic theorem application, and an MM0 verifier event as the same unit. That distinction changes the current estimates by factors of tens to hundreds.

For the final proposed **sparse large-prime/shared small-prime bitmap design**, my independent planning figure is **about 30,000 physical-core-years in total**, including proof generation and one full proof check, with an illustrative efficient-design range of **3,000 to 300,000 core-years**. This replaces the much larger dense-sieve scenario as the preferred estimate because it removes the dense large-prime sieve proof, not because the same proof has been assigned a faster clock. Costs outside this range remain possible if the covering, arithmetic, or chunk-composition assumptions fail. These are engineering scenarios, not measured forecasts, confidence intervals, lower bounds on PA proof length, or a proof of optimality.

The lower end requires an aggressively compressed, proved arithmetic library, small retained covers, and fast certificate production. A generic bit-by-bit or per-number implementation can exceed the upper range. The former dense-sieve models remain below as comparisons; their totals must not be mistaken for the sparse estimate.

The sparse center has about 14,854 cover-checking core-years and 7,427 cover-emission core-years. The remainder of the rounded 30,000 allows for large-prime certificates, native search, table setup, interval assembly, and overhead. All of these require measurement. The total is plausible only with the explicitly optimized producer described below.

## Preferred sparse architecture and its conditions

Take blocks containing 2^32 even targets, with integer width 2^33. Certify a shared small-prime bitmap through 2^33+D once. For a high block starting at B, search for about 512 certified large primes q in [B-D,B). Then a target n in the block is covered whenever the shared bitmap certifies p=n-q as prime. This reduces the number of large-prime certificates to approximately

    (2e18 / 2^32) * 512 = 2.384e11,

before exceptions and reuse. It eliminates the need to prove a dense prime bitmap throughout [0,4e18]. The first block, partial final block, q<B requirement, and bitmap endpoints require explicit handling. For illustration, D=2^20 makes the shared odd-prime bitmap only slightly larger than 512 MiB. That is a size calculation, not a proven sufficient search window.

At 15 retained masks per output word, 200 inclusive events per mask, 2e8 events/second, 250 emitted bytes per mask, and 500 MB/second of native template emission,

    cover E = 3.125e16 * 15 * 200 = 9.375e19
    cover checking = 14,853.79 core-years
    cover bytes = 3.125e16 * 15 * 250 = 1.171875e20 bytes
    cover emission = 7,426.90 core-years.

All counts and rates are assumptions, but their units agree. A large-prime certificate averaging 1e6–1e8 inclusive events would add about 38–3,778 checking core-years. An average of 1e9 events would instead add about 37,775; treating primality as one operation is unacceptable. Finding convenient certifiable primes and factoring the needed auxiliary integers are separate producer costs. A 100–1,000-core-year native allowance is provisional, particularly for greedy cover search.

The sparse strategy is logically sound as a certificate scheme: check each retained q's primality, each source-bit implication, and each word's complete coverage. It makes **no theorem-level guarantee that 512 q values, 15 retained masks, or a fixed D suffice for every block**. A random-density model does not establish such a guarantee. Candidate masks are correlated through residues and overlap. The producer must enlarge its pool/window, issue exceptional certificates, or use a slower fallback when coverage fails. The final estimate assumes these fallbacks are rare in aggregate, which is a crucial unmeasured hypothesis.

The 200-event cost must include or amortize arbitrary source-word access, shifts, and the connection to the shared certified bitmap. The bitwise OR lemma alone does not pay for those. The roughly 512 MiB shared table may not fit in cache; a logical lookup also needs a sound array-membership representation. Per-access large-tree proofs or poor memory locality can erase much of the apparent saving. Keeping small-prime facts as unchecked external table entries would not be a PA proof.

## Reconcile the earlier numbers

The given estimate of 30 minutes for 50 million cases means 36 microseconds per even integer. A linear extrapolation to the approximately 2e18 target evens gives

    1800 * (2e18 / 5e7) / 31557600 = 2,281,542 core-years.

This is an extrapolation of the earlier assumption, not a reproduced benchmark. It also ignores the change from roughly 27-bit inputs to 62-bit inputs. It must not be presented as an empirical constraint on a different block algorithm.

The original computation reports about 770 heterogeneous one-core CPU-years. Its Q9550 figures give 8.7 sieve cycles per odd integer and 9.707 partition/statistics cycles per even integer. Applying those local rates over the full range at 2.83 GHz yields about 412 reference-core-years. That normalization is not the campaign's accounting. The historical sieve and partition algorithms already share work across many integers. [Original paper, sections 1.1–1.3](https://denisevellachemla.eu/empirical-verification-of-the-even-CG.pdf).

Thus the old 30-minute extrapolation is about 2,963 times the 770-year total and about 5,535 times the 412-year normalized estimate. An efficient proof estimate can differ by those factors without contradiction only because the algorithm and proof representation change. Moving from Lean to MM0 alone does not establish that saving.

The native review's 100-modern-core-year central scenario, with a 30–300 range, is a reasonable *assumption* for discovery. Its hardware and algorithmic improvements are already included. Do not divide by a second hardware factor, and do not subtract a second statistics-saving factor. Under the same full-sieve architecture, even deleting the entire partition phase only saves a factor about 2.12 over the normalized historical total.

## Count the right unit

There are exactly 2e18-1 even targets from 4 through 4e18 and

    W = ceil((2e18-1)/64) = 3.125e16

64-even output words. Define three different quantities:

- `D`: applications of derived PA theorems. Their fixed proofs can be shared; they need not expand to PA axioms on every use.
- `P`: emitted proof-stream instructions. One theorem application generally needs additional term construction and argument instructions.
- `E`: executed verifier work, counting proof instructions, unifier instructions, and argument/dependency checks.

Only a throughput measured in the matching unit may divide one of these counts. In particular, `1e8 D/s`, `1e8 P/s`, and `1e8 E/s` are different hypotheses. A 62-bit OR is not one PA inference merely because it is one CPU instruction. A proved byte-table method still pays for its table applications, byte extraction, term construction, and composition.

MM0's published fast library check establishes that its representation can avoid redundant work. It does not measure the arithmetic workload proposed here. The proof format explicitly has both proof and unification streams. [MM0 paper, section 3](https://arxiv.org/html/1910.10703v1).

### Dense-sieve comparison with efficient tables

The source-guided revision proposes caching closed byte-operation proofs and applying one fused eight-byte lifting theorem. I independently checked the saved primary source's `CMD_PROOF_REF` branch: an ordinary saved proof is pushed onto the stack without rerunning its theorem unifier. This supports the proposed optimization. It does not establish its throughput. Tables must be hoisted again when the theorem-local proof store resets.

The revised throughput chapter assumes 5e7–5e8 inclusive events per second, centrally 2e8, for short cached templates. The proposed central count is

    sieve: 2.5e18 effective updates * 150 E/update = 3.75e20 E
    cover: 3.125e16 words * 15 masks * 200 E/mask = 9.375e19 E
    total: 4.6875e20 E
    checking: 4.6875e20 / 2e8 / 31557600 = 74,268.96 core-years.

This arithmetic is consistent. It assumes about 80 effective sieve updates/output word after wheel/batching improvements. The 150-event sieve budget must include the required progression, endpoint, mask, and update work on average. A 200-event Boolean lifting theorem alone does not prove that whole sieve budget. Likewise, the 200-event selected-mask budget must average its shift, source-word provenance, union, and bookkeeping costs through sharing. Charging 200 events for each constituent operation separately would make it larger.

The initial generation-unit issue has been resolved by using literal output bytes. The throughput chapter initially proposed 5e7 equivalent inclusive events/second, which would make generation four times the checker cost, about 371,345 generation-plus-checking core-years in this dense model. Its revised native-template producer instead hypothesizes 500 MB/second. This producer need not rerun the checker's unifier, so the separate byte-rate assumption is coherent.

At 250 bytes for each of the 2.96875e18 dense-model updates, 500 MB/second gives about 47,037 generation core-years. Adding the 74,269 checking years gives about 121,306 before discovery. Thus **roughly 100,000 total core-years is coherent for the optimized dense scenario**, while **roughly 400,000 described the earlier slower-producer assumption**. Neither is measured. A generic allowance of half the checking time happens to be exact for the sparse cover calculation above but is not exact for this dense mix, whose average event count per record differs.

### Slower-library sensitivity retained for comparison

Before the cached-byte revision, the integration review proposed an unmeasured 5e6–5e7 inclusive events per core-second, centrally 2e7. The following table retains that slower-library scenario rather than silently discarding the sensitivity:

| Scenario | Inclusive events per output word | Inclusive events/core-second | Checking core-years |
|---|---:|---:|---:|
| Aggressive batching | 1,500 | 50,000,000 | 29,708 |
| Earlier slower-library center | 8,640 | 20,000,000 | 427,789 |
| Expensive arithmetic | 50,000 | 5,000,000 | 9,902,527 |

The middle word budget was an explicit design assumption: 48 effective sieve updates at 80 events each, plus 16 selected masks at 300 events each. It assumes wheels/batching reduce the roughly 100 large-prime strikes per word and that structured updates are cheaper than arbitrary 62-bit arithmetic. It also assumes boundary, base-table, and aggregation work can be amortized. None of those costs has been measured. It is not the revised central scenario above.

Two checks against the peer models prevent a misleadingly small total:

1. The architecture report's central `P=2e20` at `R_E=2e7` takes `316,881*m` core-years, where `m=E/P`. A stream-only count cannot be divided by an inclusive-event rate while silently setting `m=1`.
2. The arithmetic review's selected-cover model has 15 masks/word and 50 derived applications/mask. Its sieve model has about 5.65e18 strikes and 20 derived applications/strike. With 10 inclusive events/application and 2e7 events/second, together they cost roughly 2.16 million checking core-years. The smaller planning center above therefore requires real batching and cheaper structured updates, not just a notation change.

The slower-library center spends 6.75 microseconds per target even. The revised efficient-table center spends about 1.172 microseconds, roughly 31 times faster than the old 36-microsecond assumption. Both are consistent with substantial sharing partly offset by explicit arithmetic-proof overhead; neither recovers the native program's full thousands-fold speed advantage.

## Selected covers are a valid saving, with qualifications

The producer may inspect hundreds or thousands of candidate prime shifts and certify only the small subset whose masks cover a word. Failed searches need not appear in the proof. A fixed PA theorem can turn a certified union mask into all 64 existence statements without spelling out 64 unrelated derivations.

The proposed 8–32 selected masks, centrally 16, are plausible set-cover hypotheses. The toy independent-prime simulation is evidence about that toy model only. Real masks share residue-class restrictions and overlapping source intervals. The actual mean, tail, exceptional words, candidate-pool size, and halo size remain unmeasured. There is no proved uniform 16-mask bound. Exceptional certificates must be included in both the proof and the expected cost.

Selecting 16 masks from 1,200 candidates may itself cost far more than trying 100 shifts once. A naive greedy selection repeatedly rescans candidates. That extra *producer* work is omitted from the short cover proof but is not free. Native search, proof serialization, and checker work need separate clocks.

The larger unresolved cost is prime provenance. Certifying that cleared bits are composite does not certify that the surviving bits are prime. A full sieve certificate needs the complete base-prime coverage and correct progression endpoints. A one-sided prime bitmap may discard extra primes, but every retained one needs justification. Sparse Pocklington-style certificates could replace the dense sieve; their modular arithmetic and production/factorization costs need a different count. No present evidence proves that option cheaper.

## I/O and chunking are not optional accounting details

The compact certificate and its expanded PA proof have different sizes:

| Object | Cumulative bytes |
|---|---:|
| One bit per target even | 2.5e17 = 250 PB = 0.25 EB |
| One 64-bit witness per even | 1.6e19 = 16 EB |
| Sixteen 16-bit selected-prime indices per output word | 1e18 = 1 EB |
| Architecture report's central proof stream | 1e21 = 1 ZB |

The index payload excludes prime evidence, masks, exception handling, and framing. One bit per even is an illustrative bitmap size, not an information-theoretic lower bound on all possible proofs.

The revised efficient-table center has 4.6875e20 inclusive events. At 250 bytes per effective update, its 2.96875e18 sieve-plus-cover updates generate about 742 EB, or 0.742 ZB. This byte allowance is also a hypothesis; sieve and cover records may have different sizes. The architecture report's 1 ZB uses a different instruction-density model. These estimates should not be averaged as if they were measurements; both expose enormous cumulative traffic.

Reading 1 ZB once takes about 31,688 years at an aggregate 1 GB/s, 317 years at 100 GB/s, or 31.7 years at 1 TB/s. Generation, writing, and rereading can add passes. Pipelining can overlap CPU and I/O, so elapsed time is bounded by their maximum rather than necessarily their sum. Streaming can keep peak memory and disk small, but it does not remove cumulative bytes or make independent replay free. A retained compressed payload requires regenerating the expanded proof for another check.

The stock `mm0-c` documentation also restricts individual proofs to 4 GB, theorem/term-table addressing to 32 bits, and theorem statements to the first 4 GB. Therefore a single theorem for each of 3.125e16 words cannot simply be appended to one stock file. A sound chunk-composition protocol or reviewed extension is part of the engineering estimate. Separate successful runs cannot be turned into new axioms in a final run while calling the result one PA proof. [Official verifier documentation](https://github.com/digama0/mm0/blob/master/mm0-c/README.md).

## Assumptions that can move the result by 100 times

- Counting an entire derived arithmetic application as one constant-cost verifier event can underestimate work by one or two orders of magnitude. Expanding every use back to PA axioms can overestimate it severely in the other direction.
- A verified word/byte/progression library that batches numerical work can cut repeated proof operations. It must still prove the particular data accepted by the checker; a once-proved native algorithm is not a certificate of its untrusted execution.
- Replacing the dense sieve with a sparse-prime cover may remove the dominant strike trace, or replace it with still more expensive modular-arithmetic proofs. This is an architecture change, not a small multiplier adjustment.
- Poor literal sharing, array-membership proofs, or a whole-execution trace can add factors of 100 even when the native algorithm is unchanged. Conversely, shared numeral DAGs and short selected-cover certificates can remove them.
- A persistent proof stream at zettabyte scale can impose a separate wall-time limit. A fast CPU model with inadequate aggregate I/O is not an achievable system estimate.

Hardware throughput alone and dropping minimal-partition statistics do not currently support a 100-fold improvement over the normalized historical native baseline.

## What would most change this estimate

Before a large run, the useful experiment is one fully certified high-end segment, including prime-bitmap provenance, selected-cover exceptions, and a sound two-chunk composition. Record `D`, `P`, inclusive `E` if available, bytes, generation CPU time, checking CPU time, and peak storage separately. Use actual inputs near 4e18 and increasing block sizes. A small low-end arithmetic demo or a fast library replay cannot calibrate these quantities.

Until then, publish the central number with the word budget and rate beside it. The proposed efficient architecture is substantially better motivated than per-number checking, but its PA execution cost remains the principal uncertainty.

## Final assembled-model verdict

**Pass as a clearly conditional Fermi estimate, with no blocking arithmetic or claim-status defect found.** This final verdict supersedes this audit's earlier 30,000-core-year planning suggestion. The assembled model increases the allowance to 400 inclusive events and 400 emitted bytes per selected mask to cover slicing and certified lookup in addition to a bare Boolean operation. Its final headline is **50,000 core-years**, with an illustrative **10,000–500,000 range**.

I independently recomputed every sparse scenario component using exact fractions and compared the resulting values with `model.json`. Results were 8,037.132011, **47,919.630421**, and 496,177.188573 core-years. The central total includes 29,707.582326 coverage-checking years, 11,883.032930 emission years, 4,951.263721 compact-cover-search years, 377.751444 anchor-checking years, and 1,000 other years. The 465,661,288 blocks, 238,418,579,456 modeled anchors, and 187.5 EB central coverage stream agree. The wall-time table correctly divides the rounded 50,000 by physical cores times 0.7. The target count is rounded upward by one even integer, with no change to the word or block counts.

The document explicitly labels all operation costs, rates, pool sizes, and retained-mask counts as assumptions. It does not claim a measured runtime, completed implementation, or a proved fixed-pool covering theorem. It explicitly requires checking every covered word and allows fallback costs outside the range. Its 8,037-year aggressive scenario is rounded to a 10,000-year planning endpoint, which is acceptable because the range is expressly illustrative rather than a bound enclosing all modeled outcomes.

The 400-event allowance remains a design assumption rather than proof that all lookup and provenance work fits within it. The 500 MB/second emitter is likewise unmeasured. Those limitations are adequately stated. The model separately accounts for native cover search and avoids mixing theorem applications with inclusive events or emission bytes. No additional research or implementation was required for this verdict.

Reviewed SHA-256 pins:

- `SPARSE_ESTIMATE.md`: `9c3ec810d5118fe40c2157f2d902eae8a936d5d0c5be08d88279a37be1f346d1`
- `model.py`: `018a5fff283f2ba0c833d8283d5ce3a2b8c640bb6078267273db5de0e1e8c73a`
- `model.json`: `c19b8582930998cdc5c00868dede97f8162fa5d7e606d8433e00feb418505f4e`
