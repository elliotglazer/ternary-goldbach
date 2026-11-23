# Bounded compilation of reusable binary-cover clauses

2026-11-11. Paper algorithm and ordinary-proof representation. This supplements BINARY_SHARED_COVER_DICTIONARY, SHA2563B9747B5502C2AD7665A17EA55D2DF1357AA97D8CB874239C350DA21DD4F5E0A, without changing it. Its independent review690A464BE433097FC06CE598E0EA180808D692B78FA96D78958E49FE204B795F accepted the mathematics and qualified its cost comparison: use the same charged checking schedule, including the shorter final block, rather than subtracting unrelated upper bounds.

The new construction is deterministic and bounded. It streams source rows, maintains a capped antichain, and either emits a reusable clause certificate or returns to the existing shifted-mask checker. A successful certificate includes actual-row witnesses, so its per-block condition is equivalent to the same-palette direct coverage condition. The verifier need not trust or replay the antichain search.

No actual source-prime bitmap, anchor candidate, prime test, analytic function, transform or production range was evaluated. No Lean declaration, build or checker implementation was created. The companion script checks the finite algorithm on abstract Boolean masks only.

## 1. Exact proposition and immutable inputs

Retain the previous parameters B=2E, L>=D+2, E>=L, J=L+D, and a fixed source bit function P on[0,J). Its already checked source theorem is

    P[j]=1 implies Prime(2j+1).

Choose a sorted, distinct palette s_0,...,s_(M-1) in[0,D], with M>=1. Fix one target tile origin a and width W, with W>=1 and a+W<=L. Define its exact source rows

    H_t={i<M : P[a+t+s_i]=1},  0<=t<W.              (1)

The entire source interval lies within[0,J). The earlier source-prime theorem must be tied to these actual bits; a digest authenticates a file but does not prove this equality or primality.

A compiled certificate consists of K>=1 nonempty clauses C_j subset[0,M), an actual-row index tau_j<W for each clause, and two checked properties:

    C_j=H_(tau_j),                                  (2)
    for every t<W, some j<K has C_j subset H_t.      (3)

For a later block r>=1, let A_r subset[0,M) be the indices with supplied, checked proofs of

    Prime(q(r,s_i)), q(r,s)=2rL-(2s+1).

The reusable theorem has the exact conclusion

    [for every j<K, A_r intersects C_j]
      implies
    [for every t<W, 2(rL+a+t) is a sum of two primes]. (4)

Proof: for t use(3) to choose j, then choose i in A_r intersect C_j. The inclusion gives P[a+t+s_i]=1. The source theorem proves the first prime, the A_r theorem proves the second, and

    2(rL+a+t)=q(r,s_i)+[2(a+t+s_i)+1]

proves the sum. L>=D+2 ensures q>=3, so natural subtraction has its ordinary intended value.

Property(2) is not needed for soundness of(4), but it adds the useful exact equivalence

    [every t<W has A_r intersect H_t nonempty]
       iff [every j<K has A_r intersect C_j nonempty]. (5)

For the reverse direction use(3). For the forward direction specialize the direct condition at each tau_j and use(2). Thus compiled checking never introduces a stronger acceptance requirement than the direct checker on the same P, palette and A_r. This is equivalence of two finite coverage tests, not equivalence to all possible Goldbach representations. A failing test may be resolved by other anchors or explicit sums.

## 2. Deterministic capped compiler

The untrusted producer visits t=0,...,W-1 in order. It retains an ordered list of pairs(C,tau), initially empty. Set a nonnegative cap Kcap before the attempt.

For each actual row H_t:

1. If H_t is empty, return a blocked-row result. The palette cannot cover this tile for any A. This says nothing about other palettes or Goldbach itself.
2. If some retained C is a subset of H_t, keep the first such pair in the test order and leave the list unchanged.
3. Otherwise remove every retained C containing H_t, then append(H_t,t). Preserve the order of all surviving pairs.
4. If the list now has more than Kcap entries, abort this compression attempt. Do not silently discard an undominated clause.

On completion emit the retained pairs. Equal rows are caught by step2, so there are no duplicate clauses. A zero cap always aborts or finds a blocked row on a nonempty tile; it cannot produce a usable empty certificate.

The invariant after every completed non-aborted row is:

* every retained pair is an actual row with its correct index;
* retained clauses form an antichain under inclusion;
* every row already visited contains some retained clause.

The first property holds by construction. In step2 the new row is already dominated and older rows remain dominated. In step3 each removed clause contains the new row; therefore every previously dominated row remains dominated by that new row if its old dominator is removed. No survivor contains the new row, and step2's failure says no survivor is contained in it. This proves both antichain and domination invariants. On completion they give(2)–(3), hence(4)–(5).

An overflow does not prove that the final antichain is large. Later rows could have deleted many current clauses. The prescribed algorithm nevertheless aborts rather than spending unbounded work. It is not a minimum-clause search or an optimal compression algorithm. A separate work meter may abort earlier, with the same safe fallback.

