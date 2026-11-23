# Source-prime certification by exact sorted word streams

2026-11-11. This is a paper acceptance algorithm and an integer-only cost model. No source sieve, prime search, source bitmap, actual periodic table, Lean/MM0 proof or build was produced. The companion tests use small abstract odd-modulus progressions, without asserting primality. Prior frozen reports are unchanged.

The proposed checker replaces a full chunk-sized mask operation at every prime/chunk pair by bounded-width arithmetic and explicit sorted lists of 64-bit masks. Every progression and every merge input is exhausted. This gives a concrete ordinary-rule alternative to the earlier unspecified certified `C_mark`. It does not establish that this alternative is cheaper: even conservative merge bounds reach trillions of records. Actual proof compilation, scratch capacity and repeated proof transport remain material costs.

## 1. Object, scope and recursive completeness

Retain the pinned source design [S1]. Let `J=L+2^19`, `U=2J-1`, and let source index `j` represent `2j+1`. The three size comparisons use `L=2^32,2^34,2^36`. Partition `[0,J)` into consecutive chunks `[b,b+w)`, with `0<w<=T=2^18`. Each chunk has at most `W=4096` words of 64 bits. A short final word has an explicit valid-bit mask.

Require a proved, sorted, duplicate-free complete base list containing exactly the primes `2<=p<=floor(sqrt(U))`, with the integer square-root witness. The generator cannot substitute a list whose members are merely prime. The entire base list is traversed for each chunk in the conservative schedule below. Prime 2 is skipped by a proved oddness argument. Every odd entry supplies either a complete stream or an explicitly proved empty stream. Missing streams are rejected.

The final chunk mask `C` includes all listed odd-prime composite marks and the bit for 1 when `b=0`. A proposed source bitmap `B`, with no invalid high bits, passes the top-level source rule when `B AND C=0`. Then each positive source bit denotes a prime. If `2j+1>1` were composite, its least prime divisor `p` would lie in the complete base list, and `2j+1>=p^2`, so the exact progression for `p` would mark it. The bit for 1 handles the excluded case separately.

For bootstrap base lists, require the stronger equality of `B` with the valid-bit complement of `C`, and exact extraction of all set bits, with 2 inserted when in range. Erased entries are composite because the marked number is divisible by a prime `p` and at least `p^2`. This proves both directions of primality membership. Recurse at `floor(sqrt(V))<V` for `V>2`, ending in the explicit cases at `V<=2`. The earlier square-root chains in [S1] are unchanged. A top-level subset of survivors cannot be used as a complete recursive base list.

The sufficient top theorem is positive membership, not a density or binary-coverage theorem. Clearing extra bits remains permitted, but can destroy the later binary coverage. Prime 2, the initial binary interval, anchor primality and every outer-block coverage proof remain separate.

## 2. Exhaustive prime/chunk headers

For an odd base prime, put

```
r=(p-1)/2, j_p=(p^2-1)/2, e=b+w, a=max(b,j_p).
```

If `a>=e`, certify an empty stream. Otherwise set `j=r+p*ceil((a-r)/p)`. Here `a>=j_p>=r`, so all divisions can be nonnegative Euclidean divisions. Certify `j>=a`, `j congruent r mod p`, and `j-p<a`. The last inequality can be expressed without subtraction underflow as `j<a+p`. These statements prove that `j` is the first admissible hit.

If `j>=e`, the stream is empty. Otherwise certify

```
H=1+floor((e-1-j)/p), last=j+(H-1)p,
last<e<=last+p.
```

The complete hit sequence is `j,j+p,...,j+(H-1)p`. Its first and last witnesses prove exhaustive membership, including the exact `p^2` boundary. Equivalently it is the intersection of `[b,e)` with `j_p+k*p`, `k>=0`, since `j_p-r=p*(p-1)/2`. A proof checking only that emitted positions are multiples is insufficient.

All global scalar operands fit a conservative 64-bit representation in these three sizes. Source indices need at most 37 bits; source numbers and prime squares need at most 38 bits; `p<2^19`. Header quotient products are bounded by the particular divisions, rather than assumed to fit from unrestricted 64-bit multiplication. General multiplication proofs below allow 128-bit results anyway. Valid local hit offsets fit 18 bits, but the exclusive endpoint `T` needs 19. Valid local word labels fit 12 bits, while the count/pointer 4096 needs 13. Global word labels would need 27,29,31 bits; this design instead binds local labels to the separately certified global `b`.

