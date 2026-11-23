# Goldbach through 4 × 10^18: measured forecast

Research and experiments, 2026-11-10 Pacific / 2026-11-11 UTC. The target is every even integer from 4 through 4 × 10^18, with a proof whose mathematical dependencies use only the chosen standard foundations. This document forecasts future proof production and checking; it does not claim to have constructed that proof.

## Forecast and its scope

My revised planning estimates are **about 2,000 physical-core-years for Lean**, and **about 20,000 for the current MM0 explicit-proof architecture**. These totals include construction and checking after the required infrastructure has been developed. They exclude research/development time. Broad sensitivity envelopes are roughly **1,000–10,000** and **5,000–100,000 core-years**, respectively. These envelopes are engineering judgments, not confidence intervals or proven upper bounds.

The user's strongest optimization premise also permits proved-admissible arithmetic accelerators, with verified acceptance paths preserving the foundations. Under that interpretation **both systems must be allowed such changes**. The native measurements support substantially cheaper coverage candidates: about 729 core-years for packed arithmetic, or about 147 for native shift/OR on the same fixture. These are arithmetic-stage projections, not complete checker forecasts. A total in the low thousands is a conditional engineering scenario, but the full accelerated acceptance path was not built or measured here. An accelerated MM0 would not be an ordinary MMB proof checked by the present verifier. Consequently there is no measured basis for a universal “MM0 is 2–3 times faster” ratio, or for treating the current-checker estimates as optimality bounds.

The earlier 50,000-versus-120,000 estimates should not be reused. The earlier 2,500-year Lean guess was also unsupported; proximity to a revised estimate would be coincidence, not validation of its original reasoning.

## Evidence collected

All experiments ran on the same AMD Ryzen 9 8945HS host. Lean used the installed Windows x64 release 4.35.0, commit `eb6cafb7290e8bd5f2937522d8d804f58f02bafc`. The MM0 C checker was compiled from pinned source and ran under Linux in WSL. The host and arithmetic backends are not identical execution environments; timing ratios are not pure language-overhead measurements. See the component reports and raw results for repetitions, flags, source hashes and timing boundaries.

| Experiment | Result | What it establishes |
|---|---|---|
| Actual prime covers, interior/high positions | About 11.175 selected masks per 64 targets with a 512-anchor greedy pool | Replaces the earlier independent-random-mask assumption for the sampled cases |
| Native SIMD search, including source slicing | About 1.30 microseconds per 64-target word for that pool | A measured producer component; scalar code was about 3.64 microseconds |
| Lean, 65,536 targets and 168 real anchors, shifted masks | About 1.8 ms checking; about 2.0 ms building and checking from cached inputs | Efficient large-bitset kernel reduction, with corrupted proofs rejected |
| Lean, 262,144 targets and 188 real anchors, packed convolution | About 3.400 ms checking | Approximately 822 core-years if that arithmetic workload scales to the full range |
| Native FLINT arithmetic on the same packed fixture | About 3.015 ms | Approximately 729 core-years for this arithmetic stage; not a formal checker |
| Native FLINT shift/OR on the same 262,144-target fixture | About 0.608 ms | Approximately 147 core-years for this arithmetic stage; a stronger native candidate than packed multiplication |
| MM0, actual selected-mask trace with checked word resets | About 0.822 microseconds checking plus 0.400 microseconds emitting per selected mask | Actual verifier/producer throughput for a schematic arithmetic library |
| MM0, sparse slice-and-OR trace with resets | About 1.306 microseconds checking plus 0.575 microseconds emitting per update | A more expensive alternative that repeats alignment work |
| Lean Lucas–Pratt certificates | 55.08 ms CPU per anchor in a 32-root shared cohort | Genuine prime proofs: 250 prime nodes plus 1,105 auxiliary declarations; standard Lean axioms only |

The actual-prime experiments sampled four block origins and multiple offsets. They are correlated, deliberately structured samples. No failure of the 512-anchor pool was observed in the sampled targets, but this does **not** establish that the pool succeeds uniformly through 4 × 10^18. A production generator must certify every block and use larger pools or exceptional witnesses when needed.

Two measurement errors were caught and excluded. MM0 files mapped through the Windows/Linux filesystem boundary made a tiny test about a thousand times slower; accepted timings use Linux-local RAM storage. Lean's named primality theorems omitted substantial work in generated auxiliary proofs; the final primality measurements include those declarations.

