# Independent review of the coarse Gamma phase

2026-11-11. **PASS as a paper derivation and source-interface plan.** The normalized Binet construction, periodic-polynomial conversion, integration by parts, and elementary phase extraction justify

`|theta(t)-theta0(t)-1/(48*t)| <= 1/(4*t^2)+23/(384*t^3) < 13/(50*t^2)`

for `t>=1500`. No fine Gabcke theta theorem is used. The final consumer comparison correctly gives `.471*t^(-3/4)` globally for `t>=1500` when combined with the pinned analytic K0 allowance `.47*t^(-3/4)`, before finite-arithmetic errors. This does not prove the K0 formula/remainder itself, implement a new evaluator, or supply Lean terms.

## Frozen evidence

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md` | `C7B701CF5B02D34142E30F38D1FFE573AE30167A561B9A759FD9964F41FC6E79` |
| `prime-estimates/coarse_gamma_phase_scalar_20261111.py` | `A6C2FA7C888808D266A9A539CAF6205EC19A38034B872BFD46BD373D701018B4` |
| Its JSON | `E7DAED4627D28460B11865A91C634FE5F1E0C07B9806FA04C4A4A17E3A9994FF` |
| `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028` |
| `integration/REVIEW_PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `A4401782284FFF48DFFBA27BB9DE2EFAF20E6BECB09A4F3737BDD220EA739547` |

I read the full phase note, its final scalar script, and section 2 of the normalized construction; checked the five hashes above; and inspected the cited source interfaces. The independent script `independent-feasibility/review_coarse_gamma_phase_scalar_20261111.py` has SHA256 `FA561635154EBBDC61A67C48BEF2165901C1CB4BC4416D3EDB6765C9596D27D2`. Its JSON has SHA256 `C66B2344711434180BD2E38EF7886025DFEC573CD5FD0F91BFAD9014297F3087`. All 21 independent exact polynomial/rational checks passed. I did not rerun the author's script, which writes its frozen receipt.

No Gamma/zeta evaluator, finite-zero input, Lean build, dependency installation, or frozen-file edit was used. The scalar checks establish algebra and inequalities, not integration, analytic continuation, or normalized log-Gamma by themselves.

## Normalization and domain

The input constructs `L(z)=H(z)-H(1)` on `Re z>0`, where

`H(z)=(z-1/2)*Log z-z+R(z)` and `R(z)=integral_0^infinity exp(-z*u)*k(u) du`.

