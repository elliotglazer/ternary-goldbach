# Review of the zero-carry PA product cell

2026-11-11. PASS at conditional paper-algebra and static command-model scope, with no correction requested. This is not a checked PA theorem, completed byte table or full multiplication implementation. No digit enumeration, concrete product, declaration, proof emission or build was performed. Frozen author files are unchanged.

## Frozen inputs and inspection

The reviewed author is `zero-sum/PA_RADIX256_ZERO_CARRY_CELL_2026-11-11.md`, SHA256 `493812A2A73D0EF32FF8052F494EEFC91AFF15AF0ECC430B6379FB046B9E2DC5`. Its static script is `FDC53C8B9F2C5B83F94C7BFEE21121964C94D4F98772EAED9FE1C4A3B65C51FE`; its receipt is `F9261B505EA41C370FDE1665509875353CFC41154AD3DFA315CEC17B670ED9EE`. I read the full note and script without importing or executing the script. An independent read-only hash check matched these three artifacts and all nine source pins in the receipt.

I also read the predecessor cell, its mandatory closed-fact clarification and review, and the proposed row/base signatures. The source reads included `examples__peano.mm1:2034–2050,2057–2095,2119–2153` and `verifier.c:243–274,479–515`. Their hashes are respectively `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079` and `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`. The MM0 signature source remains `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`.

## Algebra and premise construction

For natural variables and the fixed radix beta, E1–E3 imply

    (x*y+a)+c = beta*((u+e)+f)+d.

The stronger fourth premise `(u+e)+f=beta*0+k` therefore gives `(x*y+a)+c=beta*k+d` using multiplication by zero and zero addition. The higher-tail premise `(X*y+A)+k=B`, distributivity and associativity then give exactly

    (((beta*X+x)*y)+(beta*A+a))+c = beta*B+d.

This proof needs no input order hypotheses and no positivity hypothesis on beta. It is a finite equality derivation using the pinned PA laws, not a new normalization instruction. Removing z and its four overflow-elimination premises from this implication is sound. Literal zero in E4 is essential; a free z with an unchecked zero flag would not suffice.

Completeness for valid source byte cells is a different claim and retains the original bounds. If x,y,a,c<beta and beta=b+1, then `(x*y+a)+c<=b*b+2b<beta^2`. Combining this with E1–E3 and d>=0 gives `u+e+f<beta`. The canonical final full-adder fact consequently has carry zero and k<beta. The preceding canonical tables also establish that u and e are byte inputs and f is a bit input. Thus a complete ordinary full-adder table supplies the requested zero-carry entry for every compatible valid source cell.

This does not say that all individually admissible fourth-adder inputs have zero overflow. The guarantee depends on compatibility with the earlier three equations and the original input ranges. The author correctly retains this dependence. Nor is the row's final high carry forced to zero: the specialization concerns only the fourth adder's overflow, and k can be nonzero.

The table remains 65536 product facts plus 131072 full-adder facts before range/library work. E2 and E3 can return carry one. No table-size saving or existing complete-table proof is asserted. The closed fact must retain the precise RHS `beta*0+k`; simplifying it to k needs a proved conversion or another lift signature.

## Source matching and exported ranges

The pinned checker compares references by their stored identity and decomposes actual term heads. The theorem invocation checks the expression argument sorts and runs its full unification header. A nullary zero head is a valid replacement for the old z-variable reference, but equal command counts do not imply equal machine costs.

The lift exports only the equality. Source digit/bit ranges, concrete numeral decompositions and carry bindings remain necessary wherever the table or row contract consumes them. In particular the intermediate outer row still needs its actual y<beta and d<beta proofs. A range established internally in a generic completeness proof is not automatically a second result of the equality-only lift. Cached closed range facts, parameterized range lemmas or a bundled interface each require their own actual proof and representation costs.

No native arithmetic, hash, hex coercion axiom or lookup success replaces an ordinary proof of a table equation. Alternative numeral spellings and independently rebuilt equal expressions also need the declared conversion/sharing discipline.

## Independently reconstructed counts and row composition

The argument list contains fourteen distinct natural variables. There are exactly five equations. The conclusion and premise syntax sizes with beta atomic are `21,9,11,11,11,9`, totaling 72. Seven occurrences of the nine-node fixed beta term add 56 nodes. Therefore the expression header has 128 nodes, and five UHyp commands plus END give 134 commands.

The predecessor's four range trees add 44 expanded expression nodes and four UHyp commands. The decrease is exactly 48 header commands. Replacing z by literal zero changes no E4 tree size. The saved-conclusion call is `14+5+2=21`; a fresh unshared 21-node conclusion gives `14+5+21+1=41`. The predecessor counts were 26 and 46. The conclusion still creates ten binary nodes under that stencil, so its conditional 240-byte allocation is unchanged. These are command counts, not proof-stream byte measurements or timings.

The proposed row/base source is `prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md`, SHA `71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC`. This review checks compatibility with those signatures; it does not independently approve their entire implementation. The new cell has the same conclusion and H premise as the predecessor, so the higher-to-lower proof replay, terminal inner base, literal zero bottom carry and final product binding do not change.

For m,n>=1 on the stipulated positive-operand path, the premise-edge subtotal is

    5mn + 7(n-1) + 4 + 1 = 5mn+7n-2.

The expression-root subtotal is

    15mn + 3n + 12(n-1) + 11 + 2 + D
      = 15mn+15n+1+D.

Hence the same connected first-use DAG model gives `20mn+22n+1+D+C`, compared with `25mn+22n+1+D+C`. For 13 by 3, the core constants are 847 and 1042, a difference of 195. The older symbolic-row constant 789 has a different scope and is not the completed 847. The five-event cell convention and the 202-event 13-by-3 template remain unchanged.

D counts newly applied closed zero-argument, zero-premise facts only. Parameterized source/range/binding producers contribute their full signatures and new terms. C and the external producers need not be identical between implementations. The five-command decrease per matched lift invocation and shorter header are valid local savings; no total multiplier or runtime saving follows without those remaining costs.

A stronger matched observation is available under an explicit representation condition. Suppose both implementations use the same canonical closed E1–E4 facts, the same source/range producers and the same saved numeral and conclusion objects. Suppose the old E4 already instantiates z with the literal zero object used by the new header. Then the new lift consumes precisely the same five equation proofs and conclusion, drops one expression-argument request and four range-proof references, and executes the 134-command rather than 182-command header. No new table/source conversion or conclusion construction is required. One may retain and charge all the old source/range production work unchanged, without claiming any dead-proof deletion. This gives a local improvement in that matched call model, rather than merely a comparison of unrelated subtotals. If a removed range producer has no other consumer, its legal retention or removal must still respect the chosen whole-proof DAG schedule; the per-call observation does not establish equal global D/C automatically. Semantic equality z=0 alone is insufficient: a different zero spelling needs its actual conversion or a changed header, whose cost must be added.

The specialization is therefore suitable for a later ordinary-rule implementation. Generic library proof bodies, complete table proofs/indexing, numeral/range producers, row/base implementation, actual stack/DAG scheduling and memory/byte costs remain explicit obligations.