A deliberately generous per-pair header circuit allowance is four 64-bit quotient/remainder checks, four 64-by-64 products, 24 additions and 24 comparisons. It covers the displayed first/last formulas, exact division witnesses, case bounds and an optional dense phase. Prove `p^2` and `r` once per retained prime-table lifetime, or charge their repetitions. The header allowance is not a claim that all four divisions are necessary.

## 3. Canonical leaf streams and sparse marks

A stream is an explicit immutable list of records `(u,M)`. Word labels are strictly increasing, `0<=u<ceil(w/64)`, and `0<M<2^64`; a record's mask is clipped to the chunk. Its semantics at a word is its unique mask, or zero if the word is absent. The stream for one prime contains exactly the words touched by its complete progression, and each mask contains exactly the hits in that word.

For every hit offset `z=j-b`, certify `z=64u+t`, `0<=t<64`. Binary digit splitting supplies this division; it still needs the proved digit-to-natural interpretation. Obtain the one-hot mask `2^t` by a fixed 6-input decoder or a certified 64-entry table. Combine consecutive hits in the same word with OR. With `H` hits and `E` emitted records, this uses `H` address/one-hot operations, `H-E` within-word ORs, and `E` record constructions. All hits are processed, including nonunits and repeated composite marks arising from other primes. For `p>=64`, a word contains at most one hit, so `E=H`.

A grouping proof maintains the processed progression prefix, the completed word list, and the unfinished current word. It closes a word only when the next hit has a greater word label or when all `H` hits have been consumed. The final count is checked against the header, and there is no permitted early termination. Thus grouping does not weaken exhaustive coverage to positive membership.

## 4. Optional dense masks with the same output

For every odd integer `3<=p<64` and every `0<=rho<p`, a fixed cache may certify the 64-bit mask whose bit `t` is one exactly when `t congruent rho mod p`. There are `3+5+...+63=1023` entries, totaling 8184 raw bytes. The cache is not a list of primes and requires no primality computation. It is a finite collection of ordinary modular-arithmetic facts. For `p=2r+1`, its row starts at index `r^2-1`; binding a lookup requires the actual `p,rho` and mask statement. Neither an unchecked address nor a digest suffices.

For a nonempty progression, let `u0=floor((j-b)/64)` and `u1=floor((last-b)/64)`. Since `p<64`, every word from `u0` through `u1` has a hit: consecutive hits are less than one word apart. Therefore `E=u1-u0+1`, without scanning or discarding a run of empty words. At word `u`, use phase `rho=(r-b-64u) mod p`. Its successor is `(rho-(64 mod p)) mod p`, checked with bounded additions/subtractions and comparisons. Clip the first word below `j` and the last word above `last`. There are at most two endpoint clips; both may occur in one word. This includes the `p^2` boundary and any short final source word.

The clipped masks equal the sparse masks bit by bit. Thus sparse and dense construction produce the identical canonical stream, not merely equivalent supersets. The downstream merge and output binding can be identical. A cache of 65 prefix masks is another 520 raw bytes; prove their 64 bit interpretations, including the empty and full masks. Construction of `2^64` may require 65 bits even though stored masks have 64.

One concrete conservative cache proof expands every pattern bit into a 6-bit remainder check and equality. There are 65472 such bit checks, plus packing, row/index statements and references. Prefix masks require 4160 small comparisons. This is intentionally not an optimized cache constructor. Regeneration, import, serialization and lookup binding are charged per actual checked cache lifetime. Restricting the cache to selected primes does not remove the cost of proving the selected table entries.

For a fixed nonempty pair, write `C_hit` for the bounded scalar/decoder work per sparse hit, `C_phase` for a dense phase step, `C_lookup` for a fully bound cache use, and `C_or` and `C_clip` for 64-bit Boolean operations. An exact local sufficient comparison is

```
H*C_hit + (H-E)*C_or
  > E*(C_phase+C_lookup) + C_boundary + C_cache_allocated
      + Delta_proof_binding + Delta_transport,
```

where `C_boundary` prices the actual at-most-two clips, and `C_cache_allocated` includes the chosen share of setup. Common header and record work cancel only with the identical checked stream representation. There are separate versions for generation, proof production and checking. No probability or measured constant is assigned. A global cache policy must justify its allocated costs; summing independent cell minima while ignoring repeated cache eviction is invalid.

