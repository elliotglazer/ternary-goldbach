# Streamed and chunked checking of ordinary-PA products

2026-11-11. Bounded paper/source model. No declarations, proof streams, builds, arithmetic instances, digit enumeration or runtime experiments were produced. All frozen inputs remain unchanged. The local-word composition lemmas below are new paper proposals, not compiled or adopted library theorems.

The existing product interface can be split at an exact proved row state. A stock MMB theorem boundary releases local scratch but leaves global declaration metadata, and the next theorem must reconstruct its local terms and reapply the exported theorem. It does not inherit old heap pointers or cached closed instances.

A more local proposed boundary is the closed equation

    A_in + x*Y_block = D_block + P_block*A_out,     P_block=beta^r.       (B)

It can be proved from the same cell equations by fixed PA algebra. Its concrete words have sizes O(m+r), rather than containing all earlier prefix-polynomial terms. Ordinary joins compose these equations, with separately proved word/power bindings. The final high carry remains part of the result. This gives a concrete alternative to storing a theorem for every arithmetic gate or repeatedly exporting the entire product prefix.

There is no language-speed conclusion. Chunk choice is a resource-admission and priced-overhead problem. Library proofs, table calls, source conversions, joins, exact headers, local cache rebuilds and proof bytes all remain in the model. Both stock and proposed continuing-state implementations must be distinguished from fresh standalone checks and independent rechecks.

## 1. Frozen mathematical and implementation inputs

The product cell/row library and its ordinary-PA foundation are those of prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md, hash `71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC`, reviewed at `DFF5635A401C45F7C69910B779706F9EAF84843FC5CF3CCD86D1CB0DD64273A7`. The exact expanded state is

    I(x,Y,l,P,A) = (l+P*A=x*Y) AND
                  (A<x AND (l<P AND 0<P)).

The newly reviewed numeral-binding design is independent-feasibility/PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md, `67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59`, with review `D5F0EB33433CBD04C1326D90F1B1EE46A87A11D3C5F7AC7A42ABB95D3D92CDB0`. It supplies literal prefix terms, the padded inner base, exact concatenation passes and public b0/b1 source bindings. Its ordinary proof/library implementation remains open.

Use beta=256 as that packet does. A byte word W(digits,T) means the finite literal expression with low digit outermost, `beta*tail+digit`. It is notation for existing PA terms, not a trusted list interpretation. The product has m input bytes, n multiplier bytes, and a complete m+n-byte result with leading zeros allowed. All concrete digits, carries and table/range facts refer to the actual terms used by the proof.

The accepted general storage designs are audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md and audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md. This note specializes their boundary and cost questions to the product interface. It does not repeat their general correctness claims as new implementation results.

## 2. Exact boundary using the existing row invariant

For a cut after row i, the arithmetic continuation needs the proved I(x,Y_i,l_i,P_i,A_i), with its full equality, three range/positivity components, conjunction association and actual term objects. A statement that merely says the previous rows passed is insufficient.

There are two ordinary ways to export it:

1. A closed concrete theorem whose conclusion is this exact I. The next declaration reconstructs the conclusion in its own arena and applies that already checked theorem.
2. A concrete transition schema with incoming I as an explicit proof hypothesis and outgoing I as conclusion. The chunk proof checks the local arithmetic under that hypothesis. Assembly must discharge it with the base state or earlier chunk; the transition is not a closed proof of the outgoing state by itself.

In either case, the continuation also needs the actual remaining source digits and their range/table bindings. The public operand/output context must survive somewhere in the checked environment or be reconstructed with ordinary proofs. One explicit context includes

    x_src=x,
    Y_src=Y_i+P_i*Y_remaining,
    Z_src=l_i+P_i*Z_remaining,

with the actual source-word tails and exact public terms. The output binding is a word-splitting identity about the supplied result, not evidence that the result is a correct product. Arithmetic I supplies that separate content. At the terminal cut, Y_remaining is zero and Z_remaining is the final high carry. Alternatively retain only the original source/word bindings globally and prove the final concatenation at the root. No need to export every context fact in every I theorem is asserted.

