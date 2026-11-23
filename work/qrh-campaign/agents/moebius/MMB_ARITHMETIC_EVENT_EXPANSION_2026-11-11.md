# Ordinary MMB expansion of arithmetic events

2026-11-11. Static source and integer metadata only. No compiler, checker, proof generator, arithmetic certificate, function evaluator or build was run. No new MM0/MM1/Lean declarations were written. This is an encoding and missing-library analysis, not evidence that a new arithmetic backend works.

The pinned checker supports a concrete command model. For example, the existing `add_xx0` lemma has six expression arguments and two premises; a legal call with saved operand expressions and premise proofs needs fourteen proof commands when the conclusion's addition and equality nodes are fresh. The corresponding `mul_x2x` call needs sixteen. The proposed radix-256 templates do not yet have the proved cell/row signatures needed to replace every event by a numerical command total. This packet gives the expansion formula and identifies those missing signatures without inventing them.

## 1. What the sources provide

The arithmetic baseline is integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md, section 3. It proposes

    M(m,n) = 5mn + 2n + 1,       A(l) = 2l + 1,

where `n` is the row count, normally the smaller operand's byte length. These count digit-table uses and fixed algebraic steps. Its section 7 already leaves the ordinary-PA byte implementation open.

`examples__peano.mm0:168–228` supplies the PA arithmetic setting. The actual `eqdivmod` body at `examples__peano.mm1:2693–2698` takes two conditional premises, a remainder bound and `b*Q+R=a`, and concludes the quotient/remainder identities. Nearby `divmod` and `modlt` bodies are at 2700–2712. These are natural-number statements. Natural truncated subtraction is not signed integer subtraction. `powadd` and `powmul:5024–5032` supply genuine source proofs relevant to shifts, but an exact numeral/grid adapter still has to call suitable proved lemmas.

`examples__peano_hex.mm1:418–508` contains generated closed digit-add/carry facts and recursive addition; 526–587 contains generated digit-product facts and recursive multiplication; 595–646 connects normalization equalities with expressions. In particular, multiplication branches on zeros, ones, low zero digits and recursive additions. It is not the same circuit as the proposed five-events-per-byte-cell schedule.

The hex source extends its base theory: `examples__peano_hex.mm0:67–134` introduces strict digit sorts and coercion axioms, including `h2nlt`, `h2n0` through `h2nf`, and `c2nch`. Their `.mm1` declarations, including `@eval-check axiom h2n0:133`, remain axioms, not PA derivations. The baseline's PA-only route must replace closed digits by naturals and prove the radix identities, or supply a complete conservative translation. Source bodies in the expanded hex theory do not discharge that obligation by themselves. No new check of their full axiom closure is claimed here.

## 2. Actual checker work for one theorem call

`mmb.md:25–30` defines command encodings of 1, 2, 3 or 5 bytes. For shortest legal encoding of a nonnegative ID `d`, write

    ell(d) = 1 if d=0; 2 if 0<d<256;
             3 if 256<=d<65536; 5 otherwise, up to 2^32-1.

`types.c:214–286` fixes `Term`, `TermSave`, `Ref`, `Thm`, `ThmSave` and the conversion commands. `verifier.c:151–163` reads their operands; 410–470 implements term construction and 479–515 implements theorem calls. A call to a theorem with `a` expression arguments consumes those `a` expressions AND an explicit conclusion expression. It then checks argument sorts/dependencies and runs the theorem's complete unification stream. Premise proofs lie below the arguments on the main stack and are consumed by `UHyp` in reverse declaration order. The number of expression arguments does not count the premises.

Theorem reuse therefore has three distinct costs: the theorem-ID command, its arguments/conclusion and premise stack traffic, and the executed unification stream. The generic theorem body is checked once earlier in the stream; that does not eliminate any of these per-instance costs.

`TermSave` combines one construction with retaining its resulting pointer. `ThmSave` similarly retains the proof without a second `Save` command. `Ref` can retrieve either an expression or a proof. These savings concern an existing local heap entry. The source compares expression identity: `verifier.c:243–247` checks a `URef` against the exact saved expression pointer, while 250–274 decomposes a `UTerm` and pushes its children. It does not recursively compare the contents of a numeral substituted for a theorem variable. Conversely, rebuilding an equal-looking numeral gives a different pointer. A producer must use the saved expression or prove the necessary conversion; a hash is not such a proof.

