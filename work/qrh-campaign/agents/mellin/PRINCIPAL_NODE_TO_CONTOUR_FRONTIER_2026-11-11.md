# From exact principal kernel nodes to a complete contour

2026-11-11. Research frontier only. No new node, scan, Lean command, source edit or frozen-file edit was made. The two new node results remove numerical-oracle dependence at two particular inputs. They do not establish a high-height Fourier packet or show that a proposed contour is zero-free.

The ordered route below uses the already reviewed Fourier/Taylor and polygon arguments. It separates missing proof interfaces, absent finite data, and the still-unproved spectral assertion. None of its intermediate contracts is an allowed new hypothesis at the final Goldbach theorem.

## 1. Fix the intended contour before choosing an evaluator budget

There are two distinct principal obligations in the selected strategy:

| Required result | A sufficient direct-exclusion region above the accepted head |
|---|---|
| Zeta zeros satisfy the closed strip `[.4968,.5032]` for `1500<|Im(s)|<=10^6` | Prove no zero on the closed rectangle `[.5032,2]+i*[2000,10^6]`, then use conjugation and reflection, together with accepted RH through closed 2000. This proves a slightly stronger strict upper inequality in the remaining range. |
| Conductor-one part of the shared family satisfies `Re(s)<=.555` through inclusive height 60,343,058 | Prove no zero on `[.555,2]+i*[2000,60343058]`, with the same head and symmetry joins. This is separate from the narrow one-million assertion. |

These are sufficient certificate designs, not assertions that either rectangle has been certified. A boundary zero on Re(s)=.5032 or .555 is compatible with the desired non-strict target but obstructs this stronger design. Such a case needs localization or an exact boundary treatment; increasing precision does not eliminate it. The rectangle may instead be split into a finite closed stack, provided every seam is included and its zero handling is explicit.

The existing source function is the unhalved [xiF, Xi.lean:18](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/Xi.lean:18). Its entirety, reflection, and outer-half-plane nonvanishing are at lines 20, 24, 42 and 51. [xiF_eq_zero_iff:56](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/Xi.lean:56) transfers zero locations only when `0<Re(s)<1`; it is not an already packaged multiplicity-transfer theorem.

The accepted exact count `N(10^6)=1747146` does not locate those zeros. Its top-edge nonvanishing evidence also does not automatically supply the image vertices or argument increments of a different normalized function on the new rectangle. It may supply a boundary-nonvanishing fact after exact function transport, but a compatible winding computation remains necessary.

## 2. What is already available, with its exact scope

