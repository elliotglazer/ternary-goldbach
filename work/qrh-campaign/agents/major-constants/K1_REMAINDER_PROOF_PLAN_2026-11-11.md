# First-order Gabcke remainder: complete specialized paper derivation

2026-11-11. This note reconstructs the remaining first-order integral estimate, specialized to `t>=1500`. It proves on paper

\[
 |S-B_0-B_1\tau|<\frac{21}{5}\tau^2,
 \qquad \tau=(8t)^{-1/2},\quad |q|\le\sqrt\pi,
\]

with the endpoint meaning specified below. The proof supplies the variation-of-constants identity, endpoint cancellation, exponent bounds, Gaussian integrals, and tail estimates. No numerical quadrature, zero data, high-order coefficient table, Lean build, source edit, or frozen-report edit is used. Formal terms and the separate upstream Riemann–Siegel identity remain open.

## 1. Source and boundary of this proof

Primary source: Gabcke, corrected 1979/2015 thesis, <https://d-nb.info/1072293277/34>. Local PDF `agents/mellin/gabcke_1979_corrected_2015.pdf`, SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. Printed pages 41–51 contain 3.1.1–3.1.3; pp81–84 contain the elementary estimates 4.4.2 and 4.4.3. Printed p48 was visually checked in the earlier blueprint; the retained image is `major-constants/gabcke_blueprint_p48.png`.

The upstream exact saddle identity is separately reconstructed in `moebius/RIEMANN_SIEGEL_IDENTITY_PROOF_PLAN_2026-11-11.md`, SHA `724FB84B60B9E3CFD178486BD52950A00709DC0D2CB7AA56C3E4193C426234E5`, under independent review when this note was written. The moment/contour identities are separately reconstructed in `mellin/K0_GAUSSIAN_MOMENT_PROOF_PLAN_2026-11-11.md`, SHA `A3BD9C855E57DD70D828E093E83E760B2832AD4B8E6E00CED608629A087CE97A`, also under review. Their claimed review status is not an input to this proof. This note consumes the exact definition of S and the matching B0/B1 contour representations, then proves their remainder estimate.

The frozen low-order assembly `GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md`, SHA `8A65614DA19778FBA1CB08440183FCE49D52B9BCCD9F7B552EA535234C1DD713`, and its independent review `audit/REVIEW_GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md`, SHA `7B40483351FFAFAEF7039BC89E02C89A4F292A13BAB3281C1CF7482D9D4F51D1`, already checked the scalar specialization assuming 3.1.3. Here that analytic assumption is expanded into the proof below. The source-ledger correction requiring Mordell parameters 1,2,1/2 remains in force upstream.

## 2. Definitions and exact polynomial defect

Fix real `t>=1500`, `tau=1/sqrt(8*t)>0`, `epsilon=exp(i*pi/4)=(1+i)/sqrt(2)`, and real q. Define on

\[
 \Omega_\tau=\mathbb C\setminus\{iy:y\ge1/(2\tau)\}
\]

the analytic function

\[
 G_\tau(z)=\left(-\frac12+\frac{i}{8\tau^2}\right)\Log(1+2i\tau z)
                   +\frac{z}{4\tau}-\frac{iz^2}{4},\qquad g_\tau=e^{G_\tau}.
\]

The log is the principal log of its argument; the displayed domain is exactly its preimage slit plane. It contains zero and is star-shaped about zero. Direct differentiation gives

\[
 G_\tau'(z)=\frac{\tau(z^2-i)}{1+2i\tau z},\qquad
 (1+2i\tau z)g_\tau'(z)=\tau(z^2-i)g_\tau(z).
\]

Set

\[
 P_1(z)=z^3/3-iz,\quad
 P_2(z)=z^6/18-(5i/6)z^4-(3/2)z^2,
 \quad R(z)=g_\tau(z)-1-\tau P_1(z).
\]

The polynomial identities

\[
 P_1'=z^2-i,\qquad P_2'=(z^2-i)P_1-2izP_1'
\]

give the exact defect equation

\[
 (1+2i\tau z)R'(z)-\tau(z^2-i)R(z)=\tau^2P_2'(z).
 \tag{1}
\]

