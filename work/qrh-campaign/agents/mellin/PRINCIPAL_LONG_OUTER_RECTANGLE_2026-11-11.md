# Principal long outer rectangle with a batched left edge

2026-11-11. Paper design only. No new values, transforms, scans, Lean declarations or builds. This specializes the already reviewed outer-boundary alternative in the family slab assembly; it does not introduce a new argument principle.

## Proposed certificate and available edges

Put b=629/1250=.5032, H=2000, T=1000000, and

`Q=[b,2]+i*[H,T]`.

One complete zero-winding certificate for the boundary of Q suffices to exclude zeros on all of closed Q. It need not certify horizontal crossbars at intermediate heights. The required CCW traversal is bottom left-to-right, right upward, top right-to-left, and left downward.

The numerical work already recorded for the two horizontal edges can be reused within its reviewed external scope:

* The six top models are the accepted `zero-sum/EM_TOP_HORIZONTAL_2026-11-11.md` packet, SHA `C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF`; its independent review SHA is `6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E`.
* The bottom can reuse the six whole-panel models from `work/qrh-blueprint/principal-chunk-2000/em_top_2000.json`, SHA `477BD15B17326BCE7333346491BA820C98DB2FE2B07DBDB7A0D11278CD2AE252`. Their independent review is `prime-estimates/REVIEW_TOP_COUNT_2000_2026-11-11.md`, SHA `C3CA2ABA8EDA4CE9158CB4BD22203DFBEEE0CEC145A54FC8F0D630346B3FC89D`. It verifies whole-panel positive real parts over [1/2,2], not just a total zero count.

At each height clip the first old panel [1/2,3/4] to [b,3/4]; the other five remain unchanged. The models approximate entire zetaF and include its errors before division by the full s-1 box. Their Taylor coefficients must not be interpreted as coefficients of zeta. New rational image vertices at the clipped endpoints must satisfy the old horizontal and new vertical half-planes together. An old endpoint at 1/2 is not the clipped endpoint b.

The entire right side has `Re zeta(2+it)>1/4` from the existing absolutely convergent Dirichlet-series bound. It can be one analytic panel, regardless of its length. Its endpoint surrogate vertices must have positive real part and agree exactly with the neighboring horizontal vertices.

What remains numerically is the left edge, its complete closed panel enclosures, compatible shared rational image vertices, and exact crossing evaluation for the complete outer polygon. None of those results follows from the accepted thin high slab or from either total count N(H), N(T).

## Reusing vertical batching without adding contours

The author-frozen [finite-EM batching note](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md) has SHA `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818`. Its section6 already distinguishes vertical panels from the horizontal crossbars required by a slab cover. The present choice removes those crossbars by choosing its alternative outer-contour protocol.

A purely geometric initial mesh of length 1/8 uses m=8(T-H)=7984000 panels. Its downward centers are

`b+i*(T-1/16-j/8)`, for `0<=j<m`.

Panel j covers `[T-(j+1)/8,T-j/8]` exactly. Its first and last endpoints are T and H. This is a mesh count, not a claim that those panels pass or that this is an efficient final mesh. A shorter or adaptive certified mesh is permissible.

Partition these centers into finite computational batches. Within each batch, use the frozen finite-EM grid formula with sigma=b, signed Delta=-1/8 and its actual first center. A shorter last batch uses its own J and transform length. Different batches may use different N,M,K and precision, provided every model is identified with the same actual zeta and all error bounds use its own height range. Batch boundaries are only subdivision points of the left side. They require a common rational image vertex and compatible adjacent panel half-planes, but no horizontal contour edge or zero count.

Every output needs the full batching ledger: residual exponential truncation, input moment uncertainty, normalized-DFT arithmetic, final contraction, B-phase recurrence, finite EM corrections, and coefficient assembly. Add weighted coefficient errors, the finite-entire-g Taylor tail, and the actual-point EM remainder before division by s-1. Scalar truncation estimates alone are not panel nonvanishing. Fixed precision cannot repair a source Taylor or EM truncation error larger than a panel's unknown margin.

The exact integer grid and coverage checker must reject gaps, duplicates with extra traversal, wrong orientation, omitted batch joins, and an incorrect final endpoint. Shared vertices are local to the two incident outer panels; there is no requirement to manufacture vertices at interior points of Q.

## Actual zeta, entire source theorem, and multiplicities

Use the same local-to-entire bridge as [HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md), SHA `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5`. The length of the rectangle changes none of its analytic steps.

