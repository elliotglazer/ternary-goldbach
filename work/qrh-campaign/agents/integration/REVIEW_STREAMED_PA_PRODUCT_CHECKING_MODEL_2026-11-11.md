# Independent review of streamed PA product checking

2026-11-11. **PASS at bounded paper/source and conditional cost-model scope**, with the stock-taint qualification in section 4. No correction to the frozen mathematical interfaces is requested. The local-word block equations and their joins preserve the exact public multiplication equality. The note does not implement those lemmas, a streaming checker or a stock-format proof pack.

Author: `independent-feasibility/STREAMED_PA_PRODUCT_CHECKING_MODEL_2026-11-11.md`, SHA256 `E906A3372DED168EF06D9065CD823B781FF427AD86AF55FB6D5D4B4DEC75A973`. I read the full frozen note, inspected the relevant actual PA/MMB and Lean source bodies, and matched all eighteen author source/report pins. The new row, block, append, place and terminal identities and their arities were checked directly on paper. No author program was executed and no new script, proof, declaration, digit enumeration, arithmetic instance or build was produced.

## 1. Two distinct boundary contracts

The direct invariant route retains the exact expanded I, including equality, carry range, low-prefix range and place positivity. A closed concrete theorem of I can be reapplied after a reset. A transition with incoming I as a hypothesis only proves an outgoing state after that hypothesis is discharged. The note correctly distinguishes these alternatives; an untrusted checkpoint or a list of successful rows supplies neither.

The direct route does not solve syntax growth automatically. The literal place spine grows with the row number, and low-prefix trees repeat earlier places. Sharing gives a linear local DAG only when the actual objects are shared. Re-exporting unshared trees or rebuilding them after resets can lose that bound. Fresh prefix names exchange those trees for retained definitions and conversion costs rather than deleting them.

The new selected alternative is a closed concrete equation

    A_in+x*Y_block=D_block+P_block*A_out.

The two carry words are actual supplied m-byte objects. The block multiplier and low-output words have the actual r digits, and P_block is the r-step place term. The chunk does not assume that its incoming carry has the correct global meaning. Its ordinary cell proofs establish the displayed relation for that supplied carry. The outer A<x invariant is unnecessary for this equality-only export, while every byte/carry/table range premise required by the cells remains necessary.

This is not a vacuous interface. At assembly, adjacent carry words must match exactly or be connected by a proved equality. The first carry is proved zero, all blocks cover the ordered multiplier once, and the final high carry remains in the output binding. Incorrect disconnected carry witnesses cannot be accepted merely because they have the right byte lengths.

## 2. New algebra and exact terminal equality

For the nine-argument, two-premise row lift, E removes only its explicit trailing zero and gives A+x*y=beta*B+d. Combining it with B+x*Y=D+P*C yields

    A+x*(beta*Y+y)
      =beta*(B+x*Y)+d
      =(beta*D+d)+(P*beta)*C.

The rearrangement uses the pinned ordinary-PA associativity, commutativity, distributivity and equality substitution. There is no division, evaluator or new arithmetic axiom. The two-argument block base C+x*0=0+1*C starts the reverse proof order. Repeatedly consuming the already proved higher row equation builds the exact low-digit-outermost Y/D words and right-multiplied place spine. The padded inner base preserves the outgoing m-byte carry, including m=1 and a nonzero top carry.

For the thirteen-argument, five-premise join, substitute the Y binding into A0+x*Y, use the left equation, factor PL*(A1+x*YR), use the right equation, and apply the D/P bindings. This proves A0+x*Y=D+P*A2 without computing the public product again. The three concatenation/place bindings are genuine proof premises, not metadata assignments.

The proposed append lemma is sound:

    V=U+P*T
      -> beta*V+d=(beta*U+d)+(P*beta)*T.

Starting from T=0+1*T and traversing the left word from high digit to low digit gives W(left,T)=W(left,0)+P_left*T. Two passes produce the exact combined Y and D objects. The separate place pass through the right place word derives PL*PR=P_total. Its symmetry is required for the author's displayed P_total=PL*PR join premise and is charged.

