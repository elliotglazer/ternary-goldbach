# Actual radial Fourier separation envelope

Date: 2026-11-11. Source and paper audit only. No Lean edits, declarations, builds, analytic evaluations or scans.

The checked source proves a scale-uniform separation envelope for the actual paper-normalized radial Fourier kernel. The Euler derivative hypothesis of the general separation lemma is supplied by a concrete Schwartz construction, not left as a new assumption. The compact logarithmic cutoff gives the required uniformity in the positive radial scale. The weighted integrals are integrable by the Schwartz estimates used in their construction.

This is a bounded local-source PASS. The remaining foundations include Mathlib's Schwartz Fourier transform, inversion, composition and weighted-integral theorems. This report does not validate the full cubic improvement or establish that every later family of input tests has uniformly bounded Schwartz seminorms.

All source paths below are relative to work/openai-math/lean/OAI/NumberTheory/DirichletL. The final table pins their versions.

## 1. Exact conclusion and parameter dependence

QuadraticSieve/IdealQuotients.lean:415, paperRadialFourier_log_separation_envelope, fixes a Schwartz function \(W:\mathbb R\to\mathbb C\), a finite index type, arbitrary functions \(V_j:\mathbb R\to\mathbb C\), real slopes \(a_j\), nonnegative widths \(M_j\), and natural orders \(A,J\). It assumes only

\[
 V_j(y)\ne0\ \Longrightarrow\ |y|\leq M_j
\]

for the window functions. It then chooses \(C\geq0\) before every \(R>0\), and for each such \(R\) chooses a Schwartz function \(b_R\), such that for every vector \(y\),

\[
 \prod_j V_j(y_j)\,F\!\left(R e^{\sum_j a_jy_j}\right)
 =\int_{\mathbb R}
   \prod_j\left(V_j(y_j)e^{2\pi i t a_jy_j}\right)b_R(t)\,dt,
 \qquad F=\operatorname{paperRadialFourier}(W),
\]

\[
 (1+R)^A\int_{\mathbb R}(1+|t|)^J|b_R(t)|\,dt\leq C,
 \qquad
 (1+R)^A(1+|t|)^J|b_R(t)|\leq C.
\]

The weighted integrability assertion is explicit. The same \(b_R\) serves every \(y\). Neither \(C\) nor \(b_R\) is chosen separately for each row value.

The statement does not make \(C\) uniform over arbitrary Schwartz functions, slopes, widths or derivative orders. The proof's dependence on the windows is only through their common support box; section 6 explains the stronger shared-window version actually used downstream. No measurability or smoothness of \(V_j\) is needed because \(y\) is fixed inside this one-dimensional Fourier integral. The result by itself does not justify a later integration in arbitrary \(y\).

## 2. Actual radial kernel and its normalization

GaussSum/SexticRadialPoisson.lean:234 and :304 define

\[
 \xi(u)=\frac{2i}{\sqrt3}\overline u,\qquad
 \operatorname{paperFourier}(f)(u)
 =\frac2{\sqrt3}\int_{\mathbb C}\operatorname{paperE}(-zu)f(z)\,dz.
\]

Here paperE has the explicit exponential
\(\exp(4\pi i\,\operatorname{Im}(z)/\sqrt3)\). The equality at line 307 proves

\[
 \operatorname{paperFourier}(f)(u)
 =\frac2{\sqrt3}\widehat f(\xi(u)).
\]

Thus the conjugated frequency and covolume factor are part of the actual function. At line 426,

\[
 F(x)=\operatorname{paperFourier}
       (z\mapsto W(\|z\|^2))(\sqrt{x}).
\]

Poisson/RadialFourier.lean constructs radialTestCLM by Schwartz composition with \(z\mapsto\|z\|^2\). The growth estimate required for that composition follows from \(\|z\|\leq1+\|z\|^2\); it is not an arbitrary smooth pullback assumed to preserve Schwartz decay. radialFourierCLM applies the Schwartz Fourier transform to this actual radial test. The real-ray pullback along \(\xi(s)\) also satisfies the required growth estimate.

Consequently paperFourierRayCLM produces a genuine one-dimensional Schwartz function \(g\), including the factor \(2/\sqrt3\), with

\[
 F(x)=g(\sqrt{x}).
\]

The source does not claim ordinary smoothness of this expression across \(x=0\). The separation theorem requires smoothness only on \(x>0\), which follows from the smooth square root there. Every logarithmic input is positive because \(R>0\).

## 3. Euler derivatives and rapid decay

Fourier/PositiveLogProfiles.lean:264 defines the Euler derivative by

\[
 E_jF(x)=
 \left.\frac{d^j}{du^j}F(xe^u)\right|_{u=0}.
\]

