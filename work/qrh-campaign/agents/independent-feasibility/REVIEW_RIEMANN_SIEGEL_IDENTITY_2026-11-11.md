# Independent review of the exact Riemann–Siegel identity

2026-11-11. **PASS as a reconstructed paper proof of the completed integral identity, its critical-line finite-sum form, and the exact saddle substitution with the stated endpoint detour.** I found no mathematical defect in the frozen note. In particular, the proof supplies the Fubini majorant, Gamma-ray branch factor, origin detour, and analytic-continuation domain rather than treating Gabcke 4.1.6 as a black-box premise.

This verdict is not a Lean theorem or a Riemann–Siegel error estimate. It relies on the previously reviewed special Mordell proof and ordinary Gaussian/Gamma/complex-analysis prerequisites. Their formal implementations and the subsequent K0 error analysis remain open.

## Frozen evidence and scope of checking

All paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `moebius/RIEMANN_SIEGEL_IDENTITY_PROOF_PLAN_2026-11-11.md` | `724FB84B60B9E3CFD178486BD52950A00709DC0D2CB7AA56C3E4193C426234E5` |
| Upstream `moebius/MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md` | `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050` |
| Its independent review | `4046A11E67FC3090D09ABA87270D3895355974B49163C397341EE1F0E2EE6A92` |
| `mellin/gabcke_1979_corrected_2015.pdf` | `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53` |

The upstream and PDF pins were checked in the preceding special-case review. I read the complete new note, checked its hash, inspected primary text on pp66–68 and pp9–12, and visually inspected retained primary pages 67 and 11 in addition to the preceding review's page 66. The [corrected primary thesis](https://d-nb.info/1072293277/34) agrees with the final identity and the endpoint side conventions.

The new exact bookkeeping script `independent-feasibility/review_riemann_siegel_bookkeeping_20261111.py` has SHA256 `45DC015EE35B6CA048F24A747F2162625E367F8D1AAFDA68B024C5E282973106`; its JSON has SHA256 `AC8CCCF4D1A1E20990DF6BDCBBD1746591E3F416CD24C893D60513F59B0DDA54`. All 24 rational coefficient/phase/orientation checks pass. They corroborate elementary bookkeeping only; the analytic verification below is a paper argument, not something established by the script.

No producer/frozen artifact, Lean file, build state, or dependency was changed. No numerical scan, Gamma/zeta evaluation, or finite zero data was used.

## Four contours and parameter convergence

The note's L contour runs southwest to northeast, and K runs southeast to northwest. A uses the reverse of L; B uses the reverse of K. I preserved these four orientations throughout. Both lines cross the real axis at c in `(0,1)`, so neither meets an integer pole or the nonpositive-real principal-log cut.

The quadratic exponents have Gaussian real parts, respectively `-pi*v^2-sqrt(2)*pi*c*v` and `-pi*v^2+sqrt(2)*pi*c*v`. The reciprocal denominator decays on the tails and is bounded on the central compact segment. On compact s sets, principal powers and their s derivatives grow at most polynomially in `|v|`: Arg is bounded, the line stays away from zero, and logarithmic factors can be absorbed by a larger polynomial. This proves absolute integrability and entire dependence of A and B on s.

Finite horizontal connectors have bounded length and Gaussian decay uniform over their bounded real intercepts. The strips used for contour independence meet the real axis only at positive intercepts between successive integers; hence they avoid the logarithm cut. These observations justify all infinite-line shifts by finite contours followed by limits, with crossed residues retained. Here N in a finite residue sum is a nonnegative integer.

## Actual double-integral bound and Gamma ray

At `u=1/2+epsilon*v` and `z=eta*y`, with `epsilon=exp(i*pi/4)` and `eta=exp(3*i*pi/4)`, the product `epsilon*eta=-1`. Thus the v*y term in `2*pi*i*z*u` is purely imaginary and its real part is `-pi*y/sqrt(2)`.

Also `|D(1/2+epsilon*v)|=2*|cos(pi*epsilon*v)|>=2`. Indeed `|cos(a+i*a)|^2=cos(a)^2+sinh(a)^2>=1`; expansion of `cosh(2a)+cos(2a)` has only nonnegative powers of degree divisible by four beyond its constant 2. Since s is initially real, the ray's power has modulus `y^(s-1)`. The displayed majorant

