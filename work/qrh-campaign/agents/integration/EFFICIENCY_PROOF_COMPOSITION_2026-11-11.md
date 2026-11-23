# Proof composition for large finite certificates

2026-11-11. Paper/source design. No prover, prime search, analytic evaluator or production certificate was run. The only new computations were exact integer ceilings and byte counts. This is an implementation proposal, not a formal proof or a timing estimate.

**Recommendation:** preserve each workload's shared arithmetic circuit, check bounded packs with one generic soundness theorem, and export short complete-range conclusions. Separate arithmetic batch size, logical proof-pack size and physical shard size. For stock Lean, investigate the existing module system's private implementation/export boundary; do not assume legacy imports discard witnesses. For ordinary MM0, generate one fully checked proof stream with reusable theorem references and bounded per-proof scratch; independently accepted shard claims cannot simply become axioms in that stream. Price generation, final checking and imports separately.

The relevant next experiment is two distinct complete packs plus their composed root, including a shared source-fact table and a false-boundary test. A single modular exponentiation or repeated identical theorem does not measure this architecture. That experiment requires later authorization; this report creates no declarations or executable checker.

## 1. Three sizes, one exact domain

Let q be an arithmetic batch size, k the number of internal items covered by a proof pack, and f the number of packs placed in a physical shard. These are different choices. The existing Proth checker has q=32 and k=4096. Increasing k must not silently replace its 32-candidate product by a k-candidate product: the latter changes big-integer costs. A spectral batch is a shared transform circuit, not one independently recomputed character. A binary tile is a complete residual-coverage computation, not one theorem per even integer.

Use a fixed mathematical domain descriptor D, a complete canonical enumeration of its required slots, and an interval [a,b) of that enumeration for each pack. The public mathematical conclusion is that every required item in that interval satisfies its semantic predicate. The descriptor contains actual exact parameters, not merely a hash: binary cutoff and parity; ladder candidate rules and endpoints; or conductor, character labels, actual function normalization and height obligations. File digests bind production artifacts operationally but do not define primehood, analytic functions or coverage.

A generic pack theorem consumes: (i) sound shared facts, (ii) an exact decoded finite witness, (iii) successful acceptance of the entire pack, and (iv) the interval/domain binding. It returns a short interval theorem, existentially hiding witnesses where appropriate. Sound adjacent-range composition proves coverage of [a,c) from [a,b) and [b,c). A balanced tree has P-1 joins and depth ceil(log2 P) for P nonempty packs. Exact adjacency, final short pack, bounds and domain equality are checked. Hash equality is never a substitute for those equalities.

Incomplete tiles retain an explicit residual invariant. They are not complete-pack theorems. This distinction permits checkpoints without letting skipped entries disappear from the proof. The complete final theorem must also consume the separately certified small/initial range and analytic large range; the original BinaryGoldbachInput is an obligation to discharge for the new unconditional full target, not an allowed extra assumption.

## 2. Concrete shared data and mathematical outputs

| Workload | Shared inputs checked once at the appropriate scope | Pack output and composition boundary |
|---|---|---|
| Binary coverage | Source prime bitmap meaning, anchor-prime facts, exact source slices; a bit need only imply primality, not enumerate every prime | Every even target in the exact tile is represented. Residual starts as all W bits; updates/splits preserve the exact residual; zero or exhaustive prime-pair exceptions discharge it. Initial L-2 targets and the last width E-floor(E/L)L+1 remain explicit, including width one when L divides E. |
| Mixed Proth ladder | Generic modular/Proth theorem; shared general-prime factors and certificates; each base group's product and V/A chain | Every required rung has a certified prime in its prescribed interval; first/last and inter-rung gap facts imply coverage. A group skips no original indices: either advance through every index or prove the gap-power invariant. Changing the product modulus invalidates old residues unless a congruence adapter is proved. |
| Spectral tile | Exact source/CRT/primitive/inverse map; one coefficient enclosure and transform-circuit proof for the actual inputs; elementary tables with explicit accuracy/domain | Certified signs or cluster counts with actual function/phase identities and exact rational ordinates. Closure is per character/conjugate orbit, using central count, both inverse channels, auxiliary weights and the strict count inequality. Arithmetic tile boundaries share exact node identities; they do not automatically provide contour-image seams. Principal conductor one remains a distinct producer. |

