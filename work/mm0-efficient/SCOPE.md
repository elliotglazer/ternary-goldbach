# Efficient MM0 verification of binary Goldbach through 4 × 10^18

Research scope, 2026-11-10 Pacific. This document proposes tooling and gives conditional resource estimates. The measured programs are native prototypes, not completed MM0 proofs. The objective here is a defensible project design, not a claim that the finite Goldbach theorem has now been formally verified.

## Recommendation

Build a specialized native certificate checker, justify its rules by PA derivations checked with MM0, and ultimately prove that the exact executable implements those rules. Use compact prime certificates and bulk bitset coverage. Do not require an explicit MMB arithmetic derivation for every word operation in the production run.

This is a new verification backend with an MM0-checked correctness argument. Its production artifact is not an ordinary `.mmb` file accepted by an unchanged `mm0-c`. Retain ordinary MMB expansion for small reference cases. If unchanged `mm0-c` acceptance is a mandatory deliverable, that is a different, potentially much more expensive project.

The opportunity is substantial: native coverage prototypes have reached sub-nanosecond times per even target on actual sampled prime data. At this scale, one nanosecond per even target costs about 63.38 core-years. A reasonable conditional engineering target is roughly **100 core-years per complete independent verification**, with a **50–300 core-year planning envelope**. This is an extrapolation with allowance for integration, not a measured complete run or a confidence interval. The proposed implementation and its formal correctness proof still need to be built.

No claim of mathematical optimality is possible. A new number-theoretic theorem or better certificate scheme could change the computation entirely. This design is a concrete way to exploit known bulk computation without paying for an explicit proof record of every arithmetic step.

## 1. Exact result and acceptance boundary

Freeze the PA presentation, conservative definitions, and the exact target syntax:

```text
For every natural number n, if 4 <= n <= 4000000000000000000
and n is even, there exist primes p and q with n = p + q.
```

There are exactly 1,999,999,999,999,999,999 even targets. This task concerns the finite binary result. It does not by itself remove PlattGRH from the separate analytic ternary-Goldbach argument.

The abstract certificate checker A must satisfy a syntactic proof-preservation theorem:

```text
A(spec, certificate) = accept
    -> Prf_PA(Expand(spec, certificate), ExactTarget(spec)).
```

`Expand` may produce an enormous ordinary derivation. Prove its validity and termination; production does not have to materialize it. This establishes admissibility of the accelerated checking rules. It is not a global reflection principle saying that PA proves its own soundness. Nor does an internal assertion that a PA proof exists automatically become an internal PA proof of its conclusion.

For the strongest deliverable, also prove a theorem about the exact deployed binary:

```text
Initial(exact_binary, exact_inputs) and SuccessfulExecution
    -> A(spec, certificate) = accept.
```

The original MM0 checker verifies this reusable correctness argument once. An independent consumer then runs the justified specialized checker on the compact certificate. The result establishes PA derivability at this verification boundary; a consumer demanding an ordinary MMB proof must instead obtain the expansion or another ordinary derivation.

An interim implementation may have proved mathematical rules and a source-audited native kernel, with the native kernel trusted like an ordinary prover implementation. Clearly distinguish that from the final executable-refinement deliverable. A theorem about an algorithm does not certify arbitrary C code, compiler output, or claimed run logs.

See [soundness.md](soundness.md) for the detailed contract, theory-binding requirements, and remaining machine/environment assumptions.

## 2. Mathematical certificate and checker pipeline

The producer searches for convenient primes and factors without being trusted. The checker deterministically verifies every mathematical fact it uses.

1. **Establish a shared small-prime bitmap.** A proved segmented sieve establishes that every set bit denotes a prime. The proof must show surviving marked numbers are prime, including completeness of the required divisor search. Merely proving cleared bits composite is insufficient. Clear 1 explicitly and handle 2 separately.
2. **Check large prime anchors.** Use partial Pocklington certificates, sharing already certified small factors. Require the factored divisor F of q−1 to satisfy F² > q, with the precise modular and gcd conditions of the selected theorem. Check factor products, exponents, acyclic references, and every modular operation. Probable-prime tests may help the producer but are never accepted as certificates.
3. **Check coverage in bulk.** Each anchor translates the source prime bitmap into possible Goldbach decompositions. OR the translated masks. Use dense word loops initially, then visit only unfinished words. A word leaves the active list only after all its required bits are covered.
4. **Resolve exceptions.** An initial budget of 512 anchors is an engineering choice, not a theorem. If it leaves holes, provide more certified anchors or explicit certified decompositions for those targets. Failure to find a certificate causes rejection or continued search, never acceptance.
5. **Assemble the exact range.** A proved interval or two-dimensional schedule establishes that every required target was checked, including the base interval and inclusive final endpoint.

