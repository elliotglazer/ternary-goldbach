# Modular reduction for the principal differentiated-theta kernel

2026-11-11. Paper feasibility result and source-based implementation plan, submitted for independent review. Modular reduction can replace the raw near-boundary Gaussian series by series with a uniform positive imaginary part. The construction handles first and second derivatives and avoids undecidable equality tests at reduction boundaries. It does not establish an overall runtime bound, produce actual high-height samples, or supply Lean code.

## 1. Exact input and source boundary

The input is the accepted `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, reviewed in `audit/REVIEW_PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2`. Paths here are relative to `work/qrh-campaign/agents/` unless specified otherwise.

That input uses the actual unhalved source xi and the kernel

```
P(w)=sum_(n>=1) (8*pi^2*n^4*exp(9w/2)-12*pi*n^2*exp(5w/2))
                   *exp(-pi*n^2*exp(2w)),     |Im(w)|<pi/4.
```

It proves at paper level that P is even and that `exp(-I*b*(s-1/2))*xiF(s)` is its shifted Fourier integral. This note changes only the pointwise computation of P. Its spatial, quadrature, panel, and zero-order arguments remain separate.

Mathlib source pin remains `56a005855ea17e0b0958f73ec801ae140b0a1679`. The following files were read directly:

| Source | Existing API |
| --- | --- |
| `NumberTheory/ModularForms/JacobiTheta/OneVariable.lean:29,31` | `jacobiTheta` is the classical theta3 series and equals `jacobiTheta₂ 0 tau`. |
| Same file, lines 34,43 | Period 2 and `jacobiTheta_S_smul`, with multiplier `(-I*tau)^(1/2)`. |
| `NumberTheory/ModularForms/JacobiTheta/TwoVariable.lean:46,252` | The two-variable series has term `exp(2*pi*I*n*z+pi*I*n^2*tau)`. Its subscript 2 means two variables, not classical theta2. |
| Same file, lines 294,333 | Joint complex differentiability and differentiability in the tau variable on Im(tau)>0. |
| Same file, lines 380–410 | Periodicity, quasiperiodicity, and `jacobiTheta₂_neg_left`. |
| Same file, line 466 | `jacobiTheta₂_functional_equation`: `Theta(z,tau)=(-I*tau)^(-1/2)*exp(-pi*I*z^2/tau)*Theta(z/tau,-1/tau)`. |
| `Analysis/Complex/UpperHalfPlane/MoebiusAction.lean` | `modular_S_smul`, `modular_T_zpow_smul`, and `im_smul_eq_div_normSq` identify the actual transformations. |

The first two source-file hashes are respectively `7C29B4B07AED2E46D40FE408362F2A707126BFBBF05C3B374420AA0EDDF06B5C` and `CC4E420DA8441AD20DDBE3709040C4CFBEBB530C6DDD8E101FF2FC1F0B6F8820`. These source APIs do not yet package the classical three theta constants, their tau-derivative jets, the reduction algorithm, or its interval error proof.

## 2. Three theta constants and their exact transformations

For Im(tau)>0 define, as mathematical notation rather than new frozen declarations,

```
theta3(tau)=sum_(n in Z) exp(pi*I*n^2*tau),
theta4(tau)=sum_(n in Z) (-1)^n*exp(pi*I*n^2*tau),
theta2(tau)=sum_(n in Z) exp(pi*I*(n+1/2)^2*tau).
```

In source terms these are `jacobiTheta tau`, `jacobiTheta₂ (1/2) tau`, and `exp(pi*I*tau/4)*jacobiTheta₂ (tau/2) tau`, respectively. Absolute local uniform convergence justifies the reindexings and derivatives below.

For every integer n and Im(z)>0,

```
theta2(z+n)=exp(pi*I*n/4)*theta2(z),
(theta3(z+n),theta4(z+n))
 = (theta3(z),theta4(z)) if n is even,
 = (theta4(z),theta3(z)) if n is odd.                         (T)