Here Log is the principal logarithm of z on the right half-plane. It is not the pointwise principal logarithm of Gamma. The accepted paper construction identifies `exp(L)=Gamma` using the positive-real recurrence, log-convexity, Bohr–Mollerup, and analytic uniqueness. L is real on positive reals and L(1)=0, fixing its branch. H(1) is real and disappears from the phase. The [DLMF Binet representation](https://dlmf.nist.gov/5.9.E10_2) independently confirms the underlying normalized integral form; its logarithm convention matters.

The new derivation preserves that L exactly. It does not choose an untracked multiple of `2*pi*i`, infer a Gamma argument from numerical values, or use the sharp three-term phase expansion. The construction and identification with the source Gamma remain formal proof tasks.

For every integral involving `z+x`, `Re z=sigma>0` and `x>=0` imply a nonzero denominator and `|z+x|>=sigma+x`. At the phase point `z=1/4+i*t/2`, these conditions hold for every `t>0`; the threshold 1500 enters only the final simplified constants and consumers.

## Integral identities and boundary terms

The explicit polynomials are `P2(r)=r^2-r+1/6` and `P3(r)=r^3-(3/2)r^2+r/2`. On `[0,1]`, `|P2|<=1/6`, `|P3|<=1/8`, `P3'=3*P2`, and both endpoints of P3 are zero. These follow by elementary factorization; the scalar script independently checks the coefficient identities and endpoints. Continuous endpoint matching also permits the stated periodization, but the proof need not differentiate the fractional-part function at integers.

For `u>0`, direct differentiation of the displayed antiderivative gives the unit-cell Laplace integral, including the signs of both boundary terms. Geometric summation yields

`J(u)=1/(6u) -(1+exp(-u))/(u^2*(1-exp(-u))) +2/u^3`.

The identity `k(u)=1/12-u*J(u)/2` then follows by algebra. Each denominator is nonzero. Integrability of the periodic function times the real exponential follows from its bound; values at integers or at the excluded zero endpoint do not change these integrals.

Substitution into R is legitimate by absolute Fubini. The double-integrand norm, before the harmless factor 1/2, is bounded by

`(1/6)*u*exp(-(sigma+x)*u)`.

Its double integral is `1/(6*sigma)`: integrate x first to cancel u, then integrate the remaining positive exponential. Thus there is no conditionally convergent rearrangement. For `Re w>0`, finite-interval integration gives `integral exp(-wu)=1/w`; one integration by parts gives `integral u*exp(-wu)=1/w^2`. The boundary `u*exp(-wu)` tends to zero since its norm is at most `u*exp(-Re(w)*u)`. This proves

`R(z)=1/(12*z)-(1/2)*integral P2bar(x)/(z+x)^2 dx`.

On each closed integer cell, integrate the ordinary polynomial `P3(x-n)/3` against `(z+x)^(-2)`. Its endpoint values vanish individually, and the reciprocal derivative is `-2*(z+x)^(-3)`. The resulting sign is therefore

`R(z)-1/(12*z)=-(1/3)*integral P3bar(x)/(z+x)^3 dx`.

Both sides converge absolutely as the integer endpoint tends to infinity, by powers of `sigma+x`. There is no surviving origin, integer-jump, or infinity boundary term.

For `y=Im z>0`, splitting at x=y gives `integral |z+x|^(-3) dx <= 3/(2*y^2)`: use y on the first part and x on the tail. Multiplying by `(1/3)*(1/8)` gives `1/(16*y^2)`, hence `1/(4*t^2)` at y=t/2. The bound is deliberately loose but valid for all t>0.

## Phase algebra and constants

At `z=1/4+i*t/2`, set `u=1/(2*t)` and `q=u^2`. The right-half-plane log has argument `pi/2-atan(u)` and modulus logarithm `log(t/2)+(1/2)log(1+q)`. Also

`Im(1/(12*z))=-1/(6*t*(1+q))`.

Substitution gives exactly

`theta-theta0=(t/4)log(1+q)+(1/4)atan(u)-1/(6*t*(1+q))+Im E`.

The leading coefficient is `1/16+1/8-1/6=1/48`. The three absolute errors are bounded respectively by `1/(128*t^3)`, `1/(96*t^3)`, and `1/(24*t^3)`, using the elementary integral bounds on `q-log(1+q)` and `u-atan(u)` and the exact reciprocal difference. They sum to `23/(384*t^3)`. These estimates hold for all positive t, without a small-argument hypothesis.

For t>=1500, `1/4+23/(384*t)<13/50` and `1/48+13/(50*t)<1/40`. The former proves the claimed phase error; the latter gives `|theta-theta0|<1/(40*t)`. The equality with `tau^2/5` is correct when `tau=(8*t)^(-1/2)`. These are uniform monotone comparisons, not point samples.

As an optional independent corroboration, one can improve the polynomial bound to `|P3|<=1/16` using reflection and `r*(1/2-r)<=1/16` on the left half. The square-root antiderivative bounds the cubic integral by `1/y^2`. This would give `|E|<=1/(12*t^2)` and total phase error below `.1/t^2` for t>=1500. Neither sharpening is needed for approval of the author's simpler proof.

## Consumer scope and corrections resolved before freezing

During draft review I flagged two potential scope errors. The final frozen note resolves both:

* The existing published K0 allowance is `.47`, not `.45`. The latter is now explicitly conditional on the separate proposed shortened K0 proof, which this review does not approve or assume.
* The constant 80 for `2*sum_(n<=N) n^(-1/2)` is restricted to the selected height range `[1500,1000000]`, not asserted for arbitrary larger t.

The global comparison avoids both concerns. Integral comparison and `N=floor sqrt(t/(2*pi))` imply the amplitude is below `4*t^(1/4)`. Replacing theta by `theta0+1/(48*t)` therefore costs less than `1.04*t^(-7/4)`. Its coefficient relative to `t^(-3/4)` is at most `1.04/1500`, so

`.47+1.04/1500=17651/37500 < .471`.

This holds for every t>=1500, provided the underlying K0 formula/remainder is proved on that domain. Finite-sum and correction-function interval errors must be added separately. No old frozen pilot or sign receipt is silently reassigned the new phase allowance; an evaluator adopting this expression must produce a new receipt.

## Existing APIs and remaining implementation

The listed pinned Mathlib source interfaces are real and have the needed scope: `bernoulliFun_two`, `hasDerivAt_bernoulliFun`, matching endpoints and continuous periodization in `NumberTheory/ZetaValues.lean`; complex-valued finite integration by parts in `MeasureTheory/Integral/IntervalIntegral/IntegrationByParts.lean`; the complex exponential moment of order zero and negative-real-exponent tail integral in `Analysis/SpecialFunctions/ImproperIntegrals.lean`; the improper-limit theorem in `IntegralEqImproper.lean`; and absolute-integrability/Fubini interfaces in `Integral/Prod.lean`. I inspected their declarations. These are ingredients, not existing proofs of the new phase theorem. The first exponential moment, periodic-cell wrappers, measurability/integrability majorants, and normalized-phase algebra still require ordinary proof terms.

The final note is mathematically sound within its stated paper-proof scope. It removes the sharp Gamma-phase dependency from the proposed fast K0 consumer, while retaining normalized Binet and the separate K0 formula/remainder as explicit proof tasks. It supplies no additional spectral certificate or completed Lean theorem.