`(1/2)*exp(-pi*v^2-pi*v/sqrt(2))*y^(s-1)*exp(-pi*y/sqrt(2))`

is therefore correct and is a product of integrable functions for s>0. The separate right-hand terms require s>1 at the origin. Restricting the initial proof to `1<s<2` satisfies both and avoids the later denominator zeros.

The Laplace transform for positive real lambda follows from the real Gamma integral. Both sides are holomorphic on `Re(lambda)>0`, with derivative majorants `y^(s-1+k)*exp(-delta*y)` on compact subsets. Identity on the positive real axis gives the complex-lambda formula by analytic uniqueness; no infinite contour rotation is assumed.

For the actual u line, `lambda=2*pi*epsilon*u` has constant real part `pi/sqrt(2)>0`. More precisely `-3*pi/4<Arg(u)<pi/4`, so adding pi/4 lands strictly in the principal right-half-plane argument range. Consequently

`Log(lambda)=log(2*pi)+Log(u)+i*pi/4`

holds without a winding integer. The ray power and Jacobian supply `exp(3*pi*i*s/4)`; lambda's power supplies `exp(-pi*i*s/4)`. The net factor is exactly `C(s)=exp(pi*i*s/2)*(2*pi)^(-s)*Gamma(s)`. Reversing L to the A convention gives `-C(s)*A(s)`.

## Both ray terms and the origin

On the upper ray, the geometric expansion of `exp(i*pi*z)/D(z)` has the required minus sign and starts at n=1. Tonelli bounds the integral of absolute values by `Gamma(s)/(sqrt(2)*pi)^s * sum(n^(-s))`, finite for real s>1. Hence the first term is `-C(s)*zeta(s)` using the defining convergent series, with no zero-location premise.

For the second term, near zero `D(z)/z` tends to `2*pi*i`, while the power contributes `|z|^(s-1)`. Thus the integrand is `O(|z|^(s-2))`. A slit-disk detour has integral `O(rho^(s-1))`, tending to zero for the chosen s. At infinity the connector bound is uniform for intercepts in `[0,c]`. Removing the small disk leaves a pole-free, cut-free deformation region. Taking the infinity limit first and the origin limit second is legitimate.

On the positive eta ray, `Log(-z)=Log(z)-i*pi`. The inward opposite half-ray contributes `-exp(-i*pi*(s-1))=exp(-i*pi*s)` times the outward ray, including both denominator oddness and orientation. Therefore `J=(1+exp(-i*pi*s))*I_minus` and `I_minus=-B/(1+exp(-i*pi*s))`. This proves the branch factor, rather than deducing it from parity alone.

The denominator is nonzero on `1<s<2`. The author's restriction corrects the source's unqualified intermediate division for real s>1, where odd integers would be exceptional. No assertion at those exceptional values is needed before continuation.

## Gamma algebra and continuation

Combining signs gives `C*zeta=C*A+B/(1+exp(-i*pi*s))`. Multiplication by `exp(-i*pi*s/2)` produces `1/(2*cos(pi*s/2))`. Reflection at `(1-s)/2` and duplication give exactly the factors in equations (13)–(14); on `1<s<2` all involved Gamma values are finite and nonzero. Cancelling the common factor yields

`Gamma_R(s)*zeta(s)=Gamma_R(s)*A(s)+Gamma_R(1-s)*B(s)`.

The pinned Mathlib Gamma source includes `Complex.Gamma_mul_Gamma_one_sub` and `Complex.Gamma_mul_Gamma_add_half` in `Analysis/SpecialFunctions/Gamma/Beta.lean`, so these are available analytic ingredients rather than additional special Mordell assumptions. Application still needs the stated nonzero-factor and principal-real-base power bookkeeping.

For the selected consumer, the difference of the two sides is holomorphic on the connected punctured strip `0<Re(s)<2`, `s!=1`. Its vanishing on `(1,2)` supplies an accumulation point inside that domain. Analytic uniqueness therefore reaches the entire critical line. This avoids interpreting totalized pole values. The optional global extension across the discrete possible poles is correctly stated as meromorphic-germ equality; it is not required for the consumer.