For a sign/Turing route, the tile is not itself a completeness certificate. The orbit consumer still needs K_main, W=sum(H-v) with the correct channel multiplicities, Abar and B, and (Abar-W+2B)/h < K_main+1 at T at least the requested inclusive height. Endpoint zeros not counted by open sign intervals cause saturation to reject unless separately accounted for. All shared source enclosures must be sound; checking only the downstream transform of arbitrary supplied centers is insufficient.

The binary interface follows the new complete residual design, pinned below. The spectral interface is a proposed adapter to the existing completeness contracts, not a claim that all spectral data exist. The three routes may use one storage convention but require distinct semantic soundness theorems.

A prime-fact dictionary should export a theorem about the exact table or a block of it, rather than one declaration for each set bit. Reused anchor/factor references resolve to the actual certified integer. Cache keys for analytic data include source, parameters, normalization and error bounds. A reference carries a theorem application or a checked derivation; a content hash alone does not carry its semantics. A global table of all intermediate arithmetic values is unnecessary: retain only actual reuse points and the data needed for a replayable proof.

## 3. Lean: preserve batching without hiding the import bill

The actual ladder already supplies a useful model. `Ladder/Check.lean:1–23` states its import-light design; `prodC`, `sqPow`, `powM`, `chk` at 30–57 share a product-modulus computation, while `runWith`/`run` and `ChunkOK`/`RunsOK` at 80–91 expose small conclusions. `RunsOK.append:108–117` composes adjacent ranges. `Ladder/Data.lean:1–128,138ff` imports 128 files and constructs a balanced proof for 62,168 chunks. Thus a checked batching interface is already substantive source, not a proposed timing shortcut. Its present hard-coded widths and parameters do not certify the new cutoffs unchanged.

Proposed stock-kernel path:

1. Keep the arithmetic checker and its datatype layer small. Separate the mathematical soundness library from the generated-data elaboration imports, as the existing Check/Spec split does. The generator may search natively, but emits only exact witnesses and checked parameters.
2. Check one bounded pack computation with kernel reflection, then apply the generic semantic theorem once. `Init/Tactics.lean:1427–1476` explains why `decide +kernel` avoids the default tactic's duplicate elaborator/kernel reduction. Proof-producing evaluation is another candidate (`decide_cbv:2547–2557`); it must include its generation and kernel costs. Neither route permits `native_decide` under the standard-axiom policy.
3. Store data in bounded packed literals or a shallow tree of bounded chunks. Do not concatenate billions of hints into one Nat and repeatedly shift the remaining suffix: the work on that growing operand and its copies is not constant per hint. Avoid linear list lookup for arbitrary references. Prove the chosen decoding/indexing functions once; charge their actual reductions. No claim of automatic kernel memoization follows from a shared source `let` or definition.
4. Export complete interval facts with short types. Keep per-operation equations local to a proof unless they are reused enough to pay for a global declaration. Opaque theorem references prevent intentionally re-running the pack computation at each semantic consumer; confirm the generated term actually uses those references.
5. Select k by whole-pack checking memory/time and proof/data size. k=65536 is a useful design point for comparison, not an approved optimum. It can contain 16 old-size data chunks and 2048 arithmetic batches without changing q=32. If an evaluator unrolls beyond its stack/heartbeat/memory budget, reduce k or change its proved traversal; do not increase every resource limit without accounting.

**An important stock-Lean alternative exists.** In the pinned 4.35 source, `Lean/Environment.lean:2108–2175` distinguishes legacy transitive imports from the opt-in module system's public/private import levels. `mkModuleData`/`writeModule:1859–1918` writes exported, server and private parts; the comment and implementation at 2250–2283 permit exported theorem information without its original proof body. Consequently a module-private data/proof pack with only its interval proposition exported is a credible way to reduce downstream import data. This needs a small source-compatible implementation test; the existing ladder files use legacy imports and obtain no such guarantee from a summary filename alone.

