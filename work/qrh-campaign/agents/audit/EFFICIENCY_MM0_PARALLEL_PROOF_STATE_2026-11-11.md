# Parallel verification under ordinary MM0 rules

2026-11-11. Source research and an implementation design, not an implemented verifier. No build, proof execution, process experiment, arithmetic evaluation or frozen-source change was performed.

## Conclusion

A verifier can check independent proof tasks in trusted worker threads or processes and join their checked theorem schemas without serially repeating their arithmetic proofs. This preserves the ordinary inference rules if every imported theorem comes from a completed trusted checking task in the same exact theory. The coordinator still checks the dependent theorem applications, final target and all remaining hypotheses.

The pinned `mm0-c` does not implement this interface. It has global mutable proof, parser and environment state. Simply calling its verifier concurrently or trusting success messages from external proof producers would not implement this proposal.

The proposed improvement removes duplicate verification work and exposes genuine task parallelism. It does not remove any task's ordinary arithmetic proof, imply constant memory for an arbitrary dependency graph, or establish a measured speedup. It also does not change the final Goldbach statement or its permitted assumptions.

## 1. Source basis

This extends the accepted [streaming note](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md) and its [independent review](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/independent-feasibility/REVIEW_EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md). Their storage and completion restrictions remain in force.

The source snapshot is `digama0/mm0` revision `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`. The files inspected are in [the local source directory](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/formal-goldbach-bench/mm0/src).

- `verifier.c:479-517` applies an already checked theorem below `g_num_thms`, checks its arguments and dependency restrictions, and runs the statement unifier. It does not replay the theorem's proof body. Required hypotheses are consumed at `297-316`.
- `verifier.c:770-790` checks a theorem body, requires a single final proof value, checks its declared conclusion and hypotheses through `UThmEnd`, and advances the checked frontier. The unifier's final empty-stack conditions are at `233-239`.
- `verifier.c:537-543,600-606` can place a provisional proof value under an outstanding conversion obligation. A proof tag by itself is therefore not a publishable theorem.
- `verifier.c:803-807` rejects accumulated `Sorry` taint. The successor must reject that instruction immediately or prevent every tainted task from publishing results.
- `verifier.c:7-14,674-697` and `verifier_types.c:18-77,99-245` contain mutable global instruction pointers, environment/frontier state, proof stores, stacks and parser state. Worker isolation is a required change.
- `types.c:50-68,96-122` describes the whole-file tables and declaration metadata. Raw offsets into one worker's file or arena cannot be treated as pointers into another worker's state.
- `main.c:38-76` maps one file, initializes the parser and invokes one verification call. There is no trusted worker scheduler or result-import interface here.
- `parser.c:612-681` checks the public declarations against the requested specification. A parallel replacement must preserve this exact binding; `NO_PARSER` is not an acceptable shortcut.

## 2. The logical invariant and finite dependency graph

Fix an exact base theory Gamma, an allowed conservative definition policy and an exact final target T. Gamma includes the complete permitted axiom declarations. A task cannot add a new axiom merely by naming it as an import.

The proposed task graph is a finite directed acyclic graph. Each vertex has an exact expected export schema and a finite list of earlier checked dependencies. A schema includes all binders, sorts, dependency/disjointness conditions, ordered hypotheses and conclusion. A schema may be a generic conditional theorem. Calling it closed means that no unrecorded local assumption or dangling variable remains, not that its displayed hypothesis list is empty.

Maintain this invariant for every committed task result:

    Its exact export is derivable by ordinary rules from Gamma,
    with its recorded binders and hypotheses, and with no undeclared assumptions.

The library establishes the initial invariant. A worker checks task i using only the library, permitted checked definitions and committed dependency schemas. Ordinary theorem application discharges imported schemas' hypotheses at their actual use sites. Substitution of the already established dependency derivations proves the export invariant for task i. Induction in a topological order proves the final result. Independent tasks can be checked in any order because neither imports the other's unfinished result.

This argument also supplies a finite sequential ordinary derivation: rename private declarations freshly, choose a topological order and concatenate the corresponding checked derivations and joins. The expanded artifact need not fit the old 32-bit MMB transport. Changing that transport is separate from changing the inference rules.

