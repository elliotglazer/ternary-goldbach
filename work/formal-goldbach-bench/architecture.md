# Certificate architectures for an optimized Lean–MM0 comparison

Research audit, 2026-11-10. No theorem-prover benchmark or implementation was run for this note. The target remains binary Goldbach for every even integer from 4 through 4e18, with no empirical Goldbach axiom. Earlier estimates in `work/mm0-fermi` are architecture scenarios, not established runtimes.

## Main finding

**A common 64-bit format is a useful controlled experiment but can materially handicap Lean.** Lean 4.35.0's kernel directly reduces `Nat.land`, `Nat.lor`, `Nat.xor`, `Nat.shiftLeft`, and `Nat.shiftRight`, as well as arithmetic on natural-number literals. It can therefore certify one wide bitset calculation without a separate PA proof for every bit or byte. This is kernel computation, not native-decide trust. The same source has a default 128 MiB numeral-size limit and bounded shift counts. [Pinned kernel source](https://raw.githubusercontent.com/leanprover/lean4/v4.35.0/src/kernel/type_checker.cpp).

The principal comparison should optimize each prover's representation separately, while keeping the target, prime evidence, and certificate semantics equivalent. Report a shared-format comparison as a second result. Neither a microbenchmark on 64-bit arithmetic nor the number of logical theorem applications decides the optimized ranking.

## 1. Preserve the useful sparse-anchor mathematics

The earlier sparse design is sound in principle. Split the target interval into blocks; certify a reusable table of small primes and a collection of large prime anchors below each block. If a target n has n−q in the small-prime table for one certified anchor q, it has a Goldbach representation. Positive table bits need prime soundness; the table need not contain every prime. The small exceptional initial interval and all endpoints must be included explicitly.

This avoids certifying every prime near 4e18. It also lets untrusted search choose a short covering list, without proving the search procedure or reproducing its failed attempts. The remaining costs are concrete primality certificates, table soundness and access, shifted-mask coverage, and interval assembly.

The old choices of 2^32 target evens per anchor block, 512 anchors, and 15 selected masks per 64-bit word are not mathematical guarantees or measured optima. A larger local cover window generally needs more selected masks. Arithmetic correlations and rare hard targets invalidate any inference of complete coverage from independent random-bit estimates. Enlarged anchor pools and explicit exceptional representations preserve correctness, but their frequency affects cost.

## 2. Best immediate Lean candidate: wide kernel bitsets

For W target evens, define a coverage theorem with the following checked data:

* a target origin and active-length bound;
* prime facts for the selected anchors;
* certified source chunks whose set bits denote small primes;
* explicit shifts mapping source indices to n−q;
* a closed equality saying the union of the shifted, truncated chunks contains the active W-bit mask.

The mathematical theorem connects each set bit to a representation. Kernel reduction checks the closed arithmetic equality. It is unnecessary to instantiate a theorem for each target integer. A final range-composition theorem combines the local universal statements.

Use `Nat` literals with the kernel-supported bit operations. There is no reason to implement the same calculation as a recursive list of booleans, or to assume `UInt64`/`BitVec` wrappers incur identical reduction costs. Literal decoding, definitional unfolding, proof elaboration, and rechecking must be measured, not just the arithmetic primitive.

Suggested width sweep: 64, 256, 1024, 4096, 16384, and 65536 bits, extending it if memory and generation cost permit. A larger numeral does not imply constant-time arithmetic: its limbs must be processed. Large widths principally amortize expression, theorem, and indexing overhead.

### Source-chunk layout matters

Do not encode the entire roughly 537 MB small-prime table as a single `Nat`, then shift that giant object for every local lookup. Apart from the default numeral limit, this can make each lookup depend on the table size instead of W. Store verified chunks and choose a source-chunk width comparable to the cover window. A contiguous W-bit source slice needs at most two adjacent W-bit chunks, with an explicit local offset. The appropriate prime-soundness theorem must accompany the chosen chunks.

