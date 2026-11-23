# Joining fixed Gaussian coefficients to the indented saddle contour

2026-11-11. This note proves the specific contour join needed before combining the low-order Gaussian coefficient bounds with the first-order saddle remainder. It is a paper proof, not a Lean implementation or a completed K0 certificate. No frozen note, source file, dependency, or numerical receipt was changed; no build or scan was run.

The essential endpoint fact is that **B0 cannot be replaced by an unindented straight integral**. At `q=sqrt(pi)`, its normalized southeast arc contributes exactly `exp(i*pi/8)` in the shrinking-radius limit. Its symmetric straight-line principal value is zero. Only after subtracting B0 and tau*B1 from S does the double zero of the residual allow the arc to disappear.

## 1. Inputs and exact statement of the join

The primary source is Gabcke's corrected thesis, <https://d-nb.info/1072293277/34>, PDF SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. The relevant passages are 1.2.1, p12 (source contour and indentation), (1.25)–(1.28), pp16–17 (coefficients), and 3.1.1, pp41–43 (subtract before removing the residual indentation).

The separate paper plans are:

* `mellin/K0_GAUSSIAN_MOMENT_PROOF_PLAN_2026-11-11.md`, SHA `A3BD9C855E57DD70D828E093E83E760B2832AD4B8E6E00CED608629A087CE97A`, defining coefficients on a fixed line and proving their bounds. Its independent review deliberately leaves the constant-coefficient endpoint join to a separate proof.
* `moebius/RIEMANN_SIEGEL_IDENTITY_PROOF_PLAN_2026-11-11.md`, SHA `724FB84B60B9E3CFD178486BD52950A00709DC0D2CB7AA56C3E4193C426234E5`, sections 10–11, deriving the source southeast detour after the affine saddle substitution and orientation reversal.
* `major-constants/K1_REMAINDER_PROOF_PLAN_2026-11-11.md`, SHA `0008EECFA0408799E48B506A04F97BEF41EB55FE75D5A138CDF105F415CE107F`, deriving the double zero and the integrable remainder bounds, conditional on matching the coefficient contours first.

Put `p=sqrt(pi)>0`, `epsilon=exp(i*pi/4)=(1+i)/sqrt(2)`, and for real q define

\[
 c(q)=\frac{e^{i\pi/8-iq^2/2}}{2p},\qquad
 K_{P,q}(v)=\frac{e^{iv^2/2+qv}P(v-iq)}{\cosh(pv/2)}.
\]

Only the entire polynomials `P0(w)=1` and `P1(w)=w^3/3-iw` are used. Let

\[
 L_r:\ v=ir+\varepsilon u,\qquad -\infty<u<\infty,
\]

oriented southwest to northeast. The fixed coefficients are

\[
 B_j(q)=c(q)\int_{L_0}K_{P_j,q}(v)\,dv,\qquad j=0,1.
 \tag{1}
\]

The theorem to prove is:

1. For `-p<q<p`, (1) equals the same integral on the straight source line `Lq`.
2. For `q=p`, it equals the integral on the source line with its southeast, pole-left semicircular detour, for each sufficiently small fixed positive radius. It consequently equals the source's shrinking-detour value.
3. Subtracting these **matched** coefficients from S gives the residual integrand `g(tau,v-iq)-1-tau*P1(v-iq)`. Its double zero removes the endpoint arc and gives the straight integral used by the K1 proof.

The actual saddle domain is `-p<q<=p`. This note makes no unindented m=0 assertion at either endpoint and needs no source definition of S at the excluded lower endpoint `q=-p`.

## 2. Singularities, convergence, and finite closing edges

The only singularities of the coefficient kernels are the simple denominator zeros

\[
 v=i(2k+1)p,\qquad k\in\mathbb Z.
\]

There is **no logarithmic cut** in either coefficient kernel: its numerator is an exponential times a polynomial. Any cancellation can only remove a listed pole; it cannot create a new singularity.

For a finite vertical connector `v=epsilon*R+i*r` with r between 0 and q, direct expansion gives

\[
 \Re(iv^2/2+qv)=-R^2/2+(q-r)R/\sqrt2
 \le -R^2/2+p|R|/\sqrt2,\qquad |q|\le p.
 \tag{2}
\]

Also `|v-iq|<=|R|+p`, so

\[
 |P_0(v-iq)|=1,\qquad
 |P_1(v-iq)|\le (|R|+p)^3/3+|R|+p.
\]

The exact identity `|cosh(x+iy)|^2=sinh^2 x+cos^2 y` yields

\[
 |\cosh(pv/2)|\ge\sinh\left(\frac{p|R|}{2\sqrt2}\right).
 \tag{3}
\]

