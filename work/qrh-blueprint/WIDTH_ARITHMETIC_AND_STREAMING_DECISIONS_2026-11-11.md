# Width, arithmetic and streaming decisions

2026-11-11. Coordinator reconciliation of three reviewed research results. This changes the cost-model baseline and implementation priorities, not the theorem status. No builds, numerical certificates or timings were produced.

## Decisions for the end-to-end model

1. Compare spectral algorithms at a stated common precision and peak-width allocation. The reviewed mixed-radix construction requires no additional fractional or integer bit relative to its specified conservative whole-axis baseline. This permits a fair operation comparison without guessing a compensating precision penalty. It does not establish a runtime ratio or beat a separately optimized baseline precision analysis.
2. Select complex multiplication by actual operand widths and reuse, rather than always choosing the cached three-product formula. The general Gauss formula can have a smaller ordinary-PA arithmetic subtotal despite more additions. Retain four-product arithmetic where its representation or rounding advantages justify it.
3. Price ordinary-MM0 proof assembly as one checked library plus the actual shard proofs and joins in a continuous run. Do not add a mandatory replay of every old proof per shard. Stock MM0 already reuses theorem statements. Bounded global memory and a wider streaming transport remain explicit implementation work.

## Precision and integer widths

The width author and independent review establish a conservative augmented magnitude bound K(c)(B+1), where B bounds stored input centers and K is computed from the exact selected circuit. If B bounds true values instead, include the input radius first. Both the cached nonunit Bluestein kernel and the unnormalized inverse FFT before division are included.

The exact peak recurrences are K=2n for radix-two/direct leaves, K=max(K_m,2m K_r) for a CT split n=rm with the m child first, and K=4P(n^2+n+1) for a Bluestein node with padded length P. The semantic output bound is used only between children, not substituted for an internal peak. The reviewed induction and independent metadata replay establish K_mixed<=K_old on all 13,943 axes and 149,999 conductor layouts. A reduced conductor family inherits this comparison.

For common grid 2^-p, B+1<=2^b and q=ceil(log2 K(c)), safe signed capacities are p+b+q+2 for stored centers and 2p+b+q+2 for exact schoolbook product/output temporaries. Three-product intermediates use 2p+b+q+5. The exact product bound exploits the circuit's operand norm products; it is not obtained by squaring the maximum stored value. These are value capacities, not prices for every rounding witness, root enclosure, parser term or proof object.

For a useful cost estimate, preserve separate operand widths P and Q at each gate. A unit coefficient and a large input usually need different integer parts. A product-output capacity alone does not specify either factor's multiplication cost.

## Arithmetic selection and remaining overhead

The complex/Karatsuba report is accepted only with its chunk-cost clarification. The minimum over product schedules compares unsigned arithmetic subtotals. Chunk initial/row/final proofs, extraction and the zero-factor case belong to an additional term; no displayed selected schedule uses that branch. Signed proofs, encoding, cache binding and rounding are additional for every method.

At byte radix and equal total operand widths, the independently reconstructed subtotals illustrate why one fixed choice is unjustified:

| Operand bits | Four-product | Cached fixed, runtime | Gauss |
|---:|---:|---:|---:|
|128|5386|4348|4377|
|256|18562|14855|14601|
|1024|190350|145796|144974|

All three receive their own available Karatsuba improvements. The fixed formula also pays coefficient setup: at128 bits it needs three uses to beat Gauss's subtotal; at256 and1024 bits its runtime subtotal already exceeds Gauss. These equal-width examples do not price the actual spectral workload.

Write each method's full cost as its subtotal plus its own excluded overhead. Choose a method only after including that overhead, or retain a portfolio where the current evidence does not distinguish them. The proof blueprint should expose both exact identities behind a common complex-gate correctness/error interface, so changing the arithmetic schedule does not alter the analytic theorem.

## Ordinary-MM0 theorem reuse and bounded state

The coordinator read the streaming author/review and the actual theorem completion, theorem application and conversion bodies of the pinned C verifier. A theorem application checks the retained schema and hypotheses; it does not rerun the original proof. Theorem boundaries reset proof-local scratch. Global declaration tables and the mapped container remain growing structures in the stock implementation.

A same-rule successor can retain the exact checked library and a small closed prefix theorem, prove the next prefix using ordinary joins, then discard obsolete facts and unreachable syntax. A ladder prefix must retain its needed boundary prime and interval facts. A list of every past witness is not a bounded interface. Live definitions and binder/dependency information remain necessary even when proof bodies are forgotten.

Commit only after complete theorem, hypothesis and conversion checks. In particular Conv/ConvCut can create provisional proof-tagged values guarded by pending conversion obligations; such a tag alone is not a proved export. Sorry/rejection taint cannot be erased by shard reset. External hashes or success receipts cannot install facts. Restarting without trusted checked state requires replay or an explicitly trusted persistence mechanism.

For a continuous run the cost is L+sum_i(V_i+J_i+I_i+G_i)+T_final: library, shard proof, join, representation, reclamation and final checking. Peak live state can be bounded by retained library plus the largest shard and surviving interface closure, under the specified export policy. Deleting history does not reduce proof bytes or ordinary arithmetic inference counts. Parallel checking without duplicate replay is a separate design now under research; it is not already supplied by stock mm0-c.

These implementation obligations are treated symmetrically with Lean's trusted kernel and environment implementation. No extra demand for a formally proved executable is imposed on MM0 alone. Neither side receives an unchecked arithmetic oracle.

## Evidence and next work

`reconcile_width_streaming_20261111.py` and its JSON receipt bind the seven author/review/clarification files and their source tables. The coordinator read each combined packet; hash reconciliation only confirms that identity and is not the mathematical review itself.

The next useful refinements are the actual operand-width distribution and proof-object overhead, the trusted parallel task protocol, and a sharper cutoff from existing SmallMuPhi checkpoints. The full analysis library/translation, actual spectral values and completeness, binary coverage, certified prime chain and their complete cost accounting remain open.

DRAFT_ANCHORS: 0 created; UNREGISTERED_SORRIES: 0 introduced; DRAFT_IMPORT_VIOLATIONS: 0 introduced; SEALED_THIS_TURN: 0.
