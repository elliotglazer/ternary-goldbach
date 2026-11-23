# Closed facts in the product-cell command formula

2026-11-11. Mandatory counting clarification to `PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md`, SHA256 `3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E`. The original remains unchanged. No proof emission, arithmetic instance or build was performed.

In section 4, the term D in

    984+D+C+3*(a_1+h_1)+3*(a_2+h_2)+(a_B+h_B)

counts newly applied CLOSED arithmetic table or byte-bound facts with zero expression arguments and zero proof premises. The phrase "any newly applied bound proofs" is too broad. A parameterized numeral-decomposition lemma, carry-bound lemma or another proof with arguments or premises is not a unit contribution to D.

For those alternatives use the full reviewed formula H+R+C+2. Add each additional theorem's expression-root requests a+1 and all of its premise edges to R and H, and add any new constructor-child requests to C. Shared proof dependencies and exact local terms must still obey the declared connected proof-DAG schedule. Cached bound proofs are external premise leaves, not newly applied D facts. If a modified interface exports or projects a bound, its actual nodes and signatures must be included.

The cell's 15 natural arguments, nine premises, algebraic proof, 182-command unshared header stencil and 26/46-command cached/fresh call counts are unchanged. This clarification does not assert that the required closed byte facts have been produced or checked. The five-event cell remains a conditional arithmetic core, with range establishment and complete row/base interfaces separately charged.
