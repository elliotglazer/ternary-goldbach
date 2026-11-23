# A PA certificate architecture for Goldbach through 4e18

Research design and Fermi estimate, 2026-11-10. Nothing here is implemented or benchmarked. The instruction counts are explicit planning assumptions, not measured properties of MM0.

The proposed certificate proves Goldbach in blocks. A segmented sieve certifies prime bitmaps; a separate cover certificate selects a few prime shifts whose masks cover each 64-even word. The producer may perform an expensive search, but the proof contains only the selected masks. This removes failed Goldbach search attempts from the checked computation. It does not remove the cost of proving the prime bitmaps or the word operations correct.

The preferred efficient architecture is the sparse-anchor version in section 10. It certifies a shared small-prime bitmap and a modest number of large prime anchors instead of sieving the entire large range. Its planning central case is about 30,000 core-years for generation and checking together, with substantial uncertainty. The earlier dense-sieve design in sections 1-9 remains a comparison and fallback architecture; its central count is about 2e20 proof-stream instructions. Proof-stream instructions and inclusive verifier events are different units and must not be combined at the same rate.

## 1. Target and representation

Freeze the PA statement before writing a generator:

    For every natural n, if 4<=n<=4,000,000,000,000,000,000
    and n is even, then there exist primes p,q with n=p+q.

There are M=1,999,999,999,999,999,999 target evens and

    W=ceil(M/64)=31,250,000,000,000,000

output words. Deal with n=4 separately, since the other representations use two odd primes. Mask the final word explicitly. Use binary or hexadecimal numerals and fixed-width words encoded as natural numbers below 2^64. Prove all word lemmas as PA theorems, with conservative definitions for extraction, shift, AND and OR. Arrays and finite lists must have explicit PA encodings; they are not new set-theoretic axioms.

Use segments containing, for example, 2^26 odd candidates, about 8 MiB of bitmap. Each segment stores a halo wide enough for the permitted small-prime shifts. Its theorem states the numerical interval, bitmap value and the implication that every set bit denotes an odd prime. Segment boundaries, the halo, small exceptional primes, and the final interval are part of the checked statement.

MM0's repository contains a PA example with natural numbers, arithmetic, induction and binary constructors. Its documentation describes checking an `.mm0` specification against an `.mmb` proof; it does not make native word execution a PA inference rule. See the [PA example](https://github.com/digama0/mm0/blob/master/examples/peano.mm0) and [verifier documentation](https://github.com/digama0/mm0/blob/master/mm0-c/README.md). These are source interfaces, not evidence that the proposed sieve or bitset library already exists.

## 2. Certify primality separately

The required prime table reaches floor(sqrt(4e18))=2,000,000,000. Produce and certify that smaller table once by a recursively justified sieve. A survivor at the large scale is prime because every composite m>=2 has a prime divisor <=sqrt(m). That elementary theorem has a fixed PA proof.

For an odd segment A+2i, start from all candidate bits and clear every multiple of each relevant odd base prime. The first strike can be max(p^2, the first multiple in the segment). Starting at p^2 preserves p itself, while the small-prime-divisor argument still proves completeness of elimination. Remove 1 explicitly. A finite induction over the complete base-prime list gives:

    A set bit is not divisible by any prime p<=sqrt(segment maximum),
    hence its represented integer is prime.

The certificate needs elimination completeness for surviving bits. Listing a divisor for each cleared bit only proves that those cleared bits are composite and does not establish that the survivors are prime.

The checker should regenerate strike positions from an initial residue and an arithmetic progression, not accept a supplied mask without proving its relation to p. A reusable progression-mask theorem can clear several strikes at once. Pre-sieving very small primes using periodic word masks avoids repeating scalar marks. For larger primes, use bucketed progressions or segment-local lists of affected words. Every bucket movement and every progression endpoint used to justify completeness still needs a proof or a verified checker computation.