The literal prefix representation has a cost consequence. P_i has an i-step product spine, and Y_i and l_i contain the earlier P_j terms. A naively expanded tree can therefore have quadratic prefix size. The reviewed exact sharing plan gives a linear-size local term DAG, but that sharing does not automatically survive a theorem reset or shorten a newly written unshared header. An exact UTermSave/URef header layout may reuse repeated patterns when the actual local objects satisfy its pointer constraints; its commands still need to be constructed and counted. Introducing a fresh name for every prefix is a different representation with retained definition bodies and conversion obligations.

Consequently the direct I route is sound, but its metadata cost must be measured by the actual exported syntax S_i. Merely resetting scratch does not make sum_i S_i constant. This is why a local-word boundary is worth specifying separately.

## 3. Proposed closed local-word chunks

Partition the multiplier rows into K nonempty consecutive blocks of lengths r_1,...,r_K with sum n. The certificate must retain their exact order, first and last rows, and any final short block. At a block boundary A_in and A_out are actual m-byte carry words. Y_block is the corresponding r-byte multiplier word ending in zero; D_block is the corresponding r-byte low-output word ending in zero. P_block is the literal r-step place term, starting at one and multiplying by beta on the right.

The selected new chunk export is the CLOSED concrete equation (B). It has no incoming arithmetic hypothesis. All cell equations and digit/carry facts needed to establish it are proved within the chunk or imported from genuine checked theorems. The incoming carry is supplied as a concrete word, not assumed to have the correct global product meaning. Its relation to the outgoing carry is exactly what (B) proves.

This closed interface is different from the conditional I transition above. It is possible because the cell arithmetic proves row equalities for any correctly represented supplied carry. The outer A<x invariant is not needed to establish the block equality. Actual byte/carry range hypotheses of the cell theorem are still indispensable. This proposal does not obtain them from a producer label or from the old theorem's internal, unexported calculations.

### 3.1 Fixed row-composition proof

The padded inner base and m cell applications yield each complete row equation

    E: (x*y+A)+0=beta*B+d.

Define a proposed row-composition theorem with nine natural arguments

    x,A,B,y,d,Y,D,P,C

and two proof premises E and

    H: B+x*Y=D+P*C.

Its conclusion is

    A+x*(beta*Y+y) = (beta*D+d)+(P*beta)*C.        (R)

After removing the explicit zero in E, its algebra is

    A+x*(beta*Y+y)
      = (A+x*y)+beta*(x*Y)
      = beta*(B+x*Y)+d
      = beta*(D+P*C)+d
      = (beta*D+d)+(P*beta)*C.

Only associativity, commutativity, distributivity and equality substitution are used. These are the same pinned PA facts used in the row/base proof. There is no division, arithmetic evaluator or assumption about a computed product.

The high block base has two arguments x,C and no premises:

    C+x*0=0+1*C.

Start at the block's actual A_out=C and apply R from its highest row to its lowest. The multiplier and output expressions are built as literal byte words. After r applications the exact result is (B). At each step P becomes P*beta, so the place term has the required r-fold syntax. The higher-tail equation is not inferred from a low-to-high producer trace; it is the already checked premise H of the next ordinary theorem application.

No extra digit extraction is needed to obtain the next row's A. The reviewed padded inner base makes its B an actual m-byte word ending in zero. The first block's incoming word is the m-byte zero word, with its zero equality proved once. Every later boundary carry must match the same actual word on both adjacent exports, or have a separately proved equality transport.

For one r-row chunk, the arithmetic-event layout is

    4mr table uses + mr cell applications
      + r padded inner bases + r row-composition applications
      + 1 block base = 5mr+2r+1.                  (3)

This is a new paper schedule; it is not an adoption of that formula as complete checking cost. Table calls may instead reuse an actually retained closed instance. Ranges, word/source bindings, all term/header work and the generic proof bodies are extra.

In the reviewed H/R convention, the cell contributes 25 per cell, the padded inner base 3, the new row composition 12, and the block base 3. Thus the non-table-instantiation part is

    H+R = 25mr+15r+3.                            (4)

