# Independent review of the first-order remainder and coefficient-contour join

2026-11-11. **PASS as a combined paper proof**, using the two separately pinned notes below. The variation-of-constants argument, four range estimates, endpoint cancellation, Gaussian moments, and frozen-tail bounds establish

`|S-B0-tau*B1| < (21/5)*tau^2`, `tau=(8*t)^(-1/2)`, for every real `t>=1500` and every actual saddle parameter `-sqrt(pi)<q<=sqrt(pi)`.

The residual has the stated continuous extension to the excluded lower endpoint. This is not a new unindented definition of S at that pole. The bound has no upper height cutoff and no q-dependent constant.

The original K1 note alone consumes a coefficient-contour join it does not prove. The separate supplement closes that interface and is essential to this combined verdict. Earlier scalar Y checks alone would not establish the result. No Lean theorem, completed K0 error theorem, or numerical zero certificate is claimed.

## Frozen evidence

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `major-constants/K1_REMAINDER_PROOF_PLAN_2026-11-11.md` | `0008EECFA0408799E48B506A04F97BEF41EB55FE75D5A138CDF105F415CE107F` |
| `major-constants/K0_COEFFICIENT_CONTOUR_JOIN_2026-11-11.md` | `B484CC05689773705AC91AE6D3938FE6D605AF850404106845A4E7CC0B8816D1` |
| `independent-feasibility/review_k1_remainder_algebra_20261111.py` | `D8D166E34FC2C7C919A9DD8407FA2107D9CA3E8BE600A9FCE3593B8E3C65223A` |
| Its JSON | `903F04D2E431F4FF101D1408C70A37852E4C94018646FC7BD8B302F5F53AE625` |

I read both full notes and checked their hashes. I also read the fixed-coefficient definitions in `mellin/K0_GAUSSIAN_MOMENT_PROOF_PLAN_2026-11-11.md`, pinned `A3BD9C855E57DD70D828E093E83E760B2832AD4B8E6E00CED608629A087CE97A`. The exact saddle source is the separately reviewed `moebius/RIEMANN_SIEGEL_IDENTITY_PROOF_PLAN_2026-11-11.md`, pinned `724FB84B60B9E3CFD178486BD52950A00709DC0D2CB7AA56C3E4193C426234E5`; its independent review is pinned `FA2C974BF1199A2C1888B9096BC20AB2F656AB25763A46A743894069B931F16A`.

