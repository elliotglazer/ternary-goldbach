# Grouped order-root certificates and exact schedule tradeoffs

2026-11-11. Paper soundness and finite integer exponent-schedule arithmetic. No candidate primality, prime/L-function evaluation, search, Lean/MM0 build or proof generation ran. The output is a deterministic acceptance and cost framework, not a successful ladder or a time-optimal implementation.

## 1. Generic criterion and the redundant predecessor-divisibility check

Let n>1 be odd. Let d_1,...,d_s be positive integers with proved prime factorizations and let F=lcm(d_1,...,d_s). Assume

    n<(F+1)^2.                                      (1)

For each d_j>1 supply x_j and prove

    x_j^d_j = 1 mod n,
    gcd(x_j^(d_j/q)-1,n)=1 for every prime q|d_j.    (2)

Then n is prime. To prove this, take any prime r|n. The first congruence makes x_j a unit modulo r and gives order_r(x_j)|d_j. If that order were a proper divisor of d_j, some prime q would have its q-adic exponent smaller, making the order divide d_j/q. This contradicts the corresponding unit condition. Thus order_r(x_j)=d_j. Each d_j divides r-1, so F divides r-1 and r>=F+1. A composite n has a prime divisor r with r^2<=n, contrary to (1).

The witnesses may differ across groups. No single common element of order F is needed. Overlapping groups contribute an lcm, not a product with repeated factors. The useful partition case makes the full prime powers Q_i=q_i^e_i atomic, puts each in exactly one group, and takes d_j as the product of its assigned Q_i. These d_j are pairwise coprime and their lcm is F.

No assumption F|(n-1) is used by this acceptance theorem. After primality has been proved, apply the same order argument with r=n to derive F|(n-1). It may still be checked as producer layout or provenance, for example when reconstructing n=kF+1. Removing it from the mathematical criterion does not create prime candidates in new residue classes: successful accepted n automatically satisfy it.

The strict bound in (1) is essential to the stated least-factor proof. The current portfolio has n<N<F^2, which is stronger. A factorization of F must be proved; an arbitrary list of purported small primes is not sufficient.

## 2. Negative-one and parity cases

For a group with even order d, replace its Fermat congruence and q=2 unit test by

    x^(d/2)=-1 mod n.                               (3)

Squaring proves x^d=1, and x^(d/2)-1=-2 is a unit because n is odd. All odd-q unit tests in that group remain. The explicit oddness guard cannot be dropped merely because F|(n-1) is no longer checked.

If the full 2-primary factor is exactly 2, a singleton group {2} needs no supplied root or modular operation: every prime r|n is odd, so 2|r-1. This group has zero root coordinates in the cost model. A larger group containing 2 may still be useful because (3) saves its Fermat computation. If the full factor is 2^e with e>1, oddness supplies only one factor of 2 and does not replace the required order-2^e root.

Empty groups are discarded. Order-one groups add no information. These conventions avoid zero or negative unit-product counts in degenerate cases.

## 3. Whole-product acceptance and one aggregate inverse

Let M be the exact product of a nonempty batch of odd candidates n_h satisfying their individual strict bound (1). For each group supply 0<=X_j<M and check (2), or (3), modulo M. Every checked congruence and unit descends to each n_h, so the preceding proof certifies every candidate. No pairwise-coprimality premise is needed for soundness.

Collect all required odd-q differences across all groups as residues z_1,...,z_v modulo M. Their simultaneous unit conditions are equivalent to the single checked inverse

    (product z_i)*V = 1 mod M.                      (4)

If the product is a unit, each factor is a unit; conversely a product of units is a unit. For v>=1, forming it takes v-1 modular multiplications and checking (4) takes one more. Thus the counted bill is v products and one inverse coordinate. If v=0, omit the inverse and its product entirely. Residue subtraction/normalization, range comparisons and the actual modular arithmetic proofs remain separate work.

For the eleven-prime portfolio below, v=10 for every partition. The q=2 test is handled by (3) or free parity, and each odd prime appears in exactly one group. Therefore every proposed partition uses one aggregate inverse coordinate, not one inverse per root group. If the verifier computes gcds itself instead, it has a different cost and payload schedule; that variant is not silently assigned zero cost here.

The producer can obtain each group component modulo each actual prime, then CRT it across the distinct candidates. It need not exhibit the generating base in the accepted certificate. The increasing ladder supplies distinct primes in intended data. CRT only modulo primes does not justify a repeated prime-power product; either deduplicate or produce actual lifts. The verifier always checks the full product identity (4) and the full root congruences, so a failed lift rejects.

