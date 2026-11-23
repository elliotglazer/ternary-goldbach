# Gaussian Fourier identity for primitive characters

2026-11-11. This is a mathematical derivation and source-level implementation plan. It proves the proposed normalization on paper, including both parities, complex characters and the exponential tilt. No Lean declaration, numerical evaluation, full-family computation or new assumption about zeros is supplied. Previously frozen reports are unchanged.

The identity follows from a primitive-character theta transformation, an absolutely convergent Mellin identity in Re(s)>1, entire continuation, and a contour shift of a rapidly decreasing holomorphic kernel. No interchange of the critical-line Dirichlet series with an integral occurs.

## 1. Exact functions and conventions

Let c>1 be an integer and chi an actual primitive complex Dirichlet character modulo c, with chi != 1. Extend chi to integers periodically, with value0 on nonunits. Let a in{0,1} satisfy chi(-1)=(-1)^a, and write k=a+1/2. Complex conjugation of chi is its inverse character, denoted bar chi. It has the same parity and conductor.

Use the positive additive character in the Gauss sum:

\[
 \tau(\chi)=\sum_{r\bmod c}\chi(r)e^{2\pi i r/c},\qquad
 W_\chi=\frac{\tau(\chi)}{i^a\sqrt c}.
\]

Primitive Gauss orthogonality gives |Wchi|=1. Fix one epsilon with |epsilon|=1 and epsilon^2 Wchi=1. This is a constant in t, not a separately chosen square root at each sample. No compatibility between independently chosen phases for chi and its inverse is assumed. An opposite-height reuse rule would require that separate phase adapter; the identity below is per character.

Define the entire conductor-completed function using the source's entire continuation:

\[
 \Lambda_\chi(s)=c^{(s+a)/2}\,\mathrm{completedLFunction}_\chi(s).
\]

For Re(s)>0, in particular on the critical line, this equals

\[
 (c/\pi)^{(s+a)/2}\Gamma((s+a)/2)L(s,\chi).
\]

At gamma poles the source entire function, rather than the pointwise product of totalized Gamma and L, is the definition. Every power of a positive real number uses its real logarithm.

For real t and real eta with |eta|<1, put b=pi*eta/4 and

\[
 Z_\chi(t)=\epsilon\Lambda_\chi(1/2+it),\qquad
 F_\eta(t)=c^{-k/2}e^{bt}Z_\chi(t).
\]

Thus the exact input expressed directly through Mathlib's completion is

\[
 F_\eta(t)=\epsilon e^{bt}c^{it/2}
                 \mathrm{completedLFunction}_\chi(1/2+it).                 \tag{1}
\]

The phase c^(it/2) cannot be dropped. The constant c^(-k/2)=c^(-(2a+1)/4) is positive, so it does not change signs relative to Zchi, but it changes the transform and error budget.

This note uses the angular-frequency convention

\[
 \widehat F(x)=\frac1{2\pi}\int_{\mathbb R}F(t)e^{-ixt}\,dt.
\]

The result, for every real x, is

\[
 \boxed{\widehat F_\eta(x)=
 2\epsilon c^{-(2a+1)/4}e^{(2a+1)u/2}
 \sum_{n=1}^{\infty}n^a\chi(n)
       \exp\left(-\frac{\pi n^2e^{2u}}c\right),
 \quad u=x+i\pi\eta/4.}                                                 \tag{2}
\]

Eta is not a complex parameter in this statement. Both sides are ordinary absolutely convergent integrals or series. The boundary values eta=+/-1 are excluded.

## 2. The primitive theta transformation

For Re(z)>0 define the positive-index theta series

\[
 \theta_\chi(z)=\sum_{n\ge1}n^a\chi(n)e^{-\pi n^2z/c}.
\]

It is holomorphic in that half-plane. On a compact subset with Re(z)>=delta>0, the j-th differentiated terms are bounded by a constant times n^(a+2j) exp(-pi*delta*n^2/c), a summable sequence. This proves normal convergence and all required termwise derivatives.

