# Independent review of the conditional psi strip bound

Verdict: PASS as a conditional paper reduction and exact scalar calculation. No mathematical defect was found in the deduction

`|psiR(x)-x| < .0081*x/log x` for every `x >= exp(35)`.

This does not prove the finite spectral assertion, validate the global QRH provider, produce a Lean theorem, or fill `[1e9,exp(35))`. Those remain open. In particular, the proposed reduction and the existing sieve ending strictly below `1e9` do not yet establish the full sufficient Möbius input.

Reviewed producer report SHA256:
`d4a026f5b7190f0aa577a70a88e7bfcb79740f9ca549ee9b7ac0ef0c782b3826`.

Reviewed scalar script SHA256:
`30fbfa0e84c83613ebb46756ea6f0a442724181332b07595e14ce1ae3ccc1398`.

The report and script are `agents/integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md` and `resume_psi_finite_strip_20261111.py`. Source references below are relative to `work/ternary-goldbach/TernaryGoldbach`, campaign pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The independent JSON records hashes of every inspected source file. No Lean builds or canonical edits were performed.

## Spectral assumptions and translated mass

The finite assertion is about every actual nontrivial zeta zero, with the closed cutoff `|gamma| <= 60343058`, and upper real part `111/200`. Functional-equation reflection gives the lower real part `89/200` on the same height range. The high part requires the separate genuine global upper bound `7/8`. Equality at the height cutoff belongs to the low part. Neither assumption follows from the scalar replay.

The translated mass argument has the correct sign and normalization. `XiPartial.lean:776` approximates `xi'/xi(s)` by the finite sum of `m/(s-rho)`. At `s=2+ic`, real parts are positive and equal to

`m*(2-beta)/((2-beta)^2+(gamma-c)^2)`.

Taking a disk containing the chosen finite zero set and the evaluation point, discarding other positive terms, and sending the approximation error to zero gives the desired finite-subset inequality. No factor two or extra imaginary constant enters its real part.

The actual identity in `Xi.lean:142` and `ZetaDatum.lean:222` gives rational real-part terms at most `1.5`, a nonpositive `-log(pi)/2`, and an Euler-series contribution less than one. The latter follows from

`log(2)/4+log(3)/9+(log(3)+1)/3 < .7/4+1.1/9+2.1/3 < 1`.

