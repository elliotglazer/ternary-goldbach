# Off-critical Gaussian Fourier evaluation for primitive characters

2026-11-11. Mathematical derivation and source-level proof plan. No L-function scan, FFT computation, Lean build, dependency change or frozen-file edit. Two small exact rational comparisons in Section 7 were checked with Python `Fraction`; they contain no character or spectral data.

The reviewed Gaussian identity extends to every fixed real sigma in (0,1). Its output is generally complex. The positive- and negative-frequency decay rates become 1-sigma and sigma, and inverse-character reciprocity acquires the factor c^(1/2-sigma). These changes permit a direct contour-evaluation route without assuming Hardy realness or simple critical-line zeros. They do not supply any actual missing contour data.

## 1. Inputs, normalization and source function

Let c>1 and let chi be an actual primitive nonprincipal complex Dirichlet character modulo c. Its parity is a in {0,1}. Use

\[
 \theta_\chi(z)=\sum_{n\ge1}n^a\chi(n)e^{-\pi n^2z/c},\qquad
 W_\chi=\tau(\chi)/(i^a\sqrt c),\quad |W_\chi|=1,
\]

where tau uses the positive additive exponential. The inverse character is written bar-chi. It has the same parity and conductor. Fix a constant unit complex number epsilon_chi. The transform identity does not require epsilon_chi^2 W_chi=1; existing certified root phases satisfying that condition can be retained. In particular, a complex-valued evaluator could instead choose epsilon_chi=1 and avoid square-root phase selection.

Define the entire conductor-completed source function by

\[
 \Lambda_\chi(s)=c^{(s+a)/2}\operatorname{completedLFunction}_\chi(s).
\]

This uses the actual continued completion. It is not defined as a product of totalized Gamma and L at a Gamma pole. For Re(s)>0 the source relation gives

\[
 \Lambda_\chi(s)=(c/\pi)^{(s+a)/2}
       \Gamma((s+a)/2)L(s,\chi).
\]

Let 0<sigma<1, eta be real with |eta|<1, and b=pi*eta/4. The precise Fourier input is

\[
 F_{\sigma,\chi,b}(t)
 =\epsilon_\chi e^{bt}c^{-(\sigma+a)/2}\Lambda_\chi(\sigma+it)
 =\epsilon_\chi e^{bt}c^{it/2}
       \operatorname{completedLFunction}_\chi(\sigma+it).                 \tag{1}
\]

Every power of c uses its real logarithm. The factor c^(it/2) remains mandatory. No assertion that (1) is real-valued is made.

Use the angular Fourier convention

\[
 G_{\sigma,\chi,b}(x)=\frac1{2\pi}\int_{\mathbb R}
                         F_{\sigma,\chi,b}(t)e^{-ixt}\,dt.
\]

Then, with u=x+ib,

\[
 \boxed{G_{\sigma,\chi,b}(x)
  =2\epsilon_\chi c^{-(\sigma+a)/2}e^{(\sigma+a)u}
       \theta_\chi(e^{2u}).}                                          \tag{2}
\]

The inverse is F(t)=integral G(x)exp(ixt)dx, with no extra factor. Setting sigma=1/2 recovers the accepted critical-line normalization exactly.

## 2. Derivation without a conditionally convergent interchange

The accepted primitive theta transformation is

\[
 \theta_\chi(z)=W_\chi z^{-(a+1/2)}\theta_{\bar\chi}(1/z),
                \qquad \Re z>0.                                     \tag{3}
\]

It uses the all-residue primitive Gauss identity, including zero and nonunit frequencies. It is not valid with the same formula for an arbitrary imprimitive or principal character. The powers use the principal logarithm on the right half-plane.

The previously derived entire Mellin identity is

\[
 \Lambda_\chi(s)=\int_0^\infty
          \theta_\chi(y)y^{(s+a)/2}\,\frac{dy}{y}.                       \tag{4}
\]

