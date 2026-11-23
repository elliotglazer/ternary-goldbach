# A zero-carry specialization of the PA product-cell lift

2026-11-11. Bounded paper algebra and static syntax metadata. This develops the root-proposed specialization of the reviewed cell. It emits no PA/MM0/MM1/Lean declaration or proof, enumerates no digits, and assumes no arithmetic table has been built. Frozen predecessors remain unchanged.

The specialization is sound. Requiring the fourth closed table equation to have literal output carry zero removes the overflow variable and all four range premises from the local equality lift. Under the same explicit representation model, the lift has 14 expression arguments and five premises, a 134-command unshared header and 21/41-command cached/fresh calls. The old figures are 15/9, 182 and 26/46. Actual source digit/carry bounds, table completeness and row/output representation obligations remain. These local savings are not a complete multiplier or runtime saving.

## 1. Exact conditional implication

Keep beta as the same fixed PA natural term `b0` applied eight times to `d1`, mathematically 256. The fourteen natural expression arguments are

    X, x, y, A, a, c, u, v, e, w, f, d, k, B.

Keep the five premises in this exact shape:

    E1: x*y = beta*u+v
    E2: (v+a)+0 = beta*e+w
    E3: (w+c)+0 = beta*f+d
    E4zero: (u+e)+f = beta*0+k
    H: (X*y+A)+k = B.

The conclusion is unchanged:

    (((beta*X+x)*y)+(beta*A+a))+c = beta*B+d.       (1)

There is no z argument and no premise x<beta, y<beta, a<beta or c<beta. The zero in E4zero is the fixed natural zero term, not a variable accompanied by an unchecked claim that its value is zero. The explicit zeros in E2/E3 also remain. This is a paper statement of a reusable implication, not a new declaration.

Write t=(x*y+a)+c only as explanatory notation. Using the first three equations and ordinary natural associativity/distributivity gives

    t = beta*u+((v+a)+c)
      = beta*u+((beta*e+w)+c)
      = beta*(u+e)+(w+c)
      = beta*((u+e)+f)+d.

E4zero, `beta*0=0` and `0+k=k` therefore give t=beta*k+d. Expanding the outer expression and using H gives

    (((beta*X+x)*y)+(beta*A+a))+c
      = beta*(X*y+A)+t
      = beta*((X*y+A)+k)+d
      = beta*B+d.

This is a pure natural semiring equality argument. It needs neither order nor positivity of beta for the implication itself. It uses no subtraction, quotient computation or arithmetic oracle. The earlier counterexample exploiting z=1 cannot satisfy E4zero. Conversely the conclusion still exports only an equality. It supplies no digit bounds and does not assert that arbitrary natural witnesses belong to a byte table.

The immediate PA sources are the same as before: equality/congruence at `examples__peano.mm1:874,903–905,920–922,2034–2050`; zero and addition reassociation at 2057–2095; zero multiplication, distributivity and multiplication associativity at 2105–2153. The radix spelling is the existing natural `b0` definition at 3011. A formal proof body still needs to be written and checked against those interfaces. The algebra above is not a ring-normalization acceptance rule.

## 2. Why valid byte cells have a zero-carry fourth entry

Soundness of the conditional lift and completeness of constructing its premises are separate. For the existing source contract, retain x,y,a,c<beta and beta=256. Canonical table outputs for E1 give u,v<beta. Canonical full-adders for E2 and E3 give e,f in {0,1} and w,d<beta. Thus the fourth lookup's inputs u,e,f are in the declared full-adder domain: two byte inputs and one bit input. In particular e<beta uses beta>=2.

The generic byte bound is unchanged. Writing beta=b+1, each source input is at most b, so

    t <= b*b+b+b < (b+1)*(b+1) = beta*beta.

E1–E3 already give `t=beta*((u+e)+f)+d`. Since d is natural and beta>0, this forces `(u+e)+f<beta`. Otherwise its product with beta alone would be at least beta squared. Therefore the canonical full-adder decomposition of this last sum has output carry zero and low digit k=(u+e)+f<beta. A complete, proved full-adder table contains exactly the required E4zero fact for these valid source inputs.

