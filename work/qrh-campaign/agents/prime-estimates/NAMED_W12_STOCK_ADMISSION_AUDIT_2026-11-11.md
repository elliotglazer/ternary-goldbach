# Stock admission boundary for the named w12 arithmetic table

2026-11-11. Static source audit and symbolic layout bounds only. No digit definitions, arithmetic facts, proofs, declarations, tables or builds were generated. This is a separate successor to the frozen named-digit design, not a change to its bytes. It examines the pinned C verifier with source parsing enabled; a NO_PARSER build does not establish the source boundary used here.

The public-name obstruction has a source-supported solution: check the large arithmetic table as local theorems and the digit aliases as local definitions. Local means absent from the public MM0 specification, not unchecked, forgotten after a theorem, or unavailable for later proof use. This removes the theorem-name-trie obstruction. A complete stock-admission claim still requires actual proof-body bounds, the final source interface, the full declaration catalogue and a concrete layout.

## 1. Exact object counts and the public-name obstruction

Let beta=4096. The design retains the existing zero and one terms, introduces 4094 nullary natural digit definitions and one nullary radix definition, and proves one multiplication fact for each ordered digit pair plus two full-adder facts per pair. Thus it adds 4095 terms and F=3 beta^2=50,331,648 arithmetic theorems. These are counts of proposed checked objects, not generated objects or accepted table contents.

The source parser uses separate fixed tries. `verifier_types.c:93–119` gives a 2^20-node theorem trie and a 2^16-node term trie; two nodes are initially reserved. Each character is inserted by two nibble steps, and `parser.c:174–179,208–229` rejects allocation beyond the declared limit. Public declarations get distinct terminal nodes and duplicate names are rejected at `parser.c:669–677`. Consequently F distinct public arithmetic-theorem names cannot fit even if every name costs only one additional node. Shortening names cannot repair this. This is a public-name limit, not a 2^20 limit on global theorem IDs.

Even the 4095 digit/radix definitions should not be declared public merely to make their heads usable internally. Their possible public-name encoding and its interaction with existing variable/operator names would otherwise need a separate trie count. The local schedule below avoids that additional requirement. The selected public prelude, generic public API if any, and final public target still need a finite trie census; this note does not certify an unspecified prelude.

The optional debug name index is a different object. `index.c:26–34` accepts absence of that index by returning false when p_index is zero. Its diagnostic name arrays are not the trusted parser trie. Omitting optional debug names does not bypass public-source checks and does not itself solve the public trie problem.

## 2. A source-legal local declaration schedule

The specification explicitly distinguishes LocalDef and LocalThm (`mmb.md:158–175,211`). `types.c:183–196` gives their opcodes 0x0D and 0x0E and the local flag. There is no local-axiom opcode in this schedule.

A candidate declaration order is:

1. Check the exact allowed public PA specification/prelude and the earlier binary-natural constructors and algebra needed for setup.
2. Check the 4095 local natural definitions, with the definition bit set and the exact canonical binary bodies from the named-digit design. These bodies use only earlier terms. Do not substitute primitive local terms without bodies.
3. Check the named-radix generic algebra and needed range/conversion lemmas in dependency order. They may also be local when their signatures expose private heads.
4. Check the F closed local arithmetic theorems, plus any separately required range/decoder facts. Each must have an ordinary proof from earlier allowed facts. Setup subproofs need not all be separately exported global theorems, but their proof work and local storage remain charged.
5. Check the actual arithmetic consumer proofs using the checked table IDs, consistent named heads, source-word bindings and explicit conversions. End with a public theorem whose statement matches the intended MM0 source statement.

This is a legal sequencing scheme, not an emitted proof file. The concrete dependency order within steps 3–4 remains an obligation of table-proof construction. If the selected proof construction needs earlier facts, their order or additional proved helpers must be specified; a table entry cannot justify itself or a previous entry through a forward reference.

