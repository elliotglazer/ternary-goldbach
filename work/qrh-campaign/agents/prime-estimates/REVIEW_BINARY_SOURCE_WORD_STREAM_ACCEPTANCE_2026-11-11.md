# Independent review of sorted-word source acceptance

2026-11-11. PASS at the stated conditional mathematical and operation-model scope, with no correction requested. This binds zero-sum/BINARY_SOURCE_WORD_STREAM_ACCEPTANCE_2026-11-11.md, SHA256 `03BD20DF832348BD00967140D61E60D5A00CE7CA936E22DFAEA4EC1D6B39538F`. It accepts a finite certificate design, not an implemented ordinary-PA checker, a source bitmap, or an end-to-end cost reduction.

I read the complete frozen report and script, the earlier source-bitmap/wheel/coverage contracts, and the cited verifier bodies. I independently reconstructed its metadata without importing or executing the author script. No prime classification, actual source sieve, source bitmap, periodic64-bit table, analytic value or build was produced. The finite tests concern abstract odd-modulus progressions and synthetic lists only.

## 1. Complete progressions and the surviving-prime proof

The source contains J=L+2^19 positions, with index j denoting2j+1 and0<=j<J. Index0 must be zero. Prime2 is not represented by this odd bitmap. The exact complete base list through Y=floor(sqrt(2J-1)) is required, including both membership directions and an integer square-root witness.

For an odd listed prime p, the residue r=(p-1)/2 and starting index j_p=(p^2-1)/2 satisfy j_p-r=p(p-1)/2. The header's first-hit conditions therefore select exactly the progression j_p+kp, k>=0, intersected with the current chunk. With a=max(b,j_p), a>=r, the formula using ceil((a-r)/p) uses nonnegative integer division. Congruence, j>=a and j<a+p prove minimality. The two empty branches, a>=e and then j>=e, correctly avoid a negative count calculation. In the nonempty branch, last<e<=last+p proves that no terminal hit is omitted. The p^2 endpoint is included and p itself is not marked.

If a positive source bit represented a composite n>1, its least prime divisor p satisfies p^2<=n<=2J-1 and is in the complete base list. The corresponding progression must mark that bit, contradicting B AND C=0. The separate bit for1 closes the remaining nonprime case. The earlier actual PsiSieve3.prime_iff_PS3 proof uses precisely Nat.minFac_prime, Nat.minFac_sq_le_self and Nat.minFac_dvd; its fixed old numeric range is not itself a generic theorem for the new source sizes.

The top-level source needs only positive-bit soundness, so extra zeros are allowed. Recursive base construction needs equality with the valid-bit complement and exact extraction. Every mark except1 is composite because its number is divisible by a certified prime and at least p^2. Thus exact complement supplies both primality directions and does not discard a prime needed at the next recursive level. A subset-only base bitmap would be unsound for this purpose. The square-root recursion decreases for V>2; the small base cases and insertion of2 remain explicit obligations.

The proposed source theorem does not prove binary coverage. All anchor primes, initial even targets, complete outer-block/tile coverage and the source-to-target identity remain required. An all-zero top bitmap is sound but usually useless for coverage.

## 2. Grouping, dense cache and complete merging

For each hit, the quotient/remainder decomposition j-b=64u+t binds the exact local word and bit. Grouping processes the complete progression in increasing order. It may close a word only at the next larger word label or after all hits are consumed. Consequently a grouped record contains exactly the progression bits in that word. For p>=64 there is at most one hit per word. A grouping that only proves its emitted bits are multiples would not suffice.

The dense option is equivalent to this same canonical stream. For p<64, successive hits cannot skip a complete word, so the occupied labels form u0 through u1. The phase formula and its recurrence select the same congruence class. Clipping below the first hit and above the last hit enforces both p^2 and the chunk boundary, including two clips in a single word. This proves exact equality of sparse and dense streams, which is stronger than needed at the top and sufficient for recursive complement extraction.

The cache covers all odd moduli3..63, without claiming those moduli are all prime. Its1023 row entries,8184 raw bytes, and row start r^2-1 for p=2r+1 are correct. The prefix cache has65 entries and520 raw bytes. All semantic table facts, row lookup proofs and packing remain charged. I did not construct the actual64-bit tables. My independent toy dense comparison uses smaller abstract word lengths.

The six merge cases preserve strictly increasing labels and the pointwise OR of both inputs. An equal-key step consumes both records, so duplicate composites are harmless but not free. Empty-side copying must bind the exact remaining list. Termination in the sum of child lengths and the requirement that both tails close prevent omitted suffixes. A sorted output alone would not prove exhaustive consumption.

The level bounds are valid for the specified balanced schedule. If E0 bounds all emitted records and there are P+1 leaves per chunk, including the mark for1, then

    E_l <= min(E0,Q*ceil((P+1)/2^l)*4096).

The input and output record sums must include every level. E0<=Z+1 globally is correct because the mark for1 occurs only in the first chunk; the other such leaves are empty. The final union size cannot substitute for input or intermediate record counts. In these three64-divisible source sizes, p=3 starts at j=4 and marks every word, so the final root actually has every word label. There is no sparse-final-support assumption available here.

An accounting qualification is important: a merge of two empty streams still needs a structural case and child bindings. Such work is not counted by sums of E_l. The report retains separate case/bound-proof costs and the already displayed O(QP) header/tree administration. The author confirmed that reading during review. For a carry-last schedule there are P internal binary merges per chunk; padding can add a bounded factor and must follow its declared schedule. Zero records do not imply zero proof work.

