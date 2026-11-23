# One ordinary-rule signed dyadic product-round schedule

2026-11-11. Bounded paper and static-source design. No arithmetic instance, digit enumeration, inventory fold, proof emission, declaration or build was performed. Frozen predecessors are unchanged. This is a complete mathematical acceptance interface and a conditional proof-work accounting schedule; the proposed composite PA lemmas and byte facts are not an implemented arithmetic library.

The useful local choice is to retain proved byte words between multiplication and rounding. One unsigned product and two natural additions suffice for the rounded branch below. Powers of two use a separately proved shift binding, rather than another general multiplication. Stock theorem-local reuse can reduce repeated closed-fact applications. Neither improvement removes source binding, range proofs or the final signed interpretation.

## 1. Exact scope and acceptance target

Fix input grids px, py and output grid po, with signed exact inputs

    x = (-1)^sx A 2^(-px),   y = (-1)^sy B 2^(-py).

The signs sx,sy are literal 0 or 1 after a checked source adapter. Allow either sign for an internal zero magnitude. Let a>=b>=1 be declared magnitude capacities, with proved A<2^a and B<2^b, and put

    t = a+b,   s = px+py-po,   1 <= s <= t,
    S = 2^s,   H = 2^(s-1),   sigma = sx XOR sy.

These are the hypotheses of this one materialized rounding branch. The integer exponent relation, powers, inequalities and source-grid meaning require ordinary proofs or previously checked exact interfaces. They are not unchecked host metadata. A gate with s<=0 or s>t needs another interface and is outside this price formula. Swapping operands to arrange a>=b requires the actual input permutation/commutativity binding.

The requested output is the signed dyadic z=(-1)^sigma M 2^(-po), rounded to nearest with half ties toward positive infinity. Its public sign may differ from sigma only when M=0. The final exported statement binds this value to the actual destination object and proves

    -2^(-po-1) < z-x*y <= 2^(-po-1).

It also proves the specified nearest-grid rule, not just an enclosure. Integers and dyadics here are mathematical notation for the accepted natural-pair bridge, not new trusted sorts. If the destination requires odd-mantissa canonical form, its exact normalization is an additional final adapter; otherwise the fixed grid po is retained.

## 2. Bound arbitrary candidates before bounded arithmetic

An untrusted producer supplies product magnitude C, rounded magnitude M, remainder r, shifted magnitude D, and a common addition result Z. Before using any width-priced arithmetic, require proved bounds

    C < 2^t,             M < 2^(t-s+1),
    r < S,               D < 2^(t+1),
    Z < 2^(t+2).

All are natural numbers, so nonnegativity is part of their type. Check the same kind of bound for every supplied intermediate digit/carry and every actual source word. A parser's length limit prevents oversized allocation; it is not the PA proof of a bound. Conversely an eventual product/equality proof cannot justify allocating an arbitrarily large candidate beforehand.

One explicit representation is the earlier literal radix-256 word W, with padded eight-bit natural digit terms ending in zero. Short top bytes require their smaller power-of-two bound; byte bounds alone give only a byte-rounded capacity. Closed byte facts or the ordinary bit-range lifts produce these bounds. Every bound must be consumed by the final acceptance composition, decoder or range-checking arithmetic theorem. Disconnected proofs left on a stack do not count as acceptance.

Prove D=M*S by a power-of-two shift/word binding. The cost includes the exact s-bit shift, any partial-byte boundary, high zeros and proof of equality to the retained D term. The adapter is not a trusted native shift. For complete valid witnesses D<2^(t+1) follows from the M cap, but the priced representation still needs that bound before bounded operations. No cancellation or a small residual is assumed to reduce a raw candidate width.

The caps are complete for this branch. If C<2^t, nearest rounding of either signed C/S has magnitude at most C/S+1/2, hence less than 2^(t-s+1). The resulting D has the stated cap. All sums below are less than 2^(t+2) even for independently supplied candidates satisfying the preliminary bounds: D+r<2^(t+1)+2^s<=3*2^t, while C+H<2^t+2^(t-1). Thus the common raw cap does not depend on trusting either equality.

## 3. Product and the two round equalities

First prove the natural equality A*B=C. Use the reviewed full 15-argument/9-premise cell, the row/base schedule, and the padded inner base PB. Do not substitute the distinct zero-carry cell or named-radix layouts into its counts. The actual top carry is retained. Choose m=ceil(a/8), n=ceil(b/8); the product word has m+n byte positions and a separately checked t-bit bound.

