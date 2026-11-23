# Ordinary-backend accounting and bounded concrete-proof reuse

2026-11-11. Bounded paper/static research. No proof emission, build, numerical value, table enumeration, metadata fold or timing was performed. This report proposes an accounting correction and a concrete ordinary-instruction reuse interface. It does not change the selected arithmetic, source or precision baseline.

## The unresolved conversion

The largest structural gap in the present end-to-end model is the conversion from typed arithmetic-template events to complete checking work. “Largest” here identifies the common uncalibrated conversion affecting the repeated arithmetic bill, not an experimentally established largest runtime component. Actual principal, finite-coverage, library and repair costs could still dominate.

The current papers already distinguish events from commands and bytes. The missing composition is a workload record that retains theorem-application signatures, executed unification headers and concrete-object lifetimes together. A single event-to-command multiplier, followed by a single command-to-time multiplier, is not justified by those papers. The same event count can have different source bindings, cached premises, statement matching and allocation costs.

The accepted zero-carry cell, its 20mn expression and checked-private-name result are inputs here, not new improvements. The end-to-end inventory is read with its mandatory principal-head erratum: no separate N1500/Q1500 obligation belongs to the selected original-RH consumer merely because another route uses it. Its corrected ladder count remains unchanged. No historical operation count is promoted to a current production count in this report.

## 1. A concrete accounting correction

For one legal connected first-use proof DAG, the reviewed expansion uses V new theorem applications, H premise edges, R=sum(a_v+1) argument/conclusion requests, T new term nodes and C constructor-child requests. Its body command count, including one END, is

    I_body = H + R + C + 2.                         (1)

This is a particular proved scheduling formula, not a universal minimum. Add conversions, definitions, hypotheses and other commands outside that fragment explicitly. In particular a parameterized bound theorem is not a unit-cost closed fact.

Extend each block's record to retain, at minimum,

    (I_by_opcode, N_apply_by_exact_header, U_by_opcode,
     constructor_arities, argument/dependency checks,
     new_object_bytes, retained/reloaded_objects,
     command_ID_lengths, library/import/join work).  (2)

Here U counts executed unifier instructions, not stored header bytes. If theorem j has a fixed h_j-instruction header and is newly applied N_j times, its contribution is N_j*h_j, even though the header is stored only once and its proof body was checked only once. Include definition unfolding and declaration-final matching separately. Count the opcode/child/dependency operations of those headers when machine-work distinctions matter; equal instruction counts need not mean equal machine costs.

The pinned verifier supplies the reason. `verifier.c:479-517` consumes an explicit conclusion and arguments, checks argument types/dependencies, then calls `run_unify` on every Thm/ThmSave. `URef` at 241-249 compares a saved arena identity; `UTerm` at 252-280 checks a head and pushes its children. `Term` at 414-470 allocates a fresh node and checks its arguments. Sharing whole numeral leaves can avoid walking their digits, but independently reconstructed equal numerals do not thereby share identity.

For scale only, the already reviewed expanded-radix zero-carry stencil has 134 header instructions per cell. In its stated representation, mn such applications execute 134mn header instructions in addition to the proof-stream command work. For m=n=16 its arithmetic template has 1313 events; its inherited equality-body core is 5473+D+C commands; the cell-header contribution alone is 34304 executed header instructions. These are three different units, not three alternative timings. The header figure is representation-specific: a different admitted header or named radix must be counted from that representation. It is not a universal lower bound and is not added again to serialized body bytes.

An explicit symbolic checking-work model is therefore

    W_check = W_library + W_parse/import/join
              + sum_o price_proof[o] * I[o]
              + sum_o price_unify[o] * U[o]
              + W_argument/dependency + W_allocation/traffic.

The prices denote unknown implementation work in one chosen coordinate. If an opcode price already includes some argument or allocation work, remove that work from the other terms. This is exhaustive accounting with named unknowns, not a measured linear runtime law. Peak memory and critical path are separate quantities.

Expanded body bytes are instead exactly the sum of the actual encoded instruction lengths. In the pinned format those lengths are 1, 2, 3 or 5 bytes, depending on opcode data. Add tables, headers, declarations, source specification and representation data once at their real lifetimes. Legal body command counts consequently bound body bytes between I and 5I, but this says nothing about the number of commands omitted from an arithmetic subtotal, header execution frequency, total file admission or time. A compressed archive or deterministic producer recipe is not the expanded checked stream.

