# Binary coverage: complete residual certificates and span-normalized convolution

2026-11-11. Research design, not an implemented or measured prover. No prime computation, analytic evaluation, Lean/MM0 build or production scan was performed. This note minimizes checked work for a fixed genuine prime input; it does not assume that any prescribed anchor pool covers the target range.

## Decision and scope

Use a complete residual certificate with three interchangeable terminal checks: wide shift/OR, exact packed convolution, and explicit residual representations. Normalize a convolution's source slice by the **minimum selected anchor offset**, so its halo is the selected offset span. Permit hierarchical splitting only with an exact residual partition. This retains a wide Lean arithmetic path and a word-oriented MM0 path without changing the mathematical certificate obligation.

The earlier `work/mm0-efficient/SCOPE.md` already proposes dense-to-active loops. Those loops are not a new contribution here. The additions are the complete residual proof contract, a precise span normalization, a carry-safe residual-only packed check, a bounded search/checking ledger, and tests for when a shared prefix actually saves work. No new speed estimate is inferred from historical forecasts. In particular, the MM0 benchmark's arithmetic library is schematic and its final proposition is `ok`, not binary Goldbach.

The strongest unconditional local simplification is span normalization: for the same anchor subset and targets it never enlarges the required source slice or packed operand bounds. It may alter cache reuse; total wall time need not decrease. Hierarchy and backend selection give conditional savings governed by actual residuals and backend costs, not a theorem about prime density.

## 1. Prime meaning and complete target range

For even B let E=B/2. Choose an outer length L with 2<=L<=E. A source bit P[j]=1 has a proved interpretation `Prime(2j+1)`, for 0<=j<L+D. In particular P[0]=0. No completeness claim for P is required. Every anchor handle resolves to an already checked prime

    q_i = 2rL - (2s_i+1) >= 3,       0<=s_i<=D.

The handle includes its value and its verified certificate; an offset or hash is not such a proof. For target n=2(rL+t), the exact identity

    n = q_i + (2(t+s_i)+1)

turns a checked source bit into a representation. For a tile t=a+x of width W, use 0<=x<W and a+W<=w_r. Every read satisfies a+x+s_i<L+D. Word padding outside [0,W) must never become a required target or a usable source fact.

The outer blocks are r=1,...,floor(E/L), with w_r=min(L,E-rL+1). Separately prove the initial range 4<=n<2L. It has L-2 even targets. For R=floor(E/L), the exact total is

    (L-2)+(R-1)L+(E-RL+1)=E-1.

If L divides E, the last width is one. The initial proof can recurse to a smaller L and eventually explicit prime sums; its full cost remains in the ledger. None of this supplies the binary input as an assumption. An odd chosen B is handled by replacing it with 2 floor(B/2), explicitly.

## 2. A complete residual checker

For a tile, M_W=2^W-1 and initially R=M_W. R is the exact bitmask of targets not yet justified. Every update uses a certified anchor and the *actual* source slice

    C_i = sum_{0<=x<W} P[a+x+s_i] 2^x,
    R_new = R AND (M_W XOR C_i).

The invariant says that every bit of M_W outside R already has a prime representation, and every bit still set in R is retained as an obligation. A proof need not retain a separate representation for a bit once the sound update lemma has discharged it.

A finite certificate tree has these constructors:

* `Update(i, child)`: compute the source slice and exact residual update, then check the child.
* `Split(h, left, right)`, 0<h<W: set R_left=R mod 2^h and R_right=floor(R/2^h), and recursively check widths h,W-h at origins a,a+h. Verify the equality R=R_left+2^h R_right and both width bounds, or derive them by the proved extraction operation. The children inherit these masks; they cannot choose their own obligations.
* `Zero`: accept only after checking R=0.
* `Packed(I)`: the residual-only convolution check in section 3 discharges all remaining bits, or rejects.
* `Witnesses`: give strictly increasing indices j_1,...,j_h and prove R=sum 2^j_l. For every index check actual prime handles p_l,q_l and p_l+q_l=2(rL+a+j_l). These can be outside the source/anchor scheme. Empty lists require R=0.