## 4. Two explicit exact exponent schedules

Define the leading-one binary exponentiation cost for integer e>=1 by

    P(e)=(floor(log2 e), popcount(e)-1),

counting squares and other modular products separately. P(1)=(0,0). These are finite integer bit functions, not evaluated real logarithms. The input base is the seed; there is no fictitious multiplication by 1.

For a group of order d, let R be its radical and t=d/R. The schedule candidates are:

**Shared binary ladder.** Required exponents are d/q for all q in the group, together with d if the group is odd. For an even group, its d/2 output is the negative-one check. Form the common powers X^(2^k) through the largest required exponent. Assemble each distinct output from its set bits. The cost is

    floor(log2(max E)) squares,
    sum_(e in E)(popcount(e)-1) other products.      (5)

Exponent 1 reuses X. Distinct requested outputs are computed once. This is an exact upper schedule, without a claim of optimal addition chains.

**Prime-power prepower and complement tree.** First form Y=X^t. Compare binary exponentiation with the chain that raises successively to each q exactly e_q-1 times. The latter costs sum_q (e_q-1)*P(q), and its exact exponent is the product t. Use the cheaper sum-of-operations choice, with a deterministic tie rule.

For the distinct primes in a set S, a complement tree produces every Y^(R/q). At a node split S into nonempty disjoint A,C. Raise its input to rad(C) for the A child and to rad(A) for the C child. Induction proves each leaf exponent is the product of all primes outside that leaf, so its value is X^(d/q). Node cost is P(rad A)+P(rad C). A singleton needs no tree operation. For an odd group obtain X^d by raising any one completed q leaf to q; choose the cheapest P(q). For an even group no final Fermat power is needed, by (3).

The script minimizes the sum of squares and products over all binary complement trees for each prime subset. It compares this result with (5), and records both costs and the chosen method. Every tree split and every requested exponent is saved. These are exponent identities only; no modular value was calculated.

The singleton odd prime-power group recovers the factor-specific construction: form y=X^(q^(e-1)), prove y^q=1 and y-1 a unit. The two schedules also compare direct powering with repeated q-power formation. The singleton 2-primary group checks its negative-one leaf, subject to the free-parity case above.

## 5. Deterministic partition optimization and Pareto scope

Use the fixed certified primes

    2,3,5,7,11,13,17,19,23,29,31,
    P=200560490130,
    F=mP, m in {160,162,165,168,175,180}.

Each of the eleven full prime powers is represented by one bit. For a nonempty mask A, let G(A) be its available group cost vectors (root coordinates, squares, products). A complete vector Pareto recurrence is

    D(empty)={(0,0,0)},
    D(S)=Pareto union [G(A)+D(S\A)],                (6)

where A ranges over nonempty subsets of S containing its least set bit. This visits each set partition without order duplication. Pareto deletion is coordinatewise: discard a vector only if another has no larger component and a strictly smaller one. Equal vectors may retain a canonical witness. Add the aggregate-unit bill after partitioning. Keeping multiple tree/prepower choices in G gives the full vector frontier within the chosen schedule library. It is not a proof of optimality among arbitrary circuits.

The present receipt computes a bounded projection of (6): for each exact root count, minimize squares+products within the two schedules above. It keeps a deterministic tie-break by squares, products and masks. It does not claim to have computed the entire three-dimensional frontier. This distinction matters if a modular square and a general product have different prices.

The exact equal-weight totals below include ten aggregate-unit products. One inverse coordinate is required in addition to the displayed root count.

| m | 1 root | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|160|184|130|106|92|86|81|78|75|72|70|70|
|162|185|128|107|93|86|81|78|75|73|71|71|
|165|182|132|108|94|87|82|79|76|73|72|omitted|
|168|185|128|107|94|86|82|78|75|73|71|71|
|175|182|132|106|96|88|84|80|77|74|72|omitted|
|180|185|131|107|94|87|82|79|76|73|71|71|

For m=165 and 175 the full 2-part is 2, so a singleton parity group has no root. An eleven-coordinate version only adds a needless parity witness and is omitted. For the other rows, the eleven-root point is dominated in this two-coordinate projection by ten roots with the same total operation count.

For m=160, full powers are {64,3,25,7,11,13,17,19,23,29,31}. Some selected witnesses are:

| Root count | Blocks of prime powers | Squares | Other exponent products | Total with units |
|---:|---|---:|---:|---:|
|1|all eleven|128|46|184|
|2|{64,17,19,23,29}; {3,25,7,11,13,31}|68|52|130|
|4|{17,19}; {3,7,23}; {25,29}; {64,11,13,31}|43|39|92|
|6|{11}; {25,13}; {17,19}; {7,23}; {64,29}; {3,31}|41|30|81|
|10|{64,31}, and the other nine singletons|38|22|70|

The one-root costs differ slightly from the earlier single chosen complement-tree schedule for some m because this library also compares shared binary ladders and the prime-power prepower chain. The earlier schedule remains valid; no frozen report is changed.

## 6. What these counts do and do not optimize

All operations for a whole-product batch occur at its actual modulus width. For n candidates below 2^90, each root and the aggregate inverse use at most 90n bits. With r roots, the coordinate allocation is at most (r+1)*90n bits, before tighter actual bit lengths. Candidate positions/tags, range checks, product construction, residue subtraction, reductions and arithmetic proof witnesses are additional.

More roots can halve the counted modular operations while increasing the coordinate payload and generator work severalfold. The companion payload note gives a CRT schedule sharing its n-1 internal modulus inversions across coordinates, but each extra coordinate still needs its own modular and lifting products. Direct per-candidate order roots avoid whole-product CRT and operate at narrower widths. A producer can also retain successful prime-power components from different trials, but its success rate and screening cost are a separate investigation.

For illustration only, assigning price 1 to each counted modular operation and lambda to each coordinate gives m=160 the objective C_r+lambda*(r+1). At lambda=10, four roots give 142 units; at lambda=4, six roots give 109; at lambda=1, ten roots give 81. At lambda>54, one root minimizes this particular finite projection. These are exact comparisons in an explicitly chosen artificial objective. They do not calibrate lambda, identify a fastest implementation or account for root-generation difficulty. If squares and products have distinct costs, use the full vectors and recurrence (6), not these totals.

An ordinary-MM0 backend must pay for the actual multiplication and quotient/remainder proofs; a native modular result is not an axiom. Lean elaboration, kernel evaluation, source certificate generation, CRT construction and MM0 proof generation/verification can favor different points. A common-root count at a wide modulus cannot be compared directly with the same count of narrow operations. No throughput forecast follows from the table.

Cyclotomic geometric-sum checks are a possible further schedule family but are not included here. In particular no unproved replacement of a root/unit test by a cheaper sum is counted in the receipt.

## 7. Proof and evidence boundary

The mathematical criterion extends the least-prime-factor mechanism already present in `TernaryGoldbach/Ladder/Spec.lean:38`. The power-of-two source theorem does not by itself implement the general prime-power/group order proof. The latter needs standard finite-field order divisibility, exact factorization/lcm lemmas and the concrete congruence/unit proofs. These are new eventual library obligations, not extra final assumptions. Candidate n=kF+1 remains a useful producer encoding; its equality and the actual ladder gaps must still be checked if that encoding is used.

The script uses only integer factor extraction against the fixed eleven primes, bit counts, finite masks, exact exponent multiplication identities and dynamic programming. It performs no primality tests, including on candidate numbers. The eleven fixed prime facts are inherited from the portfolio's separately certified factors. Its execution produced only a schedule receipt.

| Artifact | SHA256 |
|---|---|
| `major-constants/grouped_order_root_schedules_20261111.py` | `45E7C08123A9B8B4A892C12BD40622551778DB41C2D5990DDD4B91E48EE73DF8` |
| `major-constants/grouped_order_root_schedules_20261111.json` | `C0E1AAAC2EF8D90CAA841288ACCD5B3938DB981D3C3F3F3AC010CE37B1225BFC` |
| `major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md` | `77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785` |
| `audit/REVIEW_EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md` | `18EA39FC8F4142FFE4091FA3D542F4BBD43DB7A1DDB03B33246E06438E285B37` |
| `prime-estimates/SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md` | `5C49B39D44D432A71F7A5F45E924F6C76E9E173666DB6301EF0469F1AAD5F59A` |
| `prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md` | `EA13551BB8A8C572F983A26EC57E4F3FCD3E658F86DCE8252BABF70002814044` |

Artifact paths are under `work/qrh-campaign/agents`. The source criterion `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` has SHA256 `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F`. Source inspection and exact schedule arithmetic do not claim target elaboration or a completed prime-chain certificate.