Its proof first interchanges the sum and integral only for Re(s)>1. The absolute majorant is a Gamma integral times sum n^(-Re(s)). Equation (3) then supplies inverse-exponential decay at zero, while the original series gives exponential decay at infinity. The integral is entire by dominated differentiation on compact s sets, and the identity theorem supplies (4) for every s. Thus specialization to sigma<1 introduces no new Dirichlet-series interchange.

Put

\[
 h_{\sigma,\chi}(w)=2\epsilon_\chi c^{-(\sigma+a)/2}
                      e^{(\sigma+a)w}\theta_\chi(e^{2w}).
\]

It is holomorphic for |Im(w)|<pi/4. Substitution y=e^(2v) in (4) gives F_(sigma,chi,0)(t)=integral h(v)exp(itv)dv. For any closed substrip |Im(w)|<=B<pi/4, set d_B=pi*cos(2B)/c and C_a(d_B)=sum n^a exp(-d_B(n^2-1)). If v>=0, the original theta series gives

\[
 |h(v+iy)|\le2c^{-(\sigma+a)/2}C_a(d_B)
                 e^{(\sigma+a)v-d_Be^{2v}}.
\]

If v<=0, equation (3) gives the corresponding bound

\[
 |h(v+iy)|\le2c^{-(\sigma+a)/2}C_a(d_B)
                 e^{(1-\sigma+a)|v|-d_Be^{2|v|}}.                      \tag{5}
\]

Both ends decrease faster than any inverse power. Derivatives have the same property by Cauchy estimates on a slightly larger closed substrip. The horizontal contour shift therefore has vanishing vertical-edge integrals, for either sign of b, and yields

\[
 \int h(v+ib)e^{itv}\,dv=e^{bt}\int h(v)e^{itv}\,dv=F_{\sigma,\chi,b}(t).
\]

Two integrations by parts give integrability of F, and Fourier inversion gives (2). This is the same proof as in the accepted critical-line note with the two exponential prefactors in (5) kept distinct. The sign of the imaginary shift is positive.

## 3. Reciprocity and conjugation: three distinct identities

Let epsilon_bar be the chosen unit phase for the inverse character and define

\[
 \gamma_\chi=\epsilon_\chi W_\chi/\epsilon_{\bar\chi},\qquad
 \rho_\chi=\epsilon_\chi/\overline{\epsilon_{\bar\chi}}.
\]

Both have modulus one. No compatibility between the two choices is presumed. Theta reciprocity gives

\[
 h_{\sigma,\chi}(w)
   =\gamma_\chi c^{1/2-\sigma}
                       h_{1-\sigma,\bar\chi}(-w),                    \tag{6}
\]

and hence

\[
 G_{\sigma,\chi,b}(x)
   =\gamma_\chi c^{1/2-\sigma}G_{1-\sigma,\bar\chi,-b}(-x),
\]

\[
 F_{\sigma,\chi,b}(t)
   =\gamma_\chi c^{1/2-\sigma}F_{1-\sigma,\bar\chi,-b}(-t).           \tag{7}
\]

In particular, negative frequency can be evaluated directly as

\[
 G_{\sigma,\chi,b}(x)=2\epsilon_\chi W_\chi c^{-(\sigma+a)/2}
 e^{-(1-\sigma+a)u}\theta_{\bar\chi}(e^{-2u}),\qquad x<0.              \tag{8}
\]

This implementation needs W_chi and inverse-character values, but no inverse root-phase choice at all.

Conjugation, by contrast, preserves sigma:

\[
 F_{\sigma,\chi,b}(-t)
       =\rho_\chi\overline{F_{\sigma,\bar\chi,-b}(t)},\qquad
 G_{\sigma,\chi,b}(x)
       =\rho_\chi\overline{G_{\sigma,\bar\chi,-b}(x)}.                \tag{9}
\]

If root phases satisfy epsilon_chi^2 W_chi=1, the functional equation and conjugation also imply the same-character relation

\[
 F_{\sigma,\chi,b}(t)
       =c^{1/2-\sigma}\overline{F_{1-\sigma,\chi,b}(t)}.               \tag{10}
\]

Equation (10) is realness only when sigma=1/2. It does not make the off-critical output real. For the real-character/root-number edge cases, the already reviewed signed phase adapter still applies; equations (6)-(9) retain the explicit phase ratios and therefore do not assume the exceptional signs away.

