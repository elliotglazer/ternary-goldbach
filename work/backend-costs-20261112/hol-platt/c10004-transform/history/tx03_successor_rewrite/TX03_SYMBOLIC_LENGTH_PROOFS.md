# Qualify composition and keep lengths symbolic

Tx02 parsed every transform definition and proved the cached-multiplication identity and emit length. It then failed because the ML proof referenced the unopened name o_DEF. The successor qualifies that existing theorem as combinTheory.o_DEF.

Three concrete outer length proofs now use arith_ss with explicit LENGTH_GENLIST and let rewrites. This applies the length identity without the general list simplifier's literal GENLIST expansion, which already caused avoidable work in the map build. Only proof tactics change. All program definitions, theorem statements, diagnostics and runner remain unchanged. The tx02 source and failure receipts remain under history/tx02_proof_namespace.

Successor source SHA256: `3bf0d99366177556ac7b1996487dc7f99ffe3a50d46a4ee50a334367e58f3288`.