The integrity condition is essential. A short imported theorem interface is not a fresh proof check of its hidden body. Retain exact full/private artifacts and source; perform the clean dependency build/check of every pack and the allowed-axiom audit against full declarations. Do not report the loader's internal theorem-as-axiom representation as a newly proved axiom, nor accept arbitrary hand-written interfaces in place of checked modules. If the chosen audit/export tool cannot recover and validate every hidden proof, use the full-artifact path until it can. This is normal compiled-module trust accounting, not a new mathematical assumption. A one-file independent rechecker may need to reload all proofs and have different memory costs.

`finalizeImport:2308–2388` constructs maps from imported constant records; importing is not re-elaborating or rechecking every proof. In legacy mode the transitive import closure is explicit. In module mode selected private dependencies can be omitted according to the import rules, but exported dependencies/extensions still cost space. Neither mode licenses a claim of constant final-root memory without inspecting actual artifacts. Report clean build, cached import, and standalone full recheck as different measurements. Keep arithmetic packs independent of earlier packs so parallel workers do not repeatedly load a growing prefix. Shared small libraries are still loaded in each process; grouping packs amortizes this at the cost of a larger local environment.

## 4. Ordinary MM0: bounded proof scratch, real proof bytes

Use the same mathematical batch DAG. Prove word/integer operations and the generic checker/coverage theorems in the chosen foundation; emit genuine proofs for concrete arithmetic. Ordinary MMB does not acquire Lean's kernel literal evaluation simply because the same Boolean algorithm has been described. An explicit arithmetic producer must preserve sharing of products, quotient/remainder witnesses, V/A chains and transform butterflies, and account for their arithmetic derivations.

The pinned MMB format offers `TermSave`, `Ref`, `ThmSave` and `Save` (`mmb.md:180ff`). Repeated expression construction can defeat pointer-identity reflexivity; reference the saved node. Within a pack, share a DAG; between packs, reuse small generic and genuinely common mathematical facts by theorem references. Do not make every machine operation a global theorem. Conversely do not make one proof cover billions of operations: `verifier.c:771–788` resets the scratch store and stacks at each theorem, but no within-proof garbage-collection guarantee was established by this audit. Pack size must fit the actual fixed store/heap limits.

The inspected implementation has default STORE_SIZE=2^26 bytes and HEAP_SIZE=2^16 slots. `README.md:29–48` describes adjustable implementation limits and hard format limits: theorem/term data pointers are 32-bit, statements must fit the first 4 GiB, and an individual proof has a 32-bit next-statement displacement. This does **not** bound the entire proof file to 4 GiB. The compact table alone uses eight bytes per theorem, before arguments/unification streams (`mmb.md:109–128`). Generic proof-table/statement size remains a real large-scale constraint even when scratch memory resets.

An ordinary-compatible build plan is: produce independently numbered shard proof streams; an untrusted linker merges shared declarations once, remaps every term/theorem reference and emits a complete ordered MMB plus the exact MM0 specification. The final ordinary verifier checks the entire merged stream and its requested public statement. Local shard checks are useful for finding errors, but if performed they are additional checking work. They do not authorize a final file which assumes each shard's conclusion. `verifier.c:667–802` explicitly traverses all statements and counts all proved declarations; run with the specification parser enabled (`README.md:27`), and no sorry path admitted.

This is sequential proof traversal, **not a claim of a streaming-file API**. The inspected `main.c:38–76` maps the entire MMB file and then calls the verifier. Proof generation can spool bounded shards to disk; linking can use bounded buffers and compute offsets in a metadata pass. The verifier still uses its mapped file and statement tables; address space, resident pages, I/O and metadata must be measured. Compressed transport/storage is useful, but the ordinary checker ultimately consumes a valid decompressed MMB. Decompression and temporary disk cost remain in the ledger.

For a full Goldbach result, specify the MM0 foundational theory and construct the analytic library as well as finite arithmetic. An existing PA arithmetic benchmark is not a translation of the Lean analytic proof. This open library obligation is charged separately; no universal MM0 speed factor follows from these format features.

## 5. Exact scale sensitivity, not runtime estimates