## 5. Merge certificate and child consumption

Use a binary merge tree whose leaves are in the order of the complete odd-prime list, plus the explicit mark for 1. Empty leaves remain identified. Pad by empty leaves or carry a last unmatched leaf according to a fixed schedule. The schedule and all child/root identities are checked.

The merge proof has six cases: both lists empty; only left empty; only right empty; smaller left head; smaller right head; and equal heads. In the equal-head case it consumes both records and emits their OR. In a smaller-head case it consumes exactly that child record and copies its mask. In an empty-side case it consumes/copies the entire other tail by an exact list identity. Each recursive step decreases the sum of child lengths, and the final tails must both be empty. Declared lengths, or the literal list constructors, are bound to those very lists. A trace with a missing suffix cannot close the proof.

Induction on the two list lengths proves sorted unique output and, for every word, that its mask is the OR of the two child masks. Associativity then proves the complete root is the OR of every leaf. Repeated composite marks may collapse to one output bit or one record, but every input record has still been consumed. This proof does not rely on cancellation, probabilistic fingerprints or a generator's claimed visited-set.

For child lengths `n1,n2`, the output length is at most `min(W,n1+n2)`. There are at most `n1+n2` head cases/record consumptions, and at most `min(n1,n2)` equal-key OR operations. Let `P'=P+1`, `d=ceil(log2(P'))`, and `E_l` be the total number of records across all streams at level `l`, summing over source chunks. If `E_0` is the total emitted leaf-record count, then

```
E_l <= min(E_0, Q*ceil(P'/2^l)*W),
merge input-record work <= sum_(l=0..d-1) E_l,
merge output-record work <= sum_(l=1..d) E_l.
```

Copying a carried leaf is charged in these conservative bounds. `E_0<=Z+1`, where `Z` is the full repeated hit count from [S1]. A final union count does not replace `E_0` or any merge-level count. In fact prime 3 belongs to the complete base list and, starting at index 4, touches every full 64-bit word in these source sizes. The final root has a record at every word. The proposed benefit is reduced repeated wide work, not sparse final support.

## 6. Ordinary-rule arithmetic and list access

Here is a bounded proof operation model, rather than a native clear-bit instruction. Represent bit vectors by literal Boolean constructors with a proved natural-number interpretation. Use only proved truth-table equations and structural induction lemmas. A binary Boolean gate contributes one closed truth-table proof and its bound input/output references. A compiled gate is not asserted to be one MM0 opcode or one Lean reduction.

The following conservative circuit bounds count Boolean gates. Constructors, proof applications and digit packing are separate columns.

| Operation | Gate bound |
|---|---:|
| OR/AND of `n` bits | `n` |
| addition of `n` bits, with carry | `5n` |
| subtraction with borrow | `6n+1` |
| unsigned comparison | `7n` |
| full `n` by `n` product | `11n^2` |
| restoring quotient/remainder of `n`-bit numerator by positive `n`-bit divisor | `n*(16(n+1)+1)` |

For addition use two XORs, two ANDs and an OR per full-adder bit. Subtraction complements one input and uses the carry circuit. Comparison maintains equality/less-than from the most significant bit, with at most seven gates per bit. Multiplication forms at most `n^2` partial-product ANDs and adds `n` rows at width `2n`. Restoring division retains `n+1` remainder bits, performs a comparison, subtraction and a three-gate-per-bit select at every step. Overflow/carry outputs and the terminal quotient/remainder identity are retained in the proof. These constructions supply bounded ordinary arithmetic proofs; a symbolic correctness lemma is proved once and does not replace the distinct ground gate checks.

A sparse hit can be charged one 64-bit increment, a 12-bit label comparison, a 64-bit bound comparison, and a 64-bit OR, totaling 916 gates, plus address-splitting/packing and one-hot production. An uncached six-bit one-hot decoder takes at most 326 further gates: six complemented inputs and 64 products of six literals. Thus the mark arithmetic has a fixed 1242-gate bound with no chunk-wide operation. Copying the first mask or exploiting exact bit patterns may reduce it; no such reduction is credited. A merge input record needs at most a 12-bit comparison and a 64-bit OR, or 148 gates, plus structural cases, record access/copies and length bookkeeping. Lengths may be obtained by a structural theorem, or their concrete 13-bit decrement/update proofs must be added. No terminal value 4096 is stored in a 12-bit field.

