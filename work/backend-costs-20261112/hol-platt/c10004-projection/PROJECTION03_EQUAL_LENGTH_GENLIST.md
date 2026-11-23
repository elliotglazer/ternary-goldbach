# Use the explicit equal-length GENLIST equivalence

Projection02 passed the flatten lemma and first stage invariant, then failed in the first line-congruence proof. The pinned library's GENLIST_EQ is an alias of the general GENLIST_CONG theorem, whose antecedent includes a length equality as well as pointwise equality. The attempted immediate qx_gen_tac therefore did not match the generated goal shape.

Both line-congruence proofs now rewrite with GENLIST_FUN_EQ, the explicit equivalence between equality of two GENLISTs at the same length and bounded pointwise equality. This matches their actual common lengths 40 and 60. Only those two tactic steps change; all definitions, statements and bounds are unchanged. The failed source, receipts and saved proof state remain under history/projection02_genlist_congruence.

Successor source SHA256: `6bb5ed4b68c6db1a44a7e9f680d2695a39b2e7037852c4c7fce93a4354e5d324`.