Induction on this finite tree proves all W target obligations. A format may combine several updates into a wide union, but the operation is the same. Duplicate anchors waste work and are allowed unless the chosen polynomial construction explicitly assumes distinctness.

This is also a complete *coverage* algorithm conditional on supplied prime representations: explicit witnesses can represent every residual bit. It is not a proof that a search budget, 512 anchors, or any fixed D always succeeds. Lack of witnesses causes failure. Count every failed anchor search and every exceptional primality proof in production cost.

An alleged sparse list of unfinished words is not enough. It must come from scanning the computed residual, or from an exact concatenation/partition proof that every omitted word is zero. Likewise a Merkle root authenticates bytes only; it does not prove omitted obligations empty. The split constructor avoids this gap even if the producer searches arbitrarily.

## 3. Span normalization and a residual-only convolution

For a nonempty selected multiset I of m anchors, set

    u=min s_i, v=max s_i, d=v-u, e_i=s_i-u.
    Q_j=P[a+u+j],  0<=j<W+d.

Then the target bit supplied by i is Q[x+e_i]. Choose k>=1 with m<=h=2^(k-1), and b=2^k. Define

    Qpack=sum_{j<W+d} Q_j b^j,
    Apack=sum_{i in I} b^(d-e_i),
    Z=Qpack*Apack.

At exponent d+x the coefficient is exactly sum_i Q[x+e_i]. Every product coefficient, including non-target ones, is at most m<b. Thus ordinary multiplication has no carries between b-digits. This argument also handles repeated offsets if Apack includes their multiplicity. A 0/1 anchor bitmap instead requires distinct offsets.

Let

    Kall=sum_{x<W} (h-1)b^(d+x),
    Hall=sum_{x<W} h*b^(d+x),
    HR=sum_{x<W, bit(R,x)=1} h*b^(d+x).

Then the exact acceptance test is

    (Z+Kall) AND HR = HR.

Each affected digit lies between h-1 and m+h-1<=b-1. No addition carry occurs, including at the tile boundaries. Its high bit is set exactly when the target coefficient is nonzero. HR tests only obligations left in R. This is not a comparison of packed integers with a repeated-one pattern, which would be unsound. For m=512 the additive test permits k=10; the different OR/subtract trick would need a stricter bound.

For the same anchors, replacing the usual maximum offset v by d=v-u saves u source positions and 2u positions in the product-length bound. Explicit upper bit lengths are

    bits(Qpack) <= k(W+d),
    bits(Apack) <= k(d+1),
    bits(Z+Kall), bits(Hall), bits(HR) <= k(W+2d).

The last bound includes W=1,d=0 and all non-target product digits. It is a bound, not a promise that the integer uses every bit. The source interval is [a+u,a+v+W), within the original legal halo. A cache indexed by (source origin,length,k) must charge this change of origin; it cannot pretend every normalized subset shares one fixed packed source.

For incremental packed clusters, keep the residual in the same high-bit positions and radix: J=(Z+Kall) AND Hall, then HR_new=HR AND (Hall XOR J). It can be split by radix shifts. If a later backend wants ordinary binary residual words, the digit gather/decoding must be proved and charged. The cheaper terminal-only packed constructor above needs no gather. Different cluster radices require an explicit conversion; they cannot be mixed bitwise.

One can partition offsets into narrow clusters to reduce d and k, but each cluster repeats a target-width multiplication and packing work. Narrower operands do not by themselves prove a saving. Choose clustering only when its complete measured cost is below one normalized multiplication or the residual OR path.

## 4. Checked work, not just logical node counts

Let w be a machine/proof word width (64 in the examples), n=ceil(W/w), A the available anchor count, and n_j the number of nonzero residual words before the j-th sequential anchor update. Let a_v be the updates at a tree node of width W_v; let h be the number of explicit residual witnesses. Define costs separately for the target proof system S:

    X_S(W,s): certified source extraction and index/provenance access;
    O_S(W): one width-W Boolean update;
    T_S(W): proved split/zero/terminal-width work;
    M_S(p,q): exact multiplication of p- and q-bit operands;
    D_S(k,W): certified binary-to-radix dilation and residual masking;
    P_S(p): primality certificate checking for a new value p.