The positive-A branch supplies a genuine 0<A proof from the bound source syntax. If A=0, use its proved zero binding, ordinary zero multiplication and transport to C instead of applying the positive row invariant. This is a separate zero branch with its own signature/term costs. B=0 remains admissible in the positive-A row branch with leading-zero digits; alternatively it can take a separately charged zero-product proof. Branch selection is justified by checked syntax/equalities, not a native zero test alone.

Let ell=ceil((t+2)/8). Pad the addition inputs to ell bytes by proved word equalities. Use two range-checking natural adders, each with initial carry zero and its actual final carry retained. Their output tails are the same retained object Z, or are separately proved equal to it. The two sign branches are:

| Product sign | First addition | Second addition |
|---|---|---|
| sigma=0 | C+H=Z | D+r=Z |
| sigma=1 | D+H=Z | C+r=Z |

This is two additions, not an implicit comparison/subtraction routine. The final adder carry is not discarded to force the destination width. The prior bound on Z and a proved representation equality justify any leading-zero removal. In the generic adder, each result initially has the form `(U+V)+0=Z`; the separate three-argument/one-premise zero-carry removal adapter gives U+V=Z.

For sigma=0 the equalities imply C+H=M*S+r. For sigma=1 they imply -C+H=-M*S+r. Thus in both branches, with signed product P=(-1)^sigma C and signed grid integer Q=(-1)^sigma M,

    P+H=Q*S+r,             0<=r<S.

Since H=S/2, division by S gives Q=floor(P/S+1/2). Equivalently Q*S-P=H-r lies in (-H,H]. This proves the asymmetric tie rule, including negative ties and zero. Two accepted candidates must give the same Q: subtracting their quotient/remainder equations leaves an integer multiple of S with absolute value less than S. Existence is the ordinary division algorithm applied to the shifted signed integer, or its natural-pair case split; it is not an additional numerical assumption.

The unsigned product plus the proved sign-XOR identity establishes the exact signed product. The last equality and the checked exponent relation establish z and its dyadic error. Public output sign/zero rules are checked here. Canonical odd-mantissa output additionally proves M=2^v U with U odd and positive, changing the exponent from -po to -po+v; zero has its specified canonical form. The current exponent must be used, as required by the signed-bridge clarification.

## 4. The retained-word and source interfaces

Use literal terms `W([],T)=T`, `W([d0,...],T)=beta*W([...],T)+d0`, with beta=b0^8(1). W denotes construction of actual PA ASTs, not a trusted evaluator. Input sources may be already bound words or the supported public b0/b1 numeral grammar. For the latter, the reviewed source adapter uses at most 26L+8 theorem applications for an L-byte operand, with a deliberately conservative request bound 622L+200. These are upper schedules, not mandatory costs on every internal word.

The product's C word is retained as an operand of the round check. It is not converted to a public binary numeral and then decoded again. Likewise retain the exact M word through its D shift and output binding, and retain the same Z result object across the two addition proofs. Necessary padding, shift, source-to-word and equality-transport proofs remain. URef requires the actual saved identity; independently rebuilt equal-looking words require equality or conversion work.

The product caller can use the full reviewed binding schedule: literal prefix terms, three intermediate reflexive bindings per row, two concatenation passes, the initial padded zero carry, positivity transport and final transport. In that final transport the product-side target may itself be the retained C word; its binding is reflexive and still supplied. This sufficient schedule retains its published H+R count, even where a later implementation could omit trivial transports. Boundary input decoders and their positivity/range producers are separate from this count.

For addition, high-tail identities are actual shared word subterms, and source padding/shift adapters bind the requested operands to them. The common Z binding must be proved if the two constructed output tails are not the same pointer. This obligation cannot be replaced by the fact that the two producers wrote equal integers.

The concrete representation saving is narrow: compared with an otherwise identical schedule that exports C to a fresh public numeral and decodes it again before rounding, retain C and delete those two adapter sub-DAGs, retaining all required padding/bindings. The saved commands, headers and term nodes are exactly those of the deleted sub-DAGs minus any genuinely necessary replacement sharing operations. The loose 622L+200 decoder ceiling is not a lower bound on savings. No universal conversion saving is inferred for a producer already using words.

## 5. Ordinary command and header model

