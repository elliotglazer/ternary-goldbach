# One bounded principal slab at the required million-height endpoint

2026-11-11. Research design only. No new zeta, xi, theta, node, coefficient, or contour value was evaluated. No build, source edit, production array or new final premise is proposed here. The scalar support below is exact arithmetic on analytic bounds, not evidence that the proposed contour will pass.

## Fixed target and actual function

Set T=1,000,000 and a=629/1250=.5032. The proposed single closed slab is

`R=[a,2]+i[T-1/8,T]`.

This is at the upper endpoint of the selected additional principal strip `[.4968,.5032]`. A successful zero-exclusion certificate covers only this final1/8-high right slab. Conjugation and functional reflection supply the corresponding local negative-height/left-side consequences with their source adapters. Nothing here covers the rest of2000<|gamma|<=10^6. Closed exclusion at Re=a is stronger than the selected weak strip, so a zero exactly on that line can obstruct this producer without refuting the selected strip statement.

Evaluate actual zeta, using the entire source function

`zetaF(s)=(s-1)zeta(s)` away from1, with removable value1 at1.

The exact source is `TernaryGoldbach/Explicit/ZetaGrowth.lean:17` (`zetaF`), line19 (`zetaF_of_ne`), and line30 (`differentiable_zetaF`), in pinned target23b2d68ca344203d4384e0aff7affa4ec034bef9. Every point of this slab has large positive imaginary part, so the quotient by s-1 is holomorphic and has no denominator zero there. No xi/Gamma normalization or HardyZ phase is numerically evaluated.

## Accepted evaluator inputs and safe reuse

The accepted top path is already at this exact T, not a low-height surrogate:

* `zero-sum/EM_TOP_HORIZONTAL_2026-11-11.md`, SHA256 `C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF`.
* `zero-sum/em_top_horizontal_20261111.py`, SHA256 `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10`.
* Its JSON, SHA256 `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26`.
* The full independent source/alternate-parameter review is `independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md`, SHA256 `6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E`. It checks all six blocks and the actual zetaF/quotient semantics, not just the count extracted afterward.

The stored six models have centers x=5/8,7/8,9/8,11/8,13/8,15/8 at height T. They contain degree23 zetaF coefficients, separate zetaF EM and Taylor errors, and zeta image/endpoint boxes. They cover[1/2,2]+iT. Clip the first top interval to[a,3/4]; its old full interval and disk bounds still apply. The recorded strict positive-real top images can be reused under their proved interval semantics.

Read the JSON as exact rational lower/upper endpoints. A new implementation must check their ordering and construct an enclosing interval whose output lower endpoint is no greater than the stored lower endpoint and whose upper endpoint is no smaller than the stored upper endpoint. Do this for every coefficient, endpoint and error input. Use upper-bound radius construction, including uncertainty in a rounded midpoint. Decimal parsing, midpoint-only conversion, or overlap is insufficient. Preserve the header N/M/K/R/T and all six exact centers. A digest authenticates the record; its accepted enclosure theorem supplies the meaning.

Do **not** import the old producer module: its top-level code eagerly evaluates all six long models. Reuse its reviewed formulas in a separately prepared driver, with the old coefficient receipt read-only. New rational image vertices must be shared by exact input-coordinate key; adjacent edges may not independently round different vertices under the same name.

## Seven new models and fourteen initial sides

Retain the accepted parameters:

`N=333334, B=N+1=333335, M=32, K=24, outer radius R0=1`.

K is the **Taylor length**, so retained degrees are0,...,23. The following are the only new long models:

1. Six bottom models with the same six real centers as the top, at ordinate T-1/8. Their model radius is1/8. The first actual bottom segment is[a,3/4]; the others are the original quarter-unit intervals through2.
2. One left model at `a+i(T-1/16)`, radius1/16, covering the complete left side.

The right side needs no new long model: absolute convergence gives `Re zeta(2+it)>=2-zeta(2)>1/4` throughout it, as in the accepted top-path proof. Its two shared rational image vertices must also lie in that same half-plane.

Thus the initial counterclockwise boundary consists of6 bottom segments,1 right side,6 top segments in reverse order, and1 left side downward:14 segments. The exact perimeter is

`2*((2-a)+1/8)=8109/2500`.

All corners and endpoints are included. Refine individual segments only by dyadic subdivision, keeping the same model center, coefficients, original disk and original uniform error. No new long model is created by subdivision. The right side uses its analytic half-plane, and every clipped top segment remains inside its accepted old model.

## Finite entire model and explicit analytic budget

Use precisely

`A(s)=sum_(n=1..N)n^(-s)+B^(-s)/2 + sum_(k=1..32) [B_(2k)/(2k)!](s)_(2k-1)B^(1-s-2k)`,

`g(s)=(s-1)A(s)+B^(1-s)`.

This finite g is entire. Its coefficients can be computed by the already reviewed finite series implementation, or by the independent exponential-coefficient recurrence. All coefficient rounding stays in interval balls. Actual zetaF differs from g on the tested boundary by the explicit EM remainder; no EM claim is needed on the larger outer disk used only for g.

The independent scalar support is `major-constants/HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md`, SHA256 `5176DAF690017CF8889BF14F22A882CF93B713B76D126983AAB7359BA8ECB060`; its exact check script has SHA256 `E4D3AC6451D16F8DBFC460112F63AA667DF4A85672D3A41D42458F6321E0E499`, receipt `3E23393B1DBD5EEFB186F8D0D6C624E71F12E3433B184A10EEBB218FA6E11E17`.

