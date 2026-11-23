# Independent review of grouped cyclotomic certificates

2026-11-11. PASS at paper acceptance-theorem and explicit schedule scope. No correction is required to `major-constants/EFFICIENCY_GROUPED_CYCLOTOMIC_SUPPLEMENT_2026-11-11.md`, SHA256 `3429D9CEECB68030C1AE052662A75884453CBBB62993358D0B12D007BE797E58`.

The review does not establish a Lean/MM0 implementation, a successful candidate certificate, a complete ladder, runtime, or globally optimal arithmetic circuits. I read the frozen note and script, checked the earlier grouped and sum-only interfaces, independently decoded the saved circuits, and inspected the existing least-factor source consumer. No modular candidate values, prime searches, builds or analytic evaluations were run. Author files were unchanged.

## Local Fermat identity and full prime-power order

Fix n>1 odd and one group d, with every full prime-power factor assigned to that group. The leaves must be the exact powers Y_q=X^(d/q). For an even group, Y_2=-1 gives X^d=1. For an odd group with a cyclotomic leaf, the polynomial identity

    (Y_q-1) S_q(Y_q)=Y_q^q-1

and S_q(Y_q)=0 also give X^d=1. No cancellation or unit premise is needed for this implication. An odd group whose leaves are all unit tests has no such implication and must retain its separate X^d=1 check. A check for another group's root cannot discharge this obligation. The script's `needs_fermat` condition has exactly these cases.

For each prime r dividing n, X^d=1 makes X a nonzero element of the field modulo r. Let its order be t. Then t divides d. At a unit leaf, the certified inverse excludes Y_q=1 modulo r. At a cyclotomic leaf, Y_q=1 would turn S_q(Y_q)=0 into q=0 modulo r. Since q is prime, that would force r=q; the explicit q-not-dividing-n guard rules it out. Thus t does not divide d/q. In conjunction with t dividing d, this forces the complete valuation v_q(t)=v_q(d). Checking every distinct q in the group gives t=d, including repeated prime powers in d.

For the even leaf, oddness of n ensures r is odd and -1 is not 1. A singleton d=2 is exceptional because oddness alone gives 2 dividing r-1. That exception does not justify omitting a root for 2^e with e>1 or for a mixed group containing 2.

All disjoint groups imply F divides r-1. A composite n would have a prime factor with r^2<=n, contradicting r>=F+1 and n<(F+1)^2. Overlapping groups imply only the least common multiple of their orders; their product cannot be substituted. The saved partitions use disjoint full prime-power blocks.

No independent F-divides-n-1 premise is needed by this argument. It does need every cyclotomic q-exclusion. Exact candidate equations n=kF+1 are an adequate way to prove these guards. Dropping those equations requires another proof of the guards; proving n prime later cannot justify omitting them earlier. The familiar unguarded n=57, q=3 prime-power example remains a counterexample to that omission, as recorded in the predecessor review.

The existing `Ladder/Spec.lean:38` theorem implements the corresponding least-factor argument only for the power-of-two Proth case. The grouped cyclotomic theorem and its circuit semantics remain new formalization obligations. Reusing the proof pattern is not importing an existing formal proof of this stronger interface.

## One aggregate inverse and exact product descent

In the commutative ring modulo n, if V times the product of all remaining unit leaves equals 1, every factor is a unit. An inverse for one factor is V times all the other factors. Hence no separate per-group inverse is needed.

For u positive unit leaves, the exact global arithmetic is u-1 product-formation multiplications plus one multiplication checking the inverse, and u subtractions. This is u products and one inverse coordinate. Allocating one product to each unit leaf in the additive partition recurrence gives this same total; it does not charge or assume one inverse for each group. For u=0 there is no product check or inverse coordinate. The state retaining only the presence of unit leaves is sufficient because the arithmetic allocation itself is linear in their count.

For a batch modulus M, the product must equal the product of the listed odd candidates, and every leaf power must be computed modulo that actual M. The aggregate inverse descends to every factor. For a cyclotomic q, the required guard is q not dividing M, proved from all candidate predecessor equations or otherwise. The strict size inequality is applied separately to each candidate, not to M. Repetition does not defeat acceptance, but CRT production from residues modulo a repeated prime alone does not establish the required congruence modulo its higher power. The author retains that distinction.

## The m160 circuit and saved arithmetic

The sum-only recurrence is a polynomial identity. Even indices pair exponents 2j and 2j+1. Odd indices add the exponent zero and pair 2j+1 and 2j+2. Reusing the square in Y+Y^2 is necessary for the advertised count. These identities do not output Y^q; the local Fermat implication above is what makes that unused power unnecessary.

Independently charging the four stated m160 groups gives:

