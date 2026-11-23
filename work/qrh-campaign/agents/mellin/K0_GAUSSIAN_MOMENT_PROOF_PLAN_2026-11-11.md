# Low-order Gaussian bounds for the Gabcke K0 argument

2026-11-11. This is a paper proof of the four requested bounds, with the exact contour identities supplied by the separate Mordell note stated explicitly. It is not a Lean theorem or a proof of the full Riemann–Siegel representation. No build, numerical scan, canonical edit, or frozen-file edit was made.

## Inputs and source conventions

The primary source is Wolfgang Gabcke, *Neue Herleitung und explizite Restabschätzung der Riemann-Siegel-Formel*, corrected 2015 edition, <https://d-nb.info/1072293277/34>. The local PDF `gabcke_1979_corrected_2015.pdf` has SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. The source passages checked are equations (1.26)–(1.28), Satz 2.3.1 and its proof on pp35–36, Satz 4.1.3–4.1.4 on pp63–64, Satz 4.4.1 on pp80–81, and the proof of Satz 4.4.4 on pp85–86. The latter's correction footnote expressly includes both closed endpoints.

The input notes read were:

* `major-constants/GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md`, SHA256 `8A65614DA19778FBA1CB08440183FCE49D52B9BCCD9F7B552EA535234C1DD713`.
* `moebius/MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md`, SHA256 `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050`, under independent review when this note was written.

Write epsilon = exp(i*pi/4) = (1+i)/sqrt(2). Let L0 be v=epsilon*u, oriented from southwest to northeast, with u increasing over the real line. Define

\[
 b_m(q)=\frac{e^{i\pi/8-iq^2/2}}{2\sqrt\pi}
 \int_{L_0}\frac{e^{iv^2/2+qv}(v-iq)^m}{\cosh(\sqrt\pi v/2)}\,dv.
 \tag{1}
\]

In particular B0=b0=Ftilde. The source's sloping contour may be shifted to L0 for real |q|<sqrt(pi). The Mordell note supplies the equality with the entire function

\[
 \widetilde F(q)=\sqrt2 e^{i\pi/8}
 \int_0^\infty e^{-\pi v^2/2}
 \frac{\cosh(\sqrt\pi q\bar\epsilon v)}
      {\cosh(\pi\bar\epsilon v)}\,dv.                 \tag{2}
\]

It also supplies Re Ftilde(sqrt(pi)*z)=F(z) for real z, where

\[
 F(z)=\frac{\cos(\pi(z^2+3/4)/2)}{\cos(\pi z)}
\]

is interpreted by its analytic continuation at z=+/-1/2. Thus the values there are 1/2, not the value of totalized division. Conjugating (2) gives

\[
 F(z)=\sqrt2\operatorname{Re}\left[e^{-i\pi/8}
 \int_0^\infty e^{-\pi v^2/2}
 \frac{\cosh(\pi z\epsilon v)}{\cosh(\pi\epsilon v)}\,dv\right].
 \tag{3}
\]

The signs of the two prefactors are opposite because (3) is obtained by conjugation. In (1), dv includes the positive epsilon Jacobian. Neither formula uses the different complex F normalization in FLINT.

## Elementary hyperbolic inequalities

For real x,y, direct expansion of cosh(x+iy) gives

\[
 |\cosh(x+iy)|^2=\sinh^2x+\cos^2y
  =\tfrac12(\cosh 2x+\cos 2y),
\quad
 |\sinh(x+iy)|^2=\tfrac12(\cosh 2x-\cos 2y).        \tag{4}
\]

Consequently, for real x,

\[
 H(x):=|\cosh(\epsilon x)|^2
   =\sum_{k=0}^\infty\frac{(\sqrt2 x)^{4k}}{(4k)!}\ge1. \tag{5}
\]

The power series is absolutely convergent. If a is real and |a|<=1, termwise comparison gives H(ax)<=H(x). Also

\[
 |\sinh(\epsilon ax)|^2=H(ax)-\cos(\sqrt2 ax)
 \le H(x)+1\le2H(x).
\]

Since H(x)>=1, the denominators never vanish, and

\[
 \left|\frac{\cosh(\epsilon ax)}{\cosh(\epsilon x)}\right|\le1,
 \qquad
 \left|\frac{\sinh(\epsilon ax)}{\cosh(\epsilon x)}\right|\le\sqrt2.
 \tag{6}
\]

