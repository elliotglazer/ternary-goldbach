# Bounded-state assembly under ordinary MM0 rules

2026-11-11. Source research and a proposed storage design only. No implementation, build, proof stream, process experiment or arithmetic evaluation was produced. The frozen sources and earlier reports are unchanged.

## Conclusion

Yes, a continuously running checker can retain checked generic libraries and a small proved prefix interface, consume each shard once, and discard obsolete concrete proof state without replaying the checked prefix. This needs no new arithmetic inference rule. It follows from the ordinary theorem rule: a proved theorem can be applied through its exact statement, binders and hypotheses without retaining the derivation used to establish it.

The pinned `mm0-c` already has that logical behavior at theorem boundaries. It does not provide the proposed bounded global environment, shard-resume protocol or genuine bounded-buffer MMB input interface. These are explicit same-rule implementation changes, with their own correctness and engineering obligations. They do not remove ordinary digit-level proof steps or their input bandwidth.

The useful distinction is between retaining a theorem's derivability in trusted checker state and accepting an external assertion that a theorem was checked. A digest, success log or serialized `verified=true` flag is not the former.

## 1. What the pinned implementation actually does

The source snapshot is `digama0/mm0` revision `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`. The four core C files in the source ledger match the earlier `work/mm0-fermi/sources-manifest.json` hashes. The copies inspected here are under `work/formal-goldbach-bench/mm0/src`.

- `verifier_types.c:4-15` represents a proof stack value as a tag plus an expression-store offset. It does not store a full derivation tree in each proof value. The expression and conversion layouts are at 32-63.
- `verifier.c:178-200` loads and checks declaration binders and resets the local heap. `verifier.c:770-788` resets the expression store and stacks, checks a theorem proof, requires the final proof tag, and matches its conclusion and hypotheses against the declaration's unification program. The checked theorem then becomes available by advancing `g_num_thms`.
- `verifier.c:479-517` applies only a theorem below that checked frontier, validates expression argument types and disjoint-variable restrictions, and invokes its statement unifier. It does not replay the theorem's original proof stream. `verifier.c:297-316` checks required theorem hypotheses by consuming proof-tagged arguments.
- `Ref` at `verifier.c:382-395` addresses the current proof heap. `Save` at 619-632 appends to that heap. The heap and expression arena do not offer arbitrary deletion in this instruction set. Old closed instances of table theorems therefore cannot be assumed to survive the next `load_args` merely because their global theorem declarations survive.
- Global term/theorem tables remain mapped. `types.c:50-68,96-122` uses 32-bit counts and offsets. `verifier.c:674-697` installs these whole-file table pointers and advances through the proof section. Local theorem/definition commands still increment the same global counters at 759/790. They avoid some public-specification parsing, but do not mean a garbage-collectable lexical scope.
- `main.c:38-76` maps the complete MMB file before invoking verification. Sequential traversal is not itself a bounded-buffer streaming API. The operating system can page mapped proof data, so whole-file mapping also does not prove that every byte is simultaneously resident. Nevertheless the source offers no end-to-end bounded-memory guarantee independent of the growing global tables.
- `verifier_types.c:18-77` gives the fixed proof-store/heap capacities. Its parser tries and input buffer at 99-245 add separate limits. `README.md:29-48` documents the first-4-GiB statement-data and individual-proof constraints. Raising only the scratch size does not remove them.
- The public parser at `parser.c:612-681` checks declaration kind, binders, expression and duplicate names. `NO_PARSER` would lose binding to the requested specification. A successor parser may use another exact representation, but it must preserve that binding.

Thus stock `mm0-c` can check a suitably sized merged file with one library prefix and many local pack theorems, each with bounded scratch. It does not recheck all old proof bodies per pack. Its accumulated declaration metadata and file format can still obstruct the full campaign.

## 2. A small interface that really summarizes the prefix

Fix the exact foundational theory Gamma, permitted definitions, and final target T before reading numerical shards. Check the generic arithmetic and coverage library once. Retain its exact declaration schemas, not only names or hashes.