These costs include reduction or proof construction as appropriate; they are not unit-time oracle calls. A model for a tree is

    sum_v a_v [X_S(W_v,s)+O_S(W_v)]
      + sum_splits T_S(W_v) + sum_terminals T_S(W_v)
      + sum_packed [D_S + M_S + linear packed checks + anchor-polynomial proof]
      + sum_explicit [prime checks not already cached + source/equality/index checks].

For array implementations, one aligned word update reads at most two source words, merges the shifted pieces, and performs the masked residual update. Its total charged work is O(sum_j n_j) word operations plus discovery/compaction. A dense prefix of k updates followed by active updates costs O(kn+sum_{j>k}n_j). Compacting the active list is O(n) once and O(n_j) on each later sweep; it is not free. A scan that checks all n zero markers on every update instead costs O(An) despite its short nonzero list.

For a tree implemented with independent big integers, splitting a node may copy or shift O(ceil(W_v/w)) limbs. If every level materializes all descendants, a full depth-log n tree pays O(n log n) limb traffic in splits alone. An indexed chunk representation can avoid these copies, but then checked lookup/provenance and immutable-slice ownership replace them. Do not count both the copy and slice implementation, or omit both.

Dense wide OR pays roughly A*n limbs but only A high-level arithmetic reductions. Local selected-word certificates pay roughly sum_word m_word word updates plus selections, lookup and completion. A shared-prefix tree is not automatically better than either: it trades reused coarse arithmetic for potentially worse local anchor choices. The simplest bounded production search evaluates a fixed list of prefix lengths and split depths, reusing its exact residuals; the number of candidate plans and every evaluated update go into generation cost G. An unrestricted optimal set-cover search is not an uncharged preprocessing step.

Packed work is `M_S(k(W+d),k(d+1))+O_S(k(W+2d))+D_S`, including reads and the anchor polynomial. Schoolbook, subquadratic, or kernel multiplication costs must use the implementation actually checked. A three-operation expression does not cost three MM0 inferences. If a packed attempt fails and falls back to OR, count both attempts. A bounded policy can instead choose its backend from previously measured cost bounds without first computing both on every tile; that selection has no effect on soundness.

## 5. Exact size and break-even examples

These are integer calculations, not new prime fixtures, measured timings, or density assumptions.

At W=2^18,w=64 there are n=4096 words. A full A=512 scan has 2,097,152 word-anchor updates. For a hypothetical eight-anchor shared prefix and U unfinished words requiring eight more selected masks each, updates are 32,768+8U, before compaction, splits and lookup. It beats the historical sampled mean 11.175 masks/word only if

    32,768+8U < (447/40)*4096 = 228864/5,
    U <= 1625.

This threshold is necessary in this equal-word-operation comparison, not sufficient for a runtime saving. Nothing read here establishes that U<=1625. It warns against extrapolating dense-prefix benefits from a different fixture or from an independence model.

For W=2^18,m=512,k=10, maximum-offset packing with v=2^19 has a product bound 13,107,200 bits. If the *same selected offsets* lie in [2^19-4096,2^19], span normalization gives 2,703,360 bits, a bound ratio 160/33. The corresponding source bounds fall from 7,864,320 to 2,662,400 bits. This is a valid conditional input-size reduction even though no such prime-anchor pool has been generated in this task. Actual zero leading source bits or different multiplication implementations may change the realized ratio.

At the current exploratory B=10^16,L in {2^32,2^34,2^36}, keep D=2^19 and W=2^18 only as parameters. The existing scaling note already counts around 19 billion top-level tiles. Changing the tree or packed layout does not reduce E-1 obligations or remove the larger initial range when L increases. The reviewed source-bitmap design and prime-estimates' sieve work should determine the source term; it cannot be reused here as a cost-free array.

## 6. Proof size and system-specific acceptance