Here R means argument/conclusion-root requests, not the theorem (R). Its cell premise edges include the actual table and range inputs. Their producers and repeated local imports are not priced by (4). Header execution and constructor-child requests also remain separate. Compared with another row schedule, different arities must be priced rather than declaring equal event totals to have equal cost.

### 3.2 Exact joins and final product

A proposed join has thirteen natural arguments

    x,A0,A1,A2,YL,YR,Y,DL,DR,D,PL,PR,P

and five proof premises:

    A0+x*YL=DL+PL*A1,
    A1+x*YR=DR+PR*A2,
    Y=YL+PL*YR,
    D=DL+PL*DR,
    P=PL*PR.

It concludes `A0+x*Y=D+P*A2`. To verify the algebra, expand x*Y, substitute the left equation, factor PL*(A1+x*YR), substitute the right equation, and use the three bindings. Its H+R charge is 13+5+1=19 before construction and header execution. It never multiplies out the large x*Y numeral.

The three bindings are not free metadata. They can be supplied without value arithmetic by the following explicit finite passes. An append lemma has five arguments T,U,V,P,d and one premise:

    V=U+P*T
    -------------------------------------------------
    beta*V+d = (beta*U+d)+(P*beta)*T.              (A)

Starting with `T=0+1*T`, apply A through the LEFT word from high digit to low digit. In r+1 applications this proves

    W(left,T)=W(left,0)+P_left*T.

Run it once with T=YR and once with T=DR. The combined Y and D objects are the literal concatenations. The place binding starts with `PL*1=PL` and uses the three-argument, one-premise step

    PL*Q=R -> PL*(Q*beta)=R*beta.

After s steps through the RIGHT place word it gives `PL*PR=P_total`, oriented as needed by the join. Choose the join premise's orientation consistently with this producer, or charge a symmetry application. In the displayed five-premise version P=P_total is on the left, so one two-argument, one-premise symmetry application is included below.

For left length r and right length s, the two append passes cost 14r+4 in H+R; the place pass costs 5s+2, its orientation costs 4, and the join costs 19. This explicit choice therefore costs

    H+R <= 14r+5s+29                             (5)

plus constructor/header/import costs. A differently oriented join could remove that one symmetry, but no such optimization is credited here. This count uses a different, simpler append pass than the old low-prefix normalization, and needs its own proved generic library.

At the root the block equation still contains A_out. Prove A_initial=0 by the reviewed zero-word pass. Prove the actual full output binding

    Z = D_total+P_total*A_out

by an n-step append pass through all produced low digits. A seven-argument, three-premise final extractor consumes the zero equality, the root block equation and this output binding and concludes x*Ytotal=Z. Its arguments are x,Ytotal,D_total,P_total,A_initial,A_out,Z. The final high carry is not set to zero or truncated. The append plus extractor costs 7n+13 in H+R, before construction/header work.

Finally use the reviewed three source-numeral bindings and six-argument/four-premise public transport to conclude exactly `x_src*Y_src=Z_src`. This retains the original target, independent of the chunking. The actual finite word matching, all requested range facts, and any public/internal digit conversions remain in the certificate.

## 4. What chunking buys, and what it does not

The local export contains x, two carry words, two r-byte block words and one r-step place word. Its literal syntax is O(m+r), even without preserving all old row prefixes. The root's full word is still O(m+n). There is no constant-size representation of arbitrary concrete operands claimed.

One conservative architecture makes every leaf block and every binary join a separately checked closed declaration, followed by one public final theorem. It has K leaf declarations, K-1 join declarations and one final declaration, apart from the library/source facts. A different architecture could keep several joins local in one proof, but then it must account for their simultaneous scratch rather than assuming the same reset behavior.

A balanced join tree has at most ceil(log2 K) levels. At each level the total combined byte lengths are at most n. Therefore the total word/place pass work and word syntax across joins is O(n log K), with an additional O(Km) for repeated x/carry boundaries and actual imports. A sequential chain can instead repeat growing words and have O(nK) such work for comparable chunks. The fixed algebraic join is what permits the balanced tree; the generic parallel-checker design alone does not prove this property.

