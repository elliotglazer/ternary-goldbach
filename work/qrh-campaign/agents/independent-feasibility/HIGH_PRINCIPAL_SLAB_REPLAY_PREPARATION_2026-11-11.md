# Independent high-slab replay preparation

Status: **code and review design prepared; no new numerical function, coefficient model, panel image or endpoint value evaluated.** Only syntax/static checks are performed. A future run requires a fresh coordinator manifest after the analytic design and producer are independently reviewed and frozen.

The owned implementation is `review_high_principal_slab_prepared_20261111.py`. Its syntax receipt records the exact code hash. It imports no producer module and never imports the old top producer, whose module body eagerly evaluates six models.

## Exact target and model budget

The only target is the closed slab

`[629/1250,2]+i*[1000000-1/8,1000000]`.

The evaluated function is actual zeta, obtained from an enclosure of the source entire zetaF=(s-1)zeta by dividing the complete error-expanded polynomial by the full s-1 box. No xi, Gamma, Hardy phase or Riemann-Siegel evaluator is used.

The producer design is pinned at `moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md`, SHA256 `5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8`. It proposes seven new models and reuse of six old top models. The scalar support is `major-constants/HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md`, SHA256 `5176DAF690017CF8889BF14F22A882CF93B713B76D126983AAB7359BA8ECB060`. That support is for the producer parameters; it is not silently used for different independent parameters.

The old independent top receipt retains whole-block images and endpoint balls but **does not retain its coefficient jets**. It cannot evaluate arbitrary clipped/subdivided top panels. Accordingly this independent attempt budgets **13 fresh models**, not seven: six at height T, six at T-1/8, and one at 629/1250+i*(T-1/16). The six horizontal real centers are 5/8,7/8,...,15/8. All old files remain immutable. The accepted top count is neither a bottom/left value nor a zero count for this slab.

Independent parameters are N=300001, B=N+1, M=36, Taylor length K=26, outer radius 3/4, and 160-bit interval arithmetic. Horizontal target radii are 1/8; the left radius is 1/16. The producer uses N=333334,M=32,K=24,R=1 and 192 bits for its new models, with the old top coefficients imported outward. A length is the number of retained coefficients, so the independent polynomial has degree 25.

All 300001 positive integer logarithms and log(B) are initialized once. Each long model uses scalar exp(-s0 log n), then explicit coefficient recurrence a_j=a_(j-1)*(-log n)/j. It does not use the producer's power-series exponential operation. Bernoulli numbers are recomputed by an exact rational recurrence. The final pole-cancelled term is independently assembled as B times the B^(-s) series. The finite polynomial, coefficients and separate error bounds are saved for every completed model.

Caps are 13 models, at most 256 consumed panels, depth at most 12, 300 seconds of numerical work, and 512 MiB measured peak working set. These are operational rejection limits, not timing forecasts. A new progress file retains completed models and panels; a failure or exhausted cap produces only an incomplete result. There is no automatic precision retry, added model or shifted domain.

## Independent error proof used by the prepared code

Write z=s0 and let h be the model's target radius. The finite entire function is

`g(s)=(s-1)*(sum_(n=1)^N n^-s + B^-s/2 + B^-s*sum_(k=1)^M B_(2k)/(2k)!*(s)_(2k-1)*B^(1-2k)) + B*B^-s`.

Its finite correction lengths are 1,3,...,71. The omitted EM remainder has rising-factorial length 72. The script computes a new outer bound, not the producer's 2^48 constant: with S=|z|+3/4 and sigma_out=Re(z)-3/4, bound each main term by max(1,N^(-sigma_out)), the B terms by B^(-sigma_out), and each correction product by product_(j=0)^(2k-2)(S+j). Multiply by S+1 for s-1 and add B*B^(-sigma_out). This gives a valid finite-g bound even on negative real parts of the outer circle.

At actual tested panel points, Re(s)>=629/1250>1/2. Put S_h=|z|+h. The independent actual-zetaF EM error is bounded by

