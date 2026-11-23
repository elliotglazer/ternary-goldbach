# Periodization and error bounds for the family Fourier evaluator

2026-11-11. This note derives the sampling identity and explicit bounds for both infinite alias sums, the finite Gaussian-series tail, and coefficient-error propagation. These are mathematical rules for a future certificate. No Fourier coefficients, FFT outputs, signs or family zero certificates were computed. No Lean build or source edit was made.

The input is the exact primitive-character identity in `FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41`. Its independent review passed at `integration/REVIEW_FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577`. Neither packet is changed.

## 1. Fixed normalization

Let c>1 and chi be an actual primitive nonprincipal complex Dirichlet character at conductor c. Let a in{0,1} be its parity and k=a+1/2. Write

\[
 W_\chi=\tau(\chi)/(i^a\sqrt c),\quad |\epsilon|=1,\quad
 \epsilon^2W_\chi=1,\quad b=\pi\eta/4,\quad \eta\in\mathbb R,\ |\eta|<1.
\]

The entire conductor-completed Lambda uses the source continuation, as in the reviewed note. The real-valued input is

\[
 F(t)=\epsilon e^{bt}c^{it/2}\,
             \mathrm{completedLFunction}_\chi(1/2+it).
\]

Equivalently F(t)=c^(-(2a+1)/4)exp(bt)epsilon Lambda(1/2+it). Define

\[
 G(x)=\widehat F(x)=\frac1{2\pi}\int_{\mathbb R}F(t)e^{-ixt}dt=h(x+ib),
\]

where

\[
 h(w)=2\epsilon c^{-k/2}e^{kw}
       \sum_{n\ge1}n^a\chi(n)e^{-\pi n^2e^{2w}/c}.
\]

The inverse formula is F(t)=integral G(x)exp(ixt)dx, with no factor1/(2*pi). All conductor factors, the positive tilt and the character's fixed root phase remain present below. The argument is per character, and does not assume compatible phases for inverse characters.

## 2. Two explicit bounds for the frequency kernel

For v>0 let S_a(v)=sum_(n>=1) n^a exp(-v*n^2). The elementary integral comparisons

\[
 S_0(v)\le\frac{\sqrt\pi}{2\sqrt v},\qquad S_1(v)\le\frac1v              \tag{3}
\]

hold for every v>0. The first follows by integrating the decreasing Gaussian on each[n-1,n]. For the second, on that interval exp(-v*t^2)>=exp(-v*n^2), so

\[
 \int_{n-1}^{n}2t e^{-vt^2}dt\ge(2n-1)e^{-vn^2}\ge n e^{-vn^2}.
\]

Summing and integrating2t exp(-v*t^2) on[0,infinity) proves the second inequality. No monotonicity of t*exp(-v*t^2) is assumed.

For a real strip height y with |y|<pi/4, put C_y=cos(2y)>0 and d_y=pi*C_y/c. Define

\[
 A_0(y,c)=\frac{c^{1/4}}{\sqrt{C_y}},\qquad
 A_1(y,c)=\frac{2c^{1/4}}{\pi C_y}.
\]

Using(3) in h(v+iy) for v>=0 gives |h(v+iy)|<=A_a(y,c)exp(-v/2). For v<0 use the reviewed primitive theta transformation with coefficient Wchi of modulus1, then apply the same bound at -v,-y to the inverse character. Thus

\[
 |h(v+iy)|\le A_a(y,c)e^{-|v|/2}.                                       \tag{4}
\]

A stronger bound follows by taking exp(-v/2) out of each summand in S_a(v), since n^2>=1, and applying(3) at v/2. With K_0=sqrt(2), K_1=2, it is

\[
 |h(v+iy)|\le K_a A_a(y,c)e^{-|v|/2}
                     \exp\{-d_y e^{2|v|}/2\}.                          \tag{5}
\]

For later use set A=A_a(b,c), d=d_b and

\[
 Q(X)=K_a A\exp\{-X/2-d e^{2X}/2\}\quad(X\ge0).
\]

Then |G(x)|<=min(A exp(-|x|/2),Q(|x|)). These bounds retain c, a and eta and cover both signed frequency tails. The negative-frequency bound requires the actual primitive theta identity; it cannot be obtained by taking absolute values of the original small-d Gaussian sum alone.

## 3. Explicit time decay

Choose a real R with |b|<R<pi/4, and let