Moreover `R(0)=R'(0)=0`: `g(0)=1`, `g'(0)=-i*tau`, and `P1'(0)=-i`. Thus R has at least a **double** zero at zero. This is stronger than the single zero needed in Gabcke's general-K argument.

## 3. Variation of constants, with branch and FTC justification

For `z in Omega_tau`, the whole segment `r*z`, `0<=r<=1`, stays in that domain. Since g is an exponential it never vanishes. Divide (1) by `(1+2*i*tau*z)*g(z)` and differentiate `R/g`. The real-parameter FTC on the segment, using `R(0)=0`, yields

\[
 R(z)=\tau^2z\int_0^1
 \frac{P_2'(zr)}{1+2i\tau zr}
 \exp\left(\tau z\int_r^1\frac{(zv)^2-i}{1+2i\tau zv}\,dv\right)dr.
 \tag{2}
\]

The exponential here is exactly `g(z)/g(z*r)`: integrate the derivative of the explicitly defined analytic G along the same segment. There is no assertion that a pointwise principal logarithm of g is globally analytic. The denominators are nonzero on the compact segment, so all displayed finite integrals are continuous and integrable. This proves the K=1 case of source (3.5) without a general complex ODE existence theorem.

## 4. Put the segment on the diagonal and calculate its modulus

Let `u in R` and `z=epsilon*u`; this point is in `Omega_tau` for every u. Put

\[
 x=2\sqrt2\tau u=u/\sqrt t,
 \qquad f(x)=\int_0^x\frac{v^2(v-1)}{1+(v-1)^2}\,dv,
 \qquad \phi(x,r)=f(x)-f(xr).
\]

Since `epsilon^2=i`, (2) becomes

\[
 R(\varepsilon u)=\tau^2iu\int_0^1
  \frac{P_2'(\varepsilon ur)}{\varepsilon-2\tau ur}
  \exp\left(-\tau u\int_r^1
       \frac{(uv)^2-1}{\varepsilon-2\tau uv}\,dv\right)dr.
 \tag{3}
\]

For `x!=0`, direct real-part integration gives the following **exact** norm multiplier in the integrand of the triangle bound:

\[
 \frac{1}{|\varepsilon-2\tau ur|}
 \exp\Re\left(-\tau u\int_r^1
       \frac{(uv)^2-1}{\varepsilon-2\tau uv}\,dv\right)
 =\frac{\sqrt2\exp\{u^2\phi(x,r)/(2x^2)\}}
 {[1+(xr-1)^2]^{1/4}[1+(x-1)^2]^{1/4}}.\tag{4}
\]

For verification, the real part of the exponent alone is

\[
 \frac{u^2\phi(x,r)}{2x^2}
 -\frac14\log(1+(x-1)^2)+\frac14\log(1+(xr-1)^2),
\]

and `|epsilon-2*tau*u*r|=sqrt(1+(x*r-1)^2)/sqrt(2)`. These positive real logarithms involve no branch choice. At `u=x=0`, use `R(0)=0` separately rather than a division by x.

When `x<0`, both bracketed quantities in (4) are at least 2, so its prefactor is at most 1. When `x>=0`, both are at least 1, so its prefactor is at most `sqrt(2)`.

The derivative `f'(v)=v^2(v-1)/(1+(v-1)^2)` shows

\[
 \phi(x,r)\le
 \begin{cases}
 f(x),&x<0,\\
 0,&0\le x\le1,\\
 f(x)-f(1),&x>1,
 \end{cases}\qquad 0\le r\le1.\tag{5}
\]

Indeed f is nonnegative on the negative axis, decreasing on [0,1], and increasing on [1,infinity), with its minimum on the nonnegative axis at 1.

## 5. Elementary exponent inequalities

The negative range admits a shorter proof than the general-parameter arctangent argument in 4.4.2. For `r>0`, substitution gives

\[
 f(-r)=\int_0^r\frac{v^2(v+1)}{1+(v+1)^2}\,dv.
\]

The integrand is less than v for `v>0`, since `v(v+1)<1+(v+1)^2`. Therefore `f(-r)<r^2/2`. Also `a/(1+a^2)<=1/2` for every positive a, so
`f(-r)<=r^3/6`. In particular, for `0<r<=1/4`,

\[
 f(-r)\le r^2/24.\tag{6}
\]

This supplies the negative small-range multiplier `exp(u^2/48)`. It replaces, rather than assumes, Gabcke's more general expression involving the auxiliary omega. Its resulting decay `23/48` is stronger than the already reviewed lower bound `17/36`.

For the positive far range, an antiderivative gives

\[
 f(x)=x^2/2+x-2\arctan(x-1)-\pi/2.
\]

Define `W(x)=f(x)-f(1)-(14/25)*x^2` for `x>=1`. Then

\[
 W'(x)=-\frac3{25}\frac{x(x-7/3)(x-8)}{1+(x-1)^2}.
\]

It follows that W decreases on [1,7/3], increases on [7/3,8], and decreases on [8,infinity). Thus its supremum is bounded by `max(W(1),W(8))`. Here `W(1)=-14/25<0`, while

\[
 W(8)=133/50-\pi+2\arctan(1/7)
 <133/50-157/50+2/7=-34/175<0.
\]

We used the real identity `atan 7=pi/2-atan(1/7)`, `atan(1/7)<1/7`, and `pi>157/50`. This proves source (4.34), with its exact `.56=14/25`, on the entire positive range. It is not a finite numerical check of an unbounded interval.

Finally, the polynomial triangle inequality gives

\[
 |u|\int_0^1|P_2'(\varepsilon ur)|\,dr
 \le V(u):=\frac32u^2+\frac56u^4+\frac1{18}u^6.
 \tag{7}
\]

Combining (3)–(7), set `vartheta=1/4` and obtain the four bounds

\[
 |R(\varepsilon u)|\le\tau^2 V(u)
 \begin{cases}
 e^{u^2/4},&u\le-\sqrt t/4,\\
 e^{u^2/48},&-\sqrt t/4<u<0,\\
 \sqrt2,&0\le u\le\sqrt t,\\
 \sqrt2e^{7u^2/25},&u>\sqrt t.
 \end{cases}\tag{8}
\]

Use non-strict inequalities in (8), especially at u=0 where both sides vanish. Strict final bounds come from the later scalar margins. Source displays using a strict inequality at a vanishing endpoint should not be copied literally into a theorem.

## 6. Residual contour and endpoint cancellation

On the source contour through iq define

\[
 RS_1=S-B_0-\tau B_1
 =\frac{e^{i\pi/8-iq^2/2}}{2\sqrt\pi}
    \int\frac{e^{iv^2/2+qv}R(v-iq)}{\cosh(\sqrt\pi v/2)}\,dv.
 \tag{9}
\]

For `-sqrt(pi)<q<sqrt(pi)` this is a straight diagonal. At `q=sqrt(pi)` the source S and coefficient contours have the same small indentation, keeping the pole on the left. Subtract their integrands first. The numerator R has a double zero at `v=iq`; the denominator has at most a simple zero there, so the residual integrand extends analytically with value zero. The indentation may now be removed: on a sufficiently small disk its integrand is bounded, and the short arc integral tends to zero with its length. Choose the disk to avoid the next cosh pole and the shifted logarithmic cut; e.g. radius smaller than both `sqrt(pi)/2` and `1/(4*tau)` suffices. No residue remains after this cancellation.

For the straight residual, put `v=iq+epsilon*u`. Its exponential simplifies exactly to

\[
 i v^2/2+qv=iq^2/2-u^2/2,
\]

so (9) becomes

\[
 RS_1=\frac{\varepsilon e^{i\pi/8}}{2\sqrt\pi}
     \int_{\mathbb R}\frac{e^{-u^2/2}R(\varepsilon u)}
       {\cosh(\sqrt\pi(iq+\varepsilon u)/2)}\,du.\tag{10}
\]

The q phase cancels; it must not remain as an extra factor in the norm calculation.

For real q,u the denominator satisfies

\[
 \left|\cosh\left(\tfrac{\sqrt\pi}{2}(iq+\varepsilon u)\right)\right|^2
 =\sinh^2(cu)+\cos^2\left(\tfrac{\sqrt\pi q}{2}+cu\right),
 \qquad c=\frac{\sqrt{2\pi}}4.
\]

Hence its modulus is at least `sinh(c*|u|)`, which is at least `c*|u|`. Formula (8) now gives an integrable bound for the residual: near zero, `V(u)/|u|=O(|u|)`; at infinity the remaining exponential has decay at least `exp(-11*u^2/50)`. This justifies the integral, norm inequality, and subsequent splitting. It also dominates uniformly in q. Consequently (10) extends continuously to the closed q interval, including `q=-sqrt(pi)`. On the actual saddle domain `-sqrt(pi)<q<=sqrt(pi)` it equals the source `S-B0-tau*B1`; at the unused lower endpoint it defines the corresponding continuous residual extension. No separate unindented definition of S at its pole is asserted.

The matching fixed-contour B0/B1 representations belong to the separate Gaussian-moment proof. Once they are transported to the source contour, only a local removal of the residual indentation is needed here, not an additional unjustified deformation at infinity.

## 7. Integrate the two middle ranges

Take absolute values in (10) and split at `-sqrt(t)/4,0,sqrt(t)`, obtaining nonnegative contributions `J1,J2,J3,J4`.

For `s>0`, `s/sinh(s)<=1`. On the negative small range, the product of the two exponentials in (10) and (8) is `exp(-23*u^2/48)`, bounded above by `exp(-w0*u^2)` with `w0=17/36>0`. Extend the integral to the whole positive half-line and use `1/(2*sqrt(pi)*c)=sqrt(2)/pi`:

\[
 J_2\le\frac{\sqrt2\tau^2}{\pi}\int_0^\infty
       e^{-w_0u^2}\left(\frac32u+\frac56u^3+\frac1{18}u^5\right)du.
\]

The substitution `v=w0*u^2` gives
`integral_0^infinity u^(2k+1)*exp(-w0*u^2)du=k!/(2*w0^(k+1))` for k=0,1,2. Thus

\[
 J_2\le\tau^2\frac1{\sqrt2\pi}
  \left(\frac3{2w_0}+\frac5{6w_0^2}+\frac1{9w_0^3}\right)
 <1.82\tau^2.\tag{11}
\]

On the positive middle range, the extra `sqrt(2)` in (8) instead gives

\[
 J_3\le\frac{2\tau^2}{\pi}\int_0^\infty
 e^{-u^2/2}\left(\frac32u+\frac56u^3+\frac1{18}u^5\right)du
 =\tau^2\frac2\pi\left(\frac32+\frac53+\frac49\right)<2.31\tau^2.\tag{12}
\]

The exact rational upper bounds used in (11),(12) are respectively
`9787500/5399387` and `3250/1413`, using `sqrt(2)>7/5` and `pi>157/50`. These are the values already independently checked in the frozen K1 scalar audit.

## 8. Tail lemma with its full domain

For real `a>=1` and `X>a`, define the convergent positive integral

\[
 \Gamma(a,X)=\int_X^\infty e^{-v}v^{a-1}\,dv.
\]

Finite integration by parts followed by exponential decay gives

\[
 \Gamma(a,X)=e^{-X}X^{a-1}+(a-1)\int_X^\infty e^{-v}v^{a-2}\,dv
 \le e^{-X}X^{a-1}+\frac{a-1}{X}\Gamma(a,X).
\]

Since `X>a`, the coefficient left after rearrangement is positive. Therefore

\[
 \Gamma(a,X)\le\frac{X}{X-a+1}e^{-X}X^{a-1}
                \le a e^{-X}X^{a-1}.\tag{13}
\]

The final inequality follows from `(a-1)(X-a)>=0`. This is an elementary proof of the exact bound used in source 4.4.3, with both required conditions visible. It does not claim the bound for arbitrary positive a or for X<=a.

All uses below have `a=3/2,5/2,7/2`. Their X values are `1500/64` and `330`, both strictly greater than 7/2. Gaussian polynomial integrability and the vanishing endpoint in the integration-by-parts formula follow from exponential domination of any fixed real power.

## 9. Freeze the two tails at t0=1500

Write `T=1500`, `vartheta=1/4`, and `ck=(3/2,5/6,1/18)`. On the negative far range, (8) leaves `exp(-u^2/4)`. Since `t>=T`, extend the positive-u tail down to `vartheta*sqrt(T)` and replace the sinh denominator by its smaller endpoint value. This gives

\[
 J_1\le\frac{\tau^2}{2\sqrt\pi\sinh(c\vartheta\sqrt T)}
       \sum_{k=0}^2c_k\int_{\vartheta\sqrt T}^\infty
                  e^{-u^2/4}u^{2+2k}\,du.
\]

Use `v=u^2/4` and (13), with `a=k+3/2`, `X=vartheta^2*T/4`. Simplifying every power of 2 gives

\[
 J_1\le\tau^2Y_1,\qquad
 Y_1=\frac{\vartheta\sqrt T\,e^{-\vartheta^2T/4}}
             {\sqrt\pi\sinh(c\vartheta\sqrt T)}
       \sum_{k=0}^2c_k(\vartheta^2T)^k(k+3/2).\tag{14}
\]

On the positive far range the remaining exponent is `exp(-11*u^2/50)`. Let `b=11/50`. Freeze its lower limit and denominator at `sqrt(T)`, substitute `v=b*u^2`, and use (13), now with `X=b*T=330`. The extra square root from (8) is retained. The result is

\[
 J_4\le\tau^2Y_4,\qquad
 Y_4=\frac{\sqrt T\,e^{-bT}}{2b\sqrt{2\pi}\sinh(c\sqrt T)}
              \sum_{k=0}^2c_kT^k(k+3/2).\tag{15}
\]

These are precisely the K=1 tail formulas of source 3.1.3; `2b=.44`. The prerequisite source inequalities `T>7/.44` and `vartheta>sqrt(14/T)` hold. The substitutions above also verify their actual incomplete-Gamma domains directly.

For (14), `vartheta*sqrt(T)<10`, `vartheta^2*T<100`, and the denominator is greater than 1. The polynomial sum is below
`9/4+(25/12)*100+(7/36)*100^2<2200`.
Also `exp(T/64)>exp(20)>(8/3)^20>300000000`, using the positive exponential series. Hence

\[
 Y_1<22000/300000000<1/1000.\tag{16}
\]

For (15), `sqrt(T)<39`, its denominator is greater than 1, and its polynomial sum is below 450000. Since `exp(330)>2^40`,

\[
 Y_4<39\cdot450000/2^{40}<1/1000.\tag{17}
\]

For clarity on the discarded denominators: `sqrt(2*pi*T)>80`, so `c*vartheta*sqrt(T)>5` and `c*sqrt(T)>20`; both sinh values exceed 1. In (15), additionally `.44*sqrt(2*pi)>1`, since `pi>3.14`. These ensure the inequalities have the required direction. Each sinh/exponential comparison can be certified by a finite positive Taylor lower sum; no floating evaluation is needed.

## 10. Final result, uniformity, and formal scope

Combining (11),(12),(16),(17),

\[
 |RS_1|\le J_1+J_2+J_3+J_4
       <(.001+1.82+2.31+.001)\tau^2
       =4.132\tau^2<4.2\tau^2.
\]

This holds for every real `t>=1500`, with no upper cutoff and no dependence on q in the bound. The source residual agrees with this integral on its actual q domain and at its upper endpoint; the closed lower endpoint is the continuous residual extension. The estimate uses true function values, not a finite approximation to the integral.

The scalar script `major-constants/gabcke_k1_scalar_20261111.py`, SHA `CDCAF0DB9559A875C74E0DD8BB52E7E7F7E012CF40ECFBBE296ED713D7FB062C`, already verifies the rational constants (and was independently checked by audit `7B404833...`). No author script or frozen receipt was rewritten for this task. The new elementary inequalities (6), the derivative factorization for W, and the Gamma-tail rearrangement have been proved algebraically above, not accepted by a numerical scan.

The genuinely new Lean work is finite and identifiable: the exact holomorphic defect/segment-FTC formula; real-part identity (4); the elementary f and W calculus; analytic removable extension and local arc removal; uniform integral domination; Gaussian moment substitutions and the tail integration by parts; and the scalar assembly. Pinned Mathlib has derivative, interval-FTC, improper-integral limit, Gaussian integrability, and complex analytic removable-singularity ingredients, but no ready-made theorem for this kernel. The basic sloping-contour S identity and the B0/B1 contour transport remain upstream tasks, separately covered by the named proof plans. This note does not add their conclusions as new assumptions to a final theorem or claim they are kernel-checked.
