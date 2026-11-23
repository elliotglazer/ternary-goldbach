# Independent principal-route review, 2026-11-11

**Verdict:** no mathematical defect found in the proposed conditional principal-energy route. The translated mass estimate, multiplicity accounting, enlarged Gram domain, and high tail withstand the checks below. This is a paper review, not Lean validation. The actual finite zero-free assertion (ZF) is still unproved, the genuine global 7/8 provider still requires its separate validation, and the projection/digamma/limit bridges still require formalization. This review does not establish `Ep ≤ 1e-4`, `J < 10`, or Goldbach.

Reviewed inputs:

- `agents/mellin/RESUME_PRINCIPAL_2026-11-11.md`, SHA256 `950bd0ec1a67a9591626d5fa527867d127929e7a2028cd7b39a4c1438005f22c`.
- `agents/mellin/resume_principal_20261111_constants.py`, SHA256 `e5c4fae2d5fa6e897c1acabf19c282e05a91c31866616ac6e75aa142134b7460`.
- Target source under `work/ternary-goldbach/TernaryGoldbach`, pinned campaign commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Source paths below are relative to that directory.

The parent already ran the scalar script successfully. I inspected its rational inequalities and their connection to the analytic formulas; I did not treat its success as evidence about zeros or run a compiler.

## Translated mass and true multiplicities

`Explicit/XiPartial.lean:776` approximates `logDeriv xiF s` by the finite sum of `m/(s-u)`: its displayed plus sign accompanies `(u-s)⁻¹`, so the proposal's sign is correct. At `s=2+ic`, each real part is `(2-β)/((2-β)^2+(γ-c)^2)>0`. The source xi zero strip supplies `0<β<1` independently of QRH. Choose the compact disk to include the evaluation point and every selected zero, discard the other positive terms, and let the arbitrary approximation error tend to zero. This introduces neither a Hadamard constant nor a factor of two.

The upper bound agrees with `Explicit/Xi.lean:142` and `Explicit/ZetaDatum.lean:222`: the `1/(s-1)` term comes from `zetaF`, while `1/s` and the half-digamma term come from xi. The two rational real parts are at most `1/2+1`. The Euler-series bound by `Σ log(n)/n²<1` is valid; `log(t)/t²` decreases for `t≥3`, which justifies the proposed integral comparison.