- The [r=0 node review](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/mellin/REVIEW_PRINCIPAL_ONE_NODE_BOUND_2026-11-11.md), SHA `6ABD86362059F5BFED71A5DA72D59DC6774ED2B338E9E9189899E79C425254B9`, proves `|P(i*b)|<=2^-408`, where **b=pi/4-1/1000001**.
- The [r=1/8 node review](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/mellin/REVIEW_R1OVER8_P_NODE_EXACT_2026-11-11.md), SHA `3F6684C81A95E2ACC9A4BA7EEDC449E0D4D95F0375ABE5AE0A01346AB894C09A`, certifies the actual nonzero P value at `1/8+i*b` within `2^-128` of its exact stored center. Its independent rational replay covers the new seed, accepted five-inversion word, elementary series, all theta tails and transport.
- The [Fourier evaluator](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md), SHA `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, and [node-substitution plan](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md), SHA `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571`, supply reviewed paper identities and explicit errors, not compiled Lean interfaces. The substitution review is SHA `FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD`.
- The [modular-node xi disk pilot](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/prime-estimates/PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md), SHA `85EDD45B5DEB8E96AEC957AA956E90AEBEC4B9B0C9BE31C7D06FA52DAE6E2D49`, covers one disk centered at `3/5+14i`, using **b=pi/4-1/33** and 2049 nonnegative kernel nodes. Its elementary evaluations still use external Arb. The later [rectangle adapter](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/mellin/PRINCIPAL_MODULAR_RECTANGLE_ADAPTER_2026-11-11.md) gives a reviewed rational winding-zero consequence for a tiny rectangle inside that disk.

The two exact T=10^6 nodes cannot replace the low pilot's nodes: their b differs. They also cannot be reused unchanged at the conductor-one height if that calculation chooses b=pi/4-1/60343059. No continuity-in-b error has been supplied to justify either substitution.

## 3. First gate: a complete finite kernel-node manifest

Choose one exact b per complete contour, or per separately counted rectangle. For work height T>=1 the reviewed choice is

`eta=1/(T+1), b=pi/4-eta, a=eta/2, kappa=eta/2`,

where a is the quadrature strip width, renamed here to avoid confusing it with the real kernel node. Require `|b|+a<pi/4` and `0<kappa<=cos(2(|b|+a))`. Fix rational h>0, K a natural, V=Kh, and exact nodes v_k=kh.

For **every** k=0,...,K, produce a rational complex center p_k and rational e_k>=0 proving

`|P(v_k+i*b)-p_k|<=e_k`.

The manifest must bind the exact b, T, h, integer k, seed, modular word and tail/rounding ledger. The two accepted nodes fit only if their exact inputs occur in that manifest. `r=1/8` lies on a suitable dyadic grid, but this must be checked, not rounded to a nearby node.

For each new node, the available paper route is: enclose the exact seed `exp(2v_k)*(-cos(2eta)+i*sin(2eta))`; verify all word operands/branches; select the correct terminal theta type; enclose its complete jet including tail; and unwind all local factors to P. The general modular reduction/termination and series bounds are reviewed. The current rational programs remain fixed instances: fixed precisions, Taylor lengths, word lists and range caps do not prove a parameterized evaluator correct or sufficient at every grid point. Extending them requires a sound, refining elementary/graph checker and actual per-node records. It does not require a new conjectural estimate.

Only finite pointwise P inequalities are needed here, not a uniform-in-v interval evaluator. Uniformity over the later continuum comes from the analytic Fourier/Taylor bounds. For negative k, prove/use both identities `P(-v+i*b)=P(v-i*b)=conj(P(v+i*b))`, transporting the entire enclosure. The zero node occurs once at full weight; its small enclosure is not an exact zero.

## 4. Second gate: certified coefficients with a uniform error allocation

Define the rational constants from the reviewed envelope:

`C=3kappa, q=C/2, z0=3C/2, A=(2048/C^2+96/C)*(1+z0)/z0, M=A/q, D=A*(1/q+1/q^2)`.

For a center s0=sigma+i*t with `.4968<=sigma<=2` and `|t|<=T`, let

`f_j=F_b^(j)(s0)/j!, F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`.

The finite coefficient weight is `w_(j,k)=h*v_k^j/j!*exp((s0-1/2)*v_k)`. A complete record must supply weight centers and norm errors d_(j,k), exact or rounded finite summation with certified eta_j, and the bound

`E_j=Q_j+S_j+B_j+sum_k d_(j,k)|p_k|+eta_j`,

where, with R=exp(2V) and Den=exp(2*pi*a/h)-1,

`Q_0=2M exp(Ta)/Den`, `Q_j=2D exp((T+1)a)/Den` for j>=1;

`S_0=M exp(-qR)`, `S_j=A exp(-qR)*(R/q+1/q^2)` for j>=1;

`B_j=h sum_k e_k*|v_k|^j/j!*exp((sigma-1/2)*v_k)`.

Require **qR>=2** when any positive derivative is used; threshold 1 alone only suffices for the undifferentiated discrete tail. All analytic inequalities must be enclosed by the same rational elementary machinery; printing the formulas is not a certificate of their numerical values. No unreduced Gaussian tail is added again when e_k already bounds the full P value.

A concrete conservative allocation is available: if epsilon_B is assigned to node error for every retained j, it suffices to prove

`e_k <= epsilon_B/[h*(2K+1)*exp(5V/2)]` for all k.

This follows from `|v|^j/j!<=exp(|v|)` and `|sigma-1/2|<=3/2`. It shows why an isolated `2^-128` node radius cannot automatically be declared sufficient for a future contour. The required node accuracy depends on h,K,V and the contour error allocation. Sharper weighted, nonuniform e_k are permitted by B_j.

The decomposition `w(P-p)+(w-w_hat)p` accounts for correlated inputs without a missing mixed term. Signed powers of negative v are retained in coefficient centers; factorial normalization occurs once. Exact rational center sums can set eta_j=0. Optional FFT batching must instead charge its full arithmetic error with the correct scale: h*L for a normalized positive DFT, h for an unnormalized positive DFT. No FFT is needed for mathematical completeness. Its exact ordinate lattice involves pi; arbitrary rational panel centers cannot be silently identified with rounded FFT outputs. Certified off-grid interpolation or direct coefficients are required.

## 5. Third gate: whole panels, shared vertices and winding

For a degree-d coefficient packet and `|z|<=rho<1`, the reviewed bound is

`|F_b(s0+z)-sum_(j=0)^d fhat_j*z^j| <= sum_(j=0)^d E_j*rho^j + D*rho^(d+1)/(1-rho)`.

D bounds the entire function on the unit disk around s0; no numerical sampling of that outer circle is needed. If another algorithm does sample an outer circle, its work height must cover those sample points. Each affine panel must be contained in its claimed Taylor disk, including both endpoints. Enclose the polynomial on the entire parameter interval and include polynomial-evaluation error if it is not exact.

To use the reviewed [polygon contract](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md), choose a rotation u in `{1,-1,i,-i}` and prove `Re(u*F_b)>0` throughout each closed panel. Merely excluding zero in a midpoint ball does not establish this. A sufficient check is a strictly positive lower bound for the real part of the polynomial image minus the complete remainder.

Choose exactly shared rational surrogate image vertices at every join, each lying in both neighboring strict half-planes. They need not equal true endpoint images, and degenerate surrogate edges are allowed. Verify the complete CCW input-side partition, closure, and every half-plane membership. Then compute the signed rational crossing sum with the prescribed half-open endpoint convention. A count of zero, not just boundary nonvanishing, is needed to exclude the rectangle's interior.

Keep the same b for all panels in one polygon. Separate rectangles may use separate b values, because each count separately transfers to xiF. Their raw normalized image edges must not be cancelled against each other without a normalization proof. For a closed stack, check exact seam coverage and zero handling before adding counts. These are finite geometry/identity obligations, not analytic error terms.

## 6. Fourth gate: actual zero carriers and closed endpoints

[RectResidue.rectInt_logDeriv_mul:391](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/RectResidue.lean:391) is the existing argument-principle target. Supply entirety, a nonzero anchor, the auxiliary ball containing the closed rectangle, and [NoZerosOnSides:360](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/RectResidue.lean:360). The reviewed polygon proof then identifies its integral with the exact integer crossing count. Nonnegative actual analytic orders turn count zero into absence of all interior zeros; the panel facts exclude boundary zeros.

The entire nonzero multiplier between F_b and xiF preserves zero orders. Within `0<Re(s)<1`, use the local nonzero factor relating xiF and zeta to transfer orders, not only the source zero-location iff. Reflection and conjugation preserve the relevant carrier and multiplicities. For a closed cutoff H used inside a strict finite divisor carrier, choose an outer carrier height T'>H; [WeilBridge.multRectD_eq_mult:87](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/WeilBridge.lean:87) requires strict height containment. An evaluator work bound T and a divisor-carrier height T' play different roles.

The source-level polygon/order adapters have reviewed paper proofs but are not yet a composed Lean theorem. The finite principal contour itself does not require the global 7/8 provider; that provider remains a separate downstream input when the finite strip is joined to all-height analytic tails.

## 7. What the next bounded packet should contain

The next useful milestone is **one fully rational coefficient-to-panel packet at fixed b**, with its finite node manifest, signed weights, exact center sums, certified Q/S/B/weight errors, Taylor remainder, shared endpoint rule and strict half-plane comparison. It should be chosen and budgeted before producing new nodes; success must not be assumed. This tests the missing end-to-end composition and serialization, rather than generating another isolated P value. The existing low-height Arb disk is a model for the mathematics, not a rational replay of its entire 2049-node input.

After that packet is independently reviewed, extending a known correct finite checker to all required nodes/panels is a volume-of-computation task **only conditional on** the necessary strict comparisons actually succeeding. The current fixed examples supply neither a uniform spectral margin nor a guarantee that any selected contour avoids zeros. A failed margin may call for refinement, a different certified decomposition, or explicit boundary analysis; an actual positive zero count contradicts that proposed exclusion region.

The reviewed convergence formulas give finite per-request accuracy in principle. They are not a throughput or feasibility bound for the full height. For example, the conservative quadrature choice h<=6a/J forces K>=VJ/(6a) once V is chosen; at small a this can create a large manifest. Adaptive words and FFTs change implementation cost, not the required errors, exact coverage or winding evidence. No full-principal completeness claim is justified until the complete selected cover and its counts pass, and no Lean closure claim is justified until the exact finite records and analytic adapters are kernel-checked.
