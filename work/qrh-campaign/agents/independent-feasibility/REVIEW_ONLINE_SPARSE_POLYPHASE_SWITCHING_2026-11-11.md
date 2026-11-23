# Review of online sparse-to-polyphase switching

2026-11-11. PASS at conditional scheduling-theorem and exact-metadata scope, without correction. Author `major-constants/ONLINE_SPARSE_POLYPHASE_SWITCHING_2026-11-11.md` has SHA256 `078A8C9A9DA83888C837F1D13995EF87B2E7D14733587616D793F823AB7C0F52`.

I read the full frozen note, script and receipt. I reused my already completed arithmetic review rather than repeating the FFT audit. The policy has the claimed guarantee for its fixed priced implementations and realized query sequence. It does not establish a bound against every shared, evicting, precision-adaptive or independently optimized evaluator. No transform, function value, build or frozen-file modification occurred.

## The exact comparator

Fix the actual coefficient array, conductor, tilt, interval, precision, phase convention, offset class and output kind. Both methods must satisfy the admitted evaluator contract. Their numerical centers need not be identical, but the same realized requests are used in the cost comparison.

Let C>=0 be truly common work, K>=0 the fixed dense construction and persistent-storage price, d_i>=0 the per-unique-query dense cost, and l_i the cache-aware all-local increment. The assumption r_i=l_i-d_i>=0 is essential. The l_i sequence is defined by the fixed all-local cache trajectory, including lazy setup, rather than by340 presumed cache misses on every request. Costs must be available from the declared schedule and metadata before local evaluation.

For a nonempty sequence the fixed alternatives are exactly C+D+R and C+D+K. If some quantities are upper price ledgers, the theorem compares those ledgers; it does not establish the same ratio between unknown actual costs. In particular subtracting two upper bounds does not prove that actual local excess cost is nonnegative.

The common C cannot include a base transform avoided by one comparator. Output normalization, rounding, strict-sign checks or numerical Y scaling must be included in whichever schedule actually performs them. The author states these conditions rather than treating dense retrieval as free.

## Prefix proof and overshoot

Until the first switch, the policy's local cache equals the all-local cache. Therefore its predicted next r_s is the correct all-local increment. It buys before paying that increment when R_previous+r_s>=K.

For K>0, the accumulated paid rental is strictly below K. If a purchase occurs at s, nonnegativity of subsequent all-local rentals gives total R>=K for every later stopping prefix. The online cost excluding controller work is exactly

    C+D+R_previous+K < C+D+2K.

If it does not buy, it is the all-local execution, with R<K. Combining cases gives

    ALG <= controller+C+D+2*min(R,K)
        <= controller+2*min(C+D+R,C+D+K).

The K=0 case buys on the first unique request and pays C+D. The empty sequence performs no optional purchase or lazy local setup; common and controller work already incurred retain their declared charges. These cases do not use the strict R_previous<K statement with K=0.

Large first-use setup or a cache miss cannot cause rental overshoot because the threshold comparison precedes that work. With a billion-unit first rental and K=10, the policy pays10 rather than the billion and then10. Paying the triggering local request first would destroy the bound. The frozen algorithm uses the correct order.

The proof holds at every finite stopping prefix, with no distributional assumption. Adaptively chosen endpoints are allowed only with comparison to the same realized endpoint sequence. Different error intervals can cause different evaluators to request different points; the theorem does not compare those resulting search strategies or their eventual Turing success.

## Cache, duplicates and persistence

Lazy local kernel cost and the actual missing coarse-sample set are charged when first used by the all-local trajectory. If the policy purchases immediately, it need not construct those unused objects. If it purchases later, their previous cost remains in R_previous and is never refunded. A query result may be deduplicated only under the full instance key. An inconclusive sign remains inconclusive; a higher-precision request is a new instance unless a separate reuse proof and cost model is supplied.

The explicit controller term covers query lookup/return, stencil calculations, cache membership and insertion, price arithmetic and any bitset initialization absent from the comparators. Its omission could make the displayed arithmetic savings misleading. The stated2*ceil(N/w) zero-word initialization count is correct for two N-bit bitsets, but is not a complete memory or proof-state bound.

K must buy an array that remains queryable. Streaming and discarding unknown future outputs does not satisfy that contract. External storage is acceptable only with its accesses and persistence priced. Eviction or a rebuild requires a different accounting theorem. Refusing a purchase because of exhausted memory also removes the guarantee for that instance unless its comparator is correspondingly restricted.

Across classes, summing independent-instance inequalities gives a guarantee against the sum of the private-cache fixed minima, with truly shared work charged once. It does not give a guarantee against an offline schedule sharing arbitrary roots, stencil normalizations or one padded transform across classes. Actual cache sharing may reduce the online bill, but does not make a stronger comparator theorem automatic. The author explicitly retains this limitation.

The raw-U proposal and changed precision are likewise distinct arithmetic contracts. This scheduling theorem does not admit them, identify their operand widths, or make old T-normalized samples valid under a new scale.

## Necessary assumptions and useful interpretation

The given negative-rental counterexample is valid. With K10, dense per-query costs1,20 and local costs11,1, the first request triggers purchase. Online cost31 exceeds twice the all-local12. The negative second excess invalidates the step R_final>=K. This is a real hypothesis failure, not a rounding artifact.

Other explicit exclusions are also necessary: a later discounted K, unpriced root setup, a different query sequence, or an unbounded retained-state requirement changes the model. The factor two is an assurance for this one-purchase scheduling rule after concrete backend prices are justified. It is not a measured speed ratio, a sign-resolution guarantee, a globally optimal proof plan or a statement that dense work is actually selected at useful frequencies.

## Independent evidence

Owned `review_online_polyphase_switching_20261111.py`, SHA256 `B729B01B14DD9D238267352EAC1ECC89FBBA1B31E59C053D2AA6EAE647F5D422`, passed58129 exact assertions over3509 cases. It checks every stopping prefix, rational and zero rentals, K0, empty streams, large jumps, lazy setup, duplicates and a different overlapping-cache family. It imports no author program or evaluator. Its receipt `review_online_polyphase_switching_20261111.json` has SHA256 `440D02CCF9B5F2226CDC2B255BE2EA5FA3417708D25B4F52FFD0941139C702E8`.

All five pins match: the author note; author script `B4DDCBF0D9B3A155C0D921D68B43DE3978CB4FD126CCB8FB9857219F13D01FBF`; author receipt `E23E7BB25C69DB258D79C057BC259C617C204216DD9439BE8A8FED0E13AEB92A`; arithmetic predecessor `8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9`; and my accepted arithmetic review `F231302A5FBB884B4A4020E7D104264A8BEBAB9FB71D47BB45715907CE8BD01B`. The generic prefix argument above establishes the scheduling implication; finite tests are controls, not a proof by sampling.