This argument proves that the proposed specialization does not reject any valid source byte cell when the stipulated canonical tables are available. It is not evidence that those tables, their complete indexing or their ordinary PA proofs already exist. The bound can be established once in the generic library/completeness argument; it need not be replayed inside each equality lift. At a concrete acceptance site the exact closed equation must still be proved and bound to the actual terms. A native lookup, a hash, or a flag saying "zero overflow" is not that proof.

There is no hidden equation-to-range inference. The original E1–E4zero equalities alone, with arbitrary natural intermediate outputs, do not establish all canonical byte/bit bounds. Those remain source/table representation facts when required by the surrounding contract. The result also does not mean the most significant carry of a multiplication row is zero. Only the overflow of the fourth within-cell full-adder is zero. The cell's k and a row's terminal carry can be nonzero.

## 3. Closed-table representation and source identity

The baseline closed table format is still one equation per digit product and one equation per full-adder. It has beta squared product facts and twice beta squared full-adder facts, 196608 arithmetic facts at radix256, before bounds and library lemmas. E2/E3 can have carry one, so this specialization does not replace the full table by only zero-output entries. No reduction of global table construction or table cardinality is credited.

Keep every full-adder conclusion in the fixed source shape `(a+b)+carry=beta*outcarry+digit`. E4zero then requests an existing-format fact whose outcarry term is literally zero. If a producer simplifies that conclusion to `(u+e)+f=k`, it must prove and charge the conversion, or use a separately proved lift with a different header. Likewise numeral spellings of beta or zero must match the selected source representation. Semantic equality is not pointer identity in the MMB checker.

For closed PA facts there are no expression arguments or proof premises at the table theorem application. Their statement and proof still have to be present and checked. A parameterized table lookup theorem, indexed list membership proof or decoder is a different implementation and must pay its own arguments and premises. It cannot be counted as a newly applied closed fact of cost one. The earlier mandatory closed-fact clarification remains in force.

The inspected checker at `verifier.c:243–274` compares URef pointers and decomposes UTerm heads; at 479–515 it checks supplied argument types and runs the entire theorem header. A new zero-shaped header uses a nullary zero UTerm where the old header used the z-variable URef. This is still one header command, not proof that their machine costs are identical. Closed theorem signatures can persist globally; local numeral/proof pointers reset at theorem boundaries. Exact rebuilding, conversions, cache capacity and reload traffic remain charged. No new table-residency assumption is introduced.

## 4. Static local counts

The formal syntax checker constructs trees only. With beta temporarily atomic, the sizes of conclusion, E1, E2, E3, E4zero and H are

    21, 9, 11, 11, 11, 9.

Their sum is72 and they contain seven beta occurrences. Representing each beta by eight existing unary b0 heads and d1 adds56 nodes. The unshared expression header therefore has128 nodes. Five UHyp commands and one END give134 header commands.

The predecessor had four additional range trees, each eleven nodes after beta expansion, plus four UHyp commands. It therefore had48 more header commands. Replacing z by literal zero leaves the size of E4 unchanged. These are explicit unshared header stencils; a compiler using different sharing must be measured from its actual output.

|Local quantity|Old cell|Zero-carry cell|
|---|---:|---:|
|Natural expression arguments|15|14|
|Proof premises|9|5|
|Unshared header commands|182|134|
|Call with saved whole conclusion|26|21|
|Call with fresh unshared conclusion|46|41|
|Fresh conclusion binary term nodes|10|10|

The cached call uses a+h+2 commands. The fresh call uses fourteen argument references, five premise references, eleven saved leaf references, ten term constructions and one theorem application. Its ten binary-node allocations are unchanged, conditionally240 bytes under the inspected16-byte node-header layout. No compiled ABI or proof-stream byte size is asserted.

These counts exclude premise/operand production, the once-checked theorem body, exact source conversions and the enclosing proof boundary. Under the same local term/cache convention, each invocation removes one argument request and four premise references. It also executes the shorter header. This is a genuine reduction of repeated lift checking at the same source contract, even if range evidence is retained for other consumers. It does not by itself quantify the cost of producing that evidence or total accepted multiplication.

