# Review of the full right-slab Fourier evaluator

2026-11-11. **PASS at the stated paper-construction scope. No correction required.** The Gaussian majorant extends the previously reviewed transform through sigma=1 and sigma=2. The scalar searches terminate for every finite rational requested height and positive rational error. The common-function derivative bound supplies a valid full-panel adapter. This is not a successful contour computation or a proof of a spectral statement.

## Frozen artifacts and independent computation

The producer artifacts in `../zero-sum/` are:

* `FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `618FB579D8657C72F2003BE4D60C68E38648C2F30F266938CE40E2C8F5A5E771`.
* `full_right_slab_fourier_parameters_20261111.py`, SHA256 `0F3987B2F5BA8CF45A3D51663E2466207976D5FED520B9E2552D161B1D9872FE`.
* Its JSON receipt, SHA256 `87E2731447C2FB0B189F4EE77A3189844DA253DF56460BF8860C8056D2F2736B`.

The independent script `review_full_slab_fourier_20261111.py`, SHA256 `57284B62D1595AC1F39E1EAC62A5CF969A2866662E740924C18104FE2EBA0499`, completed with 49 exact checks passing. Its receipt `review_full_slab_fourier_20261111.json` has SHA256 `709D803AB2325EC0A3FBD2BDF0D4DEB779EA21F5C1340AB87C49B78E84ABA1AB`.

I independently reconstructed all rational fields in all four producer rows. The search implementation uses exponential brackets and bisection for the monotone K, L, x and power-of-two thresholds, rather than executing the producer script. Four further cases test height zero, a fractional height, large tolerances, very small tolerances, and a conductor-height product far above the old fixed cap. No transform array, character, special-function value, or FFT was generated. This is a scalar audit, not an independent spectral computation.

The predecessor is the off-critical plan `BA7A5D0517972FD9C93496E6166DEC471B36C18CA0B6BBA734985016ECD24B25`, reviewed in `REVIEW_OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md`, SHA256 `F9431FA70E33B7FFA3A16B6C12CB254A14D590C8FEEF81CC86E328418A304D0F`. That review pins the underlying Gaussian and alias derivations and source identities. None of these files was modified.

## Source function, characters, and endpoint normalization

The input remains an actual primitive nonprincipal character of integer conductor c>1, with parity a in {0,1}. The actual source function is

`Lambda(s)=c^((s+a)/2) completedLFunction_chi(s)`.

The chosen epsilon=1 and tilt b=0 remove phase-selection arithmetic but do not assert anything about W. The reciprocal formula still uses the actual root number W and the inverse character. It is not valid with an arbitrary substitute character or omitted Gauss factor. The mandatory factor `c^(it/2)` in the expression using `completedLFunction` is retained.

The exact Mellin identity in the accepted predecessor is entire before its real part is specialized. Its derivation interchanges the original Dirichlet series only in Re(s)>1, then uses theta reciprocity and analytic continuation. Thus applying it at sigma=1 or 2 is legitimate. The restriction sigma<1 belonged to a discarded elementary majorant, not to the transform identity itself.

The frozen Mathlib source at `56a005855ea17e0b0958f73ec801ae140b0a1679` supplies `differentiable_completedLFunction`, `LFunction_eq_completed_div_gammaFactor`, `rootNumber`, and `IsPrimitive.completedLFunction_one_sub` in `NumberTheory/LSeries/DirichletContinuation.lean`. On this whole slab `Re(s+a)>0`; `Analysis/SpecialFunctions/Gamma/Deligne.lean` supplies `GammaR_ne_zero_of_re_pos`. The completion factor is analytic and nonzero, so multiplication preserves the actual L-function's zeros and their multiplicities. Conductor one and its theta constant terms and poles remain excluded.

No critical-line realness premise is used. All values, enclosures, and winding witnesses are complex. At negative frequency the prefactor exponent is `1-sigma+a`; it may be negative at the right edge. The estimate only uses its upper bound, so this causes no sign reversal or missing factor.

## The Gaussian majorant and full-slab integrability

I derived the uniform Gaussian estimate independently before reading the frozen note. Write r=|x| and C=cos(2y). For |y|<=1/4, `C>=7/8`, so `d=pi C/c>2/c`. The split-Gaussian formulas are

`|h(x+iy)| <= K_a A_sigma exp((sigma-1)r - d exp(2r)/2)` on the positive side,

`|h(x+iy)| <= K_a A_sigma exp(-sigma r - d exp(2r)/2)` on the negative side.

These algebraic bounds do not require 0<sigma<1. The two Gaussian sums used to obtain them have positive arguments regardless of sigma. In the requested closed slab, both linear rates are at most 1. Also `A_sigma<=c/C`, `K_a<=2`, and `2/C<=16/7<3`. Therefore the proposed common bound

`Q_c(r)=3c exp(r-exp(2r)/c)`

is valid uniformly in sigma, parity, and |y|<=1/4. In particular it remains valid at sigma=1 and 2. The negative side genuinely uses theta reciprocity; it is not obtained by discarding cancellation in a small-argument direct theta series.

With u=exp(r), the two-sided zeroth moment is at most

`6c integral_[1,infinity) exp(-u^2/c) du <= 6c integral_[1,infinity) u exp(-u^2/c) du <= 3c^2`.

The first absolute moment is at most the same last expression because log(u)<=u. Thus the retained constants `M_c=6c^2` and `J_c=3c^2` are safe. The factor two for the two ends is present. No Gaussian integral normalization is needed for these coarse bounds.

The theta series and reciprocal series give holomorphy and rapid decay on a slightly larger closed log-plane strip. This justifies moving the transform contour to y=+1/4 or -1/4, with vertical-edge integrals tending to zero, and proves `|F_sigma(t)|<=6c^2 exp(-|t|/4)`. Fourier inversion and Poisson regrouping are justified by the same decay. The proof does not try to apply the former singular factor `1/[sigma(1-sigma)]` outside its domain.

## Parameter construction and termination

The tolerance is a positive rational error for F, and H is a nonnegative rational height. Replacing H by max(1,H) handles H=0 without a degenerate period. Every parameter is a finite scalar, not an allocated transform.

For the time tail, P=2H0+4K gives P>=6 and P-H0>=4K. Each geometric denominator exceeds one-half. Both signed channels therefore sum to less than `24c^2 exp(-K)`, and the rational K test is sufficient because exp(1)>8/3.

For the frequency tail, the integer x test yields `exp(2x)/c>2x+L`. The least power of two N above Px/3 satisfies N>=2, `N<2Px/3`, `X=pi N/P>x`, and `omega N<88x/21=D`. Here omega<2. The derivative of log Q is `1-2exp(2r)/c`; beyond x it is strictly negative and bounded away from zero. The geometric progression estimate in equation (11) follows, including its factor two and the overcount of the negative endpoint. In particular the parenthesis is less than three, and `Q(x)<3c exp(-L)`, proving the stated frequency test.

For the theta-series tail, n0 is the first omitted theta index and is unrelated to a retained Fourier index. `log(1+1/n0)<=1/n0` proves the common ratio bound exp(-z). Both direct and reciprocal prefactors grow at most exp(3r). With V>=2 their product with the Gaussian decreases for r>=0, since its logarithmic derivative is at most `3-2V exp(2r)<0`. The denominator improves as r increases. Replacing exp(-V) by `(3/8)^floor(V)` is conservative. This proves equation (12), and multiplication by D correctly counts the total weighted error of all N coefficients.

The K and L searches terminate by geometric decay. For x>=1 and L>=1, the successive threshold ratio is at least `(64/9)(3/5)>1`, with a fixed margin above one. The N threshold is finite. Once n0>=c, z>6 and V>=3n0; equation (12) is bounded by `3n0(3/8)^(3n0)`. Its successive-integer ratio is at most 27/256. This proves convergence to zero and termination even if n0 is doubled. None of these arguments needs information about zeros or their separation.

The input-rounding contract contributes less than e/8 after multiplication by omega N. The transform contract is already an error in the final scaled output, as the note explicitly specifies. One must not interpret it as an unscaled normalized inverse-DFT error and omit omega N. The remaining three contributions are each less than e/4. Their sum is strictly below e. Arbitrary-depth FFT arithmetic still requires its own verified stage budget; the old fixed-depth example is not imported here.

All four exact producer rows match, including the large N=1073741824 witness. This number records a sufficient scalar choice only. There is no measurement of such a transform's runtime or memory consumption.

## Actual point values and whole contour panels

A rational target ordinate is not necessarily an FFT grid point. Direct evaluation of the finite trigonometric polynomial at that ordinate has the same analytic tail estimates, provided its finite arithmetic is also enclosed. The note makes this distinction explicitly.

Recovering Lambda requires an enclosure of the positive multiplier `m=c^((sigma+a)/2)`, not just an approximate midpoint. An explicit allocation supplementing the note is as follows. For a desired point radius tau, take

`delta_F=min(1,tau/(4c^2))`,

`delta_m=min(1,tau/(4(M_c+1)))`.

If the two centers have these errors, the error in their product is at most `c^2 delta_F+(M_c+delta_F)delta_m<=tau/2`. This leaves room for rounding the final multiplication. The independent script checks this formula in small- and large-tolerance cases. All quantities and elementary evaluations have finite requested precision. Their actual certified implementation remains future work.

The horizontal derivative deserves a separate check. Differentiating G in sigma produces `(x-log(c)/2)G`. Differentiating m cancels the logarithmic term exactly. Hence

`Lambda'(sigma+it)=m integral x G_sigma(x) exp(itx) dx`.