All leaf arithmetic is still present once: sum mr_i=mn. Chunking does not reduce those cell computations or ordinary table proofs by discarding their history. Any extra local prechecking followed by final ordinary verification is additional work. Conversely an already trusted continuing checker need not replay the leaf arithmetic at each join; it checks the imported statement and join proof.

The closed local equations permit independent checking after the concrete witnesses have been produced. This does not imply independent carry generation or parallel arithmetic search. A producer may need lower rows to discover the next carry, and all resulting witnesses still need the ordinary proofs above.

For small products that already fit comfortably in a proof pack, splitting each product is not automatically sensible. A pack may instead contain many whole products and export the exact higher-level arithmetic or enclosure conclusion required by its consumer. Giving every multiplication a global theorem can create more metadata than the pack can afford. For a general arithmetic DAG, the export must retain every live value/equation crossing the cut, together with any range/error contract its consumers need. That frontier can be much larger than one product's three words. No constant-size arbitrary-DAG summary is supplied by this report.

Row chunking also does not solve an oversized unchanged x word or a deep statement by itself. If m or the imported statement exceeds a local stack/store limit, reducing r may never make the proof fit. A further checked representation or column-level boundary would be needed. That distinct producer is outside this bounded report.

## 5. Stock lifetimes and exact re-import

The current C source supports the following distinctions directly.

|Object|Within one theorem|After its declaration is checked in the same MMB stream|
|---|---|---|
|Local digit/radix head objects and word ASTs|Can be saved and referenced by exact pointer|Discarded with the local store; reconstruct in the next arena|
|Local closed table instances, range proofs, converted bodies|Can share proof/expression references within live scratch|Local references are gone; apply the global theorem again or use a separately implemented trusted persistent fact mechanism|
|Checked theorem schema|May be applied with exact arguments and hypotheses|Global descriptor remains available below the checked frontier; its original derivation is not replayed on each call|
|Checked conservative definition|Body/header can be used by ordinary unfolding|Descriptor/body remains global and must remain live whenever retained syntax or conversions require it|
|A public/source binding exported as a theorem|Has an actual ordinary proof|Can be reused by theorem application; statement reconstruction and any new representation transport still cost work|
|Producer hash, result log, native cache or old arena pointer|No proof authority|Cannot become an imported theorem|

At verifier.c178-200, load_args resets the local heap. At 731-738 definitions reset store/stack; at 771-774 theorems reset store/stack/hypothesis stack and load their binders. Global term/theorem counters advance at 757/790. The theorem table is not an arena of persistent proof values. Applying a previous concrete theorem requires a new local conclusion expression matching its exact header. A caller cannot paste an old heap offset into the new arena.

UTerm checks the actual constructor ID at 250-274; URef checks the exact saved object at 243-247. A fresh arena can reconstruct a valid local shared term DAG and apply the old theorem, but it must use consistent new references throughout that application. Equal values or a matching external digest do not establish the object constraints.

Theorem publication occurs only after its whole proof, hypotheses and statement unification are checked at 770-790. Conv/ConvCut can temporarily place proof-tagged values under pending conversion obligations. Such mid-proof values are not exportable chunk results. Failed, truncated or tainted chunks publish nothing. The full specification and final target checks remain enabled.

Stock verify initializes g_num_terms and g_num_thms to zero for each file at 687-690. Calling it again on a new file does not inherit the old checked environment. The executable maps the whole MMB input before verification. This is sequential traversal with theorem-local resets, not the proposed bounded-buffer multi-file continuation API. Whole-file mapping alone also does not mean every proof byte is simultaneously resident.

## 6. Named digits, caches and retained definitions

The newly reviewed named-natural design is prime-estimates/NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md, `99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988`, reviewed at `5B9F0652F6312613094A68E3E8E794A78F119073409C95E0077F9AEEDADAC216`. Its acceptance is conditional representation scope, not generated-table or whole-pack admission.

It keeps literal zero/one, uses conservative nullary definitions with canonical binary bodies for the other digits, and gives the radix its own checked definition. These global definitions can persist across chunks. A local TermSave object for a named head and a locally unfolded binary body cannot. A named theorem header does not unfold its digit definitions automatically, and a generic header must use the same named radix or have an explicitly proved specialization.

