# Gabcke K0: a shorter analytic proof target at height 1500

2026-11-11. Source-first research ledger and paper derivation; not an approved dependency graph, Lean declaration, or completed analytic proof. No Lean build, sign scan, canonical edit, or change to a frozen report was made.

The useful new reduction is that Gabcke's **first-order** integral remainder already implies

\[
 |Z(t)-Z_0(t)|<0.45t^{-3/4}<0.47t^{-3/4}\qquad(t\ge1500).
\]

Here `Z0` includes the usual `C0` correction and uses the actual normalized phase. This derivation needs only `P1`, `P2`, a third derivative bound for `F`, and a coarse phase bound. It avoids the order-10 remainder, its large coefficient tables, and its complex Taylor truncation. The contour representation and Gamma-phase estimate remain genuine analytic work. The stronger coefficient .45 is derived below, not quoted as a theorem printed in Gabcke.

## 1. Pinned sources and the exact consumer

Primary source: Wolfgang Gabcke, *Neue Herleitung und explizite Restabschätzung der Riemann-Siegel-Formel*, corrected electronic edition of the 1979 thesis, 2015, <https://d-nb.info/1072293277/34>. Local PDF `agents/mellin/gabcke_1979_corrected_2015.pdf`, SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. Printed page p is PDF page p+8 counting from one. I read the relevant primary text and visually checked the four-term bound on printed p48; its image is retained as `gabcke_blueprint_p48.png`. Earlier reviewed images cover pp53,55,72 and the coefficient table.

The prior independent source review is `agents/audit/GABCKE_PRINCIPAL_EVALUATOR_SOURCE_REVIEW_2026-11-11.md`. It accepts the transcription, not the analytic proof. The present note preserves that distinction.

Put

\[
 a=\sqrt{t/(2\pi)},\quad N=\lfloor a\rfloor,\quad z=1-2(a-N),
 \quad q=\sqrt\pi z,\quad \tau=(8t)^{-1/2}.
\]

Thus `-1<z<=1`, `|q|<=sqrt(pi)`, and `tau=1/(4*a*sqrt(pi))`. Define

\[
 F(z)=\frac{\cos(\pi(z^2+3/4)/2)}{\cos(\pi z)}
\]

with its removable values at `z=+/-1/2`, both equal to `1/2`. The target is

\[
 Z_0(t)=2\sum_{n=1}^{N}\frac{\cos(\theta(t)-t\log n)}{\sqrt n}
       +(-1)^{N-1}a^{-1/2}F(z).
\]

Gabcke's `theta` is the imaginary part of the holomorphic log-Gamma at `1/4+it/2`, normalized real on the positive axis, minus `(t/2)log pi`. It is not `arg(Gamma(...))` chosen independently at each point. `Z=exp(i*theta)*zeta(1/2+it)`.

