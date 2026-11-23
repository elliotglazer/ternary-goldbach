# Minimal analytic slice for the rational xi disk

2026-11-11. Support for the next-after-panel memo. This is a source/interface extraction and a proposed simplification of the proof slice, not approved Lean declarations or a new implementation. No node evaluation, build or frozen-file edit was performed.

The fixed candidate is `integration/rational_xi_panel_candidate_20261111_01.json`, SHA `1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F`. Its geometry is the closed disk centered at `s0=3/5+14i` with radius rho=1/64; b=pi/4-1/33. The 929 nonnegative nodes, 1857 signed weights per coefficient, seven coefficients and exact rational arithmetic are the finite data to replay. The frozen producer report's historical review status is not changed here.

## Minimal conclusion and what can be omitted

Prove `xiF(s)!=0` for every `|s-s0|<=1/64`. A stronger intermediate result is `Re(F_b(s))>0`, where `F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`.

For this conclusion, no polygon crossing theorem, argument principle, zero-order transport, rectangle carrier, sign-count completeness, FFT, family manifest, global QRH provider or production-height theorem is needed. Once the F_b disk inequality is proved, exponential nonvanishing gives xiF nonvanishing. The rectangle consequence uses only its exact containment in the disk. If a zeta conclusion is desired afterward, [Xi.lean:56](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/Xi.lean:56) supplies the zero-location iff in `0<Re(s)<1`.

## Interfaces in dependency order

| Interface needed in the proof | Existing source versus new proof |
|---|---|
| Actual unhalved xiF | [Xi.lean:18](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/Xi.lean:18) defines `s*(s-1)*completedRiemannZeta0(s)+1`; entirety is line20, product identity line28. These are existing source declarations. File pin `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F`. |
| `F_b(s)=integral_R P(v+ib)exp((s-1/2)v)dv` | New formal proof from the reviewed Fourier note. The source completed-Mellin construction, theta FE and Gaussian series exist; splitting at1, two integrations by parts, the constant/boundary terms, P evenness and contour shift must be assembled. This is the first essential source-to-kernel analytic bridge. |
| Node semantics for the actual full P | New classical theta2/theta4 wrappers, their T/S identities, principal-root branch identification and two ordinary tau-derivative formulas, then `P(w)=exp(w/2)*(6tau*theta3'+4tau^2*theta3'')`. Existing Jacobi theta definitions/FE and differentiability APIs support the proofs; the final interfaces do not already exist. |
| Terminal finite series plus full tails | New instantiation of the actual differentiated series and the **specific sixteen-mode `2^-277` tail** used by this candidate. The conservative `384exp(-(N+1/2)^2/5)` theorem at N=16 does not imply that stronger radius. The fixed sixteen-mode proof is in the reviewed panel specification. Normal-convergence/derivative identification still needs Lean proof. |
| Elementary and interval semantics | Existing pi/arctan, exponential-series/remainder and square-root facts; new soundness proofs for exact rational endpoint operations, reductions, root branches, algebraic phases and tiny-exponential endpoint bounds. Then closed kernel-checked acceptance of the actual nodes and weights. Python success or a hash is not such a proof. |
| Uniform kernel envelope and weighted integrability | New formal proof of the reviewed envelope and constants at this fixed b: `A=46687168/3`, q=1/44, `M=2054235392/3`, `D=30813530880`. Needed for the contour shift, quadrature and residual. General all-height parameterization is optional for this small slice. |
| Seven moment quadrature errors | New analytic trapezoid/periodization proof for the seven integrands `(v^j/j!)*P(v+ib)*exp((s0-1/2)v)`, j=0,...,6, plus omitted discrete-node bounds. Use work height14, strip width1/66 and cutoff `q exp(2V)>=2`. The reviewed composition note supplies the formulas but not an implemented theorem. |
| Finite substitution and disk inequality | Finite triangle inequalities, signed weights, exact center sums, rational budget and polynomial norm inequalities. These are new formal assemblies with no additional analytic conjecture. The final residual can be obtained by the moment argument below, avoiding an iterated-derivative/Cauchy API. |