The real digamma series follows from [DLMF 5.7.6](https://dlmf.nist.gov/5.7.E6) at `z=1+iv`. Its summands are `v²/(n(n²+v²))`, including zero when `v=0`. The decreasing-function comparison gives at most `1+log(1+v)`, after dropping nonpositive minus Euler's constant. Thus `Re(xi'/xi(2+ic))≤3+log(1+|c|/2)/2` is justified on paper. A formal series/real-part interchange is still needed.

**Small API gap to handle explicitly:** `xi_partial_approx` exposes only `T>0`; `Explicit/WeilBridge.lean:87` (`multRectD_eq_mult`) takes `1≤T'`. It cannot be applied directly with that existential witness without another argument. The approximation proof itself chooses `k≥23` and a good height `T≥k+1`, so exposing this bound is one safe route. Alternatively derive multiplicity equality directly from membership in the two divisor carriers and `analyticOrderAt_xiF_eq` (`WeilBridge.lean:38`). Membership supplies the required local-domain facts. This is an interface obligation, not a counterexample to the mass lemma. Replacing the true multiplicity by the statement's weaker `1≤mult` would be insufficient.

The count `<45` follows with the stated strip: the endpoint test for the concave quadratic in `a=2-β` is valid on `[9/8,15/8]`. This counts multiplicity, not distinct locations.

## Gram normalization, domain, and Schur estimate

`Explicit/EtaPlusMellin.lean:59` defines `fP δ t=etaPlus(t) exp(2πiδt)`, and `Helfgott/Defs.lean:42` defines the actual `etaPlus=t*hH(200,t)*exp(-t²/2)`. Extending `etaPlus(t)t^(ρ-1)` by zero for negative t, ordinary full-line Plancherel therefore has no extra `2π` factor. The product on the t-side is

`etaPlus(t)^2 * t^(β+β'-2+i(γ-γ'))`.

Its Mellin parameter is exactly `β+β'-1+i(γ-γ')`. Thus the proposed real interval `[-3/4,3/4]`, rather than the earlier nonnegative interval, is necessary and sufficient under the reflected 7/8 strip. The Fourier sign does not change this inner product identity. The functions are in L1 and L2: near zero bounded `hH` leaves a positive power governed by `β>0`, and infinity has Gaussian decay.

With `k=σ+2`, differentiating `E=exp(ku-exp(2u))` gives the displayed polynomial `16-8k+(4k+4)z-4z²`. The bounds `1,1,3,5,33`, numerator `427.8<428`, and denominator floor `a²≥25/16` are consistent. Two integrations by parts require bounded continuous derivatives of the bandlimited projection and vanishing endpoints; the compact frequency cutoff supplies those after its inversion/differentiation bridge is proved. The projection contraction norms cited from the energy chapter remain formal proof obligations, not already available compiled statements.

Repeated-index Schur is the correct treatment of multiplicities. A zero of multiplicity m appears m times with the same coefficient; row counts also include all m copies. The resulting right side is `2600 Σ m|cρ|²`, while the left side still contains the full squared multiplicity interaction. No m² term has been silently dropped. The two-sided bins give the factor 90, and `Σ_{j≥4}j⁻²≤1/3` is valid. Relevant nonempty-bin centers stay within `T0+10`; empty far bins need no local count. Endpoint overlap only increases the upper bound, or can be removed by half-open bins.

## Pole continuation and finite-region implication

`Explicit/ZetaGrowth.lean:17–34` uses `Function.update ((s-1)*ζ(s)) 1 1` and proves it entire. Hence the proposed argument-principle object has no zero or pole artificially inserted at 1. Using the raw pointwise product there would be wrong; the proposal correctly avoids it.

Boundary nonvanishing plus winding number zero on the rectangle with real sides 2/3 and 2 would imply (ZF), after conjugation. This is a **stronger certificate target** than (ZF): it also excludes zeros on the line `β=2/3`, which (ZF) allows. A zero on that boundary would require a modified contour or boundary treatment, not refute the weaker desired statement. The top edge must include the specified height exactly. Neither boundary enclosures nor the winding computation have been supplied. The pole-removal definition alone supplies none of this missing zero information.

Given (ZF) and the global upper strip, all low zeros satisfy `β≤2/3`; consequently `Σ m x^(2β-2)≤1.1e9*x^(-2/3)`. The final low norm bound is uniform for every `x≥4.9e26`, not just the endpoint or one choice of phases.

## Exact EA/EB tail and passage to the limit

The formulas match `Explicit/ZeroSumBound.lean:89,92,307,308`. `Explicit/EtaPlusMellin.lean:286` requires `T0≥200+max(10π|δ|,50)`, `0<Re(s)<1`, and strict `T0<|Im(s)|`. All hold for the high part at `T0=40000000` and `|δ|≤600000`. The low part must include equality at the cutoff.

The subtraction `T'=T0-200` is essential and is retained. At the largest δ, `T'/(π|δ|)>21.2`; the EA expression decreases beyond that point. At δ=0 it is zero by definition. `Cg*(2aH)<130` uses `aH=200/(2π)`, so there is no missing frequency-width factor. Both geometric denominators are safely bounded by 300000. `BPz2` at `ZetaPoly.lean:425` agrees with the script's polynomial for positive T, and `polyDatum_zeta2` has exponent parameter 10.

`Explicit/ZeroSumGen.lean:121` already counts both ordinate signs, giving `2 Z3g+2 c3g(k+1)`. Summing this against `ρ^k` gives exactly the two geometric terms used in the proposal. There is no further factor two. The resulting coefficient bound `<1e-8` is consistent with the EA contribution `<8e-9` and negligible EB term. The normalized high part has `x^(-1/8)`, requiring the genuine global 7/8 bound, not merely the finite-region assertion.

`Explicit/ZetaExplicit.lean:122` uses `goodSeqD ldatum_zeta` independent of δ, and `Datum.lean:579` puts its kth height in `[k+1,k+2]`. Bound **each finite rectangle sum** by splitting it at the fixed T0. The low Schur estimate and high geometric estimate are uniform in the outer height. Apply Fatou to squared norms with respect to `W(δ)dδ` and the pointwise explicit-formula limit. No uniform convergence in δ, arbitrary reordering of a conditionally convergent zero sum, or interchange of an infinite Gram matrix is needed. Measurability and identification of the actual residual/vertical term must still be formalized.

The earlier removal and vertical-remainder budgets were treated as cited interfaces, not independently re-proved in this bounded review. With those interfaces, the displayed norm budget `.0095+3e-8+1e-15+5e-12<.01` is consistent. The scalar file contains both the older `.64/9000` scenario and the new `2/3/2600` scenario; its final stronger block is the one relevant to this proposal.

## Handoff

Keep the route as a conditional research reduction, with separate tasks for the actual finite zero-free evidence, the global provider, translated multiplicity-aware mass, projection/Gram formalization, and finite-height Fatou assembly. None may be supplied as a new axiom. This review found no reason to discard the route, but it supplies no new finite zero-free theorem and does not close the separate nonprincipal or cubic major-arc obligations.