A shared lookup function over a long inductive list can also hide linear traversal. Direct references to indexed chunk theorems, or a proved balanced/indexed representation, avoid silently charging the entire table per access. The benchmark must include this provenance cost. A cached integer alone is not a cached proof of which primes it represents.

## 3. An explicit scaling model

Let M≈2e18 be the number of even targets, W the local bit width, d(W) the actual mean number of selected masks, and L the implementation limb width. Let alpha be per-operation expression/proof overhead and beta the cost per limb. An idealized wide-bitset coverage cost is

    (M/W) d(W) [alpha + beta ceil(W/L)]
      ≈ M d(W) [alpha/W + beta/L].

This does not yet include source lookup, literals, primality, exceptions, or assembly. It shows why W should increase while alpha dominates, but not indefinitely: d(W) can grow and the beta term remains. The selected cover's distribution matters, not just its mean. Peak memory can depend on live intermediate bitsets and proof-DAG retention.

For explicit PA proofs using g-bit digit lemmas, a different first model is

    (M/W) d(W) k ceil(W/g) ≈ M d(W) k/g

proof events, with k measured rather than assumed. Here increasing W alone may not help; it can increase cost through d(W). Shared arithmetic lemmas and reused concrete results can change k, and their implementation must be benchmarked. A cost curve from one prover must not be transplanted to the other.

A nonselected pool of A anchors per wide chunk is another candidate: it avoids expensive greedy set-cover generation and fixes the mask count at A. Its check cost uses A in place of d(W). Compare total generation-plus-checking time, because minimizing the proof need not minimize the project.

## 4. Packed arithmetic is a sound alternative, not a free speedup

Arithmetic can batch more than fixed-width words. For example, encode finite sets as polynomials with 0/1 coefficients, evaluated at a base b. Their integer product encodes convolution counts without carries if b exceeds every possible coefficient. With at most A contributing anchors, b>A suffices. Coefficient j then counts certified representations at the corresponding target offset. This is exact Kronecker-style packing; the proof must establish the coefficient bound, orientation, truncation, and interval halo.

However, checking that every target coefficient is positive is a separate obligation. One whole-integer comparison to a repeated-one pattern does not establish digitwise positivity: a larger high digit can hide a zero low digit. A checker needs verified extraction, a bit-parallel digit test, or a suitable auxiliary certificate with proven digit bounds. In Lean, native kernel shifts and bitwise operations now make direct bitsets the simpler initial experiment. Multiplication may help when it replaces many shifts and unions, but can lose through increased bit length and the cost of positivity checks.

Another possible certificate partitions the targets into disjoint submasks assigned to anchors. In base b>A, their sum equals the repeated-one target pattern exactly when every digit is covered exactly once, provided each submask is certified to have 0/1 digits. Each submask still needs a subset proof relative to its prime mask. Omitting the digit and subset obligations would make this argument unsound. Materializing all submasks can also expand the payload.

For PA/MM0, multiplication and bitwise functions are mathematical definitions, not assumed native arithmetic inference rules. A fast arithmetic algorithm can have a short reusable correctness theorem while its concrete run still requires evidence. Subquadratic arithmetic or certificate-based multiplication is worth researching; it is not justified to assign one MM0 event to an arbitrary huge integer multiplication.

## 5. Real PA/MM0 optimizations

Use binary numerals, preproved small-digit tables, fused slice-and-union lemmas, and references to already checked closed prime/chunk facts. Pick the digit size empirically: a larger binary-operation table has quadratically more cases and can increase literal, lookup, and proof-reference costs. A common symbolic theorem can be reused without re-proving it from the PA axioms.

MM0's binary proof design supports efficient checking and sharing, but its library-verification benchmark does not measure this arithmetic workload. The `.mm0` specification must be checked alongside the proof so the accepted theorem is the intended one. [MM0 paper](https://arxiv.org/abs/1910.10703), [reference verifier documentation](https://github.com/digama0/mm0/blob/master/mm0-c/README.md).

