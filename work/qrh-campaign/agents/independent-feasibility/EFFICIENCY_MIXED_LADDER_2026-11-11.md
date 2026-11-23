# Operation-level frontier for the mixed Proth ladder

2026-11-11. Proposed checker algorithms and exact scalar counts. No new ladder primes, primality tests, analytic evaluations, Lean/MM0 declarations, builds or timings were produced. Older reports are unchanged. This task optimizes the actual finite certificate algorithm rather than extending the spectral source audit.

The recommended comparison has three ordinary paths: a same-base product batch with indexed jumps, direct Proth checks for sparse singleton groups, and a product batch using one checked common base X. General-prime fallback is still needed for windows without a supplied special-form certificate. Before that fallback, permit an arbitrary-base Proth certificate: a prime missed by a fixed list of small bases does not automatically require factoring its predecessor.

No path is declared fastest. The relevant cost is a vector of squares, multiplications, reductions and proof work at their actual operand sizes, plus producer search, certificate payload and final coverage. The old55-microsecond rung measurement does not calibrate these changed algorithms.

## Fixed geometry and soundness contract

Retain F=2^45, D=F/2=2^44, N=1e27. A regular record at slot i gives t in[0,W) and p=(S*i-t)*F+1. The two shapes are

| Binary cutoff B | W | S | Last required index K |
|---|---:|---:|---:|
| 1e16 | 128 | 157 | 181029996372 |
| 2e16 | 256 | 313 | 90804183483 |

The previous exact geometry proves S>=W, `(S+W-1)*F+2<=B`, and S*K<F. Thus every regular candidate has1<=S*i-t<F and at most90 bits. A general record instead certifies any odd prime in `[(S*i-(W-1))*F+1, S*i*F+1]`. Both records give exactly the same interval-prime proposition, so the existing n=3+binary base interval and remaining ladder coverage can be retained.

For any base a, sufficient Proth evidence is gcd(a,p)=1 and

`a^(D*S*i) + a^(D*t) = 0 mod p`.

Cancellation gives `(a^(S*i-t))^D=-1 mod p`, and the original power-of-two order/minimal-divisor argument proves p prime. The checker need not import quadratic reciprocity, predict which base works, or prove p prime before using this criterion. Bounds and concrete congruences must be checked even when producer-side residue tables suggest success.

Every required slot must have exactly one accepted record. A macroblock has an exact start and length, bounded by K; ordinary groups and general records must partition its positions. Sorted group indices, a checked position bitmask or a proved permutation can enforce this. An omitted slot is never made harmless by a successful group computation. The final short macroblock has its actual length; no unchecked padding is allowed. These fixed-m45 counts do not extend unchanged beyond the S*i<F range when N is raised.

## Optimized same-base group

For a group of n selected positions `i_1<...<i_n`, possibly interspersed with other bases or general records, define

`M=product p_i`, `V=a^D mod M`, `A=V^S mod M`, `U_1=A^i_1 mod M`.

The invariant is `U_j = a^(D*S*i_j) mod M`. At a consumed position compute `v_j=V mod p_j`, `z_j=v_j^t_j mod p_j`, and require `(U_j+z_j) mod p_j=0`. Each p_j divides M by construction; pairwise coprimality is not needed. For prime small a, the group gcd check can be `M mod a !=0`, with the small prime theorem checked once.

Use an optimized binary power for each positive exponent e: bitlength(e)-1 squares and popcount(e)-1 other multiplications, beginning from its leading one instead of an accumulator multiplication by1. This changes the implementation and needs a congruence proof; it is not an exact dynamic cost claim about the old eager recursion.

For the two proposed S, popcount(S)=5, with bitlength8 or9. For arbitrary actual first position i_1, initialization therefore costs

`44 + (bitlength(S)-1) + (bitlength(i_1)-1)` modular squares,

`4 + popcount(i_1)-1` other modular multiplications.

The worst square count is88 for both shapes. A safe worst other-multiply bound is40 for B=1e16 and39 for B=2e16. The smaller old bound for aligned starts1+32j cannot be retained after arbitrary grouping. Actual costs should use the actual first index, not these maxima. A group with no ordinary positions does no product arithmetic.

Products have at most90n bits; reduced products before reduction have at most180n bits. Balanced product trees and factor-divisibility proofs permit sharing. The same V can be reduced to all p_j by a remainder tree rather than n unrelated full-size divisions; that alternative has its own tree operations and must be costed. The U_j differ, so that saving does not automatically apply to all slot-test reductions.

