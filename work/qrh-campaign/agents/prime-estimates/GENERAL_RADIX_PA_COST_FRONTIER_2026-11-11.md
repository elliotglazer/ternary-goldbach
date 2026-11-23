# Larger proof digits at the saved Horner widths

2026-11-11. Conditional paper proof and bounded saved-metadata fold. No digit table, arithmetic instance, analytic value, conductor inventory, generated proof or build was produced. The accepted byte packets and all other frozen artifacts are unchanged.

Radix 256 is a baseline, not a demonstrated best choice. At the saved narrow-by-wide Horner capacities, radix 1024 substantially reduces the declared product-template subtotal. Radices 4096 and 65536 reduce it further, but require larger statements and much larger complete tables. The current stock format excludes a complete radix-65536 table by theorem count alone. A specified unshared radix-4096 header layout also fails its signature-start addressing constraint. These are reasons to price sparse or shared libraries and same-rule format engineering, not proofs that a wider radix is intrinsically slow.

This packet generalizes the newly explicit cell/row signatures and checks them against saved capacities. It does not select a radix or assert a runtime improvement. Its full20 Horner workload is a same-input sensitivity comparator, not the currently optimal or selected evaluator. Shorter-output, jointly shifted precision, rounded finite differences, transform arithmetic and their conversion costs are not imported for free.

## 1. Bounded input and what was folded

The preflight was accepted before the fold. Only these two existing JSON files supply numerical workload metadata:

- `moebius/fixed_horner_degree_envelope_costs_20261111.json`, 234441 bytes, SHA256 `4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9`;
- `prime-estimates/large_residue_bucket_occupancy_20261111.json`, 181690 bytes, SHA256 `19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB`.

Each read is capped at 512 KiB and pinned before parsing. The first file has six cases, three fixed profiles in each of the first-four/final source classes, each with 19 stages. The fold uses only saved input and rounded-product magnitude capacities. The two real-coordinate copies of r*M and L*v give four real products per stage. Their other factor capacities are the retained 18 and 20 bits, respectively. This packet selects the uncancelled comparator consistently; it does not invent more cancellation or infer actual digit values from a capacity.

There are exactly 6*19*2*4=912 capacity-pair repricings for w in {8,10,12,16}. Equal pairs are combined into an exact capacity histogram with multiplicities, not a measured histogram of runtime values. The four previously saved guard scenarios supply only five band unit-output totals each. Their sum and 19-stage baseline are rechecked; no conductor or unit is enumerated. The resulting receipt is 67175 bytes, below the 256 KiB output cap. All existing w=8 subtotals match exactly.

## 2. The same PA proof works for beta=2^w

The full cell's proof uses only beta>0 and the natural digit ranges. For x,y,a,c<beta, the bound xy+a+c<beta^2, zero-overflow elimination and higher-tail lift hold exactly as before. The fixed radix term is b0 applied w times to d1. The expression arity remains 15 and the premise arity remains nine. The row/base proof uses the same positive-radix laws, so its four signatures also remain unchanged.

The literal unshared header counts do change with the radix term's syntax. Keeping existing b0 and d1 definition heads, the beta term has w+1 nodes. The full cell has eleven beta occurrences, the intermediate row four and the terminal row two. Consequently:

|Macro|Header commands|
|---|---:|
|Full cell, 15 arguments/nine premises|94+11w|
|Inner row base|10|
|Initial outer state|26|
|Intermediate row update|88+4w|
|Terminal row update|64+2w|

The cell's cached/fresh conclusion calls remain 26/46 commands only under the previous saved-leaf assumptions, which now include the actual beta term. Constructing that term, prefix encodings, range facts and conversion proofs remains charged. This does not make a w-bit arithmetic fact a trusted machine operation.

For a real product with capacity lengths m>=n>=1 in radix beta, the retained conditional event skeleton is

    E_w(m,n)=5mn+2n+1.

The explicit row/cell signatures give the connected core body count

    B_w(m,n)=25mn+22n+1+D+C.                       (1)

D counts only newly applied closed zero-argument, zero-premise facts. C counts constructor-child requests in the actual expression DAG. Parameterized range, binding, carry or conversion proofs add their own argument roots and premise edges, as required by the mandatory cell clarification. Formula (1) alone is not the full body count after those producers are added.

