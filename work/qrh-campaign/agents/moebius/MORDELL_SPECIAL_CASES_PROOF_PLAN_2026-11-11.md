# The three Mordell identities needed by the Gabcke K0 route

2026-11-11. This note gives a paper derivation of the special identities at parameters 1, 1/2, and 2, using a Gaussian integral and one finite contour shift. It does not assume Gabcke's cited general rational-parameter identity. The contour-limit and orientation calculations are supplied below. No Lean theorem, numerical certificate, or full Riemann–Siegel representation is claimed. No build, dependency change, or frozen-source edit was made.

## Source and scope correction

The primary source is Wolfgang Gabcke, *Neue Herleitung und explizite Restabschätzung der Riemann-Siegel-Formel*, corrected 2015 edition, <https://d-nb.info/1072293277/34>. The local PDF is `agents/mellin/gabcke_1979_corrected_2015.pdf`, SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. Printed pages 61 and 66 were rendered and visually checked in this task. The text of pp62–64 was also checked.

Gabcke 4.1.1, p61, defines the integral below and cites Chandrasekharan for its general rational evaluation. The actual specializations used by the K0 blueprint are:

| Parameter | Source use |
|---|---|
| 1 | 4.1.6, p66, with x=z+1/2, to start the Riemann–Siegel integral derivation. |
| 1/2 | 4.1.3, pp63–64, with x=z/2+1/4, for the Gaussian/cosh representation. |
| 2 | 4.1.2, pp62–63, with x=1/2−2p, for the original contour definition of Ftilde. |

Thus the earlier statement that only parameters 1 and 1/2 are needed omitted a source dependency. Parameter 2 is proved here by the same two relations. No general rational case, Gauss sum, modular transformation, or reciprocal-parameter theorem is required.

## 1. Definition, convergence, and Gaussian normalization

Fix a **positive real** tau. Put epsilon=exp(i*pi/4)=(1+i)/sqrt(2). For 0<c<1, let L_c be the straight line

    u=c+epsilon*t,  -infinity<t<infinity,

oriented southwest to northeast. Define the contour integral by the real parameter integral, including du=epsilon*dt:

\[
 \Phi_\tau(x)=\int_{L_c}
 \frac{\exp(i\pi\tau u^2+2\pi i x u)}{\exp(2\pi i u)-1}\,du.
\]

All the following assertions hold for every complex x. They do not assert the corresponding result for arbitrary complex tau.

Here is one bound that covers both convergence and all later closing edges. Let |x|<=M, let u=b+epsilon*t with real |b|<=B, and let R=|t|>=1. Then

\[
 \left|e^{i\pi\tau u^2+2\pi ixu}\right|
 \le \exp[-\pi\tau R^2+(\sqrt2\pi\tau B+2\pi M)R+2\pi MB].                 \tag{1}
\]

Indeed, Re(i*pi*tau*u^2)=−pi*tau*t^2−sqrt(2)*pi*tau*b*t, and |u|<=B+|t|. On the upper endpoint, Im(u)=R/sqrt(2), so

    |exp(2*pi*i*u)−1| >= 1−exp(−sqrt(2)*pi*R) > 1/2.

On the lower endpoint, its modulus is at least exp(sqrt(2)*pi*R)−1>1. The reciprocal denominator is therefore at most 2 on either endpoint. These estimates hold uniformly as b varies in any fixed bounded interval. On a compact central segment of L_c the denominator is nonzero, since its only zeros are real integers and L_c meets the real axis at the noninteger c.

Consequently the integral converges absolutely. The same estimates, multiplied by any fixed power of |u|, dominate its x derivatives locally uniformly. Differentiation under the integral proves that Phi_tau is entire in x.

The same finite-parallelogram argument as in section 3, with no enclosed integers, proves independence of c within (0,1). Its horizontal connectors have bounded length and satisfy (1), so their integrals tend to zero. Thus c=1/2 can be chosen throughout.

Define the entire Gaussian integral

\[
 G_\tau(x)=\int_{L_c}e^{i\pi\tau u^2+2\pi ixu}\,du
 =\tau^{-1/2}e^{i\pi/4-i\pi x^2/\tau}.                              \tag{2}
\]

The square root of tau in this formula is the **positive real** square root. To prove (2), substitute u=c+epsilon*t. The quadratic coefficient becomes −pi*tau and the linear coefficient is b=2*pi*i*epsilon*(tau*c+x). Apply