The generator does not need to prove that its sieve is fast. It needs to emit enough evidence to prove the final bitmap is a subset of the primes. Additional zero bits are harmless for Goldbach coverage. A missing small prime in the base table is not harmless unless a separate argument proves it cannot divide any surviving integer.

The full odd bitmap would be 2e18 bits, or 2.5e17 bytes, about 0.25 decimal EB. It can be streamed a segment at a time; it need not reside in memory or on disk at once. A full set of per-integer primality certificates would throw away this sharing.

## 3. Certify only a selected Goldbach cover

Let an output word represent E_j=a+2j for 0<=j<64. For an odd small prime p, take the corresponding slice of the certified odd-prime bitmap for q=E_j-p. After boundary checks and a shift combining at most two adjacent source words, its mask C_p satisfies

    bit(C_p,j)=1 implies Prime(p) and Prime(E_j-p).

Choose a list p_1,...,p_d and prove

    C_(p_1) OR ... OR C_(p_d) = active-word mask.

A fixed PA lemma then yields Goldbach for all active positions of this word at once. It existentially selects the prime corresponding to a set bit in the union; there is no need to expand a separate 1,000-step proof for each represented integer. A second fixed lemma combines adjacent certified intervals.

The producer can try thousands of candidate p values and solve a small set-cover problem. Its certificate includes only the selected p indices, not the rejected attempts or the greedy algorithm's execution. Minimality of the selected set is irrelevant. If a word cannot be covered by the chosen pool, enlarge the pool or use an exceptional certificate. Any Fermi estimate based on a typical d must account for exceptional words; no uniform d bound is proved here.

For a dense bitmap near 4e18, the heuristic probability that an odd candidate q is prime is about 2/log(4e18), approximately .0467. A sequential search might need roughly 100 attempted shifts to fill a 64-bit word. Searching a larger pool and retaining only a good cover can reduce the checked number d. The planning scenarios use d=8,16,32. These are unmeasured set-cover assumptions, not a theorem about primes or independent random bits. Residue-class correlations matter and must be measured on actual segments.

Do not multiply W by the number of failed producer attempts when estimating cover proof work. Conversely, do not claim one native OR validates the meaning of all its input bits. The input masks require certified provenance from the prime table.

## 4. Why a packed witness array is not automatically cheaper

An alternative assigns a small-prime index to every even. Sixteen-bit indices cost 4e18 bytes, or 4 EB, before prime evidence. Even a 10-bit average code would cost 2.5 EB. It saves search history but leaves 64 indexed prime-bit lookups per output word.

Packing those indices into a few machine words does not turn an arbitrary gather of 64 unrelated bits into one PA step. A proved vector-gather checker, sorting/merge certificate, or other batch membership argument could improve this, but its operations and proof must be counted. Merkle proofs certify consistency with a committed table; hashes alone do not prove the committed bits denote primes. A probabilistic proof of correct lookup is not the requested deterministic PA proof.

The selected-shift representation keeps the lookups contiguous. With d=16, each word needs at most 32 source-word references and 16 selected prime references, then a fixed sequence of shifts and ORs. Reusing source words and prime facts across neighboring outputs can reduce representation overhead without changing the logical obligations.

## 5. A computation trace is still a proof obligation

There are two sound implementation paths.

1. A proof-producing checker emits ordinary MM0 proof instructions for every arithmetic fact, lookup and block-cover theorem application. Its proof file is checked against the fixed PA specification.
2. A generic certificate checker is defined and proved sound in PA. The instance additionally carries a PA proof that this checker accepts the actual certificate. Proving checker soundness once does not prove a native run's return value. Evaluation by a verified proof-producing interpreter can supply that second proof.

Adding an unchecked instruction that runs the native sieve and declares success changes the trusted proof system. Accepting a hash of an external successful run is also insufficient. A fully proved implementation or compiler may move the trust and proof boundary, but its execution acceptance still has to fit the chosen formal verification model.