DAG sharing is strongest when subterms or concrete facts recur. Distinct windows usually have distinct concrete bit patterns; a generic lemma does not establish their distinct numerical premises automatically. A compressed macro stream can save generation/storage, but its expansion or checked interpretation has a cost. Grammar compression of a proof is not the same as compression of the computation's logical evidence.

A stronger PA alternative is a domain-specific reflection theorem with an encoded checker and a proof-producing evaluation strategy that batches many small arithmetic steps. This could improve on bytewise proof emission. It must demonstrate how concrete evaluation is certified and report its total proof/event count. The mere existence of a sound checker does not establish an acceptance result.

## 6. Compilation and trust boundary

There are three distinct claims:

1. a checker is mathematically sound;
2. compiled code implements that checker;
3. this concrete input causes the checker to accept.

A proof of the first two does not supply the third. A native run observed outside the logic is not by itself a standard-axioms-only theorem. Sound options include checked execution evidence, proof-producing computation, or reduction by the existing trusted kernel. Extending a verifier to accept native arithmetic may be a reasonable new system, but it is a different trust configuration and must be reported separately.

In Lean, `decide +native` uses additional trusted native evaluation, whereas the requested strict path can use kernel evaluation. Version-specific axiom names change; audit the actual proof dependencies rather than searching for one historical name. [Lean proof-validation reference](https://lean-lang.org/doc/reference/latest/ValidatingProofs/), [Lean 4.35.0 release notes](https://lean-lang.org/doc/reference/latest/releases/v4.35.0/).

If MM0 is used as an external prover for Lean, a proved MM0-checker soundness theorem is only part of the bridge. Lean must also certify acceptance of the concrete proof or receive a translated proof term. Kernel-checking the entire MM0 byte stream can erase its native speed advantage; do not assume integration is free.

## 7. Benchmark and forecast requirements

Keep two tracks: the same semantic certificate represented naturally in each prover, and separately optimized certificates for the same Goldbach target. For every track record generation, elaboration/emission, standalone kernel verification, output bytes, live memory, and actual proof dependencies. Separate one-time library/table work from per-window work and final assembly.

First benchmark synthetic operations only to map width scaling. Then use actual high-range anchors with the shared prime table and include source-chunk provenance, primality evidence, endpoints, and exceptions. Synthetic random masks do not estimate real cover difficulty reliably. Measure a histogram of d(W), not just hand-selected easy examples.

Primality may become the bottleneck after bitset acceleration. Benchmark the actual anchor-certificate method, including its modular arithmetic and shared factor proofs. Likewise, a small-prime table cannot be imported merely as a trusted bitmap. Its proof might be amortized over the project, but must exist and be included in end-to-end checking.

No defensible optimized Lean/MM0 multiplier follows yet. The concrete structural expectation is that native kernel big-integer operations favor wider Lean blocks, while explicit PA digit proofs favor stronger fact reuse and possibly smaller windows. Either expectation may be overturned by measured proof construction, lookup, or primality costs. The current 64-bit estimates must be labeled conditional on that architecture rather than treated as system-wide forecasts.

## 8. Same PA axioms, different arithmetic checker

The scope of the comparison matters. **There is no in-principle requirement that an optimized MM0-based PA checker expand every arithmetic operation into the present stock verifier's proof instructions.** A verified arithmetic accelerator is a legitimate additional architecture. It need not introduce a new mathematical axiom.

Three boundaries should be stated separately:

| Boundary | Question |
|---|---|
| Mathematical foundation | Are the target statements still derivable from the chosen PA axioms and conservative definitions? |
| Proof representation | Is the certificate ordinary current MMB, or does it contain compressed arithmetic/evaluation instructions? |
| Trusted implementation | Which parser, verifier, arithmetic library, compiler, and execution model justify acceptance? |

For example, extend a checker with an instruction claiming that the AND of two concrete natural-number literals is a third literal. Its admissibility can be justified by an arithmetic algorithm proved correct for the PA definition of AND, together with a verified implementation of that algorithm or a certified translation of each accepted instruction into an ordinary PA derivation. The optimized checker can validate the compressed instruction without materializing the expanded derivation. Addition, multiplication, shifts, and bounded block checking admit analogous approaches. The construction must cover decoding, bounds, allocation, and the implementation assumptions actually used.

The important mathematical claim is derivability preservation for these additional instructions. It is unnecessary, and potentially misleading, to demand a PA proof of the global semantic soundness of PA itself. A local admissibility or proof-translation argument is the appropriate obligation.

Under that design, the mathematical axioms can be unchanged while the proof format and trusted checker differ. It is **not ordinary verification by the current stock MMB verifier** unless the new instructions are first expanded into proofs it accepts. It may nevertheless be a conforming alternative MM0 verifier in the broader specification-level sense: the MM0 documentation treats the proof side-input format as implementation-dependent, and requires acceptance to imply derivability of the supplied specification. [MM0 format specification](https://github.com/digama0/mm0/blob/master/mm0.md), [reference verifier contract](https://raw.githubusercontent.com/digama0/mm0/master/mm0-c/README.md).

A verified alternative checker is not automatically an increase in *unverified* trusted code. Its arithmetic implementation may be proved against a smaller machine model, with a bootstrap verifier checking that proof once. But the exact proof, compiler/execution boundary, and connection to the binary used must be supplied. Conversely, merely writing a fast arithmetic routine and asserting its correctness would introduce an unverified trust assumption, even if the `.mm0` axiom list remains unchanged.

This also clarifies section 6. For the **original stock kernel**, an observed external checker run is not a derivation of the concrete result. For an **accepted alternative verified kernel**, executing that kernel is the final proof-checking operation, just as executing the stock kernel is. It is not necessary to recursively re-certify every machine instruction forever. What changes is the explicitly chosen verification boundary. The unimplemented accelerator scenario should not be excluded by treating the current boundary as a law of PA.

Accordingly, forecasts should distinguish:

* optimized certificates checked by the present MM0/PA verifier;
* optimized certificates checked by Lean's present kernel, including its arithmetic primitives;
* an arithmetic-accelerated, derivability-preserving MM0/PA verifier, whose implementation and throughput remain to be established.

The third could narrow or reverse an advantage observed for Lean's present arithmetic kernel. There is no measured multiplier for it here. A claim about the most efficient possible implementation must include this open alternative, while a practical forecast may explicitly restrict itself to developed kernels.

## 9. Precompute all 64 source alignments

The small-prime table is reused over the entire outer range. This makes alignment precomputation much more attractive than it would be for a one-use sieve.

Let P be its odd-candidate bit length, roughly 2^32 bits in the previous sparse design. Store the 64 shifted views, or equivalently the 64-bit window beginning at every permissible bit position. The raw storage is approximately

    64 * P/8 = 8P bytes ≈ 34.4 GB,

slightly larger when including the previously proposed halo. This is raw data, excluding statements, proofs, and indices. It represents roughly 4.3 billion 64-bit windows.

Prove each view's relation to the prime table once. Later coverage proofs can refer directly to a certified, correctly indexed window. This can remove repeated two-word alignment arithmetic and its bit-operation proofs. Reuse is particularly promising for explicit PA arithmetic, where those proofs may be much more expensive than reading the result. It is a sound candidate and should be benchmarked.

It does **not** remove all per-mask work. The selected anchor and target position must still imply the correct source index; the cited window must have prime provenance; and the union/all-covered calculation remains. A precomputed integer without its certified indexing relation saves native computation but not those proof obligations.

A monolithic theorem for every window is unlikely to be the right physical representation. Besides large metadata, roughly 2^32 windows already press against the current verifier's 32-bit theorem addressing; the halo exceeds that count, and the first-4GB theorem-data restriction is tighter still. Use a redesigned indexed certificate store or soundly composed shards, or prove structured shifted chunks and amortize their extraction. The limits are current-format engineering constraints, not mathematical obstacles. [Current verifier limits](https://raw.githubusercontent.com/digama0/mm0/master/mm0-c/README.md).

The correct revised cost model is

    one-time view certification
      + uses * (indexed-reference proof + anchor/index arithmetic + union proof),

not `uses * (slice proof + union proof)`, provided the implementation actually realizes cheap certified references. End-to-end measurements must include bringing the pre-certified facts into each independent shard. Reproving the whole view table in every shard could forfeit the benefit.

## 10. Sixteen-bit arithmetic tables

Replacing 8-bit binary-operation facts with 16-bit facts changes the full table from 2^16 to 2^32 entries, a factor of 65,536. A 16-bit result for each implicitly indexed input pair already occupies 8.59 GB per operation; storing both 16-bit inputs and the result would occupy 25.77 GB before formal metadata. OR and AND tables together double the output-only figure. These are exact cardinality/storage calculations, not estimates of formal proof size.

A 64-bit operation then needs four digit facts rather than eight, so it can roughly halve the **digit-fact component** of its proof, if lookup and composition remain equally cheap. It cannot generally halve total coverage time: source-index arithmetic, prime provenance, proof dispatch, joins, output bytes, and final checks remain. Formally, if fraction f of the old cost is halved, the total speedup is only `1/(1-f/2)`.

At Goldbach scale, even a costly one-time table may amortize, but a four-billion-entry formal table needs a credible indexed representation and caching strategy. Sparse on-demand memoization is another sound option; whether it touches most input pairs depends on actual prime-mask and accumulated-union distributions. Those distributions are not uniform random pairs and should be measured. An intermediate 12-bit table has 2^24 entries and six chunks per 64-bit word, making it a useful additional engineering point.

These alternatives strengthen the case for an optimized-MM0 benchmark instead of treating a particular eight-bit/64-bit cost model as a lower bound. They do not establish a new numerical forecast until table construction, certified access, reuse, and the remaining proof costs have been measured.

## 11. Sharding, bounded memory, and final assembly

An estimate for roughly 10^12 coverage chunks and 465,661,288 anchor blocks must not assume a stock invocation retains all their declarations. There are three different products: a one-shot Lean compilation, a collection of independently checked local results, and a **closed, verified proof DAG** connecting those results to the final theorem. Only the third provides the proposed scalable end-to-end certificate; the second needs checked composition, and the first has not been demonstrated at this scale.

### Hierarchical proof interface

Keep individual coverage chunks internal to a bounded block proof. Export a theorem giving Goldbach for every even integer in a precise interval, rather than a global declaration for every mask operation. The block checker must still validate all internal arithmetic, prime provenance, and coverage. Packaging those obligations under one statement does not erase them.

Combine adjacent interval theorems with a fixed, proved composition rule. Half-open index intervals `[a,b)` for the sequence of even targets make endpoint checks straightforward; the root translates back to the required inclusive numerical range and includes 4. Every parent records exact child intervals, proves no gap, and exports only its larger interval statement. Overlap is harmless when intentional, but should not substitute for checking completeness.

For illustration, grouping 465,661,288 anchor-block theorems with fan-in 1024 produces levels of 454,748, 445, and 1 aggregate theorems. This bounds the interface at an individual aggregation step; it does not make the whole proof consist of 445 checks. Total assembly still consumes every leaf result and all internal edges, so it is at least linear in this chosen DAG's size unless further mathematical regularity is proved.

### What a once-checked shard must bind

A shard record must identify its exact theorem statement, all definitions giving that statement meaning, its proof/certificate bytes, and its full dependency list. It must also bind the logic/axioms and relevant checker version/configuration. The global validation pass checks dependencies in a well-founded order, checks each proof against precisely the imported statements, rejects missing dependencies or cycles, and checks the root against the frozen Goldbach target. Reused prime tables and arithmetic libraries are checked once under the same rule.

Content hashes are useful identifiers and integrity checks, not mathematical proofs of shard conclusions. The trusted composition mechanism must ensure that an imported conclusion really refers to the previously checked object with those definitions and dependencies. Treating manifests, worker success messages, or an arbitrary imported axiom as the proof would leave the argument open. For an exact mathematical model, the object-identification mechanism is injective references or exact object equality; practical hash-based storage additionally needs its normal integrity/trust assumptions stated.

This can be implemented as a bounded-memory external checker or as a carefully managed proof-DAG layer using a kernel to validate individual nodes. Such a layer can preserve the original axioms, as discussed in section 8, but its dependency handling and composition are part of the verification implementation. It is not automatically supplied by parallel jobs or stock module imports. A node may discard an already checked proof body when it retains a sound reference to the verified conclusion; re-importing arbitrary unchecked summaries is different.

Lean's validation documentation distinguishes checking a declaration relative to imports from replaying stored proofs through the kernel. It describes `lean4checker --fresh` and external export/rechecking, but does not establish bounded-memory trillion-node distributed operation. [Lean proof-validation documentation](https://lean-lang.org/doc/reference/latest/ValidatingProofs/). Likewise, overcoming the current MMB size/address limits requires an explicit shard or format design, not a claim that one stock file contains everything.

### Costs still missing from the forecast

Even 100 bytes of metadata per anchor block would be about 46.6 GB; per 10^12 local chunks it would be 100 TB. Keeping chunk-level records internal to block proofs avoids that particular global index, while the local proof/certificate data still have to be consumed. The live set also includes arithmetic literals, prime facts, cached source chunks, and data required by the current dependency frontier.

Per-anchor-block administrative overhead of 1 millisecond totals about 5.4 core-days; 1 second totals about 14.8 core-years. At 10^12 chunks, a 1-millisecond per-chunk overhead alone totals about 31.7 core-years. These are accounting examples, not measured overheads. They show why launching a process or writing a separate file for every arithmetic chunk is not a neutral implementation choice.

Still unpriced are peak live proof memory, import and literal decoding, manifest validation, reuse across worker boundaries, serialization, temporary storage, final composition arithmetic, and failure/retry behavior. A forecast should expose these as additional terms rather than absorb them into an unmeasured parallel-efficiency constant. Benchmark a complete leaf-plus-parent pipeline and its memory growth before claiming that local checking times extrapolate to a closed global proof.

No impossibility is asserted: hierarchical proof packaging and verified DAG checking are plausible engineering routes. The defensible distinction is between a measured local arithmetic kernel and an as-yet-unmeasured scalable proof assembly system.

## 12. Expanded proof bytes are not mandatory I/O

The earlier sparse forecast charged roughly 188 EB of expanded coverage proof output at an assumed emission rate of 500 MB/s. **That charge belongs to a particular serialized-proof pipeline; it is not a lower bound for an optimized MM0 implementation.** It must not be carried into an all-optimized forecast without specifying that pipeline.

A compact certificate can name proof templates and their concrete parameters. An untrusted expander can generate the corresponding ordinary proof steps just as the checker needs them. The checker still validates each step against the current proof state. Expansion can stream through a small buffer, or a fused producer/checker interface can pass decoded operations directly, avoiding materialization and possibly encoding/decoding of the full expanded byte stream. These optimizations need no new logical inference rule. Their implementation must preserve the checker's validation path; a producer may propose steps but may not install unchecked proof facts.

This is distinct from the arithmetic accelerator in section 8: template expansion still performs the underlying ordinary proof checks, while an accelerator may validate a derived arithmetic operation directly. A stock binary-file-only verifier may require adaptation to consume the stream or decoded interface, but changing that interface is not itself an extension of PA's axioms.

The costs that remain are reading the compact inputs, template selection and parameter substitution, constructing any necessary literals/terms, proof-step dispatch, unification and other checks, and their actual memory traffic. Compact input generation and storage also remain. Fusing these stages may overlap work or remove repeated copies, so adding an independently modeled emitter time to checker time can double-count shared operations.

Use measured end-to-end fused throughput when available. Until then, report serialized emission as one scenario and streamed/fused checking as another, with explicit template-expansion overhead. Do not price unavoidable work as `expanded bytes / assumed write bandwidth`, and do not replace that mistake with a claim that expansion is free. Reproducible checking requires retaining the compact certificate and a specified expander, or another sufficient reproducible source of the checked steps; it does not require archiving the expanded 188 EB stream.

## 13. Audited packed-convolution coverage test

The following exact arithmetic construction is a stronger candidate than the unspecified coefficient-positivity method in section 4. It replaces a list of shifted unions by a multiplication, an addition, a bitwise AND, and an equality check. It is mathematically sound; comparative performance is being measured separately.

### Statement and proof

Let W>0 be the number of target positions. Let P_j belong to {0,1}, with a proved prime interpretation for every set source bit. Extend P_j by zero outside its finite domain. Let s_1,...,s_m be nonnegative anchor offsets, each having the required certified-prime interpretation, and choose S>=max_i s_i. Repeated offsets are permitted, provided m counts multiplicity. Choose B=2^k with h=B/2>m.

Define

    P' = sum_(j=0)^(S+W−1) P_j B^j,
    A  = sum_(i=1)^m B^(S−s_i),
    Z  = P' A.

The coefficient of B^(S+t) in this product is

    c_t = sum_(i=1)^m P_(s_i+t),          0<=t<W.

Every coefficient of the whole polynomial product, including positions outside the target window, is between 0 and m. Thus every coefficient is strictly below h, in particular below B, and multiplication creates no interdigit carries. Ordinary base-B digits of Z are precisely the polynomial coefficients. A target is covered exactly when its c_t is positive.

Set

    Hs = sum_(t=0)^(W−1) h B^(S+t),
    Ks = sum_(t=0)^(W−1) (h−1) B^(S+t).

Then the entire coverage condition is exactly

    ((Z + Ks) AND Hs) = Hs.

Indeed, addition changes a target digit to c_t+h−1, which lies between h−1 and B−2. Its high bit is set exactly when c_t>=1. No addition carry reaches another digit. Outside the target positions, digits remain at most m<h; therefore lower and higher unused product digits cannot corrupt the test. Hs selects exactly the high bits at the W target positions.

This direct form needs no product slicing, division, or modular reduction. The originally proposed extracted form is equivalent: if C is the W target digits of Z, H repeats digit h, and L repeats digit 1, then `(((C OR H)−L) AND H)=H`. Since C has all selected high bits zero, one may instead test `(C+(H−L)) AND H=H`. The direct shifted masks above remove extraction too.

The original OR/subtract formulation needs the strict bound m<h. For example, m=512 then requires k>=11, not k=10: at k=10, a count of 512 is already the high bit and OR/subtract incorrectly reports it uncovered. **The direct ADD formulation improves this to m<=h.** Under this relaxed assumption every product digit is still below B, and c_t+h−1<=B−1, so there are still no carries and the same high-bit equivalence holds. Thus the direct test safely uses k=10 for 512 anchors. All index bounds, prime interpretations, and the power-of-two radix must be included in the formal theorem, not supplied by the native generator alone.

### Reuse and input size

The dilation from binary source bits to base-B digits must be certified once; an arbitrary expanded integer is not a prime table. Use a fixed radix determined by a bound on anchor-pool size if global reuse is desired. The source table is independent of the large outer block, and its expanded local slices can be reused across blocks. Taking S as a common upper bound on all anchor offsets, rather than each block's exact maximum, makes the source slices and Hs/Ks reusable for fixed W and local target position.

The anchor polynomial is specific to an outer block. Its sparse exponents must be linked to that block's certified anchor primes. It can be constructed and certified once per anchor block, then reused for every local coverage window in the block. This does not require certifying a different anchor polynomial for each local mask word. Deriving it from a compact offset list also avoids storing a dense polynomial literal separately for every block, provided the checker efficiently reuses the constructed value and its proof.

For a local window starting at target index t0, use source bits P_(t0+j), with 0<=j<S+W. The arithmetic above then counts P_(t0+s_i+t). Thus the local source polynomial has roughly k(S+W) bits and the product can have roughly k(2S+W) bits. Its multiplication cost depends on the offset span S, not just W. A large, sparse A is not automatically cheap for a dense big-integer multiplication primitive.

With the older anchor search interval of width 2^20 integers, odd-prime indexing gives an offset span around 2^19, subject to the exact origin convention. At k=11 this span alone is several million bits. Those are realistic benchmark operand sizes. Expanding the entire approximately 2^32-bit shared table would multiply its raw storage by k and exceed Lean's current default numeral-size limit, so certified local chunks remain necessary.

The mathematical operation count per local window becomes one multiplication plus linear-size addition/AND/comparison, but arithmetic bit complexity is approximately `Mul(k(S+W))` plus linear work, not O(1). Source-slice construction, anchor-polynomial certification, literal handling, and reuse are separate costs. Increasing W can amortize the span S; the optimal W is a new measurement question.

### Consequences for MM0

The same theorem is valid over PA; its mathematics does not privilege Lean. It may substantially reduce the number of high-level covering operations. With the current explicit PA checker, however, the actual large multiplication and bitwise result still need arithmetic proofs. Charging one ordinary MM0 event for that multiplication would be unsound accounting. Fast proved multiplication algorithms, arithmetic certificates, or the verified accelerator of section 8 could make this route competitive, but their concrete cost is not established here.

Lean's present kernel has direct big-integer arithmetic and bitwise reductions, making it an immediate candidate for this construction. A successful arithmetic microbenchmark is still not a complete Goldbach proof: source dilation, prime soundness, anchor offsets, all endpoint cases, and hierarchical assembly remain required.

## 14. Interpreting the measured packed-kernel comparison

The coordinating benchmark reports the following actual-fixture stage timings at W=262,144: 3.015 ms for native FLINT packed arithmetic and 3.400 ms for strict Lean kernel checking. Applying those rates to 2e18 target evens gives approximately 729 and 822 core-years respectively. This is a uniform extrapolation of that measured stage, not a completed end-to-end run. Their ratio is about 1.128; where the arithmetic libraries or execution paths differ, it is not a clean measurement of kernel overhead alone.

For the user's broad interpretation of **most efficient implementations**, these measurements support a conditional **order-of-1,000-core-years forecast for the packed coverage stage of an arithmetic-accelerated, PA-preserving MM0 verifier**, as well as that order for Lean. It is reasonable to use the native arithmetic measurement as the engineering target if the new verifier performs essentially the same big-integer operations with modest additional overhead. It is not reasonable to treat that target as already achieved or independently benchmarked in a verified MM0 implementation.

The conditions are substantive: arithmetic instructions must preserve derivability from the chosen PA axioms; the implemented checker must conform to their proved meaning; the compact certificate must bind the exact inputs, prime evidence, and final target; and the distributed proof dependencies must compose soundly. Such a design need not emit or expand ordinary MMB arithmetic proofs. It changes the verification implementation and possibly the proof format, while it can leave the mathematical axioms unchanged.

A verified compiler plus an observed native computation does not, by itself, produce a stock MMB proof of this instance. The proposed alternative instead accepts the native arithmetic operations as part of a justified proof-checking implementation, analogous in purpose to an existing arithmetic kernel. Its correctness construction and concrete performance are not supplied by the timing experiment.

Consequently, report three separate interpretations:

| Interpretation | What the current evidence supports |
|---|---|
| Strict Lean kernel, packed arithmetic | Measured local checking rate; approximately 822 core-years for coverage-stage extrapolation |
| Present explicit MMB/PA arithmetic proofs | A much larger architecture-dependent estimate; current 10,000–25,000-core-year figures are not lower bounds on all MM0 implementations |
| PA-preserving arithmetic-accelerated MM0 checker | Conditional coverage target of the same order as the measured native packed arithmetic, around 1,000 core-years; verified implementation not built or timed |

No row yet supplies the full-project total. Prime certificates, expanded-source certification and access, per-block anchor-polynomial construction, compact-certificate parsing, proof/certificate production, assembly, and memory/I/O costs must be added unless explicitly included in the measured stage. A total near 1,000 core-years is conditional on those remaining costs fitting within that order; the data above alone do not establish it. Development and correctness-proof effort are separate from compute time.