Conjugation gives the same inequalities with epsilon replaced by its conjugate. These proofs include a=+/-1 and x=0. No numerical trigonometric bound is used.

## Domination and differentiation

All parameter differentiations below are justified on a neighborhood of the closed interval, rather than only at its interior. For |z|<=2, the absolute value of the k-th z derivative of the integrand in (3), k=0,1,2,3, is bounded by

\[
 (\pi v)^k\exp(-\pi v^2/2+2\pi v),\qquad v\ge0.       \tag{7}
\]

Indeed the denominator has norm at least 1 by (5), while both cosh(w) and sinh(w) have norm at most exp(|w|). Completing the square proves integrability of (7). The same argument works on any compact complex z disk, so it also supplies analytic continuation across the removable quotient points. Applying dominated parameter differentiation three times and commuting the continuous real-part map with the integral proves the derivative formula used below.

For (1), on |q|<=M the parametrized integrand is bounded, apart from the constant 1/(2sqrt(pi)), by

\[
 e^{M^2/2}(|u|+M)^m\exp(-u^2/2+M|u|),\qquad u\in\mathbb R. \tag{8}
\]

The denominator has norm at least 1 by (5). Any fixed finite number of q derivatives introduces only further polynomial factors. These are still integrable after completing the square. Thus b_m is entire and in particular continuous at q=+/-sqrt(pi). This fixed-contour definition will handle the closed endpoints without an assumed indentation convention.

## The B0 and F''' bounds

For real |q|<=sqrt(pi), apply the first inequality in (6) to (2), with a=q/sqrt(pi) and x=pi*v. The elementary Gaussian integral gives

\[
 |B_0(q)|\le\sqrt2\int_0^\infty e^{-\pi v^2/2}\,dv
 =\sqrt2\cdot\frac1{\sqrt2}=1.                     \tag{9}
\]

Three differentiations of (3), justified by (7), give

\[
 F'''(z)=\sqrt2\operatorname{Re}\left[e^{-i\pi/8}
  \int_0^\infty e^{-\pi v^2/2}(\pi\epsilon v)^3
   \frac{\sinh(\pi z\epsilon v)}{\cosh(\pi\epsilon v)}\,dv\right].
\]

For real |z|<=1, the second inequality in (6) therefore yields

\[
 |F'''(z)|\le2\pi^3\int_0^\infty v^3e^{-\pi v^2/2}\,dv
 =2\pi^3\frac{2}{\pi^2}=4\pi.                     \tag{10}
\]

The last integral follows by s=pi*v^2/2 and integral_0^infinity s*exp(-s) ds=1. This proves the absolute-value version of the source derivative bound, on the whole closed interval including the removable points.

## The b1 and b3 bounds

First take real |q|<sqrt(pi). Shift the contour in (1) from L0 to v=iq+epsilon*u. There are no poles between these lines: the poles of the denominator are v=i*(2k+1)*sqrt(pi), and the intervening imaginary intercepts lie strictly between -sqrt(pi) and sqrt(pi). The finite parallel-line contour identity has vanishing closing edges. On an edge v=epsilon*R+i*r with r between 0 and q, its numerator is bounded by a polynomial in |R| times exp(-R^2/2+C|R|), while (4) bounds the denominator below by |sinh(sqrt(pi)*R/(2sqrt(2)))|. The edge length is bounded. This proves the required limiting contour equality directly.

The substitution has dv=epsilon*du and the exact exponent identity

\[
 iv^2/2+qv=iq^2/2-u^2/2.
\]

Hence

\[
 b_m(q)=\frac{\epsilon e^{i\pi/8}}{2\sqrt\pi}
 \int_{\mathbb R}e^{-u^2/2}
 \frac{(\epsilon u)^m}{\cosh(\sqrt\pi(iq+\epsilon u)/2)}\,du.
 \tag{11}
\]

Put c=sqrt(pi)/(2sqrt(2)). For every real q,u, (4) gives

\[
 |\cosh(\sqrt\pi(iq+\epsilon u)/2)|^2
 =\sinh^2(cu)+\cos^2(\sqrt\pi q/2+cu)\ge\sinh^2(cu).
\]

The elementary inequality sinh(v)>=v for v>=0 follows by integration of cosh(v)>=1. Thus, for u!=0 and m>=1,

