# A coarse normalized Gamma phase for the Gabcke K0 route

2026-11-11. New paper derivation with exact scalar checks. No sharp Gabcke theta estimate, numerical Gamma evaluation, finite zero data, Lean build, new premise of the final theorem, or frozen-file edit is used.

For the actual normalized Gamma phase, define

```
theta0(t) = (t/2) log(t/(2*pi)) - t/2 - pi/8,
thetahat(t) = theta0(t) + 1/(48*t).
```

The result established below is

```
|theta(t)-thetahat(t)| <= 1/(4*t^2) + 23/(384*t^3)
                         < 13/(50*t^2)                 (t >= 1500).
```

It also gives `|theta(t)-theta0(t)| < 1/(40*t)`. At t=1500 the conservative bound, multiplied by 80, is exactly `13/1406250 < 1/100000`, approximately 0.00000924445. The bound decreases for larger t. This is sufficient for the shortened K0 strategy without proving the three-term theta approximation with error `1/(3322*t^7)`.

## 1. Accepted normalized input and precise branch

The input paper construction is `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md`, SHA256 `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028`, section 2. Its independent review is `integration/REVIEW_PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md`, SHA256 `A4401782284FFF48DFFBA27BB9DE2EFAF20E6BECB09A4F3737BDD220EA739547`.

For u>0 it defines

```
k(u) = (1/(exp u-1) - 1/u + 1/2)/u,
R(z) = integral_(u>0) exp(-z*u) k(u) du,
H(z) = (z-1/2) Log z - z + R(z),
L(z) = H(z)-H(1)                              (Re z > 0).
```

The accepted construction proves on paper that L is the analytic logarithm of Gamma, normalized by L(1)=0 and real on the positive real axis, with `exp L=Gamma`. It uses Bohr–Mollerup and analytic uniqueness, not an unspecified Stirling branch. H(1) is real. The phase here is exactly

`theta(t)=Im L(1/4+i*t/2) - (t/2)log pi`.

This input remains a formalization task, not an already kernel-checked theorem. The present note strengthens its elementary remainder estimate while preserving its normalization. In particular, it never takes the pointwise principal logarithm of Gamma(z).

## 2. Convert the Laplace remainder to a low-degree periodic polynomial

Use the explicit polynomials

```
P2(r) = r^2-r+1/6,
P3(r) = r^3-(3/2)r^2+(1/2)r = r(r-1/2)(r-1).
```

Let `Pjbar(x)=Pj(fract x)` for x>=0. These are bounded, measurable, period-one functions. On [0,1],

```
|P2(r)| <= 1/6,    |P3(r)| <= 1/8,
P3'(r)=3*P2(r),    P3(0)=P3(1)=0.
```

The first bound follows from `P2(r)=(r-1/2)^2-1/12`. The second deliberately crude bound uses `r(1-r)<=1/4` and `|r-1/2|<=1/2`. No tabulated Bernoulli maximum, Fourier series, or cotangent partial fraction is needed. These are precisely B2 and B3, but the proof can use their displayed polynomials directly.

For real u>0 put `J(u)=integral_(x>0) exp(-u*x) P2bar(x) dx`. Direct polynomial integration gives

```
integral_0^1 exp(-u*r) P2(r) dr
 = (1-exp(-u))/(6*u)
   - (1+exp(-u))/u^2 + 2*(1-exp(-u))/u^3.
```

For example an antiderivative is

`-exp(-u*r)*(P2(r)/u + P2'(r)/u^2 + 2/u^3)`.

On [n,n+1] the integral is exp(-u*n) times the unit integral. Summing finitely, applying the finite geometric identity and then taking the limit gives

```
J(u) = 1/(6*u) - (1+exp(-u))/(u^2*(1-exp(-u))) + 2/u^3.
```

All limits are justified by `|P2bar|<=1/6` and positive exponential decay. Algebra using `1+2/(exp u-1)=(1+exp(-u))/(1-exp(-u))` now gives the exact identity

`k(u) = 1/12 - (u/2)*J(u)`.

Fix z with sigma=Re z>0. Substitute this identity in R. Fubini is legitimate, not a formal rearrangement of conditionally convergent integrals: the double-integrand norm is at most

`(1/6)*u*exp(-(sigma+x)*u)`,

whose integral over u,x>0 is `1/(6*sigma)`. Integrate x first to see this immediately. The values at u=0 are immaterial to these open-half-line integrals. The elementary complex moments, for Re w>0, are

```
integral_(u>0) exp(-w*u) du = 1/w,
integral_(u>0) u*exp(-w*u) du = 1/w^2.
```

The second follows by one finite-interval integration by parts and exponential decay; the first is already an improper-integral source theorem. Consequently

`R(z) = 1/(12*z) - (1/2)*integral_(x>0) P2bar(x)/(z+x)^2 dx`.  (1)

This derives the needed first complex Stirling correction directly from the accepted normalized Binet construction. It does not import a separate complex Stirling remainder theorem.

## 3. One cellwise integration by parts and a coarse norm bound