For a theorem with `a` arguments and `h` premises, suppose all premises, arguments, and whole operand numerals are already saved. A call whose fresh conclusion is `op(A,B)=C` uses:

|Part|Commands|
|---|---:|
|Premise references|h|
|Argument references|a|
|Whole operand references for the conclusion|3|
|Binary operation and equality constructions|2|
|Theorem application|1|
|Total, excluding proof END|a+h+6|

If the whole conclusion is already saved, this becomes `a+h+2`. Neither case includes making the saved operands, proving the premises, conversions, or the final theorem boundary. The fresh case allocates two binary term nodes, exactly `2*(sizeof(store_term)+8)` expression-store bytes under the C allocation rule. The declared layout gives 48 bytes if `sizeof(store_term)=16`; no compiled ABI measurement was performed.

Two actual source examples make this model concrete:

|Lemma and location in peano_hex.mm1|Expression arguments|Premises|Fresh conclusion commands|Cached conclusion commands|
|---|---:|---:|---:|---:|
|add_xx0:457, also explicit generated call at 489|6|2|14|10|
|mul_x2x:556, explicit generated call at 573|7|3|16|12|

The arguments of the first are `a,b,c,d,e,f`; the second adds `g`. The whole `hex` numerals in the conclusion must be saved consistently with those prefix/digit arguments. Merely having independently equal values is insufficient.

For an explicit unshared header representation, expand the displayed source terms but leave `hex` as its declared constructor. Make the implicit `h2n` coercions in hypotheses explicit. `add_xx0` has respectively 11, 5 and 8 constructor-or-variable nodes in its conclusion and two hypotheses. With two `UHyp` commands and `END`, that is 27 unification commands. `mul_x2x` has 9, 5, 8 and 5 such nodes, hence 31 including three `UHyp` and `END`. These are source-derived legal header stencils, not counts extracted from a compiled MMB. A compiler may share header subterms differently. The metadata checks these formal trees, not arithmetic instances.

Under the pinned heap limit, shortest `Ref` encodings use at most three bytes, while term/theorem IDs may need five. Thus the fresh calls above have proof-stream upper bounds 48 and 54 bytes respectively, excluding END and all setup. These bounds do not include the 27/31 executed header commands or header storage. Bounds are not measured output sizes.

## 3. A complete local DAG counting formula

Fix a legal first-use postorder schedule for one connected proof DAG with one live conclusion. Every non-root newly applied theorem is consumed by at least one premise edge. Earlier cached proofs may be additional leaves. This fragment uses only `Ref`, `Term[Save]`, `Thm[Save]`; hypotheses, conversions and definition unfolding are outside it and must be added when needed.

Define:

* `V`: newly applied theorem nodes, including closed table-fact applications made in this fragment.
* `H`: total premise edges consumed by these applications, including edges to earlier cached proofs and repeated edges.
* `R=sum_v(a_v+1)`: expression-root requests for the arguments and explicit conclusion of each application.
* `T`: newly constructed expression DAG nodes. Save a node at first construction if it is reused.
* `C=sum_t arity(t)`: child requests of these new constructors.

The `V-1` non-root first proof uses arrive on the stack from their just-completed proof; all other premise uses need `H-(V-1)` references. Of the `R+C` expression requests, `T` construct a first-use node and the remainder reference a saved node. Therefore

    theorem applications       V
    proof references           H-V+1
    term constructions         T
    expression references      R+C-T
    body commands with END     H+R+C+2.                       (1)

This is an exact count for that declared schedule, not a lower bound on all possible encodings. The first-use stacks obey the source's argument and hypothesis order. Saving shared nodes does not add a separate command because the save variants exist. A proof forest with `k` live roots replaces the proof-reference expression by `H-V+k`; compose the roots with an actual theorem before claiming one accepted result. Do not add one END per arithmetic cell.

The body byte count is the sum of `ell(id)` over its actual term/theorem/heap references plus one END. If every local heap ID fits the stock 65536-entry heap, a sufficient bound is

    5(V+T) + 3[(H-V+1)+(R+C-T)] + 1.                       (2)

Allocation is `sum_t(sizeof(store_term)+4*arity(t))`, conditionally `16T+4C` for the source layout. Add saved proof entries, initial variables, stacks, parsed signatures, statement tables and the input mapping separately. The work performed by the C loops includes `sum_v a_v` argument checks, `C` term-child checks, and all invoked header operations; one proof command is not one machine operation.