Fixed 4-bit or 8-bit arithmetic tables can amortize repeated truth-table reasoning. For example, a 64-bit OR can use eight byte operations with a small proved composition theorem. An 8-bit binary-operation table has 65,536 cases, so it is feasible to prove once. Looking up a table row, constructing literals and composing the result still take MM0 instructions. The per-word instruction costs below include these tasks only as hypotheses to benchmark, not as measured constants.

## 6. Native work versus checked proof work

The dense sieve's odd-candidate count is 2e18. A rough prime-reciprocal estimate gives sum(1/p) over odd primes through 2e9 about 2.826. The primes 3 through 61 contribute 1.213857..., leaving about 1.612 for p>64. Thus scalar large-prime strikes alone are roughly 3.22e18, or about 103 per 64-candidate word, before endpoint corrections. This is a heuristic operation estimate, not a required analytic premise of the proof. Pre-sieving, wheels and grouping strikes into a word can reduce the number of emitted update records. They cannot be assumed to divide every large-prime strike count by 64, because most such progressions touch a word only once.

Use a for the number of effective sieve update records per output word, d for selected cover masks, s for MM0 instructions per sieve record and c for instructions per selected mask. The main model is

    total proof instructions = W*(a*s+d*c).

The count does not include producer search or factorization attempts. It does include the checked arithmetic/provenance of the accepted sieve updates and cover masks. A benchmark must add segment boundary proof overhead, literal encoding, base-table proof, block aggregation and any repeated reads if those are not negligible. The table assumes those lower-order costs can be amortized; that is part of the design to test.

| Scenario | Sieve records a/word | Instructions s/record | Selected masks d/word | Instructions c/mask | Instructions/output word | Total instructions |
|---|---:|---:|---:|---:|---:|---:|
| Optimistic | 32 | 10 | 8 | 30 | 560 | 1.75e19 |
| Central | 96 | 50 | 16 | 100 | 6400 | 2e20 |
| Conservative | 160 | 500 | 32 | 1000 | 112000 | 3.5e21 |

These are scenarios, not confidence bounds. The optimistic sieve row requires substantial batching and a compact proved arithmetic library. The central row corresponds to about 100 proof instructions per even after sharing, versus a separately constructed 1,000-step proof per even. The conservative row can be worse than that naive baseline. The table derives costs from accepted records rather than assigning a fixed proof length to each integer.

For native certificate checking, 3 to 8 machine-level operations per sieve record and 5 to 10 per selected mask give roughly 1e19 operations in the central dense design, plus memory traffic and decoding. Treat this as an order-of-magnitude count. A modular arithmetic operation in a different design is not interchangeable with one simple shift or OR. Producer work can exceed checker work because candidate searches and failed construction attempts are absent from the certificate.

At an assumed sustained 1e8 MM0 instructions/second per core, the three rows take approximately 5,545; 63,376; and 1,109,083 core-years. This rate has not been benchmarked on the proposed proof terms. Parallel chunk checking reduces elapsed time only to the extent that generation, I/O and final sound composition also parallelize.

These counts are emitted proof-stream instructions, not an inclusive count of verifier events. If E additionally counts unifier instructions and argument checks, write E=mP where P is the table's proof-instruction count and measure m. At an event rate R_E, time is mP/R_E, not P/R_E with the extra work silently omitted. For example, the central P=2e20 at R_E=2e7 events/second gives approximately 316,881*m core-years. This architecture does not independently justify a 30,000-core-year central estimate. The assumed 1e8 stream-instruction rate would have to include all verifier work in its measured elapsed time before using the preceding illustrative times.

## 7. Byte cost and storage

For illustration, assign 2, 5 and 12 encoded bytes per MM0 instruction to the three rows. This gives cumulative proof streams of 3.5e19, 1e21 and 4.2e22 bytes, respectively. The central stream is 1 decimal ZB, or 1,000 EB. Those byte densities are assumptions, and literal/term encodings could make them larger.

