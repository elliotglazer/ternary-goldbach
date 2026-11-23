# Review of padded named-digit source binding

2026-11-11. PASS at the stated paper, source and static-count scope. No correction requested. This is a compatible successor representation with explicit conversion obligations, not a free composition of the canonical-name and source-decoder packets. No arithmetic table, definition, proof stream or build was produced.

## Frozen evidence

The author is `work/qrh-campaign/agents/moebius/PADDED_NAMED_DIGIT_SOURCE_BINDING_2026-11-11.md`, SHA256 `5A42958919FC13814BBC07F1517E410E5A8BBA2F851888988D4B302A9433B3F7`. Its static script `padded_named_digit_binding_20261111.py` has SHA256 `7362F691F211F06474B4BCBA64A69CEEE46C9936E29F82BC75D0D1E9A5E2C11B`; its receipt has SHA256 `4016F05CE9C279C707C380DEDCDD10A3779BEF582F1BD4159EB1FF43BB017FA3`.

I read the complete frozen note and script, the canonical named-digit packet, the accepted product-numeral binding packet and its review, and the relevant actual PA and verifier source. An independent bounded static check verified the three author hashes, all seven input pins and all four radix rows against separately derived size/signature formulas: 87 checks passed. It did not import or execute the author script, enumerate digits, evaluate arithmetic instances or generate a new inventory. This review is the only new artifact from this task.

## Representation and the two exceptions

The source adapter's bit-order convention is correct. With the low bit at the outermost constructor, its digit term is exactly w b0/b1 heads on literal zero. For a nonzero digit other than one, making that entire term the body of D_d gives an exact definitional bridge. The body differs from the earlier shortest canonical body, so this requires new checked definitions and matched table/library objects rather than changing the interpretation of frozen IDs.

The zero and one patterns are b0^w(0) and b1(b0^(w-1)(0)). They do not reduce to the literal d0/d1 solely by the verifier's definitional conversion rule. In `examples__peano.mm1:3011–3025`, b0 and b1 have their ordinary natural definitions, and b00 and b10 are proved arithmetic equalities. The two proposed helpers follow from constructor congruence and those equalities. Their arguments, premises and conclusions are exactly sufficient.

Starting with reflexivity, w zero-helper applications prove the zero exception; w-1 zero-helper applications and one one-helper application prove the one exception. Each therefore uses w+1 theorem applications. Its H+R contribution is 2+3w, before term construction and the connected proof's END. The helper signature is 1 argument/1 premise, with header9, cached call4 and fresh-conclusion call7. These are fixed proved macro counts, not emitted command streams or free table facts.

For d>=2, reflexivity together with an explicit Conv/Cong/Unfold proof can establish P_d=D_d. The supplied body must be the actual declared P_d. For the two exceptions an ordinary equality proof is required instead. The distinction is necessary and correctly retained.

## The mixed glue closes the actual caller interface

The old affine induction still proves S=beta*T+d using the expanded beta and the actual padded digit body. From that equation, T=U and d=e, ordinary multiplication/addition congruence and transitivity prove S=beta*U+e. The fixed equality or definitional conversion beta=B then proves S=B*U+e. The PA congruence axioms and their derived forms occur at `examples__peano.mm1:2031–2053`; equality reflexivity/transitivity at901–905 supplies the other fixed steps. This introduces no arithmetic oracle.

The five arguments S,T,U,d,e and three premises are complete. The radix equality is a proved fixed library dependency, not a hidden fourth caller premise or an uncharged conversion on every use. Once that library theorem is checked, applications match its actual named-radix conclusion. The cell, row, concat and padded inner-base library must be specialized to the same B before this is a usable end-to-end interface.

The independently reconstructed header is w+24 commands. Cached/fresh calls are10/16, H+R=9 and the conclusion has six child requests. The old glue has H+R=7. Hence the conservative added H+R is two per decoded digit, giving4(m+n) for decoder lengths m,n,m+n. Keeping the old w8 caller upper bound and adding this amount is sound only with the separately charged bridge, catalogue, local sharing and library work, exactly as stated. The smaller fresh named conclusion is not also claimed as a complete saving.

The generalized source conversion application count (3w+2)L+8 follows by replacing the two bitwise source-normalization bounds by wL+2 each and the affine pass by (w+2)L+1, with the retained transitivity allowance. The author correctly does not reuse the old byte-specific622L+200 expression-request bound for wider radices without repricing its syntax.

The final public equality remains x_src*Y_src=Z_src. Carry retention, source length/grammar, zero-product handling, positivity and the three operand/output equality bindings remain required. The glue does not establish that arbitrary output digits are correct; that still comes from the table/cell arithmetic and the terminal row invariant.

## Exact objects and lifetime costs

The actual checker uses structural head matching in UTerm and saved expression identity in URef (`verifier.c:243–274`). Conv/Cong/Unfold at537–598 performs explicit conversion work. Thus neither a native digit code nor a separately allocated equal-looking tree automatically supplies the required premise object.

The retained-object schedule is sound as a construction discipline: create the padded body and its subtrees, make the affine steps use those exact subtree objects, and retain the bridge proof on the final P_d and named D_d. At every step the fixed constructor matching still checks the source bit pattern. Reusing a wrong body cannot pass merely because its external catalogue index was supplied. Constructing this shared graph and its references remains charged.

The uncached alternative really executes the closed bridge header at each application. The cached alternative pays for the distinct objects and proofs in each local lifetime, with no assumed ratio of distinct patterns to uses. Global theorem/definition IDs survive in a checked file; local pointers and proofs are reset between theorem contexts. Extra patterns needed by intermediate row digits or range proofs remain additional. This preserves the stock-admission limitations and prevents hash-only imports or free registry reuse.

## Setup counts and remaining costs

For beta-1 definitions of w+1 nodes each, N_pad=(beta-1)(w+1). Subtracting the canonical total gives2beta-2w-2. Each definition body/header stream has (beta-1)(w+2) commands. The two stated definition-byte subtotals follow by charging the same entry, return binder and statement-prefix model as the canonical packet. All four symbolic radix rows agree independently.

At w12 the results are53,235 body nodes,57,330 commands per stream, and294,840 or614,250 bytes under the two stated old-head width models. The complete bridge library adds4096 theorem entries,65,536 header commands and131,070 header bytes under the two-byte old-head/three-byte alias model. The literal zero/one targets account for the two-byte subtraction. Alignment and proof bodies are not included. The w16 three-byte alias window remains unavailable.

A bridge proves equality only. The padded bit-range induction and transport to D_d<B are still needed. Likewise a canonical-spelling arithmetic table is not automatically converted to the padded alias table. The stated w+1 normalization schedule per pattern is justified by a zero-prefix chain, the significant one step when present, and congruence through the remaining outer heads. Its ordinary proofs and all uses in table setup must be paid. Compact runtime table headers retain their10/12 shapes only after those actual arithmetic facts have been proved on the matched names.

The author's complete comparison therefore retains the right unresolved terms: the new fixed library, definition/bridge/range/table proofs, source-body and reference construction in each local lifetime, exact table/result spelling, storage and imports. The packet can remove a representation mismatch and repeated arithmetic normalization under a valid reuse schedule; it proves neither a universal cost saving nor full stock admission. The earlier canonical packet and numeral-binding packet remain unchanged.

Source hashes are the seven pins in the frozen author receipt, independently matched here. In particular the actual PA source is `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079` and verifier source is `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`. This is static source inspection, not a fresh verifier run, kernel validation, emitted proof or full axiom audit. The bounded review is complete.