On the critical line, conjugation sends the A contour to K and contributes a minus from D; reversal gives precisely B, since `-conj(s)=s-1`. The normalized Gamma log supplies the actual phase, so `Gamma_R(s)/|Gamma_R(s)|=exp(i*theta)`. The completed identity then gives `Z=2*Re(exp(-i*theta)*B)`. A modulus-only Gamma equality would not suffice, and the note does not use one.

## Finite shifts, saddle substitution, and integer endpoints

For the northwest-to-southeast B contour, a rightward connector makes the finite shift polygon counterclockwise. At a positive integer n the quotient of numerator and denominator signs is `(-1)^(n^2-n)=1`, since n(n-1) is even. Thus each residue contributes exactly `n^(s-1)`, giving the main finite sum with the displayed sign. The transformed cosine is `cos(theta-t*log(n))/sqrt(n)`.

The point `a=sqrt(t/(2*pi))` is the chosen nearby saddle location; the argument does not assume it is the exact stationary point of the full exponent. Moving the line through a inside `(N,N+1)` is an exact contour deformation, not an asymptotic approximation.

At integer a=N>=1, the northeast semicircle has angle decreasing from `3*pi/4` to `-pi/4`. It crosses the real axis to the right of a and keeps the pole on the right of the oriented path. Its singular contribution is `-i*pi*Res`; the holomorphic remainder contributes a vanishing arc integral. Therefore the residual equals principal value **minus** that half-residue, as stated. A bare principal value is not interchangeable with it.

For a completely explicit finite deformation, one may first choose rho smaller than both the displayed radius cap and half the initial intercept displacement, then use an annular-sector Cauchy deformation to compare other permitted radii. This makes the pole-free homotopy transparent even if a larger drawn arc intersects the initial straight line. It does not change the claimed identity or require a producer correction.

Because a is positive, `Log(u)=log(a)+Log(1+(u-a)/a)` preserves the principal branch exactly. Expanding the quadratic and using `pi*a^2=t/2` proves equation (19). The substitution `u=N+1/2+i*v/(2*sqrt(pi))` gives `u-a=i*(v-i*q)/(2*sqrt(pi))`; its quadratic exponent is `i*v^2/2+q*v-i*q^2/2`. The integer signs and `du/(i*sin(pi*u))` contribute a minus, cancelled by reversal of the v path. This proves the prefactor of equation (21).

With `a=1/(4*sqrt(pi)*tau)`, the transformed logarithm is `Log(1+2*i*tau*w)`, its linear exponent is `w/(4*tau)`, and its quadratic exponent is `-i*w^2/4`. Its cut is exactly `w=i*r`, `r>=1/(2*tau)`. The contour avoids it because the original u contour avoids the nonpositive real axis and `u=a*(1+2*i*tau*w)`.

At the integer endpoint, the affine map rotates the u arc by `-pi/2`; subsequent path reversal changes its angular increment from `-pi` to `+pi`. The final arc is southeast of the pole, crosses the imaginary axis below it, and leaves the pole on the left of the southwest-to-northeast path. This matches the primary pp9–12 convention. The sign `(-1)^(N-1)` is correctly interpreted over integers, including N=0.

## Remaining obligations

No unresolved analytic gap was found within the supplied paper proof of the exact identities. Closure at that level rests on the accepted special Mordell derivation and ordinary real Gamma, holomorphic uniqueness, finite Cauchy/residue, and normalized-phase results. It does not rely on a cited full Riemann–Siegel identity as an assumption.

Formal work remains for the affine line integrals, dominated differentiation, product/series interchanges, finite-to-infinite contour limits, origin and pole detours, Gamma branches, conjugation/HardyZ adapter, analytic continuation, and exact substitutions. The script's scalar checks are not replacements for these proofs.

The later variation-of-constants deformation, its four-range estimates, coefficient/moment estimates, quantitative Gamma phase, and any K0 error theorem are outside this verdict. No new sign chain, finite zero certificate, or Goldbach closure follows from this identity alone.
