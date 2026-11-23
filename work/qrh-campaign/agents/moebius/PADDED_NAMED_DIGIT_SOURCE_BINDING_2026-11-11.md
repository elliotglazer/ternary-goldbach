# Padded named digits matched to the public-numeral adapter

2026-11-11. Bounded paper and static-syntax design, submitted for independent review. No definitions, tables, arithmetic instances, proof streams or builds were emitted. The canonical-body named-digit packet and accepted numeral-binding packet remain unchanged.

Use the source adapter's exact fixed-width bit strings as the bodies of the new digit aliases. This removes the representation mismatch for digits other than zero and one. Preserve literal zero and one and connect their padded strings by two ordinary PA equality proofs. A mixed-radix glue theorem then consumes the digit equality explicitly. Reuse can remove repeated arithmetic normalization, but it still pays actual theorem/header applications, term construction and local cache reconstruction.

## 1. Frozen starting points and proposed representation

The canonical named-digit design is `prime-estimates/NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md`, SHA256 `99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988`, reviewed at `5B9F0652F6312613094A68E3E8E794A78F119073409C95E0077F9AEEDADAC216`. The public-numeral adapter is `independent-feasibility/PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md`, `67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59`, reviewed in integration at `D5F0EB33433CBD04C1326D90F1B1EE46A87A11D3C5F7AC7A42ABB95D3D92CDB0`. Agent paths are relative to `work/qrh-campaign/agents`.

Fix beta=2^w. The directly accepted source-adapter case is w=8. The same w-fold affine induction below gives a paper generalization for w10/12/16; its larger-radix library remains to be implemented and checked.

For a w-bit syntactic pattern, let P_d be exactly its w b0/b1 heads applied to d0. The outermost head is the least significant bit. There are exactly w+1 nodes, including the terminal d0. The subscript is a mathematical catalogue label; it is not a trusted evaluation of the term. The actual constant catalogue must bind the complete declared body to the actual pattern used by the source decoder.

For 2<=d<beta, introduce a fresh nullary natural definition D_d with body P_d. Set D_0=d0 and D_1=d1 literally. Define the new radix B by the existing expanded beta term b0^w(d1), as before. There are beta-1 new definitions. These are different definitions from the canonical-body packet, not replacements for its frozen IDs or proofs.

The existing b0/b1 definitions use only the natural sort and ordinary arithmetic. Def checks body, type and dependencies before making a new term available; Term can reference only earlier terms. The definition bodies therefore need no new arithmetic axiom or coercion. The later table and bridge proofs still require the accepted no-Sorry/axiom closure and source-translation conditions. A native table index does not substitute for a checked body or theorem.

## 2. Exact digit bridges, including zero and one

The desired bridge for every pattern is the ordinary equality

    G_d: P_d = D_d.

For d>=2 this follows from reflexivity and explicit conversion using the checked D_d definition. It is a definitional bridge, not a multiplication computation. The checker still executes the definition header and requires the supplied expanded body to match it. A global closed bridge theorem can export this equality once; a local direct Conv proof is an alternative with its own cost.

The exceptional patterns are

    P_0=b0^w(0),
    P_1=b1(b0^(w-1)(0)).

They are not silently identified with d0/d1 by definitional conversion. In the actual PA source, b00 and b10 are proved arithmetic equalities. Two fixed helpers suffice:

    T=0 -> b0(T)=0,
    T=0 -> b1(T)=1.

Each has one natural argument and one premise. Starting with 0=0, w zero steps prove G_0. Starting with 0=0, w-1 zero steps followed by the one step prove G_1. Each proof uses w+1 theorem applications including its reflexive base. Its H+R contribution before constructor children and the single END is 3w+2. The helper's header has9 commands, cached call4 and fresh-conclusion call7 in the existing command model. The fixed helper proofs use congruence, transitivity and b00/b10 and are separate setup work.

The two exception facts may be reused as global checked theorems or actual retained local proofs. Their theorem applications and statement matching remain charged. This prevents normalization of a padded zero or one from becoming an unpriced per-occurrence arithmetic operation.

A bridge must concern the actual P_d and D_d objects consumed by the next theorem. UTerm matches the constructor heads without unfolding; URef matches exact saved object identity. A proof cached for a separately allocated equal-looking P_d cannot satisfy a generic premise on another P_d by pointer equality alone.

## 3. A glue interface that consumes the bridge

The accepted affine source construction runs from inner bits to outer bits and proves

    S=beta*T+d,