Primary comparison used the text of Gabcke 3.1.1–3.1.3 on printed pp41–51 and the retained image of p48 in the [corrected thesis](https://d-nb.info/1072293277/34), PDF SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. The new argument reconstructs the specialized analytic estimates; it does not cite the general remainder theorem as an assumed bound.

All 33 independent exact polynomial/rational checks passed in one run. They include the defect polynomial, G derivative cancellations, f antiderivative, W derivative factorization, Gaussian decay constants, both incomplete-Gamma domains, and final margins. The script uses no floating acceptance or special-function call. These checks corroborate algebra; the analytic verification is given below. No author receipt was rerun or overwritten, and no Lean/build/dependency/frozen-source action occurred.

## Defect and variation of constants

The slit `Omega_tau` is the exact preimage of the principal-log slit under `z ->1+2*i*tau*z`. It is star-shaped about zero: a permitted point's radial segment cannot first meet the removed positive imaginary ray. The displayed G derivative simplifies to `tau*(z^2-i)/(1+2*i*tau*z)`. In particular g is an exponential and is nonzero on the domain.

I independently checked

`P1=z^3/3-i*z`, `P2=z^6/18-(5*i/6)*z^4-(3/2)*z^2`,

`P2'=(z^2-i)*P1-2*i*z*P1'`.

For `R=g-1-tau*P1`, this gives exactly the inhomogeneous defect equation with right side `tau^2*P2'`. Also `R(0)=R'(0)=0`. Integrating the derivative of R/g along the compact radial segment proves equation (2). The exponential quotient is obtained from the explicitly analytic G, not from a presumed global principal log of g. Every denominator on that segment is nonzero. This is a complete specialized FTC argument, with no general ODE existence result left as an unexplained step.

At `z=epsilon*u`, the prefactor is `i*u/(epsilon-2*tau*u*r)` and the exponent has the stated minus sign. The exact modulus calculation follows by taking the real part of the reciprocal and integrating its logarithmic term. Combining that term with the reciprocal's modulus leaves quarter-powers of both positive brackets, precisely as in equation (4). There is no lost square-root factor. At u=0 the proof uses R(0)=0 separately; it does not divide by x=0.

## Exponent bounds on all four ranges

For `x<0`, both bracket factors are at least 2, so the multiplier prefactor is at most 1. For x>=0 it is at most sqrt(2). The extrema in the r variable give `phi<=f(x)`, `phi<=0`, and `phi<=f(x)-f(1)` in the three indicated x ranges.

For r>0, `f(-r)` is the integral of `v^2*(v+1)/(1+(v+1)^2)`. This integrand is below v and at most `v^2/2`, giving `f(-r)<r^2/2` and `f(-r)<=r^3/6`. If r<=1/4, the latter is at most `r^2/24`. Thus the new small-negative exponent is `u^2/48`, without the source's auxiliary omega/arctangent bound.

On the positive side, differentiation confirms the stated antiderivative and

`W'(x)=-(3/25)*x*(x-7/3)*(x-8)/(1+(x-1)^2)`.

The monotonicity intervals show that W on `[1,infinity)` is bounded above by the larger of W(1) and W(8). They are both negative; the endpoint estimate using `atan(1/7)<1/7` and `pi>157/50` gives `W(8)<-34/175`. This is an all-range calculus proof, not a sampled maximum. It implies the positive-tail exponent `7*u^2/25`.

Finally, integrating the absolute coefficient bounds for P2' gives exactly

`V(u)=(3/2)*u^2+(5/6)*u^4+(1/18)*u^6`.

The resulting bounds (8) have the correct non-strict form, including the vanishing endpoint u=0. After multiplication by the residual Gaussian, the four decay exponents are respectively `1/4`, `23/48`, `1/2`, and `11/50`. All are positive. The replacement `23/48>17/36` in the middle negative range is in the correct direction.

## The coefficient join: why the supplement is needed

The moment note defines B0 and B1 on the fixed diagonal L0. Its endpoint dominated-convergence argument applies to powers m>=1; it does not remove B0's endpoint pole. Accordingly, K1 section 6 was initially conditional on transporting these fixed coefficients to the source contour. The new join supplement supplies that transport directly.

For an interior q, the finite parallelogram between L0 and Lq has no denominator pole. The only possible poles lie on the imaginary axis at odd multiples of `i*sqrt(pi)`. Along its vertical closing edges the numerator is bounded by a degree-three polynomial times `exp(-R^2/2+p*|R|/sqrt(2))`, while the denominator is bounded below by `sinh(p*|R|/(2*sqrt(2)))`. These are uniform bounds over each entire connector. Their lengths are bounded, so both vanish as R tends to infinity.

At q=p=sqrt(pi), use the specified southeast arc of radius `rho<p/4`, angle increasing from `-3*pi/4` to `pi/4`. Rotation by conjugate(epsilon) turns the geometry into a lower semicircular notch in the upper boundary of a horizontal strip. The notch excludes the endpoint pole and stays strictly above L0. No other pole lies in the region. The same finite Cauchy/connector proof therefore equates the fixed P0/P1 integrals with their indented integrals for each fixed rho. There is no logarithmic cut in these polynomial coefficient kernels. The supplement does not deform the g kernel from L0, which would require a different branch argument.

The explicit endpoint check is correct and decisive. The normalized B0 residue is `exp(-3*pi*i/8)/pi`; the positive pi angle contributes `exp(i*pi/8)`. The symmetric straight principal value vanishes by oddness. Thus `B0(p)=exp(i*pi/8)` comes entirely from the arc in that decomposition. Dropping the arc before subtraction would lose a nonzero term. P1 has a removable quotient, with the stated unnormalized value `-2*i/p`.

The source S integral and both coefficients can now be subtracted on this same indented contour. Choose rho additionally below `1/(4*tau)` to stay away from g's shifted log cut. Only then does the double zero of R make the residual quotient `O(|v-ip|)`. Its arc is `O(rho^2)` and vanishes. No residue or half-residue remains in the residual. This resolves the previously conditional join at paper level without altering the frozen K1 note.

## Residual integral, uniform q, and endpoints

The substitution `v=iq+epsilon*u` has positive epsilon Jacobian and exponent `i*q^2/2-u^2/2`; the prefactor's q phase cancels exactly. The denominator norm is at least `sinh(c*|u|)>=c*|u|`, where `c=sqrt(2*pi)/4`.

For u!=0, this gives the uniform q majorant. Near zero `V(u)/|u|=O(|u|)`; at infinity the worst surviving Gaussian is `exp(-11*u^2/50)`. At u=0 use the removable residual value zero, or discard that single point for integration. For every nonzero u the integrand is continuous in q and its denominator never vanishes. Dominated convergence therefore gives the claimed continuous residual extension at both q endpoints. It does not assert that the singular B0 or S straight integral exists there without its contour prescription.

On the actual domain `-p<q<=p`, the straight residual is exactly `S-B0-tau*B1`, by the newly proved join. At q=-p the result is only the specified continuous residual extension. This distinction is preserved throughout the verdict.

## Gaussian integrals, tails, and all-height uniformity

The middle-range constants retain all prefactors: `1/(2*sqrt(pi)*c)=sqrt(2)/pi`, with another sqrt(2) on the positive range. Substituting `v=w*u^2` gives the odd Gaussian moments, producing the exact rational upper bounds

`Y2=9787500/5399387<1.82`, `Y3=3250/1413<2.31`.

The incomplete-Gamma bound is valid on its stated domain `a>=1`, `X>a`. Integration by parts yields `Gamma(a,X)<=exp(-X)*X^(a-1)+(a-1)*Gamma(a,X)/X`. The rearrangement has positive denominator, and `X/(X-a+1)<=a` follows from `(a-1)*(X-a)>=0`. The boundary at infinity vanishes by exponential domination. Actual uses have `a=3/2,5/2,7/2`, with `X=1500/64` or 330, both strictly above every such a.

The two tail substitutions give exactly equations (14)–(15), including the positive-range sqrt(2) and denominator `2*b=.44`. Freezing at T=1500 is legitimate for every t>=T: first bound the original tail by its positive surrogate, then enlarge that surrogate's integration interval and replace sinh by its lower endpoint value. No assertion about R on the artificially added interval is needed. The factor tau^2 remains the actual parameter's factor; it is not replaced by tau(T)^2.

The discarded denominators are genuinely greater than one, and the stated positive exponential-series lower bounds suffice. The independent exact upper bounds are `Y1=11/150000<.001` and `Y4=1096875/68719476736<.001`. Consequently the coarse total is below `4.132*tau^2`, hence strictly below `4.2*tau^2`. Every margin is uniform for all t>=1500; none uses a finite height sample or an upper cutoff.

## Remaining scope

No unresolved mathematical gap remains in the combined specialized K1 estimate and coefficient join at paper-proof level. The exact saddle identity, definitions and moment estimates, normalized phase, and later K0 assembly remain separate reviewed components; this verdict does not silently approve all of them.

Formal proof work remains for the holomorphic defect and segment FTC, real-part integration, elementary f/W calculus, finite notched-contour Cauchy identity, removable factors and arc limits, uniform integral domination, Gaussian substitutions, incomplete-Gamma integration by parts, and rational assembly. The complete Lean proof and proof-producing interval checker are not supplied by these notes or by the 33 scalar checks.