## 4. Explicit unequal frequency tails and time decay

Write C_y=cos(2y)>0, d_y=pi*C_y/c, and define

\[
 A_{\sigma,0}(y,c)=\frac{c^{(1-\sigma)/2}}{\sqrt{C_y}},\qquad
 A_{\sigma,1}(y,c)=\frac{2c^{(1-\sigma)/2}}{\pi C_y}.
\]

The elementary estimates sum exp(-v*n^2)<=sqrt(pi)/(2sqrt(v)) and sum n exp(-v*n^2)<=1/v from the accepted alias note, applied to (2) and (8), give the **same prefactor** A on both ends but different rates:

\[
 |h(x+iy)|\le A_{\sigma,a}(y,c)
 \begin{cases} e^{-(1-\sigma)x},&x\ge0,\\ e^{-\sigma|x|},&x\le0.
 \end{cases}                                                         \tag{11}
\]

Thus integral |h(x+iy)|dx<=A/[sigma(1-sigma)]. It is not 4A unless sigma=1/2. This distinction matters near either endpoint of (0,1).

For b fixed, let A=A_(sigma,a)(b,c), d=d_b, K_0=sqrt(2), K_1=2, and for X>=0 set

\[
 Q_+(X)=K_a A e^{-(1-\sigma)X-(d/2)e^{2X}},\qquad
 Q_-(X)=K_a A e^{-\sigma X-(d/2)e^{2X}}.                                \tag{12}
\]

Splitting one half of the Gaussian exponential off each summand proves |G(x)|<=Q_+(x) for x>=0 and |G(x)|<=Q_-(|x|) for x<=0. Both Q functions are strictly decreasing. These stronger estimates retain the inverse-exponential tail needed for practical frequency cutoffs.

For |b|<R<pi/4 define

\[
 M_{\sigma,R}=\frac{A_{\sigma,a}(R,c)}{\sigma(1-\sigma)},\qquad
 \lambda_+=R-b,\quad\lambda_-=R+b.
\]

The same contour shift gives

\[
 |F(t)|\le M_{\sigma,R}e^{-\lambda_+t}\quad(t\ge0),\qquad
 |F(t)|\le M_{\sigma,R}e^{-\lambda_-|t|}\quad(t\le0).                   \tag{13}
\]

All constants are explicit in c, parity, sigma and eta. For sigma=111/200, the frequency rates are 89/200 and 111/200 and the L1 multiplier is 40000/9879. The time rates themselves are unchanged; their prefactor changes.

## 5. Periodization, frequency omissions and finite series

Let P>0, even N>=2, omega=2*pi/P, Omega=N*omega, and J_N={-N/2,...,N/2-1}. Schwartz decay from (5) justifies Poisson and absolute regrouping exactly as in the accepted alias proof. For every real t,

\[
 \omega\sum_{n\in\mathbb Z}G(n\omega)e^{in\omega t}
                      =\sum_{r\in\mathbb Z}F(t+rP).                   \tag{14}
\]

At t_m=mP/N, fold C_j=sum_l G((j+lN)omega). Then the positive-exponent DFT of C, multiplied by omega, equals the right side. With Mathlib's normalized `invDFT`, the multiplier remains omega*N. Complex output introduces no new DFT normalization.

For |t|<=T<P the unwanted time copies are bounded by

\[
 E_{\rm time}(t)=M_{\sigma,R}\left[
 \frac{e^{-\lambda_+(P+t)}}{1-e^{-\lambda_+P}}+
 \frac{e^{-\lambda_-(P-t)}}{1-e^{-\lambda_-P}}\right].                 \tag{15}
\]

For retained folds -L<=l<=L, put X=(L+1/2)Omega. The omitted positive frequencies begin at X and negative ones at X+omega. Overcounting the negative endpoint by starting it at X gives the stable bound

\[
 E_{\rm freq}\le
 Q_+(X)\left(\omega+\frac1{1-\sigma+d e^{2X}}\right)+
 Q_-(X)\left(\omega+\frac1{\sigma+d e^{2X}}\right).                   \tag{16}
\]