\[
 M_R=4A_a(R,c),\qquad \lambda_+=R-b>0,\quad\lambda_-=R+b>0.
\]

Equation(4) gives integral |h(v+/-iR)|dv<=M_R. The contour shift proved in the reviewed note gives

\[
 |F(t)|\le
 \begin{cases}
 M_R e^{-\lambda_+ t}&t\ge0,\\
 M_R e^{-\lambda_-|t|}&t\le0.
 \end{cases}                                                          \tag{6}
\]

Indeed the untilted inverse transform is bounded by M_R exp(-R|t|), and the actual F has the factor exp(bt). This proves signed exponential bounds without a Gamma asymptotic. The eta dependence is significant: positive tilt weakens the positive-time rate and strengthens the negative-time rate. A uniform bound over a range of eta must keep a positive gap between |b| and R.

The reviewed theta bounds, Cauchy derivative estimates on a larger closed strip, and repeated integration by parts also show h(v+ib) and F are Schwartz functions. The explicit bounds(4)-(6) suffice for all summability estimates below; Schwartz regularity supplies a convenient existing Poisson API.

## 4. Exact periodization and finite DFT identity

Choose time period P>0, an even integer N>=2, and write

\[
 \omega=2\pi/P,\quad \Delta t=P/N,\quad\Omega=N\omega,\quad
 J_N=\{-N/2,\ldots,N/2-1\},\quad t_m=mP/N.
\]

Poisson summation yields, for every real t,

\[
 \omega\sum_{n\in\mathbb Z}G(n\omega)e^{in\omega t}
                  =\sum_{r\in\mathbb Z}F(t+rP).                        \tag{7}
\]

One direct normalization check applies unit-lattice Poisson to g(y)=omega*G(omega*y)*exp(i*omega*t*y). In Mathlib's negative-exponent2*pi convention, Fourier(g)(r)=F(t-rP). Reindexing r proves(7). Both sides converge absolutely by(5)-(6).

At a grid point t_m, group n=j+ell*N for j in J_N. The exponential factor becomes exp(2*pi*i*j*m/N), since the ell contribution is an integer multiple of2*pi*i. Define the exact folded coefficients

\[
 C_j=\sum_{\ell\in\mathbb Z}G((j+\ell N)\omega).
\]

Absolute convergence justifies regrouping, giving

\[
 \omega\sum_{j\in J_N}C_j e^{2\pi i jm/N}
                       =\sum_{r\in\mathbb Z}F(t_m+rP).                 \tag{8}
\]

Thus an unnormalized positive-exponent inverse DFT is multiplied by omega. Mathlib's `ZMod.invDFT` includes1/N, so the corresponding multiplier is omega*N, not omega. A numerical library's normalization and centered-index permutation must be checked against(8). Negative indices represent their residues modulo N; no extra fftshift phase may be silently inserted.

For a finite folded input choose an integer L>=0 and retain only -L<=ell<=L. This retains every integer frequency index in the contiguous interval

\[
 -(L+1/2)N\ \le n\le\ (L+1/2)N-1.
\]

L=0 is the usual single centered frequency block. Omitting folds does not make(8) exact for F: the omitted-frequency error and unwanted time copies must both be added.

## 5. The two alias errors

### Time copies

For |t|<=T<P, formula(6) gives the pointwise bound

\[
 E_{\rm time}(t)=M_R\left[
 \frac{e^{-\lambda_+(P+t)}}{1-e^{-\lambda_+P}}
 +\frac{e^{-\lambda_-(P-t)}}{1-e^{-\lambda_-P}}
 \right]                                                             \tag{9}
\]

for sum_(r!=0)|F(t+rP)|. Both denominators are positive. A uniform bound on that target interval replaces P+t and P-t by P-T. P>2T is convenient for representing every target grid point inside the centered time block, although the mathematical inequality only needs P>T. This error includes both signed time channels, whether or not the character is real.

### Omitted frequencies

Put X=(L+1/2)*Omega. The omitted positive frequencies start at X; the negative ones start at X+omega. Bounding both by the first progression therefore gives

\[
 E_{\rm freq}\le2\omega\sum_{j\ge0}Q(X+j\omega)
 \le\frac{2\omega Q(X)}{1-\exp\{-\omega/2-(d/2)e^{2X}(e^{2\omega}-1)\}}. \tag{10}
\]

The ratio is strictly below1 and decreases along the progression. This is a global output-error bound at every grid point, because each DFT exponential has modulus1. It deliberately overcounts one endpoint frequency; it never omits the Nyquist endpoint.

