# Named natural digits remove the expanded-header obstruction

2026-11-11. Paper representation design and static source/count checks only. No digit definitions, arithmetic tables, numeric instances, declarations, proofs or builds were emitted. The earlier general-radix packet remains unchanged and valid for its explicitly unshared expanded-numeral layout.

Conservative nullary natural definitions can make the arithmetic-table headers constant size. For w=12, the proposed metadata has a layout below the stock signature-start address limit, subject to explicit prelude and extra-library allowances. This removes the earlier representation-specific obstruction. It does not prove complete checker admission, make the 50 million arithmetic facts free, or establish a runtime winner.

The representation must be used consistently. Named definitions do not automatically unfold during theorem matching, and two separately allocated occurrences of the same constant are not interchangeable at every generic-variable reference. Ordinary conversions, exact local sharing, table/range proofs and final source-numeral binding remain required.

## 1. Conservative definitions and canonical zero/one

Fix w in {8,10,12,16} and beta=2^w. Write N_d for the canonical existing natural binary term for d: zero and one have their existing d0/d1 heads; other terms use the existing b0/b1 definitions. This is a symbolic family, not an enumerated table.

For 2<=d<beta, introduce a fresh nullary natural definition with body exactly N_d. Denote its head by D_d. Preserve D_0 as the existing d0 and D_1 as the existing d1. Add one further nullary natural definition B whose body is w nested b0 heads on d1. Thus there are beta-2 new digit definitions and one new radix definition, beta-1 new terms in total.

Reusing literal zero and one is deliberate. The retained full cell contains literal zero carry inputs in E2/E3, and the full-adder tables use bit carries zero or one. New aliases for those two values would introduce real conversion obligations at those interfaces. If the literal proposal of beta new digit names is required, the two additional definitions can be checked, but their use in place of d0/d1 must be converted and charged. They are not needed for this matched design.

The available grammar is demonstrated by the existing nullary natural definitions d1,d2 and so on in `examples__peano.mm0:172–181`. The natural b0/b1 definitions appear in the same specification and at `examples__peano.mm1:3011,3018`. The proposed definitions add no sort, primitive numeral constructor, coercion axiom or arithmetic axiom. Their bodies use only earlier terms. The implementation may use checked local definitions, avoiding a claim that millions of internal facts must be public source names; the final public theorem must still match its source statement.

The source checker makes this more than an intended convention. `verifier.c:720–758` constructs each definition body in Def mode, checks its sort/dependencies, matches its declared body through UDef, and only then increments the available term count. At427 a body can reference only earlier terms. The definition-body stream here needs only Term operations on existing b0/b1/d0/d1, with no hypotheses or theorem applications. The source rejects Sorry in Def mode at639. Global no-Sorry, accepted-axiom and sound source-translation conditions for arithmetic theorem proofs remain separate requirements.

No value is accepted from a native map of digit IDs. The exact definition body is the meaning of its named term. Any external digit-code-to-term catalogue must bind that body and the actual term object used by the certificate.

## 2. What matching does, and why conversion still costs

At `verifier.c:250–274`, UTerm checks the exact constructor ID and descends into its arguments. For a named nullary natural, there are no arguments. It does not unfold the definition. A closed theorem stated using D_a therefore matches that named head directly, with constant header shape. Its arithmetic meaning is justified by the checked definition and the ordinary proof of the theorem, not by interpreting D_a as an unconstrained constant or evaluating multiplication in the checker.

At243–247, URef compares exact saved expression pointers. Consequently a generic cell argument D_a and its occurrences inside all supplied premises must still use the required same object under that schedule, or an explicit conversion. Constructing an equal-looking D_a again does not hash-cons it automatically. A simple plan is one TermSave per used digit/radix head in a local theorem and genuine reuse of its reference. That has allocation, heap and lifetime costs.

The row/cell library must also use the SAME named radix B in its statements. Its algebraic proof works for a positive radix, and B's positivity follows by the checked definition and the old b0 positivity laws. This is a new proved library specialization with the same arities, not an automatic direct call to the frozen library whose beta term is expanded. One may build the named version by explicit conversions from the expanded version inside a generic theorem proof, once per library. Calling the old expanded-beta signature directly in every arithmetic cell would instead require per-call conversions. This packet credits neither silently.