Let b=ceil(M/w), where w is the reference bit-word width. With direct row extraction, any attempt, including an abort, has at most:

* WM source-bit reads and placements into row words;
* 2W Kcap subset tests, each scanning at most b words;
* W(Kcap+1)b word copies for survivor compaction and new-row insertion;
* Wb word initializations for fresh rows, plus O(W(Kcap+1)) loop/index operations.

These are proved loop bounds, independent of source values. Use stable in-place compaction of the clause array, retaining the new row in a separate buffer; the read cursor stays ahead of the write cursor. The active clause/row storage is then at most(Kcap+2)b words, plus clause indices, offsets and the source-access cache. A copying-list implementation may need a second clause array and must charge it instead. The source access pattern spans at most D+1 bits per row, but storing or streaming that halo is a separate cost. A full source bitmap is not included in the clause-memory figure.

An implementation may compute many rows by transposition instead, but no such improvement is needed for this bound. Each subset test and source lookup has an actual arithmetic/memory implementation cost in the chosen prover. The word counts do not make arbitrary proof-level memory access constant time.

## 3. A small certificate with independently checkable premises

Store P as bounded chunks with checked bit meaning and bounds. Store the palette once. Each C_j uses b words with zero high padding; store tau_j and optionally a sorted list of its set indices. If the list is supplied, check that it is exactly the mask's support. Nonemptiness, all indices and all source bounds are checked before using them.

The verifier independently checks(2) by extracting all M source bits at a+tau_j+s_i and comparing with C_j. This costs at most KM source-bit extractions and word assembly. Negative source bits here mean only that the fixed P does not certify the corresponding number; no compositeness inference is made.

Check(3) by a tiled exact identity. For each j form the width-W mask

    I_j[t]=AND_(i in C_j) P[a+t+s_i].

Then check

    OR_(j<K) I_j = all W bits.                      (6)

Use the existing proved source-extraction and Boolean lemmas, with the exact last-word mask. No list of one witness per target is needed. No assertion that the supplied clauses are minimal is needed either. Equality(2) and identity(6) suffice even if the producer was implemented differently or performed no antichain search at all.

A streaming verifier can compute(6) one target word at a time: initialize an outer union word to zero; for each clause initialize an intersection word to the target mask; AND the extracted source words for its set indices; OR this result into the union; finally compare with the target mask. This uses two word accumulators in addition to the clause data and source-access buffer. It does not require storing KW intermediate bits.

Write Q=ceil(W/w) and Csum=sum_j |C_j|. This particular premise checker performs at most QCsum shifted source-word extractions, QCsum ANDs, QK ORs and Q final equalities, plus the KM individual bit extractions for(2), padding/indices and clause-support decoding. A shifted source word uses at most two adjacent source chunks if those chunks have width w, with separately charged access, shifts and joining. All index arithmetic uses proved natural bounds or an explicitly verified bounded-integer implementation.

The ordinary proof representation has three layers:

* prove the generic finite-bitset theorem(4)–(5), source extraction rules and tiled assembly once;
* for each compiled tile, supply ordinary proofs of its concrete chunk calculations, row equalities and(6), obtaining one theorem universally quantified over r and A;
* for a block, supply its actual anchor-primality proofs and concrete K nonempty-intersection checks, then specialize the tile theorem.

In unchanged Lean, the concrete calculations can use supported kernel arithmetic/bit operations with explicit correctness lemmas. The compiled theorem must be shared as a theorem, not unfolded into every later proof. In ordinary MM0, the concrete word calculations need arithmetic derivations accepted by the chosen foundation and stock verifier; later blocks reference the already checked tile theorem. A checked generic algorithm plus an unverified native execution is not this artifact. This report supplies the proposition and circuit structure, not implemented proof generators.

An index in the serialized dictionary resolves only to a theorem already checked in the current proof environment. A file hash is not a proof handle. Parallel fresh checker processes may each have to check or import the compiled premises; if they repeat that work P times, charge P copies, not one. Streaming proof generation can reduce resident storage but does not erase ordinary arithmetic proof construction or checking.

## 4. Per-block evaluation and complete fallback

For block r, a supplied availability mask A contains only indices with checked prime certificates. It may omit other prime anchors. Build its positive-index theorem from those certificates once; reuse each prime fact across all clauses. Mask bits at or above M are zero. The fixed per-block clause circuit checks C_j AND A is nonzero for all j. It needs at most Kb word ANDs and Kb reductions/nonzero checks under a fixed full-scan schedule, plus indexing and theorem applications.

A sparse alternative gives one index i_j per clause, checks its membership in C_j and A, and reuses the indexed prime fact. This has K selected-membership checks rather than a mandatory M-bit intersection scan. Charge the index proofs and lookup structure. The cheaper representation depends on real proof costs and is not prescribed without measurement.