The full Fourier paper is pinned at `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`; the modular-node substitution paper at `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571`; its independent review at `FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD`. The fixed panel spec is `92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957`, reviewed at `2F05928D57B1E76F513095FE5CCA4D5930EF314EB658EE748016E52FBE84CC97`.

## A shorter disk-remainder interface

Set `K(v)=P(v+ib)*exp((s0-1/2)*v)` and define the seven coefficients directly by

`a_j=integral_R K(v)*v^j/j! dv`, j=0,...,6.

The Fourier identity gives `F_b(s0+z)=integral_R K(v)*exp(zv)dv`. The reviewed envelope implies

`integral_R |K(v)|*exp(|v|)dv <=D`.

Indeed its integrand is bounded by `A exp(4|v|-q exp(2|v|))`; substitution R=exp(2|v|) gives at most `A(1/q+1/q^2)=D`.

For |z|<=rho<1, the ordinary exponential series gives the pointwise bound

`|exp(zv)-sum_(j=0)^6 (zv)^j/j!|`

`<=sum_(j>=7) rho^j*|v|^j/j! <=exp(|v|)*rho^7/(1-rho)`.

The second inequality uses `|v|^j/j!<=exp(|v|)` separately for every j and sums a geometric series. Integrating this bound and exchanging only a **finite** polynomial sum with the integral yields

`|F_b(s0+z)-sum_(j=0)^6 a_j*z^j|<=D*rho^7/(1-rho)`.

This is exactly the remainder used in the accepted budget. It needs no identification of a_j with an iterated derivative, no numerical outer-circle samples, and no Cauchy integral theorem. The seven trapezoid rules apply directly to these moment integrands, so their existing errors and the stored coefficient centers are unchanged. The equivalence with Taylor coefficients can be proved later if another consumer needs it.

The exponential-series source is `Analysis/Normed/Algebra/Exponential.lean:640`, `expSeries_div_hasSum_exp`; `Analysis/Complex/Exponential.lean:249` bounds the nonnegative finite terms by the real exponential. The above moment-remainder argument is a new proposed proof simplification, not a claimed compiled or independently reviewed lemma.

## Finite semantic attachment and the last comparison

Each accepted node inequality must refer to the exact `v=k/256` and exact common b. Its arithmetic seed/word trace alone is not yet a P inequality: it must be attached to the actual elementary functions and theta identities. Each weight inequality refers to `h*v^j/j!*exp((1/10+14i)v)`. Negative P values use evenness **and** conjugation; signed powers and unequal real exponential weights remain explicit. Exact integer center products give denominator `2^96` and no finite-sum rounding error.

The total budget is the fixed rational `E=91500568239/10^12<1/10`. It contains quadrature, discrete spatial tails, node radii, weight radii and the degree-six remainder. Prove the stored seven coefficient inequalities from these ingredients, not from a predicate asserting the desired final disk bound.

For the exact stored centers c_j, finite algebra proves `U>=sum_(j=1)^6 |c_j|rho^j` and `Re(c0)-U>14.0688`. Hence throughout the disk `Re(F_b)>=Re(c0)-U-E>0`. This final step and disk-to-rectangle containment need no zero-count apparatus.

## Recommended first bounded implementation milestone

Integration's proposed generic typed-interval containment theorem plus at most four selected node traces is a valid bounded **arithmetic** milestone. Select representatives covering theta2/3/4 and maximal S depth, and check actual operand dependencies and conditional seed semantics. Do not label that result an actual P enclosure until the elementary/theta semantic attachment is proved.

A separate small first **analytic** milestone is the integral-moment remainder argument above: prove it from an integral representation and the weighted L1 bound, then instantiate only after the actual xi Fourier identity and envelope are proved. This removes an unnecessary derivative/Cauchy interface while retaining all current constants. It is not a replacement hypothesis at the source xi theorem.

The eventual closed small-disk theorem must consume kernel-checked finite records and the proved analytic bridges with no remaining certificate-validity or evaluator-correctness premise. A standard-axioms audit alone is insufficient if those hypotheses survive in its type; expanded inputs must also be inspected. These bounded milestones give no production or family-coverage claim.