Compact tree input consists of constructor tags, split points or fixed-layout split bits, anchor IDs, exceptional prime references and their indices. With A cached anchors, an explicit selected-ID format costs sum a_v*ceil(log2(A+1)) bits, before framing. A fixed sequential schedule or compression can use fewer bytes; its schedule expansion must still be checked. Tree structure is O(number of nodes) for fixed bisections. Explicit residual witnesses add their number times target-index and prime-reference lengths, plus genuinely new prime certificates. Source and prime cache bytes are separate. Proof-generated residuals need not be serialized; serializing every intermediate mask adds sum_v W_v bits and can defeat the design.

For Lean, use a generic soundness theorem over this certificate and chunk arithmetic whose concrete equalities reduce in the kernel. Wide Boolean leaves may amortize elaboration and expression overhead. Prove source dilation and index conversion once generically, then check their concrete inputs; arbitrary packed literals are not an admissible source shortcut. Bound numerals/chunks under the actual kernel limits. One declaration per word or per top-level tile is not required: bounded batches can expose a range theorem with a checked internal tree. Import, literal decoding, reduction, and retained term memory still count.

For stock MM0, derive digit operations, array lookup, leaf discharge and range composition in the chosen foundational theory. Let e_X,e_O,e_T,e_M be actual expanded proof-event counts for the above operations. Total events are their corresponding sums, and proof bytes depend on the concrete term/reference format. The historical approximately 150 encoded bytes/update measures a schematic OR trace and cannot price a newly sound residual leaf or a large multiplication. A sound terminal must require R=0 (or the proved packed/witness alternative), unlike the historical unconstrained reset. Generic rule reuse saves proving its statement repeatedly; it does not prove a new numerical premise.

A streaming expander may avoid persistent expanded proof bytes but must still produce and check the ordinary proof steps. A specialized PA-preserving arithmetic acceptance backend is a third architecture, with its own correctness and concrete execution evidence. Do not credit stock MM0 with its native cost before supplying that bridge. Likewise no native-decide trust is silently added to Lean. The full analytic translation/library for an end-to-end MM0 Goldbach proof remains outside the binary checker and must be costed separately.

## 7. Production accounting and recommended next experiment

Use

    G_source+G_anchor+G_plan+G_exceptions
    + V_source+V_anchor+V_tree+V_exceptions+V_range
    + library build + serialization/import.

One producer can present anchor proofs to a live sound checker and retain its verified residual state while searching. That avoids a redundant final pass *inside that run*, provided every state update is already checked. An independent replay is another full checking pass. Failed searches, discarded plans and missing-witness branches remain generation work even if their bytes are not retained. Cache source segments across outer blocks; re-sieving the complete source once per outer block is not a saving. Preserve the separate certified factor cache needed by anchor certificates.

Next, after separate authorization, implement one small complete leaf-plus-parent comparison on the same immutable source and anchor proofs: wide OR; span-normalized packed terminal; residual tree with a short fixed menu of prefixes and word witnesses. Include the initial/base and final-width cases, provenance, negative controls for a dropped nonzero residual word and a misindexed halo bit, emitted/expanded proof counts, and generation plus independent verification. This would answer the controlling unknown: **how much genuine residual/provenance work remains after choosing a backend that each prover can actually check?** No present evidence warrants replacing that unknown with a new core-year headline.

## Read evidence

The source files used for this paper comparison are `work/qrh-blueprint/COMPUTE_FIRST_RESEARCH_AGENDA_2026-11-11.md`, `work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md`, `work/formal-goldbach-bench/FORECAST.md`, `work/mm0-efficient/SCOPE.md`, `work/formal-goldbach-bench/architecture.md`, `work/formal-goldbach-bench/prime-cover/PACKED_REPORT.md`, and `work/formal-goldbach-bench/mm0/REPORT.md`. Their byte hashes and the integer examples are recorded by the companion `efficiency_binary_coverage_scalars_20261111.py` and its JSON receipt. That script performs no prime or function evaluations. Historical numerical claims are attributed to those reports, not independently reproduced here. This note preserves their warnings about missing integrated primality, provenance, range assembly and the schematic MM0 library.