where d is precisely the w-head padded body P_d, and beta is still the expanded b0^w(1) term. Retain that construction. Replace the old four-argument/two-premise byte glue by this five-argument/three-premise library theorem:

    S=beta*T+d,   T=U,   d=e
    --------------------------------
    S=B*U+e.                                      (G)

Its arguments are S,T,U,d,e. Its proof uses the two supplied equalities by multiplication/addition congruence and transitivity, plus the checked equality or definitional conversion between beta and B. That radix conversion occurs in the fixed generic proof, not implicitly on every theorem application. The actual cell, row, concat and padded-base library must also be proved with the same named B.

Instantiate e with the actual named digit D_d and the third premise with G_d. The output is a word with named digits and named radix, exactly the representation required by the named table/cell library. The higher tail U is the same already bound named word. For d=0 or1, the same interface consumes the arithmetic exception bridge and emits the literal d0/d1.

The mixed glue has header w+24 commands, cached call10, fresh-conclusion call16, H+R=9 and six conclusion-child requests. At w8 these are32/10/16, compared with the old glue's36/8/22. The H+R increase is exactly2 per decoded digit; the digit-bridge producer is additional. There is no claim that the fresh-call difference alone is a complete cost saving.

This theorem changes the adapter interface, not its public conclusion. The three source operands still receive actual equality proofs to their internal words, and the accepted final transport still proves x_src*Y_src=Z_src. The concat passes and padded inner base retain every high carry. Range proofs, positivity and the separate zero-product branch remain mandatory. An arbitrary supplied output word is accepted only after the cell/table arithmetic establishes the row invariant and terminal product equality.

For w=8 one may conservatively retain the accepted caller bound

    4mn+1313m+1324n+668

and add4(m+n) for the H+R increase across decoder lengths m,n,m+n, plus all digit-bridge, catalogue, local-sharing and new-library costs below. This does not subtract the smaller named conclusion construction. The old bound's general constructors remain an upper reserve under the stated matched construction; any new registry allocation is charged separately. The padded-base substitution and range work retain their previous accounting.

For general w the same source-one/padding/affine reasoning gives at most

    (3w+2)L+8

adapter theorem applications for a source fitting L radix digits, before the new bridge producers. The w affine lifts and one start/one glue give (w+2)L+1; each of the two source-normalization passes is bounded by wL+2, with the remaining transitivity allowance. No general-w version of the numerical622L+200 child-request bound is borrowed without recalculating its syntax. The public source grammar and declared length restriction are unchanged.

## 4. Two explicit reuse schedules

One complete option checks closed bridge facts G_d for all beta patterns. A sparse option checks only the actually requested pattern facts. Neither is generated here. An indexed catalogue is a producer aid only; the actual bridge theorem and its statement must identify the padded pattern and alias.

Under an uncached application schedule, every decoded digit constructs its actual equality target and applies the matching checked closed G_d. Its header has w+4 commands: P_d contributes w+1 nodes, D_d one, equality one and END one. This includes the zero and one cases. Thus N occurrences pay N such header executions, along with actual target/reference traffic. The bridge's arithmetic proof body is checked at its global declaration, not repeated as an unproved native normalization.

Under a local retained-object schedule, construct the body tree and named head once for each distinct pattern needed in that theorem. Retain the bridge proof on those exact objects. When applying the w affine lifts to another source occurrence, use the saved body subtrees as the running digit objects. Each lift's constructor/premise matching checks that those subtrees have the required bit heads. This preserves the actual P_d identity needed by the cached bridge. Incorrect pattern lookup cannot be accepted merely because the generator supplied a code: the affine chain and bridge header must match the source bit syntax.

Let K_l be the number of distinct body/head pairs constructed in local theorem lifetime l, and N_l the number of source digit occurrences. The retained schedule pays body/subtree construction, bridge application or local conversion, head construction and saved proof references for K_l objects, plus actual uses in N_l mixed-glue applications. It must fit the local heap/store and preserve the required objects. There is no presumed K_l/N_l ratio. Internal row digits, range proofs or other consumers can require further patterns and uses and must be added.

Global closed bridge and definition IDs persist in the checked stream. Their local expression pointers and retained proof objects do not survive theorem reset. Rebuilding across chunks or files, imports and catalogue checks are separate costs. A full registry is not assumed to fit the stock heap, and a hash is not an accepted imported theorem.

## 5. Definition, header and setup prices

