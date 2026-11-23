# Independent review of named-natural digit headers

2026-11-11. PASS at the conditional paper, source and symbolic-metadata scope. No correction requested. One metadata field's byte assumptions are made explicit below. The result removes the prior expanded-header obstruction under a changed representation. It does not admit a complete stock proof file, produce ordinary PA arithmetic proofs or establish a speed winner.

## Frozen packet and checks

Author `prime-estimates/NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md` has SHA256 `99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988`. Script `named_natural_digit_format_20261111.py` has SHA256 `86867B6612B4C6A22A317FCF140273E1F9F0BD1CFA92B8EEADA85BD5015F6417`; its receipt has SHA256 `AB5DEE833A8181D03F2F51798DCC78FB16ADFD746FCF0F9D95F019B49645F051`.

I read the full frozen note and script and inspected the cited actual C and peano sources. My own checker reconstructs symbolic syntax counts, all four size rows and all 24 saved-case header rows. It verifies the nine source/input pins. All 272 checks pass. It neither imports nor executes the author writer.

Owned `review_named_natural_digits_20261111.py` has SHA256 `A551E451B6297157BDD00A65A993E033C0A31217C97B9F75891A8AE260EA9C79`; its receipt has SHA256 `2380BB8F1193338F53464F6EA6D2E713EB4868D521A7147A4D70A06A36FA6935`. No digit enumeration, arithmetic instance, emitted definition/table/proof, build or functional evaluation occurred. Frozen author files are unchanged.

## Meaning and source-rule boundary

The proposed beta-2 digit definitions and one radix definition are nullary definitions in the existing natural sort. Existing d0 and d1 remain literal zero and one. Their canonical binary bodies use earlier b0/b1/d1 terms. `examples__peano.mm0:46,172-181,288-293` supplies the natural sort, nullary natural-definition examples and binary constructors. No new sort, coercion axiom or primitive arithmetic rule is required by this design.

At `verifier.c:427`, Term checks that the referenced ID is already available. At `720-758`, a definition is checked in Def mode for its body, return type and dependencies, and its UDef header is checked before incrementing the term count. Nullary bodies using only previous terms therefore meet the stated acyclicity plan. The same source rejects Sorry in Def mode at639. This is not a blanket no-Sorry or allowed-axiom certificate for all later arithmetic proofs. Those remain separate requirements.

The meaning of a digit name is its checked body, not its position in a native code-to-value table. The external catalogue must bind the exact body and term ID used. Existing literal carries avoid conversion mismatches in the full cell's zero-input addition premises. An alias for zero or one would need an additional bridge; the chosen design does not introduce it.

`verifier.c:250-274` matches UTerm by exact head ID, without unfolding definitions. `243-247` matches URef by saved object identity. Thus constant-size closed headers are sound, but generic cell arguments and repeated occurrences must still share the required object or carry an explicit conversion. Local TermSave/Ref reuse has allocation and lifetime costs.

The generic cell and row signatures must consistently use the named radix. This requires a newly proved specialization or explicit conversions from the expanded-radix library. The author correctly does not claim an unchanged direct call to the previous frozen signature.

## Conversion schedule

The actual Conv, Cong, Unfold and Refl cases at `verifier.c:537-598` support the proposed conversion. Conv creates an obligation, Cong follows matching constructors, Unfold runs the checked definition header on a supplied body, and Refl requires exact identity. Naming does not make unfolding free.

Given the stated saved expanded leaf objects, a newly named leaf uses one body reference, Unfold and Refl. A product has four surrounding arithmetic constructors and at most five newly named leaves, so its conversion needs at most 1+4+15=20 proof commands. A full-adder has five constructors, at most four named leaves and two unchanged bit leaves, giving 1+5+12+2=20. A product's occasional unchanged digit leaves only reduce this upper bound.

The fresh target uses nine or eleven construction/reference commands. Referencing the old proof adds one, hence the declared 30/32 setup additions. Repeated literal leaves must use the same saved objects needed by Refl; the count permits references rather than constructing fresh copies. Obtaining the old proof, obtaining those saved leaf bodies and any normalization from a different spelling remain outside this conditional count.