The formula gives a precise way to price reuse. A repeated table conclusion can reuse its expression and proof by reference, reducing `V`, `T`, and header executions, while the consuming premise edge remains in `H`. Numeral prefixes and exact operation results should be constructed once per local context. Repeated conversions or independent numeral spellings are not automatically merged.

## 4. One rectangular byte product

For `m=13,n=3`, the declared schedule is

    39 digit-product uses + 117 full-adder uses
      + 39 fused lifts + 6 row steps + 1 base = 202 events.

These counts are useful even before the byte lemmas exist. They specify the intended implementation obligations. Let the fused lift have `(a_L,h_L)`, the two row lemmas `(a_1,h_1),(a_2,h_2)`, and the base `(a_B,h_B)`. Let `D` be distinct closed digit facts first applied in this local product proof; existing cached facts are instead external premise leaves. For just the four table uses per cell, `D<=156`. Extra bound/decoder facts are additional nodes, not included in that inequality.

Assuming the completed templates really realize this declared schedule, their proof DAG has

    V = mn+2n+1+D,
    H = mn*h_L+n*(h_1+h_2)+h_B,
    R = mn*(a_L+1)+n*(a_1+a_2+2)+(a_B+1)+D.

For this rectangle, (1) becomes

    48+D+C +39*(a_L+h_L)
             +3*(a_1+h_1)+3*(a_2+h_2)+(a_B+h_B).           (3)

The 156 table USES are accounted for through consuming premise edges. First uses additionally create the relevant closed proof nodes and terms; subsequent uses do not execute the global table theorem again when its local proof is retained. Counting all 156 as both newly applied theorems and references would double-charge; treating their conclusions as free would undercharge. The exact `C` counts saved digit constants, numeral prefixes, table conclusion terms, invariant terms and operation/equality nodes that this product actually introduces.

For an `l`-digit adder with one table fact and one lift per position plus a base, the analogous expression is

    body commands = l*(a_L+h_L+1)+(a_B+h_B+1)+D+C+2.        (4)

The letter `L` in (4) denotes the adder's own lift, not the product lift. The exact statement signatures and first/last carry treatment must be supplied before using a numerical coefficient in (3) or (4).

The missing work is specific: PA-only radix-256 digits and range facts; the fused lemma combining one digit product and three full-adder equations with a prefix/carry equation; both row-invariant transitions and their bound hypotheses; the zero/base and unequal-width cases; and the adder lift/base statements. The inspected `mul_x2x` is an implemented source pattern for recursive radix-16 multiplication, not a proved substitute with the proposed byte fused-cell interface. A byte table may be proved from adapted nibble arithmetic, but its 196608 arithmetic facts and bounds/decoder lemmas are not free inputs.

## 5. One signed nearest-round stage

Use the reviewed first-four-band, uniform100, uncancelled stage `j=0` from the signed-Horner receipt. This is a fixed width example, not a new coefficient evaluation. For one real coordinate the input `M` has 104 magnitude bits, the rounded coordinate `L` has 102, `r` has at most 18, and `v` has at most 20. Both `r*M` and `L*v` therefore use the 13-by-3 byte template above. Here the grid alignment exponent is zero.

The signed acceptance interface is

    P=r*M, V=L*v, R=P-V,
    S=2R+v, S+C+1=2v, Mnew=L+n_j.                         (5)

`S,C` are canonical nonnegative integers independently capped below `2^21` before their equality is checked. Hence their raw guard sum fits 22 magnitude bits without assuming acceptance. The equality gives `0<=S<2v` and therefore `-v<=2(P-Lv)<v`, which is nearest ties toward positive infinity, including negative inputs and both tie endpoints. Canonical signed zero and the sign-case hypotheses are essential.

|Operation, one real coordinate|Magnitude capacities|Declared byte-template events|
|---|---|---:|
|r*M|18 by 104|202|
|L*v|102 by 20|202|
|Residual signed-add magnitude equality|122|33|
|Range signed-add magnitude equality|123|33|
|Nonnegative guard with carry1|22|7|
|Exact coefficient-add magnitude equality|113|31|
|Subtotal|two products and four adders|508|

There are also two signed-product bridges, three signed-add bridges, one nearest-range implication, residual doubling, range/canonical-sign proofs, binding to the actual source coefficient and rational grid, and expression/proof construction. Two coordinates give 1016 template events, not 1016 MMB commands. The metadata checks this row against both frozen source receipts; the complete signed schedule's independent review remains the mathematical input.