The generic macro-header executions for one product, excluding all table/range headers, sum to

    mn*(94+11w)+n*(98+4w)+2-2w.                  (2)

The negative constant is just the terminal replacement correction. The expression is positive for n>=1. The optional literal-zero-overflow cell is a separate successor under review and is not used in these numbers.

## 3. Complete tables: proofs, statements and placement

A full ordered product table has beta^2 closed facts; the two carry-input full-adder tables have 2beta^2. Thus

    F_w=3*2^(2w)

arithmetic facts are required before bounds, decoders, generic lemmas and representation adapters. The already reviewed digit-table paper gives PA generation schemas: successor multiplication plus binary addition, or independently proved smaller-radix arithmetic for requested facts. These are ordinary proofs with setup and conversion costs. The source's hex coercion axioms cannot be used as their PA justification. No tables have been generated here.

|w|Complete arithmetic facts|Eight-byte theorem entries alone|
|---:|---:|---:|
|8|196608|1572864 bytes|
|10|3145728|25165824 bytes|
|12|50331648|402653184 bytes|
|16|12884901888|103079215104 bytes|

These entry bytes follow the actual C `thm` layout. They exclude statements, proof streams, source names, input mapping and every bound/decoder fact.

There is also a concrete closed-statement model, rather than a constant-cost lookup assumption. Encode a closed natural digit canonically with d0 or d1 and unary b0/b1 constructors. Its node length lambda is one for zero and one, and is its binary bit length otherwise. For all digits below beta,

    sum lambda = (w-1)*beta+2.

This follows by grouping binary lengths, not enumerating digits. Keep statements in the exact forms ab=beta*h+l and (a+b)+c=beta*u+v. Product-result digits h,l are below beta; full-adder u and c are bits. Counting the unshared expression nodes plus END gives:

    product header <=5w+6 commands;
    full-adder header <=4w+9 commands.

Across the complete tables, lower bounds using only the input digit lengths and nonempty output numerals, and upper bounds using maximal lengths, give

    L_w = beta^2*(9w+22)+12beta
      <= total unshared header commands
      <= beta^2*(13w+24) = U_w.                   (3)

The lower bound is obtained by adding beta^2*(w+8)+2beta*sum(lambda) for products and 2beta^2*(w+10)+4beta*sum(lambda) for the two full-adder tables. It does not assume a distribution of output digits.

For one explicitly chosen encoding, all arithmetic term IDs are nonzero and fit one data byte, so their commands occupy two bytes and END occupies one. This is an encoding condition, not a claim about a compiled file. Table entries plus disjoint unshared headers then use between 2L_w+7F_w and 2U_w+7F_w bytes:

|w|Entry/header lower bytes|Entry/header upper bytes|
|---:|---:|---:|
|8|13703168|18153472|
|10|256925696|344981504|
|12|4714496000|6392119296|
|16|1516125028352|2083059138560|

Alignment, proofs and additional facts increase these numbers. Different term IDs, within-header sharing, other numeral representations or sparse tables require a different calculation. Global theorem reuse does not by itself share subexpressions between distinct unshared header byte streams.

The stock C format has u32 theorem count and theorem IDs, u32 theorem-table and signature-start pointers, and variable commands with up to four data bytes. A complete w=16 table exceeds the theorem-count field before other theorems are added. Even the all-symmetric three-table count exceeds that field. A partitioned or on-demand library is a different format/use schedule, not a way to put all these named facts into one existing theorem table.

The w=12 conclusion is more limited but precise. In the stated disjoint two-byte-command encoding, the HEADERS ALONE have at least 4311842816 bytes. Each individual header has at most 131 bytes. All closed theorem `p_args` pointers identify their header starts, which must be below 2^32. Even allowing the last header to extend beyond that address boundary, disjoint headers can occupy at most (2^32-1)+131 bytes. The lower bound exceeds that capacity. This excludes the stated unshared placement, without relying on a false assertion that every whole MMB file must be shorter than 4 GiB. It does not exclude header sharing, another encoding, sparse tables or a widened implementation. The receipt's entry-plus-header size comparison is only a layout screen; this header-start argument supplies the relevant obstruction.

