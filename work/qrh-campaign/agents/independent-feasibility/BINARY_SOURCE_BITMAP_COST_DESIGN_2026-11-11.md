# Certified source-prime bitmap for sparse-anchor binary coverage

2026-11-11. Research design and exact integer size calculations. No sieve was run, no prime candidates or analytic functions were evaluated, and no Lean/MM0 implementation or build was attempted. Existing frozen artifacts are unchanged.

The source bitmap can be certified once and reused across all outer anchor blocks. Its small base-prime table can be built by a recursively certified sieve. The difficult cost is checking the large sieve execution and preserving its theorem through reuse. Native marking speed alone does not price that work. A straightforward wide-mask checker gives an implementable standard-kernel route, but its prime-by-segment work can become comparable to binary coverage at L=2^36. A proved native memory checker is another implementation with a different verification boundary, not a free substitute.

## Exact source object and sufficient theorem

Retain the root block design. Let J=L+D, D=2^19, and U=2J-1. Source bit j, for 0<=j<J, represents the odd integer n_j=2j+1. A sufficient source theorem is

`bit(source,j)=1 -> Prime(2j+1)`.

The top source set need not include every prime. It may deliberately clear additional bits, although this can make coverage harder. A proof of completeness is required for the *base-prime list used to justify sieving survivors*. These two obligations are different.

For outer block r>=1 and a certified anchor q=2rL-(2s+1), with 0<=s<=D and q>=3, target index0<=t<w_r has

`2(rL+t) = q + (2(t+s)+1)`.

Because t<=L-1 and s<=D, t+s<=J-1. No off-by-one extension to j=J is needed. A local target tile[a,b) consumes source indices[a,b+D), whose largest possible index is b+D-1. The endpoint s=D is allowed. If the source is split into chunks of T=2^18 bits, the D=2T halo requires at most three source chunks for an aligned full tile. Their raw data occupy98304 bytes. This does not include prime proofs, base lists, coverage accumulators or arithmetic temporaries.

Index0 denotes1 and must be zero. The odd bitmap does not represent2. Prove Prime(2) separately and use4=2+2 at the binary base case. The initial range4<=n<2L is still a separate recursive/direct Goldbach obligation; certifying the source primes does not certify this range. The root formula for the last outer block, including its possible width one, remains unchanged.

## Complete base primes and recursive bootstrap

Put Y=floor(sqrt(U)), certified by the integer comparisons Y^2<=U<(Y+1)^2. Require a sorted duplicate-free list P with

`p in P <-> Prime(p) and 2<=p<=Y`.

Both directions matter. If a composite survivor n has a least prime divisor p, then p<=sqrt(n)<=Y. Omitting that p from P would invalidate the survivor proof even if every listed element were prime.

Build this complete list without assuming a prime oracle:

1. To certify primes through an integer V>2, recursively certify the complete list through floor(sqrt(V)).
2. Sieve the odd indices representing numbers<=V with that list, using the exact masks below. Clear1. Prove the resulting bits are equivalent to odd primality in this finite interval.
3. Extract the sorted set bits and prepend2 when2<=V. Prove extraction membership and its index bounds.
4. Stop at V<=2 with explicit finite cases. The argument decreases because floor(sqrt(V))<V for V>2.

Exact survivor equivalence is available here: every erased number has a prime divisor and is at least p^2, hence is composite; every composite number has a least prime divisor in the complete recursive list and is erased. The top-level source may either use the exact survivor bitmap or prove its proposed bitmap is a subset. At recursive base levels use equality/exact extraction, not the weaker subset rule.

The integer chains for the three proposed source sizes are

| L | U -> Y -> subsequent bootstrap limits |
|---|---|
| 2^32 | 8590983167 -> 92687 -> 304 -> 17 -> 4 -> 2 |
| 2^34 | 34360786943 -> 185366 -> 430 -> 20 -> 4 -> 2 |
| 2^36 | 137440002047 -> 370729 -> 608 -> 24 -> 4 -> 2 |

These are integer square roots, not approximations. Their top witnesses are respectively

