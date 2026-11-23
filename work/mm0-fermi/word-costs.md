# Word costs for an MM0 binary-Goldbach computation to 4e18

Research estimate, 2026-11-10. No MM0 implementation or benchmark was run. All costs below are engineering hypotheses unless explicitly attributed. The main conclusion is that batching 64 or 256 output bits is necessary but insufficient: a proof trace for each sieve strike can dominate everything. A factor of 3, 10, 30, or 100 over native execution cannot be inferred from MM0's fast logical kernel.

## Units and native baseline

Use N=4e18, M=N/2=2e18 even targets, and a year of 31,557,600 seconds. Ignore the constant number of small boundary cases in this Fermi estimate.

The parent campaign supplies a historical normalized cost of 8.7 sieve plus 9.707 partition cycles per even target on a 2.83 GHz Q9550, about 412 reference core-years. This is different from the published campaign's approximately 770 accumulated old core-years. For a modern optimized implementation, the parent's provisional baseline is 100 core-years, with a 30–300 range. This note does not independently measure that modernization factor.

Three different operations must remain distinct:

1. A native arithmetic or bit-mask update.
2. A derived PA theorem application, denoted D, using previously proved arithmetic lemmas.
3. A kernel event, denoted E, including proof opcodes, unification, argument traversal, and term construction.

One D can require many E. This note models 5–20 E/D, with 10 as an illustrative central value. The integration worker's proposed throughput is 2e7 E/s. Neither number is measured on this application. A claim of 1e8 D/s is a much more optimistic scenario than 1e8 E/s and must not be substituted silently.