In `verifier.c:720–758`, both local and public definitions run the same Def-mode body construction, sort/dependency checks and UDef matching. Only the call to parse_until is skipped for local declarations. The term counter increments afterwards. At line 427 term construction requires term_id < g_num_terms. The chosen binary bodies are therefore acyclic by construction, once those earlier constructors are established.

Similarly `verifier.c:767–790` checks a local theorem's actual proof and conclusion against its theorem-table signature before incrementing g_num_thms; only public-source parsing is skipped. `verifier.c:479–515` allows subsequent Thm calls precisely when theorem_id < g_num_thms. Local table facts are therefore reusable throughout the same checked file by ID. Calling them still constructs arguments/conclusion and runs their unification header. They are not zero-cost imports.

At the end, all declared sorts, terms and theorems must have been processed (`verifier.c:800–809`), and parse_until(CMD_END) requires the public input to be exhausted (`parser.c:863`). Source parsing is disabled by the explicit NO_PARSER branch at `parser.c:6–11`; that branch is excluded here.

## 3. The public conclusion must really leave the private interface

The local names need not exist in the public source grammar. The internal proof can use their term IDs, but the final public signature must match the source expression, not merely an intended interpretation of a private head. The chosen final theorem must expose ordinary source natural terms, or the source must deliberately declare any public definitions it actually uses. The local option does not provide a parser spelling for a private term.

UTerm checks exact heads, not arbitrary definitional equivalence (`verifier.c:250–274`); URef additionally requires the matched saved object at `243–247`. Thus conversion from named digit/radix expressions to the actual source numerals, and exact sharing inside generic applications, remain real operations. The Conv/Cong/Unfold route at `537–598` supplies a rule-level path, but its proofs, body construction and matching costs still have to be paid. The independently proposed fixed-width, zero-ended numeral adapter is not automatically the same body as the canonical named numeral.

This is also why the local schedule is conservative only when it uses genuine checked definitions and proved theorems. It does not license local primitive natural symbols as substitutes for digits, hidden arithmetic axioms, Sorry, or a native lookup oracle. Def mode rejects Sorry; the overall campaign must retain its no-Sorry and allowed-axiom closure checks for every arithmetic proof. Static inspection here is not a kernel-validation or checker-soundness theorem.

## 4. Counts, offsets and a conditional layout window

`types.c:47–65,90–114` declares u32 term/theorem counts and table/signature starts, 8-byte term and theorem entries, u16 argument counts, and u64 optional debug-index offset. These are the actual C p_args interfaces, not a different draft p_data layout.

With t0 terms before the aliases, the 4095 new IDs end at t0+4094. A three-byte new-head encoding is available if 256 <= t0 <= 61441. If that window is unavailable, the general maximum five-byte command bound below is still valid while total IDs fit u32. F itself fits u32. The complete theorem count, including prelude, range/decoder facts, helpers and consumer declarations, must fit too; F alone does not establish that total. An arithmetic fact near the end of this table has a five-byte Thm command in the stock variable-width encoding, rather than a one-byte cache reference.

The F theorem entries alone occupy 402,653,184 bytes. The frozen named design bounds entries plus compact headers by 182 beta^2 bytes when every term command is allowed five bytes. Reserving seven alignment bytes for each header gives 203 beta^2 = 3,405,774,848 bytes. This deliberately does not require the three-byte new-head window. It is an upper bound for this specific metadata, not a proof-body bound.

For the definitions, the canonical body-node total is 45,069; their body-command and header-command totals are each 49,164. The earlier conservative five-byte subtotal for entries, return binders, bodies, headers and declaration prefixes is 532,590 bytes. Adding seven alignment bytes per definition gives 561,255 bytes. Including even the definition bodies in this reserve is conservative for a layout that puts all proof streams later.