One small test reformulation reduces U_j modulo p_j first and checks `u_j+z_j=p_j` using90-bit operands. Under the gcd invariant both are positive and below p_j, so this is equivalent to divisibility of their sum. Even without using the converse, equality is a sufficient accepting test. It avoids adding a small offset power to a product-size U before the final division, but still pays the product-size-to-factor reduction.

## Indexed jumps instead of visiting skipped slots

Set g_j=i_(j+1)-i_j. The correct transition is

`U_(j+1) = U_j * A^g_j mod M`.

It is incorrect to multiply by A only once after skipping several original indices. Conversely, there is no mathematical need to traverse the skipped positions if this exponent identity is checked.

For an actual gap set G, build `A^(2^r) mod M` through r=floor(log2(max G)), with that many squares. For each distinct g assemble J_g=A^g using popcount(g)-1 other multiplies; powers of two use a stored value directly. Each transition then uses one multiply by J_g. Reuse J_g for repeated gaps. With no transitions there is no jump table. The resulting count is

`squares = floor(log2(max G))`,

`other multiplies = (n-1)+sum_(g in G)(popcount(g)-1)`.

The full-position alternative uses `i_n-i_1` multiplies and no jump table. A producer can choose a bounded valid schedule with the lower priced cost vector. A verifier checks every transition, so this optimization need not be a trusted heuristic. A fixed table for all possible gaps is unnecessary when actual gaps are small/repeated.

The following exact synthetic position patterns illustrate the difference. They describe operation schedules, not observed prime/base frequencies. Initialization square maxima are summed across groups at their respective modulus sizes, so totals in that column cannot be compared as equal-cost machine operations.

| Pattern in32 positions | Group sizes | Initialization-square upper total | Extra jump squares | Jump other multiplies | Trimmed full-position multiplies |
|---|---|---:|---:|---:|---:|
| all one base |32|88|0|31|31|
| alternating two bases |16,16|176|2|30|60|
| six bases cyclically |6,6,5,5,5,5|528|12|32|156|
| first30 one base, then two singletons |30,1,1|264|0|29|29|

For the six-base pattern every gap is6. Two squares build A^2,A^4 and one multiplication builds A^6 per group. This is why jumps reduce the transition work to32 multiplies plus12 squares instead of156 multiplies. The older full-block-per-base traversal would be even longer. A singleton should instead be considered for the direct check below.

## Group across a bounded macroblock, then choose batch size

A fixed group per base inside every32-slot block can create many tiny batches. A different schedule accepts H=256 or1024 consecutive slots, partitions regular records by base, sorts positions within each base, and splits each list into batches with at most m factors. Only positions, not target intervals, are reordered. General fallback records keep their original positions. The final checked partition returns results to the global slot order.

For g occupied bases and q regular slots, the number of groups is `sum_a ceil(n_a/m)`, at most `ceil(q/m)+g-1`. Gaps are bounded by H-1, so a worst jump table needs at most7 or9 squares respectively. Use the actual maximum gap for the real count. This policy has bounded state; it does not queue a rare base indefinitely until enough slots arrive.

For example, six bases cyclically occupying1024 slots form36 batches at m=32, instead of192 nonempty groups if every consecutive32-slot block is independently partitioned. The batches mostly have gap6. Their moduli are larger than those of the six-way32-slot split, so this is not a proved speedup.

An adaptive local choice of m in{8,16,32,64,128} exposes the arithmetic tradeoff:

| m | Product bit bound | All-ordinary batches at B=1e16 | At B=2e16 | Initialization-square upper totals, B=1e16 / B=2e16 |
|---:|---:|---:|---:|---:|
|8|720|22628749547|11350522936|1991329960136 /998846018368|
|16|1440|11314374774|5675261468|995664980112 /499423009184|
|32|2880|5657187387|2837630734|497832490056 /249711504592|
|64|5760|2828593694|1418815367|248916245072 /124855752296|
|128|11520|1414296847|709407684|124458122536 /62427876192|

These upper totals are88*ceil(K/m). With one base and consecutive positions the transition count is exactly K-ceil(K/m). Mixed grouping uses its actual batch starts and gaps instead. Increasing m amortizes initialization count but enlarges every product-modulus operation and temporary. An arithmetic backend with nonlinear multiplication/reduction cost need not favor the largest m. Select a batch partition by an explicit measured or symbolic operand-cost function, not by square counts alone.