`4*(S_h+1)*product_(j=0)^71(S_h+j)*B^(1/2-72)/(6^72*(72-1/2))`.

This follows from the accepted explicit EM remainder with actual real-part floor 1/2 and |s-1|<=S_h+1. The floor is not asserted on the entire left target disk, which crosses Re(s)=1/2. The code checks every actual panel's coordinates before applying the bound. The separate finite-g Taylor remainder is

`M_outer*(h/(3/4))^26/(1-h/(3/4))`.

Both errors are inserted as a complex coordinate square before dividing by the full nonzero s-1 box. Coefficient errors, Horner arithmetic and division rounding remain in the interval evaluation. Thus no standalone 2^-42 allowance is incorrectly substituted for a total image radius. The actual generated bounds and strict half-plane margins remain uncomputed at this stage.

Elementary real log/exp, complex exp, interval arithmetic and finite series multiplication are provided by the already installed FLINT interface, as in the accepted top replay. No built-in zeta, Hurwitz, theta, Gamma, RS, indexed-zero or zero-count call is present. This future computation would be external interval evidence, not exact rational elementary replay or a Lean proof.

## Full candidate consumption

The prepared adapter follows the current producer schema: models `top_0` through `top_5`, `bottom_0` through `bottom_5`, and `left`; oriented `accepted_panels`; signed-coordinate rotations `1,-1,i,-i`; and an exact rational polygon. The producer source and receipt hashes are required in a future authorization manifest. A schema change requires inspection before authorization; it is not accepted by a permissive fallback.

Before any model computation, exact rational checks require all 13 model labels and centers, the fixed original header, a complete CCW cycle starting at the bottom-left corner, exact consecutive endpoints, all four full side lengths, and no pending boundary. Each consumed panel must be a dyadic child of its declared initial segment at depth at most 12. This includes clipping the first horizontal block at 629/1250. Arbitrary missing, repeated, diagonal, out-of-slab or wrong-model domains reject.

Each numerical panel is evaluated in its entirety with its independent model, including all accepted top panels. No subset sampling or endpoint-only test is used. The exact candidate rotation must yield a strictly positive coordinate lower bound for the independent full image. Every numerical incident endpoint is also evaluated with its incident model. The right edge is handled separately by the accepted analytic Re(zeta(2+it))>1/4 theorem; its permitted rotation is therefore `1`.

The exact polygon vertices need not equal point-value approximations. They must be shared literally between adjacent panels and lie strictly in both adjacent certified half-planes. The code checks this, rejects edges through zero, applies the exact half-open positive-ray crossing rule, compares every crossing with the stored list, and requires winding zero. Endpoint-box overlap is not used to construct or validate shared vertices.

This route independently certifies the consumed whole-panel half-plane claims and exact geometry. It does not claim bitwise agreement with producer coefficients or every diagnostic intermediate. Failed attempts and unused metadata cannot provide analytic premises. A stricter producer margin may differ from the independent lower bound; the required common statement is strict positivity in the recorded half-plane.

## Source transport and final gate

Actual zeta is holomorphic near this slab but not globally entire. The local polygon/log theorem must be combined with zetaF=(s-1)zeta and winding(s-1)=0 in the upper half-plane before invoking a source theorem requiring a globally differentiable function. The entire counted function is zetaF. Boundary nonvanishing plus winding zero gives closed-slab exclusion after the existing argument-principle/multiplicity adapter; no simplicity or RH premise is allowed.

The final analytic-plan and source-adapter reviews are not yet assumed complete by this preparation. The mandatory authorization manifest must bind those frozen reviews, the source adapter, producer code and candidate, and this independent script. All prior pins are checked as well. The manifest is an operational/provenance gate, not a proof of those mathematical facts.

No full run is authorized by this note. A successful future result would concern only the final 1/8-high slab at the million-height endpoint, with any reflected consequences proved through separate source identities. It would not establish the remaining principal strip, nonprincipal family, production feasibility or Lean closure.