`92687^2=8590879969 <= U < 8591065344=92688^2`,

`185366^2=34360553956 <= U < 34360924689=185367^2`,

`370729^2=137439991441 <= U < 137440732900=370730^2`.

The odd base bitmaps need only5793,11586,23171 bytes, respectively. The extracted prime lists take more space: without using any prime-count estimate, at most(Y-1)/2 odd entries plus2, each fitting a32-bit field. They are still small relative to the source. The bounds below intentionally do not rely on a measured or presumed pi(Y).

## A segmented sieve theorem with exact progression masks

For a source segment[b,b+w), 0<w<=T, each odd base prime p has residue r_p=(p-1)/2 in index space. Its composite index progression begins at j_p=(p^2-1)/2. Compute the least j>=max(b,j_p) satisfying j congruent r_p modulo p. This uses bounded integer division with a checked quotient/remainder relation. If j>=b+w the prime contributes no marks. Otherwise put

`d=j-b`, `k=1+floor((w-1-d)/p)`.

Its exact mark mask is

`M_p = 2^d * (2^(p*k)-1)/(2^p-1)`.

The quotient is integral by the finite geometric-series identity. Its set bits are exactly d,d+p,...,d+(k-1)p, and all lie in[0,w). The endpoint p^2 is included, while p itself is not erased. For k=1 compute M_p=2^d directly, avoiding an unnecessary large denominator/power for p>w. For k>=2, p<w and p*k<w+p<=2T. Thus these particular mask construction operands have at most2T+1 bits; the final mask has at mostT bits.

Let C be the OR of all these masks and, for the segment containing j=0, the bit for1. A proposed natural-number mask B passes if it has no bits at or above w and `B AND C=0`. Every set bit of B then denotes a prime by the complete-divisor argument. For a complete recursive base bitmap, require `B=(2^w-1) XOR C` instead, with C already truncated to w bits. Clear1 only in its actual segment. Empty ranges may be skipped under an exact partition proof; they must not acquire a nonempty prime statement.

Every segment certificate carries b,w,U and a reference to the same complete base-list theorem. The global theorem checks a disjoint contiguous partition of[0,J). No selected prime or composite is accepted from a checksum or an unproved native boolean array.

### Reusing periodic patterns

The geometric quotient need not be divided afresh for every segment. For each p<=T define n=ceil(T/p) and

`G_p=(2^(p*n)-1)/(2^p-1)`.

G_p has ones at0,p,...,(n-1)p. For a segment, compute d=(r_p-b) mod p and a=clamp(j_p-b,0,w). Its mask is

`(G_p << d) AND ((2^w-1)-(2^a-1))`.

This formula handles the p^2 boundary by the lower cutoff a. It also truncates any shifted high bits. It gives the same mark set as the direct progression formula. For p>T there is at most one marked position in a segment, checked with the scalar residue and cutoff tests.

A straightforward implementation therefore has at most one wide division per cached prime pattern, followed per active prime/segment pair by two wide shifts, one subtraction, one AND and one OR, plus bounded scalar index arithmetic. One shift constructs2^a; masks for a=0 or a=w simplify. This is an upper count for this particular design, not a claim of optimality. Reading/storing/referencing the actual operands must also be charged.

Caching every G_p can itself consume O(pi(Y)*T) bits. The bound using all odd candidate indices is already large. Do not assume that this cache fits in the98304-byte streaming window. Possible choices are a bounded small-prime pattern cache with regeneration for other p, prime-group passes over resident output chunks, or a separate proved word-sieve implementation. Each changes memory or work and must be priced. Small-prime wheel pre-sieving can be shared, provided its exact residue interpretation is proved; a wheel is not a replacement for the remaining divisor checks.

## Native generation and ordinary proof checking are different algorithms

An untrusted generator can use a conventional segmented odd sieve. For each p it starts at the first odd multiple at least p^2 and the segment lower endpoint, then clears successive bits separated by p in index space. It may retain next-hit positions between segments. This generates the candidate source bitmap and the source data needed by anchor/coverage search.