Pinned Mathlib is commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, in the matching cached checkout `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. Its `NumberTheory/LSeries/HardyZ.lean:76` defines `hardyZ` as the real part of completed zeta divided by the norm of `Gammaℝ`. At line 79, `ofReal_hardyZ` identifies its complex coercion with that quotient. `Gamma/Deligne.lean:46` defines `Gammaℝ(s)=pi^(-s/2)*Gamma(s/2)`. Consequently the exact adapter is

\[
 \Gamma_{\mathbb R}(1/2+it)/|\Gamma_{\mathbb R}(1/2+it)|=e^{i\theta(t)}.
\]

Prove this from the normalized analytic Gamma logarithm and positive Gamma modulus; then the completed-zeta product identity gives equality with Mathlib's actual `hardyZ`, including its sign. Matching absolute values or zeros alone is insufficient. The library file itself lists the theta relation as a TODO at line 33.

## 2. What the printed .47 proof actually uses

Equation (3.26), p53, includes corrections `C0,...,CK`. Satz 3.2.2(a), pp54–57, gives `.47*t^(-3/4)` for `K=0`, uniformly for `t>=200`. Its proof first obtains the order-10 result:

1. Satz 3.1.5, p52, specializes the four-term integral bound of 3.1.3 to `K=10,t0=200,theta=3/4`. It proves `|RS10|<1.4e9*tau^11`.
2. Satz 4.2.4(b), pp74–75, replaces `U` by `u(tau)=exp(-i(tau^2/6+28*tau^6/45+3968*tau^10/315))`; together with the `Bn` bounds of 4.4.4(b), this gives the first `1.41e9*tau^11` error.
3. Cauchy truncation on the complex tau-circle of radius `3/5` bounds the additional error by `1.1e8*tau^11`. The source uses `sum |Bn|*(3/5)^n<322318` and a prefactor below 340. The combined bound is `1.52e9*tau^11`.
4. Multiplication by `(2*pi/t)^(1/4)` gives `|R10|<25966*t^(-23/4)`.
5. Formula (3.36), p57, adds the omitted `Cn/a^n`. The coarse uniform `Cn` bounds of 2.3.4(a), p38, imply .47 after freezing decreasing factors at `t=200`. Those bounds depend on the analytic derivative bounds of 2.3.1, the coefficient identity (2.27), and exact recurrence/table-II arithmetic. They do not need the decimal power-series tables used for part (b).

The independent script `agents/audit/gabcke_coarse_constants_review_20261111.py` checks the last scalar reduction and obtains a coefficient below `.466380`. This is not a proof of steps 1–4 or of the analytic `Cn` bounds.

There is no reason to formalize this entire route for a consumer restricted to `t>=1500`. The following specialization replaces steps 1–5. It does not claim the improved .45 bound down to height 200.

## 3. Low-order exact identities

Satz 1.2.1, p12, is the exact saddle-point representation

\[
 Z(t)=2\sum_{n=1}^{N}\frac{\cos(\theta-t\log n)}{\sqrt n}
       +(-1)^{N-1}a^{-1/2}\Re(U S),
 \qquad U=e^{i(\theta_0-\theta)},
\]

where `theta0=(t/2)log(t/(2*pi))-t/2-pi/8`, and

\[
 S=\frac{e^{i\pi/8-iq^2/2}}{2\sqrt\pi}
    \int_{\nearrow\,iq}\frac{e^{iv^2/2+qv}}{\cosh(\sqrt\pi v/2)}g(\tau,v-iq)\,dv,
\]

\[
 g(\tau,w)=\exp\left[\left(-\frac12+\frac{i}{8\tau^2}\right)
       \Log(1+2i\tau w)+\frac{w}{4\tau}-\frac{iw^2}{4}\right].
\]

The log domain is the plane cut upward from `i/(2*tau)`. The sloping contour is oriented from southwest to northeast. At `q=sqrt(pi)` the source specifies an indentation keeping the encountered pole on the left. Removing that convention without proving the limiting identity changes the formula.

The differential equation `(1+2*i*tau*w)*g_w=tau*(w^2-i)*g`, with `g(tau,0)=1`, gives the low-order polynomials

\[
 P_0=1,\quad P_1=w^3/3-iw,\quad
 P_2=w^6/18-(5i/6)w^4-(3/2)w^2.
\]

Equivalently, recurrence (1.23), p16, gives `a^(1)=(1,2)` and `a^(2)=(3,20,40)` in
`Pn=sum_k i^(k-n)*a_k^(n)*w^(n+2k)/(n+2k)!`. These exact small coefficients suffice.

Let `Bn` denote the integral with `g` replaced by `Pn`, as in (1.25), p16. Then `S=B0+B1*tau+RS1` by definition, not by an exchange of an infinite asymptotic series with an integral.

Write `Ftilde(q)=b0(q)`, the entire contour integral in 4.1.2. Equations (1.26)–(1.28), p17, imply

\[
 b_1=\widetilde F',\qquad b_3=\widetilde F'''+3i\widetilde F',
 \qquad B_1=b_3/3-i b_1=\widetilde F'''/3.
\]

The real part satisfies `Re Ftilde(q)=F(q/sqrt(pi))`, hence

\[
 \Re B_0=F(z),\qquad \Re B_1=F'''(z)/(3\pi^{3/2}).
\]

This establishes the only correction coefficient needed internally, `C1=F'''/(12*pi^2)`, without the general `Cn` recurrence or asymptotic uniqueness.

The needed bounds are

\[
 |B_0|\le1,\qquad |B_1|<8/5,\qquad |F'''(z)|\le4\pi\quad(|z|\le1).
\]

They follow from 4.1.3–4.1.4, 4.4.1, and the cases `m=1,3` of the moment estimate in the proof of 4.4.4, pp85–86. Explicitly `|b1|,|b3|<=2/sqrt(pi)`, so `|B1|<=8/(3*sqrt(pi))<8/5`. For `B0`, the cosh-ratio bound and the Gaussian integral give 1. Differentiating the real Gaussian representation three times gives the `n=1` case of (2.41), p35. Only three differentiations under a dominated Gaussian integral are required.

