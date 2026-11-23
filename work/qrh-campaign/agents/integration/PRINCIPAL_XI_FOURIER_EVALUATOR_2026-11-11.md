# A theta Fourier evaluator for the actual principal xi function

2026-11-11. New paper derivation and evaluator plan, submitted for independent review. It covers the closed real-part strip [0.4968,2] at any specified finite height, including the separate conductor-one family height 60343058. No spectral scan, high-height FFT, numerical xi packet, Lean build, or canonical edit was performed.

The result is a convergent arbitrary-precision boundary evaluator with an FFT batching option. The Fourier transform stage has a fast finite algorithm. Direct production of its theta coefficients can still be expensive at high height; no efficient single-point runtime or completed all-height computation is claimed.

## 1. Actual source normalization

Goldbach source is at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`; Mathlib is at `56a005855ea17e0b0958f73ec801ae140b0a1679`. The target is `TernaryGoldbach.Explicit.xiF`, defined in `Explicit/Xi.lean:20` by

```
xiF(s) = s*(s-1)*completedRiemannZeta0(s)+1.
```

This is twice the common xi normalization. Source `xiF_zero` and `xiF_one` give value 1 at 0 and 1. `differentiable_xiF`, `xiF_one_sub`, `xiF_ne_zero_of_one_le_re`, `xiF_ne_zero_of_re_nonpos`, and `xiF_eq_zero_iff` supply entire differentiability, reflection, outer-half-plane nonvanishing, and nontrivial-zeta-zero equivalence. The last equivalence is stated only for 0<Re(s)<1.

Source anchors read for the integral identity are:

| Source | Relevant declaration |
| --- | --- |
| Mathlib `NumberTheory/LSeries/AbstractFuncEq.lean:249,378` | `WeakFEPair.f_modif` subtracts the constant on x>1 and its reflected power on 0<x<1; `Lambda0` is its Mellin transform. The single point x=1 is irrelevant to the integral. |
| Mathlib `NumberTheory/LSeries/HurwitzZetaEven.lean:104,134,165,204` | Equality of the two kernels at zero, theta functional equation, and Gaussian-series formulas. |
| Same file, lines 256,304 | At parameter zero the FE pair has k=1/2, epsilon=1, f0=g0=1; completed even Hurwitz0 is `Lambda0(s/2)/2`. |
| Mathlib `NumberTheory/LSeries/RiemannZeta.lean:64,85` | completedRiemannZeta0 is completed even Hurwitz0 at zero; `completedRiemannZeta = completedRiemannZeta0 - 1/s - 1/(1-s)`. Use this theorem, not a contrary-sign informal summary. |
| Target `Explicit/Xi.lean:31,62` | `xiF_eq` gives `s*GammaR(s)*zetaF(s)` for Re(s)>0 and s!=1; `xiF_eq_zero_iff` transfers zeros in the open critical strip. |

The respective source-file SHA256 values are `9FD5A09427DA6EEE9DF1C1E8A45D4803BE7ED488D4B5924C58F9C3E61249EB07` for AbstractFuncEq, `A55187C4FC35149EB5ACF82C7625849525E60F520D71A3E428FB2272DEFAC814` for HurwitzZetaEven, `DF672932018A87831A240E2FF669C675DA31C75F924D871FBA3D3F8A08FFB210` for RiemannZeta, and `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` for target Xi.

These source facts do not include the packaged differentiated-kernel identity or the evaluator below. Those are new proof obligations, not compiled APIs.

## 2. Removing the theta constant and the apparent poles

Let `psi(x)=sum_(n>=1) exp(-pi*n^2*x)` for positive real x. The complete theta function is `theta(x)=1+2*psi(x)`, and its functional equation is `theta(1/x)=sqrt(x)*theta(x)`.

Splitting the source modified Mellin integral at 1 and substituting x -> 1/x in the lower part gives, for every complex s,

```
completedRiemannZeta0(s)
 = integral_1^infty psi(x)*(x^(s/2)+x^((1-s)/2))*dx/x.        (1)
```

Both ends converge locally uniformly in s after this split. The factors 2 from theta−1 and 1/2 in the completed Hurwitz definition cancel. This proves (1) from the entire source construction without substituting s=0 or 1 into a meromorphic product.

Put z=s−1/2 and, initially for real v, `f(v)=exp(v/2)*psi(exp(2v))`. Theta reflection gives

```
f(-v)=f(v)+sinh(v/2),       f'(0)=-1/4.
```

Define on the complex strip |Im(w)|<pi/4

```
P(w)=2*(f''(w)-f(w)/4)
 = sum_(n>=1) (8*pi^2*n^4*exp(9w/2)-12*pi*n^2*exp(5w/2))
                *exp(-pi*n^2*exp(2w)).                      (2)