The fixed-width zero-ended digits of the numeral-binding packet are not the canonical bodies of this named design. Select one representation for the whole chunk plan. If combining them, charge actual definition unfolding, padding normalization, equality transport and local object reconstruction. Do not insert the fixed-width adapter counts unchanged into a named schedule and declare the gap closed. The exact generic-library specialization is setup; repeated per-use conversions are an alternative schedule, not free.

Let t_i be the number of distinct closed table/range facts instantiated in chunk i, h_i the number of local named heads constructed, and b_i the amount of unfolded body syntax actually needed. These are data/lifetime-dependent quantities. Charge their theorem-header executions, object construction and local references. Global checking of a table theorem's body is a separate setup cost. A checked global declaration saves re-proving that body, not automatically the local Thm call or its conclusion construction.

The sum_i t_i can exceed the number of distinct facts used in the whole product because the same facts are re-instantiated after resets. No digit-diversity or cache-hit distribution is supplied here. A full fixed table can be checked once and reused globally, but its entire declaration metadata and ordinary proof setup remain real costs. A sparse table has a different setup/lifetime policy. Evicting a checked fact from a proposed global cache requires rejection of stale references and re-establishment before a later use.

If a chunk exports formulas mentioning private named values, retain their complete reachable definition bodies and dependency descriptors, or prove an elimination to the fixed public syntax before export. Renaming or forgetting a definition while keeping a theorem that mentions it is not a storage optimization. The simplest local-word interface uses only fixed-library constructors and actual numeral words, so its closure is explicit.

## 7. Three implementation/acceptance modes

**Stock merged MMB.** Link the library, all leaf/join proofs and the final theorem into one exact stream/specification. The stock checker checks the library once, checks each declaration once, and reuses its header thereafter. Local scratch resets at each theorem. Global tables and the mapped input remain. A linker may be untrusted because the ordinary checker validates every remapped reference and final statement. Its generation, serialization and layout costs still belong in the end-to-end model.

**Continuing bounded-state ordinary checker.** The previously reviewed proposed implementation retains an immutable checked library and a bounded live frontier of exact theorem/definition descriptors. It commits only fully checked declarations, imports only from that trusted frontier, copies their exact surviving syntax, and then releases obsolete arenas/descriptors. This changes storage/transport, not arithmetic rules. It is not present in the pinned stock executable. It needs actual implementation, stale-reference/freshness checks, completion handling, and retained-definition closure. The implementation trust standard should be the same as for the Lean kernel/module pipeline, not an extra demand to formally verify only MM0's whole executable.

For a depth-first balanced composition, a bounded frontier can hold completed sibling results while checking the next subtree. Their total word lengths are O(n), with O(m log K) repeated carry/x syntax before sharing, plus the active leaf arena and fixed library. This is a possible schedule, not a bound for dispatching all leaves at once. Parallel dispatch needs bounded result queues/backpressure and may increase that frontier. Shared versus process-copied library memory must be stated.

**Fresh standalone runs.** Each new stock verify call starts from no checked theorem frontier. It must receive ordinary derivations of the required imports, or operate inside a separately specified trusted persistence/restore system. A summary file containing a statement and success hash is not such a derivation. Replaying the whole growing prefix is a possible but avoidable quadratic strategy. Independent chunk prechecks followed by a final merged check are valid and charge both passes. Trusted continuing parallel checking can avoid duplicated arithmetic only with the reviewed result-publication protocol, not with producer receipts.

An independently reproducible certificate retains or can regenerate the full ordinary proof input. Discarding already processed buffers in a successful continuing run does not let a later independent checker establish provenance from just the final short equation.

## 8. Cost model and a concrete chunk decision inequality

Keep separate generation, verification, transport and memory quantities. For a chosen partition and composition tree let

