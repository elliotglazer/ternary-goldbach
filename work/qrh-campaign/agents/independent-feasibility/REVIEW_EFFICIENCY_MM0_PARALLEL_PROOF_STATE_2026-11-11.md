# Review of parallel ordinary-rule MM0 checking

2026-11-11. PASS at source/research and implementation-design scope. No correction to the author is required. This result does not certify an implemented parallel verifier, bounded memory for arbitrary graphs, or a measured speedup.

The author is `audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md`, SHA256 `4927B1604C4E13A001CDD3C9176F024D11A3FA8ECB0C6EB35F3C70A0B9F100FE`. I verified all nine source/support pins, read the full report, and compared it with the source behavior checked in my frozen streaming review, SHA256 `8BC3923014640241C3D40EDB1D8DD85C35922D8E2D18C11898D3D307C6A33886`. I also read the global environment declarations and additional mutable parser state. No executable, proof or analytic evaluator was run; no source or earlier report was edited.

## Source behavior and actual new work

The source supports ordinary theorem reuse, not concurrent calls to the existing checker. `verifier.c:479–517` applies a checked theorem schema, verifies sorts and dependency conditions, and runs its statement unifier without replaying its derivation. `297–316` checks theorem hypotheses. The completion path at `770–790`, including the unifier's checks at `233–239`, validates a declaration's final proof, conclusion and hypothesis list. These support the proposed result interface.

The mutable state is real. `index.c:6–9` declares the current file, environment tables and frontiers. `verifier.c:7–14` holds instruction cursors and taint. `verifier_types.c:18–77,99–245` contains proof, unification and parser arenas, stacks, tables and cursors. Merely invoking this implementation from several threads would share those variables. The proposed worker-local state, immutable library and mapped imports are necessary implementation changes. No reviewed text treats the stock executable as already having them.

The additional inspected source `work/formal-goldbach-bench/mm0/src/index.c` has SHA256 `88214D057AD2C1E7569357022948C0CEA1417B2B82A3FE5CE2F8C61BB176A1AC`. The author ledger pins the other source files cited here.

The public specification check at `parser.c:612–681` remains part of acceptance. Neither a worker's internal proof consistency nor a theorem name alone binds its result to the intended target. Raw offsets and expression identities are local to a worker's arena/file and require an exact translation or persistent copy.

## Same-rule dependency argument

For a fixed theory Gamma and permitted conservative definitions, attach to each committed export its exact schema and ordinary derivability from Gamma. The export includes its formal binders, disjointness conditions and hypotheses. Conditional schemas are allowed; a final unconditional target must still discharge their premises at use sites.

A task checks only against the library, already committed dependencies and earlier accepted local declarations. Substituting those established derivations proves the invariant for the new export. Topological induction proves the final target. Equivalently, fresh-renamed local declarations and all checked tasks can be arranged in a sequential ordinary proof, retaining theorem reuse rather than textually duplicating each dependency proof. The argument does not depend on the resulting file fitting the old 32-bit transport.

This reasoning would fail for merely reserved declarations, circular future imports or an unverified producer dependency list. The author explicitly checks actual references and readiness. Disjoint local namespaces and immutable shared declarations preserve freshness. A live private definition must retain its defining syntax and dependency closure, or be eliminated before export. Recycling a bound-variable slot cannot substitute for renaming. These conditions suffice for the proposed mathematical implication; their implementation remains to be supplied.

## Result authority and completion

The trusted-worker proposal and untrusted production are correctly separated. A continuing verifier may reuse a result checked by its own worker through a channel or object whose authority is established by that verifier. The exact assigned task, environment, expected schemas, generation and completed result must match. A nonce, PID, digest or producer-supplied success field cannot create this authority.

Publication must remain task-atomic. `Conv` and `ConvCut` can place provisional assertions below unfinished obligations, and the non-BARE source postpones global `Sorry` rejection until the end. A proof-shaped tag or an early successful declaration is therefore not enough. The author's complete-input, exact-output, no-taint and all-obligations-discharged policy prevents those shortcuts. Failure, truncation and cancellation publish no new theorem.

On those conditions, the coordinator need not serially repeat a worker's arithmetic body. It must still check the actual join applications, including substitutions, hypotheses, interval boundaries and any arithmetic genuinely present in the join. A separate independent verification run may use the same parallel design, but it needs ordinary proof inputs rather than the first run's receipts. Trusted process result transport is a new implementation facility, not a portable unchecked theorem import.

## Cost and memory conclusions

The work model counts each successful arithmetic task once, its decoding/export cost, real join work, scheduling/reclamation, library policy and final target checks. It does not conceal a second serial arithmetic pass. Nor does it call arithmetic performed during proof generation free: that lies outside verification work and must be included separately in an end-to-end estimate.

One shared checked library costs one library proof check, with actual sharing/copying overhead. P workers independently checking their own persistent library copies cost P checks. Reinitializing a fresh worker for every shard can cost N checks. The source does not force the last policy. Retained instance caches, separate address spaces and physical shared pages need their actual memory accounting; summed process RSS is not automatically physical memory use.

The frontier bound is conditional and correctly stated. It includes committed dependencies, pending results and their definition closure; running workers retain referenced data until completion. Backpressure or bounded dispatch limits out-of-order results. Arbitrary DAGs can still require a large frontier and manifest. A prefix-style interface with bounded lookahead can bound the number of live summaries, while their numeral widths remain real. A balanced composition tree only improves span after its actual associative join theorem and boundary hypotheses are available.

The bounds W/P, weighted critical path and bandwidth constraints are lower bounds, not a predicted elapsed time or additive mandatory delays. The batch formula leaves synchronization, imbalance, serial joins and stalls visible. No ideal P-fold speedup follows from this review.

The fair comparison with Lean is preserved. Both require an identified trusted implementation and the same engineering validation policy for parsing, result transport, lifetimes and ordinary inference. A formal proof of the whole MM0 executable is not imposed as a special prerequisite absent from the Lean comparison. Conversely, neither may count unchecked arithmetic or worker receipts as ordinary checked proofs. The next useful evidence is an implemented and independently reviewed worker/result protocol plus complete ordinary proof packs; this paper establishes its sound design conditions only.
