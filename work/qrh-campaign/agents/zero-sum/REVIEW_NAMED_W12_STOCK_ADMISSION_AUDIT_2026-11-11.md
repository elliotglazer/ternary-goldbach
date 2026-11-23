# Independent review of named w12 stock admission

2026-11-11. PASS at bounded source and layout-analysis scope, without correction. Checked local definitions and local theorems avoid the public theorem-name trie obstruction. The report does not establish complete stock admission or prove any proposed arithmetic table entry.

Reviewed author: `work/qrh-campaign/agents/prime-estimates/NAMED_W12_STOCK_ADMISSION_AUDIT_2026-11-11.md`, SHA256 `39EFC3048C8F4CF7F775CA140DA62B0044734AC83056D5E5F3CB516F8D50B8EF`.

I read the full author and the decisive bodies in the eight pinned source/design files. All eight hashes and the author hash match. Fourteen independent symbolic integer assertions reproduce the object counts, layout reserve and ID bounds. No digit enumeration, table/proof emission, declaration, build or arithmetic-instance evaluation occurred. No additional receipt or implementation is claimed.

## Local visibility does not bypass ordinary checking

The actual C definition branch, `verifier.c:720–758`, handles both public and local definitions. With the definition bit set, it runs Def-mode construction, checks the result sort and dependencies, and matches the body with UDef. Only public-source parsing is conditional on visibility. The proposed schedule explicitly requires genuine bodies; the fact that this branch can also represent a primitive term with the bit clear is not a license to replace the named digits by arbitrary private symbols.

Term application requires `term_id<g_num_terms` at line 427. Incrementing the running count only after the declaration checks gives the required acyclic definition order. Physically placing later signature metadata earlier in the file does not make those terms available for use.

The local theorem branch at lines 767–790 executes its proof, requires a proof-typed conclusion, and unifies it with the declared signature before incrementing the theorem count. Theorem application at lines 479–515 requires `theorem_id<g_num_thms`, constructs and checks arguments, and executes the unification header. These are reusable ordinary theorems, not trusted lookup entries. There is no local-axiom opcode in the proposed schedule.

The no-Sorry requirement remains necessary. Outside BARE, the source rejects Sorry in Def mode and reports theorem Sorry use at the end. BARE removes the Sorry command case itself, leaving unknown-opcode rejection; it is not a permission to trust Sorry. The actual chosen build and allowed-axiom policy still need validation. Source matching requires the parser-enabled build; the NO_PARSER branch makes parse_until empty and is expressly excluded by the author.

## Global IDs and local proof objects have different lifetimes

The running term and theorem counters persist across statements, so checked local signatures remain callable later in the same file. `load_args` at line 178 resets the expression heap, and the declaration branches reset the expression store and stack. A saved proof pointer therefore does not survive a reset merely because its theorem ID remains available.

The declared local limits are 65,536 stack entries, 65,536 heap entries and 2^26 store bytes. Hypothesis and unification stacks have their own limits. The complete table cannot be retained as local proof objects. Consumers must reconstruct applications or use a bounded cache within a valid lifetime. Calling the global ID still pays construction, header execution and binding work. A second file needs actual prerequisite closure; a digest alone is not an import theorem.

## Public names and the final statement

The parser's theorem trie has 2^20 nodes, with two initially reserved. Distinct public theorem names require distinct terminal nodes, even if some terminals were previously prefix nodes. Since the proposed 50,331,648 names exceed the total node supply, shorter spellings cannot admit the full public table. The term and theorem tries are distinct; omitting the optional debug index does not alter the trusted parser tries.

Local definitions and local theorems skip public-source name insertion while retaining their validation. This resolves the stated name obstruction. The remaining public prelude, variables/operators and final declarations still require their own trie and parser-resource census.

The final public statement cannot silently contain an inaccessible private head. `UTerm` at lines 250–274 checks the exact head ID; `URef` at lines 243–247 checks the exact saved object. The public parser subsequently checks the declared statement. Thus the internal named-digit proof must end with the actual source terms, or with deliberately declared public definitions and their intended source interface. Conv, Cong and Unfold provide ordinary conversion rules at lines 537–598, but their body construction and proof commands remain charged. A fixed-width zero-ended numeral is not automatically the same term as the canonical binary definition body.

## Conditional layout reserve

The C tables, rather than a different draft format, supply u32 counts and starts, eight-byte term/theorem entries and u16 argument counts. With beta=4096, the arithmetic facts total `3*beta^2=50,331,648`, and their entries occupy 402,653,184 bytes. The compact-header bound `182*beta^2`, plus seven alignment bytes per fact, is `203*beta^2=3,405,774,848` bytes.

For 4095 definitions, the body-node total is 45,069 and each body/header command total is 49,164. The inherited five-byte command reservation is 532,590 bytes. Seven alignment bytes per definition raise this to 561,255. The combined reservation is therefore 3,406,336,103 bytes, leaving 888,631,192 below the largest u32 start. These exact counts agree with the author.

This is reserved capacity for specified metadata, not an actual nonoverlapping file layout. The file header, public prelude, extra facts/signatures and alignment must fit the remaining space before a legal proof-section start. Total global counts and each signature start need explicit checks. The sufficient three-byte alias window is also correct: at t0=61441, the last new ID is 65535. The conservative metadata bound does not depend on obtaining that window.

The verifier receives a u64 file length and advances from the current statement by its u32 displacement. Consequently a u32 proof-section start does not impose a universal whole-file 4 GiB cap. This observation does not bound an individual proof displacement, the total proof size, host mapping, table extents or required final read-ahead padding. Those remain actual acceptance obligations. No C memory-safety or checker-soundness theorem is established by this source inspection.

## Verdict limits and source identity

The report correctly stops before full admission. Ordinary proofs of the arithmetic, range and decoder facts; dependency order; concrete IDs and offsets; public transcript; exact numeral conversions; local peak state; no-Sorry/allowed-axiom closure; and the selected executable's validation remain required. Neither the metadata reserve nor local visibility proves the table, its complete layout or a runtime advantage.

The checked source hashes are reproduced here to bind this review independently.

| Workspace-relative file | SHA256 |
|---|---|
| work/formal-goldbach-bench/mm0/src/types.c | B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1 |
| work/formal-goldbach-bench/mm0/src/verifier.c | 71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5 |
| work/formal-goldbach-bench/mm0/src/verifier_types.c | 87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E |
| work/formal-goldbach-bench/mm0/src/parser.c | 695BF56B4FE190E6BA369A8BE854CD1031B2624929FC5FDA995551E7BAD00C39 |
| work/formal-goldbach-bench/mm0/src/index.c | 88214D057AD2C1E7569357022948C0CEA1417B2B82A3FE5CE2F8C61BB176A1AC |
| work/formal-goldbach-bench/mm0/src/mmb.md | E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0 |
| work/qrh-campaign/agents/prime-estimates/NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md | 99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988 |
| work/qrh-campaign/agents/moebius/REVIEW_NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md | 5B9F0652F6312613094A68E3E8E794A78F119073409C95E0077F9AEEDADAC216 |

No frozen predecessor was changed. The verdict accepts the conditional source path and reserve arithmetic only.