- G_lib be generation of the fixed PA tables, ranges, cell/row or block/append library and source adapters;
- L be their ordinary checking plus declaration/definition parsing;
- G_i be witness/proof construction for leaf i, including its exact digit/carry terms and any concrete representation conversions;
- V_i be its complete ordinary proof work, with actual table instantiations t_i, head/body reconstruction h_i,b_i, generic theorem applications, executed unification/definition headers and term/ref/conversion operations;
- J_v be each complete join proof, including the Y/D/P binding producers and exact imported theorem use;
- I_i,E_i be input decoding/statement installation and export copying/validation not already in V_i;
- G_link,G_store be linking/encoding and any actual reclamation/persistence work;
- Z be the final zero/high-tail/public bindings and exact target/end checks.

Then a single successful continuing or merged ordinary check, without redundant prechecks, has total work

    G_lib + sum_i G_i + G_link
      + L + sum_i(V_i+I_i+E_i) + sum_v J_v + G_store + Z.             (6)

All units in a comparison must match. A useful pre-calibration vector records theorem applications by signature, executed header commands, constructor-child requests, references, conversion/unfold-body commands, proof/header bytes, and peak live stores. A scalar price assigns explicit nonnegative costs to those categories; it is not yet seconds. Compiler/generator native multiplication used to find witnesses is included in G_i even though its result is not trusted by the checker.

For stock merged checking, L occurs once, not once per chunk. F fresh checking processes may incur F library checks unless a genuine trusted shared environment is used. Operating-system page sharing can reduce physical memory without removing CPU parsing/checking. A later independent full verification is another chosen pass; do not charge it only to one prover or silently omit actual local prechecks.

For leaves of r rows the new conditional arithmetic counts are (3)/(4). For joins use (5), with complete construction/header costs added. Over a balanced tree, (5) gives O(n log K+K) non-cell work plus the actual imported word widths, while leaf arithmetic remains O(mn). This is a source-backed structural relation, not a speedup ratio.

For two neighboring candidate chunkings on the SAME arithmetic DAG and representation, define Saved as the priced sum of removed local table/head/body reinstantiations, declaration/import work, block bases and joins. Define Added as any extra live-expression construction, header/unifier work, representation bridges, cache-management cost or required layout work in the coarser proof. Coarsening is preferable in that price model exactly when

    Saved > Added,                               (7)

provided the coarser proof passes every resource-admission constraint. Equality gives no cost preference. Keeping an unchanged arithmetic DAG makes it possible to compare these categories without pretending that a machine-language speed ratio settles them. An interior optimum is not inferred without actual category prices and resource curves.

At minimum the admission constraints include local heap/stack and unification capacities, the expression store, hypothesis count, statement depth, declaration IDs, signature offsets and each proof's next-statement displacement. Current defaults include 65,536 heap/stack slots, a 64 MiB store, 256 hypothesis/unification-stack entries and 65,536 unification-heap entries. Actual generated maximum live objects and expression layouts must be used. A small arithmetic-event subtotal is not that analysis.

Globally, all statement data starts and the term/theorem tables must fit the stock u32 fields; individual proofs also have a u32 forward displacement. This is not a universal 4 GiB bound on the entire file. Increasing the theorem chunk count may solve scratch pressure while violating metadata limits. If no partition fits both, a consistently widened same-rule transport or a different proved representation is an implementation requirement, not permission to import unchecked shard conclusions.

For a successor bounded-state checker, a conditional memory model is

    retained library/definitions
      + live exact theorem frontier and its definition closure
      + active local arenas + bounded transport/parser buffers.

For stock merged checking, add its accumulating global metadata and account for mapped-file paging separately from resident memory. Neither model discards a needed source binding, definition body or unresolved conversion to fit the limit.

## 9. Fair comparison with Lean

The same mathematical chunk equations and joins can be stated in Lean, but equal arithmetic identities do not imply equal checking instructions. Two comparisons should remain distinct.

The first uses matched explicit lemma/proof DAGs and records their actual term construction, substitution, typing, library import and final target costs. The second allows each system's ordinary kernel-compatible arithmetic method. Lean kernel reduction or proof-producing reduction may handle natural numerals differently from explicit PA digit proofs in MM0. Its generation, reduction and proof/import costs must then be measured in its own model. A native unproved arithmetic answer is not silently introduced on either side. No C-versus-Lean language multiplier is used.

