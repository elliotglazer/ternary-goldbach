# Review: ordinary-backend accounting and local proof reuse

2026-11-11. **PASS at bounded paper/static-source scope; no correction requested.** Reviewed author `audit/ORDINARY_BACKEND_ACCOUNTING_AND_LOCAL_REUSE_2026-11-11.md`, SHA256 `0E7920DAAD05D434AF6FBD6CBDE79963BE1210417066F734285D23BC18718A50`.

The new composition correctly separates arithmetic-template events, proof-stream commands, executed unifier headers, serialized bytes, allocation/traffic and theorem-local reuse. Its stock closed-fact caching substitution is valid under the stated exact-object and lifetime premises. It establishes neither actual workload reuse frequencies nor an end-to-end speedup.

I authored the earlier event-expansion packet E57FCF24. That earlier result is an input here, already independently reviewed at `70A5D74BF6D4A5D6FF38B85B3D85F528D7E33E8E49329AF114DD1B4CED0F493C`. This review does not claim a new independent validation of my own earlier derivation. I independently checked the present author's new accounting composition and local proof-cache transformation directly against the pinned C bodies. The zero-carry, named-private-theorem, numeral-binding and streaming packets retain their separate original scopes.

## 1. Actual instruction semantics

The decisive files are workspace-relative:

| File | SHA256 | Inspected scope |
|---|---|---|
| work/formal-goldbach-bench/mm0/src/verifier.c |71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5|93–109,150–198,212–280,382–392,414–517,767–790|
| work/formal-goldbach-bench/mm0/src/verifier_types.c |87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E|Stack/heap tags and capacities,18–36; term layout|
| work/formal-goldbach-bench/mm0/src/types.c |B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1|Command-size flags156–160, packed layouts205–208 and proof opcode declarations|

`Thm` and `ThmSave` share the same verifier branch. It pops the explicit conclusion expression and expression arguments, checks argument sorts/dependencies, executes `run_unify(UThm,...)`, then pushes `STACK_TYPE_PROOF | e`. For the save opcode it additionally appends exactly that tagged offset to the local heap. There is no second conclusion allocation and no separate Save instruction required.

Ordinary proof `Ref` retrieves the existing heap slot. For a proof-tagged slot it pushes that same stack value; it neither re-applies the global theorem nor calls `run_unify`. The conversion-slot branch is different and does not license treating an unfinished conversion obligation as an ordinary closed proof. The report explicitly excludes that shortcut.

Unifier `URef` compares the saved arena offset with the current target offset. `UTerm` checks the term head and pushes its children. Consequently semantic equality, equal printed digits or a common hash is not automatically the identity required by a parameter substitution. `Term` allocates a new node and performs its child/type/dependency work. These operations justify retaining object construction and unifier work separately from proof opcode counts.

## 2. Matched local transformation

Fix a used closed fact, so v>=1. It has zero expression arguments and zero premises, is already established by a permitted ordinary theorem, and its exact conclusion expression is constructed and saved. All source conversions and surrounding operations are held fixed.

Without proof caching, each request is one expression Ref followed by Thm:2v proof commands and v header executions. With caching, the first request is expression Ref followed by ThmSave; each subsequent request is one proof Ref. This uses2+(v-1)=v+1 commands and one header execution. Each request leaves the same checked proof-tagged conclusion in the position consumed by the unchanged continuation. The first-use save adds one heap slot pointing to the existing conclusion.

Thus the report's savings v-1 and `(v-1)*h_j` are exact for this matched call sub-schedule. They are not a claim that a current producer redundantly instantiates those facts. For a chosen set of used facts, summing gives the stated per-fact formula; for q distinct cached facts with L total requests it gives2L versus L+q. A fact with zero requests need not be cached and is not an instance of the v>=1 calculation.

Closed-fact production, first instantiation, conclusion construction, operand/source/range conversions and proof of the reusable arithmetic schemas remain outside this difference. A parameterized range fact cannot be charged as a zero-argument closed lookup. If the earlier full-DAG count already uses one fresh proof node plus cached premise edges, subtracting these savings again would double-count. The author retains that restriction.