`verifier.c:537–598` implements the explicit conversion route. Conv changes a proved target only while producing a convertibility obligation; Cong descends through equal constructor heads; Unfold verifies a supplied body against the definition header; Refl requires exact expression identity. Unfold therefore performs real work proportional to the represented definition body. These steps cannot be replaced by an unverified assertion that a named constant equals its binary spelling.

For a concrete setup schedule, first prove the expanded closed table statement by ordinary PA arithmetic. Then convert it to the named statement. With the relevant expanded leaf objects already saved, each newly named leaf can be handled by a reference to that exact body, Unfold, and Refl. The surrounding arithmetic constructors use Cong, and one Conv starts the obligation. Existing d0/d1 leaves use Refl with their actual matching objects.

For a product statement there are four arithmetic constructor nodes and at most five named leaves, including B. This uses at most 1+4+3*5=20 conversion commands, excluding target construction and obtaining the original proof. For a full-adder statement there are five arithmetic nodes, at most four named leaves and two unchanged bit leaves, giving at most 1+5+3*4+2=20. Under the same assumptions, constructing a fresh named target costs nine or eleven commands, and referencing the already proved expanded fact costs one more. The complete local setup additions are thus bounded by30 or32 proof commands in this declared schedule, apart from the original PA proof and leaf setup.

Those command counts omit the UDef body executions, which add at most 5w+6 commands for the product conversion and 4w+5 for the full-adder conversion. They also omit any missing saved-body construction or structural equality proof. If the expanded proof uses another spelling or independently allocated leaf trees, its normalization/sharing must be established first. This is a bounded conversion schema, not a claim that all the expanded table facts already exist.

## 3. Exact table statements and fixed headers

Use the following mathematical forms with actual closed digits:

    D_a*D_b = B*D_h+D_l,
    (D_a+D_b)+c = B*u+D_v,

where c and u are the literal natural bit terms zero or one. Product digits h,l and full-adder digit v remain in the appropriate digit catalogue. When a digit is zero or one, D_d is exactly the existing term, as fixed above. This makes the three full-adder uses in the retained cell type-correct without a new zero-alias conversion.

The closed product header has nine constructor nodes plus END, hence10 commands. The full-adder header has eleven nodes plus END, hence12. The complete arithmetic table still has F=3beta^2 facts and now exactly34beta^2 unshared header commands. The bound/decoder library is extra. A named digit does not prove that its code or arithmetic use lies in range.

For a concrete serialized-byte model, assume the old arithmetic/binary/zero/one term IDs are nonzero and fit one data byte. Let q be the first new term ID. If

    256<=q and q+beta-2<65536,                       (1)

all newly named digit and radix heads use three-byte commands. This interval exists for w8,10,12, but not w16. No compiled prelude count or actual ID assignment is asserted here. The required interval for w12 is 256<=q<=61441.

Let ell(D_d) denote the command byte length for its head. In this model sum_d ell(D_d)=3beta-2, because zero and one cost two bytes and the other heads three. B costs three. Counting the four fixed arithmetic heads in products and five in full adders gives the exact complete-table byte bounds

    74beta^2-12beta <= arithmetic header bytes
                    <=78beta^2-12beta.             (2)

For products alone the bounds are22beta^2-4beta and24beta^2-4beta: the input head lengths are summed exactly while the two output digit heads each cost between two and three. For the two full-adder tables the bounds are52beta^2-8beta and54beta^2-8beta; both bit heads have fixed two-byte cost. These formulas use no output-digit distribution assumption.

Actual C theorem entries use eight bytes each. Adding their24beta^2 bytes yields98beta^2-12beta through102beta^2-12beta for the entries and arithmetic headers, before alignment and other data. For w12 this is1644118016 through1711226880 bytes. This replaces the earlier expanded-layout lower bound above4 GiB; it does not contradict it.

The metadata comparison also has a less restrictive bound: if every term command uses the stock maximum five bytes, product/full-adder headers occupy at most46/56 bytes. Entries plus headers then occupy at most182beta^2 bytes. Allowing up to seven alignment bytes for each of the3beta^2 headers gives203beta^2. At w12 this is3405774848 bytes. The extra named-definition data is small by comparison, as quantified next. An actual layout can therefore reserve all these signature starts below2^32 provided the prelude and other required libraries fit the remaining space. This is conditional source-format feasibility, not universal admission or a generated file.