```

The Gaussian series and its differentiated series converge normally on compact subsets of this strip, so P is holomorphic there. The reflected sinh term is killed by `D^2−1/4`; hence P(-w)=P(w), first on the real axis and then throughout the strip by analytic continuation.

Twice integrating by parts on v>=0, with `g(v)=exp(zv)+exp(-zv)`, gives

```
integral_0^infty (f''-f/4)*g
 = -2*f'(0)+(z^2-1/4)*integral_0^infty f*g
 = 1/2+s*(s-1)*integral_0^infty f*g.
```

The boundary terms at infinity vanish by Gaussian decay. Substitution x=exp(2v) in (1) now proves the entire identity

```
xiF(s) = integral_R P(v)*exp((s-1/2)*v) dv.                 (3)
```

In particular (3) has no omitted constant or pole term: it equals 1 at s=0 and s=1 by the same calculation. Using only the undifferentiated theta integral and adding 1 numerically would cause severe high-height cancellation. Formula (3) removes that subtraction analytically.

## 3. Shifted evaluation and normalization

Fix a real b with |b|<pi/4. Contour shifting in the w strip, with Gaussian decay on the vertical end segments, proves

```
F_b(s) := exp(-I*b*(s-1/2))*xiF(s)
        = integral_R P(v+I*b)*exp((s-1/2)*v) dv.             (4)
```

The sign matters: for s=sigma+it with t>0 and b>0 the multiplier has modulus exp(b*t). Thus b near pi/4 compensates for the main exponential decay of completed zeta. F_b is entire in s and the multiplier never vanishes, so every zero and its analytic order are unchanged.

Evaluate P(v+I*b) by its positive-real-part Gaussian series when v>=0. For v<0 use the exact identity P(v+I*b)=P(-v-I*b), so no small-argument theta series is summed directly. The identity remains valid for complex values; no critical-line realness or zero simplicity is assumed.

For negative ordinates choose negative b, or prove and use `xiF(conj(s))=conj(xiF(s))` from (3). A single fixed b should be used on each complete contour when directly taking its winding. If different b values are used on segments, their values cannot simply be joined: reconstruct a common normalization, or include the exact correction `xiF'/xiF=F_b'/F_b+I*b` on each segment. For one fixed b the correction integrates to zero around a closed contour.

## 4. An explicit Gaussian envelope

Choose r>0 with |b|+r<pi/4 and a positive rational kappa satisfying

```
kappa <= cos(2*(|b|+r)).
```

Write the following rational constants, all unrelated to the conductor c=1:

```
C=3*kappa,       q=C/2,       z0=3*C/2,
A=(2048/C^2+96/C)*(1+z0)/z0,
M=A/q,          D=A*(1/q+1/q^2).
```

Then for real v and |y|<=|b|+r,

```
|P(v+I*y)| <= A*exp(|v|/2)*exp(-q*exp(2|v|)).              (5)
```

To verify constants, put u=|v| and R=exp(2u). The real part of pi*n^2*exp(2(u+iy)) is at least C*n^2*R, using pi>3. Split that exponential into two halves and use

```
n^4*exp(-C*R*n^2/2) <= 16/(C*R)^2,
n^2*exp(-C*R*n^2/2) <= 2/(C*R),
sum_(n>=1) exp(-C*R*n^2/2)
 <= exp(-C*R/2)/(1-exp(-3*C*R/2)).
```

The last inequality follows from n^2>=1+3(n−1). Finally pi<4, R>=1, and `1/(1-exp(-z0)) <= (1+z0)/z0` prove (5). Evenness gives the negative-v case. These are deliberately coarse bounds.

On sigma in [0.4968,2], `|sigma−1/2|<=3/2`. Therefore

```
integral_R |P(v+I*y)*exp((sigma-1/2)*v)| dv <= M,
integral_(|v|>V) |...| dv <= (A/q)*exp(-q*exp(2V)).         (6)
```

The substitution R=exp(2|v|) proves these bounds; dropping exp(-q)<=1 gives M. These constants do not depend exponentially on the evaluation height.

## 5. Explicit truncation and quadrature

For |t|<=T and sigma in the specified strip, apply the infinite trapezoid rule to `g_s(w)=P(w+I*b)*exp((s-1/2)*w)`. On the two lines Im(w)=+r and −r its absolute integral is at most M*exp(T*r). Consequently, for h>0,

```
|F_b(s)-h*sum_(k in Z) P(k*h+I*b)*exp((s-1/2)*k*h)|
 <= 2*M*exp(T*r)/(exp(2*pi*r/h)-1).                        (7)