## 2. An ordinary-rule local reuse primitive with an exact benefit

One inexpensive representation step can close part of the gap without a new arithmetic rule: save a newly established CLOSED table fact as an actual local proof object, then use proof Ref for repeated uses inside the same theorem body. The fact must have zero expression arguments and zero proof premises, and its exact term representation must match every consumer. This includes neither parameterized lookup nor a native claim that a table entry is correct.

Compare two precise schedules. In both, the fact's conclusion expression is already constructed and saved, all digit/source conversions are identical, and all surrounding arithmetic follows the same order. If the fact is requested v times:

- Without proof caching, each request uses one expression Ref and one Thm: 2v commands and v executions of that header.
- With caching, the first request uses the same expression Ref and ThmSave. The remaining v-1 requests use proof Ref. This is v+1 commands and one execution of that header.

Thus the replacement saves exactly v-1 body commands and (v-1)*h_j executed header instructions in this matched schedule. ThmSave is one command, not Thm plus a separate Save. It adds one local heap entry; it does not copy a second conclusion tree. This is a concrete use of stock instructions, not a claim that an already optimized producer fails to use them.

The source supports this substitution directly: `verifier.c:514-517` saves the checked proof-tagged conclusion; `382-392` retrieves the exact heap entry by Ref. It avoids a new theorem application, not the proof of the table fact or the first instantiation. Require the fact to be an earlier ordinarily proved theorem in the permitted theory, with no Sorry or undischarged conversion obligation. Surrounding source/range facts remain separately required. Provisional values created by conversion rules cannot be published as independently completed facts.

For a block, let v_j be actual requests and S the chosen cache set. Put

    L = sum_j v_j,
    Delta_I = sum_(j in S) (v_j-1),
    Delta_U = sum_(j in S) (v_j-1)*h_j.           (3)

When every used fact is cached, q distinct facts give 2L commands versus L+q for this call sub-schedule. No distribution of actual table entries is assumed. These substitutions must be made inside the complete DAG count, not deducted a second time if its D count already represented first applications and its other premise edges already used cached proofs.

Byte savings require actual IDs. For a repeated call, the local difference is

    ell(expression_ref) + ell(theorem_ID) - ell(proof_ref).

Saving extra heap entries can push unrelated Ref IDs across an encoding threshold. Include that external byte change and any changed term/import schedule before claiming a net byte reduction. Command savings in (3) do not determine proof-byte savings or checking-time savings. This is one sufficient local reuse policy; it is not claimed to be the cheapest possible certificate representation.

## 3. Memory and theorem boundaries constrain the reuse

The stock heap has 65536 entries and the expression store has 2^26 bytes (`verifier_types.c:28-36`). A complete radix-256 arithmetic table has 196608 facts. Thus one cannot place a separate local proof entry for every fact in a single stock theorem heap, even before saving operands or conclusions. The global checked theorem catalogue and the local proof heap are different objects. Private theorem names do not remove this local capacity limit.

For a chosen block require

    heap_base + |S| <= 65536,
    store_base + store_added <= 2^26,

as well as the actual stack and other limits. The matched construction above can have store_added=0 for the proof-cache entries because their conclusion expressions already exist; those expressions and the base heap are still paid. Entries used for unrelated saved terms and proofs count in heap_base. A candidate that constructs new conclusions to enable caching must add their real storage and command costs.

Stock heap entries accumulate until the declaration reset; there is no assumed within-proof eviction or slot reuse here. Use a fixed fitting subset S or a bounded theorem block. At the next theorem, `load_args` resets the heap and the declaration branch resets the store (`verifier.c:176-198,767-790`). Local cached proofs must be re-established in that context, or imported through a separately justified retained-state implementation. The source's checked global theorem permits re-instantiation; it does not carry the former local pointer across the reset.

For N blocks, replace any global distinct-fact count by sum_s q_s and any reuse count by the actual per-block v_sj. Larger blocks can reduce re-instantiation but increase stored terms, ID lengths and memory. This is the missing tradeoff, not evidence for a particular optimum. Parallel workers likewise pay their actual local imports and cache establishments. One shared checked library versus P independently checked libraries remains a separate already-reviewed choice; neither implies serial replay of all completed arithmetic.