At the root, the seven-argument/three-premise extractor consumes the proved initial-zero equality, the root block equation and the actual output append binding. The conclusion is x*Ytotal=Z with Z=D_total+P_total*A_out; A_out is not assumed zero. The reviewed three numeral bindings and final six-argument public transport then yield precisely x_src*Y_src=Z_src. The result is not only an equation about a private representation.

The ordered partition must be nonempty, contain every row exactly once, and retain its final short block. The proof works when there is only one chunk, or a block has one row. Leading zero digits and unequal operand lengths do not justify dropping rows or the high carry. Zero-input and source-grammar handling remain those of the reviewed numeral-binding packet.

## 3. Count and growth checks

The new arithmetic-event expression 5mr+2r+1 comprises four table uses and one cell per cell position, r padded bases, r new row lifts and one block base. It is not a count of all proof commands. With the reviewed expression-root/premise convention, the contributions are:

|Interface|Arguments/premises|H+R per application|
|---|---:|---:|
|Cell|15/9|25|
|Padded row base|2/0|3|
|New row lift|9/2|12|
|Block base|2/0|3|
|Append step|5/1|7|
|Place step|3/1|5|
|Equality symmetry|2/1|4|
|Block join|13/5|19|
|Final extractor|7/3|11|

Thus the non-table-instantiation leaf charge is 25mr+15r+3. Its premise edges include table/range consumption, but their producers, local reinstantiations, statement construction and header execution are extra. Parameterized producers are not hidden among closed zero-argument facts.

For a join with left length r and right length s, the two append passes contribute 14r+4, the place pass 5s+2, its orientation 4 and the join 19. The sum is exactly **14r+5s+29**. Root append plus extractor is **7n+13**, excluding the separately specified initial-zero and public-source transports. These counts do not price constructor children, imports or execution of the generic headers.

The local-word export has O(m+r) literal syntax. A balanced binary join tree has at most ceil(log2 K) levels; at each level the sum of child row lengths over its disjoint joins is at most n. Consequently the stated O(n log K) word/place work and O(Km) repeated carry/x boundary syntax are valid bounds. A sequential chain can repeatedly process growing words. Neither architecture removes the mn underlying cell positions.

The root still has O(m+n) syntax, and an unchanged x word may itself exceed local limits. Reducing row chunk size cannot solve either obstruction by itself. The note explicitly keeps this limitation. A general arithmetic DAG can also have a much larger live frontier than this product boundary; no constant-size summary for arbitrary computations follows.

These are possible schedules, not emitted command streams. The new block/append/terminal generic proof bodies are unimplemented fixed library work. Exact word imports, source decoding, digit ranges, named-body conversions, table instances and all statement headers remain charged. No full cost or resource admission is proved by the arity totals alone.

## 4. Actual verifier lifetimes and the taint qualification

The source distinctions are correct. `load_args` clears local heap state at verifier.c178–200. Definition checking resets the local store/stack at 731–738; theorem checking resets store/stack/hypothesis stack at 771–774 and reloads its arguments. Global term/theorem counters still advance at 757/790. The mapped descriptors and unification streams persist, while prior local expression and proof references do not.

A later theorem application checks an explicit reconstructed conclusion, argument sorts/dependencies and the old header at 479–515; it does not replay the old body. URef compares saved object identity at 243–247, and UTerm checks/decomposes actual constructors at 258–274. A fresh arena can build compatible fresh objects, but cannot reuse stale heap offsets or a hash in place of the required statement. The conclusion/header/public parser checks remain part of acceptance.

**Qualification:** the author's sentence that tainted chunks publish nothing is a required external/continuing-publication policy, not a description of stock counter behavior in isolation. In the non-BARE development path, Sorry marks a local proof; run_proof records global taint at 365–373, and the declaration can still advance g_num_thms before the whole-file rejection at 803–807. Therefore frontier advancement alone is not an export certificate. The author confirmed this interpretation during review. A clean ordinary stream or an explicit no-taint commit rule is required. The accepted general streaming protocol already retains that obligation. No frozen mathematical correction is needed.