## Offset powers and singleton records

For t>0, a modular binary offset routine uses floor(log2 t) squares and popcount(t)-1 multiplies modulo p; t=0 returns1 and t=1 returns v. Worst totals are6+6 for W=128 and7+7 for W=256, on90-bit residues and at most180-bit multiplication inputs/results before reduction.

The old unreduced `Nat.pow` output can reach11430 or22950 bits before its final reduction. Retaining it for t=0,1 or a small explicitly chosen cutoff is a legitimate alternative; using it indiscriminately is not automatically the cheapest operation DAG. These are different arithmetic-size vectors, not a timing proof. Precomputing offset powers modulo the entire M trades fewer repeated squares for wider operands; it must compete with cheap per-factor90-bit powers, not be assumed superior.

For one isolated regular record, test the Proth congruence directly:

`a^((S*i-t)*2^44) = -1 mod p`, with gcd(a,p)=1.

Compute a^(S*i-t) mod p and then44 squares. The first exponent is below2^45, so this needs at most88 squares in total and at most44 other multiplies, all modulo p. It needs no A, U progression or separate offset power. This is a natural candidate for singleton/very-small groups and arbitrary rare bases. It also avoids carrying a full batch initialization just to use one factor. Whether to use direct checks for n=2 or larger is a cost comparison, not a theorem from this count.

## Common-X acceptance; CRT is only a producer hint

Separate-base initialization is not logically necessary. For any product M of selected regular candidates, supply0<=X<M, require gcd(X,M)=1, and verify

`V=X^D mod M`, `A=V^S mod M`, `U_1=A^i_1 mod M`.

Use the same actual-index transitions and every ordinary slot test. For p=(S*i-t)*F+1 dividing M, the test implies

`p divides X^(D*S*i)+X^(D*t)`.

Since S*i=k+t as an equality of natural numbers, this is

`p divides X^(D*t)*((X^k)^D+1)`.

Coprimality permits cancellation. The existing `Spec.lean:38` theorem `prime_of_dvd_pow_add_one` applies with x=X^k. In elementary terms, every prime divisor ell of p is odd, x^D=-1 modulo ell, and its order is exactly2D=F, so ell>=F+1. But k<F gives p<(F+1)^2, contradicting a composite p's least prime divisor bound. This proof does not require k odd, pairwise-coprime factors in M, small per-factor bases, Jacobi symbols or CRT residue checks.

Therefore the cheapest *logical interface* has no per-factor base tags or tests `X mod p=a_p`. A producer may find small successful bases separately and construct a CRT lift X, but that construction is untrusted preparation. The final gcd and actual exponent tests are sufficient. A bad lift simply fails. The proof also remains sound if some tentative candidates share factors.

Do not omit the gcd requirement: with X=0 and t>0 both displayed powers vanish for a composite p. For example k=2 gives p=2^46+1 divisible by5, and S=1,i=3,t=1 gives the bogus zero-power test if gcd is omitted. This illustrates the generic failure; production still checks its own fixed S/W bounds. Do not replace the verified V=X^D by an arbitrary supplied V either: V=-1 with odd k would fake the later exponent relation. V is a computed or independently certified repeated-square value.

The all-general case has no M/X computation. Every regular slot retains its final test even if its base was chosen by a reliable producer. A common-X group may still skip general slots only through correctly indexed jumps. These precise requirements are independently reviewed in `audit/REVIEW_COMMON_X_PROTH_ACCEPTANCE_2026-11-11.md`, SHA256 `3F126257BAD43CE7F3827943E77F8C0A7173F91B1F1E00B491CA3EAA7D63DF13`. That is a paper/source implication, not an implementation approval.

### Default-base residual encoding

The full-X format adds up to90n bits of payload per batch. A short encoding can choose a subset of regular factors, form their product M0, and let M1 be the product of the remaining regular factors, so M=M0*M1. Supply a small a0 and0<=y<M1, reconstruct

`X=a0+M0*y`, and check X<M.

No per-factor base labels or CRT tests are needed. The subset only defines the encoding, and all factors still receive their final Proth tests. Producer search will often choose the subset whose primes accept a0, but soundness does not assume that claim.

If0<=a0<M0, the y bound implies X<M. For the intended a0=3 this follows whenever M0 contains at least one production candidate. If M0=1, that inequality is false for a0=3; switch explicitly to the full-X format or a0=0. The verifier can instead retain the direct X<M check in every branch. If M1=1, y=0 and X=a0 gives the all-default fast path.