If no clause certificate is emitted, the final artifact uses the old shifted-mask checker. If a clause check fails for an honestly compiled certificate, (5) shows that the same A would also fail direct coverage. The producer must then add certified anchors, use a different palette, or provide the prior complete residual/witness proof. It must not label the uncovered tile irrelevant or drop it. If A changes within the palette, the same compiled theorem remains valid; it is universally quantified over A.

Each target tile has exactly one selected acceptance branch. The manifest verifies a contiguous, nonoverlapping partition of[0,w_r) for every outer block. The previous initial range4<=n<2L remains present, with4=2+2 at the eventual base case. All outer blocks through floor(E/L) are included, even when the last width is1.

A compiled full tile may be restricted to a shorter final tile by its theorem. The cost comparison must still use the direct checker's actual shorter width. It is also valid to select the direct branch for that last tile. No automatic saving is credited for checking unnecessary targets beyond B.

## 5. Bounded work relative to a fixed direct schedule

The comparison is with a specified complete shifted-mask proof schedule for the same P, palette and certified A in each tile instance. It is not a lower bound on every possible direct checker, and it does not assume a full M-anchor scan when the comparator uses only a=|A| anchors or stops on a proved zero residual.

Fix the backend's charged costs for source access, bit/word arithmetic, proof construction/checking, indexing and theorem specialization. These may be symbolic nonnegative prices. Let D_i be the exact charge of the selected direct schedule on instance i, including its true final width. Let E_i be the corresponding clause-branch charge, including its actual representation and specialization. Shared anchor-primality/source-theorem costs common to both are tracked separately. Let C be the one-time ordinary-proof charge for checking the compiled premises, including their representation and lookup setup.

After obtaining a proposed clause family, choose the clause branch only for instances in a set S where E_i<=D_i, and require the amortization guard

    C <= sum_(i in S)(D_i-E_i).                      (7)

Then the complete charged coverage work satisfies the exact algebraic bound

    C+sum_(i in S) E_i+sum_(i notin S) D_i
       <=sum_i D_i.                                 (8)

This proves a no-increase result for that fixed charged model. If C is an upper charge, use it on the left; D_i must remain the charge of the specified comparator, not an unrelated upper bound later presented as actual saved time. For P independent proof-environment copies replace C by PC. No hardware, Lean/MM0 ratio or bit-complexity result follows without correct backend prices. A componentwise cost-vector guard is possible where it holds; otherwise the scalar price assumptions must be stated.

The guard can be checked before emitting the large concrete compiled proof, using the known clause supports and selected proof circuit. A verifier must still check all emitted premises. Supplying false equations cannot buy an accepted result. Metadata decisions and any extra indexing overhead belong in C or E_i, so they are not omitted from(8).

Producer work has a different account. Choose an independent cap G on compiler operations and abort when it is reached. For the antichain implementation, the bounds in section2 give a deterministic G from W,M,Kcap; a stricter dynamic meter is also permitted. If compilation fails or(7) fails, emit only the original direct proof. The additional producer attempt costs at most G, plus explicitly bounded cost analysis and decoding. This does not claim G is negligible or smaller than the direct producer's cost. A portfolio attempting many palettes must allocate caps whose sum is bounded; restarting with unlimited caps defeats the guarantee.

If exploratory compiled-premise proofs are generated or checked before the cost decision, add their entire cost to the producer-attempt account. They do not disappear because the final artifact uses a fallback. Conversely an aborted untrusted row search need not be replayed by the final ordinary proof checker, whose artifact contains only the selected direct or compiled branch.

No useful compressed instance is guaranteed. On overflow the method degenerates safely to old checking with bounded extra producer work. On success but no amortization it does the same. When(7) holds, the ordinary verification saving is certified within the stated schedule/prices, while all anchor and source proof work remains exposed. This is stronger than assuming a small clause family exists, but weaker than a measured end-to-end speedup.

## 6. Known limitations and evidence

The previous report's wheel and CRT limitations still apply. A fixed palette need not supply any valid cover for a finite block; infinitely many outer block numbers are completely obstructed for every fixed palette. Compression cannot manufacture a prime anchor. A capped antichain may abort even when a different source-row order, a larger transient list or a non-exact sufficient family would compress well. Those are separate algorithms with separate cost bounds.

The companion bounded_clause_compiler_20261111.py/json perform3238 checks on abstract six-bit sources, four target rows and caps0 through4. They check the invariant, row witnesses, the tiled intersection-union identity, equivalence for every availability mask, and the stated comparison/copy bounds. Of320 abstract attempts,121 finish,82 find a blocked row and117 hit the cap. These are exhaustive toy Boolean counts, not information about real prime data or production success.

The receipt pins the previous report and review, BINARY_SOURCE_BITMAP_COST_DESIGN4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA and EFFICIENCY_BINARY_COVERAGE EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436. Source primality, actual arithmetic proof generation, concrete reusable theorem implementation and end-to-end backend prices remain unimplemented here. The new result is a precise bounded compiler, independently checkable certificate and cost guard, with a complete fallback.