## The Lean design

Use a shared, certified table of small primes and blocks of 2^32 even targets. For each block choose certified prime anchors just below its origin. A target n is covered when n−q is a prime marked in the shared table for some anchor q. This requires approximately 465.7 million anchor blocks; reserving 512 anchors per block gives approximately 238.4 billion anchor certificates. It avoids certifying every prime near 4 × 10^18 independently.

Lean's kernel directly reduces large natural-number multiplication, addition, shifts and bitwise operations. This makes a large arithmetic equality a different workload from thousands of separate byte proofs. The relevant implementation is [the pinned kernel source](https://raw.githubusercontent.com/leanprover/lean4/v4.35.0/src/kernel/type_checker.cpp), particularly `reduce_nat`.

The best tested arithmetic route uses packed convolution. Let P_j be the small-prime indicator at source position j, and let s_i be the anchor offsets. Choose a radix B=2^k and h=B/2 with m≤h, where m is the number of anchors. Set

    P' = Σ_j P_j B^j
    A  = Σ_i B^(S-s_i),       S = max_i s_i.

The coefficient at position S+t in P'A is the number of representations for target t, and lies between zero and m. Thus multiplication has no carries between radix-B digits. Let H_s have digit h at the target positions, and K_s have digit h−1 at those positions, with zero digits elsewhere. Then

    ((P' * A + K_s) & H_s) = H_s

holds exactly when every target coefficient is positive. Adding K_s causes no carry: each affected digit is at most m+h−1≤B−1. This needs three large-number operations, followed by equality checking. The mathematical argument was independently reviewed; actual fixtures were checked coefficient by coefficient and then accepted by Lean's kernel. The generic theorem connecting these arithmetic facts and certified prime tables to Goldbach still needs formalization.

Do not assemble the whole shared table as one enormous Nat. Use certified chunks with bounded halos. Source expansion can be proved and cached once; anchor polynomials and their prime provenance can be cached per anchor block. The 262,144-target fixture uses the first successful 188-anchor prefix of a 512-anchor pool, not all 512 anchors. Reusing that arithmetic cost requires cached prefix polynomials or equivalent selection work. A single fixed 512-anchor polynomial has different size and cost. Source radix, halo length and anchor span must be accounted for; the model's layout margin is an explicit assumption, not proof that these costs are bounded. Larger batches are not always faster: at one million target bits, shifted masks beat packed multiplication in the measured fixture.

## The current MM0 design

Use binary/digit representations, preproved small-operation tables, reusable closed proof references, and a fused word lemma. The benchmark checks the actual MM0 proof and unifier instruction streams, including accumulator linkage and resets between words. The actual-mask producer emits a valid proof stream accepted by the checker, and corrupted references are rejected.

**The benchmark arithmetic library is schematic.** Its table and lifting facts are axioms standing in for intended PA-derived theorems. The accepted theorem is the proposition `ok`, not Goldbach or a coverage statement. Its resets do not require the previous accumulator to be all ones; Python independently checks full-word coverage in the actual input fixture. That fixture contains 256 distinct words and is repeated 160 times. Thus this is not a PA proof of the arithmetic library or Goldbach. The measurements establish the cost of the instantiated proof shape, not completion of the standard-axioms-only implementation. Source-index soundness, prime provenance, final full-mask certification and full interval composition are additional obligations.

Precomputing aligned source facts can remove repeated slice proofs. All 64 source alignments require roughly 34.4 GB of raw word data, before proof metadata. Their checked access must be implemented efficiently; a raw array reference is not a proof of lookup. The forecast includes an explicit unmeasured allowance for this work.

Choose the producer's pool size by minimizing search time plus selected-mask count times checked/emitted cost. The SIMD measurements include smaller pools and a checked fallback to 512. At the measured current MM0 cost, the 512 pool is a good candidate; it is not assumed optimal in every implementation.

An expanded proof stream is not mandatory persistent storage. Streaming or fused template expansion can avoid writing it all out without introducing new logical axioms. Expansion, term construction and verification still cost time. The serial producer/checker scenario is measured; the idealized fused scenario in the model is a sensitivity case, not a benchmark.

## Accounting and remaining uncertainty

There are 2 × 10^18 − 1 even targets. For a measured t seconds per W-target chunk, the coverage extrapolation is

    ceil((2 × 10^18 − 1)/W) * t / 31,557,600 core-years.

For the MM0 word route, add measured native search time to the number of retained masks times their checking and emission costs. The executable model keeps these quantities separate and chooses among the measured search strategies. It does not multiply an old historical run by a guessed language-speed factor.

`forecast_inputs.json`, `forecast_model.py`, and `forecast.json` separate measured calibrations from the layout, lookup, construction and assembly allowances used to reach the rounded planning estimates. The packed native arithmetic projection is also reported separately; it is not itself a standard-axioms proof.

The central accounting is as follows. “Measured extrapolation” means a microbenchmark multiplied by the proposed workload, not a measured full-system cost.

| Lean component | Core-years | Basis |
|---|---:|---|
| Packed coverage kernel | 822 | Measured extrapolation |
| Expression building and layout adjustment | 257 | Assumed 1.05 × 1.25 factor on coverage |
| Anchor-primality checking | 416 | Measured 32-root complete shared closure, including auxiliary proofs |
| Native construction | 100 | Unmeasured allowance |
| Assembly and shared data | 200 | Unmeasured allowance |
| **Total** | **1,795** | Rounded planning figure: **2,000** |

| Current MM0, prealigned serial pipeline | Core-years | Basis |
|---|---:|---|
| Selected-mask proof checking | 9,096 | Measured schematic checker × measured mask count |
| Proof emission | 4,422 | Measured native emitter × measured mask count |
| Native search | 1,290 | Measured SIMD producer |
| Certified indexing/provenance and full-mask closure | 2,766 | Unmeasured 0.25 microseconds per selected mask allowance |
| Primality, bootstrap, source/library work and assembly | 1,000 | Unmeasured allowance |
| **Total** | **18,574** | Rounded planning figure: **20,000** |

The measured slice-and-OR template instead gives about 25,863 core-years under the same other assumptions. An idealized fused prealigned pipeline that removes all separately charged emission gives about 14,152, but that implementation was not measured and template processing is not actually free. None of these values is a lower bound on a future optimized MM0 implementation.

The native-construction and assembly allowances are not procurement estimates. In particular, no numerical evidence bounds the exceptional-target tail, proves the indexed-proof design meets its allowance, or guarantees successful large-scale sharding. The broad envelopes express this uncertainty; the unpriced risks can move a real implementation outside them.

The largest remaining risks are:

* Uniform coverage and the cost of exceptional targets have not been established.
* Certified source expansion, table access, anchor-polynomial provenance and the generic coverage theorem have not been integrated with the measured arithmetic.
* The MM0 library must be derived from PA rather than supplied as schematic axioms.
* Many trillions of local checks need a bounded-memory, checked composition pipeline. Hashes and dependency manifests bind artifacts; they do not prove the theorems. Neither stock prover was demonstrated compiling this entire future proof in one invocation.
* The accelerated-MM0 alternative requires an admissible rule/proof translation and a sound implementation. A verified compiler plus an observed native run alone does not produce an ordinary MMB proof.

At 10,000 physical cores and an assumed 70% parallel efficiency, 2,000 core-years is about 104 days and 20,000 is about 2.9 years. These are arithmetic conversions, not demonstrated cluster schedules. The sharding and storage engineering must support that efficiency.

## Reproduction and component reports

* `prime-cover/REPORT.md`: real-prime samples, native search, SIMD and pool-size tradeoffs.
* `prime-cover/PACKED_REPORT.md`: packed arithmetic, coefficient validation and fixtures.
* `lean/REPORT.md`: checked arithmetic proofs, strict runs, negative controls and timings.
* `prime-cert/REPORT.md`: complete primality proof dependencies and replay timings.
* `mm0/REPORT.md`: source/build provenance, accepted proof streams, negative controls and exclusions.
* `architecture.md`: independently reviewed mathematical design, accelerator scope and checked composition.

The benchmark directories are isolated from the canonical ternary-Goldbach source and its dependency artifacts. Run the model with the existing Python environment:

    work/qrh-campaign/interval-env/Scripts/python.exe work/formal-goldbach-bench/forecast_model.py