The payload for y is at most90r bits if r factors occur in M1. It replaces a full90n-bit X. Reconstruction costs one M0*y multiplication and an addition, with direct a0 handling when y=0.

Global coprimality also admits a short split proof. Since X=a0 modulo M0,

`gcd(X,M)=1 <-> gcd(a0,M0)=1 and gcd(X,M1)=1`.

For fixed prime a0, the first check is a small-base remainder of M0. For M1>1, reduce X modulo M1 and either compute the gcd there or supply an inverse witness R1<M1. A quotient/equality proof for `(X mod M1)*R1=1+q*M1` certifies the inverse. This uses residual-size witnesses instead of a full-M inverse. For M1=1 the second coprimality condition is vacuous and needs its own branch. Exact subset-product identities are required; the mask selecting M0 must partition the regular factors with its complement. No pairwise-coprimality assumption is needed for this product-gcd equivalence.

A full-M inverse witness is another valid option, but can add90n bits even when y is short. It must not be omitted from a payload comparison. Computing the gcd avoids that input payload but has its own checked algorithm cost.

### Cost comparison with separate groups

Common-X saves duplicated initialization chains and eliminates per-factor base-residue verification, but operates modulo a larger M. Its supplied X is usually product-sized from the first square. A small fixed base begins with small powers; its early squaring operands are bounded by the growing base powers until modular reduction is needed. A common-X count of88 squares cannot be treated as equal-cost to a small-base count of88 squares.

For a simplified comparison with g equal groups and squaring cost proportional to operand_bits^alpha, separate initialization costs scale as

`g*(b*n/g)^alpha = (b*n)^alpha / g^(alpha-1)`.

For alpha>1 this arithmetic term favors narrower groups, before fixed dispatch overhead, early small powers, reductions and transitions. This is a conditional algebraic model, not an established multiplication exponent or a speed prediction. With unequal groups the corresponding sum uses their actual modulus bit lengths. A near-linear backend, expensive proof dispatch or a large number of tiny groups can change the balance.

The candidate frontier therefore contains:

- same-base groups with cached jumps;
- direct checks for isolated regular records;
- a default-base group plus separately grouped exceptions;
- one common-X batch using the residual encoding;
- a default-base group plus one common-X batch containing only exceptions.

For each common-X option add reconstruction, coprimality checking and payload; for each separate-group option add its own initialization and jump schedule at its own modulus width. The checker can accept any valid bounded plan, while the producer chooses by a cost model. Neither residue-class proportions nor a reduction in the number of chains establishes the winning plan.

## Arbitrary-base Proth before unstructured fallback

Keep base3, bases3/5, and the six small bases as producer search options. Base2 remains useless for a prime of this form, since p=1 mod8. Residue-class fractions say nothing about actual prime windows.

A regular record can also carry any a with1<a<p and the direct/shared Proth certificate. A special-form prime for which all chosen small bases are quadratic residues may still be certified this way, without a factorization library. A prime has a quadratic nonresidue, but the checker need not prove a search bound or invoke that existence theorem: it only checks the supplied arithmetic. Finding such a base and any failed searches are generator costs. Up to90 bits of base payload and full-size initial multiplication operands must be counted for this rare format.

The genuinely general branch supplies a prime anywhere in the same interval, not necessarily on the F-lattice. It remains essential if the producer supplies no valid regular certificate. No assumed prime density or statistical success rate fills a missing rung.

## Shared partial Pocklington work for general records

Retain the exact factored-divisor condition Dp|p-1 and Dp^2>p, with actual prime powers and a closed factor-prime DAG. Each distinct factor ell requires the appropriate Fermat and gcd conditions. The earlier61/62-bit full-root measurement is not a calibration for these90-bit records.

For one root, group factor conditions by the modular base actually used. For each base build its binary squaring ladder once up to the largest required exponent, at most89 squares. Reuse it for p-1 and all exponents (p-1)/ell assigned to that base. If d distinct factors use g distinct bases, the simple bound is89g squares and at most89(d+g) other multiplies, plus d gcd/inverse checks, factor products, bounds and child-prime proofs. Actual popcounts give better counts. This replaces separately recomputing a complete power for every condition; it does not make recursive factor proofs free.

Prefer factors already in a certified cache when that reduces complete checking/generation work while still satisfying Dp^2>p. The cache need only prove its entries prime, unlike a complete base-prime sieve list. Deduplicate newly required factors across the bounded macroblock/shard and prove each once in a well-founded DAG. Factors not in the cache require their own checked certificates. Do not borrow a discarded binary source chunk as an unproved primality lookup.