On every [n,n+1], use `P3(x-n)/3` as the antiderivative of P2(x-n). Both endpoint values vanish. Since the derivative of `(z+x)^(-2)` is `-2*(z+x)^(-3)`,

```
integral_n^(n+1) P2bar(x)/(z+x)^2 dx
  = (2/3)*integral_n^(n+1) P3bar(x)/(z+x)^3 dx.
```

Sum to an integer endpoint and let it tend to infinity. Integrability is immediate from sigma>0 and bounds by constants times `(sigma+x)^(-2)` and `(sigma+x)^(-3)`. The periodic-polynomial values at cell boundaries cause no derivative ambiguity, since integration by parts was done on the ordinary polynomial cells. Equation (1) becomes

```
R(z) = 1/(12*z) + E(z),
E(z) = -(1/3)*integral_(x>0) P3bar(x)/(z+x)^3 dx.             (2)
```

Now additionally let y=Im z>0. For 0<=x<=y, `|z+x|>=y`. For x>=y, `|z+x|>=sigma+x>=x`. Thus

```
integral_(x>0) |z+x|^(-3) dx
 <= integral_0^y y^(-3) dx + integral_y^infinity x^(-3) dx
 = 1/y^2 + 1/(2*y^2) = 3/(2*y^2).
```

This split avoids a square-root antiderivative and any numerical integral. From (2) and `|P3bar|<=1/8`,

`|E(z)| <= 1/(16*y^2)`.

At z=1/4+i*t/2 this is the sufficient bound

`|R(z)-1/(12*z)| <= 1/(4*t^2)` for every t>0.              (3)

The bound does not require t>=1500; that threshold is used only when simplifying the phase and consuming the result. A sharper integral or polynomial bound would improve the constant but is unnecessary here.

## 4. Extract the actual normalized phase

Let t>0, u=1/(2*t), q=u^2 and z=1/4+i*t/2. In the right half-plane,

```
Log z = log(t/2) + (1/2)log(1+q) + i*(pi/2-atan u),
Im(1/(12*z)) = -1/(6*t*(1+q)).
```

H(1) has zero imaginary part. Expanding `(z-1/2)Log z-z`, subtracting `(t/2)log pi`, and using (2) gives the exact identity

```
theta(t)-theta0(t)
  = (t/4)log(1+q) + (1/4)atan u - 1/(6*t*(1+q)) + Im E(z).
```

The three leading terms are `1/(16*t)+1/(8*t)-1/(6*t)=1/(48*t)`. Their elementary errors satisfy

```
| (t/4)(log(1+q)-q) | <= 1/(128*t^3),
| (1/4)(atan u-u) |   <= 1/(96*t^3),
| -1/(6*t*(1+q)) + 1/(6*t) | <= 1/(24*t^3).
```

These hold for all t>0. For q>=0, `0<=q-log(1+q)<=q^2/2`, obtained by integrating v/(1+v)<=v. For u>=0, `0<=u-atan u<=u^3/3`, obtained by integrating v^2/(1+v^2)<=v^2. The reciprocal difference is exactly `q/(6*t*(1+q))`. Hence their sum is at most `23/(384*t^3)`. Together with (3), this proves the first displayed phase bound.

For t>=1500,

`1/4 + 23/(384*t) <= 1/4 + 23/(384*1500) < 13/50`,

so the simpler `13/(50*t^2)` bound follows strictly. Also

`1/48 + 13/(50*t) < 1/40`,

because t>=1500>312/5. This gives the weak inequality needed in the shortened K0 analytic argument:

`|theta(t)-theta0(t)| < 1/(40*t) = tau^2/5` when `tau=(8*t)^(-1/2)`.

## 5. Consumer error budget and range

For the principal cosine sum, replacing theta by thetahat changes each cosine by at most `|theta-thetahat|`; this is the real cosine Lipschitz bound. Therefore, whenever the independently proved amplitude bound is `2*sum_(n<=N) n^(-1/2)<80`, the total phase cost is at most

`80*13/(50*t^2) = (104/5)/t^2`.

The selected Gabcke consumer uses this amplitude bound on **1500<=t<=1000000**, with its specified `N=floor sqrt(t/(2*pi))`. The phase theorem itself holds on all t>=1500; this note does not extend the fixed amplitude 80 to arbitrary larger heights.

At the lower endpoint the phase cost is exactly `13/1406250 < 10^(-5)`. This phase bound is independent of the K0 remainder constant. The already pinned primary K0 allowance is `.47*t^(-3/4)`. The separate new shortened route proposes `.45*t^(-3/4)` and was still awaiting review when this note was written; it is not assumed proved here.

**A global comparison using the pinned .47 allowance.** Integral comparison, for N>=1, gives

```
2*sum_(n=1..N) n^(-1/2) <= 4*sqrt(N)-2
  < 4*sqrt(N) <= 4*(t/(2*pi))^(1/4) < 4*t^(1/4).
```

The first inequality separates n=1 and bounds the remaining decreasing sum by the integral from 1 to N. Here N=floor sqrt(t/(2*pi)), and 2*pi>1. Hence the phase substitution error is less than `1.04*t^(-7/4)` for every t>=1500. Relative to t^(-3/4), its coefficient is at most `1.04/1500`. Thus