## 4. What a fair end-to-end estimate still needs

The actionable correction is to report (1)-(3) beside every future complete backend workload, rather than map unsigned byte events directly into proof bytes or checker time. The cheapest next static deliverable is a matched ordinary-instruction specification for one full signed rounded multiplication, with exact source/output binding, table/range producers, materialization and cache lifetimes. It can instantiate these variables without a global fold. No proof emission is authorized by this suggestion.

Existing width/category histograms can count the unsigned arithmetic skeleton and some setup multiplicities. They do not determine actual digit-table request frequencies, the set S, repeated term objects, reference IDs, signed-case proof shapes or source conversions. Those are missing data, not zero costs. The very conservative public-numeral decoder in the reviewed binding paper is one available upper schedule; it is not mandatory on every intermediate when the pipeline retains an admitted byte-word interface. Public boundaries must still be proved, rather than silently avoided.

For Lean use the same exact mathematical input/output/error contract and complete witness workload, but derive Lean term construction, elaboration and kernel checking from its own implementation. MMB command and unifier counts are not Lean reduction counts. Generic theorem reuse exists on both routes; its implementation-specific sharing and conversion behavior must not be priced by a multiplier borrowed from the other system. Missing analytic libraries and final-source bridges remain separate setup/validation gates, not arithmetic zeros.

This report supplies no universal lower bound proportional to all arithmetic events times a full numeral, and no claim of sublinear verification. Regeneration and compression can reduce stored bytes while retaining ordinary checks. It also supplies no final time estimate. Principal RH/count production, required finite binary coverage, prime-chain witnesses, strict signs and completeness, repairs and library validation remain outside the local correction and may overturn any arithmetic-only ranking.

## Evidence

All fourteen hashes were checked read-only. Agent paths below are relative to work/qrh-campaign/agents; C-source paths are workspace-relative. The decisive C bodies were inspected directly. Other mathematical papers are consumed at their stated reviewed scope, without a repeated foundational audit.

| Artifact | SHA256 |
|---|---|
| audit/END_TO_END_COST_INVENTORY_AND_PRIORITIES_2026-11-11.md | 756DC55EF39C35597C17939339BA4C2CCC5E40A701DFB5073D4DDA31FE23E69C |
| audit/ERRATUM_END_TO_END_COST_PRINCIPAL_HEAD_2026-11-11.md | 3A190899E4CC87A1D50A451CD19FF55698A7FE2A0845F92C76CFBE1F9A4154F9 |
| zero-sum/REVIEW_END_TO_END_COST_INVENTORY_AND_PRIORITIES_2026-11-11.md | 0ACA83A79F3CAA42E5E51C7CA7493A0D6028CC6B4A6345B508FFE37CF61F51C5 |
| audit/EFFICIENCY_MM0_SPECTRAL_PROOF_VOLUME_2026-11-11.md | B171309E58A36A2F9F708CD663118577C660423A1C424CB1544DBC6D48AB5408 |
| moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md | E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6 |
| zero-sum/PA_RADIX256_ZERO_CARRY_CELL_2026-11-11.md | 493812A2A73D0EF32FF8052F494EEFC91AFF15AF0ECC430B6379FB046B9E2DC5 |
| prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md | F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2 |
| independent-feasibility/PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md | 67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59 |
| prime-estimates/NAMED_W12_STOCK_ADMISSION_AUDIT_2026-11-11.md | 39EFC3048C8F4CF7F775CA140DA62B0044734AC83056D5E5F3CB516F8D50B8EF |
| audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md | 53AD15DAE3EE3F19B1ABEA27B26F4ECD593ED7F6C557001FC2BF2A5B7957FE40 |
| audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md | 4927B1604C4E13A001CDD3C9176F024D11A3FA8ECB0C6EB35F3C70A0B9F100FE |
| work/formal-goldbach-bench/mm0/src/verifier.c | 71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5 |
| work/formal-goldbach-bench/mm0/src/verifier_types.c | 87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E |
| work/formal-goldbach-bench/mm0/src/types.c | B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1 |