The much smaller certificate payload is not the expanded PA proof. At d=16, sixteen 16-bit small-prime indices per word cost 1e18 bytes, about 1 EB. Adding the uncompressed odd-prime bitmap gives about 1.25 EB before framing, exceptional cases, sieve residues and metadata. Indices alone identify the source slice only when the segment origin and the candidate-prime dictionary are already fixed and checked. Re-encoding or regenerating these payloads can reduce stored bytes but not eliminate proof of their values.

All these are cumulative bytes processed. Peak memory can remain a few segments plus a bounded proof buffer. If a proof is generated, checked and discarded, peak disk can also be small, but independently replaying the full proof later requires retaining it or regenerating it. A 1 ZB stream alone takes about 31,700 years at 1 GB/s or 317 years at 100 GB/s. The instruction-rate assumption and byte density must fit a realistic total bandwidth; they cannot be scaled independently without limit.

The current `mm0-c` format documentation lists 32-bit theorem/term-table offsets, a 4 GB maximum for an individual proof, and implementation store limits. Therefore this design cannot simply append one named theorem per output word into one stock file. It needs checked hierarchical chunks, or an explicitly reviewed format/driver extension that preserves proof checking. Treating a previous chunk's target as an axiom in the next chunk without a verified composition rule would weaken the claim. The practical chunk protocol and final PA aggregation are unresolved engineering work. See the [documented limits](https://github.com/digama0/mm0/blob/master/mm0-c/README.md).

## 8. Sparse-prime alternative worth comparing

For a block of 2^20 evens, choose a pool of certified large primes q just below the block and cover it using shifts of a single globally certified table of small primes p. The small-prime mask is denser than the large-prime mask. This can avoid sieving every large odd integer. The producer emits only the large primes actually used and their deterministic primality certificates, such as certificates based on a proved Pocklington theorem.

For roughly 1.9e12 such blocks and a pool of 256 large primes per block, there are about 4.9e14 large-prime certificates before deduplication. If a checked primality certificate costs 1e5 to 1e6 MM0 instructions, this alone costs 4.9e19 to 4.9e20 instructions, before cover proofs. Modular exponentiation must be proved, including reduction identities, so calling the primality test one operation would conceal the dominant cost. Finding convenient primes and factoring their p-1 values is producer work; failure to find a convenient certificate requires a fallback rather than an unproved assumption.

This is a genuine way to exchange dense sieve proof cost for sparse arithmetic certificates, but the present figures do not establish that it wins. Benchmark both. A segmented sieve may still be the best untrusted producer for finding those primes even if the checked certificate uses a different method to prove them prime.

## 9. The next bounded experiment

Implement one numerical word library and one proof-producing block checker before extrapolating to 4e18.

- Freeze the PA statement and prove the generic prime-bit implication and cover-union lemmas.
- Generate actual segments near 4e18 with 64, 256, 1024 and 4096 candidate small-prime shifts. Measure selected-cover sizes, not just the number of attempted shifts. Record the maximum and the tails as well as the mean.
- Emit one complete segment proof, including its base-prime provenance, sieve progression completeness, boundary handling and every numerical word result. Measure MM0 instructions, bytes, CPU and peak live storage separately for sieve and cover.
- Compare at least one sparse-prime block using deterministic primality certificates. Count its modular arithmetic proof work independently.
- Test a two-chunk composition proof against the exact final interval statement. Do not defer chunk soundness until after large-scale generation.

The most useful early result is an observed pair of costs s,c and an observed cover-size distribution. If those approach the conservative row, compression of the producer's search alone will not make the proof practical. If the sieve needs a proof step for each crossed-out bit and those steps expand heavily, a different primality certificate architecture is the next target.

## 10. Preferred efficient version: large blocks and shared small-prime masks

This section replaces the full large-range sieve in the primary estimate. Use blocks of m=2^32 consecutive even targets, with origins a_b=4+2mb. The exact block count is

    ceil((2e18-1)/2^32)=465,661,288.