\[
 \int_\mathbb R e^{-a t^2+b t}\,dt
 =\sqrt{\pi/a}\,e^{b^2/(4a)},\qquad a>0,\ b\in\mathbb C.
\]

For completeness, this complex-linear Gaussian identity follows from the real Gaussian integral and real translation when b is real. Both sides are entire in b by a locally uniform Gaussian majorant, so the identity principle extends it to every complex b. The factors depending on c cancel exactly. The Jacobian epsilon supplies exp(i*pi/4). This avoids an unproved infinite Gaussian contour rotation.

There is no Log, complex power, or slit plane in the definition of Phi, in (1), or in (2). The only branch choice in this section is the positive real square root. The principal powers in Gabcke 4.1.6 are a later analytic dependency, not an implicit convention in this calculation.

## 2. A parameter shift that removes the denominator

Absolute convergence permits subtraction under the integral. Since

    [exp(2*pi*i*u)−1] / [exp(2*pi*i*u)−1] = 1

on L_c, equation (2) gives

\[
 \boxed{\Phi_\tau(x+1)-\Phi_\tau(x)=G_\tau(x).}                       \tag{3}
\]

No contour moves in this step.

## 3. A contour shift across one pole, with its sign

Write f_x(u) for the integrand of Phi_tau. For R>=1 take the polygon with successive vertices

    c−epsilon*R, c+epsilon*R, c+1+epsilon*R, c+1−epsilon*R.

It is traversed **clockwise**: its first edge runs northeast and its second edge runs east. Its interior contains exactly the integer pole u=1. No other integer lies between the real intercepts c and c+1; the edges do not pass through an integer.

The residue is

\[
 \operatorname{Res}_{u=1}f_x(u)=
 \frac{e^{i\pi\tau+2\pi ix}}{2\pi i}.
\]