Modular inverse witnesses can replace a gcd algorithm where the exact congruence/Bezout criterion is proved, but add payload and multiplications. Sharing powers across different roots is not immediate because moduli and exponents change. Any larger-product batching of those powers must be separately specified and charged, just as for regular Proth records.

## Proof size, representation and the priced object

A compact certificate can contain offsets, mode/base tags, sparse exception positions, lift witnesses and general-prime DAG records. With a fixed default base, an exception mask followed by exception labels may be smaller than a three-bit base label at every slot. The actual layout cost depends on occupied positions; do not assign a savings ratio from residue tables. Macroblock-relative indices need8 or10 bits for H=256/1024, while absolute indices still need38/37 bits and exact range checks.

Two acceptance forms must remain distinct:

1. Kernel/proof computation recomputes the modular arithmetic from compact inputs. Intermediate residues need not all be serialized, but the expression evaluation, literal construction and actual DAG sharing are paid.
2. A quotient-witness trace certifies each modular multiplication by `x*y=q*M+r`,0<=r<M. For reduced x,y, q and r each fit roughly the modulus width. This can replace a division with multiplication/equality evidence but adds about one or two product-size numbers per step and corresponding arithmetic proofs. It is not necessarily cheaper for Lean or ordinary MM0.

MM0 proof templates may stream into the checker without materializing expanded bytes. Their arithmetic steps and references still must be checked. Lean's native Nat reduction can use the same algebra, but local-let sharing, kernel evaluation and proof elaboration must be demonstrated in the implemented schedule. A proved-admissible arithmetic accelerator is a separate verification implementation available in principle to either system, with its correctness/acceptance closure included.

Across independent products M there is no automatic reuse of residues V,A,U. Within a product, each should be computed once and reused. A proof-DAG implementation that accidentally normalizes V anew at every consumed rung defeats the cost model. Hierarchical range theorems should expose macroblock results rather than one global declaration per modular operation. Final composition must still check every slot and all dependency references; hashes alone are not primality or coverage proofs.

## Candidate decision model

For each actual regular group record its size n, first index i_1, distinct gap set G, offset histogram, base or common-X mode and product bit lengths. Price the explicit vector

`product construction; initialization squares/multiplies; jump table and transitions;`

`factor reductions; offset powers; gcd/base checks; common-X reconstruction/coprimality; proof/parser work`.

Add general-prime search/certification, unsuccessful regular searches, all factor dependencies, interval/partition checks and final range assembly. The aggregate fallback fraction f is insufficient to recover this vector. Two streams with the same f can have entirely different occupied-group counts, gaps and lift sizes.

The concrete first comparison should use m in{16,32,64}, H in{256,1024}, modular offsets with direct t=0/1, direct singleton checks, and the residual-lift mode as an alternative to same-base grouping. Keep m8/128 and unreduced small offsets as adjacent frontier points, not assumed winners. Select a mode only when its complete arithmetic/proof cost is lower on the same concrete record set. No new candidate search or benchmark is authorized by this paper design. The common-X simplification above supersedes the initially considered stronger CRT-residue-check interface; those checks are producer aids, not necessary acceptance conditions.

## Pins and calculations

Exact integer arithmetic produced the batch-count and position-pattern tables without iterating over the ladder or testing candidates. The generic proofs above justify their schedules; examples alone do not prove the checker. The inspected current `Check.lean:27-89` remains base3,32 consecutive positions and eager fixed-width exponentiation. `Spec.lean` supplies its modular induction and power-of-two primality mechanism, not these proposed generalized implementations.

| Workspace-relative input | SHA256 |
|---|---|
| `work/qrh-campaign/agents/independent-feasibility/MIXED_PROTH_CHECKER_COST_DESIGN_2026-11-11.md` | `78E8CB820D054DC8D1536052BBE69DA2063522A2614ACEC601E267413228D7D6` |
| `work/qrh-blueprint/MULTIBASE_PROTH_RESEARCH_2026-11-11.md` | `555DA959A4591205291DB862E1FE1FBA885545C4E3EC920D2FDF48F8A200D337` |
| `work/qrh-blueprint/HYBRID_LADDER_COST_FRONTIER_2026-11-11.md` | `AB81BBFF4BA1CC729579A365C4C3D4C4677B78164239A3AC148BE29AFFE290CB` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