\[
 \left|\frac{(\epsilon u)^m}
 {\cosh(\sqrt\pi(iq+\epsilon u)/2)}\right|
 \le\frac{2\sqrt2}{\sqrt\pi}|u|^{m-1}.             \tag{12}
\]

This is a uniform integrable bound after multiplication by exp(-u^2/2). In particular

\[
 |b_m(q)|\le\frac{\sqrt2}{\pi}
       \int_{\mathbb R}|u|^{m-1}e^{-u^2/2}\,du.    \tag{13}
\]

The two required Gaussian integrals are equal:

\[
 \int_{\mathbb R}e^{-u^2/2}\,du=\sqrt{2\pi},\qquad
 \int_{\mathbb R}u^2e^{-u^2/2}\,du=\sqrt{2\pi}.
\]

The second equality follows by integration by parts, with u*exp(-u^2/2) tending to zero at both ends. Therefore

\[
 |b_1(q)|\le\frac2{\sqrt\pi},\qquad
 |b_3(q)|\le\frac2{\sqrt\pi}.                     \tag{14}
\]

Continuity of b_m from (8) extends (14) to both endpoints q=+/-sqrt(pi). If one also needs (11) itself at the endpoints, dominated convergence applies by (12), since the integrands converge for every u!=0. At u=0 the zero of cosh is simple and the numerator vanishes to order m, so the quotient has a removable singularity. Its value at that single integration point does not affect the integral. This proves the endpoint formula as well, independently of the original saddle contour's indentation.

## Derivative normalization and the first correction

The source generating identity can be obtained on the fixed contour, using (8) to differentiate in a complex variable x near zero:

\[
 e^{ix^2/2}\widetilde F(q+x)
 =\frac{e^{i\pi/8-iq^2/2}}{2\sqrt\pi}
 \int_{L_0}\frac{e^{iv^2/2+qv}e^{x(v-iq)}}
 {\cosh(\sqrt\pi v/2)}\,dv.
\]

The first and third derivatives at x=0 give exactly

\[
 b_1=\widetilde F',\qquad b_3=\widetilde F'''+3i\widetilde F'. \tag{15}
\]

The plus sign in 3i is fixed by the positive exponent +ix^2/2. The source polynomial P1(w)=w^3/3-iw consequently gives

\[
 B_1=b_3/3-i b_1=\widetilde F'''/3,
 \qquad |B_1|\le\frac8{3\sqrt\pi}<\frac85.          \tag{16}
\]

For the strict rational bound, pi>3 implies sqrt(pi)>5/3. The real-part relation contains a different variable scale: Re Ftilde(q)=F(q/sqrt(pi)), so

\[
 \operatorname{Re} B_1(q)=\frac{F'''(q/\sqrt\pi)}{3\pi^{3/2}},
 \qquad |\operatorname{Re}B_1(q)|\le\frac4{3\sqrt\pi}. \tag{17}
\]

With tau=1/(4*a*sqrt(pi)), this agrees with C1(z)=F'''(z)/(12*pi^2) after extracting the common a^(-1/2) correction factor. There is no missing factor of 2, conjugation, or pi in this conversion. The stronger real-part bound (17), rather than the modulus bound in (16), is the leading K0-error input.

## Proof status and remaining implementation leaves

Equations (4)–(17) give complete paper derivations of the requested inequalities and coefficient normalization from the two stated integral identities. The argument uses only Gaussian integration, elementary absolutely convergent power series, dominated differentiation, a finite pole-free contour shift, and dominated convergence at the endpoints. No sampled maximum or tabulated coefficient bound is used.

The separate Mordell proof supplies the equality of the original contour function with (2) and with the removable quotient F. Its independent review remains a dependency of accepting this combined argument. For a kernel proof the needed new work is explicit real-parameter definitions of the sloping contours, contour deformation with the displayed closing-edge estimates, the elementary hyperbolic norm lemmas, parameter-differentiation applications with (7) and (8), and the removable-continuation adapters. Standard Gaussian integrals and integration by parts suffice for all scalar integrals here.

This note does not prove the original Riemann–Siegel saddle representation, the variation-of-constants remainder estimate, the four-range remainder bounds, or the normalized Gamma-phase estimate. Those remain separate analytic leaves in the K0 blueprint. The four bounds proved here do not by themselves establish a numerical K0 remainder theorem.