The finite residue theorem therefore gives the original upward segment minus the translated upward segment, plus the two connectors, equal to −exp(i*pi*tau+2*pi*i*x). Both connectors have length 1. In (1) use B=c+1 and a local bound M on |x|. Their integrals tend to zero because exp(−pi*tau*R^2+C*R+C') tends to zero. Taking the limit yields

\[
 \int_{L_c}f_x-\int_{L_{c+1}}f_x=-e^{i\pi\tau+2\pi ix}.              \tag{4}
\]

Substitution u=v+1 in the second integral preserves orientation and gives

\[
 \int_{L_{c+1}}f_x(u)\,du
 =e^{i\pi\tau+2\pi ix}\Phi_\tau(x+\tau).
\]

Hence the second relation is

\[
 \boxed{\Phi_\tau(x+\tau)
 =e^{-i\pi\tau-2\pi ix}\Phi_\tau(x)+1.}                            \tag{5}
\]

The plus 1 is forced by the clockwise orientation in (4). Changing it would give the wrong special formulas.

Equations (3) and (5) have now been derived without the cited rational Mordell identity. The only contour theorem needed is the finite residue theorem for one simple pole, or equivalently Cauchy's theorem after subtracting the displayed principal part.

## 4. The three finite algebraic eliminations

All quotients below are first asserted when their denominators are nonzero. The corresponding denominator-multiplied identities hold for **every** complex x by (3) and (5). Since Phi_tau is entire, every excluded denominator zero has a removable quotient singularity. No undefined quotient at a zero is used in a consumer.

### Parameter 1

Equation (5) says Phi_1(x+1)=−exp(−2*pi*i*x)*Phi_1(x)+1. Comparing with (3) gives

\[
 \boxed{\Phi_1(x)=
 \frac{e^{2\pi ix}[1-e^{i\pi/4-i\pi x^2}]}{1+e^{2\pi ix}}.}         \tag{6}
\]

The everywhere-valid identity is

    (1+exp(−2*pi*i*x))*Phi_1(x) = 1−G_1(x).

### Parameter 1/2

Apply (5) twice:

\[
 \Phi_{1/2}(x+1)
 =e^{-4\pi ix}\Phi_{1/2}(x)+i e^{-2\pi ix}+1.
\]

Subtract Phi_{1/2}(x) and use (3). Multiplication by −exp(2*pi*i*x) gives

\[
 \boxed{\Phi_{1/2}(x)=
 \frac{i+e^{2\pi ix}-\sqrt2\,e^{i\pi(1/4+2x-2x^2)}}
 {e^{2\pi ix}-e^{-2\pi ix}}.}                                     \tag{7}
\]

This is exactly the formula used on Gabcke p63.

### Parameter 2

Apply (3) twice and (5) once:

\[
 \Phi_2(x+2)=\Phi_2(x)+G_2(x)+G_2(x+1)
            =e^{-2\pi ix}\Phi_2(x)+1.
\]

Thus

\[
 \boxed{\Phi_2(x)=
 \frac{G_2(x)+G_2(x+1)-1}{e^{-2\pi ix}-1},\qquad
 G_2(x)=2^{-1/2}e^{i\pi/4-i\pi x^2/2}.}                            \tag{8}
\]

Equivalently, this is the m=2,n=1 instance of Gabcke 4.1.1. That comparison is a source check, not a premise of the derivation.

## 5. Exact parameter-1 kernel for 4.1.6

Put x=z+1/2 in (6), and absorb exp(pi*i*u) from the numerator into the denominator. Direct algebra gives

\[
 \boxed{\int_{L_c}\frac{e^{i\pi u^2+2\pi izu}}
 {e^{i\pi u}-e^{-i\pi u}}\,du
 =\frac{e^{i\pi z}-e^{-i\pi z^2}}{e^{i\pi z}-e^{-i\pi z}}.}         \tag{9}
\]

This matches the displayed identity on printed p66, including the asymmetric numerator. Its right side is interpreted by removable extension at integer z. Its left side is entire in z by the same Gaussian domination.

This proves the starting kernel of 4.1.6 only. Multiplication by z^(s−1), ray integration, absolute Fubini, Gamma ray evaluation, and continuation in s remain separate proof tasks. In particular the later ray has arg(z)=3*pi/4, and the principal power is exp((s−1)*Log(z)) on the plane cut along the nonpositive real axis. No assertion about its branch factor follows merely from (9).

## 6. Parameter 2 and the original Ftilde contour

Start with real p and x=1/2−2p. Then

\[
 I(p):=\Phi_2(1/2-2p)
 =\int_{L_c}\frac{e^{2\pi iu^2-4\pi ipu}}
 {e^{i\pi u}-e^{-i\pi u}}\,du.
\]

Complex conjugation changes the denominator's sign. Define K_c to be the line of slope −1 crossing c, **oriented southeast to northwest**, the reverse of the complex conjugate of L_c. The sign from that reversal cancels the denominator sign, so

\[
 \overline{I(p)}=
 \int_{K_c}\frac{e^{-2\pi iu^2+4\pi ipu}}
 {e^{i\pi u}-e^{-i\pi u}}\,du.                                   \tag{10}
\]

In particular it would be incorrect to keep the northwest-to-southeast conjugate path and also omit the minus sign.

For real q put p=(1−q/sqrt(pi))/2 and substitute

    u=(1+i*v/sqrt(pi))/2.

The slope −1 path K_c becomes a slope +1 path for v, oriented southwest to northeast. Its imaginary-axis intercept is i*sqrt(pi)*(1−2c), strictly between −i*sqrt(pi) and i*sqrt(pi). Also

\[
 \frac{du}{e^{i\pi u}-e^{-i\pi u}}
 =\frac{dv}{4\sqrt\pi\cosh(\sqrt\pi v/2)}.
\]

The full constant and linear exponents give

\[
 2e^{i\pi(1/8-2p^2)}\overline{I(p)}
 =\frac{e^{i\pi/8-iq^2/2}}{2\sqrt\pi}
   \int\frac{e^{iv^2/2+qv}}{\cosh(\sqrt\pi v/2)}\,dv
 =:\widetilde F(q).                                                \tag{11}
\]

For an explicit check of the constant, before multiplication the substituted exponent is i*pi*(2p−1/2)+q*v+i*v^2/2. Adding i*pi*(1/8−2p^2) leaves i*pi/8−i*q^2/2. This verifies the prefactor and the orientation in Gabcke 4.1.2.

For clarity, the elementary reduction of (8) can be recorded before conjugation as

\[
 2e^{-i\pi(1/8-2p^2)}I(p)
 =\frac{e^{2\pi i(p^2-p-1/16)}
       +2^{-1/2}(e^{i\pi p}-e^{-i\pi p})}{\cos(2\pi p)}.            \tag{12}
\]

Conjugate (12), substitute p=(1−q/sqrt(pi))/2, and use

    cos(2*pi*p)=−cos(sqrt(pi)*q),
    2*pi*(p^2−p−1/16)=q^2/2−5*pi/8,
    sin(pi*p)=cos(sqrt(pi)*q/2).

Equations (11) and (12) give

\[
 \boxed{\widetilde F(q)=
 \frac{\cos(q^2/2+3\pi/8)
  +i[\sqrt2\cos(\sqrt\pi q/2)-\sin(q^2/2+3\pi/8)]}
 {\cos(\sqrt\pi q)}.}                                             \tag{13}
\]

Initially this proves (13) for real q away from the displayed zeros. The contour integral in (11) is entire in complex q by local Gaussian domination. Apply the identity principle to (13) after multiplication by cos(sqrt(pi)*q). This proves the identity for all complex q and gives its removable values. This argument does not treat conjugation as holomorphic in q.

The allowed contour family in (11) is also independent of its imaginary intercept. This follows either from the bijection with the pole-free c interval in (10), or from the same finite-strip estimate. One can fix its intercept at 0; no endpoint pole is encountered in this Mordell identity.

## 7. Parameter 1/2 and the Gaussian/cosh representation

Set x=z/2+1/4 in (7). Elementary exponent algebra, with the same removable interpretation, gives

\[
 i\sqrt2\,e^{-i\pi z/2}\Phi_{1/2}(z/2+1/4)
 =\frac{\cos[\pi(z^2+3/4)/2]
   +i[\sqrt2\cos(\pi z/2)-\sin[\pi(z^2+3/4)/2]]}{\cos(\pi z)}
 =\widetilde F(\sqrt\pi z).                                       \tag{14}
\]

For the integral on the left choose c=1/2 and put u=1/2+epsilon*v. Its exact value is

\[
 \frac{e^{i\pi/8}}{\sqrt2}
 \int_{\mathbb R}\frac{e^{-\pi v^2/2+i\pi z\epsilon v}}
 {\cos(\pi\epsilon v)}\,dv.                                      \tag{15}
\]

The factor exp(i*pi/8) includes the Jacobian epsilon. Omitting that Jacobian changes it to exp(−i*pi/8), which is incorrect. Pair the positive and negative halves of the absolutely convergent integral. Since cos(epsilon*w)=cosh(exp(−i*pi/4)*w), this yields

\[
 \boxed{\widetilde F(q)=\sqrt2\,e^{i\pi/8}
  \int_0^\infty e^{-\pi v^2/2}
  \frac{\cosh(\sqrt\pi q e^{-i\pi/4}v)}
       {\cosh(\pi e^{-i\pi/4}v)}\,dv.}                             \tag{16}
\]

This is Gabcke 4.1.3. For real q, taking the real part in (13) gives the real F used in the K0 blueprint. Conjugating (16) for real q gives the equivalent convention in 4.1.4. Neither equality requires a general Mordell transformation.

## 8. What has been supplied and what remains

The paper derivation above supplies absolute convergence and local parameter domination, the exact Gaussian constant, both shift relations, their finite-polygon residue sign, the closing-edge limits, all three required rational specializations, the removable quotient interpretation, and the two Ftilde representations with their conjugation and Jacobian factors. There is no unresolved contour limit or logarithmic branch factor **within these special identities**.

The proof remains unimplemented and needs independent review before the campaign treats this source leaf as closed. It does not prove the complete Riemann–Siegel identity or the K0 error bound. In particular it does not settle the later Gamma-ray branch factor, the saddle contour's endpoint indentation, the variation-of-constants deformation, the four-range remainder estimates, or the normalized Gamma-phase remainder.

A finite Lean proof ledger is:

1. Define Phi_tau by the explicit real-line parameter integral. Prove the Gaussian majorants in (1), integrability, and dominated parameter differentiation.
2. Prove (2) from the real Gaussian integral and analytic uniqueness. Preserve the explicit epsilon Jacobian and positive real tau square root.
3. Prove independence of c and the finite clockwise one-pole relation (4), using affine parameterizations of the polygon edges and the displayed bounds before taking limits.
4. Derive (3), (5), then the three denominator-multiplied identities. Use those identities instead of totalized division at exceptional x.
5. Prove (9) by exact algebra. Keep subsequent powers and Gamma integrals in separate declarations.
6. Prove conjugation of the absolutely convergent parameter integral, including the reversal in (10), then the substitution and constant calculation (11).
7. Prove (12)–(14) by complex exponential algebra and analytic uniqueness after clearing denominators. Finally prove (15)–(16) by affine substitution and splitting the real line.

The existing ingredients listed in the K0 blueprint remain sufficient as library primitives: Gaussian integration, dominated parameter differentiation, finite Cauchy/residue integration after affine substitution, and analytic uniqueness. The sloping-line integral wrappers and their quantitative majorants are new glue. This note does not claim that a ready-made Mathlib Mordell theorem exists.
