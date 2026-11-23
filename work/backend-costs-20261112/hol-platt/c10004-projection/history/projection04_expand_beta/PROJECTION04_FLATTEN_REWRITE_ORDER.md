# Preserve explicit quotient/remainder forms during flattening

Projection03 passed the line-40 equality but stopped at stage40: arithmetic simplification reordered the full-array index before the conditional flatten rule consumed the explicitly proved bounds and quotient/remainder equations. The surviving goal still contains the entire full-stage flatten, while the selected stage has already reduced.

The stage40 and stage60 proofs now use bool_ss for their final conditional rewrites. Their explicit ARITH_TAC prelude still proves all index bounds and division identities. Avoiding arithmetic reordering at the rewrite stage lets the rules consume the original expressions. All definitions, statements, hypotheses, dimensions and outputs are unchanged. The failed source and receipts are preserved under history/projection03_stage40_rewrite_order.

This is an attempted tactic repair, not an accepted result or a speed improvement.