The MM0 paper describes essentially linear checking of its explicit binary proof representation. Its very fast set.mm benchmark does not measure concrete 64-bit arithmetic evaluation. The C verifier explicitly constructs terms and runs unification programs when applying theorems. These design facts motivate separating D and E. [MM0 paper](https://arxiv.org/html/1910.10703), [C verifier](https://github.com/digama0/mm0/blob/master/mm0-c/verifier.c).

## Arithmetic workload before proof overhead

An odd-only sieve contains about M positions. Its first-order strike count is

    S ~= M * sum_{odd primes p <= sqrt(N)} 1/p
      ~= M * (log(log(2e9)) + .2614972 - .5)
      ~= 5.65e18 strikes.

This is a rough analytic workload, not a lower bound. Starting at p^2, wheel sieving, presieving, buckets, and vectorized small-prime masks alter the count and the cost of a strike. It is still useful for detecting estimates that accidentally divide every sparse large-prime strike by 64. Large-prime strikes normally hit different words; packing the storage does not merge 64 such updates into one.

The base-prime table reaches only 2e9, approximately 1e8 primes and about 0.4 GB at four bytes each. Its certification is small compared with the outer range. The full odd bitset, if materialized, is 2e18 bits or 250 PB. It must be segmented and reused. Merely storing one 16-bit witness per even would cost 4 EB before its primality proofs.

For Goldbach coverage, suppose every selected small prime p gives a shifted mask of certified primes n-p. OR these masks until all target bits are covered. There are 3.125e16 64-bit target words or 7.8125e15 256-bit target words.

With prime-hit probability heuristically rho=2/log(N)=.04669, sequentially trying small prime shifts takes approximately (log W+EulerGamma)/rho trials to cover a W-bit word: about 101 for W=64 and 131 for W=256. This is a random-model estimate; arithmetic correlations and rare hard targets matter. Using 100 and 130 gives respectively 3.125e18 and 1.016e18 mask updates. A mask update itself can require several native instructions for alignment, loads, OR and completion testing.

## Omit unsuccessful searches from the certificate

The proof need not reproduce the native search order. An untrusted generator can select a small subset of shifts whose masks cover a target word. The checker then verifies only those shifts and their OR, together with the certified prime bitset. Existence needs no proof that earlier candidates failed or that the selected primes are minimal.

A reproducible toy experiment used Python random seed 20261110, 100 trials per width, 1,200 candidate masks, independent hit probability 2/log(4e18), and greedy selection of the mask with most uncovered bits. For width 64 the selected count ranged 11–14, median 13, mean 12.72. For width 256 it ranged 23–27, median 26, mean 25.54. These are synthetic masks, not observed prime data. They justify investigating budgets of 15 selected masks per 64 bits or 30 per 256 bits; they do not certify those budgets for real intervals.

The resulting update counts are 4.6875e17 for the 64-bit plan and 2.34375e17 for the 256-bit plan. Difficult words can carry longer lists or explicit witnesses. Every certificate is checked, so the heuristic affects cost prediction only. Finding the selected cover can cost more than the original sequential search, and that generation cost must be added to the final estimate.

This optimization removes failed coverage masks. It does not certify primality for free and does not eliminate the sieve computation. A successful mask must be linked to sound prime flags, not arbitrary generator-provided bits.

## Plausible proof cost per operation

These estimates assume binary numerals, shared terms, preproved byte-operation tables, and reusable arithmetic lemmas. They are not literal counts of expanded Peano axioms. Expanding every reused theorem into foundational steps would be a different and much larger measure.

| Operation | 64-bit derived applications D | 256-bit derived applications D | Reason |
|---|---:|---:|---|
| Concrete AND/OR/XOR on byte chunks | 30–150 | 120–600 | Eight or 32 byte facts plus concatenation/equality assembly |
| Shift with alignment, OR, final all-ones check | 50–250 | 200–1,000 | Cross-byte or cross-limb joins add work |
| Addition, comparison, or carry update | 50–300 | 200–1,200 | Carry and range lemmas, or bit recursion |
| Sparse sieve update with index/range justification | 20–200 | Not automatically divided by four | Address arithmetic and one modified bit/word |

A direct bit-by-bit construction can cost roughly 300–3,000 E for a 64-bit operation, and 1,200–12,000 E for 256 bits. Well-chosen byte tables may approach the lower end; poor numeral normalization and repeated term construction can exceed the upper end. These ranges overlap rather than defining separate measured architectures.

Native AVX speedup does not automatically transfer to a PA proof. If proof work is linear in bit width, moving from 64 to 256 bits gives four times the proof cost per operation and only four times fewer target words. In the selected-cover model, 256 bits need twice as many shifts per word as 64 bits, so proof work may actually double. Native generation can still benefit from AVX.

A theorem for an entire progression or block can have a short application, but its concrete output premise must also be established. Writing one theorem application whose premise says that a large sieve block was computed correctly does not make that premise free.

## Numerical consequences of the two cost units

First consider an intentionally optimistic effective throughput of 1e8 completed D/s, without charging a separate E/D multiplier:

| Work | Assumed D per update | Core-years |
|---|---:|---:|
| Sequential 100 masks per 64-bit word | 50 | 49,513 |
| Selected 15 masks per 64-bit word | 50 | 7,427 |
| Selected 30 masks per 256-bit word | 200 | 14,854 |
| Sieve at 5.65e18 strikes | 5 | 8,954 |
| Same sieve | 20 | 35,816 |
| Same sieve | 100 | 179,079 |

Even the optimistic selected-64 plus 20-D sieve example totals about 43,243 core-years. Relative to a 100-core-year modern native baseline, that is about 432 times, not 10 times.

Now use 10 E/D and 2e7 E/s. This makes each entry above 50 times larger. The selected-64 plus 20-D sieve case is approximately 2.16 million core-years: 371,345 for coverage and 1,790,792 for sieve updates. This is a stress test of a concrete trace architecture, not a prediction that every possible MM0 solution must take this long. It identifies the work that a better architecture must avoid.

At this event rate, a total runtime of H times the provisional 100-core-year native baseline permits the following average event budget over S plus the selected-64 coverage updates:

| Total overhead H | Allowed E per strike-or-cover update |
|---:|---:|
| 3 | .0309 |
| 10 | .1031 |
| 30 | .3094 |
| 100 | 1.0313 |

Every entry below one event per update requires compression across many updates. Even 100 times cannot support an ordinary multi-event proof of every strike. If a certified block algorithm removes strike-level proof traffic, these denominators change and the target can become plausible; that is precisely the design question to benchmark.

My judgment is therefore: 3 times is an aggressive research target requiring near-native certified block evaluation; 10 times remains very optimistic; 30 times is a useful target for a substantially different batched checker; 100 times is not a conservative upper bound for an explicit PA arithmetic trace. For the latter, hundreds to tens of thousands times native remain plausible depending on the throughput unit and proof representation. Do not use these judgments as measured error bars.

## Proof volume and streaming

The selected-64 plus 20-D sieve example has about 1.36e20 derived applications. At an extremely lean five bytes per application it produces about 0.68 ZB. At twenty bytes it produces about 2.73 ZB. These figures exclude any extra term bodies and are illustrative, not measured MMB sizes. The stream can be much larger if each application requires several separately encoded events or fresh concrete numerals.

Even coverage alone at 50 D per selected mask is about 117 EB at five bytes per D. Streaming avoids retaining the whole proof on disk, but does not remove generation, transfer or checking bandwidth. Reading 1 ZB at 1 GB/s takes about 31,688 years; at an aggregate 1 TB/s it still takes about 31.7 years. Compression helps only if the verifier can expand/check it cheaply enough.

The current C verifier documents 32-bit table addressing and a four-GB individual-proof limit. Large computations need independently bounded proof chunks and a checked aggregation scheme; a single ever-growing proof heap is unsuitable. [Verifier README](https://github.com/digama0/mm0/blob/master/mm0-c/README.md).

## What could change the estimate

A certified sieve can use a proved block invariant, periodic presieve masks, arithmetic-progression summaries, and a checked transition system. These may remove repeated arithmetic justification and reduce proof volume dramatically. They must still prove that every claimed prime has no small prime divisor. Proving only that the marked entries are composite is insufficient: a missed composite would otherwise become a false prime witness.

A formally proved native checker is another architecture. Its soundness theorem can be checked once, and its execution can be fast. But an external observation that it returned success is not automatically a closed PA proof of this particular Goldbach instance. The project must specify how the concrete successful execution is accepted: an explicit execution certificate, a proved and trusted computational kernel extension, or a different external trust boundary. A proof-producing compiler proves code properties; it does not by itself prove the output of an unrecorded run.

The decisive benchmark should cover at least one real high-range segmented sieve and coverage block, report separately native generation time, proof-generation time, checker time, D, E, bytes, and peak memory, and preserve the complete prime-soundness invariant. Compare sequential and selected-shift certificates on that same block. Test enough block sizes to expose term reuse and cache effects. Extrapolation can then use measured events per odd position rather than a generic multiplier.

The exact desired finite theorem is the original binary statement for every even n with 4<=n<=4e18. The 2014 empirical computation established that range operationally; this note estimates the additional cost of obtaining the requested formal certificate, not a stronger number-theoretic theorem. [Authors' publication page](https://sweet.ua.pt/tos/bib/4.12.html).
