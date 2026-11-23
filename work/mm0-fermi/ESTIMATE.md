# Efficient MM0 finite-Goldbach estimate

This is the earlier dense-sieve scenario. The final preferred estimate uses a sparse prime-cover certificate; see [SPARSE_ESTIMATE.md](SPARSE_ESTIMATE.md). The executable model retains both designs separately.

Fermi estimate, 2026-11-10. The target is a PA-based MM0 proof that every even integer from4 through4*10^18 is the sum of two primes. This report estimates building and checking that proof after its mathematical and software infrastructure has been developed. It does not claim such an implementation exists or has been benchmarked.

## Planning answer

Use approximately **100,000 modern physical-core-years for proof generation and verification together**, with a deliberately broad **10,000–1,000,000 core-year range**. The central model computes111,503 core-years, which should be rounded to one significant digit. About74,269 are checking,37,134 are proof construction beyond the native search, and100 are native sieve/search work. These components and the entire range are assumption-dependent, not statistical confidence intervals.

At the rounded central estimate and70% parallel efficiency:

| Continuously available physical cores | Approximate elapsed time |
|---:|---:|
|1,000|143 years|
|10,000|14 years|
|100,000|1.4 years|

This assumes a sound chunked proof pipeline with adequate local throughput. It excludes research and engineering time, cluster queueing, and an additional archival/export bottleneck. It is not a prediction that a current MM0 command can build a monolithic proof of this size.

## The efficient architecture being priced

The generator runs a wheel-based segmented sieve and searches for representations, but the checker does not repeat every failed search. For each64-even target word the generator selects a small collection of shifted certified-prime masks whose union covers the word. The model uses15 selected masks centrally, rather than about100 attempted candidates. The actual distribution requires a high-endpoint experiment; a random-mask simulation is only supporting intuition.

Prime evidence is shared across the whole segment. The certificate also verifies the sieve or another deterministic primality certificate; a prime bitmap cannot be accepted merely because the native program produced it. Segment boundaries, the prime halo, complete interval coverage, and the base-prime table all need proofs.

For concrete arithmetic, use a library of pre-proved byte operations, cached closed proof references, shared numeral nodes, and a fused lemma lifting eight byte results to one64-bit operation. This avoids constructing a fresh chain of bit-by-bit PA rewrites at every update. Proof caches must be amortized over sufficiently large chunks and reset costs included. No new arithmetic axiom or trusted native execution is assumed.

The required large-file/chunk composition infrastructure remains to be engineered and verified. The finite theorem is obtained only after every shard is checked and its exact interval conclusion is correctly assembled. Proving the sieve algorithm correct does not by itself certify an arbitrary execution of it.

## Native calibration

The original experiment reported770 heterogeneous one-core CPU-years. A more useful normalization is its measured8.7 sieve cycles per odd integer plus9.707 partition/statistics cycles per even integer on a2.83GHz Core2 Q9550. Applied to2*10^18 targets, these imply about412 reference-core-years before unspecified extra work. Modern throughput and existence-only output motivate a native estimate around100 core-years, broadly30–300. This is a modeled speedup, not a modern benchmark. See `native-baseline.md`.

Source: [Oliveira e Silva, Herzog and Pardi, empirical verification paper](https://denisevellachemla.eu/empirical-verification-of-the-even-CG.pdf), sections1.1–1.3.

## Central proof-work model

An **event** here means an elementary proof-dispatch, unifier-node, or argument-processing action. It is not a complete theorem application, a machine instruction, or necessarily a serialized bytecode. This unit prevents the earlier mistake of assigning an opcode throughput directly to whole PA theorem applications.

There are approximately2*10^18 even targets, or3.125*10^16 words of64 targets. The central assumptions are:

| Quantity | Assumption |
|---|---:|
|Effective sieve-update records after wheel/pre-sieve handling|2.5*10^18|
|Inclusive checker events per sieve record|150|
|Selected covering masks per64 targets|15|
|Inclusive events per mask, including lookup/lifting/coverage bookkeeping|200|
|Sustained checker throughput|2*10^8 events/second/core|
|Additional proof-generation work|half the checking CPU work|

The sieve-record count is a wheel-aware operation estimate, not an implementation measurement. The costs require specialized arithmetic lemmas and efficient references. The throughput is a cycle-budget assumption for simple cached events on a modern core; it is not inferred from MM0's published set.mm timing. The proof-generation ratio prices emission and construction separately from native search; it may be wrong in either direction.

The checking calculation is

    [2.5e18*150 + (2e18/64)*15*200] / (2e8*31557600)
      =74,269 core-years.

Adding proof generation and native computation gives roughly111,503 core-years. `model.py` reproduces all arithmetic and includes two internally consistent sensitivity scenarios:

| Scenario | Checking core-years | Generation plus checking plus native |
|---|---:|---:|
|Aggressive batching and faster simple-event checking|about7,100|about10,600|
|Central optimized byte-table design|about74,000|about112,000|
|More certificate work and slower checking|about733,000|about990,000|

The primitive costs, event throughput, selected-mask count, and generation ratio are the dominant unknowns. A poorly engineered proof trace could take longer than the upper scenario. A substantially better mathematical certificate could beat the lower one. No claim of an optimal lower bound is made.

## Why the proof is still expensive

Efficient MM0 checking does not make a64-bit update a single PA inference. Even after sharing and byte tables, validating several quintillion arithmetic/sieve records is substantial work. A very large cumulative certificate stream is also expected. The model requires generation and checking near each other, bounded-memory shards, and minimal unnecessary archival traffic; it does not assume all expanded proof data can fit on one machine or in one MM0 file.

The MM0 design supports explicit proof references and efficient checking. Its paper reports a195ms check of a translated library, but that is not an arithmetic-throughput benchmark and is not used to convert this workload. See [MM0 paper, section3](https://arxiv.org/html/1910.10703) and [MM0 binary-format documentation](https://github.com/digama0/mm0/blob/master/mm0-c/mmb.md).

## Reconciliation with earlier conversational numbers

The2.3-million-core-year number extrapolated a1000-step-per-integer design from the earlier30-minute estimate at10^8. That was not a forecast for an optimized proof-producing sieve. Conversely, the2500-core-year Lean scenario used an unsupported100-fold multiplier on an optimistic native baseline. It does not establish that Lean would be faster than this MM0 design. Neither was calibrated against an implementation, and there is no measured Lean/MM0 speed ratio here.

The present estimate names a more efficient certificate architecture and prices its remaining work explicitly. It is still a Fermi estimate. To narrow it, benchmark one representative high-endpoint segment, measuring native work, proof emission, checker events, serialized bytes, verification time, and peak memory separately. Development of that prototype is not required to state this estimate, but it is required before treating the number as a project budget.