The following table is a signature inventory, not a list of new proved declarations. It uses the reviewed expanded beta headers. a is expression arguments, h is proof premises and u is executed header instructions per new application.

| Interface | Uses in the positive-A branch | a/h | u |
|---|---:|---:|---:|
| Full product-cell lift | mn | 15/9 | 182 |
| Padded inner base PB | n | 2/0 | 22 |
| Product initial state | 1 | 1/1 | 26 |
| Product intermediate row | n-1 | 11/7 | 120 |
| Product terminal row | 1 | 10/4 | 80 |
| Full product caller, as specified above | aggregate | H+R=20n+3m+26 | 96n+20m+104 |
| Range-checking adder lift | 2ell | 8/7 | 116 |
| Adder terminal base | 2 | 1/0 | 8 |
| Adder initial-zero removal | 2 | 3/1 | 14 |

Each product cell also consumes four closed table equalities. Each adder position consumes one closed full-adder equality. Range premises need genuine producers. A table equation does not itself export all byte or carry bounds. A table on differently spelled digits needs a proved conversion to this selected table interface.

Let E be the multiset of additional *parameterized* application nodes actually needed for this gate. It includes source decoders, exponent/power/shift and padding bindings, all nonclosed range producers, zero/sign routing, the final nearest-rule/source/destination composition, canonicalization when required, and any state/import joins. For each j in E record its actual `(a_j,h_j,u_j)` and constructor occurrences. The new pair/dyadic/rounding composition's exact expanded header is not supplied by the old natural arithmetic library; its implementation and u_j remain named obligations. A wrapper application is not one command.

Let D0 count newly instantiated closed zero-argument/zero-premise facts in the complete connected DAG, after the chosen local cache policy. Let C_terms be all child-expression requests for newly built terms, including powers, literals, conclusion/premise trees, source and word terms. Under the accepted first-use connected-DAG schedule, with one final root and one END, the positive-A branch has

    I_body = 25mn + 42n + 3m + 32ell + 41
             + D0 + C_terms + sum_(j in E)(a_j+1+h_j)
             + I_outside.

I_outside records commands outside that scheduling fragment, such as explicit conversion/hypothesis/declaration operations; it is not set to zero by default. The constant uses H+R=25mn+22n-1 for the PB product core, the displayed caller, H+R=32ell+14 for the two adders including zero removal, and the single +2 scheduling term. Do not add a separate END for each component. Shared premises are edges, not new applications. All range roots must join the final connected proof before this identity applies.

Executed ordinary theorem-header instructions, before the final declaration match and any definition-conversion headers, are

    U_apply = 182mn + 238n + 20m + 232ell + 134
              + sum_(new closed facts f) u_f + sum_(j in E) u_j.

The caller header subtotal follows from its exact listed reflexivity, zero-word, concat and transport signatures. PB's larger conclusion must be included in C_terms; importing an older fresh-conclusion product price without its twelve extra child requests per row is invalid. The zero-product branch replaces the positive product/caller application multiset by its actual zero/transport multiset; the rest of the acceptance contract and two-addition schedule remain. It has no unjustified 0<A premise and is not priced by inserting zero into mn.

These formulas permit a workload sum over gates/blocks without an event-to-command multiplier. Add actual opcode distinctions, argument/dependency checks and allocation/traffic. A symbolic work expression is

    W = W_library + W_import/join + W_generation
        + sum_o price_proof[o]*I[o] + sum_o price_unify[o]*U[o]
        + W_argument_checks + W_allocation/traffic + W_source/export.

Terms already included in an opcode price must not be charged again. Source/export applications may be placed in E and their remaining production/transport work in W_source/export; document that split. The finite PA library, table and range proof generation/checking are real setup costs. Their existing paper derivations do not make them checked MM0 facts. No Lean cost follows by applying these prices to Lean terms.

## 6. Table construction, local reuse and byte/lifetime costs

The selected ordinary-PA tables use natural equations and natural digit terms only. They need proofs from the pinned PA arithmetic, or a checked on-demand producer. No peano_hex evaluator/coercion axiom or trusted product oracle is consumed. Digit-bound facts and power facts are separate unless a different explicitly priced bundle is adopted. The complete table catalogue is not necessarily materialized; either choice needs its own proved setup/import bill. We enumerate no digits here.

