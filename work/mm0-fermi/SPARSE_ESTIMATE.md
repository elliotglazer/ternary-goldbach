# Efficient MM0 finite-Goldbach estimate

> Historical, unbenchmarked scenario. Superseded by the [measured Lean/MM0 forecast](../formal-goldbach-bench/FORECAST.md), which tests actual prime covers, both checkers, native production and complete Lean primality-certificate dependencies. The figures below are retained to document the earlier assumptions; do not use them as the current forecast.

Fermi estimate, 2026-11-10. Target: a PA-based MM0 proof that every even integer from4 through4*10^18 is a sum of two primes. This estimates building and checking the proof after developing the required infrastructure. No such complete implementation was built or benchmarked here.

## Answer

My final planning estimate is approximately **50,000 modern physical-core-years for proof generation and checking together**, with a broad illustrative range of **10,000–500,000 core-years**. The central arithmetic gives about48,000 years. This is an engineering estimate for an explicitly described efficient certificate design, not a lower bound, confidence interval, or measured forecast.

At50,000 core-years and70% achieved parallel efficiency:

| Physical cores | Approximate elapsed time |
|---:|---:|
|1,000|71 years|
|10,000|7 years|
|100,000|9 months|

Research/development time, queues, and any additional storage bottleneck are excluded. These wall times assume sound sharding, sufficient local throughput, and balanced allocation between construction and verification. A stock monolithic MM0 file is not the proposed implementation.

## Use a sparse prime covering certificate

Divide the targets into blocks of2^32 even numbers, each spanning2^33 integers. There are465,661,288 blocks, with a partial final block. Certify one reusable table of small primes through roughly2^33+2^20. Its odd-only bitmap is approximately537MB before formal metadata.

For a block beginning at B, find roughly512 certified large primes q in[B-2^20,B). Then a target even n is covered whenever p=n-q is marked prime in the shared small table. For each word of64 even targets, select a small set of these shifted prime masks whose union is the active-word mask. The model uses15 selected masks per word. The initial block is handled by an ordinary finite sieve proof, because it has no positive anchors below its origin.

This certifies only about2.38*10^11 large-prime anchors rather than every prime through4*10^18. It also omits failed producer searches from the proof. Every selected prime, table slice, shift, union and interval boundary must still be checked. A positive bitmap bit must have prime provenance; native memory contents are not trusted.

The512-anchor pool and15-mask average are unmeasured performance assumptions, not number-theoretic guarantees. The generator must actually check full coverage. It can enlarge the pool or use individually certified exceptional representations if a block fails. That fallback is sound but its frequency and cost are unknown. It may move the runtime outside the stated range. A heuristic or random-mask experiment cannot prove complete coverage.

## Efficient MM0 arithmetic and table access

Pre-prove byte-level operations, reuse closed proof references, and use one fused lemma to lift byte results to a word operation. This avoids fresh chains of bit-by-bit PA rewriting. Primary-source inspection confirms that a saved closed proof can be reused with MM0 `Ref`, while generic theorem application otherwise runs a unification stream.

A table reference is not automatically a proof of array lookup. The proposed layout uses proved prime-word chunks and a sequential scan. At a given output position the anchor shifts lie within a sliding window of about8193 source words. Unpack chunks once into cached indexed prime-word facts, then advance the window. A fused two-source-word slice-and-union lemma supplies each covering mask. The central cost below includes400 elementary verifier-work events per selected mask, allowing twice the estimated bare word-operation cost for slicing, indexing and provenance.

Here an event is an elementary proof-dispatch, unifier-node or argument-processing action. It is not a complete PA theorem application. The costs and throughput are cycle-budget assumptions, not observed Goldbach performance.

See [MM0 binary-format documentation](https://github.com/digama0/mm0/blob/master/mm0-c/mmb.md), [the MM0 paper](https://arxiv.org/html/1910.10703), and the source review in `mm0-throughput.md`. The paper's195ms library benchmark is not used as an arithmetic-throughput conversion.

## Central calculation

There are2*10^18 even targets and3.125*10^16 target words.

| Component | Assumptions | Core-years |
|---|---|---:|
|Check selected coverage masks|15 masks/word,400 inclusive events/mask,2e8 events/s/core|29,708|
|Emit their proofs|400 bytes/mask,500MB/s/core using a specialized template emitter|11,883|
|Find compact covers|20,000 native cycles/word at4GHz|4,951|
|Check large-prime certificates|512 anchors/block,1e7 events/certificate|about378|
|Other construction and shared certificates|Allowance for anchor generation, small-table proof, amortized chunk setup and composition|1,000|
|Total||about48,000|

The coverage-checking equation is

    (2e18/64)*15*400 / (2e8*31557600) = 29,708 core-years.

Emission uses serialized bytes per second, not verifier events per second. The emitter does not execute the verifier's unification work. Cover search and failed attempts are separately priced rather than silently omitted.

`model.py` and `model.json` give all parameters and reproducible arithmetic. An aggressive scenario gives about8,000 core-years and a conservative one about500,000; rounding yields the stated10,000–500,000 planning range. They vary retained masks, inclusive work per mask, bytes, verifier/emitter throughput, and search cost. They are not measurements.

The central expanded coverage stream is about188 exabytes. This is cumulative data, not peak memory, but it is a real engineering issue. The estimate assumes local generation, bounded-memory checking, and sound chunk composition. Retaining and transferring the entire expanded stream would be a separate enormous project. The reference MM0 format has finite per-proof/table limits, so sharding is a prerequisite. A hash alone or importing an unchecked chunk conclusion as a new axiom does not establish a PA proof.

## Historical calibration and comparisons

The historical native computation reported770 heterogeneous CPU core-years. Its measured Q9550 sieve and partition costs normalize to about412 reference-core-years. A modeled modern native dense-sieve run is around100 core-years, broadly30–300. It is not the same algorithm as the sparse proof generator, whose compact-cover search may do more native work to emit less proof. See `native-baseline.md` and [the original paper](https://denisevellachemla.eu/empirical-verification-of-the-even-CG.pdf).

The earlier2.3-million-year estimate extrapolated a separate proof for each integer. It was not an optimized-MM0 estimate. The earlier2500-year Lean scenario used an unsupported conversion multiplier and likewise does not establish a fair comparison. The dense proof-producing sieve alternative remains in `model.json`; its central estimate is about112,000 core-years, under a different set of explicit assumptions. The sparse design is the preferred efficient architecture here.

The present result does not establish that equally optimized Lean is faster or slower. It gives a concrete MM0 estimate while accounting for proof arithmetic and certificate production. A pilot near the high endpoint must measure actual masks retained, certified lookup cost, prime-certificate cost, proof bytes, and producer/checker rates before this becomes a reliable project budget.