`.47 + 1.04/1500 = 17651/37500 < .471`.

Combining the pinned analytic K0 allowance and this phase bound therefore yields a `.471*t^(-3/4)` allowance **globally for t>=1500**, before arithmetic enclosure errors. This route needs no improved K0 constant or upper height bound. It can also support a later higher principal spectral cutoff.

**Optional comparison conditional on the new .45 proof.** If that separate shortened K0 argument is accepted, the same global calculation gives `.45+1.04/1500 < .451 < .47`. Alternatively, keeping the earlier finite amplitude 80, adding its phase cost stays below `.47*t^(-3/4)` throughout [1500,1000000]. Indeed t>=1500>=1 gives `t^(5/4)>=t>=1500>1040`, so

```
(104/5)/t^2 < .02*t^(-3/4),
.45 + (104/5)/1500 = 3479/7500 < .47.
```

These are uniform comparisons on their stated ranges, not just endpoint numerical samples. The .45 implications are scalar consequences conditional on that separate proposed analytic improvement; they do not establish it. Arithmetic enclosure errors for the finite sum and correction function must still be included separately. Existing frozen pilot receipts using the sharper phase polynomial are not rewritten or reinterpreted by this new route. A future evaluator using thetahat must recompute its own interval allowances.

## 6. Exact source interfaces and remaining proofs

Mathlib revision `56a005855ea17e0b0958f73ec801ae140b0a1679` was inspected in the existing local cache. Paths here are relative to its Mathlib directory.

| Existing source | What it supplies; new wrapper needed |
| --- | --- |
| `NumberTheory/ZetaValues.lean:47,63,86` | `bernoulliFun`, explicit degree-two polynomial, and `hasDerivAt_bernoulliFun`. The degree-three identity can be proved by polynomial expansion, or use displayed P3 directly. |
| Same file `:71,274,277` | Matching Bernoulli endpoint values and continuous periodization for index !=1. Alternatively direct fractional-part cell arguments suffice for the two explicit polynomials. |
| `MeasureTheory/Integral/IntervalIntegral/IntegrationByParts.lean:110` | `intervalIntegral.integral_mul_deriv_eq_deriv_mul_of_hasDerivAt`, including complex-valued factors. Apply on finite intervals, where every denominator is nonzero because Re z>0. |
| `Analysis/SpecialFunctions/ImproperIntegrals.lean:63,87` | Integrability and integral of `exp(a*x)` on a half-line when Re a<0. Gives the zeroth complex moment; one finite IBP plus exponential decay gives the first moment. |
| Same file `:130,178` | `integrableOn_Ioi_rpow_of_lt` and `integral_Ioi_rpow_of_lt`. The exponent -3 at positive lower endpoint y gives the split-tail value `1/(2*y^2)`. |
| `MeasureTheory/Integral/IntegralEqImproper.lean:658` | `intervalIntegral_tendsto_integral_Ioi`; passes finite geometric/cell calculations to the improper integrals after absolute integrability. |
| `MeasureTheory/Integral/Prod.lean:230,481` | `integrable_prod_iff` and `integral_integral_swap`; the explicit double majorant above discharges absolute integrability for Fubini. |
| Accepted normalized construction, section 2 | `L=H-H(1)`, `exp L=Gamma`, and real H(1), so the phase is the genuine normalized one. This is a reviewed paper construction still requiring Lean terms. |

Small new analytic lemmas, in dependency order, are: polynomial bounds and cell Laplace formula; geometric summation/improper limit; first complex exponential moment; Fubini identity (1); cellwise cubic identity (2); split norm bound (3); elementary phase algebra and FTC inequalities; rational endpoint comparison and cosine error transport. These are ordinary proofs, not new assumptions to add to the final theorem.

There is no need in this route for a global k'' bound, Fourier expansion of the Binet kernel, higher Bernoulli coefficients, complex Stirling constants, or the sharp three-term theta remainder. The separate Gabcke analytic K0 formula/remainder remains a required theorem; this note removes only its sharper Gamma-phase dependency where the displayed weaker contracts suffice.

## 7. Scalar evidence

`coarse_gamma_phase_scalar_20261111.py`, SHA256 `A6C2FA7C888808D266A9A539CAF6205EC19A38034B872BFD46BD373D701018B4`, ran with exit 0. Its receipt `coarse_gamma_phase_scalar_20261111.json`, SHA256 `E7DAED4627D28460B11865A91C634FE5F1E0C07B9806FA04C4A4A17E3A9994FF`, contains 19 exact rational/polynomial checks. They verify the P3 derivative and endpoints, unit Laplace coefficients, constants, leading phase cancellation, and the separately labeled pinned/conditional consumer margins. No floating-point comparison, special-function evaluator, finite zero count, or library native proof oracle is involved.

The scalar script checks algebra and margins. It does not itself prove Fubini, improper integration, branch normalization, or the Gabcke remainder. Those analytic proofs are explicitly supplied as paper derivations and staged above for later formalization.