| Group d | Exact leaf exponents | Squares | Other products | Additions/subtractions |
|---:|---|---:|---:|---:|
|20800|10400, 4160, 1600|13|8|2|
|627|209, 57, 33|8|9|4|
|493|29, 17|8|7|2|
|4991|713, 217, 161|11|13|6|
|Total||40|37|14|

The first group obtains its Fermat identity from the negative-one leaf. The second uses S3; the fourth uses S7. The third has only unit leaves and explicitly raises the first leaf X^29 to 17, yielding X^493. Its four additional squares and one product are included. There are eight unit factors across all four groups, so their global formation and inverse check cost eight products. The witness has four root coordinates and one inverse coordinate. The four group orders multiply to the actual F for m160.

Replacing S3 and S7 in these same groups by unit tests plus Fermat powers adds four products and removes four additions/subtractions. The full comparison with the old four-root optimum also changes the partition and extraction library. Therefore attributing the entire 3-square/12-product saving to the sum-only recurrence would be incorrect; the author explicitly avoids that claim.

The independent integer script checked all 2,047 saved complement trees with an explicit stack. It reconstructed their leaf exponents and square/product costs. It then checked every selected circuit in all six families and three price projections: 384 output schedules and 2,364 group records. This included disjoint full coverage, full prime-power prepower, local Fermat requirements, method costs, unit counts, root/inverse coordinates and aggregate totals. No author module was imported or executed.

The script also reconstructed the manual circuit above and the m160 coordinate-count curve from the saved outputs:

    221, 159, 124, 93, 77, 70, 66, 62, 59, 57, 55.

These are selected-circuit consistency checks, not a separate exhaustive rerun of the partition optimizer. The optimizer's recurrence was reviewed from source as described next.

## Fixed-price projection and omitted costs

Selecting the group containing the least set bit enumerates all unordered partitions exactly once. For each such group, the script enumerates every subset of its odd primes as cyclotomic leaves. At a fixed price it keeps the best local cost for each unit-presence state. This is valid because every nontrivial group costs one root, the free parity case has fixed zero-root cost, operation counts add, and global unit presence combines by OR. The parent state also retains exact root count. No discarded higher-cost local record can improve the same fixed-price parent state.

The price and addition/square/product tie ranking is translation-invariant under adding the same future cost. The final deterministic encoding tie only selects among equal cost vectors. This establishes the optimal-substructure argument for the stated finite library and the three specific price projections.

The library does not contain every addition chain or complement tree. Its trees were selected previously at equal square/product prices, so other trees can win at new prices. Even within that library, three linear projections do not enumerate the entire nondominated cost set. The `sampled_resource_nondominated` field compares only the saved alternatives in its projection. It must not be read as full-vector Pareto optimality. The author states these limits correctly.

The 40/37/14 count excludes candidate decoding, guards, exact factor/product binding, modular reduction proofs, representation and protocol work. Additions and subtractions may have different actual proof costs. Removing an inverse coordinate changes producer work; combining component roots does not preserve old unit-leaf residues, so an old aggregate inverse cannot simply be reused. The 44-square one-coordinate Proth test remains a separate comparison on a different candidate family. No prime-availability or runtime advantage follows from the schedule counts alone.

## Pins and review output

| Artifact | SHA256 |
|---|---|
|Author supplement|3429D9CEECB68030C1AE052662A75884453CBBB62993358D0B12D007BE797E58|
|major-constants/grouped_cyclotomic_schedules_20261111.py|95BD950D8E5776106B69C8449B62185F75281636A56DF591B479F5321E1829A4|
|major-constants/grouped_cyclotomic_schedules_20261111.json|FC21AE178DD49F9923244B3D2CA6547CB31797AE695F8D4F683C8A78519E7585|
|moebius/REVIEW_CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md|E47FE2FDD2651772B7448FA9E3C05460DE3C8939787FE653CE1F43F576D3D074|
|audit/REVIEW_EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md|AB62BB505F152138A021FB9929B31E1DA5F017BFBAF61D44C681B89A73A43DD1|
|work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean|0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F|
|audit/review_grouped_cyclotomic_counts_20261111.py|33029273958E16E8317448CE06AD108605892D0F3AF4B53CFF22133E464387AB|
|audit/review_grouped_cyclotomic_counts_20261111.json|41D53A3FECCBD7D305B60B0A31BA490BA84169B29CDA51F63F95D71FA4326F13|

Agent artifact paths are relative to `work/qrh-campaign/agents`. The independent receipt also verifies the four predecessor pins stored in the author receipt. Its exact-only script exited zero. Formal proofs, actual bounded modular checking, successful production data and performance remain separate gates.