For a ladder, a useful closed state theorem has the shape

    Gamma proves CoveredThrough(e_i) and Prime(p_i) and BoundaryRelation(e_i,p_i).

Here the concrete numerals e_i and p_i are ordinary terms using the fixed library's constructors. The exact relation and endpoint convention must be chosen from the intended coverage theorem. The state includes a last-prime fact if the next shard needs it; a coverage proposition alone does not automatically supply primality of a chosen boundary value.

Each shard supplies ordinary proofs of its arithmetic, ordered positions, complete local coverage and its outgoing boundary. A previously proved generic join theorem combines those proofs with the old state theorem to produce the new state theorem. This join still needs an ordinary checked theorem application and all hypothesis/parameter checks. Only after the new theorem has been fully accepted may the old state and shard-internal facts be forgotten. The final generic closure theorem consumes the last state and the separately required initial/terminal cases to prove exactly T.

A conjunction listing every old shard is not a bounded summary. Nor is a concrete existential witness list whose term grows with every shard. The quantified interval property above has small syntax apart from its endpoint numerals because the generic join theorem has already been proved. The accepted statement carries the logical strength; no arithmetic trace is trusted merely because it is omitted from that statement.

Independent shards may instead prove a schema conditional on their incoming boundary fact. Such a schema is not a closed proof of the shard conclusion. Sequential assembly must discharge the incoming fact with the base theorem or previous state. This preserves the existing adaptive-chain boundary obligation.

## 3. Trusted-state and deletion invariants

A minimal successor checker can expose an exact checked environment plus one current prefix slot. It needs the following invariants.

1. **Theory and target identity.** Retain the exact allowed sort, term, definition and axiom declarations and the target syntax. New axioms cannot be introduced by a shard. Definitions must obey ordinary MM0 formation and freshness rules. Import identifiers are resolved against this exact environment, including binder sorts, dependency/disjointness masks and ordered hypotheses.
2. **Accepted fact provenance.** Every retained theorem schema has a derivation by the ordinary rules from Gamma and the permitted conservative definitions. The only transition that installs a fact is successful completion of its ordinary proof and exact statement checks. The checker may erase that derivation afterward; its state-transition invariant supplies provenance. A caller cannot manufacture a fact handle or overwrite its statement.
3. **Completed obligations.** Commit only at a verified declaration boundary with all conversion and unification obligations discharged and the full hypothesis list matched. If the exported prefix must be closed, no undeclared assumptions may remain. Generic library schemas may have hypotheses, which later applications must prove.
4. **Live syntax closure.** Retain every term/definition descriptor reachable from the surviving formulas, their types and any later permitted unfolding. A proof body can be forgotten while its surviving conclusion still needs a definition body. The simplest numerical interface uses only fixed-library constructors, rather than a fresh opaque constant for each witness. Alternatively prove and perform elimination of private definitions before export. Do not discard their meaning while retaining a formula that mentions them.
5. **Reference integrity.** Stale handles must fail, never resolve to a newly allocated theorem or expression. Monotone logical identifiers, or slot-plus-generation identifiers with checked exhaustion behavior, can separate logical identity from reused storage. Relocation must preserve all expression edges, sorts, dependency masks, and exact identity tests. Hash-consing may accelerate lookup, but hash equality alone cannot establish term equality.
6. **Failure and completion.** A failed or incomplete shard cannot advance the prefix. Persist rejection state across resets. The exact final target and end-of-stream checks remain mandatory. A result may not be exported from an unfinished run merely because some intermediate proof tag exists.

A particularly important source detail supports item 3. `Conv` at `verifier.c:537-543` puts a proof-tagged expression on the stack before placing the conversion obligation above it. `ConvCut` at 600-606 similarly creates an assertion guarded by an outstanding obligation. `Refl`, `Cong`, `Unfold` and the remaining conversion instructions discharge those obligations. Deleting the guard while retaining the provisional proof would create an unsound rule. It is not valid garbage collection. The conservative design in this note performs commits and environment pruning only after the full declaration-end check, rather than trying to export arbitrary mid-proof values.