For each block after the first, choose initially 512 distinct certified odd primes q in [a_b-D,a_b), with D=2^20. Put delta_q=a_b-q. For every target n=a_b+2j in that block,

    n=q+p,    p=delta_q+2j,
    1<=p<2^33+D.

All the small-prime facts therefore come from one shared certified bitmap through 2^33+2^20=8,590,983,168. Its odd-only payload is 536,936,448 bytes, about 0.537 GB. It is constructed by an ordinary segmented sieve with base primes only through its square root, about 92,700. This computation and its proof are tiny compared with the global cover stage, although they must still be implemented and checked.

Each anchor q needs a deterministic PA primality certificate, for example a certificate checked using a proved Pocklington criterion with recursively certified factors. Searching for anchors, testing candidates and factoring q-1 are producer tasks. A probabilistic prime test may guide the search but cannot replace the final prime proof. Even an upper count of 512 anchors for every block gives only 238,418,579,456 anchor certificates. Omitting the first block subtracts 512. At an assumed 1e6 inclusive verifier events per certificate and 2e8 events/second, checking all of them takes about 38 core-years. This allowance needs a real arithmetic benchmark, but it has room to grow substantially before dominating coverage.

The first block has targets 4 through 2^33+2. Certify it directly with the same small-prime bitmap, treating 4=2+2 separately. No negative anchor, assumed prime gap, or downward extension of the main-block argument is needed. The final block includes only the remaining target positions through exactly 4e18.

For each later output word, the producer forms the 512 masks using the shifts delta_q in the small-prime table and selects a short cover. A selected mask is justified by the anchor's already proved primality plus two aligned words from the shared small-prime bitmap. The checker does not prove any rejected candidate anchor prime and does not prove any unselected large integer composite. This is where the main saving over the dense-sieve trace comes from.

### Complete fallback and its limitation

If the initial 512 anchors do not cover a word, try 1,024 anchors, more anchors from the same interval, or a wider interval with an enlarged certified small-prime table. The certificate records the actual interval and table bounds. A final exception format supplies explicit p,q prime certificates for each still-uncovered target and checks p+q=n. The producer can search p<=n/2 exhaustively for that format.

The verifier is deterministic and its acceptance implies the full target theorem, including exceptions. The generator is complete for true finite instances if exhaustive search and complete primality proofs are allowed. This does not prove that a fixed pool of 512 anchors always succeeds, that a chosen short interval always contains enough convenient anchors, or that the exception count is small. If no representation is found, the generator cannot issue an accepted certificate. The planning time assumes exceptions are rare; a worst-case guaranteed running-time bound is not claimed.

There is no apparent algebraic obstacle to the anchor construction: the identity n=q+delta_q+2j is exact and the small-prime range bound is uniform over all blocks. The main unresolved empirical issue is the cover distribution under actual prime residue correlations and the cost of producing the deterministic anchor certificates.

### Cached word access and byte proofs

Store the small-prime proof as chunks of 256 or 1,024 aligned words with a theorem stating that all set bits in the chunk are prime. Extract individual closed word facts with fixed finite selectors. At output word index j, the anchor shifts access offsets (delta_q-1)/2 below 2^19 bits. Thus all required input words lie in a sliding window of at most 8,194 aligned words, including the boundary word. Extract a new input-word fact once as it enters this window, cache it, and reference it across the selected masks. This avoids proving an arbitrary lookup into a huge encoded list separately for every mask.

Use preproved closed tables for byte OR, and for byte slices with shifts 0 through 7. The OR table has 65,536 cases; the full shift-slice table has 8*65,536 cases. Each output word combines the eight byte facts by one fused word lemma. A shifted mask plus OR can require about 16 byte facts, two source-word references and a semantic cover step. The team's source-level estimate is 200-400 inclusive verifier events per selected mask, with 200 an optimistic central engineering target. These counts include unification and argument checks; they are not the proof-opcode counts used earlier. They remain unmeasured.