## 3. Arithmetic, indexing and actual ordinary-rule limits

The proposed Boolean gate bounds are sufficient circuit bounds. Five gates per full-adder bit, complement-and-carry subtraction, equality/less-than comparison, partial-product schoolbook multiplication, and restoring division give the displayed formulas. In particular the n+1-bit restoring remainder accounts for comparison, subtraction and a three-gate select. The64-bit header bound465152 and sparse arithmetic916 are consistent. The six-bit one-hot decoder uses6 complements plus64 groups of5 AND gates, giving326 and the combined1242 bound. A merge record's comparison-plus-OR upper bound148 is likewise correct.

These are not MM0 opcode counts or Lean reductions. Bit/natural interpretation, address splitting, record construction, bounded arithmetic conclusions, case lemmas, proof applications and references remain separate. Literal Boolean/list encodings must be conservative over the chosen arithmetic foundation, and the claimed truth-table and induction lemmas must be proved rather than supplied as new axioms. A symbolic circuit correctness theorem does not certify its distinct ground gates.

Valid local word labels fit12 bits, but the terminal count4096 needs13. Valid local hit offsets fit18 bits, while the exclusive chunk endpoint2^18 needs19. Global b and hit/header calculations remain separately bounded64-bit arithmetic. The bound check must precede using a purported next hit as a valid local label; an out-of-range terminal hit does not inherit the valid-label width. Word masks and the last valid-bit mask are bound to their actual finite lengths.

I read verifier.c at the cited operations. CMD_UNIFY_REF compares the actual shared substitution/term reference; CMD_UNIFY_TERM exposes its arguments; CMD_PROOF_REF reads an established local reference; CMD_PROOF_THM checks argument sorts, dependency constraints, hypotheses and the instantiated target. These support exact-tail sharing in principle. They do not authenticate an arbitrary native pointer or a digest of a discarded list. The65536-entry local heap and64MiB expression store are present in verifier_types.c. Literal local sharing, serialized theorem statements, global format bounds and resets remain different issues.

The paper correctly leaves a demonstrated proof-pack layout open. The122880-byte raw three-stream figure is not a bound on parsed Boolean terms, ground arithmetic proofs or checker memory. A fresh proof pack needs exact imports/reconstruction, and a copying compiler can pay O(4096) record syntax per tail reference. Neither constant-time arbitrary list access nor free cross-pack proof reuse is assumed. The formal arithmetic/list library, proof compiler and storage schedule remain substantial implementation work.

## 4. Source transport and complete cost comparison

The root-stream/bitmap walk checks every bitmap word against its exact composite mask and invalid high bits. Bootstrap instead checks exact complement. Chunk assembly must prove a gap-free partition of[0,J), use the same base theorem and U, and expose the same word object later consumed by coverage.

For a coverage tile[a,b), the necessary source interval[a,b+2^19) has last index b+2^19-1. The original aligned three-chunk halo and the inclusive final binary target are preserved. A new packed or dilated source literal needs an exact interpretation proof. Retaining only a checksum does not retain a prime theorem. Replays across workers or passes, factor-prime caches and any coverage dilation remain charged.

The sparse/dense inequality cancels common header and record work only because both constructors prove the identical canonical stream. Setup, lookup binding, eviction and transport must use their actual lifetimes. Likewise the stream/full-mask decision compares complete source schedules under the same theorem and trust assumptions. The conservative bounds reaching trillions of merge records are not measured work or a demonstrated saving. Native generation, ordinary proof production, kernel checking, bytes and memory remain distinct quantities.

## 5. Independent evidence and verdict

I checked the three author artifact pins and all eight source pins in its receipt. My independent script reconstructs the three size rows using binary-search square-root witnesses and repeated ceiling-halving of tree sizes. It matches every per-level record bound, aggregate count and circuit/cache scalar. It also checks617 abstract progression cases, including empty ranges, p^2 boundaries, partial words, and dense/sparse equality where applicable. A separate direct-divisibility oracle supplies the expected hits. A recursive merge implementation and pointwise-mask oracle check1024 synthetic list pairs and exact consumption of both inputs.

All6232 checks pass. These finite tests support the algebra and cost metadata; the general proofs above, not the tested examples, justify all intervals. No author program was imported or executed.

|Artifact|SHA256|
|---|---|
|Frozen author report|03BD20DF832348BD00967140D61E60D5A00CE7CA936E22DFAEA4EC1D6B39538F|
|Author scalar script|71CF1D455B503C7F55B769E98E3B744A991D5A1A0271BC74E571C25D96D43733|
|Author receipt|6363C29B990DF24D848ED2A2254A4C8E8F70B08C47F820940E522BEA254B58DC|
|prime-estimates/review_binary_source_word_stream_20261111.py|4772123A044AACC2DC63F85210A7A76C2AE27EB7D7108FBB303FCD83818B4CFD|
|prime-estimates/review_binary_source_word_stream_20261111.json|A5439F1D82B43DA84F2EEF8D5B8A4F0038A6FEA2AD5A3681672C382032309021|

The independent receipt preserves the complete source path/hash manifest, including the actual verifier files. The scoped verdict is PASS with no author correction. It does not establish a compiled standard-axioms certificate, a successful prime source, actual compression, stock-format capacity, or a runtime advantage.