A reserved declaration, queued task or partial proof is not a checked dependency. Reject cycles and missing imports, or enforce an equivalent discipline in which every actual import must already be committed. A producer-supplied dependency list is only a proposal; every theorem reference in the proof must resolve to an authorized checked dependency or an earlier checked local declaration. The graph is a checker scheduling design, not an approved declaration graph for the Goldbach development.

## 3. Exact task identity, definitions and result publication

A trusted task record contains at least the following data:

1. A coordinator-issued task identifier and generation, the assigned worker identity, and an internal state such as queued, running, checked or failed.
2. The exact immutable theory/environment identity and dependency descriptors, including their full schemas and defining syntax where needed.
3. The expected export schemas and permitted local definition namespace, plus resource and input-format bounds.
4. The actual completion outcome and the exact exports copied into persistent checked storage.

Hashes may index these objects or detect accidental corruption. A hash match alone does not establish logical equality, trusted provenance or completion. Compare exact canonical data, or use trusted object identity whose construction already guarantees the same data. Bind proof input and expected output together before checking; a worker must not check one statement and publish a producer's different statement afterward.

Allocate declaration names once. Independent tasks use disjoint private namespaces, and all imported definitions have already been checked. A proposed definition may use only available earlier syntax under the ordinary formation rules; future declarations cannot make a cyclic definition acceptable. Shared declarations must be installed once by the coordinator, never raced into existence by two workers. An explicit checked renaming may reconcile equivalent private names, but string equality alone cannot do so.

The simplest numerical exports use only fixed library constructors and concrete numerals. If an export refers to a private definition, retain its complete reachable defining syntax and dependencies, or eliminate it through an ordinary proof before export. Definition bodies may be needed for later conversion even after the proof that introduced them is discarded. Local bound-variable slots and dummy-variable masks must not escape as if they were global identities.

Each worker owns its scratch arena, proof/hypothesis/unification stacks, parser cursor, local frontier and taint state. Its library environment is immutable. Imported theorem references are translated through an exact checked mapping into the worker's environment, not by copying another process's table indices without validation. A worker can use a dense local import table, but its entries must originate in the coordinator's committed table.

Publish atomically only after the task's full declaration and transport-end checks have succeeded. This includes every outstanding conversion, hypothesis and unification obligation; exact output count and statement matching; and absence of taint. A later `Sorry` in a task cannot be hidden by publishing an earlier success-shaped value. The conservative policy is task-atomic publication after the complete input has been accepted. Failure, cancellation, exhaustion or an incomplete input publishes no new theorem.

The coordinator copies the export's exact syntax into persistent storage before releasing the worker arena. A stale task handle must never refer to a later task reusing the same slot. Generation checks, immutable records and checked exhaustion are required. No producer-controlled `checked=true` field changes task state.

## 4. Trusted workers and ordinary joins

With threads, the worker entry point and coordinator belong to one verifier implementation. A private completion object may carry authority only because the coordinator creates it, assigns the exact task and permits only the checker completion path to commit it. The proof language has no operation that writes coordinator state. Memory isolation, lifetime discipline and synchronization are implementation obligations.

With processes, the coordinator launches the trusted checking executable and binds one owned channel to its exact task and generation. The receiver validates message framing, sizes and exact schemas against the task record. Only a completed result from that trusted checker instance may install exports. No raw arena pointers cross the channel. Crash, premature EOF, partial messages or a result for a different task fails the task. The channel's authority comes from trusted process creation and endpoint ownership, not from an untrusted message repeating a nonce or PID. This is a protocol design, not a claim that the current executable implements it.

The trusted worker may receive untrusted proof bytes. It does not receive authority to accept new axioms, bypass a failed obligation, or replace digit-level verification with a native multiplication answer. A producer that merely generates or prechecks a shard is different. Its receipts cannot be imported without ordinary proof checking by the trusted verifier.

On completion the coordinator checks ordinary joins, either itself or as new trusted tasks. It need not recheck the worker's arithmetic body. Joining costs include actual statement parsing, substitution, dependency/disjointness checks, hypothesis applications and result formation. These costs are not zero and can include large numeral syntax. A join that genuinely contains arithmetic must still check that arithmetic; this design does not relabel it as free metadata.

For an adaptive ladder, an independent shard can export a theorem conditional on its exact incoming prime/boundary facts, together with proved outgoing facts. Assembly supplies the first incoming facts from the base proof and each later set from the established prefix. Matching a numerical endpoint does not itself discharge primality or coverage. Exact interval orientation, closed/open endpoints, ordering, gaps and terminal range remain in the join statements.