Every outer finite-g disk has real floor at least-1/2 and |s|<=T+3. Since sqrt(N),sqrt(B)<578 and A0=T+66<4B, the Fourier Bernoulli bound `|B_(2k)|/(2k)!<=4/6^(2k)` gives a correction sum below4/5. Consequently

`Mout < (T+4)*(N*578+578*(1/2+4/5))+B*578`

`=963343833694218/5 < 2^48`.

For actual boundary points only, Re(s)>=a>1/2 and |s|<=T+2. Hence

`E_EM,zetaF < 4*(T+3)*578/(127/2) * (A0/(6B))^64 < 2^(-38)`.

The scalar check verifies A0/(6B)<501/1000 and the last strict rational inequality. The left target disk extends left of1/2, but its *actual tested side* does not: use this EM estimate only on the side and its subsegments. The finite-g Taylor estimate, independently valid on its whole disk, is then added on those same points.

The degree23 Taylor tails are at most

`2^48*(1/8)^24/(1-1/8)=2^(-21)/7`

for a bottom model, and `2^(-44)/15` for the left model. These are zetaF errors. Divide by the full s-1 box, whose modulus is greater than2^19 on the whole slab. Even allowing sqrt(2)<3/2 for inserting an error disk as a coordinate square,

`(3/2)*(2^(-38)+2^(-21)/7)/2^19 < 2^(-42)`.

This is a uniform analytic quotient-error allowance, not a claim about all coefficient/import rounding or a lower bound for actual |zeta|. Those uncertainties remain in the complete image balls and must pass the final strict test. Begin a separately authorized attempt at192-bit arithmetic; its adequacy is checked, not assumed.

## Acceptance, source transport and failure

For each actual subsegment, evaluate the zetaF polynomial on the full real or imaginary offset interval, add its complete error square and divide by the full s-1 box. Require a strict signed-coordinate half-plane for this whole zeta enclosure and both globally shared rational endpoint vertices. An independently proved rational rotation can be allowed later, but is not needed in this fixed proposal. Use the accepted exact polygon-crossing rule, with shared vertices and no edge through0, and require total winding exactly0.

Do not apply a theorem requiring globally entire zeta: `RectResidue.rectInt_logDeriv_mul:391` requires global `Differentiable` for its function. Apply it to the actual entire zetaF instead. The needed bridge is

`wind(zetaF on boundary)=wind(zeta on boundary)+wind(s-1 on boundary)=wind(zeta on boundary)`.

The factor s-1 stays in the upper half-plane and has a single analytic principal logarithm there, so its winding/log-derivative integral is zero. This can be proved through local logarithms or the standard product-winding identity. It is an explicit proof obligation, not a claim that zeta is entire. For the source's carrier ball take `c=2+i(T-1/16), Rcarrier=4, h=1`. The right-edge estimate gives zetaF(c)!=0; the rectangle has distance at most`1871/1250+1/16<2=Rcarrier/2` from c. Thus the center-nonzero and strict carrier-containment premises have concrete proofs.

The independent source and geometry support is `mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md`, SHA256 `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5`. It makes the required local half-plane/logarithmic-integral bridge explicit before transfer to the globally entire source function.

Shared rational image vertices need not approximate the actual endpoint value: a rational point certified to belong to both adjacent strict half-planes suffices for the homotopy. For signed-coordinate half-planes with unit normals u and v, the candidate conjugate(u)+conjugate(v) is allowed only after checking both strict inequalities. If the normals are opposite, reject that pair; do not infer a join from interval overlap. The exact input-coordinate key still identifies one shared polygon vertex.

Boundary nonvanishing plus winding0 excludes all zeros of zetaF strictly inside with analytic multiplicity; boundary tests cover the remaining closed edges. Since s-1 is nonzero throughout, the same holds for actual zeta. No simplicity, RH, supplied zero list, fitted inverse, or assumed margin enters.

A future single attempt must stop after7 new model builds,256 total whole-panel tests, dyadic depth12, or180 seconds of numerical construction, whichever limit prevents completion. These are caps, not timing forecasts based on the old run. Reaching a cap, an import/domain failure, an unresolved half-plane, or nonzero winding is not a successful zero-exclusion certificate. Store exact partial geometry and reason; do not shift the left line, height, center or target to obtain a pass. Increasing precision or changing models would be a separately authorized attempt.

## Literal local work and production limits

The seven new long models contain2,333,338 initial Dirichlet terms in total, or56,000,112 contributions to24 coefficient positions. The literal source calls2,333,352 truncated-series exponentials when its two endpoint exponentials per model are included. There are224 Bernoulli-correction terms and168 newly stored complex Taylor coefficients. Initialize333334 real logarithms plus log(B) once. No extra long sum is needed for endpoints; use their model evaluations. The six reused models contribute144 old coefficient enclosures. If all top models are independently recomputed instead of reused, the full ancestor calculation has13 models,4,333,342 initial terms and312 coefficients.

These are a bounded local ledger, substantially smaller in object count than the draft all-height principal Fourier construction's625,000,626 nonnegative nodes atT=10^6. They are not comparable unit-cost operations or a runtime ratio: each truncated EM exponential produces24 coefficients, while the Fourier nodes involve different modular computations. The large Fourier table can also be shared across many centers; this slab does not establish a better full-height algorithm. Repeating an O(T)-length EM sum at O(T) centers would itself create quadratic total-height work without additional reuse.

Existing accepted EM/Taylor machinery therefore supports a meaningful bounded actual pilot at a required high endpoint. The genuinely unproved result is its strict whole-boundary margin and zero winding, not an evaluator formula or an extrapolated low-height budget. The product-winding/local-log adapter and safe old-box import must be included in its analytic/checker contract. This design does not assert that the pilot will pass and does not replace the still-missing full principal or nonprincipal spectral certificates.