## 4. Exact first-order remainder bound at 1500

Satz 3.1.1, pp41–43, first proves the identity

\[
 RS_K=\frac{\varepsilon e^{i\pi/8}}{2\sqrt\pi}
   \int_{\mathbb R}\frac{e^{-u^2/2}Rg_K(\tau,\varepsilon u)}
     {\cosh(\sqrt\pi(iq+\varepsilon u)/2)}\,du,
 \quad\varepsilon=e^{i\pi/4}.
\]

The numerator vanishes at `u=0`; this cancels the possible simple pole at the endpoint values of q. Its exact variation-of-constants formula (3.5) is

\[
 Rg_K(\tau,w)=\tau^{K+1}w\int_0^1
 \frac{P'_{K+1}(wr)}{1+2i\tau wr}
 \exp\!\left(\tau w\int_r^1\frac{(wv)^2-i}{1+2i\tau wv}\,dv\right)dr.
\]

This can be proved directly by differentiating the integrating-factor expression; a general complex ODE existence theorem is unnecessary.

Satz 3.1.2, pp44–47, bounds this integrand on four ranges of u. It uses the elementary rational integral and inequalities in 4.4.2, pp81–84. In particular the far positive range has exponential `exp(.28*u^2)`, leaving the integrable Gaussian `exp(-.22*u^2)`. Dropping that decay or replacing all ranges by the worst positive-range exponent would lose the desired constant.

For the four integrated bounds of 3.1.3, take exactly

\[
 K=1,\quad t_0=1500,\quad \vartheta=1/4,
 \quad w=\frac14+\frac1{2\vartheta}
       -\frac1{\vartheta^2}\arctan\frac{\vartheta}{\vartheta+2}.
\]

The auxiliary `vartheta` is not the Hardy phase. Its hypotheses hold: `1500>7/.44` and `vartheta^2=1/16>14/1500`. Since `arctan(1/9)<=1/9`,
`w>=9/4-16/9=17/36`.

After substituting `(3,20,40)`, the middle two constants are

\[
 Y_1^{(2)}=\frac1{\sqrt2\pi}
  \left(\frac3{2w}+\frac5{6w^2}+\frac1{9w^3}\right)<1.82,
\]
\[
 Y_1^{(3)}=\frac2\pi\left(\frac32+\frac53+\frac49\right)<2.31.
\]

For the first tail, `vartheta*sqrt(1500)<10`, `vartheta^2*1500<100`, and its denominator is greater than 1. Its polynomial sum is at most
`9/4+(25/12)*100+(7/36)*100^2<2200`. Also
`exp(1500/64)>exp(20)>(8/3)^20>300000000`, using the positive exponential series. Therefore
`Y1^(1)<22000/300000000<.001`.

For the last tail, `sqrt(1500)<39`, its denominator `.44*sqrt(2*pi)*sinh(sqrt(2*pi*1500)/4)>1`, and its polynomial sum is below 450000. As `exp(330)>2^40`,
`Y1^(4)<39*450000/2^40<.001`.

These are valid upper bounds on the source's four constants, not diagnostic evaluations. They yield, uniformly over `|q|<=sqrt(pi)` and `t>=1500`,

\[
 |RS_1|<(1.82+2.31+.001+.001)\tau^2<4.2\tau^2.
\]

The incomplete-Gamma estimate 4.4.3 used by 3.1.3 can be proved by one integration by parts and monotonicity. For this specialization its parameters are `a=3/2,5/2,7/2`, all positive, and the tail thresholds satisfy the source inequalities. It does not require a general incomplete-Gamma formalization.

## 5. Phase factor and assembly of the .45 bound

Satz 4.2.3(d), p72, states for `t>=10`

\[
 \theta-\theta_0=1/(48t)+7/(5760t^3)+31/(80640t^5)+E,
 \quad |E|<1/(3322t^7).
\]

For `tau<=1/40` its absolute value divided by `tau^2` is bounded by the rational number

\[
 \frac16+\frac{28}{45\,40^4}+\frac{3968}{315\,40^8}
       +\frac{8^7}{3322\,40^{12}}<\frac15.
\]

Consequently `|U|=1` and `|U-1|<tau^2/5`. The exponential Lipschitz bound is already in Mathlib, as listed below. Thus

\[
 US=B_0+B_1\tau+E_1,
 \quad |E_1|\le |RS_1|+|U-1|(|B_0|+|B_1|\tau)<4.41\tau^2,
\]

because `(1/5)(1+(8/5)/40)<.21`. From the exact identities in section 3,

\[
 |Z-Z_0|<a^{-1/2}\left(\frac4{3\sqrt\pi}\tau+4.41\tau^2\right)
 =t^{-3/4}\left[\frac{(2\pi)^{3/4}}{3\pi}
            +\frac{4.41(2\pi)^{1/4}}{8\sqrt t}\right].
\]

Use `(2*pi)^(1/4)<198/125`, `pi>157/50`, and `sqrt(t)>38`. The bracket is strictly below

\[
 \frac{(198/125)^3}{3(157/50)}
 +\frac{(441/100)(198/125)}{8\cdot38}
 <0.444884<0.45<0.47.
\]

The accompanying `gabcke_k1_scalar_20261111.py` checks every displayed scalar comparison with `Fraction`. Its floating output is explanatory only. It does not certify the source analytic lemmas.

For an evaluator using the three-term phase approximation instead of actual theta, retain the separate main-sum error. On `1500<=t<=10^6`, the already reviewed `N<=398` estimate gives an additional `80/(3322*t^7)`. The .45 result leaves ample room to retain the published .47 budget after this phase substitution, but a formal consumer should either add that error explicitly or verify the small remaining inequality. The `C0` correction has no phase argument. At integral a the actual floor branch is `z=1`; use the contour endpoint convention and never infer continuity of the finite approximant. Actual HardyZ continuity supplies IVT.

## 6. Analytic dependencies that the short proof does not remove

**The first missing source bridge is earlier than 3.1.3.** Gabcke 4.1.1, p61, gives the rational Mordell-integral formula but refers its proof to Chandrasekharan, *Introduction to Analytic Number Theory* (1968), p35ff., or the German edition, Chapter V. It is not proved in the thesis. Only the cases with rational contour parameter 1 and 1/2 are needed here. A formal proof should establish those specific contour identities by Gaussian integration, shifts of a finite sloping contour, residues, and explicit vanishing of the closing edges. This note has not reconstructed the external proof and does not replace it with a hypothesis asserted to be a result.

The required order of substantive proofs is:

1. Define the sloping-line integrals with a fixed orientation and principal powers; prove absolute convergence, local parameter domination, and holomorphy. Prove the two needed Mordell identities. Apparent denominator zeros in their closed forms are removable because the integral is entire.
2. Follow 4.1.6, pp66–68: derive the Riemann–Siegel integral identity for real `s>1` by an absolutely convergent double integral, Fubini, rotated Gamma integrals, and the zeta Dirichlet series. Prove the branch factors during rotation. Extend the resulting meromorphic identity by analytic continuation. This is not supplied merely by the existing zeta functional equation.
3. Shift the sloping contour past the integers `1,...,N`, calculate the residues with orientation, and make the exact saddle substitution of section 1.2. This gives 1.2.1, including the special floor endpoint convention. No generic asymptotic saddle-point theorem is needed: the new residual `g` is exact.
4. Establish the `Rg1` integral by the differential identity, pole cancellation, and contour deformation, then prove the four elementary exponent bounds and Gaussian/incomplete-Gamma estimates. Only `P2` is needed.
5. Prove the Gaussian representation of `Ftilde` from the special Mordell identity. Prove the cosh and sinh ratios of 4.4.1 from their nonnegative power-series coefficients; derive the first and third moments and the third derivative of F by dominated differentiation.
6. Construct the normalized analytic log-Gamma and prove the explicit phase estimate used above. Gabcke 4.2.1(f), pp69–70, refers the complex Stirling remainder to Behnke–Sommer (1965), p303; its proof is another external analytic leaf. The printed phase proof uses reflection, duplication, and this bound on the imaginary axis, plus finite Bernoulli arithmetic. A campaign Binet-integral proof may replace that leaf after it is itself reviewed and formalized. A real factorial Stirling theorem does not suffice. Nor does the coarse phase error below .347 used only to preserve signs of a rotated zeta expression: here the error must be of order `1/t` to control `U-1`.
7. Identify the source Z with Mathlib HardyZ, then apply the exact scalar assembly. The theorem must quantify over every real `t>=1500`, including floor transitions.

This is a proposed proof order, not an approved graph or completed Lean dependency inventory.

## 7. Pinned Mathlib ingredients and their limits

Paths below are relative to the pinned `Mathlib` directory. These were inspected locally; there was no build.

| Needed operation | Existing source ingredient | Remaining specialization |
|---|---|---|
| Actual Hardy function | `NumberTheory/LSeries/HardyZ.lean:76–85`, `hardyZ`, `ofReal_hardyZ`, `abs_hardyZ`; continuity at 122 | Normalized Gamma-phase identity, not just equality of moduli. |
| Gamma integral and functional equation | `Analysis/SpecialFunctions/Gamma/Basic.lean:87`, complex `GammaIntegral_convergent` assumes positive real part; `Gamma_eq_integral` at 319; `Gamma_add_one` at 312; `Gamma_conj` at 356 | Rotated-ray integral and justified branch factors. |
| Gamma reflection/duplication/nonvanishing | `Gamma/Beta.lean:398`, complex `Gamma_mul_Gamma_one_sub`; 559 `Gamma_mul_Gamma_add_half`; 454 `Gamma_ne_zero_of_re_pos` | A holomorphic log normalized on positive reals, and explicit complex Stirling/Binet remainder. |
| Gaussian domination | `Analysis/SpecialFunctions/Gaussian/GaussianIntegral.lean:91,96`, integrability of real powers times a Gaussian for exponent greater than -1; 210 real Gaussian integral; 236 complex Gaussian integral when real part of coefficient is positive | Affine contour parameterization, moment substitutions, elementary tail bounds. |
| Parameter differentiation | `Analysis/Calculus/ParametricIntegral.lean:284`, `hasDerivAt_integral_of_dominated_loc_of_deriv_le` | Verify measurability, local derivative bounds by one integrable Gaussian majorant, and base integrability for the actual kernel. |
| Finite contour deformation | `Analysis/Complex/CauchyIntegral.lean:292`, `integral_boundary_rect_eq_zero_of_differentiableOn`; circle variants at 437ff. | Rotated rectangles/parallelograms via affine substitution, poles, endpoint indentations, and limits of unbounded edges. Existing target `Explicit/RectResidue.lean` handles rectangular integrals, not a ready-made Riemann–Siegel sloping contour. |
| Identity principle | `Analysis/Analytic/Uniqueness.lean:224`, `eqOn_of_preconnected_of_eventuallyEq` | Supply analyticity and initial equality on an appropriate connected domain; remove or separate poles. |
| Principal-log derivative | `Analysis/SpecialFunctions/Complex/LogDeriv.lean:37`, `hasDerivAt_log` on `slitPlane` | Explicit proof that each substituted segment avoids the cut. It does not give a global principal log of Gamma. |
| Integrating-factor FTC | `MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean:1176`, `integral_deriv_eq_sub`, with derivative integrability | The finite segment formula for `Rg1`, including its initial value. |
| Phase error in exponentials | `Analysis/SpecialFunctions/Trigonometric/Bounds.lean:286`, `norm_exp_I_mul_ofReal_sub_one_le`; cosine Lipschitz at 283 | Convert the real phase bound and multiply by the explicit finite main-sum norm. |

Scoped searches of the L-series, Gamma, and target Explicit files found no exported Mordell or Riemann–Siegel evaluator theorem and no complex Stirling remainder with the required constant. This is a scoped negative result, not a claim that no alternate formalization exists elsewhere.

## 8. Recommendation and limits

Use the low-order derivation in sections 3–5 as the proposed analytic target for the K0 sign checker at `t>=1500`, subject to independent review. It reaches the same .47 consumer without proving `R10`, `C2,...,C10`, their tables, or a degree-10 Cauchy remainder. The remaining complex-analysis work is substantial and explicit above.

The thesis also cites the older Titchmarsh estimate `1.50*(t/(2*pi))^(-3/4)` for `t>250*pi` in its introduction, p4. Its normalization is much weaker than `.47*t^(-3/4)`, and p5 explicitly says it did not always suffice for historical sign computations. This note does not select that bound or assert it would close the current chain.

Even the requested .47 bound only makes a **pointwise checker** sound: the interval around a computed approximant must exclude zero. It does not guarantee a whole sign chain succeeds. Difficult samples can be moved or checked with separately sound EM or higher-order formulas. No new numerical experiment, completed sign chain, verified zero location, or kernel theorem is claimed here.