Indeed the geometric ratio on each progression is at most exp(-delta*omega-(d/2)e^(2X)(e^(2omega)-1)), with delta=1-sigma or sigma; use e^(2omega)-1>=2omega and 1/(1-e^(-z))<=1+1/z. The weaker version replaces Q_+ and Q_- by A exp(-(1-sigma)X) and A exp(-sigma X), and the two reciprocal denominators by 1/(1-sigma) and 1/sigma.

For each retained frequency put r=|x|, v=d e^(2r), n0=M+1, and

\[
 r_a=((M+2)/(M+1))^a e^{-v(2M+3)}.
\]

When r_a<1, the Gaussian-series remainder is at most

\[
 \frac{2c^{-(\sigma+a)/2}n_0^a e^{-vn_0^2}}{1-r_a}
 \begin{cases}e^{(\sigma+a)x},&x\ge0,\\
 e^{(1-\sigma+a)|x|},&x<0.
 \end{cases}                                                         \tag{17}
\]

For a common cutoff, its numerator decreases with r on both sides if

\[
 d n_0^2\ge\tfrac12\max(\sigma+a,1-\sigma+a).
\]

The denominator also improves with r. This gives a uniform bound by the x=0 expression; using only the positive-side exponent would be incorrect for sigma<1/2.

Coefficient rounding, root values, W, epsilon, pi and exponentials require certified balls. If their additional norm errors are delta_n, the input contribution is omega*sum_retained(E_series(n*omega)+delta_n). Add a certified finite-DFT output error and (15)-(16). All these are complex norm enclosures; none proves a sign or nonzero value until the final resulting complex ball excludes zero.

## 6. From samples to actual contour panels

Equation (14) is valid for every t, not just grid points. The finite trigonometric sum of retained frequencies, evaluated on an entire t interval, together with uniform versions of (15)-(17), is therefore one valid full-panel enclosure. Alternatively, interval samples can feed a separately proved Cauchy model, as in the accepted c101 slab experiment. FFT samples alone do not certify the intervening contour.

A simple derivative majorant available directly from (11) is

\[
 |F'(t)|\le\int|xG(x)|dx
 \le A\left((1-\sigma)^{-2}+\sigma^{-2}\right).
\]

It justifies a Lipschitz panel enclosure around a sample; its usefulness depends on the actual margin and is not asserted to be efficient. Stronger derivative bounds can use (12).

For 0<sigma<1 the Gamma factor has no pole and no zero, so a zero of the completed function is exactly a zero of L. To assemble one analytic function around a rectangle, recover Lambda from (1), or L using its certified nonzero Gamma factor. In particular, varying sigma without undoing the positive scale c^(-(sigma+a)/2) does not produce the same analytic function. For a fixed epsilon and a continuous fixed tilt, that scale and e^(bt) are positive, so a continuous closed curve of scaled values has the same winding as Lambda; this requires an explicit adapter, not an assumption of holomorphy of the scaled two-variable expression. Undoing all scales is the simpler certificate interface.

The present elementary L1 bounds require 0<sigma<1. They cannot be applied to the right edge sigma=2. The underlying theta-Mellin identity has wider validity by (5), but a bound for that edge must be supplied separately; the existing explicit-EM evaluator is one option. Horizontal connectors also remain actual contour work. No rectangle is certified by this note.

## 7. A conservative common parameter check at the selected family heights

This section shows that the modified rates do not break the existing finite parameter protocol. It is not a runtime forecast or actual FFT run. Restrict sigma to [89/200,111/200], c<=300000, T>=1 and cT<=10^8, as for the active nonprincipal family at Hcert. Compared with the critical-line A_crit,

\[
 A_{\sigma,a}/A_{\rm crit,a}=c^{(1-2\sigma)/4}
 \le c^{11/400}<2,
\]

because c<2^19 and 209/400<1. Also sigma(1-sigma)>=9879/40000. Therefore M_(sigma,R)<3 M_(critical,R). For the single sigma=111/200, the A ratio is at most one and the M ratio is at most 10000/9879; the larger bound covers both reciprocal lines.