The source's non-BARE `Sorry` path sets a taint flag and rejects the completed file at `verifier.c:803-807`. A successor must reject such instructions immediately or preserve the taint through all shard resets and prohibit fact export. Resetting that state would not preserve the ordinary rules.

Fresh bound-variable state also cannot be recycled while live expressions still refer to it. Keep persistent concrete prefix proofs closed. Store generic library declarations as schemas with their own checked binders, not as raw variable-bearing heap instances copied into a new binder scope.

## 4. Minimal same-rule implementation change

Use three storage classes: an immutable checked library environment, a small current-prefix environment, and a per-shard arena. Read a bounded shard stream; run the ordinary expression, theorem, conversion and hypothesis instructions; prove the next prefix; copy its exact statement into the prefix environment; then free the old prefix and shard arena after proving that no retained syntax points into them.

The fact-copy operation changes storage only. It accepts no new mathematical statement and performs no special multiplication, primality or coverage inference. If a new `forget` or checkpoint directive is used in the transport format, its logical action is environment restriction after completed proof checking. Expanding the entire finite run into fresh ordinary declaration names yields an ordinary derivation with the same applications. That derivation need not fit the pinned 32-bit MMB container. A widened transport/checker is explicitly a different implementation, even though the logical rules are unchanged.

For an even narrower first change, retain all global descriptors but add bounded proof-input buffering and preserve the existing theorem-boundary scratch reset. This avoids holding proof bytes resident but does not solve linear global metadata growth. Fully bounded global state requires the live-declaration policy above as well.

There are two different library caches. Checked theorem declarations avoid re-proving the library. Closed instantiated table facts can additionally avoid repeated `Thm` instantiations if stored in a persistent checked arena. Stock `Ref` cannot access those across theorem boundaries. A new implementation must either add an exact checked-handle access mechanism or pay local re-instantiation per shard. Keeping all byte-table instances also has a real persistent-memory cost. It must not be advertised as both free setup and zero retained memory.

Private witness declarations, arbitrary shared old facts and public name maps can prevent bounded storage. The format must either prohibit these exports beyond the explicit interface, or retain their full reachable closure and account for it. A proof producer asking for an already-forgotten lemma must re-prove it or fail. Storage reuse never grants an unproved import.

## 5. In-process continuity, restarts and independent checks

Within one trusted checker execution, forgetting derivation history after successful checking is the same logical principle already used by theorem application. It does not assume that PA proves its own consistency, and it does not require a new theorem of reflection inside PA.

Across a process restart, an untrusted checkpoint containing a statement and `checked=true` does not recreate that provenance. A conventional digest protects neither logical validity nor the origin of the flag. Safe choices are:

- replay the required ordinary proof input, including the library if no trusted checked environment survives;
- retain the live checker state in a trusted continuing process;
- specify and validate a trusted persistence/restore mechanism as part of the checker implementation and its platform assumptions.

The third choice is an implementation trust claim, not a portable ordinary proof certificate. An independent checker receiving only an exported summary still needs a derivation or its own trusted provenance. It may stream the full original certificate once without retaining all proof bytes. A practical independently reproducible artifact should therefore retain or reproducibly regenerate the full proof stream even if the accepting process discards processed buffers.

Parallel untrusted workers can generate shards freely. Their success receipts are not theorem imports. An ordinary final checker can read and verify each shard once in sequence, with the shared library checked once. A trusted parallel proof-checker/coordinator could avoid duplicate checking, but its exact result transport, immutable statement identity and theory match would become part of the trusted state mechanism. That extension is not supplied here.

## 6. Cost model for N shards

Let L be the library proof-checking cost, B_L its proof bytes, and M_L its retained declarations and any deliberately retained closed instances. Let V_i be shard i's ordinary proof work, J_i the exact join/install work, I_i its parsing/representation work, G_i its reclamation work, and B_i its proof bytes. Let A_i be its maximum arena, C_i its live private-declaration closure, and R_i the surviving prefix syntax. The proposed single-pass design costs

    T = L + sum_i (V_i + J_i + I_i + G_i) + T_final,
    bytes_read = B_L + sum_i B_i + join/header bytes,
    peak_live <= M_L + max_i(A_i + C_i + R_i + R_(i-1))
                 + bounded input/output/parser buffers.

