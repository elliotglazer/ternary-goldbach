# Smaller binary cutoff with a mixed prime ladder

Research result, 2026-11-11. This derives interval geometry and a conditional cost frontier. It does not establish primality in new windows, run a search, compile a theorem or assert a new runtime forecast.

## Why this changes the next experiment

The original finite-range argument combines binary Goldbach through B0=4e18 with a prime ladder to N=1e27. The current ladder has a cheap special-purpose batch checker. Reducing B while requiring every new prime to use a generic certificate may destroy that advantage. A mixed ladder can retain the batch checker on ordinary windows and give separate prime certificates only for failed special-form windows.

The first experiments should therefore compare complete mixed blocks, not only a fully generic denser ladder. In particular, narrower windows at B=1e16 or 2e16 deserve investigation. Their binary range is respectively 400 or 200 times smaller, but their regular ladder has approximately 711 or 357 times as many rungs in the constructions below. These are work counts, not predicted speedups. Fallback frequency, per-rung cost and artifact composition decide whether either trade is worthwhile.

## Exact coverage geometry

Let F=2^45, let W be a power of two, and let S be a positive integer. Window i contains the candidates

    p(i,t) = (S*i-t)*F + 1,  0 <= t < W.

For a regular window, certify one such candidate prime. For a fallback window, certify any odd prime p in the enclosing interval

    (S*i-(W-1))*F + 1 <= p <= S*i*F + 1.

The fallback prime need not lie on the F-lattice. Both kinds give exactly the same interval guarantee to the final coverage proof.

For odd n, set i=floor((n-5)/(S*F)). Then

    i*S*F + 5 <= n <= (i+1)*S*F + 3.

Consequently, for either certified rung,

    4 <= n-p <= (S+W-1)*F + 2.

Thus (S+W-1)*F+2 <= B is sufficient. The even number n-p is then in the binary range. Use n=3+(n-3) for odd 5<n<=B+3. Every larger n has i>=1, because the coverage condition implies S*F<=B-2. The final required index is at most floor((N-5)/(S*F)). These statements include the last odd n below the even bound N.

For this simple uniform first-window construction, impose S>=W. This keeps S*i-t positive at i=1. It is a convenient sufficient condition, not a theorem that other early-window constructions are impossible. The Proth certificate also needs S*i<F; all listed rows satisfy it for their whole index range. If N changes, F and this constraint must be reconsidered.

Separately, arbitrary ordered odd prime rungs cover the full odd interval using binary Goldbach through even B precisely when the consecutive coverage intervals leave no odd gap. A sufficient and sharp adjacent-gap condition is p_next-p<=B-2, since a rung covers odd [p+4,p+B]. The uniform-window condition above guarantees this even for the worst relative endpoint choices.

## Concrete admissible shapes

For fixed B and W choose S=floor((B-2)/F)-(W-1). The following rows satisfy the exact sufficient conditions. The byte count is only a packed regular offset stream, before exception tags, fallback certificates, framing, proof artifacts or copies.

| Binary cutoff B | W | S | Rungs through N | Raw regular offsets, bytes |
|---:|---:|---:|---:|---:|
| 1e16 | 128 | 157 | 181,029,996,372 | 158,401,246,826 |
| 2e16 | 256 | 313 | 90,804,183,483 | 90,804,183,483 |
| 1e17 | 1024 | 1819 | 15,624,908,977 | 19,531,136,222 |
| 2e17 | 2048 | 3637 | 7,814,602,537 | 10,745,078,489 |

All exceed the old 28-bit rung-index bound. Reusing the old source unchanged would be invalid even if the certificate search succeeds. The old 11-bit offset width must also become the actual log2(W). Block assembly must handle bounded memory and complete index coverage; a list of untrusted successful shard hashes is insufficient.

The exact script [hybrid_ladder_tradeoff_20261111.py](hybrid_ladder_tradeoff_20261111.py) writes [the geometry and sensitivity data](hybrid_ladder_tradeoff_20261111.json). It checked 816 selected endpoint identities, 48 exact cost-threshold identities, and a negative stride control. The mathematical proof is the inequalities above; those examples alone are not a universal proof. No prime or transcendental function was evaluated.

## Conditional break-even test

Let a be total binary-generation-and-checking work per unit cutoff within a specified architecture. Let cP be total ordinary-rung cost, cF the corresponding fallback cost, and f the fraction of fallback windows. Let K be the required rung count. The first-order model is

    C(B,W) = a*B + K*cP*(1 + f*(r-1)),  r=cF/cP.