A correctly proved mutable-word implementation would execute one read/modify/write per mark, plus setup, allocation and extraction. Native code alone does not prove that it visited every required divisor progression or cleared every required bit. Two concrete acceptance implementations are available:

- **Strict existing Lean kernel:** use bounded Nat bitset chunks and the progression-mask theorem. The closed arithmetic checks use natural-number shift, AND, OR, division and equality, with symbolic soundness proofs connecting them to primes. The prior architecture report documents native kernel reduction for these Nat operations. Do not encode the entire multi-gigabyte source as one numeral, or assume that a mutable native array loop receives the same reduction behavior. Organize each chunk as one internal computation, not one global declaration per mark/prime pair. Prove chunk access against an indexed representation; an inductive list lookup may be linear.
- **Ordinary MM0 proof checking:** translate the same finite-number/mask theorems to the chosen arithmetic foundation, supply concrete arithmetic proofs, and share the complete base-list result and pattern identities. A wide OR or division is not one constant-time MMB inference. Alternatively implement a word-oriented sieve trace with a proved persistent memory representation. For example a balanced tree of 64-bit words requires O(log ceil(T/64)) path work per local update, unless a separately justified checker implements memory access directly. Generic correctness lemmas do not prove the distinct concrete updates for free.

An arithmetic/word-memory accelerator can be built for either system. Its acceptance rule must imply derivability of the exact source-prime theorem, and its executable must implement that rule under the stated trust boundary. That is a new checker implementation, not the measured stock-kernel path. A proved abstract sieve plus an observed ordinary C run is insufficient to yield a standard Lean proof term or stock MMB proof. The earlier soundness/toolchain notes separate admissible rules, executable refinement and concrete acceptance evidence; their unfinished-toolchain caveats remain.

A certificate generator may stream proof templates directly into an ordinary checker. Expanded trace bytes need not be materialized on disk, but template expansion, arithmetic proof steps and memory accesses still cost work. Conversely, a compact native-checker input is not evidence that ordinary MM0 proof checking is equally compact.

## Conservative size and work model

Take T=2^18 source bits per chunk. Define P=number of odd primes<=Y. The exact count is deliberately left unevaluated. Use the conservative bound P<=Pbar=floor((Y-1)/2). Let Q=ceil(J/T), which is exact division in these cases.

| L | Source bits J | Source bytes | Chunks Q | Y bits | Pbar |
|---|---:|---:|---:|---:|---:|
| 2^32 | 4295491584 | 536936448 | 16386 | 17 | 46343 |
| 2^34 | 17180393472 | 2147549184 | 65538 | 18 | 92682 |
| 2^36 | 68720001024 | 8590000128 | 262146 | 19 | 185364 |

Source integers require34,36,38 bits respectively. Indices require33,35,37 bits. Base-prime squares, segment endpoints and scalar next-hit calculations fit64 bits if additions are guarded or proved within their stated bounds. Wider packed arithmetic is separately bounded by the chosen T. The raw source contains67117056,268443648,1073750016 64-bit words respectively. No explicit per-prime primality certificate for every positive source bit is required by this sieve design.

Let Z be the total number of ordinary sieve marking visits, counting repeated erasures by different primes. Exactly,

`Z=sum_(odd prime p<=Y) (1+floor((U-p^2)/(2p)))`.

All summands here are nonnegative because p^2<=U. A convenient bound is `Z<=J*sum_p(1/p)+P`. If Y<2^b, split the odd integers>=3 into b-1 dyadic bands. Each band's reciprocal sum is at most1/2, so `sum_p(1/p)<=(b-1)/2`. This loose elementary bound avoids any prime enumeration or analytic estimate. It yields:

| L | Q*Pbar, dense pair/setup upper bound | Z upper bound |
|---|---:|---:|
| 2^32 | 759376398 | 34363979015 |
| 2^34 | 6074192916 | 146033437194 |
| 2^36 | 48592431144 | 618480194580 |