These are accounting identities, not measured coefficients. Reclamation can be cheap arena release when all exports are copied and closure checks are structural. If it scans reachable graphs, that scanning cost belongs in G_i. Shared library references and substitutions still cost work in V_i/I_i. Local table re-instantiation belongs there unless its persistent alternative is explicitly charged to M_L and L.

For a fixed target with bounded endpoint width and an export restricted to one prefix/boundary statement, R_i is bounded by the fixed interface size and numeral width. For an unbounded family of targets, indices and endpoints require at least logarithmic size. This is bounded live state relative to the chosen target/pack bounds, not literal constant bits for arbitrarily large integers.

The existing merged-MMB path already has one library proof check and a single pass through shard proofs. Its distinct costs are the accumulated metadata of all declarations, possible parser growth and format/address limits. It must not be charged an unnecessary N-fold replay of L or all old proofs.

Fresh independent per-shard processes ordinarily pay N*L plus local work. If their outputs are untrusted, the final ordinary check is additional work. Naively restarting with the entire proved prefix for shard i costs

    N*L + sum_j (N-j+1)*V_j,

before joins, giving quadratic repeated shard work when V_j is constant. That is a property of this restart strategy, not a necessary cost of ordinary MM0. Independent conditional shard proofs plus a final single-pass check, or the proposed continuing state, avoid that repeated-prefix term.

None of these arrangements reduces sum_i B_i or sum_i V_i merely by erasing proof history. Compression may reduce storage or transport but still requires correct decoding and ordinary proof processing. Arithmetic acceleration would be a separate acceptance rule and is not assumed.

## 7. Required validation before a cost claim

The storage implementation must preserve the invariants above under malformed streams, exhaustion, failed joins and stale references. Targeted controls should include a changed theorem statement behind a reused handle, an unmatched hypothesis, dropping a pending conversion guard, a forgotten definition later unfolded, an allowed-theory mismatch, `Sorry` before a checkpoint, a skipped coverage interval, and an untrusted checkpoint pretending to be accepted. A valid alternate arithmetic proof must remain acceptable; identical producer bytes are not required.

The decisive future benchmark is complete ordinary proof packs with the same library and arithmetic witnesses under the stock merged format and the proposed storage policy. Measure library proof/setup, local instantiation, proof bytes, declaration bytes, peak live closure, join/reclamation, final target check, and restart/independent recheck separately. This note provides no implementation or runtime estimate.

## Source ledger

| File | SHA256 |
|---|---|
|work/mm0-fermi/sources-manifest.json|3A1D00A2A7BCC5F59D9E6EDF6E69A364E9BF51CA0E4332CFEDB46AE3EB174AC5|
|work/formal-goldbach-bench/mm0/src/main.c|ECDE31379241E38CA0B375DF0F40B216E9108F6CFD45952CCB282658D883DE17|
|work/formal-goldbach-bench/mm0/src/types.c|B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1|
|work/formal-goldbach-bench/mm0/src/verifier.c|71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5|
|work/formal-goldbach-bench/mm0/src/verifier_types.c|87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E|
|work/formal-goldbach-bench/mm0/src/parser.c|695BF56B4FE190E6BA369A8BE854CD1031B2624929FC5FDA995551E7BAD00C39|
|work/formal-goldbach-bench/mm0/src/README.md|5ADA16E00CD2F72E7F83D247768CDE6ADE34E56962B1858BC014FABEDC900A70|
|work/qrh-campaign/agents/integration/EFFICIENCY_PROOF_COMPOSITION_2026-11-11.md|FE62515193754C19CDB4A34728765CFA09DD5BEDD1694E5D575DCC79EE7D4E9B|
|work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md|3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227|

All hashes were checked against the read-only local files. The C-source inspection supports the stated storage and checking behavior; it is not a completed formal proof of the pinned executable or the proposed successor. No existing final theorem, foundational axiom set or frozen certificate was changed.