The full w16 arithmetic table still needs12884901888 theorem entries, exceeding the stock u32 theorem-count field. Naming terms does not remove that separate obstruction. A sparse or partitioned table, or a consistently widened same-rule implementation, remains a separate design. The three-byte model(1) is not applied to w16.

## 4. Definition setup and the remaining PA proofs

For canonical binary numerals, the sum of node lengths for all digits below beta is (w-1)beta+2. Remove the existing zero/one heads and add the radix body of length w+1. The total new definition-body nodes are therefore

    N_def=(w-1)beta+w+1.

There are beta-1 definitions. Their straight-line body construction streams and matching unshared definition headers each use N_def+(beta-1)=w*beta+w commands, including their END markers. This is an exact syntax count for the proposed bodies, not a generation of them.

The actual C nullary term entry has eight bytes and its return binder another eight. In the two-byte old-term-ID model, the combined entry, return-binder, body, header and two-byte local-definition statement-prefix subtotal is

    20*(beta-1)+4*N_def.

The statement prefix can be two bytes here because each individual body is short enough for its next-statement offset to fit one data byte. Alignment, names/debug data and the existing library are excluded. Under five-byte body-term commands the corresponding subtotal is20*(beta-1)+10*N_def. The C layout uses p_args pointing to return binders followed by the definition header; the draft document's different p_data layout is not substituted.

At w12 there are4095 definitions,45069 body nodes,49164 body commands and49164 definition-header commands. The preceding byte subtotals are262176 and532590. Add up to seven alignment bytes per definition, any required names and prelude layout. These costs are finite and explicit; they are not the cost of proving the arithmetic tables.

The remaining50,331,648 arithmetic facts at w12 must each have an ordinary PA proof. A valid construction is the previously described successor-product recurrence plus proved binary additions, or an independent smaller-radix PA derivation of each requested fact. The proof must also establish the two-digit result spelling B*D_h+D_l. Computing h,l in a generator does not establish that spelling. Full-adder facts, digit/bit ranges, decoders and generic lifting bodies require their own proofs as well. Naming constants compresses statements; it does not prove arithmetic by declaration.

The table proofs may first derive the expanded binary statements and then use the conversions of section2. At declaration end the checker also matches the final proof to the compact header. Closed table proofs can use existing generic lemmas and earlier checked facts; their cost need not be represented by additional global theorems for every internal proof node. Nevertheless generation time, body commands, all executed arithmetic/definition headers and statement/source checks remain charged setup costs. No constant setup price or runtime estimate is supplied here.

The proof-stream start and all signature starts must fit their actual pointer fields. It is inaccurate to infer a universal whole-file4 GiB cap from those starts: a later proof stream may extend further, subject to its actual statement-offset and parser constraints. The metadata layout above leaves room for a proof-stream start, but does not prove that a completed stream, public-name index, local proof pack or its imports fit. Those are concrete remaining acceptance tests.

## 5. Replay, source binding and local lifetimes

Within a consistently named library, arithmetic table headers do not unfold the names on each call. The full cell header is94 commands, intermediate row88, terminal row64, inner base10 and outer base26. Their argument/premise arities remain unchanged. This represents a newly proved same-rule specialization, not a mutation or automatic application of the frozen expanded-beta declarations.

For one m-by-n real product, m>=n>=1, the macro headers sum to

    94mn+98n+2.

If all four arithmetic table facts are invoked afresh at each cell, add46mn, giving140mn+98n+2. This is an exact command count for those headers in the named statement model. It excludes range/binding headers, setup and body traffic. The arithmetic macro count5mn+2n+1 and the reviewed core body formula25mn+22n+1+D+C are unchanged; the actual D,C and representation bridges can change and must be recomputed. Locally cached table proofs replace repeated header execution with real retained-proof references under the existing conditions.

The following example reuses only the saved first-four, fixed15442, full20 Horner capacities. No analytic order, precision or workload choice changes:

|w|Product template subtotal, unchanged|Named uncached table+macro headers|Earlier expanded-header upper|
|---:|---:|---:|---:|
|8|10702|307256|742510|
|10|5920|170168|470564|
|12|5040|145528|452036|
|16|3980|115848|436344|