```

The first identity follows from `(k+1/2)^2=k*(k+1)+1/4`, since k*(k+1) is even. The other two use the parity of k^2. The same factors and permutations apply to every derivative with respect to z, because the shift derivative is one and the multipliers are constant.

For tau in the upper half-plane put `v=-1/tau` and `A(tau)=1/(-I*tau)^(1/2)`, with the source principal square root. Then

```
theta3(tau)=A(tau)*theta3(v),
theta2(tau)=A(tau)*theta4(v),
theta4(tau)=A(tau)*theta2(v).                                (S)
```

The source two-variable functional equation at z=0 proves the first. At z=tau/2, its exponential cancels the prefactor defining theta2, proving the second. At z=1/2, its new argument is `1/(2tau)=-v/2`; evenness in the first argument changes this to v/2, and the exponential is exactly exp(pi*I*v/4), proving the third. No extra root of unity is omitted.

The number `-I*tau` has real part Im(tau)>0. Its principal square root therefore lies in the right half-plane, is nonzero, and varies holomorphically throughout the domain. The algorithm retains this particular local factor at each S step. It does not combine a product of square roots into an unproved global multiplier such as a chosen square root of c*tau+d.

## 3. Derivative jets and recovery of P

Here primes always mean derivatives with respect to tau. If an S identity reads `f(tau)=A(tau)*g(-1/tau)`, its exact first two derivatives are

```
f   = A*g,
f'  = A*(-g/(2*tau)+g'/tau^2),
f'' = A*(3*g/(4*tau^2)-3*g'/tau^3+g''/tau^4).                (J)
```

The g derivatives are evaluated at v and are derivatives in v, not derivatives of the composition. To verify (J), use `A'/A=-1/(2tau)`, `A''/A=3/(4tau^2)`, `v'=1/tau^2`, and `v''=-2/tau^3`. The coefficients of g' in the second derivative sum to -3/tau^3.

Store the transformation word, its actual intermediate points, and the theta-type permutations. Evaluate the required theta jet at the final reduced point, then unwind the word using (T) and (J). If all three types are evaluated, apply the same formulas componentwise with the stated permutations. If only theta3 is wanted, a single changing type suffices. The theta value itself must be retained even though the final P formula uses derivatives: S mixes it into both derivatives.

For `tau=I*exp(2w)`, direct differentiation of the theta series gives

```
P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau)).     (P)
```

Indeed `theta3'=2*pi*I*sum_(n>=1)n^2*exp(pi*I*n^2*tau)` and its second derivative has factor `2*(pi*I)^2`. Inserting tau yields exactly the -12*pi and 8*pi^2 coefficients of the accepted kernel. The theta constant cancels in this final expression, not prematurely in the jet transport.

## 4. Reduction with overlapping certified decisions

The following relaxed reduction was refined jointly with the independent reviewer. It targets a uniform Gaussian convergence domain, not the unique classical fundamental domain.

At each current upper-half-plane point tau:

1. Obtain a rational approximation xhat to Re(tau) with error strictly below 1/10. Choose any nearest integer n to xhat, resolving a rational tie arbitrarily. Set z=tau-n. Then `|Re(z)|<3/5`; certify this strict inequality. Record the T^n identity for later reconstruction.
2. If Im(z)>2/5 is certified, stop.
3. Alternatively, if Im(z)<1/2 is certified, set tau=-1/z, record S, and repeat.

Steps 2 and 3 have an overlap. At every positive imaginary part at least one test is strictly true, including the equality cases Im(z)=2/5 or 1/2. Refining convergent enclosures and testing both conditions therefore eventually selects a valid branch. No exact comparison to a half-integer, unit circle, or rational threshold is required.

When an inversion occurs,

```
|z|^2 < (3/5)^2+(1/2)^2 = 61/100,
Im(-1/z)=Im(z)/|z|^2 > (100/61)*Im(z).                      (R)
```

Translations leave the imaginary part unchanged. If y0>0 is any certified lower bound for the initial imaginary part, choose an integer N with `(100/61)^N*y0>=1/2`. There can be at most N inversions: after N of them the inversion condition is impossible and the stopping condition is true. Each loop contains one translation and one overlapping comparison. The resulting point obeys

```
|Re(tau_red)|<3/5,       Im(tau_red)>2/5.                    (D)
```

This proves termination for computable exact points with convergent certified enclosures. It is stronger than simply relying on the finiteness of a modular orbit below a height. It does not bound the cost of obtaining each enclosure or multiplying large integers.

For the accepted xi parameters, reflect w first so Re(w)>=0. With `b=pi/4-eta`, `eta=1/(T+1)`, the initial point has

```
Im(I*exp(2w))=exp(2Re(w))*cos(2b)
             >=sin(2eta)>=eta=1/(T+1).
```

The last inequality uses 0<2eta<=1 and sin(x)>=x/2 on that interval. Thus a sufficient bound is the least N with `2*100^N >= (T+1)*61^N`. Exact integer arithmetic gives N=27 at T=1000000 and N=35 at T=60343058. Only these two power comparisons were computed for this note. They are bounds on inversion count, not seconds, required digits, or total bit complexity. Larger work heights use the same formula.

## 5. Uniform theta-jet tails in the reduced domain

In (D), let alpha=6/5. Since pi>3, the Gaussian modulus is bounded by exp(-alpha*t^2), independent of the original height. For derivative order j=0,1,2, its term gains the factor `(pi*I*t^2)^j`.

