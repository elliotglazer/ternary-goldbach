# Independent review of the K0 Gaussian moment bounds

2026-11-11. Verdict: PASS as a paper derivation of the four stated closed-domain bounds and the first-correction normalization, using the separately reviewed Mordell identities. I found no blocking analytic or normalization defect. This does not establish a Lean theorem, the original saddle representation, the full Riemann-Siegel formula, or the K0 remainder estimate.

The producer is `mellin/K0_GAUSSIAN_MOMENT_PROOF_PLAN_2026-11-11.md`, SHA256 `A3BD9C855E57DD70D828E093E83E760B2832AD4B8E6E00CED608629A087CE97A`. Paths in this report are relative to `work/qrh-campaign/agents/`. No producer or frozen file was changed. No build, numerical experiment, or scan was run.

## Inputs checked

I read the complete producer note, the corresponding formulas in `major-constants/GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md`, and the relevant parts of the Mordell derivation. Its integral representations have the precise constants needed here:

- `moebius/MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md`, SHA256 `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050`.
- `independent-feasibility/REVIEW_MORDELL_SPECIAL_CASES_2026-11-11.md`, SHA256 `4046A11E67FC3090D09ABA87270D3895355974B49163C397341EE1F0E2EE6A92`, which accepts those identities as reconstructed paper proofs.

I also checked the local primary text of the corrected Gabcke thesis on printed pp35–36 and 85–86. It agrees with the derivative integral and the low-order moment estimates. The correction footnote on p85 explicitly includes the closed q endpoints. The primary PDF pin is `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. This source comparison supplements the independent calculations below; it is not a replacement for them.

## Fixed definitions and hyperbolic estimates

Keep epsilon=exp(i*pi/4), kinematic contour v=epsilon*u with u increasing, and the epsilon Jacobian in the integral. On this fixed contour the denominator is never zero. For real x,

```
H(x) = |cosh(epsilon*x)|^2
     = (cosh(sqrt(2)*x)+cos(sqrt(2)*x))/2
     = sum_(j>=0) (sqrt(2)*x)^(4*j)/(4*j)! >= 1.
```

For real |a|<=1, each nonnegative series term at ax is at most the corresponding term at x. Therefore H(ax)<=H(x). Also

```
|sinh(epsilon*a*x)|^2 = H(ax)-cos(sqrt(2)*a*x)
                     <= H(x)+1 <= 2*H(x).