The first moment bound gives `|Lambda'|<=3c^(7/2)<3c^4`. This is the complex derivative of the single actual entire function. It controls both horizontal and vertical segments, not just the derivatives of a family of scaled functions. Dominated differentiation follows locally from the entire theta-Mellin bounds; alternatively derive the estimate in the slab interior and extend to the two edges by continuity of the entire derivative. The endpoint sigma=2 is therefore covered without silently demanding that the slab bound hold on an open neighborhood beyond 2.

Integration along a straight segment contained in the closed slab proves the proposed Lipschitz constant. With point error e_panel/2 and parameter radius at most `e_panel/(6c^4)`, the whole segment has error at most e_panel. Rational upper bounds on Euclidean displacement give a fully rational geometric test. This covers horizontal connectors and corners as well as the vertical sides. Repeating fixed-sigma sample values without this derivative or a uniform interval model would not suffice.

## Limits of the accepted result

The evaluator-parameter search terminates for every input in its stated domain. A search for strict nonvanishing witnesses has a different condition. If an actual compact boundary is zero-free, its positive minimum modulus, refinable point errors, and the derivative bound allow strict half-plane witnesses under fair refinement. Shared rational vertices and the established geometric checker are still required. On a positive oriented simple closed contour, the argument principle then counts zeros with multiplicity; arbitrary non-simple paths require the usual winding-weighted interpretation.

No such boundary hypothesis is proved here. A zero on Re(s)=111/200 can satisfy the intended weak strip assertion and still defeat strict nonvanishing on that particular boundary. Inclusive height endpoints require actual enclosing connectors. No sign, zero count, simplicity assertion, or zero-free region follows merely from successful parameter selection.

The zero tilt also leaves potentially severe high-ordinate conditioning. An absolute-accuracy algorithm may need a much smaller tolerance to separate a very small nonzero completed value from zero. The paper construction has no fixed analytic error floor, but makes no feasible-runtime claim.

The source adapters, uniform estimate packaging, search-termination proofs, elementary interval arithmetic, finite-transform implementation, complete character manifest, and actual contour records remain implementation or data obligations. The principal conductor-one case is excluded. No Lean build, canonical change, new assumption, or production spectral computation was made for this review.