For numerical stability, no subtraction of nearly equal exponentials is needed. Since1/(1-exp(-z))<=1+1/z for z>0, and exp(2omega)-1>=2omega, (10) implies

\[
 E_{\rm freq}\le2Q(X)\left(\omega+
                              \frac1{1/2+d e^{2X}}\right).             \tag{11}
\]

The same calculation using(4) instead of(5) gives the weaker fallback

\[
 E_{\rm freq}\le2A e^{-X/2}(\omega+2).
\]

These are the frequency-fold omissions. They are separate from truncating the n-series used to evaluate each retained G. There is no second unexplained alias multiplier after the factor omega in(10).

## 6. Finite series and numerical input errors

The Gaussian identity can be evaluated stably on either frequency side without assuming compatible inverse-character root phases. For x>=0 use the original formula with w=x+ib. For x<0, use exactly

\[
 G(x)=2\epsilon W_\chi c^{-k/2}e^{-kw}
          \sum_{n\ge1}n^a\bar\chi(n)e^{-\pi n^2e^{-2w}/c}.              \tag{12}
\]

In either case the absolute Gaussian parameter is v=d*exp(2|x|), and the prefactor has modulus2*c^(-k/2)*exp(k|x|). If the series is truncated after M terms, set n0=M+1 and

\[
 r_a=((M+2)/(M+1))^a e^{-v(2M+3)}.
\]

When r_a<1, the per-coefficient series error is bounded by

\[
 E_{\rm series}(x)\le
 2c^{-k/2}e^{k|x|}\frac{n_0^a e^{-v n_0^2}}{1-r_a}.                    \tag{13}
\]

This is a direct successive-term ratio bound and preserves multiplicative-character values of norm at most1. For a single M used at all x, the numerator decreases with |x| whenever d*n0^2>=k/2; the denominator only improves as |x| increases. Consequently(13) is then bounded by its x=0 value. This is a sufficient convenience condition, not a requirement for using per-frequency bounds.

Suppose each retained value G(n*omega) has an additional proved absolute rounding enclosure delta_n, including its exact character value, root phase, constants and exponential evaluations. If C_j is formed by interval summation, the total contribution of coefficient errors to the normalized output is

\[
 E_{\rm inputs}\le\omega\sum_{n\text{ retained}}
                            (E_{\rm series}(n\omega)+\delta_n).         \tag{14}
\]

Finally let E_impl,m enclose the error of the finite normalized DFT itself, including the factor omega. Then the computed output V_m encloses F(t_m) with total radius

\[
 E_{\rm time}(t_m)+E_{\rm freq}+E_{\rm inputs}+E_{\rm impl,m}.            \tag{15}
\]

A future checker must prove the numerical input and DFT enclosures. No assertion of backward stability or a machine library's accuracy is imported here. Since F is real by the reviewed phase argument, a real-part interval excluding0 proves its sign. An interval containing0 remains unresolved; a small absolute error alone is not sign evidence.

## 7. One uniform parameter protocol at the actual Hcert

The following conservative example shows that all error rules have simultaneous explicit parameters. It is not a recommended fast configuration or a runtime forecast.

Take any active nonprincipal conductor c and T=Hcert(c). The existing selected profile gives T>=1 and c*T<=10^8. Put

\[
 \eta=1-1/T,\quad R=\pi(1+\eta)/8,\quad P=257T,\quad
 N=2\lceil2P\rceil,\quad L=0.                                         \tag{16}
\]

Thus0<=eta<1, |b|<R<pi/4, P>2T and N is even. Using sin(pi*z/2)>=z for0<=z<=1 gives

\[
 \cos(\pi\eta/2)\ge1/T,\quad d\ge3/(cT)\ge3\cdot10^{-8},
 \quad A\le10^8,
\]

where3<pi is used conservatively. For the outer strip,

\[
 \cos(2R)\ge1/(2T),\quad M_R\le8c^{1/4}T\le8\cdot10^8,
 \quad\lambda_\pm\ge3/(8T).
\]

Since P-T=256T and each geometric denominator in(9) exceeds1/2,

\[
 E_{\rm time}<32\cdot10^8 e^{-96}<10^{-30}.                             \tag{17}
\]

Also N>=4P implies X=pi*N/P>12; omega<1. Since d*exp(2X)/2>200, equations(10)-(11) give

