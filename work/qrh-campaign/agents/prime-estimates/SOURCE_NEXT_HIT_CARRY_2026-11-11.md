# Certified next-hit carry for source-word streams

2026-11-11. Paper proof, scalar circuit bounds and abstract recurrence tests only. No primes, source bitmap, real sieve streams, analytic values or builds were produced. The complete-base and word-stream acceptance contracts remain unchanged. This is a successor header construction, not an implemented checker or a measured saving.

The next required progression hit can be carried between consecutive chunks. Its invariant eliminates repeated certification of the first congruent hit. An active transition needs one narrow count-times-prime product, additions and comparisons. An empty transition retains the pointer. Exact immutable state linkage is essential: a locally valid transition alone can omit a hit if its starting pointer is untrusted.

The comparison below does not subtract the new bound from the previous four-division upper allowance and call that a saving. A stronger fresh-header comparator can already use quotient witnesses without executing division. Against that specified comparator, the carried state removes one wider first-hit product and its range checks, but adds state-vector construction, proof linkage and transport. The net advantage remains conditional.

## 1. Complete progression invariant

Use the accepted geometry J=L+2^19, U=2J-1, T=2^18 and a gap-free consecutive partition

    0=b_0<e_0=b_1<e_1=...<e_(Q-1)=J,
    0<e_i-b_i<=T.

The complete sorted odd-prime list is the odd part of the already required list of all primes through floor(sqrt U). Prime2 is handled separately. For each listed p>=3, put

    j_p=(p^2-1)/2,
    Prog_p={j_p+k*p : k is a natural number}.

At chunk start b, retain n_p with the exact proposition

    n_p is the least member of Prog_p which is >=b.       (1)

This includes progression membership, not just a numerical lower bound. An equivalent finite characterization is n_p=j_p+k*p, n_p>=b, and either k=0 or j_p+(k-1)p<b. The counter k need not be serialized: the generic transition theorem can preserve this existential characterization. It does not require a growing quotient to be recomputed numerically at each chunk.

Initialize n_p=j_p at b=0, with the exact cached prime-square identity. This is the least progression element. The old prime metadata already required p^2 and its p^2 cutoff. A fair comparison retains the same checked p,j_p facts and their lifetime on both sides; it does not count repeated old square calculations as a necessary cost.

## 2. Empty and active transitions

If n_p>=e, emit the proved empty stream and set n'_p=n_p. By(1), no progression hit lies in[b,e). Every earlier progression element is below b, hence below e, so the same pointer is least at or above e. Equality n_p=e is correctly empty in the old chunk and will be included at the start of the next nonempty chunk.

If n_p<e, supply an integer H>=1 and check

    n'_p=n_p+H*p,
    e<=n'_p<e+p.                                      (2)

Then exactly the H hits

    n_p,n_p+p,...,n_p+(H-1)p

lie in[b,e). Indeed the last is n'_p-p<e, and every earlier one is at least n_p>=b. A progression element in[b,e) cannot precede n_p by(1), and the next after the displayed sequence is n'_p>=e. The same argument proves that n'_p is the least member of Prog_p at or above e, so it establishes the next invariant.

The strict upper endpoint in(2) is necessary. Allowing n'_p=e+p would skip a required next hit at e. The inequalities admit a unique H, namely ceil((e-n_p)/p), but acceptance uses the product and inequalities rather than executing division. The generator must still discover and provide H or derive it while generating the stream. No generator division or search is assumed free.

For the existing leaf interface, define last=n'_p-p. Since H>=1, n'_p>=n_p+p>=p; the subtraction has no underflow. The first hit, H, last and terminal condition last<e<=last+p are exactly the old exhaustive header. The sparse grouping and optional dense stream therefore consume the same mathematical header and produce the same canonical stream. No hit, OR, merge record or downstream zero-bit check is removed by the carry proof.

At a p^2 boundary, j_p=b is included immediately. If j_p=e it remains the empty chunk's next pointer and is included in the following chunk. At the final endpoint e=J, the output pointer proves that every required progression hit below J has been consumed. No hit at J is introduced into the source. Short final chunks use the same argument. The separate mark for1 remains only in the chunk beginning at0.

## 3. The immutable vector is part of acceptance

Fix the exact complete prime list P_list. A state is an immutable list N of next pointers, related to P_list by an elementwise invariant whose ith proposition is(1) for that very prime and the common chunk start. It includes exact length and ordering. A chunk step traverses P_list and N together. Each cons case binds the actual prime, its actual pointer, the emitted leaf stream and its successor pointer. The recursive result supplies the remaining successor list and leaf list. Missing, duplicated or permuted prime entries cannot be accepted merely because the resulting pointer numbers happen to satisfy local inequalities.