Use immutable literal lists, not an unproved mutable array. A merge step matches the actual `cons(head,tail)` terms and applies the corresponding proved merge constructor to the recursive proof. The equal-head case binds both keys and the OR result. List correctness and word semantics follow by ordinary induction on this trace. A source leaf similarly binds its actual progression counter and next list tail. A cache lookup uses the actual closed cache theorem, or a proved path through a literal balanced cache tree; the latter takes at most ten branch steps for 1023 entries. Source-prime-list traversal is sequential and exhaustive. There is no assumed constant-time arbitrary list lookup.

The concrete proof representation can share exact tail terms in a checked local expression arena. Construction adds one cons cell per record and bounded record/bit terms. Each merge case destructures only the heads and refers to the exact tails, rather than rescanning their contents. In the pinned MM0 implementation, `verifier.c:241-270` checks shared substitution identities and destructures term arguments; `382-395` checks local references; `479-517` applies a previously checked theorem with argument/hypothesis checks. These facilities support this representation in principle. They do not certify an untrusted pointer into a native source array.

The cost vector must include Boolean gates, record/bit constructors, local references, merge/grouping constructor applications, table fact applications, case/bound proofs, literal input construction, packing and serialized command bytes. Each logical constructor has fixed arity. Thus their number is linear in the emitted records, consumed records and checked arithmetic gates, with the already displayed header count. The constants are the compiled sizes of finitely many fixed ordinary-rule lemmas, not a hidden `C_mark(J,T)` or a claim of constant native time. Supplying those lemmas and measuring or proving their command expansion is a remaining implementation obligation. This paper specifies the operations and semantic acceptance; it does not claim an existing MMB trace.

If a compiler instead copies literal suffixes, charge the copied syntax: a stream is at most `W` records, giving a conservative additional `O(W)` record-term copy cost per such reference. The small shared-term bound cannot be used for that representation. Likewise a fresh process must reconstruct/import the actual statement and checked dependency, or replay its proof. External checksums do not establish the required equality.

## 7. Memory, passes and end-to-end binding

A raw local record needs ten bytes for a 12-bit word label and a 64-bit mask, before framing, lengths and proof objects. Two complete input streams and one output stream of a single merge use at most `30W=122880` raw bytes; this is not a checker-memory bound. A levelwise external schedule reads each level's input records and writes the next level's records, so charge at least the corresponding `10*sum E_l` raw bytes in each direction, plus headers and proof streams. This avoids retaining all prime streams in native RAM, but introduces file traffic and proof joins.

Proofs of separate merges must identify their exact child lists. If an earlier theorem is imported, its statement and proof provenance must survive; if only a file is available, replay or a proved import mechanism is necessary. Literal roots are not authenticated by a hash alone. In one uninterrupted local proof pack, exact term sharing can provide the stated access bound. Across packs, record copies, re-instantiation and proof replay are priced explicitly.

Stock MM0 has a 65536-entry local heap and a 64MiB expression store [S5], and clears local state at theorem boundaries [S4]. A raw 122880-byte merge does not prove that its arithmetic proof fits these limits. One global theorem per progression/merge can also exceed global format limits at the displayed scale. A production layout must either demonstrate bounded proof packs under stock limits, or validate a same-rule streaming/import implementation. No such implementation or fit claim is made here. This is the precise remaining representation requirement after replacing abstract mark access by structural lists and bounded gate circuits.

After the root stream is accepted, walk its word labels and the proposed bitmap words in order. Missing root words mean zero composite mask; each proposed word is checked disjoint from its root mask and from invalid high bits. Charge one 64-bit AND per word, a zero check, record alignment and final-word bounds. The complete base bootstrap instead verifies exact complement/equality. Global chunk assembly proves a gap-free partition of `[0,J)` and binds all chunks to the same `U` and complete base theorem.

The later binary tile must consume those actual source words and their exact index translation `j=t+s`. For a target tile `[a,b)`, the source halo is `[a,b+2^19)`, with its last index `b+2^19-1`. The prior three-chunk halo fact still applies. Reusing a source chunk across many outer blocks requires retained proofs or checked imports; if a worker replays source proofs, multiply their cost by the actual replay count. A streamed schedule must certify that all required block/tile consumers finish before eviction. Prime-factor caches, dilations for packed coverage, and the initial binary interval remain additional proof/data objects.