Actual zeta is holomorphic near Q because the pole1 is outside it. Boundary half-planes give nonvanishing there, and the reviewed local polygon/log argument gives its logarithmic-derivative integral as `2*pi*i*k`. On the boundary,

`zetaF'/zetaF=zeta'/zeta+1/(s-1)`.

The integral of the last term is zero: principal log(s-1) is holomorphic on the upper half-plane containing Q, and sidewise FTC telescopes. Apply the global source `RectResidue.rectInt_logDeriv_mul:391` to entire zetaF, not to globally non-entire zeta.

Concrete source parameters are `c=2+501000*i`, R=1000000, h=1. The right-half-plane bound makes zetaF(c) nonzero. Every s in Q satisfies

`norm(s-c)<=499000+1871/1250<500000=R/2`.

Thus the existing enclosing-ball requirement holds. It is a source carrier choice, not a demand to evaluate the function on that large ball. Entire zetaF provides the analytic hypotheses there.

The resulting k is the sum of actual positive finite analytic orders at interior zeros. It is nonnegative, so k=0 excludes every interior zero without simplicity or RH assumptions. The boundary tests exclude the remaining points of closed Q. There is no cancellation between positive and negative multiplicities. A computed positive k must be reported as such, not inferred to be zero from the desired strip statement.

The known total counts N(H) and N(T) count zeros across the whole nontrivial strip, including the critical line outside Q. Their difference cannot replace this outer winding count. Similarly, a successful top horizontal path cannot fix the unknown continuous argument along the full left edge.

## Closed low-height join and exact scope

The independently reviewed 449-point sign chunk, joined to the lower certificate, establishes external finite RH and simplicity through inclusive height2000 under its reviewed analytic contracts. Its review SHA is `8EC2B71F288EFF6B2C4ABE01362E8A467C23D22BA1648B62EAABE89EC7F016E8`. This is already a stronger low-height result than needed for the narrow strip. Its kernel proof obligations remain open.

If the new outer certificate succeeds, every nontrivial zero with H<=gamma<=T has beta<b. Functional reflection and conjugation give beta>1-b=.4968 and the same conclusion for negative ordinates. Together with low RH for |gamma|<=H, this yields the requested closed strip [.4968,.5032] through inclusive height T. The stronger strict inequalities in the high range cause no gap at H because both statements include H. The low principal certificate supplies the real-axis coverage; a contour beginning at H alone would not do so.

Closed geometry includes top-height zeros in its exclusion region. When source multiplicity transport uses `WeilBridge.multRectD_eq_mult:87`, select both finite carrier heights strictly larger than T, as its hypotheses require. The rectangle's closed nonvanishing does not become an open-height statement merely because an auxiliary carrier has strict bounds.

This is the principal zeta target through one million only. It does not cover the higher conductor-one family cutoff, other characters, or the global7/8 provider.

## What the change saves, and what remains unknown

For m stacked height panels and six horizontal real blocks, a closed-slab protocol uses 6(m+1) distinct horizontal model blocks if seams are shared. The long-rectangle protocol uses 12, already available here. Both need the entire left edge. The analytic right side can be one panel for the outer contour instead of appearing in every local polygon. The outer initial polygon has m+13 edges before refinements. These are exact geometry comparisons, not runtime predictions.

For a computational batch with J centers and L the smallest power of two at least4J, the pinned explicit schedule charges NKp bin contributions, KpL log2(L)/2 butterflies, JK(p-1) contraction steps and per-center EM correction work. Sum these costs over actual batches, adding elementary input certificates, directed arithmetic, model construction and panel testing. Reinitializing a batch repeats its N input phases and bin work. No uniform N, precision, margin or successful J is assumed. Keeping one enormous batch is not required and its storage may be prohibitive.

The tradeoff is loss of incremental closed-region results: a complete local slab can stand on its own, whereas an unfinished outer boundary proves no exclusion for the large interior. One failed outer panel or nonzero final winding blocks the full conclusion. A zero exactly on beta=b would block this strict boundary protocol even though the requested non-strict strip allows it; localization or a different boundary strategy would then be needed. If the boundary is nonzero, continuity on its compact length gives some finite half-plane subdivision, but no known positive numerical margin or resource bound follows. The interior may still contain zeros, so boundary nonvanishing alone never proves k=0.

There is no new mathematical obstruction to the outer-rectangle route beyond these existing boundary and winding obligations. The saving is removal of internal crossbar computations and count joins. It does not solve high-height evaluation costs, left-edge conditioning, exact receipt production, or formal implementation.