This approximation assumes the same binary architecture scales linearly over the proposed cutoffs. Shared setup, changing word lengths, fallback search, assembly and storage costs must be added or included consistently in the coefficients. In particular, failed ordinary searches belong in cF. There is no measured f for these windows.

Normalize the old binary cost to 1. Put q=old_ladder_cost/old_binary_cost, c=new_ordinary_rung_cost/old_ordinary_rung_cost and K0=254638308. Then the candidate costs

    B/B0 + q*c*(K/K0)*(1+f*(r-1)),

while the old route costs 1+q. For r>1 the exact algebraic threshold is

    f_limit = (((1+q-B/B0)/(q*c*(K/K0)))-1)/(r-1).

A negative threshold rejects the candidate even with no fallbacks. A threshold above one means fallback frequency alone cannot erase the modeled advantage. Between these extremes, measured f and a conservative hard-case allowance must be below the threshold. This is the decisive test; an unsupported prime-density heuristic must not be substituted for the result of a complete certificate search.

The script evaluates illustrative dimensionless q, c and r grids. They are sensitivity scenarios, not calibrated Lean or MM0 estimates. Optimal choices can differ between the two systems. Reducing the symbolic objective by assuming smaller costs is not research progress.

## How to preserve the ordinary batch computation

The current batch checker shares modular exponentiation over a product of candidate moduli. A mixed implementation can propose omitting fallback positions from that product while advancing the exponent progression across every position. It checks the original divisibility conditions only at retained positions. Separate primality and interval certificates cover the skipped positions.

This is a proposed checker adaptation, not an already proved modification of Ladder/Check.lean. Its soundness obligations include the mask-to-index correspondence, exact exponent progression at skipped indices, product divisibility for every retained candidate, positivity and size bounds, and disjoint complete coverage by ordinary and fallback cases. A batch containing no ordinary positions needs an explicit harmless case. Generic fallback validation should use a shared factor-prime cache where justified and retain the actual p interval endpoints.

The most useful test block includes at least one fallback and one boundary case. An all-ordinary interior block would not validate the new architecture. A full production run must certify every requested window or reject; no statistical assumption fills missing rungs.

## Recovered benchmark evidence and its limits

The existing [formal-goldbach-bench](../formal-goldbach-bench/FORECAST.md) work contains actual component measurements that were absent from the recent campaign summary. All seven data-file hashes listed in forecast_inputs.json match the current files. This verifies their recorded identity, not a fresh execution or independent correctness audit.

Usable observations, with their original boundaries, include:

- Lean checked a 262144-target packed arithmetic equality in about 3.400 ms of inner-loop wall time. Prime-table interpretation and the generic Goldbach implication were outside that benchmark. It is not a complete binary-block CPU measurement.
- The Lean primality experiment checked a full shared closure of 32 prime roots near 2e18 and 4e18 at 55.078 ms CPU per root. The roots were 61 or 62 bits. It did not implement partial Pocklington or the special-form batch optimization.
- The MM0 mask experiment measured about 0.822 microseconds of checking and 0.400 microseconds of emission per update. Its arithmetic library was schematic, and its accepted conclusion was `ok`, not the PA coverage theorem. These rates price a proof shape; the missing library, indexing, prime provenance and full-mask implication still need construction.
- The separate specialized-native-checker proposal explicitly changes the acceptance implementation. It cannot be silently priced as an ordinary proof accepted by unchanged mm0-c. If an admissible arithmetic extension is allowed, compare the corresponding possibility for both systems and account for its correctness construction.

Do not compare the 55.078 ms generic 61/62-bit primality result directly with the README's 55 microsecond special-purpose approximately 90-bit ladder result and call their ratio a calibrated fallback penalty. They use different proof algorithms, batching and inputs. The ratio r above needs an actual mixed-ladder implementation or an explicitly conditional operation-level estimate.

The old headline forecasts remain historical models. They are not full ternary-Goldbach costs and do not determine the new optimal B. Their underlying measurements do justify preserving wide arithmetic and batching in the next design rather than reverting to per-integer proof terms.

No new theorem, production certificate or measured speedup is claimed. The next research action is to compare mixed-rung certificate algorithms and choose complete test blocks at the above shapes, while the separate spectral investigation determines whether its own cost dominates.