The initial list is constructed from the exact j_p metadata. The next chunk consumes the exact successor list proved by the previous chunk, with b_next=e. The source partition theorem supplies this boundary equality. Its state is not an arbitrary newly supplied list or an unproved native array. Final assembly consumes the postcondition at J for every prime.

For example, with the abstract progression parameter p=3, j_p=4, b=0 and e=10, the false initial pointer7 and H=1 satisfy the local checks n'=10 and10<=n'<13. They omit index4. Initialization and exact state linkage reject that example. A hash of a claimed earlier state cannot replace these dependencies.

Use a sequential immutable-list traversal, as in the reviewed word-stream scheme. The conservative schedule reads one state entry and constructs one successor-state cons cell per prime/chunk pair, including empty cases. It also applies a bounded-arity transition/elementwise-invariant lemma per pair. Reusing the numeric pointer in an empty case does not by itself remove its new list node or proof binding. Sharing an unchanged suffix is a possible separate optimization requiring its own checked equality.

The proposed Boolean/list encodings, selectors and natural interpretation still need conservative definitions and proved lemmas over the chosen arithmetic foundation. Constant-arity MM0 term access alone is not that proof. Literal tails and exact local theorem references can support the schedule only when their semantics, packing and concrete context lifetime are established. No constructor axiom, unverified memory oracle or free large-numeral interpretation is introduced here.

## 4. Exact capacities before cancellation

For an active chunk, the unique H satisfies

    H<=ceil((e-b)/p)<=ceil(T/3)=87382<2^17.

Thus a17-bit H field is complete for valid headers; H>=1 is checked explicitly. For the three selected L, the prime and global pointer capacities are:

|L|Y|Prime bits f|Pointer bits g|Raw H*p bits|Raw n+H*p bits|
|---:|---:|---:|---:|---:|---:|
|2^32|92687|17|33|34|35|
|2^34|185366|18|35|35|36|
|2^36|370729|19|37|36|38|

Here J+Y<2^g is checked exactly. Every accepted successor is less than e+p<=J+Y, and the initial j_p is less than J because p<=sqrt U. However the raw multiplication and addition checks use the larger capacities shown, before the successor inequalities are established. In particular the L2^32 raw sum is35 bits, not merely the accepted33-bit pointer width. The e+p addition uses g+1 bits and is compared after zero-extension to the raw-sum width w=max(g,17+f)+1.

After(2), H*p=n'_p-n_p<T+p<=T+Y<2^20. This is a proved accepted-result bound, not permission to perform the initial product in20 bits. Similarly n'_p can be repacked to g bits only after the range proof. The raw result, extraction and equality proofs remain part of the record.

The last pointer and local endpoint offsets n_p-b and last-b are valid g-bit nonnegative subtractions. Their accepted local offsets are less than T and thus fit18 bits. Word labels and bit remainders follow by exact binary splitting, with the same12-bit valid labels and13-bit terminal counts as before. No padding or splitting interpretation is treated as free proof work.

## 5. A complete named arithmetic schedule

Use the word-stream report's Boolean gate schedule. Addition A(n)=5n, subtraction S(n)=6n+1, comparison C(n)=7n, and restoring division D(n)=n*(16(n+1)+1). For an a-by-b product, choose the smaller factor as the row count and use

    M(a,b)=ab+5 min(a,b)(a+b).                          (3)

The first term constructs all partial-product ANDs, and the second adds all rows at their full a+b width. This is a sufficient fixed circuit, not a free word multiplication. Ground truth-table proofs and all representation bridges remain required.

An empty pair checks n_p>=e using C(g), then binds an empty leaf and the unchanged successor value. An active pair uses the following arithmetic operations:

- C(g) for the branch n_p<e and C(17) for H>=1;
- M(17,f) for H*p;
- A(w) for n_p+H*p and A(g+1) for e+p;
- two C(w) comparisons for e<=n'_p<e+p;
- S(g) for last=n'_p-p;
- two S(g) operations for the first and last local offsets.

The first and last offsets expose the same leaf address interface on both sides of the comparison. Sparse per-hit increments, grouping, masks and all merges are unchanged and separately charged. A sparser header could avoid some endpoint work, but that is not the compared schedule here.