```

Division by H(x)>0 gives the cosh-ratio bound 1 and the sinh-ratio bound sqrt(2). The identities follow directly from the real and imaginary parts of cosh and sinh. They include x=0, negative x, and a=+/-1. Conjugation preserves their norms, so the same estimates hold for conjugate epsilon. There is no trigonometric approximation in these inequalities.

## Parameter differentiation and the two representations

The accepted Mordell representation has prefactor `sqrt(2)*exp(i*pi/8)` and conjugate epsilon in the cosh ratio. Conjugating it for real q gives the representation for the real F with prefactor `sqrt(2)*exp(-i*pi/8)` and epsilon. Keeping these opposite prefactor signs is correct. At z=+/-1/2, F means the analytic continuation of the quotient; the value is 1/2. Totalized division at zero is not the intended function.

On the complex disk |z|<=2, the k-th parameter derivative of the Gaussian/cosh integrand, for k<=3, is bounded by

```
(pi*v)^k exp(-pi*v^2/2 + 2*pi*v), v>=0.
```

Indeed the denominator's norm is at least 1, the numerator is either cosh or sinh at a complex argument of norm at most 2*pi*v, and either norm is at most exp(2*pi*v). Completing the square gives an integrable polynomial times a translated Gaussian. This is a neighborhood majorant around the whole real interval [-1,1], so the derivative statements do not fail at its endpoints. The same argument on arbitrary compact disks provides holomorphy of the integral representation. The real-part map commutes with the integral and real differentiation.

For the fixed-contour moments b_m, on a complex q disk |q|<=M the product is bounded by

```
exp(M^2/2) (|u|+M)^m exp(-u^2/2 + M*|u|)
```

apart from the fixed factor 1/(2*sqrt(pi)). The factor exp(M^2/2) bounds the complex prefactor exp(-i*q^2/2); the Gaussian comes from i*(epsilon*u)^2/2=-u^2/2. Further q derivatives introduce only polynomial factors. Thus each b_m is entire and continuous at both q endpoints. This supplies continuity without an assumed pole-indentation convention.

## The B0 and third-derivative bounds

For real |q|<=sqrt(pi), apply the cosh-ratio estimate with a=q/sqrt(pi). The Mordell representation gives

```
|B0(q)| <= sqrt(2) integral_0^infinity exp(-pi*v^2/2) dv = 1.
```

This argument covers the two q endpoints directly. It does not use the later moment estimate, which requires m>=1.

Three real differentiations of the F representation introduce `(pi*epsilon*v)^3` and a sinh numerator. For real |z|<=1, its norm is bounded by

```
sqrt(2)*sqrt(2)*pi^3 integral_0^infinity v^3 exp(-pi*v^2/2) dv.
```

The last integral equals 2/pi^2, by the substitution r=pi*v^2/2. The result is exactly `|F'''(z)|<=4*pi`. The argument is valid at both interval endpoints and at the removable quotient points. It proves the absolute-value bound, not merely an upper bound on the signed derivative.

## Shifted moments and both endpoints

For real |q|<sqrt(pi), shift the fixed line to v=i*q+epsilon*u. The denominator poles are precisely `i*(2*j+1)*sqrt(pi)`. The strip between these parallel lines meets the imaginary axis only at intercepts between 0 and q, so it contains no pole. This also handles q<0 by reversing the finite contour orientation.

For the connector v=epsilon*R+i*r, with r between 0 and q, the real Gaussian exponent is at most `-R^2/2+C*|R|`. The denominator has norm at least `|sinh(sqrt(pi)*R/(2*sqrt(2)))|` by the cosh norm identity. The connector length is bounded, and the numerator's remaining factor is polynomial in R. Thus both connector integrals tend to zero. The contour equality is justified by a finite pole-free deformation followed by these limits, rather than by an unspecified infinite contour shift.

Direct substitution yields

```
i*v^2/2 + q*v = i*q^2/2 - u^2/2,
v-i*q = epsilon*u,
dv = epsilon*du.
```

The q-dependent constant cancels the prefactor exactly. With c=sqrt(pi)/(2*sqrt(2)), the shifted denominator satisfies

```
|cosh(sqrt(pi)*(i*q+epsilon*u)/2)|^2
  = sinh(c*u)^2 + cos(sqrt(pi)*q/2+c*u)^2
  >= sinh(c*u)^2.
```

Since |sinh(c*u)|>=c*|u|, for u!=0 and m>=1 the quotient is at most `2*sqrt(2)/sqrt(pi)*|u|^(m-1)`. Multiplication by the prefactor gives

```
|b_m(q)| <= sqrt(2)/pi integral_R |u|^(m-1) exp(-u^2/2) du.
```

For m=1 and m=3, the Gaussian moments both equal sqrt(2*pi). The second equality follows by integration by parts with vanishing boundary term. Hence each requested moment has bound 2/sqrt(pi), with no factor-of-two loss from integrating over the full real line.

The fixed-contour continuity already extends these inequalities to q=+/-sqrt(pi). To obtain the shifted integral formula itself at an endpoint, the same majorant works uniformly as q approaches it from the interior. Pointwise convergence holds for u!=0. At u=0 the denominator has a simple zero and the numerator vanishes to order m, so the quotient has a removable singularity. Its single-point value has no effect on the real integral. Dominated convergence is therefore valid for m=1 and m=3. It must not be reused for m=0, whose corresponding |u|^(-1) bound is nonintegrable. The author does not make that invalid extension.

## Derivative and correction normalization

Multiplying the fixed-contour definition of Ftilde(q+x) by exp(i*x^2/2) cancels its quadratic x term in the exterior exponential. Its remaining factor under the integral is exactly exp(x*(v-i*q)). The local Gaussian domination justifies taking its first and third derivatives at x=0. They give

```
b1 = Ftilde',
b3 = Ftilde''' + 3*i*Ftilde'.
```

The sign is positive because the generating factor is exp(+i*x^2/2). Thus P1(w)=w^3/3-i*w gives `B1=b3/3-i*b1=Ftilde'''/3`. Triangle inequality gives

```
|B1| <= 8/(3*sqrt(pi)) < 8/5.
```

For the strict comparison, pi>3>25/9 suffices. Separately, `Re Ftilde(q)=F(q/sqrt(pi))` gives

```
Re B1(q) = F'''(q/sqrt(pi))/(3*pi^(3/2)),
|Re B1(q)| <= 4/(3*sqrt(pi)).
```

Multiplying by tau=1/(4*a*sqrt(pi)) yields the coefficient `F'''/(12*pi^2*a)`. After the common a^(-1/2) saddle factor is extracted, this is exactly the claimed C1 normalization. The stronger real-part estimate and the weaker modulus estimate are distinct; the note keeps their uses separate.

## Scope of acceptance and remaining work

No substantive correction is requested. The accepted paper conclusions are `|B0|<=1`, `|b1|,|b3|<=2/sqrt(pi)`, and `|F'''|<=4*pi` on their full stated closed real domains, plus the derivative and first-correction identities above. They depend on the precise entire Ftilde/Mordell representations already reviewed at pin 4046A11E... .

The fixed-contour argument establishes these moments and their continuous endpoint values. Identifying them with every convention in the original indented saddle formula remains part of the separate saddle representation proof. In particular the m>=1 endpoint cancellation is not a proof that one may discard an indentation for the m=0 saddle integrand. The complete saddle identity, Gamma phase, variation-of-constants remainder, and four-range estimates are outside this review.

Lean work still includes explicit affine contour definitions, finite deformation and connector-limit arguments, the hyperbolic norm lemmas, dominated parameter differentiation on neighborhoods, removable-value adapters, Gaussian moment evaluations, and the exact substitutions between Ftilde, F, and B1. The presence of familiar library ingredients does not mean these adapters have been implemented or kernel-checked. The four bounds alone do not establish a numerical K0 remainder theorem.