\[
 E_{\rm freq}<12\cdot10^8e^{-200}<10^{-75}.                             \tag{18}
\]

For a deliberately generous common Gaussian cutoff M=100000,

\[
 d(M+1)^2>300,\quad
 d(2M+3)-1/(M+1)>1/200.
\]

The inequality1+z<=exp(z) therefore gives r_a<=exp(-1/200) and1/(1-r_a)<=201. Since c^(-k/2)<=1 and n0^a<=n0, formula(13), uniformly at every retained frequency, gives

\[
 E_{\rm series}(x)<402\cdot100001\,e^{-300}<10^{-119}.                  \tag{19}
\]

The total DFT norm factor obeys omega*N<26, because N<4P+2, P>=257 and pi<22/7. Thus this series contribution is below10^(-117). If future per-coefficient rounding enclosures are at most10^(-50) and the normalized finite-DFT error is at most10^(-40), equations(15)-(19) give a total radius below2*10^(-30), uniformly at the target grid points |t_m|<=T.

The two last rounding hypotheses are future certificate inputs, not results of this task. Neither this radius nor parameter(16) proves a sign, finds a sign change or supplies a zero count. The interval endpoints Turing requires above Hcert are not covered by declaring T=Hcert: if an auxiliary zone extends to T+h, rerun these rules with that larger target and the corresponding bound on c*(T+h). The principal c=1 row is outside the primitive nonprincipal Gaussian theorem.

The exact scalar script verifies nine rational inequalities used above. It replaces exp(m) by the strict lower bound(8/3)^m, obtained from the first four positive terms of exp(1). In particular it checks

\[
 (3/(2\cdot10^8))(8/3)^{24}>200,
 \quad32\cdot10^8(3/8)^{96}<10^{-30},
 \quad12\cdot10^8(3/8)^{200}<10^{-75}.
\]

It generated no character or spectral data. The cutoff100000 and period257T establish a simple finite example, not an optimized operation count. Smaller point-dependent cutoffs and periods can use(9)-(14) directly, provided every resulting enclosure is checked.

## 8. Source interfaces and remaining adapters

Use the same pinned source revisions as the reviewed Gaussian note: Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679` and Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The new source reads were:

* `Mathlib/Analysis/Fourier/PoissonSummation.lean:201,215`: `Real.tsum_eq_tsum_fourier_of_rpow_decay` and `SchwartzMap.tsum_eq_tsum_fourier`. Scaling/modulation gives(7); the existing theorem is on the unit lattice.
* `Mathlib/Analysis/Fourier/ZMod.lean:87,106,114`: `ZMod.dft`, `dft_apply` and `invDFT_apply`. The forward sum has negative exponent and no normalization. The inverse has positive exponent and1/N. Thus our output is omega*N times that source inverse.
* `Mathlib/Analysis/SpecificLimits/Normed.lean:486,496`: `tsum_geometric_of_norm_lt_one` and its real variant supply the geometric tail sums once strict ratio bounds are proved.
* `Mathlib/Analysis/SpecialFunctions/Trigonometric/Bounds.lean:69,84`: `Real.le_sin_mul` and `Real.mul_le_sin` give the concavity bounds used in(16).

The Gaussian integral and contour-shift interfaces are already pinned in the reviewed predecessor. New adapters still need implementation: the two S_a integral comparisons; explicit kernel/time envelopes; the scaled Poisson and centered folding identities; the finite-input perturbation lemma; and rationally verified interval implementations of the transcendental bounds. The mathematical derivations here do not turn these adapters into existing Lean theorems.

The arithmetic character manifest must continue to identify each actual primitive character, its parity and exact inverse label. Formula(12) uses epsilon_chi*Wchi and bar chi directly, so no unproved relation between the separately stored epsilon phases is required. All actual Gauss and conductor normalization factors are already in F and h. No change is made to the selected Hcert or to the main family completeness/count obligation.

## Reproduction and status

Run `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/family_fourier_alias_scalar_20261111.py`. The receipt reports PASS for nine exact scalar checks, with no analytic data generated.

* Script SHA256: `A64EE1ED4DA92033C45B6A4254ECF43EBA34775744707B1474EEB064722FA6C8`.
* Receipt SHA256: `89B0E22CC7B3EE0447556664C39D493C2851399CB043ABA119CB04D43593C31A`.

Independent review is requested. This task derives analytic acceptance rules and checks conservative scalar consequences; it does not certify any finite-family zero statement or establish an implementation's numerical correctness.