## 5. Compatibility with the row and base proposal

The new row/base paper `prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md`, hash71D3F4BF below, is a separate proposed library component under independent review. The zero-carry cell has exactly the old conclusion and the same higher-tail H. It therefore substitutes into its high-to-low inner proof without changing the row signatures. At the top, `((0*y+0)+c)=c` starts the supplied carry chain. At the bottom the incoming carry is literal zero and the chain supplies `(x*y+A)+0=beta*B+d`, exactly the row premise. Producer carry discovery may proceed low to high; proof replay remains acyclic in the opposite direction.

The intermediate outer state keeps its equality and A<x, low-prefix range and positive-place components. Its y<beta and d<beta premises remain. Input and carry digit bounds, exact decompositions, padding, prefix/place bindings and the final product-numeral binding do not disappear. The terminal row still concludes the original product equality, not an unrelated pair of numerals. The zero-operand and empty-representation branches remain separate from the positive nonempty path.

Conditional on those row signatures, m,n>=1 and the same connected first-use proof-DAG convention, the equality core becomes

    V = mn+2n+1+D,
    H_edges = 5mn+7n-2,
    R_requests = 15mn+15n+1+D,
    body commands including END = 20mn+22n+1+D+C.

Here D counts newly applied closed zero-argument, zero-premise facts only; C counts actual constructor-child requests. Other proof producers are external or added with their full signatures. The predecessor expression was `25mn+22n+1+D+C`. For13-by3 the new constant is847, versus1042. The difference of195 is5mn in the common core. It is not a claim that actual D, C or all external range/representation costs are equal or vanish. A complete comparison must retain their actual differences and all setup/body-checking costs.

Before the new row signatures were supplied, the older symbolic formula had constant984 with symbolic row/base terms. Its new cell substitution gives789 with those same symbolic terms still present. That789 is not the completed13-by3 core; substituting the current row roles gives847. The arithmetic-event convention stays five events per cell, so its13-by3 total202 is unchanged. Events, proof commands, header execution and machine time remain distinct units.

If concrete bounds used only by the old lift become dead proof nodes, an implementation may remove them only after checking that no table/row/representation consumer needs them. No such additional deletion is credited here. If bounds are generated by parameterized lemmas, their actual a+1 expression-root requests, premise edges and constructor requests are counted, not folded into D at unit price.

## 6. Evidence and remaining work

Owned script `zero-sum/pa_zero_carry_cell_syntax_20261111.py` has SHA256 `FDC53C8B9F2C5B83F94C7BFEE21121964C94D4F98772EAED9FE1C4A3B65C51FE`; its exclusive JSON receipt has SHA256 `F9261B505EA41C370FDE1665509875353CFC41154AD3DFA315CEC17B670ED9EE`. All24 checks pass. They verify formal polynomial identities, static signatures/counts and nine source pins. No variable is assigned a digit value; no concrete multiplication, table entry or proof is produced. The polynomial residual checks supplement the natural equality derivation above, not an executable arithmetic acceptance rule.

|Workspace-relative source|SHA256|
|---|---|
|work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md|3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E|
|work/qrh-campaign/agents/prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md|F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2|
|work/qrh-campaign/agents/moebius/REVIEW_PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md|DDA93BA814D78B2339E37C2588BC3DF8D0747BC5AF660BD51BAA9327569452EA|
|work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md|71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC|
|work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md|E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6|
|work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md|3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227|
|work/mm0-efficient/toolchain-sources/examples__peano.mm1|13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079|
|work/mm0-efficient/toolchain-sources/examples__peano.mm0|463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052|
|work/formal-goldbach-bench/mm0/src/verifier.c|71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5|

The bounded result is a sound, smaller conditional cell interface and a precise compatibility/count comparison. Adoption still requires independent review, formal library construction, ordinary PA table proofs, source/range/numeral producers, a legal concrete proof-stack/DAG implementation and its full cost. No native arithmetic rule, hex coercion axiom, successful table generation, stock-memory fit or end-to-end runtime improvement is assumed.