For large |R| this lower bound is at least 1. Since the connector length is at most p, (2) and (3) prove that both closing-edge integrals tend to zero, even after the degree-three polynomial factor. Explicitly, for `|R|>=2*sqrt(2)*p`, the exponent in (2) is at most `-R^2/4`; a fixed polynomial times that Gaussian tends to zero. This is a uniform tail estimate over the entire finite range of connector heights, not merely at their endpoints.

On any straight Lr away from a possible finite pole, the same calculation gives absolute convergence of both tails. In particular (1) is absolutely convergent on L0: the denominator has modulus at least 1 there by the Gaussian moment note's elementary cosh identity. All finite detoured integrals below are ordinary absolutely convergent line/arc integrals, followed only by their infinite-tail limits.

## 3. Interior q: a finite pole-free parallelogram

Fix `-p<q<p`. Truncate L0 and Lq at parameters `u=-R,+R` and join their endpoints vertically. The closed path is L0 forward, the +R connector, Lq backward, then the -R connector. For q>0 it is counterclockwise; for q<0 it has the opposite orientation. Its sign does not affect a zero integral.

Every point on the imaginary axis inside this parallelogram has imaginary coordinate between 0 and q. No odd multiple of p lies between these values or on the boundary. All possible poles of the kernel lie on that axis. Thus the kernel is holomorphic on a neighborhood of the closed parallelogram and Cauchy's theorem gives zero boundary integral. There is no residue term.

Let R tend to infinity. By section 2, the connectors vanish and the straight tails converge absolutely. The two forward line integrals are equal. Multiplying by the same c(q) proves the first part of the join. This argument changes the contour while keeping q fixed inside the integrand; it is not a continuity argument in q.

## 4. Upper endpoint q=p: the source detour and its geometry

Let `v0=ip`, and choose `0<rho<p/4`. Define `T_rho` as:

* the line `v0+epsilon*u`, from u=-infinity to u=-rho;
* the arc `v=v0+rho*exp(i*alpha)`, with alpha **increasing** from `-3*pi/4` to `pi/4`;
* the same line from u=rho to infinity.

The arc has angle change `+pi`. It passes through the southeast side of the pole and crosses the imaginary axis below it. Thus the pole is on the **left** of the southwest-to-northeast source path, exactly as in Gabcke 1.2.1 and the saddle identity note. Reversing the arc or choosing its northwest counterpart would change the integral.

To see the finite deformation without an informal picture, rotate coordinates by `w=conj(epsilon)*v`. L0 is the real axis. Lp is the horizontal line at height `p/sqrt(2)`, and the pole is at

\[
 w_0=p/\sqrt2+i\,p/\sqrt2.
\]

The detour becomes the **lower** semicircle around w0, with angles increasing from -pi to 0. Since `rho<p/4<p/sqrt(2)`, this semicircle remains strictly above L0. The region between L0 and the detoured upper path excludes the pole: the notch cuts a half-disk out of the top of the strip. No other denominator zero lies in that strip.

Truncate T_rho and L0 at parameters ±R, with R larger than rho and the fixed contour offsets. Join endpoints by the same vertical connectors as in section 2. This is a simple closed, piecewise smooth boundary; its interior is the parallelogram below the upper path with the small notch removed. The kernel is holomorphic on a neighborhood of its closure, because v0 lies outside, at positive distance from the detour. Cauchy's theorem again gives zero boundary integral. Let R tend to infinity; the connectors vanish by (2),(3). Therefore

\[
 \int_{L_0}K_{P_j,p}(v)\,dv=\int_{T_\rho}K_{P_j,p}(v)\,dv,
 \qquad j=0,1.\tag{4}
\]

This is an equality for **each fixed rho**, before taking a shrinking-radius limit. It proves that the indented coefficient integrals have a limit and that it is exactly the fixed-contour value. No dominated-convergence claim for the singular straight B0 kernel has been made.

## 5. Explicit endpoint check: the B0 arc is not negligible

For `P0=1`, at `v0=ip`,

\[
 e^{iv_0^2/2+pv_0}=e^{i\pi/2}=i,\qquad
 \left.\frac{d}{dv}\cosh(pv/2)\right|_{v=v_0}=ip/2.
\]

The unnormalized residue is therefore `2/p`. After multiplication by
`c(p)=exp(-3*pi*i/8)/(2*p)`, the residue is

\[
 r_0=\frac{e^{-3i\pi/8}}{\pi}.
\]

On the southeast arc the integral of `r0/(v-v0)` is `i*pi*r0`, not its negative. The holomorphic remainder contributes an integral tending to zero as rho tends to zero. Thus the normalized arc limit is

\[
 i\pi r_0=e^{i\pi/8}.\tag{5}
\]

On the straight pieces, substitute `v=ip+epsilon*u`. The normalized kernel becomes

\[
 \frac{\varepsilon e^{i\pi/8}}{2p}
       \frac{e^{-u^2/2}}{i\sinh(p\varepsilon u/2)}\,du.
\]