For a closed fact f requested v_f>=1 times in one theorem body, with its exact conclusion expression already retained, the matched uncached request schedule uses 2v_f proof commands and v_f header executions. ThmSave on its first application and proof Ref thereafter use v_f+1 commands and one header execution, adding one local heap entry. Thus the exact local reductions are

    Delta_I = sum_cached(v_f-1),
    Delta_U = sum_cached(v_f-1)*u_f.

This includes matching table or closed range facts; it excludes parameterized range/shift lemmas. Do not subtract these again when D0 and the premise edges in the preceding DAG formula already encode the cached schedule. No claim about actual fact frequencies is made.

Body bytes are the sum of actual instruction lengths, not U_apply or a multiple of arithmetic events. The pinned format uses 1/2/3/5-byte instructions. A repeated closed-fact replacement changes bytes by the old expression-Ref length plus theorem-ID length minus new proof-Ref length, with any ID-widening effects on other commands added separately. Headers have one stored representation but execute on each new theorem application. Table declarations, term construction, library bodies, source specification and final matching remain distinct.

Record constructed term arities and their actual allocation. The reviewed source-layout expression is sum_nodes(sizeof(store_expr)+4*arity), conditionally 16T+4C_terms for its stated layout, not an ABI measurement. ThmSave saves the tagged proven conclusion, not a second expression tree. A complete gate must fit the stock heap/store/stack and file-ID limits: heap65536 entries and expression store2^26 bytes, among other limits. There is no assumed within-proof reclamation. A full196608-fact byte catalogue cannot all be saved as local proof entries.

At a declaration reset, local word and proof identities do not survive. Count every block's actual source decoding or already-proved import, table re-instantiation, retained output state and joins. Global theorem reuse does not provide the former local pointer. The smallest useful implementation target is one fitting gate/block with this contract; splitting oversized gates requires a separately specified genuine theorem-state interface and its costs. This note proposes no streaming verifier change or new inference rule.

## 7. Source boundary and frozen dependencies

The pinned PA source supplies ordinary equality/congruence, distributivity, order and division: examples__peano.mm1 around901-922,2032-2153,2172-2415,2693-2712,3011-3037 and4999-5083. Direct reading confirms `eqdivmod`, `divmod`, `modlt`, and the actual b0/b1 definitions and zero identities. These support the paper proof, not an already implemented composite signed-round lemma. The actual verifier's Thm/ThmSave body at479-517 checks argument sorts/dependencies and runs the header on each application. Its Ref/URef/UTerm and declaration-reset behavior are those reviewed in the accounting packet.

Agent paths below are relative to work/qrh-campaign/agents. Hashes are checked on the frozen input bytes; no metadata writer is rerun.

| Artifact | SHA256 |
|---|---|
| moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md | E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6 |
| major-constants/REVIEW_MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md | 70A5D74BF6D4A5D6FF38B85B3D85F528D7E33E8E49329AF114DD1B4CED0F493C |
| prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md | EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD |
| prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md | 8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03 |
| prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md | 3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E |
| prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md | F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2 |
| prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md | 71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC |
| independent-feasibility/PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md | 67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59 |
| integration/PA_RADIX256_ADDER_LIFT_BASE_2026-11-11.md | B34EAE04F56C356894D87DF0FFD765D3403242A5E27257DF9078525D7A173C68 |
| audit/ORDINARY_BACKEND_ACCOUNTING_AND_LOCAL_REUSE_2026-11-11.md | 0E7920DAAD05D434AF6FBD6CBDE79963BE1210417066F734285D23BC18718A50 |
| moebius/REVIEW_ORDINARY_BACKEND_ACCOUNTING_AND_LOCAL_REUSE_2026-11-11.md | 8DE52F262ED5D0277E06C89757470C09513B0D078814BD1D1C78C027C483C29C |
| work/mm0-efficient/toolchain-sources/examples__peano.mm1 | 13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079 |
| work/formal-goldbach-bench/mm0/src/verifier.c | 71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5 |
| work/formal-goldbach-bench/mm0/src/verifier_types.c | 87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E |
| work/formal-goldbach-bench/mm0/src/types.c | B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1 |

The outstanding implementation obligations are finite and explicit: prove the selected composite schemas in ordinary PA; provide the exact byte/range table or decoder proofs; specify and check the signed/exponent/shift/final composition headers; construct the exact source-to-word and destination bindings; choose a legal local DAG/cache schedule and establish stock file/resource admission. The conditional formulas retain those costs. This note supplies neither a complete arithmetic-library implementation nor an end-to-end speed or proof-size claim.