The pinned Lean 4.35 Environment.lean explicitly supports module exports that omit richer theorem proof information. Its subsumesInfo code at 2250-2283 compares theorem names/types/level parameters and permits the exported theorem representation described there. This is compiled-module provenance, not a fresh check of an arbitrary supplied short interface. A clean build/check must establish every underlying proof, and the full artifacts must remain available for the intended axiom audit or independent recheck. The reviewed composition report distinguishes legacy imports, module-private data and full independent checking.

Accordingly compare a clean Lean dependency build plus actual final imports with one complete ordinary MMB check, or compare independent complete rechecks on both sides. Do not compare a warm trusted Lean import against F fresh MM0 library replays unless that is deliberately the chosen operational setup. Likewise do not charge Lean every old arithmetic proof again merely because a final module imports a checked theorem.

Both systems need the exact public source theorem and allowed foundational closure. A checker's implementation/persistence engineering is part of its assurance account; the policy must apply symmetrically. Neither requires a formal proof of its entire implementation merely to be included in this research cost model, and neither gets to treat an untrusted summary as a theorem.

## 10. Source pins, scope and stopping point

The following source versions were read directly or rechecked against the cited accepted packet. Paths are relative to the workspace except the Lean source. This note creates no new executable receipt because the task is static source/paper reasoning, not a metadata enumeration.

|Path|SHA256|
|---|---|
|independent-feasibility/PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md|67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59|
|integration/REVIEW_PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md|D5F0EB33433CBD04C1326D90F1B1EE46A87A11D3C5F7AC7A42ABB95D3D92CDB0|
|prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md|71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC|
|moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md|E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6|
|prime-estimates/NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md|99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988|
|moebius/REVIEW_NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md|5B9F0652F6312613094A68E3E8E794A78F119073409C95E0077F9AEEDADAC216|
|audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md|53AD15DAE3EE3F19B1ABEA27B26F4ECD593ED7F6C557001FC2BF2A5B7957FE40|
|independent-feasibility/REVIEW_EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md|8BC3923014640241C3D40EDB1D8DD85C35922D8E2D18C11898D3D307C6A33886|
|audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md|4927B1604C4E13A001CDD3C9176F024D11A3FA8ECB0C6EB35F3C70A0B9F100FE|
|independent-feasibility/REVIEW_EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md|AA3EF5871BD12DDD6479C7A0C978F746E6EB8DAB57A04791323322552CDC7C43|
|integration/EFFICIENCY_PROOF_COMPOSITION_2026-11-11.md|FE62515193754C19CDB4A34728765CFA09DD5BEDD1694E5D575DCC79EE7D4E9B|
|work/mm0-efficient/toolchain-sources/examples__peano.mm1|13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079|
|work/formal-goldbach-bench/mm0/src/verifier.c|71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5|
|work/formal-goldbach-bench/mm0/src/verifier_types.c|87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E|
|work/formal-goldbach-bench/mm0/src/types.c|B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1|
|work/formal-goldbach-bench/mm0/src/main.c|ECDE31379241E38CA0B375DF0F40B216E9108F6CFD45952CCB282658D883DE17|
|work/formal-goldbach-bench/mm0/src/README.md|5ADA16E00CD2F72E7F83D247768CDE6ADE34E56962B1858BC014FABEDC900A70|
|C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/Lean/Environment.lean|6C90105AECC4D28EFE94CC9AEF1704C284E7A748B28270B5F8513D2562331E43|

The agent-report paths in the first eleven rows are under work/qrh-campaign/agents/. PA algebra uses the same ordinary equality/congruence and natural addition/multiplication facts at peano.mm1:901,2034-2153 as the reviewed row/binding packet. No new axiom or numeric evaluator is proposed.

The bounded result is an exact boundary/cost design, including a fully spelled-out local-word algebraic alternative. It identifies the missing implementation measurements rather than supplying a runtime estimate: actual generated schemas and proof traces, local cache diversity, complete conversion paths, stock-format admission, and per-category costs in each prover. The new local-word lemmas and their complete schedule need independent paper review and ordinary proof implementation before adoption. Work stops at this report; no larger scan or calibration follows from it.