These columns must not be added as identical-cost operations. Native segmented marking has roughly Z word updates and QP scalar setup steps if every prime is visited per chunk. Carrying next-hit positions, buckets for large p and p^2 cutoffs can reduce that setup. The periodic-mask checker has at most QP wide pair computations plus P pattern constructions; it need not execute Z single-bit clears. The two mechanisms trade scalar memory updates against arithmetic on T-bit integers.

One explicit symbolic model for a cached-pattern strict checker is

`C_source = C_bootstrap + C_extract(P,Y) + P*C_pattern(T)`

`           + Q*P*(C_scalar(38) + 5*C_wide(2T))`

`           + Q*C_subset(T) + C_chunk_index_and_assembly`.

This expression is a conservative operation-template bound, not bit complexity or seconds. Replace C_wide by the relevant shift/AND/OR/subtraction costs when pricing the actual implementation; they need not be equal. C_wide(2T) allows the phase-shift intermediate before truncation; the final mask and accumulator have at mostT bits. C_pattern includes division on at most2T+1 bits. For an ordinary PA/MM0 arithmetic library, expand those costs into its proved arithmetic algorithms, including carries, bit predicates, numeral handling and proof dispatch. For Lean, measure actual literal reduction/elaboration and memory behavior rather than treating Nat opcodes as zero cost. An uncached pattern implementation can multiply the division cost by Q.

A word-memory checker instead has a model like

`C_bootstrap + Q*P*C_start + Z*C_mark + (J/64)*C_scan + C_assembly`.

Here C_mark is a certified memory transition in the chosen implementation. It is not justified to set it equal to the observed native clear-bit instruction cost for either ordinary prover. A persistent proof representation and a proved memory accelerator give different C_mark values. Both models additionally pay output serialization, source fact references and any copies/replicas. The recursive bootstrap contributes the same formulas at the short listed limits, not another full-U pass.

## Streaming, reuse and the factor cache

There are two defensible schedules.

**Resident source:** certify the complete source once, retain its immutable chunks/theorem references, and give workers batches of outer anchor blocks. Each worker reads source tiles with their two-chunk halo and checks its block coverage. Replicating source data across workers costs memory and transport. Whether source proofs can be verified once and safely imported by all workers depends on the proof-DAG/checker interface; ordinary independent fresh processes may otherwise repeat the checks.

**Streamed source:** certify each new chunk once, retain enough adjacent chunks for[a,b+D), and process all designated outer blocks at this target tile before discarding expired chunks. Maintain a certified two-dimensional frontier or one tile frontier per outer block. Every (block,tile) pair must be covered before its source proof becomes unavailable. A fresh source pass for each small block batch loses the intended amortization. If repeated passes are necessary because anchor or accumulator state does not fit, include them explicitly.

For the three candidate L and B=1e16, the outer block counts are1164153,291038,72759. With512 anchor offsets at four bytes each, holding just all offsets requires roughly2.38GB,.596GB,.149GB, respectively, before prime proofs/metadata. This is a reason to consider batches or streamed anchor storage, not an assertion that all state fits in the98304-byte source window. An index-based block/tile schedule can keep coverage verification local; it must not silently replay all anchor certificates for every tile.

A third cache has a different contract: `FactorPrimeCache(p) -> Prime(p)`. It need not contain all primes through any bound. Preserve certified facts for the distinct factors used by anchor Pocklington/Pratt certificates, including2, even after evicting the source chunk that established them. A factor fact can be obtained from a positive certified source bit with the exact j=(p-1)/2, or from a separate certificate DAG when p>U or its source chunk was not retained. Retain a checked theorem handle/exact dependency reference, not just a value/hash asserting it was once prime. If requested factors are known only after eviction, choose a separate factored-prime certificate, a retained indexed source proof, or price a second source pass. The fixture's old cache of10304 separately Pratt-certified primes is not a complete base-prime list and cannot be silently reused as one.

Packed convolution coverage adds another reusable object: a proved dilation of each certified binary source chunk to the chosen radix. Its arithmetic and storage are additional to this binary bitmap proof. The binary sieve need not be repeated, but the digit interpretation cannot be assumed from an arbitrary expanded integer.