The full integer series is exactly2 theta_chi. Indeed the n and -n terms agree because (-n)^a chi(-n)=n^a chi(n); the term n=0 vanishes since c>1 and chi(0)=0, including a=0.

For z in this half-plane set f_a(v)=v^a exp(-pi*z*v^2/c), v real. With the ordinary frequency convention Fourier(f)(xi)=integral f(v) exp(-2*pi*i*v*xi) dv, its transform for the two possible parities is

\[
 \mathcal F f_a(\xi)=(-i)^a(c/z)^{a+1/2}\xi^a
                         e^{-\pi c\xi^2/z}.                             \tag{3}
\]

For a=0 this is the complex Gaussian Fourier formula. For a=1 differentiate that formula with respect to xi and use derivative(Fourier f)=Fourier(-2*pi*i*v*f). The interchange is dominated by a linear polynomial times a Gaussian. In particular the coefficient is -i, not+i. Principal powers are unambiguous because z and1/z have positive real part.

Apply Poisson to each residue progression r+cZ. Both f_a and its Fourier transform decrease faster than every inverse power, so both lattice sums are absolutely convergent. The result is

\[
 \sum_{\ell\in\mathbb Z}f_a(r+c\ell)
 =\frac1c\sum_{m\in\mathbb Z}e^{2\pi i mr/c}\mathcal Ff_a(m/c).
\]

Multiply by chi(r) and sum the finite residue set. For every m, including nonunits and0, primitive Gauss orthogonality gives

\[
 \sum_{r\bmod c}\chi(r)e^{2\pi i mr/c}
       =\tau(\chi)\bar\chi(m).                                           \tag{4}
\]

This is where primitivity is needed. At a nonunit m the right side is0, and (4) is stronger than a substitution that only proves the formula for units. The source `gaussSum_mulShift_of_isPrimitive` supplies precisely this all-residue statement.

At xi=m/c, formula(3) is (-i)^a sqrt(c) z^(-k) m^a exp(-pi*m^2/(c*z)). After the factor1/c in Poisson, its coefficient is tau(chi)/(i^a sqrt(c))=Wchi. Pairing the positive and negative terms on both sides therefore yields

\[
 \theta_\chi(z)=W_\chi z^{-k}\theta_{\bar\chi}(1/z),
       \qquad \operatorname{Re}z>0.                                    \tag{5}
\]

There is no extra factor2, conductor power, or parity sign in(5). The principal logarithm defines z^(-k). The omitted zero modes are genuinely zero; a principal or imprimitive character cannot simply be substituted into this proof.

## 3. Uniform decay and the entire Mellin identity

For an explicit useful domination, choose0<=B<pi/4 and set

\[
 d_B=\frac{\pi\cos(2B)}c>0,\qquad
 C_a(d_B)=\sum_{n\ge1} n^a e^{-d_B(n^2-1)}<\infty.
\]

For w=v+iy with |y|<=B and v>=0, the defining series gives

\[
 |\theta_\chi(e^{2w})|\le C_a(d_B)e^{-d_B e^{2v}}.
\]

For v<=0, formula(5) and |Wchi|=1 give

\[
 |\theta_\chi(e^{2w})|\le
 C_a(d_B)e^{-2kv}e^{-d_B e^{-2v}}.                                      \tag{6}
\]

The same C works for the inverse character since both have |chi(n)|<=1. On the positive real z-axis this is exponential decay at infinity and an inverse-exponential bound z^(-k) exp(-pi/(c*z)) at0. Consequently the integral

\[
 I_\chi(s)=\int_0^\infty\theta_\chi(y)y^{(s+a)/2}\,\frac{dy}{y}           \tag{7}
\]

converges absolutely for every complex s and defines an entire function. For s in a compact set, the powers of y lie between two fixed real powers. The bounds above dominate them at both ends, also after any fixed power of |log y| from differentiation. This justifies holomorphy by dominated differentiation. Equivalently, the existing Mellin differentiability theorem applies on any finite vertical strip because theta satisfies arbitrarily strong power bounds at both ends.

Only when Re(s)=sigma>1 do we now interchange the series with the integral. The sum of the integrals of norms is at most