For theta3 and theta4 retain the central term and the pairs 1<=|n|<=N. For theta2 retain pairs with absolute half-integers 1/2,3/2,...,N-1/2. Take N>=1 and u=N+1/2. Define

```
M_0=1,                 M_j=(2*j/alpha)^j for j=1,2.
```

A common bound for each omitted j-th derivative tail is

```
E_(N,j) <= 2*4^j*M_j * exp(-alpha*u^2/2)
                       /(1-exp(-alpha*(2u+1)/2)).          (E)
```

To prove it, split exp(-alpha*t^2) into two halves and bound `t^(2j)*exp(-alpha*t^2/2)<=M_j` by elementary maximization. The remaining tail is bounded using `(u+k)^2>=u^2+(2u+1)*k`. For integer modes, the first omitted mode N+1 exceeds u, so the same estimate applies. Signs in theta4 and complex phases all have modulus one. The n=0 term is 1 for order zero and zero for positive derivative orders; it must not be added to theta2.

The bound tends to zero uniformly in the reduced domain. It replaces the unreduced Gaussian's cutoff dependence on a small Im(tau). The requested reduced-point accuracy can nevertheless depend on the original point through the amplification in (J) and (P).

## 6. Branches, interval propagation, and convergence

Translation phases are exact eighth roots determined by n modulo 8. They can be stored symbolically or enclosed with a certified square root of 2. Their derivatives are zero. At an S step, certify a positive lower bound for Im(tau), hence for |tau|; this protects every reciprocal in (J).

One branch-safe square-root computation uses z=-I*tau, with Re(z)>0:

```
u=sqrt((|z|+Re(z))/2)>0,       v=Im(z)/(2u),
sqrt(z)=u+I*v,                A=1/(u+I*v).
```

Every real square root here has a strictly positive input. This formula does not require deciding the sign of Im(z), and agrees with the source principal square root. It avoids a spurious branch switch when the imaginary part crosses zero.

For exact transport coefficients, reduced jet errors e0,e1,e2 propagate through S as

```
e0_new <= |A|*e0,
e1_new <= |A|*(e0/(2|tau|)+e1/|tau|^2),
e2_new <= |A|*(3e0/(4|tau|^2)+3e1/|tau|^3+e2/|tau|^4).
```

With enclosed coefficients, add their approximation errors multiplied by the corresponding computed jet-center norms, plus arithmetic rounding. This is ordinary deterministic interval matrix multiplication. Translation factors have modulus one; their enclosure and multiplication errors must still be included. After reconstruction, (P) propagates the derivative errors and the errors in tau and exp(w/2).

The exact intermediate tau values are related by the stored transformations. Their numerical errors must be propagated through those same maps; treating rounded points as exact transformed points would invalidate the source identity. At the reduced point, evaluate the series and derivatives on the certified point enclosure, with (E) for the tail and interval elementary functions for the finite terms.

For any fixed point and requested positive absolute error, the reduction word is finite and all its denominators and square-root inputs are nonzero. After certifying the word, refine its input/coefficient enclosures and increase N until the final propagated radius is below the target. Finite composition of continuous operations and the uniform tail bound prove convergence, provided the elementary interval primitives are themselves proved convergent. Cancellation in (P) or the S jets may require more precision but does not defeat absolute convergence. There is no guarantee of a useful relative error at a zero.

For a compact panel, a single word may be used only if its strict branch inequalities and upper-half-plane conditions hold on the entire panel image. Otherwise subdivide or choose local words. Each exact point has a neighborhood on which its successful strict tests remain valid, so compactness gives a finite cover. An effective subdivision proof also needs a computable panel map and certified variation bounds. The already accepted xi panel envelope remains available independently; pointwise modular evaluation does not by itself prove panel nonvanishing.

## 7. What is improved and what remains open

This construction removes a mathematical obstacle to rapid coefficient production: after a finite modular word, all three theta jets have Gaussian tails with the fixed constant alpha=6/5. It uses actual source theta identities and exact local root branches. It also gives a quantitative bound on inversion count for the selected high-height input.

It does not yet prove O(log T) bit complexity or an end-to-end speedup. Those would require bounds for intermediate coefficient sizes, numerical condition numbers, precision amplification, elementary-function costs, and reuse across many Fourier nodes. Large real translations need exact integer arithmetic even though their phase only depends on n modulo 8. Reconstructing derivatives can amplify error through small intermediate |tau|. These costs must be measured or bounded before a production forecast.

The next formal components are the classical theta2/theta4 source adapters; their T identities; the three S identities with principal branches; tau-jet chain rules; the overlapping reduction and termination proof; uniform jet tails; and the interval word-replay theorem ending at (P). The original xi Fourier quadrature, arithmetic, contour, and zero-count certificates remain necessary. No new analytic assumption, actual spectral data, or final theorem premise is introduced by this acceleration plan.