No per-mask trace needs to be serialized. The checker recomputes the inexpensive coverage operations from compact anchors and shared prime data.

### Exact indexing

Write E = N/2. Let L be the number of even targets in a full outer block. First verify the initial interval 4 <= n < 2L. For r = 1,...,floor(E/L), use

```text
w_r = min(L, E - rL + 1)
n(r,t) = 2(rL+t),                 0 <= t < w_r
q(r,i) = 2rL - (2s(r,i)+1),       0 <= s(r,i) <= D, q(r,i) >= 3
p(t,i) = 2(t+s(r,i))+1.
```

Then n(r,t) = q(r,i) + p(t,i). The source bitmap needs indices 0 <= j < L+D, representing odd numbers through **2L+2D−1**. For a target tile [a,b), retain source indices [a,b+D). This halo is part of the proof and the memory accounting.

If E is divisible by L, the last outer block has width one. Dropping it would omit N. Verify the initial interval recursively with smaller blocks or directly at a small base size. An anchor offset bound that fails for a block must be enlarged with corresponding checked source bounds, or handled through the exception route.

### Compact input format

Use a versioned bounded parser with the exact target and parameters. Encode block indices, anchor offsets, backward references to prime certificates, factor/exponent data, modular witnesses, and any exceptional decompositions. Bind certificates to the actual mathematical target and immutable source data. Internal fact handles are created only by the checker, never accepted from the producer.

The checker should generate the shared source bitmap itself. An external bitmap is acceptable only if its prime interpretation is independently verified. Checksums help transport and caching; they do not prove primality, interval coverage, or mathematical equality of unchecked objects.

## 3. Memory, storage, and scheduling

Start with L = 2^32 and D = 2^19. The shared odd-number bitmap occupies about 512 MiB plus a small halo. At 512 anchors per block, the top level has 465,661,287 outer blocks and approximately 238.42 billion anchor entries. The count is large but each anchor serves billions of targets.

Keep the bitmap resident per node. Batch several outer blocks, validate their anchors once, and process the source in cache-sized tiles against those blocks. Reuse the same source tile while it is hot. For example, 64 blocks × 512 four-byte offsets occupy 128 KiB before associated state. Actual batch size must be benchmarked against the processor cache and coverage buffers.

Give each worker a contiguous batch of outer blocks. It completes all source tiles for that batch before advancing its checked range. This avoids repeatedly parsing the entire anchor dataset for each source tile. A single trusted checker may manage parallel workers internally. Results from external untrusted workers must be rechecked from their certificates; signed success messages are not proof objects.

Larger outer blocks substantially shrink the anchor artifact. They increase the source range, reduce prime density, and may require streaming. The following values are top-level planning arithmetic using the measured 75.10 bytes per root for cached Pocklington, plus a conservative eight bytes per anchor offset. They exclude framing, exceptional witnesses, bootstrap proofs, replicas, and the initial interval. Decimal TB is used for artifacts and binary GiB for memory.

| L | Resident source bitmap | Anchor artifact estimate | Anchor preparation at assumed 0.2 ms each |
|---|---:|---:|---:|
| 2^28 | 0.0313 GiB | 317 TB | 24.2 core-years |
| 2^32 | 0.5001 GiB | 19.8 TB | 1.51 core-years |
| 2^36 | 8.0001 GiB | 1.24 TB | 0.094 core-years |
| 2^40 | 128 GiB | 77.4 GB | 0.0059 core-years |
| 2^44 | 2 TiB | 4.84 GB | 0.00037 core-years |
| 2^48 | 32 TiB | 302 MB | 0.000023 core-years |
| 2^50 | 128 TiB | 75.6 MB | 0.0000058 core-years |

The preparation column illustrates how anchor work scales. It is not a complete producer forecast: the sample timing does not establish global prime-search, factorization, coverage-search, or exception costs. Likewise the sampled certificate size is not a guarantee for other block sizes and anchor-selection strategies.