\[
 \Gamma((\sigma+a)/2)(c/\pi)^{(\sigma+a)/2}
                  \sum_{n\ge1}n^{-\sigma}<\infty.
\]

The gamma integral and the source L-series identity give

\[
 I_\chi(s)=(c/\pi)^{(s+a)/2}\Gamma((s+a)/2)
                  \sum_{n\ge1}\chi(n)n^{-s}=\Lambda_\chi(s)
                    \quad(\operatorname{Re}s>1).                        \tag{8}
\]

Both I and the source conductor-completed Lambda are entire for the specified nonprincipal character. The identity theorem extends(8) to all s. In particular(7) at s=1/2+it is the integral of the already summed theta function; it is not an interchange of the critical-line Dirichlet series.

As a consistency check, substituting(5) into(7) and changing y to1/y gives

\[
 \Lambda_\chi(s)=W_\chi\Lambda_{\bar\chi}(1-s),                           \tag{9}
\]

with the same root number as the source functional equation. Conjugating the absolutely convergent integral also gives

\[
 \overline{\Lambda_\chi(s)}=\Lambda_{\bar\chi}(\bar s).
\]

Hence Lambda_chi(1/2+it)=Wchi*conj(Lambda_chi(1/2+it)). Since epsilon Wchi=conj(epsilon), Zchi is real. This proves real-valuedness structurally; an imaginary interval containing0 would not be a substitute.

## 4. Fourier inversion and the complex shift

On the horizontal strip |Im w|<pi/4 define

\[
 h(w)=2\epsilon c^{-k/2}e^{kw}\theta_\chi(e^{2w}).
\]

It is holomorphic. For every closed substrip |Im w|<=B<pi/4, equations(6) give the uniform bound

\[
 |h(v+iy)|\le2c^{-k/2}C_a(d_B)
                    \exp\{k|v|-d_Be^{2|v|}\}.                           \tag{10}
\]

In particular h tends to0 faster than every inverse power at both real ends, uniformly in that substrip. Derivatives have the same qualitative decay: use Cauchy estimates on a fixed-radius disk contained in a slightly larger closed substrip, then apply(10) at real coordinates within that fixed radius. Thus each h_b(v)=h(v+ib), |b|<pi/4, is smooth, and h_b,h_b',h_b'' are integrable and vanish at both real ends. Full Schwartz regularity also follows, but only these first two derivatives are needed for ordinary Fourier inversion.

In(7), set y=e^(2v). Then dy/y=2dv and

\[
 F_0(t)=\int_{\mathbb R}h(v)e^{itv}\,dv.                                 \tag{11}
\]

For fixed real t, shift this integral along the rectangle with vertices -R,R,R+ib,-R+ib. The integrand h(w)e^(itw) is holomorphic on a neighborhood of that rectangle. Choose |b|<B<pi/4. On the vertical edges, |e^(itw)|<=exp(|t|B), and(10) makes their integrals tend to0 as R tends to infinity. The horizontal integrals are absolutely convergent. Cauchy-Goursat therefore gives, for either sign of b,

\[
 \int_{\mathbb R}h(v+ib)e^{it(v+ib)}\,dv
        =\int_{\mathbb R}h(v)e^{itv}\,dv,
\]

or, equivalently,

\[
 \int_{\mathbb R}h_b(v)e^{itv}\,dv=e^{bt}F_0(t)=F_\eta(t).                \tag{12}
\]

This proves the positive sign of the imaginary shift in(2). For b negative the oriented rectangle or its reversal gives the same identity; no positivity assumption on eta was used.

Twice integrating(12) by parts gives, for |t|>=1,

\[
 |F_\eta(t)|\le\|h_b''\|_1/t^2,
\]

and for all t, |Feta(t)|<=||h_b||_1. Hence Feta is integrable. In Mathlib's 2*pi convention, (12) reads

\[
 F_\eta(t)=\mathcal F^{-1}h_b(t/(2\pi)).
\]

Change variables t=2*pi*y in the defining angular transform. Fourier inversion now gives

\[
 \frac1{2\pi}\int F_\eta(t)e^{-ixt}dt
 =\mathcal F(\mathcal F^{-1}h_b)(x)=h_b(x)=h(x+ib),
\]