Its scalar dependence on u is odd. The symmetric straight integral over `[-R,-rho]` and `[rho,R]` is consequently zero for every R>rho. Hence (4),(5) yield the exact diagnostic identity

\[
 B_0(p)=e^{i\pi/8}.
\]

This agrees with the fixed Gaussian representation at the endpoint, where its cosh ratio is 1. The calculation also proves why a principal-value-only substitution would be wrong: it would turn B0(p) into zero. The present proof retains the arc rather than trying to remove it by an m>=1 dominated-convergence estimate.

For P1, `P1(v-ip)` has a simple zero at v0. Its quotient extends holomorphically there, with unnormalized value `-2i/p`, since `P1'(0)=-i`. Its small arc integral does tend to zero. Thus the fixed B1 equals the straight endpoint integral with this removable value. This stronger observation is compatible with (4), but the common-contour identity (4) is what is needed for subtraction.

## 6. Subtract on one contour, then remove only the residual arc

For an actual saddle parameter `-p<q<=p`, use its source contour: Lq in the interior, and T_rho at q=p. Its exact source integrand is

\[
 K_{g,q}(v)=\frac{e^{iv^2/2+qv}g(\tau,v-iq)}{\cosh(pv/2)},
\]

with the normalized factor c(q). Equations (1),(4) now identify the fixed coefficients with the integrals of P0 and P1 on this **same** source contour. By linearity,

\[
 S-B_0-\tau B_1
 =c(q)\int_{\text{source contour}}
 \frac{e^{iv^2/2+qv}
       [g(\tau,v-iq)-1-\tau P_1(v-iq)]}{\cosh(pv/2)}\,dv.
 \tag{6}
\]

At q=p one may first state (6) for each sufficiently small fixed rho. The source integral is the detoured integral supplied by the upstream saddle identity. Its logarithmic cut starts at `v=ip+i/(2*tau)`; take additionally `rho<1/(4*tau)` to keep the whole arc in its analytic domain. This restriction is compatible with every earlier condition. No deformation of the g integrand from L0 is used here; only the polynomial coefficient kernels were moved from L0.

The K1 proof independently establishes, from the exact differential equation of g,

\[
 R(w):=g(\tau,w)-1-\tau P_1(w),\qquad R(0)=R'(0)=0.
\]

Thus `R(v-ip)=(v-ip)^2*h(v)` locally with h holomorphic. The denominator has a simple zero. The residual quotient in (6) consequently extends holomorphically with value zero and is `O(|v-ip|)`. Its arc integral is `O(rho^2)` and tends to zero. Both sides of the straight residual integral are locally absolutely integrable; no principal value is required.

At infinity, the K1 pointwise estimates already prove Gaussian domination of R divided by the cosh denominator, independently of the coefficient-contour identity. They justify passing to the full straight residual integral. Alternatively, on any fixed detoured path the source and both coefficient integrals are absolutely convergent, so their difference is; the K1 estimate then supplies the uniform residual majorant needed for straightening. There is no circular use of the final `4.2*tau^2` conclusion.

Finally, substitute `v=iq+epsilon*u` in the residual, retaining the positive epsilon Jacobian. Since
`iv^2/2+qv=iq^2/2-u^2/2`, equation (6) becomes exactly

\[
 S-B_0-\tau B_1
 =\frac{\varepsilon e^{i\pi/8}}{2p}
  \int_{\mathbb R}\frac{e^{-u^2/2}R(\varepsilon u)}
      {\cosh(p(iq+\varepsilon u)/2)}\,du.
 \tag{7}
\]

This is the identity estimated in the K1 remainder plan, with the same B0/B1 as the fixed-contour moment bounds. At u=0 and q=p the removable residual value is zero. The q-dependent phase cancels exactly. No residue or half-residue remains in (7), because the identical pole terms of S and B0 were subtracted on the same detour first.

## 7. Consequences and formalization boundary

The join is valid on the full actual saddle range `-sqrt(pi)<q<=sqrt(pi)`, including every integer-a endpoint. It does not assume continuity of N, of the finite correction approximant, or of its remainder across floor transitions. It uses one exact contour prescription at each parameter.

At paper level, this supplies the interface explicitly left open between the Gaussian moment proof and the K1 remainder proof. It does not prove their other analytic steps or change their review status. In particular the exact Riemann–Siegel representation, normalized Gamma/Hardy identification, Gaussian estimates, and first-order remainder estimates remain separately reviewed proof components; full Lean formalization and interval-checker soundness remain open.

Lean needs the finite pole-free contour identity for the notched region (or an equivalent finite partition into contour pieces), the explicit connector bound, affine parameter substitutions, and the elementary simple-pole/analytic-factor arc estimates. Existing Cauchy and residue APIs may implement these steps, but an external contour drawing or an interval evaluation is not a trusted theorem. The endpoint equality for B0 must be one of those proved steps; the m>=1 dominated-convergence lemma cannot substitute for it.