The C layout is the authority here. Its `p_args` points directly to binders followed by the unify stream; it is not the separate `p_data`/nested-pointer layout described in the nearby draft format document. The metadata charges the C eight-byte theorem entry and does not add an invented per-theorem nested pointer.

## 4. Replay header traffic and cache lifetimes

With all four arithmetic table facts invoked afresh at every cell, their unshared header-command upper sum is 17w+33 per cell. Combining it with (2) gives the upper bound

    H_uncached <=mn*(127+28w)+n*(98+4w)+2-2w.       (4)

This excludes range, source binding and conversion headers. It is an upper bound because actual closed digit lengths are unknown. The difference of two such upper bounds is not a measured or proved execution saving.

With retained local proofs, table headers instead execute once per newly applied distinct fact in that local theorem. Each consuming premise still incurs the reviewed stack/reference traffic. The table term itself and the matching equality expression must also be constructed or retained. A capacity histogram supplies no actual distinct-pair count, locality or hit rate, so it cannot choose between the cached and uncached regimes.

All four complete libraries exceed the pinned 65536-entry local heap even if only one proof reference per arithmetic fact were stored. The 64 MiB expression store, stack, numeral subterms and premise proofs compete for space as well. A bounded used-fact subset, direct global theorem applications or smaller proof packs are possible, with different costs. The local heap and expression store reset at each theorem. Global already-checked theorem signatures remain available in the same stream, but local operand/proof references do not survive. Independent proof files need actual accepted import/replay rules and proof closure; a hash is not a theorem import.

The large global table/signature mapping is separate from the local 64 MiB store. It is not made free by fitting a local subset, and its serialized size is not automatically its resident-memory peak. Both must be priced from an actual checker/layout. The full name-index/statement-visibility constraints are also implementation work; u32 theorem capacity does not certify that every public naming structure fits.

Stock command IDs cost 1,2,3 or5 bytes. A larger global theorem ID can require5 bytes; a locally retained Ref in the current heap fits at most3. Byte tables already exceed65536 total arithmetic theorems, so even w=8 cannot assume every global table call has a short two-byte ID. The actual ID assignment and PA prelude determine the distribution.

Widening counts, IDs, file offsets or expression references while preserving all inference/unification/source checks can remain the same proof rules. Such engineering requires consistent parser/encoder/checker changes and renewed validation; it does not retain old five-byte command bounds automatically. Adding native multiplication acceptance would instead change the arithmetic trust boundary and is outside this comparison.

## 5. Saved capacity results

Each row below is the complete product-only subtotal for one complex degree19 Horner evaluation, using exactly the same 76 real products and stored capacity bounds. The three existing grid profiles are unchanged.

|Source class/profile|w8|w10|w12|w16|
|---|---:|---:|---:|---:|
|First four, uniform100|12562|6900|5900|4620|
|First four, root-linear|11272|6220|5300|4160|
|First four, fixed15442|10702|5920|5040|3980|
|Final, uniform100|11872|6520|5560|4360|
|Final, root-linear|10552|5760|4960|3940|
|Final, fixed15442|9970|5540|4736|3728|

For every pair of magnitude capacities a,b, m=max(ceil(a/w),ceil(b/w)) and n=min of those lengths. The smaller operand is always the row count; the orientation is not assumed from the stage name. No new precision or analytic error is credited. Wider proof digits change the exact integer representation, not the underlying common-grid arithmetic or rounding specification.

The first-four fixed15442 case illustrates why proof events alone are insufficient:

|w|Product template events|Core body excluding D,C|Uncached arithmetic-table+macro header upper|
|---:|---:|---:|---:|
|8|10702|55942|742510|
|10|5920|31120|470564|
|12|5040|26720|452036|
|16|3980|21420|436344|

The last column is (4), summed over the capacities. It falls much less from10 to16 than the template subtotal, even before the larger library, range/decoder statements and term construction are paid. It remains a bound on one stipulated unshared schedule, not actual header traffic.

The receipt also carries all four saved guard-scenario totals. For the no-extra-node scenario and fixed15442 profile, multiplying the retained class counts gives product-template totals

    w8: 641689311017448096
    w10:354962596814648160
    w12:302198544285505920
    w16:238640511555395040.

These large reuse counts are conditional operation totals. They do not establish that any analytic evaluations, signs, complete zero counts or successful certificates have been produced. They do not reselect the full20 evaluator over newer alternatives.