## Can source certification erase the larger-block savings?

Yes, with an unfortunate proof representation; the existing timings do not rule that out. The raw source grows by16 from2^32 to2^36, while the dense prime-by-chunk upper count grows by about64. The actual prime count may improve the bound, but has not been computed here. A checker performing an expensive T-bit division for every pair, retaining all intermediate proofs, or re-certifying the table for every outer block can dominate the intended savings.

At B=1e16 and512 planned anchors per outer block, moving from L=2^32 to2^34 saves447034880 nominal anchor records; moving to2^36 saves558793728. Additional raw source bits are12884901888 and64424509440 respectively. These are about28.82 and115.29 extra source bits per nominal anchor saved. They are not time ratios. Every source bit can trigger several marking visits, and every anchor has its own search/factorization/checked-primality cost.

The comparison must test the actual inequality

`Delta C_source + Delta C_initial + Delta C_coverage + Delta C_reuse/assembly`

`    < saved_anchor_count * average_complete_anchor_cost`.

C_source includes generation and checking separately unless an explicit shared computation justifies their fusion. C_initial includes the larger initial binary range. C_coverage must allow the changed prime density/anchor count. The source is independent of the outer block number and hence amortizes well only when this reuse is preserved. Across experimental candidate sizes one may certify the largest source once and reuse its prefixes; a final single-size forecast still charges the chosen source construction.

For scale perspective, the root's B=1e16 table has about19.07 billion top-level coverage tiles. The loose dense-pair bounds above range from0.76 billion to48.59 billion, and each dense pair may involve several wide operations. Thus even this coarse paper accounting is sufficient to reject the assumption that source certification is automatically negligible at the largest candidate size. It is equally insufficient to declare that it dominates: useful wheels, bucketed sparse operations, proved memory access and actual P can change the cost substantially.

## Concrete next implementation decision

Use the recursive complete-base theorem and exact progression-mask interface as the reference proof algorithm. They require no mutable-array reduction or prime oracle, support arbitrary bounded chunks, and directly prove the needed source theorem. First price one complete source-chunk proof including bootstrap provenance, all progression checks and the bit interpretation used by one real coverage tile. Test both a cached-periodic-mask arithmetic implementation and a proved word-memory implementation under separately stated Lean/MM0 acceptance boundaries. Do not compare a native mutable sieve with a stock arithmetic proof and call that a system speed ratio.

A useful failure criterion is explicit: if measured marginal complete source-proof cost plus the initial-range and coverage changes exceeds the saved complete anchor cost in the inequality above, reject that L or representation. If source proofs must be replayed per outer block, redesign the dependency/scheduling mechanism before adopting any larger L. No production computation is needed to specify these tests; none was authorized or performed here.

## Evidence pins

The prior documents establish the target layout, existing prototype limitations and alternative checker contracts. Their historical timing forecasts are not adopted by this report. SHA256 hashes follow for exact reference.

| Workspace-relative file | SHA256 |
|---|---|
| `work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md` | `982115AD458F718039B391DAEA714E25C5E80823C49B537ED78FEC8F155480CD` |
| `work/formal-goldbach-bench/architecture.md` | `81B26063AD5F60DF8CEC8B1174C2FC3DA5F8234CFB13DF746FF9BB952318D3A9` |
| `work/mm0-efficient/SCOPE.md` | `9864941BD71B90706032B21D202E3D9A5043B2E63EB9CBE699EBAA073AE8DC63` |
| `work/mm0-efficient/soundness.md` | `C967F8059920C80635238FC2955C9D4FAD55327B26B1BAB6F2746F7440661FD8` |
| `work/mm0-efficient/toolchain.md` | `68F56ECDAFC149BF2EC67B4682B24F732D2042F03D7DA610B1DCE85A72AF8C86` |
| `work/mm0-efficient/primality.md` | `003B53ABCC7C40D98B85C0735546220A55EFFBA27FCF7A7D0B09B1CCD68C226A` |