The proposed beta-1 definitions all have w+1 body nodes, including the radix. Therefore

    N_pad=(beta-1)(w+1),
    N_pad-N_canonical=2beta-2w-2.

Body and definition-header streams each have (beta-1)(w+2) commands including ENDs. Under the previously stated old-term ID models, the entry/binder/body/header/two-byte-statement-prefix subtotals are

    20(beta-1)+4N_pad       for two-byte old heads,
    20(beta-1)+10N_pad      for five-byte old heads.

Alignment, names and prelude remain additional. At w12, N_pad=53235 instead of45069, an increase8166. Each stream has57330 commands. The two byte subtotals are294840 and614250, versus262176 and532590 in the canonical packet.

For the optional complete bridge library, there are beta extra theorem entries and beta(w+4) unshared header commands. Under two-byte old bit/equality heads and three-byte aliases, its exact header bytes are beta(2w+8)-2; the two literal exception targets save one byte each. At w12 this is65536 header commands,131070 header bytes and32768 theorem-entry bytes, before bridge proof bodies and alignment. The ID interval assumptions and remaining stock limits from the named packet still apply; w16 does not satisfy its three-byte alias interval.

The compact arithmetic-table headers remain10/12 commands. Definition-body choice does not change those heads. It does change setup conversions. A canonical binary table proof is not definitionally convertible to a padded alias merely because the two numbers agree. One must either prove the table directly in the padded spelling, or first supply ordinary PA normalization equalities connecting the two spellings. A zero-prefix chain followed by the significant b1 step and outer bit congruences gives a conservative w+1 theorem-application normalization schedule per pattern, including its reflexive start. Those proofs and their uses in table setup are additional.

Once such setup is checked, later compact table applications do not unfold the definitions. The arithmetic facts still need ordinary PA proofs, checked result spellings and all digit/carry ranges. A padded bit-range induction proves P_d<beta, and equality transport through G_d and beta=B gives D_d<B. This range proof is separate from G_d. Neither a constructor name nor an equality fact exports it automatically.

## 6. A complete conditional decision

Compare equal final public theorems and the same declared arithmetic workload. Let C_common contain the shared cell/row work, source bit reading, existing padding, concat and final transport. Let L_pad be the newly proved generic-library specializations. Let G_pad be definition, bridge, range and table generation/checking, with its actual global import lifetimes. Let R_l(K_l,N_l) contain local body/head construction, bridge applications/header executions, reference traffic, catalogue matching and source binding. Then a complete candidate cost has the form

    C_pad = C_common + L_pad + G_pad
            + sum_l R_l(K_l,N_l) + remaining encoding/storage/import work.

At w8 the explicit mixed-glue H+R increment can be charged as2*sum_l N_l relative to the old glue. The bridge costs cannot also be hidden inside that term. Choose either uncached per-occurrence application or a justified retained-object schedule, and count its actual identities and lifetimes. Generation, proof checking, bytes and memory require separate cost functionals.

This candidate is preferable to canonical-body names only if any reduction in runtime padding/normalization and header work exceeds the larger definition setup, bridge producers, table spelling conversions, library specialization and differential cache/transport costs. No unknown cost or cache hit rate is set to zero. It supplies a compatible representation and explicit proof obligations, not a universal speed gain or a stock-admission theorem.

## 7. Source map and immutable metadata

Actual ordinary source `examples__peano.mm1` has SHA256 `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`. Lines3011-3018 define b0/b1; lines3024-3025 prove b00/b10. Equality and arithmetic congruence/transitivity at2034-2153 support the fixed glue/exception proofs. The cited evaluator annotations are not acceptance rules used by this design.

Actual `verifier.c`, SHA256 `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`, checks URef/UTerm at243-274, explicit conversion at537-598, definitions at720-758 and theorem-local resets at768-802. These rules explain why the exact body and object-sharing conditions are necessary. No new trusted numeral rule is introduced.

Owned `padded_named_digit_binding_20261111.py` has SHA256 `7362F691F211F06474B4BCBA64A69CEEE46C9936E29F82BC75D0D1E9A5E2C11B`; its6832-byte receipt has SHA256 `4016F05CE9C279C707C380DEDCDD10A3779BEF582F1BD4159EB1FF43BB017FA3`. It passes35 static checks of seven pins, four symbolic radix rows, exact helper/glue signatures and hypothesis substitution. It constructs no digit catalogue or arithmetic proof instance and imports no author writer. The paper's induction and source argument remain subject to independent review. All frozen predecessors are preserved.