For the dense p<64 option, write n_p-b=64u0+t0. Then t0 has the correct congruence relative to the start of its word, and the initial phase is rho=t0 mod p. A6-bit division costs D(6)=678 gates. The phase step64 mod p can be checked with a7-bit division costing903 gates once per retained p/cache lifetime; its reuse must be real. The original dense word loop and its phase updates, lookups and clips remain charged. The same setup is needed by a fresh constructor using these endpoint adapters.

The resulting declared header arithmetic bounds are:

|L|Empty pair|Active sparse header|Active dense header|
|---:|---:|---:|---:|
|2^32|231|4961|5639|
|2^34|245|5142|5820|
|2^36|259|5342|6020|

These are Boolean gate bounds, not complete MMB instruction or Lean reduction counts. The operation list specifies which input/output words, range witnesses and flags must be bound. It includes the last-hit and local-offset arithmetic that would be omitted by counting only H*p. Bit splitting, accepted-width repacking, field decoding, fixed-arity transition lemmas, term construction, references, prime/state-list traversal and serialized proof commands remain separate named costs. They are bounded local routines on the displayed capacities, not a native-memory C_mark assumption.

No extra equality gate is hidden for an arbitrary successor: n'_p is the actual output of the checked n_p+H*p circuit and the same exact term is used in its inequalities and successor-state cell. If a wire format supplies a distinct successor field, its equality to that output must be proved and charged. The analogous requirement applies to last and the local offsets.

## 6. A fair fresh-header comparator and the differential

The earlier465152-gate four-division header was a generous upper allowance, not evidence that an implementation must do that work. Comparing two upper bounds would not prove a saving. Instead use the following explicit fresh-first-hit witness circuit.

For a chunk whose starting progression lies before e, compute a=max(b,j_p). Supply q>=0 and check

    n_p=r+q*p, r=(p-1)/2,
    a<=n_p<a+p.                                       (4)

This proves the first hit without executing a division. All correct q fit g-2 bits because n_p<J+Y and p>=3, while the scalar receipt proves J+Y<3*2^(g-2). The raw q*p product needs g-2+f bits and its addition of r needs g+f-1 bits. The accepted n_p is then repacked to g bits with its proved range. Do not cancel those raw capacities against the small accepted value.

Before either g-bit endpoint comparison uses n_p, the checker must prove that the high bits of the raw r+q*p result are zero and bind that raw value to the packed g-bit value. This check belongs to the separately charged packing/binding column, outside F below. Comparing only the low g bits is unsound. For example, at g=8, p=13, j_p=84, b=100, e=110 and q=27, the raw result357 wraps to101; the narrow first-hit comparisons would accept101 although it is not the raw result. The carry schedule instead compares its successor at the raw width w before narrowing.

For a matched circuit, construct a with one g-bit comparison and a three-gate-per-bit select, add a+p at width g+1, and check the two endpoint inequalities. Its extra arithmetic over the carried first pointer is exactly the following specified subcircuit:

    F(g,f)=M(g-2,f)+5(g+f-1)+29g+12.                  (5)

The remaining active H/last/offset/phase header is identical to section5. If j_p>=e, a fresh header can prove emptiness immediately with one C(g), just as the carried pointer can. Do not charge the wider first-hit subcircuit to those preactivation empty chunks.

These are two certificate branches. The immediate-empty branch checks j_p>=e. The fresh-first branch checks(4), then the common n_p<e or n_p>=e test; it does not also require a separate j_p<e comparison. The canonical producer selects the immediate-empty branch exactly on preactivation chunks. Selecting the fresh-first branch there would still be sound but would cost more. Thus the matched counts below include no uncharged initial branch comparison.

|L|Fresh first-hit subcircuit F|Matched fresh active sparse|Matched fresh active dense|
|---:|---:|---:|---:|
|2^32|5821|10782|11460|
|2^34|6471|11613|12291|
|2^36|7155|12497|13175|

These are counts in one explicitly chosen padded circuit model. Neither fresh witness checking nor carry checking is claimed optimal. A different proof schedule, finer prime-dependent widths, constant propagation or a structural maximum selector may change the comparison and must be priced on both sides.

Let P be the actual complete odd-base-list length. Let A count active pairs, G count empty pairs after progression activation, and I count pairs with j_p>=e. Then A+G+I=QP. In the matched schedule, the Boolean arithmetic differential is

    C_fresh_arithmetic-C_carry_arithmetic=(A+G)*F(g,f).  (6)

The dense/sparse mixture and its common setup cancel only if identical on both sides. For the current full T-bit chunks,

    A+G=sum_(p in P_list) [Q-floor(j_p/T)].            (7)