Here P=ceil(N/k). The final short pack is included. A binary join tree uses P-1 joins; a tree-node theorem implementation can add roughly another P declarations, whereas local joins inside shard/root proofs reduce global metadata at the expense of larger proof scratch. The MMB column is **only** the eight-byte table entries for P pack theorems; it excludes all joins, statements, common library and proof commands.

| Internal items N | k | Packs P | Pack-table bytes 8P |
|---:|---:|---:|---:|
| 1,000,000,000 | 4,096 | 244,141 | 1,953,128 |
| 1,000,000,000 | 65,536 | 15,259 | 122,072 |
| 1,000,000,000 | 1,048,576 | 954 | 7,632 |
| 181,029,996,372 | 4,096 | 44,196,777 | 353,574,216 |
| 181,029,996,372 | 65,536 | 2,762,299 | 22,098,392 |
| 181,029,996,372 | 1,048,576 | 172,644 | 1,381,152 |
| 90,804,183,483 | 4,096 | 22,168,991 | 177,351,928 |
| 90,804,183,483 | 65,536 | 1,385,562 | 11,084,496 |
| 90,804,183,483 | 1,048,576 | 86,598 | 692,784 |

The last two N values are candidate ladder sizes from the mixed-ladder cost design, not generated ladders. Increasing k reduces declaration counts; it does not reduce the required rung arithmetic. The existing candidate offset-plus-tag layouts need 181,029,996,372 or 102,154,706,419 bytes before fallback records. Logical packing does not remove those bytes. Sparse tags, better offsets or a reproducible search can change storage, but rerunning search during elaboration adds generation work to every rebuild. Preserve exact witnesses if rebuild cost matters.

One theorem per item at N=10^9 already requires 8,000,000,000 table bytes, exceeding the ordinary MMB 32-bit table address space before any statements. Packing is therefore a format requirement at that granularity, not merely a performance preference. At 44,196,777 packs, even 100 bytes per pack for its table entry plus statement data would exceed 4 GiB; that hypothetical size is a sensitivity threshold, not a measured statement encoding. A linker must validate exact metadata offsets and individual proof lengths before emitting the final artifact. If no choice of pack size meets both scratch and metadata constraints, the ordinary-format design is blocked; separate runs with unchecked summary axioms are not a repair.

For any workload write down separately: raw witness bytes, exact elementary/source table bytes, generated proof bytes, checker import data, peak scratch, and temporary/link output bytes. A hypothetical 16-byte item payload already gives 16,000,000,000 bytes at N=10^9; this is sensitivity arithmetic, not a claim about any actual tile representation. Neither item count nor compact numerical receipt size bounds proof-object size.

Let G_search, G_cert, G_proof and G_link be generation phases. Let V_lib, V_p and V_join be final verification costs, and I_load, I_encode the nonoverlapping import/serialization costs. Then the claimed total must include

    G_search + G_cert + G_proof + G_link
      + V_lib + sum_p V_p + V_join + I_load + I_encode.

If shards are first checked independently and then checked again in a final ordinary stream, add their local verification and repeated library work. If a clean Lean build already checks each declaration once and final assembly imports its checked artifacts, do not also bill a nonexistent automatic recheck; if a standalone recheck is requested, bill it explicitly. Across F fresh worker processes, a shared library can incur up to F loads/check preparations depending on the acceptance mode; OS cache sharing does not make the CPU cost zero. Report cumulative work and peak resident memory separately from parallel critical-path wall time.

## 6. Alternatives outside the ordinary acceptance path

A stateful shard checker/linker could retain only proved statement interfaces and discard proof bodies after validation. To count this as sound it must enforce the exact foundational theory, definition identity, theorem dependencies, absence of fresh unchecked axioms, complete range coverage and valid proof acceptance for every imported claim. The persistent state must have a trustworthy derivation from prior verified input, not merely a collection of success hashes. If this is supplied by a different checker/executable or a new proof rule, report it as an extended verifier and include its verification/bootstrapping cost. Apply the same latitude to Lean and MM0.

Likewise a verified word-arithmetic or interval accelerator can reduce explicit proof traffic only after its executable/input/output semantics and connection to the target theorem are established. A generic soundness theorem plus an untrusted Boolean result is insufficient. Merkle trees can identify chunks and support resumable I/O; they do not prove omitted chunks, primality, or exact mathematical input equality without an additional sound checked mechanism. A probabilistic proof/checker is a different acceptance objective and is not substituted here.