The extra UDef work is at most four digit bodies of length at most w+1 plus the radix body/header of length w+2, giving 5w+6 for a product. The full-adder has only three such digit bodies and gives 4w+5. These header executions are separate from the proof-command count.

## Syntax, size and placement

The product expression has nine nodes and its END gives ten header commands. The full-adder has eleven nodes and END gives twelve. Across one product and two carry-input addition tables the header count is exactly 34*beta^2. There are still 3*beta^2 arithmetic theorems; ranges and decoders are additional.

With old heads costing two bytes and new aliases costing three, summing the two input digit-head lengths exactly and bounding output digit heads by two or three bytes gives the stated interval

    74*beta^2-12*beta <= header bytes <= 78*beta^2-12*beta.

The ID interval is feasible at w8/10/12 only. For w12 it is exactly 256<=q<=61441. The receipt does not apply it to w16. A compiled prelude satisfying those conditions has not been supplied.

The receipt field `generic_max_five_byte_named_header_bytes_upper=104*beta^2` retains two-byte old arithmetic/d0/d1 heads and allows only the new named heads to cost up to five bytes. Its product/adder bounds are 34/35 bytes. The author confirmed this interpretation during review. It is not the all-term-five-byte bound. The separately recorded all-term bound uses 46/56-byte headers, gives 182*beta^2 with theorem entries, and 203*beta^2 after up to seven alignment bytes per arithmetic header.

At w12 the latter subtotal is 3405774848 bytes. The smaller three-byte-alias subtotal is 1644118016 through 1711226880 bytes before the stated extras. These provide conditional placement capacity for signature starts and a proof-stream start when the prelude, other required libraries and metadata fit. They are not complete parser, naming, proof-stream, host-memory or local-resource admission results. The stock w16 complete-table theorem-count obstruction remains unchanged.

Grouping canonical body lengths gives N_def=(w-1)*beta+w+1. Each of the body and header streams has N_def+(beta-1) commands. Eight-byte entries plus eight-byte return binders, body/header ENDs and two-byte definition statement prefixes give 20*(beta-1)+4*N_def bytes under two-byte old heads, or 20*(beta-1)+10*N_def under five-byte heads. The longest listed definition body plus its statement prefix fits a one-data-byte statement offset. The w12 values 4095 definitions, 45069 nodes and 49164 commands per stream agree. Alignment, names and the existing library remain extra.

The named row/cell headers give 94mn+98n+2 commands per real product. Four table applications add 46mn, so the total is 140mn+98n+2. All 24 saved capacity rows agree. The underlying event and connected-core counts are unchanged; representation-dependent constructor children, closed facts, conversion proofs and range/binding producers can change. Comparing these exact named-header counts with an older expanded-header upper bound does not prove an execution saving.

## Resource and end-to-end qualifications

The current local heap and expression store reset at each theorem. At w12, all 4097 possible digit/radix head objects fit the stated conditional head-only allocation, but that does not fit the millions of fact proofs or prove a whole proof pack fits. At w16 even 65537 head references exceed the heap. Global checked definitions and signatures persist within the checked stream; local references do not. Independent files require actual accepted import/replay and closure, not hash-based trust.

The final public theorem must still bind the original source numbers. A fixed-width word ending in zero is not automatically the canonical binary body used by these aliases. Explicit normalization, unfolding or a separately reviewed definition-body design must connect them. All 50,331,648 arithmetic facts at w12 still need ordinary proofs and checked result spellings.

The conditional cost comparison therefore remains sound only with definition setup, table proofs, executed headers, generic-library specialization, local reconstruction, source conversions and serialization/import work charged in the same resource units. The packet establishes a smaller conservative representation. It does not establish a full MM0 analytic foundation, a generated PA library or a global speedup.

Source hashes are bound through the receipt, including `types.c` `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1`, `verifier.c` `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`, `verifier_types.c` `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E`, and peano.mm0 `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`.
