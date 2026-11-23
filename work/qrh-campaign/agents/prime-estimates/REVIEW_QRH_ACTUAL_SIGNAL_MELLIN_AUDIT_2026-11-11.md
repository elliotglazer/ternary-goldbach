# Independent review of actual Hecke signal and Mellin recovery

2026-11-11. **PASS for the conditional analytic producer.** No mathematical correction is requested. I independently reconstructed the actual reciprocal estimate, contour shift, local and zero-end regularity, and Mellin recovery before reading the completed report. The report accurately preserves the separate detector inputs and the unfinished provider-validation requirements.

Author file: `zero-sum/QRH_ACTUAL_SIGNAL_MELLIN_AUDIT_2026-11-11.md`, SHA256 `BA06296484D1CC08BE3DA9AE4E5BEF064A2B03C39B1CA69912C8A8DF75A1F395`. Agent paths are relative to `work/qrh-campaign/agents/`. I matched all eleven source hashes in its table and the prior detector report hash `B28B9982BEAD587411C9FC10F5D61C06A03073E59B3701F85B8B328C6CF48ABC`. That prior report explicitly leaves this signal analysis open, so the new report covers a distinct input rather than repeating the final contradiction.

OAI source is under `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, revision `4eaee87548250b2682affda7d05d947c05554bae`. No Lean build, source modification or analytic evaluation was performed.

## Exact object and noncircular right-half-plane control

The target in `Hecke/Signal.lean:237` applies to the defined signal, not an arbitrary function chosen to have the needed Mellin transform. Its inputs include the actual Hecke character, H holomorphic on Re(s)>7/8, the contraction bound there, and a separate growth estimate `signal = O(x^(a+c))` with a<2. It has no primitivity or nonprincipal restriction.

Write Q=H*reciprocal and A=exp((s-5/6)^2)*Q. For Re(s)>1, reciprocal differentiability follows from the source supremum bound beta<=1. The latter uses only Euler-region nonvanishing and the half sentinel. Nothing here needs beta<=7/8. For Re(s)>=2 the inverse ideal Dirichlet series gives the uniform bound

`|Q(s)| <= (3/2) * sum_I |fullIdealWeight(2,I)|`.

I checked the summability path in `IdealEuler.lean:38–117`. Both series are absolutely summable before their product is rearranged over ideal multiplication fibers. The zero-ideal fiber is zero; the remaining Möbius fiber sum gives the unit ideal. The dominating full-ideal sum is genuinely summable by `QuadraticSieve/DyadicColumns.lean:209`, using injective ideal generators and the lattice exponent -2 Re(s)<-2. Thus a totalized divergent sum is not being used as a finite bound. The underlying lattice and ideal-generator results remain lower inputs, as the report says.

For a principal character the definition of reciprocal removes the pole by `(s-1)/regularizedL`. It equals the usual inverse away from zero and one and is zero at one. The report does not turn this last value into a nonzero-amplitude assertion.

## Contour, endpoint and continuity checks

Unfolding the inverse Mellin transform at -2 and replacing y by -y gives the actual signal formula

`f(x) = (1/(2*pi)) * integral_y x^(2+i*y+c) A(2+i*y)`

for x>0. Both the sign and the absence of an additional factor i are correct. Powers can be combined because the real base is positive.

On the strip 2<=u<=B, where B>=2 and 0<x<=1, the norm of the integrand is at most

`x^(2+c) * exp((B-5/6)^2) * C_Q * exp(-y^2)`.

The x-power comparison uses the reversed exponent monotonicity for bases at most one; the Gaussian real factor increases because u>=2. The report correctly fixes B,x,c before using this uniform strip bound.

`ContinuationContour` first applies the closed-rectangle Cauchy theorem, with the two vertical integrals multiplied by i. Integrable vertical restrictions have convergent symmetric truncations. The horizontal integrals tend to zero under the Gaussian majorant, including the lower edge by reflection. Cancelling i yields the two full vertical integrals. The B=2 boundary is allowed. No contour crosses the principal pole or the unproved zero-free region.

At the right endpoint the improved bound is `C_B*x^(B+c)`. Choosing B=max(2,R-c) gives the requested `O(x^R)` for each R at zero. The constant depends on R and c; the report does not assert a common constant for all exponents.

Independently, the integrable line function A(2-2*pi*i*y) has a continuous inverse Fourier transform. Its composition with -log(x), multiplied by x^(c+2), is continuous for x>0. This supplies local integrability without the top-end growth input. No value or regularity at x=0 is needed.

## The second Fourier-integrability premise is supplied

This is the principal logical check. Integrability of the amplitude alone would not justify the pointwise inverse-transform identity used later.

The top bound with a<2, local integrability and arbitrarily strong decay at zero give Mellin convergence at -(2+c). The inequalities agree with `mellinConvergent_of_isBigO_rpow`: the top convergence exponent is strict, and the zero-end exponent can be chosen one unit beyond the requested Mellin exponent.

For a general real Mellin line sigma, the substitution x=exp(-u) has absolute Jacobian exp(-u). It turns Mellin convergence of v into integrability of

`g(u) = exp(-sigma*u) * v(exp(-u))`.

The exact inverse Mellin representation gives g=FourierInv(F_sigma). Consequently the reflected g is integrable and equals Fourier(F_sigma). The source therefore has both integrability of F_sigma and of its Fourier transform before it applies Fourier inversion. Continuity of F_sigma supplies pointwise equality at every y, not merely almost-everywhere equality.

Applying this with v=x^(-c)f, sigma=-2 and the reflected amplitude gives precisely the line `2-2*pi*i*y`. I checked `ContinuationInversion.mellin_normalizedSignal` and `signalMellin_eq_on_line`; their power and sign conversions agree with `signalMellin(f,c)(s)=mellin(f)(-(s+c))`.

## Caller and foundational limits

I checked `Hecke/SignalIdentity.nonzero_of_probe_bounds` and `Hecke/CommonProbe.PrimitiveContract`. The former chooses a=beta-continuationMargin, obtains a<2 from beta<=1 and positive margin, and obtains the top bound from both the probe bound and the approximation error. It does not derive that bound from the contour formula. The actual H, its analytic/contraction properties, and the probe estimates remain detector obligations.

The numerator exp((s-5/6)^2)H(s) is nonzero under the contraction bound. This is distinct from asserting the reciprocal is nonzero at a hypothetical zero or at the principal pole. The report keeps that distinction and does not reprove the outer analytic-continuation contradiction.

The auxiliary Mathlib source checks used the cache at revision `56a005855ea17e0b0958f73ec801ae140b0a1679`, not the provider manifest's revision `d13f23b723b8a846827a245b89c10fc7d3f11612`. The inspected entries and pins are:

| Mathlib file and entry | SHA256 |
|---|---|
| `Analysis/MellinInversion.lean`, `mellin_eq_fourier`:49, `mellinInv_eq_fourierInv`:72 | `D1D0BB9AC3A6D0F3D431C6F3886E2B6A0A84A2EFBF6A243AFEF7CA87219B9673` |
| `Analysis/MellinTransform.lean`, `mellinConvergent_of_isBigO_rpow`:277 | `5E7D9902133DA1210CFC9BA447EE2178C3224AD2ACE8EEBEBCA43243232DE38D` |
| `Analysis/Fourier/Inversion.lean`, `Integrable.fourier_fourierInv_eq`:184 | `BDEEE6C8A15F85BEDF4221091BBCCDFF3F53BD746DFEC8A17C9353FFF1A9D7D1` |
| `Analysis/Complex/CauchyIntegral.lean`, closed-rectangle theorem:292 | `2E0F2F6115C4BF7BE921A92774C63681A9282C60EF51CD8D31D4D0823DFF464A` |

This is a source and mathematical review of a conditional producer. Compatible elaboration, transitive standard-axiom validation, the lower Hecke and lattice facts, the actual detector estimates and the final finite spectral/Goldbach certificates remain separate requirements.
