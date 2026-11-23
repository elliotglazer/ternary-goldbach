# Independent review of the general-radix PA cost frontier

2026-11-11. PASS at the paper, pinned-source and bounded integer-metadata scope. No correction requested. This does not accept an implemented arithmetic library, an emitted proof pack, a runtime forecast or a selected radix.

## Frozen inputs and independent work

The author packet is `prime-estimates/GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md`, SHA256 `0C69D1774C2D0AE2A2A0DA849F30962D66304A13C07C66AEA50BA942E2BB5827`. Its script is `general_radix_saved_horner_20261111.py`, SHA256 `A1F5415BD92F7F3906FDF4CE7DDC441556A10A15CF60BEE6AAC51292FB818E49`, and receipt SHA256 `87948E77ECF813E05B53893F22397D984E64B664E3EC2DC84212A268B212CFF0`.

I read the full paper and script. My independent checker reads the two pinned saved metadata inputs and author receipt, without importing or executing the writer. It reconstructs all 912 capacity-pair repricings, all six profile/source cases, every field in the four-scenario weighted folds and the exact setup thresholds. It also reconstructs the table/header quantities by grouping numeral lengths rather than enumerating digits. All 1623 checks passed; all twelve receipt pins match.

Owned checker `review_general_radix_frontier_20261111.py` has SHA256 `75112B808CBAC01FB1E594EDC90C2B6019A594933E0A2A894A40CE22882FABE4`. Owned receipt `review_general_radix_frontier_20261111.json` has SHA256 `24BEC26B00D539A98C583539F21FABC43637454A0B8E0842AA2692D303AF248E`.

## Arithmetic and command model

The retained full cell generalizes to beta=2^w for every listed w. Natural inputs x,y,a,c<beta imply xy+a+c<=beta^2-1. The raw identity beta^2*z+beta*k+d=xy+a+c therefore forces z=0. The previous row invariant and terminal identity use positive-radix algebra unchanged. Their source/byte ranges, zero-input case, representation bindings and terminal-output proofs remain separate obligations. No optional literal-zero-overflow cell is used here.

The full cell's eleven radix occurrences give 94+11w header commands. Adding n inner bases, one initial state, n-1 intermediate rows and one terminal row gives

    mn*(94+11w)+10n+26+(n-1)*(88+4w)+(64+2w)
      =mn*(94+11w)+n*(98+4w)+2-2w.

The connected core retains H=9mn+7n-2 premise edges and R=16mn+15n+1 expression-root requests before closed facts and constructor children. Thus H+R+2=25mn+22n+1, to which D+C and all separately implemented producers must be added. D is restricted to newly applied closed zero-argument, zero-premise facts. It cannot stand for a parameterized range or source-binding proof at unit cost.

The event subtotal 5mn+2n+1 and these command counts are different units. Header execution, construction of the radix/numerals, local cache traffic, conversions and source/output transport remain explicit. The arithmetic proof schemas are not existing proved PA byte lemmas merely because these counts are consistent.

## Tables and actual format limits

One ordered product table and two carry-input addition tables contain F=3*beta^2 closed facts. Grouping binary numeral lengths gives sum(lambda)=(w-1)*beta+2. The product lower header sum and two-adder lower sum give exactly

    L=beta^2*(9w+22)+12beta;
    U=beta^2*(13w+24).

For the stipulated nonzero one-data-byte term IDs, headers use 2*commands-F bytes and entries add 8F. The reported 2L+7F and 2U+7F bounds follow. Unknown output-digit distributions are not inferred from bit capacities. Bounds, decoder facts and proof bodies are additional setup.

I checked `types.c:44-113` against the pinned actual C layout, including u32 theorem count, theorem-table start and signature starts, and the eight-byte theorem entry. Its p_args directly precedes the unify stream after binders; the nearby draft format document does not override this implementation. `verifier_types.c:19-36` gives the 65536 local heap and 64 MiB expression store. `verifier.c:178-198`, `479-515` and `768-802` show argument loading, theorem application and reset/final checks. Local proof references do not survive theorem reset. Global signatures still require accepted declaration checking and storage. A file hash supplies neither a theorem import nor a retained local heap.

The complete w16 count 12884901888 exceeds u32 capacity. Even replacing each ordered table by its symmetric pairs leaves 3*65536*65537/2>2^32-1. This is a complete-library obstruction in the current format, not a prohibition on sparse libraries or same-rule format changes.

The w12 obstruction has a narrower hypothesis. Its disjoint, expanded, two-byte-command headers alone require at least 4311842816 bytes. Each has length at most 131. If every start is at most 2^32-1, their disjoint union occupies at most (2^32-1)+131 bytes, even allowing the last stream to cross the boundary. The lower bound exceeds this. This does not assert a universal four-GiB file limit. It leaves conservative named-digit definitions, shared headers, sparse tables, alternative encodings and widened implementations open, with their own proof and format costs.

All complete tables exceed the local heap count. The source also has a separate public-name trie limit; a u32 theorem field alone is not a complete public-library admission proof. The note correctly leaves actual ID assignment, command widths, naming, memory and layout unresolved. Removing or widening format limits without changing inference checks differs from adding native arithmetic acceptance.

## Workload and conditional comparison

The fold consistently uses saved uncancelled magnitude capacities, two coordinate copies of r*M with an 18-bit factor and two of L*v with a 20-bit factor. It chooses the smaller digit length as row count for every product. It does not infer that magnitude capacity determines actual digit diversity or cache hits. Both products and all 76 real products per complex full20 evaluation are present.

For example, the first-four fixed-profile events at w8/10/12/16 are 10702/5920/5040/3980, but their uncached table-plus-macro header upper bounds are 742510/470564/452036/436344. These upper bounds describe one schedule; subtracting them is not a proved execution saving. All four saved guard scenarios use their five stored band totals, with no new conductor enumeration. The full20 comparison remains a sensitivity model, not a claim that it is the selected evaluator.

The complete decision inequality is valid only with the same resource on both sides and full definitions of generation, checking, setup, import lifetimes and transport. If library generation occurs once but checking repeats, split the setup term into those two costs rather than multiplying the one-time generation cost by every lifetime. This is an allowed specialization of the named-cost model, not a correction to its conditional inequality.

The three simplified equal-setup-price ratios agree exactly with the receipt. They assume all other cost differences cancel and cannot establish amortization for an actual library. In particular, they cannot rescue the full stock w16 table. Source conversion, direct rounding, range proofs, numeral bindings, cache resets and full analytic foundations are not removed by the product-only fold.

## Source pins and accepted boundary

The actual C pins are `types.c` `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1`, `verifier.c` `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`, and `verifier_types.c` `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E`, under `work/formal-goldbach-bench/mm0/src`.

This review consumes the previously reviewed cell `3670294B...` plus mandatory closed-fact clarification `F0705C64...`, row/base `71D3F4BF...`, and MMB command model `E57FCF24...` at their existing conditional scopes. It does not expand those scopes into a generated PA implementation. Frozen author files were unchanged. No digit/table/conductor enumeration, arithmetic instance, numerical function value, proof emission or build occurred.