Conv/ConvCut also show why an arbitrary mid-proof proof-tagged stack item is not publishable: pending conversion obligations must be completed. A continuing checker may commit only after all declaration-end checks and its taint policy succeed. Interrupted or rejected work supplies no accepted theorem.

Stock verify starts global counters from zero for each file, and main maps the whole input. It does not implement a bounded-buffer multi-file accepted-environment API. A clean merged file checks its library once and then reuses checked declarations. Fresh standalone calls require genuine imports/replay or an independently specified trusted continuation mechanism. A summary containing a statement and success hash cannot replace ordinary derivability.

## 5. Definitions, composition and fair cost boundary

The named-natural digit proposal is a distinct representation. Its canonical binary definition bodies are not automatically the fixed-width, zero-ended digits of the numeral-binding packet. Checked unfolding, padding equality, specialization and transport must connect them. A surviving definition descriptor is different from a discarded local instance of its head or unfolded body. Neither theorem headers nor URef automatically unfold definitions.

Retained theorem formulas must keep the full reachable definition closure, or eliminate private names by ordinary proofs before export. Deleting or renaming definitions while preserving dependent formulas is not ordinary storage reclamation. The local-word alternative using fixed-library constructors makes this closure explicit, but retains the actual word syntax.

Within a continuing clean checker, completed derivations may be discarded after exact checked theorem installation; their provenance does not disappear. Across an untrusted restart, a short equation and hash do not preserve that provenance. Reproducible independent checking still requires the ordinary proof input or reproducible generation. Independent prechecks plus a later merged check are valid but must charge both passes.

The conditional depth-first frontier bound O(n)+O(m log K), plus active scratch and the fixed library, follows from retaining disjoint completed siblings along one balanced path. Dispatching all leaves simultaneously is a different queue/memory schedule. The stock checker retains global metadata even when scratch resets, so this bounded-frontier implementation is a proposed same-rule successor, not existing behavior.

The listed default limits match verifier_types.c: 65536 heap/main-stack entries, 64 MiB store, 256 hypothesis/unification-stack entries and 65536 unification-heap entries. Counts and offsets still constrain the global format; more chunks can trade scratch pressure for more metadata. This does not establish a universal 4 GiB whole-file ceiling, and an appropriately widened same-rule implementation remains a separate engineering candidate. Every concrete proof still needs admission against actual sizes and layouts.

The cost expression separates library generation/checking, leaf generation/proof work, joins, imports/exports, storage, final bindings and parsing. Its Saved>Added comparison is explicitly conditional on common prices and successful resource admission. It makes no calibrated speed ratio or runtime claim. Local reinstantiation counts and representation diversity are unresolved inputs rather than presumed cache hits.

The Lean comparison also preserves the correct provenance boundary. I inspected pinned Environment.lean2250–2283: subsumesInfo explicitly compares names/types/level parameters and permits a theorem's restricted exported representation. That does not certify an arbitrary supplied axiom or eliminate the original proof obligation. Clean dependency builds/imports and independent complete rechecks should be compared symmetrically with the corresponding MM0 workflows. Implementation assurance and persistence obligations should be assessed on both sides; no new arithmetic acceptance rule is proposed for either.

## 6. Evidence and stopping point

All eighteen hashes in the author's source table match the files inspected or the referenced reviewed packets. The principal implementation pin is verifier.c `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`; the ordinary PA pin is peano.mm1 `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`. I additionally inspected:

|Source|SHA256|
|---|---|
|`work/formal-goldbach-bench/mm0/src/parser.c`|`695BF56B4FE190E6BA369A8BE854CD1031B2624929FC5FDA995551E7BAD00C39`|
|`work/formal-goldbach-bench/mm0/src/mmb.md`|`E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0`|

The parser's declaration/binder/expression checks at 612–681 and the README's NO_PARSER warning support the exact-public-target requirement. No review credit is given for disabling those checks.

This review accepts the bounded algebraic boundary and conditional resource/cost design, including the newly proposed local-word joins. It does not establish ordinary compiled proofs for those interfaces, generated tables, an implemented streaming verifier, a full foundational closure audit, pack admission or an end-to-end winner. Only this new review file was created; frozen predecessors are unchanged. The task stops here.
