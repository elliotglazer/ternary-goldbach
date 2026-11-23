# Review of bounded MM0 proof state

2026-11-11. PASS at source-behavior and proposed ordinary-rule storage-design scope. No correction to the author packet is required. This is not approval of an implemented successor checker or a measured memory/time claim.

Reviewed author: `audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md`, SHA256 `53AD15DAE3EE3F19B1ABEA27B26F4ECD593ED7F6C557001FC2BF2A5B7957FE40`. I verified its nine source/support hashes against the local files. The source manifest identifies revision `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`. I read the relevant actual C bodies, not only the preceding reports. No source was edited, imported or executed; no build or proof evaluation was performed.

## Stock behavior and its limits

`verifier.c:178–200` resets the local heap and bound-variable allocation when loading declaration arguments. At `770–790`, a theorem resets the expression store, main stack and hypothesis stack, runs its proof, requires one final proof-tagged expression, checks the declared statement and hypotheses, and advances the theorem frontier. `run_unify:233–239` requires both the final hypothesis stack and unification stack to be empty in theorem-end mode. These checks support forgetting the completed local derivation while retaining the theorem declaration.

`verifier.c:479–517` permits theorem application only below `g_num_thms`. It checks argument sorts, dependency/disjointness conditions and the statement's unification program. `297–316` consumes proof-tagged premises for required hypotheses. There is no replay of the applied theorem's original derivation. Thus charging every stock merged-file shard a new verification of the entire library or old prefix is incorrect.

`Ref` and `Save` at `382–395` and `619–632` refer to the current heap. A stored instance of a generic table theorem does not survive a later local reset merely because the generic declaration survives. A persistent cache of those instances would require a new checked access mechanism or repeated instantiation. The report prices these alternatives separately.

Global term/theorem descriptors remain in the mapped file. `types.c:50–68,96–122` fixes their counts/offsets to 32-bit fields. Local declarations at `verifier.c:759,790` still advance global counters. `main.c:38–76` maps the whole MMB file. These facts do not imply that the operating system keeps all mapped pages resident, but they do refute any claim that stock MM0 already supplies the proposed bounded global environment and streaming transport. Raising scratch limits alone does not fix the format and growing-metadata limits.

The public parser is part of the target-binding argument. `parser.c:612–681` checks declaration kind, binders, expressions and duplicate names against the public specification. As the pinned README says, `NO_PARSER` permits proving an unintended trivial statement. A replacement transport must preserve exact theory and target binding rather than use that option as a shortcut.

## The prefix invariant is sufficient

The proposed state is a checked theorem of a fixed theory, with a small endpoint/boundary statement. Each transition proves a new closed statement by ordinary rules from the fixed library, the previous state theorem and the current shard's proved facts. Induction on accepted transitions gives ordinary derivability of every installed state. The last transition must prove the exact target and discharge the initial, terminal and boundary conditions.

Deleting an old theorem handle after this transition is environment restriction, not a new arithmetic rule. Conceptually retaining all declarations under fresh names produces an ordinary finite proof with the same theorem applications. The author correctly separates that mathematical argument from whether this expanded proof fits the old MMB container.

A short interval-coverage proposition can summarize many earlier instances without keeping a witness list in its syntax. This depends on a proved generic join theorem. If the next shard needs a last-prime fact, that fact must be in the retained interface or re-proved. Conditional shard theorems do not become closed facts until their incoming premises are discharged. The report does not assume either implication for free.

Definition lifetime is correctly stricter than proof-body lifetime. A surviving formula, type, or subsequently unfolded definition needs its full reachable syntax and meaning. The proposed fixed-constructor interface avoids private witness definitions; otherwise export must retain their closure or prove their elimination. Freshness, dependency masks and binder scopes must also survive relocation. Checked exhaustion and generation-tagged handles can prevent a stale reference from naming a new theorem, but those mechanisms remain implementation obligations.

## Provisional values and failure state

The strongest potential counterexample is explicitly excluded. `Conv` at `537–543` pushes a proof-tagged value below a pending conversion obligation. `ConvCut` at `600–606` similarly introduces a provisional conversion assertion. A collector that keeps the tagged value and drops its guard is unsound. Only copying after the full declaration-end checks avoids this issue; arbitrary mid-proof tags are not independent certificates.

The non-BARE `Sorry` path accumulates a global taint and rejects at file completion. Stock frontier advancement alone is therefore not an assertion that an externally exportable ordinary proof has been obtained in a tainted run. The proposed implementation must reject `Sorry` immediately, or keep the taint and prohibit export as specified. It must also preserve rejection/incomplete state across resets. None of these checks can be replaced by a successful-looking shard log.

Within a continuing trusted checker execution, checked provenance can survive deletion of proof history. Across a restart, an untrusted statement plus hash or `verified=true` flag has no such provenance. Replay, a genuinely continuing trusted process, or an explicitly trusted persistence mechanism is necessary. Independent reproducibility still requires the ordinary proof stream or its reproducible generation. The proposal neither adds a checkpoint axiom nor imports a worker's success receipt as a theorem.

## Cost and fair implementation trust

The proposed accounting correctly separates one library check, each shard's ordinary proof and join work, parsing, reclamation, retained declarations/instances, and live export closure. Its live-state bound is conditional on the bounded export policy and bounded shard sizes. Endpoint/identifier widths can grow with the target. Deletion does not reduce the total ordinary arithmetic inference count or bytes that a new independent check must consume.

The successor is a different implementation with the same intended inference rules. It needs review and tests for lifetime, relocation, malformed inputs, exhaustion and exact statement binding before measured cost can be credited. This is an engineering trust obligation of the same kind as trusting Lean's kernel implementation, parser/environment boundaries and memory management. This review does not demand a formal proof of the entire MM0 executable while exempting Lean. Conversely, neither system may replace an ordinary arithmetic proof with an unchecked native answer and call the trust boundary unchanged.

The useful decision is therefore to benchmark ordinary proof packs under a reviewed bounded-state implementation, with library checks and local table instantiations accounted for once in their actual locations. The source supports this as a credible implementation direction. It does not establish current bounded-global-memory support, a portable checked checkpoint format, completed formalization, or any numerical speed ratio.
