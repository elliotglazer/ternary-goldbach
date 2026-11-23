# Source and coverage adapter for the proposed high zeta slab

2026-11-11. Bounded source/geometry review only. No new values or models were computed. The proposed region is

`Q=[629/1250,2]+i*[1000000-1/8,1000000]`.

The design is mathematically compatible with the existing source after one explicit local-to-entire winding adapter. Nothing here assumes that the seven new models, the shared-vertex tests or winding-zero comparison will succeed.

## Reused evidence and exact geometry

The accepted top evidence is:

- `zero-sum/EM_TOP_HORIZONTAL_2026-11-11.md`, SHA `C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF`;
- its producer `em_top_horizontal_20261111.py`, SHA `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10`;
- its receipt, SHA `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26`;
- [independent full-six-block review](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md), SHA `6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E`.

The six old horizontal models are centered at real parts `5/8,7/8,9/8,11/8,13/8,15/8`, each covering its quarter-unit closed horizontal block at height 1000000. They store degree-23 models and errors for **zetaF**, then divide the complete enclosure by the whole s-1 box to obtain actual zeta. They are not direct zeta Taylor coefficients.

Restrict the first top block from `[1/2,3/4]` to `[629/1250,3/4]`; the other five remain unchanged. Restriction preserves every old whole-block enclosure. The top traverses these blocks right-to-left in the rectangle's CCW orientation. The six proposed bottom models have the same real centers at height `1000000-1/8`, with the same clipping and left-to-right orientation. The left segment is centered at `629/1250+i*(1000000-1/16)` with half-length 1/16 and downward orientation. The right segment at Re=2 has upward orientation and the source-backed analytic `Re(zeta)>1/4` bound. This gives exactly fourteen initial boundary segments.

The clipped top-left endpoint is not an old stored endpoint at Re=1/2. Its true-value enclosure must be obtained by restricting/evaluating the accepted first model, and joined to the new left model's endpoint. All four corners and all internal joins need exactly shared rational image vertices lying in both incident whole-panel half-planes. Mere overlap of two endpoint boxes is not a shared-vertex certificate. The analytic right-edge bound removes the long-sum model there, but does not by itself choose vertices compatible with its top and bottom neighbors.

The accepted top nonvanishing can be reused on precisely this restricted top segment. Its total zero count N(1000000) is not a count for this thin slab and supplies no bottom or left-edge values.

## Actual function and the necessary winding adapter

[ZetaGrowth.lean:17](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaGrowth.lean:17) defines entire zetaF by updating `(s-1)*riemannZeta(s)` to 1 at s=1. `zetaF_of_ne` at line19 gives the exact product away from1; `differentiable_zetaF` at line30 proves entirety. Since every point in a neighborhood of Q has positive imaginary part,

`zeta(s)=zetaF(s)/(s-1)`

holds and is holomorphic there. Dividing a zetaF enclosure by the full s-1 interval is valid after its nonzero denominator is proved. Errors must be divided along with the polynomial; dividing only a center is insufficient.

Actual zeta is not globally entire. The existing [rectInt_logDeriv_mul:391](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/RectResidue.lean:391) requires global `Differentiable` for its counted function, so it must not be instantiated directly with zeta. The minimal paper adapter is:

1. Localize the reviewed polygon/log proof to a function holomorphic on a neighborhood of the boundary. Its FTC arguments use only local differentiability, closed-panel nonvanishing and shared image vertices; no global entire extension is needed. Thus the accepted zeta half-plane packet implies `integral_boundary zeta'/zeta =2*pi*i*k` for its exact crossing count k.
2. On that boundary, where zeta and s-1 are nonzero, differentiate the local product identity to obtain `zetaF'/zetaF=zeta'/zeta+1/(s-1)`.
3. The principal logarithm of s-1 is holomorphic throughout the upper half-plane. Its derivative is 1/(s-1). FTC on all oriented sides telescopes, so the extra closed integral is zero.
4. Hence the same integer k is the winding integral for entire zetaF. Apply the existing source rectangle argument principle to zetaF, with h=1, center `c=2+i*(1000000-1/16)` and radius R=4. The right-edge bound and c distinct from1 give zetaF(c) nonzero independently of any new model. For every s in Q, `norm(s-c)<=1871/1250+1/16=15593/10000<2=R/2`, so the source's strict half-radius inclusion holds.

If k=0, nonnegative actual analytic multiplicities exclude interior zeros of zetaF. The panel facts exclude boundary zeros, so Q is closed zero-free. The product identity transfers this conclusion to zeta. No xi or Gamma numerical normalization is necessary. The local polygon extension and this product-integral adapter remain proof obligations; they are not existing approved Lean declarations.

## EM domain and Taylor-domain distinction

The left panel lies entirely at Re=629/1250>1/2. Its enclosing target disk of radius1/16 crosses Re=1/2, but the actual EM remainder need only hold on the **actual panel points**. Separately, the finite pole-cancelled EM expression g is entire, so its outer-circle bound and Taylor remainder may use a larger disk extending further left. Do not apply the actual-zeta EM bound to that whole disk unless its real-part floor is separately established. Conversely, merely bounding g on the disk does not include the actual EM remainder on the panel; both errors must be added before division by s-1.

This is the same separation used in the accepted top models. It permits the proposed left model without requiring an EM theorem for actual zeta at the outer circle's negative real part.

## Endpoint and reflection scope

Successful closed-panel bounds and k=0 cover both heights `1000000-1/8` and `1000000`, all corners, and the entire intervening slab. They imply the absence of nontrivial zeros with beta>=.5032 in that positive-height band. Conjugation gives the negative band; functional reflection, with the actual nonzero factor in the nontrivial strip, gives the corresponding absence for beta<=.4968. Thus the narrow-strip consequence concerns only `1000000-1/8<=|gamma|<=1000000`, not all ordinates through one million.

No strict finite-carrier endpoint is silently identified with this closed bound. When transporting the result to `multRectD`/xi finite carriers, use an outer height strictly greater than 1000000; [WeilBridge.multRectD_eq_mult:87](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/WeilBridge.lean:87) has both strict ordinate inequalities. Closed zero exclusion itself needs no such carrier until a downstream consumer asks for it.

The fixed seven-new-model and 256-panel limits are experimental caps. Any unresolved half-plane, incompatible vertex, incomplete coverage or nonzero winding must remain a failure/incomplete result for this proposed exclusion, not be replaced by the accepted top count or a presumed spectral margin.