The w16 column is syntax sensitivity only; it does not admit its full stock table. The earlier column was an upper bound depending on unknown digit lengths, so subtracting it from the new count is not an observed saving. Both byte and wider radices can use names; comparing named w12 against only an unnecessarily expanded w8 would be unfair.

There are beta+1 possible digit/radix head objects including existing zero and one. At w12, retaining all4097 as local TermSave objects would use65552 store bytes under the conditional16-byte nullary-node layout and16388 bytes of heap references, before every other object. This is much smaller than caching50 million fact proofs, which remains impossible in the65536-entry local heap. Full head-cache fit alone is not proof-pack fit. At w16 even the complete head set has65537 entries and cannot fit that heap, apart from its theorem-count failure.

Each theorem resets the local expression store and heap. Global checked definition bodies and theorem signatures remain available in the same stream, but local named-head pointers, converted bodies and fact proofs must be reconstructed or retained only within valid lifetimes. Across independent files, imports/replay must establish actual proof closure. Hashes and native caches are not accepted imports.

At the public source boundary, the intended ordinary binary numerals must still be proved equal or definitionally convertible to the internal radix words. Expanding a named digit pays the relevant body construction/unfolding costs. A source adapter that produces exactly w b0/b1 heads ending in zero is not automatically the canonical body N_d used here. It requires normalization/conversion, or an explicitly changed fixed-width definition-body design with new setup counts. In particular, the concurrent numeral-binding packet is not assumed compatible for free. The named representation does not erase the original word-concatenation and input/output-binding proof obligations.

## 7. Conditional cost decision

Let the expanded and named implementations use the same complete arithmetic facts, input capacities and final theorem. A named design is preferable in a chosen cost measure only when its reduction in header executions, stored statement syntax and repeated digit-expression construction exceeds:

- definition declaration/checking and retained global metadata;
- setup conversions and ordinary PA proofs of compact arithmetic/range facts;
- named-radix generic-library specialization;
- changed local head/body caches, resets and exact source-numeral conversions;
- all added representation, serialization, import and binding work.

The comparison must use one unit, such as bytes, explicit command counts or later measured time. Ordinary table-proof generation is not the same category as checking a constant-sized table header. The new design can remove the prior format obstacle even when its overall proof generation remains expensive. No runtime or radix winner is established.

A full w12 metadata layout with modest existing prelude and extra headers is now a plausible stock-format candidate. Actual admission still needs the complete source/theorem/definition catalogue, exact IDs and layout, local proof-pack lifetimes, generated ordinary proofs and checker validation. Sparse named tables are also possible, but no actual digit diversity or cache hit rate is inferred from capacity histograms.

## 8. Evidence and pins

The static companion reads only the prior67175-byte receipt, capped at128 KiB, and computes four symbolic size rows plus24 saved-case header rows. It contains no digit loop, new conductor loop or arithmetic-instance evaluation. Its final output is16898 bytes, below64 KiB. A draft receipt was regenerated before freeze only to include the general five-byte-ID/alignment upper bounds.

Owned `named_natural_digit_format_20261111.py` SHA256 `86867B6612B4C6A22A317FCF140273E1F9F0BD1CFA92B8EEADA85BD5015F6417`; receipt `AB5DEE833A8181D03F2F51798DCC78FB16ADFD746FCF0F9D95F019B49645F051`. The receipt pins nine source/input artifacts, including:

- `GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md`, `0C69D1774C2D0AE2A2A0DA849F30962D66304A13C07C66AEA50BA942E2BB5827`;
- its receipt, `87948E77ECF813E05B53893F22397D984E64B664E3EC2DC84212A268B212CFF0`;
- `moebius/REVIEW_GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md`, `88EFCBB3EA84F957FDFEBE502F7DF13A1FC1774743E21814E7A309E298746FC7`;
- `examples__peano.mm0`, `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`, and `examples__peano.mm1`, `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`, under work/mm0-efficient/toolchain-sources;
- C `types.c`, `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1`; `verifier.c`, `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`; `verifier_types.c`, `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E`, under work/formal-goldbach-bench/mm0/src.

The new bounded result is a conservative named-natural representation with explicit setup/conversion prices and a smaller fixed-form header layout. It removes one narrow representation obstruction, while keeping arithmetic proof construction, source transport, local resource admission and whole-checker validation open.