## 3. Commands, executed headers and bytes

For the previously reviewed connected first-use scheduling fragment, the command identity `I_body=H+R+C+2` remains a particular schedule with conversions and other excluded operations separately charged. The new record correctly adds actual theorem-header invocation multiplicities, argument/dependency checks, constructor arities, object bytes and lifetimes. A stored header's one-time byte cost differs from executing it on every fresh theorem application. Declaration-final matching and definition unfolding are additional invocations with their own modes.

The source packed structures and decoder establish legal command sizes1,2,3,5 bytes. For a complete known body containing I such instructions, I<=body_bytes<=5I is valid. It is not a bound on the omitted source/library/declaration/header data, trailing file padding or total accepted certificate size. No proof bytes are inferred from an incomplete arithmetic subtotal.

For the stated expanded-radix zero-carry representation, the inherited134-instruction cell header gives134*256=34304 executed header instructions for16-by16 cells. The conditional arithmetic-event expression gives5*256+2*16+1=1313, while the inherited zero-carry body expression gives20*256+22*16+1=5473 before D+C. These fixed hand calculations agree. They are three distinct units. The134 figure is not a universal minimum for other radix/name/header layouts.

The proof-reference replacement's local byte difference is the old expression-reference length plus theorem-ID instruction length minus new proof-reference length. ThmSave has the same encoded-ID width as the corresponding Thm. Added heap slots can nevertheless push this or unrelated references across encoding thresholds. Retargeting all affected references and including those external changes is necessary before claiming net byte savings. The paper states this rather than deriving bytes or time from v alone.

The symbolic work model is also correctly qualified: if an opcode price already includes argument checks or allocation, those operations cannot be added a second time. No measured linear law, clock estimate or comparison to Lean's own reduction costs follows from assigning names to the unknown prices.

## 4. Capacity, reset and binding limits

The stock heap is65536 u32 slots; the expression store is2^26 bytes. `push_heap` checks capacity before appending, and the allocator checks store capacity. A local cache entry can add no expression-store bytes when the exact conclusion already exists, but still consumes a heap slot and a write. Saving all196608 facts of a complete radix256 table is impossible in that local heap. A checked global theorem catalogue is not an already-instantiated local proof cache.

There is no assumed within-proof eviction or reuse in the stated schedule. `load_args` resets the heap, and each theorem declaration resets the store and proof stacks before checking its body. Local proof offsets do not survive that reset as valid imported objects. Reusing the checked theorem in a later block requires an ordinary instantiation and the new context's exact conclusion representation, unless a separately justified implementation explicitly retains valid state.

The bounds `heap_base+|S|<=65536` and `store_base+store_added<=2^26`, together with the other actual stack limits, are therefore appropriate. The report does not mistake the heap bound for a sufficient complete admission proof. Existing saved terms/proofs, source conversions, digit validity, signs, imported library facts and theorem boundaries remain charged. Block-local distinct-fact counts must sum over blocks; neither a global distinct count nor a private theorem name removes those costs. The same qualification applies to parallel worker-local caches.

## Evidence and verdict scope

All fourteen hashes listed by the author matched in a read-only source-pin check. I read the complete author note and the decisive verifier bodies, and checked the few displayed arithmetic identities by their explicit expressions. No author metadata program was rerun. No inventory, digit table, proof stream, build, value evaluator or timing experiment was executed, and no frozen artifact was changed.

The report is accepted as a concrete accounting/interface improvement: a full backend bill needs application/header/object-lifetime data, and stock ThmSave/Ref can avoid repeated closed-fact instantiation inside a fitting theorem-local context. Actual v_j, cache set S, identifiers, signed proof shapes and complete source/term binding remain unknown workload data. The review grants no blanket compression, sublinear-verification, end-to-end performance, formal-library or numerical-certificate conclusion.