## 8. Conservative metadata and the decision rule

The companion uses only [S1]'s all-odd upper bound for `P`, its dyadic reciprocal upper bound for `Z`, and integer arithmetic. It computes no prime counts. These are loose worst-case bounds, not expected work.

| `L` | Prime/chunk headers upper | Leaf records upper | Merge input records upper | Merge output records upper |
|---|---:|---:|---:|---:|
| `2^32` |759376398|34363979016|289409069880|255112207920|
| `2^34` |6074192916|146033437195|1363694473304|1217929479757|
| `2^36` |48592431144|618480194581|6348011762877|5730605318312|

The maximum merge depths are 16,17,18. Final bitmap storage remains 536936448,2147549184,8590000128 bytes. Full per-level bounds are in the receipt. Even the grouped stream route can be expensive, and these bounds cannot establish a saving over the earlier chunk-mask route.

For one complete fixed source schedule, compare separately

```
C_stream = C_complete_base + C_headers
         + C_sparse_or_dense_leaves + C_all_merge_levels
         + C_final_word_checks + C_list_terms_and_binding
         + C_cache_setup_and_transport + C_source_consumer_transport,
```

against a specified full-mask schedule at the same source and theorem. Use its actual arithmetic algorithms and operands, not a unit price for arbitrary bit widths. Sparse versus cached-dense selection uses the exact inequality in section 4, including lifetime costs. Stream versus full-mask selection requires `C_stream<C_mask` after all repeated work and common work have been identified. A hybrid may use wide masks on selected prime groups, but must convert their exact bit semantics into the same root stream or final word interface and charge that conversion. It is not automatically covered by the leaf counts above.

There are distinct generation, proof-production, checking, transport and memory objectives. A generator may create the native bitmap first and then emit a certificate, but native work plus certificate production must both be charged. A Lean implementation may find literal Nat chunk operations cheaper than explicit Boolean traces. An ordinary-MM0 implementation may benefit from the bounded word gates. Neither conclusion follows from this operation vector.

The useful next concrete comparison is one bounded chunk proof with a complete small base list, sparse-only and mixed leaf constructors, identical final source facts, and explicit proof-pack memory/bytes. It must exercise empty streams, `p^2` within a word, coincident word keys, a partial last word and all tail-consumption checks. Such a test is not run or authorized by this note. No real compression, successful source generation or reduction in end-to-end Goldbach cost is credited.

## Evidence and remaining proof obligations

`binary_source_word_stream_metadata_20261111.py` has SHA256 `71CF1D455B503C7F55B769E98E3B744A991D5A1A0271BC74E571C25D96D43733`; its JSON has SHA256 `6363C29B990DF24D848ED2A2254A4C8E8F70B08C47F820940E522BEA254B58DC`. It records 560 checks, including 168 toy progression cases and 25 synthetic merge cases. No actual source intervals or prime membership are evaluated. One initial invocation failed before tests because two source files were named `.h` rather than `.c`; only those path strings were corrected before the successful run. This is not mathematical evidence of performance.

The required formal work is the finite arithmetic/list library and its ordinary proof compiler, exact source/word extraction and joins, complete recursive base production, ground arithmetic certificates, and a demonstrated bounded proof-storage schedule. No new arithmetic or memory oracle is proposed. Existing primality and least-divisor mathematics are retained as proof dependencies rather than imported as unproved computation.

| Pin | Workspace-relative source | SHA256 |
|---|---|---|
|S1|`work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md`|`4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA`|
|S2|`work/qrh-campaign/agents/moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md`|`F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0`|
|S3|`work/qrh-campaign/agents/prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md`|`DAA7F4625A1CCF8D9307AF59D1FA0C74416CCF38F9B87BBC8547C0F0D74836F3`|
|S4|`work/formal-goldbach-bench/mm0/src/verifier.c`|`71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`|
|S5|`work/formal-goldbach-bench/mm0/src/verifier_types.c`|`87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E`|
|S6|`work/formal-goldbach-bench/mm0/src/types.c`|`B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1`|
|S7|`work/mm0-efficient/soundness.md`|`C967F8059920C80635238FC2955C9D4FAD55327B26B1BAB6F2746F7440661FD8`|
|S8|`work/mm0-efficient/toolchain.md`|`68F56ECDAFC149BF2EC67B4682B24F732D2042F03D7DA610B1DCE85A72AF8C86`|