which is exactly(2). Every integrability and continuity premise of the inversion theorem has been supplied by(10) and its derivative consequences. No gamma asymptotic, Riemann-Siegel theorem, zero-free region, GRH premise or Turing bound is used in this evaluator identity.

## 5. Explicit finite Gaussian sum error

The identity leaves an elementary summation problem at each frequency x. Put

\[
 d=\frac{\pi e^{2x}}c\cos(\pi\eta/2)>0.
\]

For truncation after n=M>=0, consecutive omitted absolute summands satisfy the following bounds. For a=0 their ratio is at most r0=exp(-d(2M+3))<1, so the omitted series has norm at most

\[
 E_0=\frac{e^{-d(M+1)^2}}{1-e^{-d(2M+3)}}.
\]

For a=1 their ratio is at most r1=((M+2)/(M+1))*exp(-d(2M+3)); if r1<1 the omitted series has norm at most

\[
 E_1=\frac{(M+1)e^{-d(M+1)^2}}{1-r_1}.
\]

The actual transform error is at most2*c^(-k/2)*exp(k*x)*E_a. The imaginary exponential in the prefactor has modulus1. This error is independent of the unknown phases of chi and does not assume cancellation in the tail. Root-of-unity, exponential, pi and root-phase rounding still need separate interval enclosures in a numerical checker.

For strongly negative x, direct summation has a small d. Formula(5) is an exact alternative representation using the inverse character and reciprocal argument, so the same proof can support a stable two-sided evaluator. A discrete FFT still additionally requires proved frequency-periodization and time-periodization bounds; the identity and the tail above alone do not certify a sampled transform or its signs.

## 6. Existing source interfaces and new adapters

Source pins are unchanged: Goldbach commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`; Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679` at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. The following declarations were read at that pin. Paths beginning `Mathlib/` are relative to its root; the other paths are relative to `work/ternary-goldbach/TernaryGoldbach`.

