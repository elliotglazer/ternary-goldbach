# Preflight: the planned 929-node rational xi panel

2026-11-11. **PASS as a statement/input specification, subject to the explicit acceptance checks below.** No target mismatch or missing analytic error term was found. This is not acceptance of a new node, coefficient, disk, or executable checker. No numerical analytic evaluations, scalar-script rerun, Lean build, or author-file edits were performed.

## Exact inputs read and pinned

All paths below are relative to `work/qrh-campaign/agents`; hashes were checked locally.

| Input | SHA256 |
|---|---|
| `prime-estimates/NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md` | `92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957` |
| `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md` | `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99` |
| `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571` |
| `prime-estimates/REVIEW_PRINCIPAL_NODE_TO_CONTOUR_FRONTIER_2026-11-11.md` | `1ACF909F6EC6449D00441F468333193195AE4AF4F7D9DBACA71C228FA997F53C` |
| `prime-estimates/rational_panel_budget_20261111.py` | `7F6BBFA8DA690593121F287EB21BEADFA37D9C5EE6132744C5808687904AC013` |
| Its JSON | `B344780B1A7DD6D58C33BC73E9B49AD6FAB1AF70966123F70130977B756A59EF` |
| `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |

The previously accepted rectangle review was also read. It supplies the geometric and source-order adapter, not reusable numerical coefficients for this run.

## Target binding and parameter separation

The target is the actual **unhalved** source xi function:

`F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, `b=pi/4-1/33`.

The node input parameter is `T_input=32`, meaning `eta=1/(T_input+1)=1/33`. It must not be overwritten by `T_work=14`. The latter bounds only the imaginary part of the Taylor coefficient center `s0=3/5+14i` in the quadrature estimate. The accepted Fourier theorem permits an independently chosen fixed admissible b, strip width `a=1/66`, and kappa `1/66`. Thus the two T values are compatible.

The unit-circle Cauchy estimate uses an analytic integral majorant independent of imaginary height; it does not evaluate a numerical circle of heights 13 through 15. Therefore T_work=14 suffices for these center coefficients. It would not suffice to apply the same quadrature estimate directly at the top of that circle or at every point of the rectangle. The later disk assertion comes from the coefficient errors and analytic remainder, not from such direct evaluations.

Required immutable geometry is `rho=1/64`, `h=1/256`, `K=928`, `V=29/8`, degree 6, and

`R=[379/640,389/640]+i*[1791/128,1793/128]`.

Each coordinate displacement from s0 is at most 1/128; consequently squared distance is at most 1/8192, strictly below rho squared 1/4096. This is whole-rectangle containment.

## Acceptance checks for the new script

1. **Bind the mathematical target in every receipt and cache key.** Store exact rational s0, both T fields, eta, b's symbolic pi expression, a, kappa, h, K, degree and rho. Bind source/script versions and input identities. A receipt for the million-height tilt, a different node index, or a different precision/output center must not pass as this input. Approximate floating equality is insufficient.

2. **Complete the new node set.** Require precisely k=0,...,928, with exact `v_k=k/256`, and a full-kernel enclosure `|P(v_k+i*b)-p_k|<=e_k<=2^-24`. Enforce the radius after rounding p_k to the 2^-32 grid. Each enclosure includes seed, all elementary operations, the complete modular word, theta value/first/second derivative tails, and reconstruction. Earlier Arb coefficients, the old disk's observed sign, and the exact nodes at b=pi/4-1/1000001 are not certified inputs.

3. **Verify the generic modular path rather than reuse a fixed instance.** Every translation, reciprocal, root branch, theta type/phase permutation and jet transform needs its own valid operand domains. The four-S cap is a resource/acceptance rule, not permission to omit a step. Preserve unresolved nodes on failure. The sixteen-mode tail and its transport bound must apply to the actual terminal type and all retained jets. A tiny exponential may be enclosed by a proved nonzero-width interval; replacing it silently by zero is invalid.

4. **Transport negative nodes correctly.** For k>0 use `P(-v_k+i*b)=conj(P(v_k+i*b))`; hence center `conj(p_k)` and radius e_k. Do not simply copy p_k. Count k=0 once with full trapezoid weight. Its enclosing ball is not a declaration that P(ib)=0.