Poisson/RadialFourier constructs the continuous linear Schwartz operator
\(\mathcal H g(s)=\frac{s}{2}g'(s)\). Since
\(\sqrt{xe^u}=\sqrt{x}e^{u/2}\) for \(x\geq0\), ordinary chain differentiation gives

\[
 E_jF(x)=\mathcal H^j g(\sqrt{x}).
\]

The source proves this by induction along the half-flow. It avoids division by \(\sqrt{x}\), so its Euler identity also holds at zero.

For any Schwartz function \(q\) and \(x\geq0\), splitting \(x\leq1\) and \(x\geq1\) gives

\[
 (1+x)^A|q(\sqrt{x})|
 \leq 2^A\bigl(p_{0,0}(q)+p_{2A,0}(q)\bigr),
\]

where \(p_{k,n}\) denotes the Schwartz seminorm with weight \(|s|^k\) and derivative order \(n\). Applying this to each \(\mathcal H^j g\) proves the actual Euler decay estimate.

At RadialFourier:358, continuity of the finitely many operators \(W\mapsto\mathcal H^j g\), \(j\leq K\), bounds these output seminorms by a constant times a finite supremum of input seminorms. The proof sums the finitely many continuous seminorms and applies Seminorm.bound_of_continuous. At line 418 this supplies a finite \(C_F\geq0\) such that

\[
 (1+x)^A|E_jF(x)|\leq C_F
 \quad(x>0,\ j\leq K).
\]

This provides the hypothesis passed to the general logarithmic separation theorem. It is not evidence for one numerical universal value of \(C_F\). A later varying family \(W_\alpha\) needs its own uniform bound on the finite input seminorms.

## 4. Uniform logarithmic cutoff and the substantive derivative estimate

IdealQuotients:305 applies the general construction with

\[
 T=\sum_j|a_j|M_j,\quad L=T+1,\quad
 m=e^{-L},\quad K=J+p,
 \qquad p=\operatorname{volume.integrablePower}.
\]

Mellin/LogProfiles.lean:1230–1300 constructs a smooth compactly supported cutoff \(V\) equal to one on \([-T,T]\), supported in \([-L,L]\), with all derivatives through order \(K\) bounded by one finite constant \(C_W\). Every point where any such derivative is nonzero lies in that support, so \(e^s\geq m>0\) there. Both the cutoff and its derivative bound are chosen before \(R\).

Set

\[
 g_R(s)=V(s)F(Re^s),\qquad b_R=\widehat{g_R}.
\]

PositiveLogProfiles:312 proves \(g_R\) is Schwartz by smoothness on the positive argument and compact support. In particular, its definition does not assume global ordinary smoothness of \(F\).

The key uniform inequality at lines 352 onward is

\[
 m(1+R)\leq1+Re^s
\]

on the derivative support, since \(m\leq1\) and \(m\leq e^s\). Put \(S=m^A(1+R)^A\). The exact logarithmic shift identity identifies the \(i\)-th derivative of \(F(Re^s)\) with \(E_iF(Re^s)\). Leibniz then yields

\[
 S|g_R^{(n)}(s)|
 \leq \sum_{i=0}^n {n\choose i}C_WC_F
 =2^n C_WC_F \quad(n\leq K).
\]

Outside the union of the cutoff derivative supports, every Leibniz term vanishes. This step is explicitly handled in positive_log_uniform_seminorm; it does not apply the support bound to a point where its premise is false. Multiplying by \(|s|^k\) therefore gives

\[
 S\,p_{k,n}(g_R)\leq L^k\,2^nC_WC_F.
\]

The source's nonnegative momentConstant is

\[
 P=\sum_{n=0}^{K}(1+L^p)\,2^nC_WC_F.
\]

Thus, for every \(n\leq K\),
\(S(p_{0,n}(g_R)+p_{p,n}(g_R))\leq P\).
All constants in this bound are independent of \(R\). The cost \(m^{-A}=e^{A(T+1)}\) remains in the final answer and is not discarded.

## 5. Weighted L1 construction, pointwise bound and inversion

Let

\[
 V_p=2^p\int_{\mathbb R}(1+|t|)^{-p}\,dt.
\]

The source uses the measure's designated integrable power and the associated Schwartz weighted-integral theorem. It does not choose an arbitrary exponent and assume this integral finite.

Mellin/LogProfiles:789 reduces the Fourier seminorm estimate to Real.pow_mul_norm_iteratedFDeriv_fourier_le. Its hypotheses include the actual Schwartz smoothness and integrability of every required weighted derivative. At line 810 the source applies the weighted-integral estimate to each derivative and obtains

\[
 S p_{k,0}(\widehat{g_R})
 \leq2^k(k+1)V_pP.
\]

Applying the same weighted-integral inequality on the Fourier side gives the coefficient moment bound at line 869. In the source notation,

\[
 \operatorname{coefficientMomentBound}(j,P)
 =V_p\bigl(V_pP+2^{j+p}(j+p+1)V_pP\bigr).
\]

Hence

\[
 S\int (1+|t|)^J|b_R(t)|\,dt
 \leq B:=2^J\bigl(
 \operatorname{coefficientMomentBound}(0,P)+
 \operatorname{coefficientMomentBound}(J,P)\bigr).
\]

The separate pointwise estimate at IdealQuotients:273 uses the Fourier seminorms of weights zero and \(J\), giving

\[
 S(1+|t|)^J|b_R(t)|
 \leq B_{\rm pt}:=2^J
       \bigl(V_pP+2^J(J+1)V_pP\bigr).
\]

The final choice \(C=(B+B_{\rm pt})/m^A\) proves both requested inequalities. The derivative order \(J+p\) is essential to the L1 argument; just \(J\) derivatives would not supply the stated weighted integral.

Integrability is independent of interpreting a possibly nonintegrable totalized integral. GaussSum/CubicNormalization.lean:424 explicitly derives it from the Schwartz integrability of \(|b_R|\) and \(|t|^J|b_R|\), using
\((1+|t|)^J\leq2^J(1+|t|^J)\). For each fixed \(y\), the separation integrand has constant window amplitude times a unit-modulus phase times \(b_R\), and is integrable as well.

The inversion is the actual Schwartz Fourier inversion at LogProfiles:411. The inverse phase is \(e^{+2\pi its}\), consistent with logPhase. If the product of windows is nonzero, \(|\sum a_jy_j|\leq T\) and \(V=1\). If that product is zero, both sides vanish. The phase splits by the finite exponential product law; no factor \(2\pi\), Jacobian or change of frequency variable is omitted.

## 6. Uniformity at the actual consumers

CubicSieve/KernelEnergy.lean:625 uses two slopes equal to minus one and asks the envelope at order \(J+2\). It obtains a common dominating density

\[
 \operatorname{firstLogDensity}_J(t)=(1+|t|)^{-(J+2)}.
\]

Lines 609–622 prove that density and its \(J\)-weighted version are integrable; the latter is exactly \((1+|t|)^{-2}\). The coefficient depends on the positive radial scale, but its dominating measure does not. The subsequent actualFirstKernel_eq_separated preserves its exterior scale factor and cube coefficient. Proving that full arithmetic identity lies outside this envelope audit.

A stronger quantifier issue is resolved explicitly in Descent/FirstProfileUniform.lean:124. radial_common_box first applies the envelope to the fixed indicator functions of the nine-coordinate support box. Only after obtaining \(b_R\) does it introduce arbitrary windows with those supports. On their nonzero product the indicators equal one, and on their zero product both sides vanish. Thus one coefficient works simultaneously for all these windows; this conclusion does not follow merely by swapping existential and universal quantifiers in the original statement.

The common_measure consumer at line 197 chooses a box of widths \(M_i+B_i\) before the shifts \(\rho_i\) with \(|\rho_i|\leq B_i\). The translated support inclusion is proved separately. Its \(b_R\) is chosen before those shifts, clipping levels and height twists. The remaining height dependence is charged to the Fourier moments of the twisted windows. The consumer's density_weighted_integrable and density_weighted_integral supply its product integration step; the radial lemma alone is not used as a blanket Fubini justification.

## 7. Scope and remaining foundations

The audit reconstructed the actual normalized kernel, its Euler derivative representation, the finite-seminorm decay bound, the support-sensitive product derivative estimate, the weighted L1 and pointwise constants, the Fourier phase, and the shared-window selection used by the first-profile consumer. No missing scale factor, circular Euler assumption, unsupported ordinary derivative at zero, or loss of uniformity in \(R\) was found.

The lower analytic foundations consumed here are SchwartzMap.compCLM with its stated growth hypothesis, the Schwartz Fourier continuous linear map and inversion, Real.pow_mul_norm_iteratedFDeriv_fourier_le, SchwartzMap.integral_pow_mul_iteratedFDeriv_le, the designated integrable-power theory, smooth compact cutoff existence and derivative-support containment, and finite continuous-seminorm control. Their applications and relevant hypotheses were checked; this report does not reprove their Mathlib internals.

The conclusion requires \(R>0\). It does not handle a zero physical frequency by continuity without a separate argument. It does not assert a measurable choice of \(R\mapsto b_R\), which the displayed pointwise/finite-row consumers do not require. It does not make the final constant uniform under unbounded support widths or arbitrary unbounded Schwartz families. These remain explicit limits when composing the envelope with other estimates.

## Source pins

Hashes freeze the files used; only the named portions are within this bounded audit.

| Source file | SHA-256 |
| --- | --- |
| QuadraticSieve/IdealQuotients.lean | 3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499 |
| Poisson/RadialFourier.lean | 86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58 |
| GaussSum/SexticRadialPoisson.lean | 8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C |
| Fourier/PositiveLogProfiles.lean | F35DE7EF62C99B19FA5D50501E84AB0CFD751C5318459A78C0A43EE597901E4D |
| Mellin/LogProfiles.lean | 0F808D2AD89AF54F26A3308078B12920B0A4E93C3B206727A22B26CC80AAE4E1 |
| GaussSum/CubicNormalization.lean | DE04E573BD90BA00B0C545F030C01F7ED0D8CCD4BCD5D0107B53D95DD5EB6915 |
| CubicSieve/KernelEnergy.lean | C884D02BE56E92D79EDD4C6F6821359880483CE57C247EEF49E30298F56DD6D0 |
| Descent/FirstProfileUniform.lean | 77351AE45B77FF7A31D27C7A70BA8A217970488C359FFBDA4BE54ED497D29761 |