A proved associative coverage-composition lemma may allow a balanced tree of conditional interval summaries, reducing the join depth. Without that lemma and its boundary premises, assume only the actual sequential join chain. Nor can an adaptive producer's search be assumed parallel merely because checking its already fixed certificate is parallel. No maximal-prime existence or guaranteed search success is inferred.

## 5. Scheduling and bounded live state

A deterministic conservative schedule freezes task descriptions, orders ready tasks by stable IDs and executes bounded topological batches. It can wait for an entire batch before committing exports in ID order. This sacrifices some utilization but gives a simple reproducible schedule. A ready-queue scheduler may run more efficiently; completion timing can vary while every accepted export and the final theorem remain identical. Deterministic logical output does not mean deterministic elapsed time.

Out-of-order completion requires a bounded result buffer. Apply backpressure or restrict dispatch to a bounded window. If an early task fails, later completed tasks do not constitute a proof of the missing prefix. Retries, if allowed at all, must keep the same task identity contract and be charged as additional checking work; acceptance cannot average or vote among failed and successful outputs.

Garbage collection retains every theorem still needed by an admitted future task and the transitive syntax/definition closure of the retained formulas. A checked dependency count can be computed from a validated fixed graph. A producer's last-use hint is insufficient unless later references to a discarded handle are rejected. Reclamation waits until running tasks have released their references.

Let F be the maximum live committed frontier including pending results and all reachable definition syntax. Let A_i and C_i be worker i's scratch and private declaration closure, and B the bounded transport/queue buffers. A shared-library design has the conditional live-memory bound

    M_peak <= M_library + F + sum_active_i (A_i + C_i) + B + M_coordinator.

The sum has at most P active workers. Independent process copies may instead require P copies of some or all of M_library. Read-only shared mappings can reduce physical memory, but simply summing process RSS may double-count those pages. Both the physical-memory metric and sharing assumptions must be stated.

For an arbitrary graph F can grow with the number of tasks. A sequential prefix interface plus a bounded window can keep it to a bounded number of summaries and results, with their actual numeral sizes. A balanced composition schedule can have a logarithmic frontier if generated and reclaimed in a suitable bounded traversal; dispatching every leaf at once can destroy that bound. A graph manifest also occupies memory unless read in a bounded validated form. Parallelism does not solve these storage issues automatically.

## 6. One library check or P library checks

There are two viable designs with different costs.

In the first, one trusted checker establishes the immutable library environment. Threads share it, or trusted child checker processes receive its exact descriptors through a trusted read-only mapping or checked internal copy. The authority to reuse these theorems is the continuing verifier's provenance. A child must not treat a producer-authored descriptor file as a checked library. Relocation, descriptor validation and process startup still cost time and memory.

In the second, each of P persistent checker workers verifies the library itself. This costs P library checks, not one check per shard. A reusable pool then handles many tasks. Imported inter-task results still need the trusted coordinator protocol. These separate library proofs do not by themselves solve that interface.

Launching a fresh standalone checker for each shard may cost N library checks, or force repeated dependency proofs. That is a possible implementation choice, not a necessary cost of the ordinary rules. A completely external untrusted prover followed by a serial final verifier is also valid, but it is a different design and repeats any arithmetic verification already performed by the producer.

## 7. Core-work, wall-time and I/O accounting

Let L be one library check. For task i let V_i be ordinary proof verification, D_i decoding/representation work and E_i export validation/copying work. Let J_k be each actual join task's verification, I_k its input/export overhead, G reclamation/scheduling work and Z final target/end checking. Separate initial transport/startup costs as U. Let ell be 1 for a shared checked library or P for independently checked worker libraries. Then a successful run without retries has total core-work

    W = ell*L + sum_i (V_i + D_i + E_i)
        + sum_k (J_k + I_k) + G + Z + U.

Every arithmetic task V_i is present once. There is no additional serial sum_i V_i unless the selected implementation actually rechecks workers' proofs. Copying schemas is not free, but it is not the same operation as replaying their arithmetic proofs. Retries and redundant independent verification add their real work to W.