For very large L, stream the source with a retained halo. At L = 2^50, there are only 1,776 outer blocks and 909,312 planned anchors. A source-segment-major schedule can reuse each sieved segment across all blocks, with a proved lexicographic two-counter coverage invariant. This avoids a resident 128 TiB bitmap. It does not avoid sieving that source range, repeated anchor traversal, or checking the initial interval. The base-prime sieve reaches about 47.5 million in this example.

The anchor-primality cache must remain available in a streamed design. A discarded source segment cannot later serve as an unchecked prime lookup. Keep a modest separately certified factor cache, give explicit certificates for other factors, or certify the needed factors during a first source pass and cover in a second. Price that extra pass or retained state. The small artifact estimates alone do not solve this dependency.

Choose between resident-source block-major batching and streamed-source segment-major batching by measuring total sieve, memory, certificate, and coverage costs. Avoid a layout that re-sieves the entire source for every outer block or rereads tens of terabytes of anchors for every small source tile. The largest L is not automatically the CPU optimum. **2^32 and 2^36 are sensible first complete-prototype candidates; large streamed L is a storage-focused alternative to test.**

## 4. Measured evidence and conditional cost model

The hardware used for these prototypes is an AMD Ryzen 9 8945HS. Measurements are single-process native experiments, not measurements of a completed formal checker, a production cluster, or a historical Goldbach implementation.

- The initial actual-prime coverage fixture contains 96 cases over 65,536, 262,144, and 1,048,576 target bits. Loaded dense-to-active checking measured roughly 0.43–0.48 ns per even target; one warm parse-and-check configuration measured about 0.70 ns. These operations include source-index identities, bounded shifts, mask unions, and coverage checks. They exclude proving or checking primality of the fixture data.
- Additional actual source windows near 2^40, 2^48, and 2^52 tested the lower prime density of large-block designs. A 1,048,576-bit hybrid configuration averaged about 0.54 ns per even over six anchor pools. The tested pools required prefixes of 278–406 anchors. Sample coverage does not imply all future blocks fit within 512 anchors.
- The final large-working-set native run used actual source bitmaps of roughly 8 MiB and 32 MiB. Cache tiling improved loaded checking to **0.291 and 0.310 ns/even**, compared with the best untiled hybrid at 0.726 and 1.126. Warm reading, parsing, allocation, and checking of the whole 84.2 MB fixture file measured **0.340 ns/even**. All 40 positive and 44 negative controls passed. These are overlapping sampled cases; the throughput is not an independently verified full-range rate. This result makes cache tiling a first-class design requirement.
- The matching build with compiler loop vectorization disabled measured **1.038 and 1.150 ns/even** at the same sizes. Its best warm parse-and-check rate was **1.476 ns/even**, or about **93.5 coverage core-years** if sustained globally. It also passed 40 positive and 44 negative controls. The optimized native build was 3.71 times faster on the 32 MiB loaded case and 4.35 times faster for warm parsing plus coverage. Platform memory-library routines remain outside the claim that the coverage loops are scalar. This gives a viable scalar-first baseline while quantifying the potential reward from a later SIMD proof.
- Native cached partial Pocklington validation measured approximately 1.672 microseconds per anchor in the final run, with about 75.10 bytes per distinct root on a 4,055-root sample. The validator includes binary parsing and backward-reference checks. The shared small-prime cache is established separately. At the 2^32 block count this is about **0.0126 core-years**, far below coverage cost.
- Smooth-only anchor certificates reduced the sample to about 49.63 bytes and 1.163 microseconds per root, but only 38.8% of sampled roots qualified. Screening more candidates can cost more than it saves. Cached partial Pocklington is the baseline; smooth-only selection is an experiment, not a free optimization. Supplying inverse witnesses instead of computing gcds measured 1.323 microseconds and 94.49 bytes per ordinary cached root, another optional speed/size tradeoff.

Detailed final coverage and scalar/large-working-set measurements belong in [native/REPORT.md](native/REPORT.md); final primality measurements and reference checks belong in [primality.md](primality.md). Initial numbers above identify the evidence supporting the design and must not be substituted for end-to-end acceptance timing.

For E−1 even targets, the coverage-only conversion is

```text
core-years = (E−1) × seconds_per_even / 31,557,600.
```