This counts precisely the chunks whose upper endpoint exceeds j_p, regardless of whether that particular chunk contains a hit. It can later be calculated from the actual certified base list, but no such list or count is produced here. In particular a bound using all odd integers cannot be substituted for the actual saving in(6).

For complete cost, the carry is favorable only if the removed first-hit proof-production/checking/encoding cost exceeds the added state initialization, state-node proofs, chunk joins, width repacking and differential transport costs. Equation(6) counts only the named arithmetic gates. It is not an end-to-end saving from the difference between two unrelated upper estimates. Discovery remains separate: the untrusted generator still obtains H and produces every required stream and proof.

## 7. Immutable state, payload and checker capacity

The conservative additional state model has P initial entries, QP state-entry visits, QP successor cons cells, QP local invariant steps, and Q-1 exact chunk-state joins. Empty cases are included. Existing source-base traversal and word-stream leaf/merge administration remain common unless the actual implementation proves a shared operation. A constructor application, literal-word proof, saved reference and target unification are different costs.

An explicit fixed-width wire state entry uses ceil(g/8)=5 raw bytes in all three sizes. Using the old all-odd P upper bound gives:

|L|One vector raw bytes upper|Two vectors raw bytes upper|Successor nodes upper|All explicit interchunk snapshots raw bytes upper|
|---:|---:|---:|---:|---:|
|2^32|231715|463430|759376398|3796650275|
|2^34|463410|926820|6074192916|30370501170|
|2^36|926820|1853640|48592431144|242961228900|

The snapshot column is5P(Q-1) when every interchunk vector is explicitly serialized. It is a charged possible layout, not a mandatory data lower bound. A live checked local context can pass exact term references instead; a fresh process must reconstruct/import/replay the actual state theorem and cannot use a digest as a substitute. The first-hit q field of the matched fresh witness is4,5,5 raw bytes respectively when explicitly encoded, but removing that field does not automatically remove all arithmetic proof bytes or offset the state snapshots.

These small raw-vector sizes do not establish stock-MM0 fit. The inherited65536-entry local heap,64MiB expression store, theorem-local resets, encoded-list terms, ground arithmetic and proof references still need a complete storage schedule. The same PA interpretation and exact term-linkage obligations noted in the independent word-stream review apply. A native mutable vector is not an accepted replacement. Partitioning the complete base list into checked contiguous shards may reduce live state, but then every shard must traverse its required chunks and its outputs must be joined with exact exhaustive prime-list coverage. Those extra passes, proof imports and merges must be charged; no such implementation is supplied here.

The top bitmap remains a subset of the exact survivors, while recursive base construction still needs full complement/equality and exact extraction. State carry changes neither requirement. It also changes none of the source-word-to-packed-coverage semantics, final partial-word guards, anchor primality, source replay costs or initial binary-range obligations.

## 8. Evidence and remaining gate

Owned source_next_hit_carry_metadata_20261111.py has SHA256 `348781327FEBDC120869A79A18EFE10E882BD43B1B6004CC01EEE3620B6136B3`; its JSON has SHA256 `43127729EB0CB7E9722A909587D2A136209D20D77F45AF2CEB449C1EDB47FDC0`. All31748 checks pass. They cover exact capacities and circuit counts, all1533 abstract odd-modulus/partition cases through small endpoint9,6912 transitions,1664 off-by-one H rejections, additional p^2/last-chunk boundary cases and the explicit invalid-initial-state counterexample. These are protocol tests, not prime or source-sieve evaluations. The writer refuses to overwrite a receipt.

Checked inputs are:

- zero-sum/BINARY_SOURCE_WORD_STREAM_ACCEPTANCE_2026-11-11.md, `03BD20DF832348BD00967140D61E60D5A00CE7CA936E22DFAEA4EC1D6B39538F`;
- its scalar receipt, `6363C29B990DF24D848ED2A2254A4C8E8F70B08C47F820940E522BEA254B58DC`;
- prime-estimates/REVIEW_BINARY_SOURCE_WORD_STREAM_ACCEPTANCE_2026-11-11.md, `D1A2CF72DB22ADF01F8ABE39A1E4C5958802E0D7E4DF256935086E0B832615C5`;
- independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md, `4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA`.

The new mathematical step is the complete carried first-hit invariant and its exact transition, plus a fully stated comparison against fresh quotient witnesses. Formal library construction, actual certificate production, independent review and full generation/checking/transport prices remain required before choosing this header representation.