Choose the same eta=1-1/T, R=pi(1+eta)/8, P=257T, L=0, and take N to be the smallest power of two at least 4P. The accepted scalar inequalities imply d>=3/(cT), M_critical<=8cT, lambda_+,lambda_->=3/(8T), X=pi*N/P>12, omega<1 and omega*N<16pi<51. Each time denominator is greater than 1/2. Thus

\[
 E_{\rm time}<96\cdot10^8 e^{-96}<10^{-30}.
\]

The accepted bound d e^(2X)/2>200, A_sigma<=2cT and min(sigma,1-sigma)>=89/200 give

\[
 E_{\rm freq}<32\cdot10^8 e^{-200}<10^{-75}.
\]

For example the two displayed strict numerical conclusions follow entirely from e>8/3 and the exact rational comparisons

\[
 96\cdot10^8(3/8)^{96}<10^{-30},\qquad
 32\cdot10^8(3/8)^{200}<10^{-75}.
\]

They were independently evaluated by exact `Fraction` arithmetic during preparation; the decimal diagnostics were approximately 1.229e-31 and 2.049e-76, rounded upward here.

The same deliberately generous Gaussian cutoff M=100000 gives d(M+1)^2>300 and r_a<=e^(-1/200). Both exponents in (17) are below 2, so the common-cutoff monotonicity condition holds. The retained per-frequency series bound remains 402*100001*e^(-300)<10^(-119); multiplication by omega*N<51 keeps its output below 10^(-117). Future rounding balls <=10^(-50) per retained coefficient and normalized FFT error <=10^(-40) would therefore still give a total complex radius below 2*10^(-30).

Those rounding and FFT statements are future input obligations, not computations made here. Such a small absolute radius still does not guarantee nonvanishing or a successful contour certificate. If T is enlarged into an auxiliary region with cT>10^8, use the general formulas (15)-(17) or rederive the arbitrary-height scalar adapter with these new sigma constants; do not import this fixed cap outside its domain.

## 8. Source plan and unresolved implementation work

Accepted predecessors, unchanged:

* `FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41`; review `../integration/REVIEW_FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577`.
* `FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA256 `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF`; review `../moebius/REVIEW_FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA256 `A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33`.

Use their exact source pins: Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The source APIs and required adapters are unchanged except for the sigma parameters:

* `DirichletContinuation.lean`: `LFunction_eq_LSeries` only in Re(s)>1; entire nonprincipal completed continuation; `LFunction_eq_completed_div_gammaFactor`; `rootNumber`; and `IsPrimitive.completedLFunction_one_sub`.
* `DirichletCharacter/GaussSum.lean`: the primitive all-residue `gaussSum_mulShift_of_isPrimitive`; `Explicit/LGrowthLeft.lean`: `norm_rootNumber`.
* `Gaussian/FourierTransform.lean` and `Fourier/PoissonSummation.lean`: the complex Gaussian transform, odd-parity differentiation, and shifted/scaled Poisson adapters producing (3).
* `LSeries/MellinEqDirichlet.lean`, `MellinTransform.lean` and analytic uniqueness: first absolute Mellin interchange, then entire identity (4).
* `Complex/CauchyIntegral.lean` and `Fourier/Inversion.lean`: contour shift and inversion, with integrability supplied by (5) or (11)-(13).
* `Fourier/ZMod.lean`: the positive normalized `invDFT` adapter and its omega*N output factor; `SpecificLimits/Normed.lean`: convergent geometric sums.

The new packages to implement are the sigma-dependent kernel, its unequal two-end bounds, the explicit phase/conductor reciprocity, and the complex-valued perturbation/contour interface. The accepted critical-line statements are not silently rewritten as already-generalized Lean theorems. Actual coefficients, certified FFT arithmetic, full panels, global geometric assembly and spectral evidence remain to be produced.

The principal conductor-one row is excluded throughout: its theta constant terms and poles require separate corrections. No historical GRH computation or critical-line realness premise is imported. Independent review is requested from the moebius worker.