| Sustained checking cost | Coverage core-years |
|---|---:|
| 0.31 ns/even | 19.6 |
| 0.34 ns/even | 21.5 |
| 0.43 ns/even | 27.3 |
| 0.70 ns/even | 44.4 |
| 1.0 ns/even | 63.4 |
| 1.6 ns/even | 101.4 |
| 2.0 ns/even | 126.8 |
| 5.0 ns/even | 316.9 |

The **100 core-year central planning value, with a 50–300 envelope**, assumes the formally justified implementation can sustain approximately 0.8–4.7 ns per target after integration, with bootstrap/prime costs small by comparison. It leaves several-fold room over the sampled vectorized loops. The scalar warm benchmark already projects to 93.5 years before the missing work, so a complete scalar-only implementation could readily exceed the central value. The estimate is conditional on safe parser and arithmetic code, effective cache tiling, a manageable exception rate, and amortized sieve/anchor verification. It is not established by a throughput microbenchmark. **Build and prove the scalar path first; add SIMD when its approximately fourfold measured benefit justifies the extra implementation proof.** The 50-year end of the envelope relies on retaining much of the vectorized performance.

The full cost model is

```text
T_verify = T_source_sieve_and_bootstrap
         + T_anchor_certificate_checks
         + T_bulk_coverage
         + T_exceptions_and_range_assembly
         + T_input_and_scheduling.

T_project_run = T_certificate_production + T_verify.
```

Do not silently count certificate production as free or include its search time in an independent consumer's verification benchmark. No complete producer has been benchmarked. A producer can feed anchors and exceptions to a live trusted checking loop, retaining its verified coverage state as more witnesses arrive; the producer itself remains untrusted. This avoids mandating two full passes merely to obtain the first accepted artifact. An independent replay still does the full checking work. If production separately tests full coverage before one final replay, budget another verification-sized pass; further searches may cost more. Roughly **100–600 core-years for that two-pass scenario** is illustrative, not an independently calibrated estimate. Retrying selection, cold I/O, replicated checking, or a disappointing final implementation can exceed it.

At 1,000 allocated worker cores with 70% utilization, 100 core-years is about 52 days; at 10,000 it is about 5.2 days. The utilization and scaling are assumptions. Memory bandwidth, shared-source reuse, certificate delivery, and the trusted parallel-composition mechanism must be tested before scheduling a full run.

[resource_model.py](resource_model.py) regenerates [resource_model.json](resource_model.json), including exact counts, byte estimates, and timing sensitivities. The models contain no hidden conversion from the historical 770-core-year computation and no claim that earlier explicit-MMB estimates are lower bounds.

## 5. Tooling to build and proof obligations

| Work package | Required result | Dependencies |
|---|---|---|
| Frozen specification and reference checker | Exact PA target, conservative syntax/definitions, bounded certificate grammar, tiny complete ordinary-MMB examples | First; independently audited |
| Arithmetic and prime certificates | PA Pocklington theorem, shared-factor cache invariant, correct modular multiplication/exponentiation, factor-product and gcd checks | Specification |
| Bitmap and sieve | Sound positive prime flags, finite-bitset interpretation, sieve bounds and halo correctness | Arithmetic interfaces |
| Coverage and assembly | Dense/active loop invariants, exact anchor identities, partial-word masks, exceptions, full range/base recursion | Stable bitmap/prime contracts |
| Global proof preservation | Check implies validity of the expanded PA derivation; totality of Expand; registry and composition invariants connecting all local rules | Local rules and frozen checker semantics |
| Native scalar checker | Small bounded parser, immutable verified data, overflow-safe loops, exact reference agreement | Can develop alongside proofs |
| Exact-binary refinement | Ordinary MM0 proof that the specific executable implements the abstract checker, including decoding and success output | Stable scalar implementation and machine semantics |
| Performance and operations | Cache tiling, safe parallel composition, bounded memory, replayable checkpoints, reproducible artifacts and full cost accounting | Complete scalar path first |
| Optional SIMD backend | Semantics and refinement proof for the vector instructions actually emitted; measured benefit | Scalar baseline and measured bottleneck |

The principal proof risk is the connection between optimized native execution and the PA-admissible checker, not the algebraic identity p+q=n. C undefined behavior, overflow, aliasing, decoding, and cross-word shifts all matter. Use 64-bit data with explicitly justified 128-bit products or a two-limb equivalent. An input q < 2^62 does not make q² fit in 64 bits.