The proof also needs chunk extraction, index arithmetic and checked composition. Include those in the benchmark. The narrow streaming access gives a concrete way to amortize them, but does not authorize treating an unverified array read as a theorem. Current `.mmb` format limits still require a reviewed multi-chunk container or format extension with a sound composition rule; reclassifying chunk results as new axioms is not acceptable.

### A bounded synthetic cover experiment

`cover_model.py` ran 128 independent 64-bit cover trials at two Bernoulli densities. With 512 candidate masks and density .058, greedy selection used 11-14 masks, median 13. At density .087 it used 8-11, median 10. All 256 synthetic words were covered. With 1,024 candidate masks the corresponding medians were 11 and 9 in the saved script's run. These are simulated masks, not actual primes, and establish no tail bound over 2e18 targets.

The density .087 approximates 2/log(2^33); .058 deliberately reduces it to represent adverse residue effects. Prime masks are correlated. Even under independence, an event rare for one word can produce many exceptions over this enormous range. For example, (1-.058)^512 times 2e18 is still on the order of 1e5 uncovered positions. Increasing the pool or explicit exceptions matters. The sample supports testing a central selected count of 15; it does not validate it for the real computation.

### Revised efficient cost model

Use W=3.125e16 output words and d=15 selected masks per word. At 200 inclusive verifier events per selected mask,

    E_cover=9.375e19 events.

At 2e8 events/second this is 14,854 checking core-years. At 250 expanded proof bytes per selected-mask update, the cover stream is 1.171875e20 bytes, about 117 decimal EB. Producing that stream at 500 MB/second takes 7,427 core-years. These are cumulative per-core costs and bytes; peak storage can be much smaller under sound streaming. Neither throughput is a measured result for this architecture.

Budgeting 20,000 native search cycles per output word at 4 GHz gives another 4,951 core-years. The central budget adds roughly 1,000 core-years for anchor construction, exceptions, chunk management and unmodeled overhead, for about 28,200 core-years, rounded to 30,000. This allowance is a planning assumption. It must not be reported as a completed implementation's runtime. Emission and checking can overlap in elapsed time, but their core-time costs still add if they use separate cores. Confirm that an emitter benchmark does not already include the search work before adding that component.

With 512 anchors, a selected anchor index takes 9 bits. Fifteen such indices per word cost about 5.27e17 bytes, or 0.527 EB, before framing. This compact certificate is much smaller than the expanded PA proof. Its checking still needs the computed masks and the logical derivation. The shared small-prime bitmap is only about 0.537 GB; the anchor certificates may add substantial terabytes without approaching the cover proof stream.

Sensitivity is large. For d=8-32, 100-400 events per mask and sustained checking rates 5e7-5e8 events/second, cover checking alone ranges from about 1,600 to 254,000 core-years. The upper endpoint combines all adverse assumptions. At the central rate, doubling the event cost from 200 to 400 adds another 14,854 core-years. Generation, search and exceptional cases then have to be added using consistent units. A defensible headline is an efficient central scenario of roughly 30,000 core-years, with at least an order of magnitude uncertainty until an actual block proof is measured.

### Dense-wheel comparison

For reference, the parent's 2.5e18 effective mod-30 sieve strikes is a plausible separate dense architecture assumption. The count is approximately

    4e18*(8/30)*sum_(7<=p<=2e9)1/p
      ~= 2.44e18,

before p^2 and segment endpoint corrections. The mod-30 wheel removes factors 2,3,5 once. Its reduced residue density is 8/30 over all integers, not 8/30 over the already odd-only table. With 150 inclusive events per strike, the dense prime-certification stage alone costs 3.75e20 events, larger than the sparse-anchor cover stage. The sparse architecture avoids that full-range strike trace rather than asserting that every strike becomes free through byte caching.