| Source | Actual interface and use |
| --- | --- |
| `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:404,532,535` | `conductor_inv`; `Odd` and `Even` are exactly the values -1 and1 at -1. |
| `Mathlib/NumberTheory/MulChar/Lemmas.lean:73,79` | `star_eq_inv`, `star_apply'` give the inverse/conjugation adapter. |
| `Mathlib/NumberTheory/DirichletCharacter/GaussSum.lean:57` | `gaussSum_mulShift_of_isPrimitive` gives(4) for every residue, including nonunits. |
| `Mathlib/Analysis/Fourier/ZMod.lean:219` | `DirichletCharacter.IsPrimitive.fourierTransform_eq_inv_mul_gaussSum` uses the negative-exponent DFT and returns chi^(-1)(-m)*tau. This minus sign is consistent with(4), whose exponent is positive. |
| `Prelim/GaussInduced.lean:175` | `TernaryGoldbach.norm_sq_gaussSum_of_isPrimitive` proves norm(tau)^2=c. |
| `Explicit/LGrowthLeft.lean:221` | `TernaryGoldbach.Explicit.norm_rootNumber` proves norm(rootNumber chi)=1 with only primitivity and positive modulus. |
| `Mathlib/Analysis/SpecialFunctions/Gaussian/FourierTransform.lean:208,228` | `fourier_gaussian_pi'` and `fourier_gaussian_pi` accept complex b with positive real part and give the exact principal-power Gaussian transform. |
| `Mathlib/Analysis/Fourier/FourierTransformDeriv.lean:784,792` | `Real.deriv_fourier` and `Real.fourier_deriv` require the relevant integrability/differentiability hypotheses. They supply the odd Gaussian and the decay from derivatives. |
| `Mathlib/Analysis/Fourier/PoissonSummation.lean:190,201,215` | `Real.tsum_eq_tsum_fourier_of_rpow_decay_of_summable`, `Real.tsum_eq_tsum_fourier_of_rpow_decay`, and `SchwartzMap.tsum_eq_tsum_fourier`. These are shifted unit-lattice formulas; scaling to r+cZ is a new adapter. |
| `Mathlib/Analysis/SpecialFunctions/Gaussian/PoissonSummation.lean:47,54,84` | Gaussian decay lemmas and `Complex.tsum_exp_neg_quadratic`. The latter is an alternative route for the even shifted lattice; it is not already a character-weighted theta theorem. |
| `Mathlib/Analysis/Complex/LocallyUniformLimit.lean:171` | `differentiableOn_tsum_of_summable_norm` supplies normal convergence once local summable majorants are given. |
| `Mathlib/NumberTheory/LSeries/MellinEqDirichlet.lean:24,118,134` | `hasSum_mellin`, `hasSum_mellin_pi_mul_sq`, `hasSum_mellin_pi_mul_sq'` make the absolutely convergent interchange explicit. The first with exponent(s+a)/2 and rate pi*n^2/c directly yields(8). |
| `Mathlib/Analysis/MellinTransform.lean:91,320,401` | `mellin`, `mellin_hasDerivAt_of_isBigO_rpow`, `mellin_differentiableAt_of_isBigO_rpow`. Arbitrary two-end power bounds from(6) give the entire Mellin continuation. |
| `Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:74,249,258,271,283` | `LFunction_eq_LSeries` only for Re(s)>1; entire nonprincipal completed L; `LFunction_eq_completed_div_gammaFactor`; exact `rootNumber`; and `IsPrimitive.completedLFunction_one_sub`. The source FE is completion_chi(1-s)=c^(s-1/2)*Wchi*completion_inv(s), which becomes(9) after conductor normalization and replacing s by1-s. |
| `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:48,69` | `Gammaℝ_def` and positive-real-part nonvanishing justify completion=Gammaℝ(s+a)*L on the half-plane used in(8) and on the critical line. |
| `Mathlib/Analysis/Analytic/Uniqueness.lean:224` | `AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq` supports the entire identity continuation after the holomorphy adapters. |
| `Mathlib/Analysis/Complex/CauchyIntegral.lean:279,292` | Rectangle Cauchy-Goursat formulas with continuity/differentiability on the specified rectangle. The infinite contour shift still needs the decay and limit proof given above. |
| `Mathlib/Analysis/Fourier/Inversion.lean:184,193` | `MeasureTheory.Integrable.fourier_fourierInv_eq` and `Continuous.fourier_fourierInv_eq` require integrability of f and its Fourier transform. Equation(10) and two derivatives discharge these mathematically. |
| `Mathlib/Analysis/MellinInversion.lean:49,92` | `mellin_eq_fourier` and `mellinInv_mellin_eq` offer an alternative inversion route, with an explicit2*pi rescaling and a vertical-integrability premise. |

The needed new packaged results are therefore concrete: a parity-unified Gaussian lattice transform; the character theta transformation with its sector bounds; the entire theta-Mellin/source-completion identity; the two-ended strip-decay and contour-shift lemma; and the final normalization adapter(1)-(2). These are not present as a single theorem at the inspected source pin. This note derives them from the stated source tools and elementary estimates, but does not claim that their Lean implementations exist.

The arithmetic manifest and root-number phase remain separate finite data interfaces. The previous character-manifest review accepted the indexing proof plan, including imprimitive ambient recovery; this evaluator only takes the actual primitive nonprincipal conductor character. The c=1 zeta row needs its separate theta constant/pole corrections and is excluded from this statement.

## 7. Scope and handoff

The formula in the frozen family production plan and endpoint addendum is correct with their clarified input F_a. Both the factor2 and c^(-(2a+1)/4) survive the derivation. The source completion requires c^(it/2); the tilt requires the positive imaginary shift. The theta transformation supplies exactly the missing decay at the negative end of the log variable. The proof works equally for real and nonreal primitive characters and both parities.

What remains for a production certificate is formalizing these adapters, proving interval arithmetic and root-phase choices, providing FFT periodization/interpolation error theorems and actual data, and proving the independent count-completeness bound. This note does not certify any family height or change Hcert. No timing or evidence-size forecast is made.

Independent review is requested from the integration worker. No source build or numerical experiment was run for this note.