The real part of the digamma series at `1+iv` is bounded by its first positive summand plus an integral, hence by `1+log(1+|v|)`. The series is consistent with [DLMF 5.7.6](https://dlmf.nist.gov/5.7.E6). Thus the mass upper bound is `3+.5*log(1+|c|/2)`. Its series and limiting argument still require formalization.

True multiplicities must be transported, rather than replaced by the weaker exposed statement `1 <= mult`. The existing bridge `WeilBridge.lean:87` requires its xi height to be at least one, while `xi_partial_approx` exposes only positivity. Its proof chooses `k >= 23` and a height at least `k+1`, so exposing that fact is sufficient. Alternatively, use the divisor equality and `analyticOrderAt_xiF_eq` directly on the actual carriers. This is the same API obligation identified in the prior principal review; it is not a new zero-distribution assumption.

## Low zeros and Gaussian normalization

For all `L=log x >= 35`, the choices `delta=.001*L^(-3/2)`, `K=sqrt L`, `a=+/- .001/L`, `b=log(10000)-L` satisfy both sandwich domains. In particular `b <= -.001/L`, `delta <= 1`, `delta <= K`, and `2*exp(-L/2)<1`.

For length-three ordinate intervals intersecting the finite height range, the center obeys `|c| <= H+3`. The exact exponential check gives translated mass strictly less than 12. With `u=2-beta` in `[9/8,15/8]`, the concave quadratic

`u-(8/25)*(u^2+9/4)`

has endpoint values `0` and `3/100`. Thus the kernel bound is non-strict `>=8/25`, while the multiplicity count is strictly less than `37.5`. The safe count 38 is valid. This endpoint equality matters when writing the lemma but changes no budget.

`GaussSmooth.lean:355` bounds the Mellin integral by `(exp(a*beta)+exp(b*beta))/|rho|`. The Gaussian factor has norm `exp(delta^2*(beta^2-gamma^2)/2)`. Therefore the factor `2*exp(delta^2/2+|a|)` is correct, including at ordinate zero. The finite strip supplies `|rho|>=89/200` for the first bins; no minimum zero ordinate is needed.

Two signed bins per index, with possible harmless double counting at zero, give the factor 76. For indices `k>=1`, use `|rho|>=3k`. If `J=ceil(1/(3delta))`, then `J<=2/(3delta)`. The first J reciprocal terms are bounded by `1+log J`, and the remaining Gaussian integral is less than one. This proves the stated `C(L)` bound for every finite truncation, not merely a complete low-zero set.

The normalized low error is `2.001*C(L)*exp(-.445L)`. Since `C'(L)=38/L` and `C(L)>=76/.445`, its scaled logarithmic derivative is at most `489/14000-.445<0` at 35 and decreases in the required upper bound thereafter. The endpoint calculation gives `.006284723442`, safely below the allocated `.007`.

## High tail and all-scale coverage

`ZeroSumGen.lean:121` counts both ordinate signs in one absolute-ordinate window. Its bound is `2*Z3g+2*c3g*(k+1)`. Consequently the geometric sum has exactly the two terms in the producer report, with no further sign factor.

The scalar script checks the actual positive-height polynomial and obtains `Z3g<180` and `c3g<1e-6`. In `ZetaZeroSums.lean:530`, the only use of the upper exponent one is the pointwise inequality `x^beta<=x`. Replacing it by `x^beta<=x^(7/8)` under the genuine global bound yields the proposed tail. This requires a new proved variant; the old theorem cannot simply be called with changed arguments.

With `A=H^2/(2*10^6)`, `B=4.4*H/10^6`, and `Q=1+L^3/B`, the estimate `1/(1-exp(-t))<=1+1/t` gives exactly the displayed `E_high`. On `[35,200]`, every retained positive polynomial factor increases with L, while the Gaussian suppression is weakest at 200. The resulting bound on `L*E_high` is below `1.048e-97`. For `L>=200`, remove the Gaussian, use `Q<=(1/200^3+1/B)*L^3`, and maximize `L^4 exp(-L/8)` and `L^7 exp(-L/8)` at 200. Their derivative signs are negative there and afterward. The exact bound is `9.9928029931e-10`, below the allocated `2e-9`. There is no uncovered intermediate or arbitrarily large x range.

The old `RHBelow` theorem with its `H>=1e8` restriction is not used. The present cutoff below `1e8` is admissible for the unconditional window theorem and the new strip-powered variant.

## Vertical integral, limit, and desmoothing

`PsiExplicit.lean:47` defines the exact `Vg`. After the explicit formula factor `1/(2*pi)` and division by x, the normalized contribution is `Vg/(2*pi*x^(3/2))`. Its `exp(-b/2)` is `sqrt(x/10000)`, giving the essential `.01*exp(-L)` term. The constant 301 bounds the source coefficient with the small exponential multipliers for both signs of a. Thus the stated vertical bound is correct. Multiplying by L gives terms `L^(5/2)exp(-3L/2)` and `L^(5/2)exp(-L)`, both decreasing from 35. The endpoint upper bound is `1.394916010e-8`.

Apply these estimates first to every finite zero rectangle. `ZetaExplicit.lean:122` then passes to the common good-height limit for each fixed x and smoothing. This does not require exchanging an infinite zero sum with an integral or proving a limit uniformly in x. Gaussian admissibility follows from the actual `GoodSmoothing` construction, and `Mg_one` supplies the exact main term.

The upper and lower normalized errors `U(L)` and `D(L)` agree with `PsiLarge.lean:296,326`. The coarse `psiR(y)<=4y` used there is elementary, as proved in `PsiSandwich.lean:90`. In particular the upper low cutoff is outside the denominator, while `E+2r` is inside; the report keeps this placement.

The remaining uniform estimates also hold. `L*exp(-L/2)` and `L*exp(.001/L-L)` decrease from 35. The denominator reciprocal decreases toward one. For the shift, expand `L*(exp(.001/L+.0000005/L^3)-1)` as a positive double series; every monomial has exponent `1-k-3j<=0` for `k+j>=1`. The lower shift `L*(1-exp(-.001/L))` is at most `.001`. Hence the endpoint allocations cover both signs for all L, rather than only a sampled grid.

The exact conservative total is

`.008005031005022 < .0081 < .01`.

## Replay and remaining work

`resume_psi_strip_audit_20261111.py` executes the original scalar script with its output path redirected through `__file__`, then checks the mass endpoints, derivative bounds, parameter domains, vertical multiplier, and Euler-series bound independently. The producer files are unchanged. The replay passed with exit code zero. The JSON records the source hashes and exact-check outputs; `resume_psi_strip_replay_20261111.json` and `.log` retain the producer results in this review directory. No pre-existing Python process was stopped.

The required analytic bridges remain the true-multiplicity translated mass, the reciprocal Gaussian low-zero lemma, the global-strip high-tail variant, the direct Vg estimate, and their finite-rectangle assembly. These are paper arguments awaiting formal proofs. The actual finite spectral assertion, genuine global-provider validation, and every point of `[1e9,exp(35))` remain separate obligations. The diagnostic crossing near `6.67e14` is only a floating evaluation of this upper bound and is not a smaller certified threshold or evidence about actual prime errors.