For the task-and-join graph, define its weighted critical path C using the same actual per-node costs. With at most P execution cores, elapsed time is bounded below by W/P and by the applicable critical path. It is also constrained by proof input bandwidth, memory bandwidth and serial coordinator work. These are lower bounds whose maximum is relevant; summing them as independent mandatory delays would generally overcount overlap.

For a concrete deterministic batch schedule after one serial library check, a useful model is

    T_wall = L + U_serial + sum_batches max_worker(batch work)
             + nonoverlapped joins/finalization + measured scheduling/I/O stalls.

Each batch assigns at most P independent tasks, and all dependency joins appear at their real positions. Equal shards of verification cost V give about ceil(N/P)*V only when their dependencies, I/O, memory and export work permit it. A mandatory sequential join chain remains a serial cost or an overlapping pipeline bottleneck. Balanced joins reduce that only when the required generic composition is proved.

If P libraries are checked concurrently, the library wall phase may approach L while its core-work remains P*L. If memory or storage serializes those checks, it can be much worse. With a single shared check the library phase is L before workers can use it; workers may decode independent bounded inputs earlier only if that additional work is separately safe and charged.

The verifier reads every proof task's bytes at least once, plus library, joins and metadata. It may map a checked library rather than reread its proof in every worker. Export traffic is the exact retained schema/definition closure, not necessarily a fixed-size hash. Reducing arithmetic core-work does not prove that the full run is compute-bound.

For a fair Lean/MM0 comparison, report ordinary checking work, decoder and join overhead, library duplication policy, physical memory, input bytes, chosen P and critical path separately. A later independent check of the full certificate is another verification run. It can itself use the same parallel rules; there is no logical requirement that it serially repeat all task arithmetic after an already trusted parallel run. Reproducibility still requires the ordinary proof inputs, rather than only exported summaries and receipts.

## 8. Implementation gates and scope

Before crediting measured performance, a successor must implement and review state isolation, immutable imports, exact specification binding, publication, syntax lifetime, fresh names, bounded transport and resource handling. Relevant rejection controls include forged task completions, wrong theory or output schema, stale task generations, undeclared dependencies, cycles, duplicate definitions, escaping locals, unresolved conversions, `Sorry`, truncated input, worker failure and missing coverage boundaries. Different valid schedules should prove the same exact target.

This does not demand a formal verification of the entire MM0 executable while exempting Lean's kernel implementation. Both comparisons must identify their trusted implementation and use the same policy for engineering validation. Conversely neither system may claim unchanged ordinary checking while importing an unchecked arithmetic result or a producer's success flag.

The result here is a same-rule parallel design with an explicit logical induction and cost model. The pinned source supplies theorem reuse and completion checks, but not trusted parallel workers, cross-worker imports, bounded global storage or widened transport. Those remain implementation work. No completed MM0 theorem, Goldbach closure, new numerical evidence or runtime ratio follows from this note.

## Exact source and support pins

All paths below are relative to the workspace root. The inspected local bytes matched these SHA256 hashes. Source line references above refer to these versions.

| Path | SHA256 |
|---|---|
| `work/qrh-campaign/agents/audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md` | `53AD15DAE3EE3F19B1ABEA27B26F4ECD593ED7F6C557001FC2BF2A5B7957FE40` |
| `work/qrh-campaign/agents/independent-feasibility/REVIEW_EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md` | `8BC3923014640241C3D40EDB1D8DD85C35922D8E2D18C11898D3D307C6A33886` |
| `work/formal-goldbach-bench/mm0/src/verifier.c` | `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5` |
| `work/formal-goldbach-bench/mm0/src/verifier_types.c` | `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E` |
| `work/formal-goldbach-bench/mm0/src/types.c` | `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1` |
| `work/formal-goldbach-bench/mm0/src/main.c` | `ECDE31379241E38CA0B375DF0F40B216E9108F6CFD45952CCB282658D883DE17` |
| `work/formal-goldbach-bench/mm0/src/parser.c` | `695BF56B4FE190E6BA369A8BE854CD1031B2624929FC5FDA995551E7BAD00C39` |
| `work/formal-goldbach-bench/mm0/src/README.md` | `5ADA16E00CD2F72E7F83D247768CDE6ADE34E56962B1858BC014FABEDC900A70` |
| `work/mm0-fermi/sources-manifest.json` | `3A1D00A2A7BCC5F59D9E6EDF6E69A364E9BF51CA0E4332CFEDB46AE3EB174AC5` |