For opposite signs a bridge proves the appropriate natural magnitude addition with the smaller magnitude plus the residual equaling the larger. That equality and canonical sign cases justify the order; replacing it by unsigned subtraction is unsound. Each bridge needs an actual PA proof and exact expression/hypothesis arity. `eqdivmod` can help establish a natural quotient/remainder fact, but it is not itself the signed rational nearest-round theorem required by (5).

To expand this real stage, combine the two product DAGs and four addition DAGs, sharing the exact operand, result and slack terms, then append the proved sign/range/rounding implications. Apply (1) to the combined DAG. Do not sum six independently closed proofs while also claiming free local proof reuse. If using separate global lemmas or proof packs, charge their statements, arguments, reconstructing exact local terms and all final binding proofs. For nonuniform profiles, include the additional exact alignment shift and any justified divisor cancellation from the reviewed schedule. Neither is a primitive arithmetic acceptance command.

## 6. Cache boundaries and the next implementable step

`verifier_types.c:19–36` fixes a 65536-entry main stack and heap and a 64 MiB expression store. `verifier.c:178–198,771–789` resets the local heap and expression store for each theorem. Global theorem signatures remain available, but local numeral and proof pointers do not survive. At the boundary, the checker also runs `UThmEnd` against the declared signature and checks the public source statement. Thus a numeral-cache plan must count actual local reconstructions and theorem applications; independent files cannot import correctness from a retained hash alone. Caching every one of the 196608 byte arithmetic facts simultaneously is impossible in that stock local heap, even before terms. A used-fact subset or separate theorem applications have different, measurable future traffic.

The smallest remaining implementation specification is a table of actual proved signatures for the product lift, row/base, adder, signed bridges and nearest-round adapter, accompanied by one exact expression-DAG and proof-stack schedule. That would fix `a,h,C,V` in (1)–(4), command widths from actual IDs, header lengths, table setup and per-context reuse. This packet gives neither a generated proof nor assurance that a chosen pack fits the stock limits. It identifies exactly what a later authorized implementation must provide to turn the current arithmetic comparisons into checker-unit comparisons.

A same-rule checker implementation may widen reference/storage limits or reclaim unreachable expressions after sound lifetime checking. It must retain theorem, conversion and statement checks; no new arithmetic inference follows from those engineering changes. A native multiply/round acceptance rule is a different system and needs its own soundness treatment. The full analytic foundation/translation remains outside this finite PA arithmetic task and is not removed by any command saving here.

## 7. Metadata and immutable source pins

Companion `mmb_arithmetic_event_expansion_20261111.py/json` performs 56 static hash, source-snippet, formal-tree and integer-count checks. It parses existing receipts, not their evaluator scripts. One initial metadata attempt used the wrong existing JSON field name and stopped before publication; the corrected run uses `stages` and passes. No actual arithmetic instance or MMB stream is emitted. The source model above and its missing-library boundary still require independent paper review.

The companion script SHA256 is `2BDBDD0E6FE9778F30C665AA93E62AF43C3CFDFFA9BBDE850996C5F5DCB5048E`; its receipt is `022682B141671DC2C2F5FEC6F58715BE076735B45DE8CF8BB047E5FCA32146F8`.

|Workspace-relative artifact|SHA256|
|---|---|
|work/mm0-efficient/toolchain-sources/examples__peano.mm0|463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052|
|work/mm0-efficient/toolchain-sources/examples__peano.mm1|13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079|
|work/mm0-efficient/toolchain-sources/examples__peano_hex.mm0|E2F5E461C568E0E3EF784B507E9111272B38956093DF98B943CCC4CD806E351B|
|work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1|76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94|
|work/formal-goldbach-bench/mm0/src/mmb.md|E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0|
|work/formal-goldbach-bench/mm0/src/verifier.c|71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5|
|work/formal-goldbach-bench/mm0/src/verifier_types.c|87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E|
|work/formal-goldbach-bench/mm0/src/types.c|B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1|
|work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md|3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227|
|work/qrh-campaign/agents/moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md|531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474|
|work/qrh-campaign/agents/moebius/signed_horner_schedule_costs_20261111.json|0DF6FF38D7F14A9C3596423BE109E5EEC6CAF18E031F4329B907E43F5A60FF37|
|work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json|4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9|
|work/qrh-campaign/agents/independent-feasibility/REVIEW_SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md|40AE12EEFE142B932820F6462E6DE7CE127679A0CE220010148C698E984BBFF1|