5. **Construct the signed, normalized weights.** For -928<=k<=928 and 0<=j<=6 the exact target is `w_(j,k)=h*v_k^j/j!*exp((1/10+14i)*v_k)`. The coefficient is `F_b^(j)(s0)/j!`, not the raw derivative. Divide by j! once; the Taylor polynomial then uses no further factorial. Odd powers remain signed. In particular negative weights are not positive weights or merely their conjugates: for v>0 they satisfy `w_(j,-k)=(-1)^j*exp(-v/5)*conj(w_(j,k))`. At k=0, w_0=h and w_j=0 for j>0.

6. **Verify weight errors after their own rounding.** Every weight center is on the 2^-64 grid with Euclidean error at most 2^-48. If orders are generated recursively, propagate the inherited error through multiplication by v/(j+1), then include fresh rounding. A box's coordinate radii are not automatically its Euclidean radius.

7. **Make center sums exact.** With those two actual dyadic grids, all 12,999 complex center products have denominator dividing 2^96; six known positive-degree zero-node products may be omitted. Exact signed integer addition then gives eta_j=0. If a center is left as an unrounded rational with a different denominator, the asserted fixed-denominator implementation must reject or explicitly handle it.

8. **Retain every analytic and arithmetic contribution.** Check q*exp(2V)>=2, not merely >=1. Use Q0,S0 for order zero and the stated Qj,Sj for positive normalized orders. Include node B_j, weight error and exact-sum status. The valid product split is `w(P-p)+(w-w_hat)p`; no extra direct-theta error is needed when e_k already encloses the full kernel. Conversely that does not remove quadrature or spatial-tail errors. Bind or replay the exact scalar planning certificate; copying displayed decimals without their rational upper-bound witnesses is insufficient.

9. **Check the whole-disk error with radius weights.** Form `E=sum E_j*rho^j+D*rho^7/(1-rho)` with outward rational bounds and require E<1/10. The specification's 0.091500568239 bound is a planning bound, not a substitute for failed node/weight tests. Large individual positive-order errors are permitted because their contributions carry rho^j.

10. **Use only the new polynomial for the sign decision.** Compute rational `U>=sum_(j=1)^6 |fhat_j|rho^j`; L1 coefficient norms suffice. Require `Re(fhat_0)-U>1/10`. Together with E<1/10 this proves strict positive real part everywhere in the closed disk. A failed comparison is inconclusive, even if the old Arb disk passed.

11. **Instantiate the actual closed rectangle and constant polygon.** Traverse bottom-left, bottom-right, top-right, top-left, bottom-left once counterclockwise. Use u=1 on all four closed panels and the exact surrogate image vertex 1 at all five joins. Shared strict half-plane membership is the required contract; no equality `F_b(z_i)=1` is asserted. The accepted crossing rule explicitly allows zero-length image edges, so all four crossings are zero. Include corners and the exact closure; do not rely on sampled images.

12. **Separate completed evidence from partial work.** Completion requires every node and weight, all exact sums/errors, the strict disk inequality and full geometric receipt. A time/precision/word cap or failed predicate records an incomplete result. Resume must reject mismatched or unverifiable prior records. A successful run would still need independent replay and source-to-checker review; exact integer execution is not itself a Lean proof.

## Closed count and remaining scope

Positive real part already proves nonvanishing throughout R. The constant polygon is also a valid instance of the reusable argument-principle route. The previous source adapter uses the entire F_b, a nonzero bottom-left anchor, auxiliary radius 33/16, and the required open-ball containment. Actual finite zero orders and boundary nonvanishing give the closed zero count. The exponential multiplier never vanishes, so the conclusion transfers to xiF; R lies wholly within 0<Re(s)<1, where the source nontrivial-zeta relation applies. No poles or real-axis exceptions occur in this rectangle.

This is one small fixed-b panel experiment. It supplies no high-height principal strip, conductor-family coverage, global QRH provider, or final Goldbach closure. The accepted source adapters remain paper-level obligations until formalized. No additional mathematical premise is authorized at either final root.