The pinned upstream MM0 toolchain supplies useful PA arithmetic, MM1 authoring, a small bootstrap verifier, and scalar x86/ELF definitions. It does **not** supply a finished verified compiler/checker chain to import unchanged. Its `compiler.mm0` includes an unrestricted `sorry` axiom; the verifier representation invariant is unfinished; compiler proof code has unimplemented branches. No SIMD/AVX model was found in the inspected x86 specification. Exact sources and dependency cautions are documented in [toolchain.md](toolchain.md).

Do not make completion of every upstream compiler feature a prerequisite. A restricted proof-producing compiler subset, direct proof of a small scalar executable, or per-binary translation validation can target only this checker. Whichever route is chosen, the final proof closure must exclude unfinished upstream assumptions. Avoid general arbitrary-precision dependencies in the trusted runtime unless their implementation proof is worth the cost.

## 6. Engineering budget, parallel work, and decision gates

The following are engineering judgments for experienced formal-methods and systems staff, not measured schedules. They exclude the full computation, cluster procurement, and mathematical discoveries.

- **7–16 person-months** for an audited native checker with machine-checked PA-admissible mathematical rules, global proof preservation and expansion totality, reference expansion, prime/coverage integration, and production testing. The low end assumes a narrow scalar implementation and successful reuse; proof-preservation infrastructure can push work above this range.
- **An additional 8–24 person-months** for the exact-executable refinement track: **15–40 person-months total**, with substantial overrun risk from machine semantics and incomplete compiler infrastructure.
- SIMD proof work is contingent scope. A scalar backend that costs somewhat more CPU may be the better total-project choice if it avoids months of instruction-model work. Scalar correctness infrastructure is reusable even if SIMD is later added.

Arithmetic/primality, sieve/coverage mathematics, native implementation/measurement, and independent specification/audit work can proceed in parallel once interfaces stabilize. Binary refinement depends on a reasonably stable implementation and is the likely critical path. Assigning eight people does not divide the schedule by eight. Integration, global interval invariants, and final axiom closure require shared review.

| Gate | Evidence required to advance |
|---|---|
| Initial 2–4 week feasibility gate | Audited exact PA target; tiny genuine-prime block with complete ordinary proof; demonstrated admissible expansion interface; no schematic arithmetic axioms |
| Complete scalar pilot | Full source provenance, prime checks, coverage, base case, final endpoint, and rejection path in one run; performance measured including parsing and assembly |
| Architecture selection | Compare 2^32/2^36 resident-source and at least one streamed alternative; record total CPU, peak memory, artifact bytes, producer work, and scalar/SIMD benefit |
| Formal acceptance | Bootstrap MM0 checks all mathematical and exact-binary proofs against an explicit axiom whitelist; prove conservative elimination of any imported syntax/coercion axioms such as peano_hex, or avoid them; independently audit target identity and executable binding |
| Production rehearsal | Sustained multicore runs with cold/warm I/O, checkpoints, exception cases, corrupted inputs, and exact partition checks; resource forecast recalibrated |
| Full computation | Entire inclusive range covered; reproducible compact artifact retained; independent complete replay under the final acceptance contract |

The feasibility gate is intended to discover blockers, not to promise all these proof components within a few weeks. Stop throughput optimization if the tiny ordinary proof or the claimed admissibility interface cannot be made honest.

Required adversarial cases include false positive source-prime bits; composite anchors; bad factors and modular witnesses; forward/cyclic certificate references; missing or extra input; integer/length overflow; shifts by 0, 63, and 64; a single uncovered target; mismatched source/target offsets; mutation of verified buffers; duplicate or omitted intervals; incorrect base range; the divisible-L final endpoint; and worker output for the wrong range. For exact executable verification, changed binary bytes must invalidate the binding. Testing supports implementation review but does not replace any formal proof obligation.

## 7. Deliverables and present status

The scoped final deliverables are: the exact PA specification; ordinary MM0 correctness proofs; a proved specialized executable; an untrusted certificate producer; the compact full-range certificate; a reproducible verifier invocation; and an independently replayable result. A separate optional deliverable is full ordinary-MMB expansion.

Present evidence supports the architecture, its acceptance contract, and the possibility of large speedups over explicit arithmetic proof streams. It includes actual native prime/coverage experiments and a transparent resource model. **The PA rule proofs, exact-executable proof, integrated producer/checker, and full-range computation are future project work.** The efficient-checker target preserves the mathematical standard while changing the proof format and verification implementation; it must never be represented as a completed stock-MM0 Goldbach proof.