## 6. A usable break-even test

For actual implementation prices, let S_w include ordinary library proof generation/checking, statement storage/imports and required range/decoder setup. Let R_w be the actual number of independent library-check/import lifetimes, with reuse within one trusted checked context modeled explicitly. Let G_w(H) and V_w(H) be generation and checking cost on the saved capacity histogram H, including concrete local cache/reset schedules, exact range/binding producers, numeral conversions and all final theorem transport. Then a wider radix is favorable only if

    R_w*S_w-R_8*S_8
      < G_8(H)+V_8(H)-G_w(H)-V_w(H).                (5)

This is a comparison in one chosen resource, such as bytes, checked commands or eventually measured time; different resources give a Pareto frontier. It is not valid to put a template-event difference on the right and elapsed time on the left.

A deliberately simplified sensitivity assumes every extra closed arithmetic fact costs the same alpha setup events, there is one library lifetime, and every other omitted cost is equal. Then

    alpha < [E_8(H)-E_w(H)]/[F_w-F_8].             (6)

For the fixed15442 main scenario the exact thresholds are respectively

    w10: 497789434379861/5120,
    w12: 3536362153457731/522240,
    w16: 2099212497198193/67107840.

These are only toy-model event thresholds; w16's full stock library remains impossible regardless of this ratio. Repeated independent setup divides the available per-fact budget accordingly when the same setup difference repeats. Actual setup price depends on w and on the generation strategy, and additional replay/header/binding costs need not cancel. Formula (6) therefore shows why enormous reuse warrants investigating larger digits; it does not establish amortization for an implementation.

Before a practical selection, the smallest useful test would implement the SAME unsigned product and source-binding interface at w8 andw10, generate and check the actually needed range/table proofs, and record setup, local distinct facts, numeral/statement bytes, header executions, resets, peak memory and accepted final statement. A w12 sparse/shared variant would need its own explicit placement proof. No such test is run or newly authorized here.

Full dense tables are not mandatory. On-demand wider facts can be proved from a smaller PA arithmetic library and cached within actual lifetimes; symmetry can reduce setup but adds commutativity applications; carry-one can be derived from carry-zero plus a successor proof. The prior digit-table report treats these alternatives. None permits both the smaller setup and the original four-table-use replay count without the extra proofs. Actual digit diversity, not operand bit capacities, determines sparse-cache reuse.

## 7. Pins and remaining boundary

Owned `general_radix_saved_horner_20261111.py` SHA256 `A1F5415BD92F7F3906FDF4CE7DDC441556A10A15CF60BEE6AAC51292FB818E49`; receipt SHA256 `87948E77ECF813E05B53893F22397D984E64B664E3EC2DC84212A268B212CFF0`. The receipt pins all twelve source/input files. Its writer refuses overwriting a published receipt. Before freeze, the draft receipt was regenerated once solely to add the precise disjoint-header-start constraint; the workload totals did not change.

The mathematical interfaces are the full cell `3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E` with mandatory closed-fact clarification `F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2`, and row/base `71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC`. Independent reviews are `DDA93BA814D78B2339E37C2588BC3DF8D0747BC5AF660BD51BAA9327569452EA` and `DFF5635A401C45F7C69910B779706F9EAF84843FC5CF3CCD86D1CB0DD64273A7`.

The command-model author is `moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md`, SHA256 `E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6`. The actual C sources are under `work/formal-goldbach-bench/mm0/src`: `types.c` SHA `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1`, `verifier.c` SHA `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`, and `verifier_types.c` SHA `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E`. The draft `mmb.md` hash is `E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0`.

Source checks cover C counts/offsets/entry layouts at types.c:44–139, command widths at161–203, local limits at verifier_types.c:19–36, theorem application at verifier.c:479–515, and local reset/final theorem checks at178–198 and768–802. They are static inspections, not a new checker soundness audit or successful proof-pack test.

The bounded conclusion is that the byte subtotal is not a sufficient efficiency baseline by itself. Wider radices materially change the declared cell counts at the saved widths, while setup, statement representation, ordinary-rule command traffic and physical format limits can reverse a choice. The paper/metadata frontier is now explicit; no radix or end-to-end speed winner is established.