These two reservations total 3,406,336,103 bytes. Relative to the largest u32 start value 4,294,967,295, that leaves 888,631,192 bytes for the file header, prelude, other term/theorem entries, extra signature headers, their alignment and any other prefix data before the proof section. Thus a sufficient layout condition is that a concrete nonoverlapping prefix, including all that extra metadata, ends with a legal proof-section start at most 4,294,967,295. Exact offsets, table extent checks and all extra declarations still need to be supplied. There is no assertion that every reasonable library fits the allowance.

The layout may place the fixed tables/headers before the proof stream. This does not constitute a forward proof dependency: execution availability is controlled by the running declaration counters, not by the physical presence of an entry. Each signature must use only the terms available when its statement is checked.

The u32 starts are not a universal whole-file 4 GiB limit. `verifier.c:669–702` receives a u64 file length and computes each next statement from its current pointer and the u32 statement displacement. Consequently the proof stream can extend beyond the signature-start region, provided each statement displacement is representable, actual pointer/file extent checks succeed, and the host can map the file. Every individual proof body still needs a finite legal displacement. `types.c:175–180` and `mmb.md:177–179` also require final read-ahead padding. This note supplies no bound on the sum or largest size of the 50 million ordinary arithmetic proofs.

## 5. Reuse lifetimes and remaining admission gates

Local in LocalThm is a visibility property. The checked theorem signature remains globally available in the same file; it is not removed by theorem-local resets. In contrast `verifier.c:178–198` resets the expression heap when loading declaration arguments, and the main definition/theorem branches reset the expression store. The fixed local limits are stack 65,536 entries, heap 65,536 entries and store 2^26 bytes (`verifier_types.c:19–36`). A cache of all F proof objects cannot live in one such heap. A consumer can call global theorem IDs as needed and use a bounded local cache, reconstructing heads and proof applications after resets. Its actual maximum live state, bindings and rebuilding work remain to be established.

This gives the following bounded conclusion. Public naming of the complete table is impossible in this pinned parser; checked private facts avoid that obstruction. The named-header reservation admits a conditional prefix-layout window even with maximum five-byte term commands. Neither result closes the full implementation:

- construct complete ordinary-PA table/range/decoder proofs, with exact named-body and final source conversion;
- specify a dependency-ordered global catalogue and public source transcript, with actual count and public trie bounds;
- assign exact nonoverlapping offsets within the stated reservation, and bound each proof displacement and required padding;
- bound local stack/heap/store use for setup and consumers, including table-call and conversion lifetimes;
- check the selected parser-enabled implementation, no-Sorry/axiom closure, and any independent-file replay/import protocol.

No hash-only cache is a checked import. Restarting the process on a new file requires the actual prerequisite proof closure, unless an independently justified mechanism provides it. No runtime, memory-throughput or complete admission verdict follows from the format counts. The static task stops at these explicit gates.

## Source pins

Paths below are relative to the workspace root; all were read and hashes checked during this bounded task. Line ranges above refer to these exact files.

| File | SHA256 |
| --- | --- |
| work/formal-goldbach-bench/mm0/src/types.c | B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1 |
| work/formal-goldbach-bench/mm0/src/verifier.c | 71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5 |
| work/formal-goldbach-bench/mm0/src/verifier_types.c | 87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E |
| work/formal-goldbach-bench/mm0/src/parser.c | 695BF56B4FE190E6BA369A8BE854CD1031B2624929FC5FDA995551E7BAD00C39 |
| work/formal-goldbach-bench/mm0/src/index.c | 88214D057AD2C1E7569357022948C0CEA1417B2B82A3FE5CE2F8C61BB176A1AC |
| work/formal-goldbach-bench/mm0/src/mmb.md | E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0 |
| work/qrh-campaign/agents/prime-estimates/NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md | 99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988 |
| work/qrh-campaign/agents/moebius/REVIEW_NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md | 5B9F0652F6312613094A68E3E8E794A78F119073409C95E0077F9AEEDADAC216 |

The named review accepts the earlier bounded representation/count proposal; it is not an independent review of this new stock-admission audit. No earlier frozen file was changed.