## 7. Small implementable next milestone

Prepare, under later code authorization, one schema shared by both provers: exact domain/version, interval endpoints, fixed-width bounded witness blocks, actual reusable-fact references, exceptional records, and a complete/partial discriminator with residual state. Freeze a pure deterministic decoder and pack checker, their semantic theorem statements, and the adjacent-range theorem. Use at least two distinct packs with one genuinely reused prime/source fact, one final short pack and one exceptional branch. Keep each arithmetic batch unchanged while comparing k at three sizes.

Lean acceptance must include the concrete checked pack results, generic soundness and semantic consumption. Compare legacy imports with a module-private implementation; retain and audit full proofs in both. MM0 acceptance must include real arithmetic derivations, actual shared references and the merged ordinary proof with parser enabled. Both must reject changed domain/endpoint, missing or duplicated mandatory item, wrong shared fact, false arithmetic, and an incomplete residual mislabeled complete. A different but valid witness is accepted; byte-for-byte reproduction is not the mathematical goal.

Record generation, proof construction, proof bytes, cold full checking, cached import, final-root checking, peak memory and temporary storage. Determine whether increasing pack size saves metadata without exploding scratch, giant-literal copies or reduction depth. Only after this whole-path test can a production cost estimate choose k/f or prefer one prover. Search availability, spectral margins, fallback rates and the full analytic library remain independent unknowns. This design reduces avoidable duplication; it does not promise enough primes, signs, memory or runtime at production scale.

## Source ledger

Paths below are relative to the workspace unless absolute. Hashes pin the inspected bytes. Supporting reports supply mathematical interface context; they are not executable acceptance certificates. The Lean module-system implementation was inspected directly this turn, rather than inferred from a report about legacy imports.

| Source | SHA256 |
|---|---|
| `work/qrh-blueprint/COMPUTE_FIRST_RESEARCH_AGENDA_2026-11-11.md` | `06F28067634B559C125B9348502EC0CD897F0AB1380E797619F52315EBC2BB8A` |
| `work/qrh-blueprint/SPECTRAL_BASELINE_COST_COMPARISON_2026-11-11.md` | `0DD28598568EC61FC8B589017680AA9A3AE350608ADA32FD94D9869B9C06B9A5` |
| `work/qrh-blueprint/MULTIBASE_PROTH_RESEARCH_2026-11-11.md` | `555DA959A4591205291DB862E1FE1FBA885545C4E3EC920D2FDF48F8A200D337` |
| `work/qrh-campaign/agents/independent-feasibility/MIXED_PROTH_CHECKER_COST_DESIGN_2026-11-11.md` | `78E8CB820D054DC8D1536052BBE69DA2063522A2614ACEC601E267413228D7D6` |
| `work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md` | `EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436` |
| `work/qrh-campaign/agents/prime-estimates/LEAN_MM0_COMPUTATION_COMPARISON_2026-11-11.md` | `FE173489DF0A8BA350CEA64BEF89B27F756E2815853C9C2E492B673E670D805F` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Data.lean` | `A07F94E80C0AA4DC3EF9032A8CB418AB3DC6FFA1040A51DFB3DA5E874BD879F3` |
| `work/formal-goldbach-bench/mm0/src/mmb.md` | `E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0` |
| `work/formal-goldbach-bench/mm0/src/verifier.c` | `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5` |
| `work/formal-goldbach-bench/mm0/src/main.c` | `ECDE31379241E38CA0B375DF0F40B216E9108F6CFD45952CCB282658D883DE17` |
| `work/formal-goldbach-bench/mm0/src/README.md` | `5ADA16E00CD2F72E7F83D247768CDE6ADE34E56962B1858BC014FABEDC900A70` |
| `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/Lean/Environment.lean` | `6C90105AECC4D28EFE94CC9AEF1704C284E7A748B28270B5F8513D2562331E43` |
| `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/Init/Tactics.lean` | `0F98C09E7E56ED3431292D6996A20237EC8E5EB4D322E5701B33D6396638E056` |