```

A proof uses the Fourier coefficients of the periodized function: shift each coefficient to the appropriate line ±r to gain exp(-2*pi*r*|j|/h), then sum the two geometric tails. P and its derivatives have Gaussian decay uniformly on every slightly smaller strip, so the periodization, Fourier identity, and interchange are justified by absolute convergence. This general trapezoid bound and its source instantiation still need formal proofs; it is not an existing checked evaluator theorem.

Truncate to |k|<=K, put V=K*h, and require q*exp(2V)>=1. The real majorant `exp(2u-q*exp(2u))` is then decreasing for u>=V. Comparing the two omitted sums with their integrals gives the discrete spatial-tail bound

```
E_space <= (A/q)*exp(-q*exp(2V)).                           (8)
```

Truncate the Gaussian series (2), using evenness as above, to 1<=n<=N. The same proof as (5) gives

```
|P(w)-P_N(w)|
 <= A*exp(|Re(w)|/2)*exp(-q*(N+1)^2*exp(2|Re(w)|)).
```

Indeed `(N+1+j)^2 >= (N+1)^2+(2N+3)*j`; its denominator is bounded by the same one used in A. A simple bound for the error in the finite sum is therefore

```
E_theta <= h*(2K+1)*A*exp(2V)*exp(-q*(N+1)^2).             (9)
```

This includes the polynomial n^4,n^2 factors in P. It is not merely a tail estimate for the original theta series.

Each retained summand must then be enclosed, with error at most epsilon/(4*h*(2K+1)) if epsilon/4 is reserved for numerical error. This includes pi, b, exponentials, powers and arithmetic. Analytic tails do not certify those numerical enclosures automatically. Correlated uses of pi or b cause no difficulty for deterministic interval bounds.

## 6. Arbitrary finite height and precision

For any real T>=1 choose

```
eta=1/(T+1),  b=pi/4-eta,  r=eta/2,  kappa=eta/2.          (10)
```

Then b>0, |b|+r=pi/4−eta/2, and its cosine is sin(eta)>=eta/2. Thus all preceding bounds apply and T*r<1/2, so exp(T*r)<2. Use negative b for the analogous negative-ordinate computation. Rational T gives rational r,kappa,A,M,D, even though b contains pi and needs enclosure.

For a requested absolute error epsilon>0 in F_b, choose an integer J>=1 with `2^J>1+16*M/epsilon`, then a positive dyadic h<=6*r/J. Since pi>3 and exp(J)>2^J, (7) is less than epsilon/4. Increase integer K until q*exp(2K*h)>=1 and (8)<epsilon/4. Increase N until (9)<epsilon/4. Refine the finitely many elementary-function enclosures until their aggregate error is less than epsilon/4. Each search terminates by its displayed limit and strict inequalities, provided the elementary interval engine is itself proved convergent. That engine is an explicit implementation dependency, not an assumed oracle at the final theorem.

The two relevant example height parameters are:

| T | r=kappa | q |
| --- | --- | --- |
| 1000000 | 1/2000002 | 3/4000004 |
| 60343058 | 1/120686118 | 3/241372236 |

There is no c*T cap. Any extra contour or auxiliary-height margin must be included in T before parameters are selected. For example, numerical Cauchy samples one unit above the required family height need T>=60343059. The separate principal narrow-strip obligation through one million is not replaced by the family-height computation; it uses its own required real boundary and the same evaluator if desired.

These rules ensure arbitrary absolute accuracy in the normalized F_b. They do not ensure relative accuracy at an actual zero or successful nonvanishing tests on a boundary containing a zero.

## 7. Derivatives and whole-panel certificates

Differentiating (4) multiplies its integrand by v^j. Normal convergence on compact s sets justifies every derivative. Since `|v|^j<=j!*exp(|v|)`, (5) gives, throughout the stated real strip,

```
|F_b^(j)(s)| <= j!*D.                                     (11)
```

For an alternative Cauchy proof, the disk |s−s0|<=1 about a point in that strip has `|Re(s)−1/2|<=5/2`. Its integrand is bounded by `A*exp(4|v|)*exp(-q*exp(2|v|))`, whose integral is at most D. Hence Taylor coefficients at s0 have absolute value <=D, and for |s−s0|<=rho<1 the remainder after degree d is bounded by

```
D*rho^(d+1)/(1-rho).                                      (12)
```

The coefficient balls still need actual certified computation, for example differentiated integrals or a certified Cauchy scheme. For differentiated trapezoids, use boundary-integral majorant `j!*exp(r)*D*exp(T*r)` in (7). Their spatial-tail bound is

```
j!*A*exp(-q*exp(2V))*(exp(2V)/q+1/q^2),
```

and their finite theta-error bound may be multiplied by V^j. The displayed spatial expression bounds the continuous tail without a monotonicity threshold. To use it also for the omitted discrete derivative samples, impose the stronger cutoff condition q*exp(2V)>=2: the majorant exp(4u-q*exp(2u)) is then decreasing for u>=V. The undifferentiated estimate (8) still needs only q*exp(2V)>=1. These bounds give the same terminating searches with the appropriate cutoff condition. At j=0 the tighter earlier bounds may be retained.

A simpler first-order panel certificate is already available from (11). If the midpoint ball has radius e and center a, and every point of a straight panel is within distance ell of its midpoint, then `|a|-e>D*ell` proves nonvanishing on that whole panel, provided the segment stays in the real-part strip. If this fails, refine or use (12); do not infer failure or success from a sample alone.

## 8. Fast batching, limits, and zero transfer

At fixed sigma and h,K, put the coefficients `P(kh+I*b)*exp((sigma-1/2)*kh)*exp(I*t0*kh)` into a length-L residue array, with L>=2K+1. The signed indices −K,...,K are distinct modulo L. At ordinates

```
t_l=t0+2*pi*l/(L*h)
```

the finite sums are exactly h*L times the accepted normalized positive DFT outputs. For a power-of-two L, the accepted radix-two algorithm returns this normalized output, so its scale is h*L. The separately reviewed arbitrary-length Bluestein algorithm returns the unnormalized positive DFT, so its scale is h instead. Equivalently, divide its output by L before using the h*L formula. The appropriate prefactor, signed-index permutation, coefficient errors and FFT arithmetic errors must all be included. Only output ordinates inside the chosen |t|<=T range inherit the uniform error estimate. Arbitrary off-grid panel points require direct sums, certified interpolation, or a shifted grid; periodicity of the finite DFT is not periodicity of xi.

This removes repeated direct summation over Fourier nodes for a shared vertical grid. It does not by itself make theta coefficient production cheap. With the choice (10), A,M,D grow polynomially in T, h can be of order `1/(T*(log(T)+log(1/epsilon)))`, and a safe uniform N grows roughly like the square root of `T*(log(T)+log(1/epsilon))`, with additional logarithmic factors from V. The resulting grid and coefficient work may be large at sixty million. Per-node theta cutoffs, reusable exponentials, or a separately proved modular-theta acceleration could reduce that work; no such optimization or production benchmark is supplied here. The fixed-b, unshifted formula is convergent too, but would require exponentially finer absolute error to resolve high-height values.

On 0<Re(s)<1, source `xiF_eq` and `zetaF_of_ne` express xiF as zeta times `s*(s-1)*GammaR(s)`, a holomorphic nonzero factor. Thus zero orders, not only zero locations, agree there. Proving the local analytic-order transport is still necessary. Outside this strip the source already proves xiF nonvanishing. At 0 and 1 its value is 1, so neither a zeta pole nor a spurious pole-cancellation zero is counted. Multiplication by the entire nonzero factor in (4) preserves all these orders.

A zero-free-boundary rectangle for one fixed F_b therefore has the same winding and enclosed zero multiplicities as xiF. Restricting its counted zeros to the nontrivial strip gives the desired zeta count. Rectangles crossing Re(s)=1 do not count a zeta pole, because the counted function is xiF. The separate source normalization and order proof, whole-panel enclosures, winding certificate, and inclusive-height containment remain mandatory. No RH, critical-line realness, simplicity, or completeness follows from this evaluator alone.

The accepted finite arithmetic input is `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md`, SHA `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E`, reviewed at `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D`. Its general butterfly proof is reused, not its fixed numerical Gaussian ledger. The arbitrary-length input is `integration/ARBITRARY_LENGTH_CHARACTER_DFT_2026-11-11.md`, SHA `FFF8C45E75DA6EF89D13E657C0E7C05713F861FCF7FFE47E87497C7ED624F5F1`, independently reviewed at `7DFADC932B61242CB39C8F840948ACCE8BED43A6F01D58860805A19B691BCA37`. All new theta differentiation, shifted contour, trapezoid, error and zero-order adapters above remain paper arguments awaiting independent review and Lean implementation.
