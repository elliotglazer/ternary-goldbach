# A refinable Fourier evaluator on the full nonprincipal right slab

2026-11-11. Paper derivation with four small exact rational parameter checks. No L-value evaluation, spectral scan, numerical FFT, Lean/Lake build, dependency change or canonical/frozen source edit.

Retaining the Gaussian factor removes the obstruction in the previous elementary L1 bound at sigma=1 and 2. This note gives one explicit, arbitrarily refinable evaluator for every fixed actual primitive nonprincipal character on the entire closed slab 111/200<=Re(s)<=2, with arbitrary finite rational height and tolerance. It also gives a whole-panel adapter to one analytic function. It does not prove that any untested panel is nonzero, that a desired winding vanishes, or that the full family certificate will succeed.

## 1. Exact function and deliberate normalization choice

Let c>1, let chi be an actual primitive nonprincipal complex Dirichlet character at conductor c, and let a in {0,1} be its parity. The principal conductor-one row is excluded. Define

\[
 \Lambda_\chi(s)=c^{(s+a)/2}\operatorname{completedLFunction}_\chi(s),
 \quad W_\chi=\tau(\chi)/(i^a\sqrt c),\quad |W_\chi|=1.
\]

The source entire completion is the definition. Powers of positive reals use their real logarithms. On the present slab the nonzero Gamma factor relates Lambda and the actual continued L-function, so they have exactly the same zeros with multiplicities.

Choose epsilon=1 and tilt b=0 throughout this construction. Root-square-root choices and Hardy realness are unnecessary for a complex contour evaluator. This is a normalization choice, not a new assertion about a root number. Define, for real sigma in [111/200,2],

\[
 F_\sigma(t)=c^{-(\sigma+a)/2}\Lambda_\chi(\sigma+it)
            =c^{it/2}\operatorname{completedLFunction}_\chi(\sigma+it).
                                                                    \tag{1}
\]

The positive angular inverse-transform convention is

\[
 F_\sigma(t)=\int_{\mathbb R}G_\sigma(x)e^{itx}\,dx,
 \qquad G_\sigma(x)=\frac1{2\pi}\int_{\mathbb R}F_\sigma(t)e^{-itx}\,dt.
\]

The kernel is

\[
 h_\sigma(w)=2c^{-(\sigma+a)/2}e^{(\sigma+a)w}
                  \theta_\chi(e^{2w}),\qquad G_\sigma(x)=h_\sigma(x),
\]

where theta_chi(z)=sum_(n>=1) n^a chi(n) exp(-pi*n^2*z/c). For negative real frequency, use the exact reciprocal expression

\[
 G_\sigma(x)=2W_\chi c^{-(\sigma+a)/2}e^{-(1-\sigma+a)x}
                     \theta_{\bar\chi}(e^{-2x}),\qquad x<0.            \tag{2}
\]

The inverse character, parity, conductor and positive Gauss convention remain those in the accepted manifest and Gaussian proof. Equation (2) does not assume compatible phases between characters.

The accepted theta-Mellin proof established an entire identity before specializing the real part. Consequently the formula above holds at sigma=1 and 2 as well: its derivation did not interchange the L-series at those points. What failed beyond sigma<1 was only the earlier Gaussian-discarding majorant. The new majorant below supplies the missing integrability and contour-shift hypotheses.

## 2. A uniform Gaussian majorant through sigma=2

Fix the auxiliary log-plane strip |Im(w)|<=1/4. Write w=x+iy, r=|x|, C=cos(2y) and d=pi*C/c. The elementary inequality cos(2y)>=1-2y^2 gives C>=7/8, hence d>2/c.

The split-Gaussian bounds from the accepted off-critical proof remain valid for all the real parts here:

\[
 |h_\sigma(x+iy)|\le K_a A_{\sigma,a}(y,c)
 \begin{cases}
 e^{(\sigma-1)x-(d/2)e^{2x}},&x\ge0,\\
 e^{-\sigma|x|-(d/2)e^{2|x|}},&x\le0,
 \end{cases}                                                        \tag{3}
\]

with K_0=sqrt(2), K_1=2 and

\[
 A_{\sigma,0}=c^{(1-\sigma)/2}/\sqrt C,\qquad
 A_{\sigma,1}=2c^{(1-\sigma)/2}/(\pi C).
\]

For sigma>=111/200 and c>1, A_(sigma,a)<=c/C. Both linear exponents in (3) are at most r because sigma<=2 and sigma>0. Since K_a<=2 and 2c/C<=16c/7<3c, a single explicit majorant is

\[
 \boxed{|h_\sigma(x+iy)|\le Q_c(r):=
                 3c\exp(r-e^{2r}/c),\quad |y|\le1/4.}                \tag{4}
\]

This has Gaussian decay in u=e^r, even when the positive-side linear exponent is zero or positive. It is integrable at both ends. Indeed

\[
 \int_{\mathbb R}|h_\sigma(x+iy)|dx
 \le6c\int_1^\infty e^{-u^2/c}du
 \le6c\int_1^\infty u e^{-u^2/c}du\le3c^2.
\]

We retain the looser uniform value

\[
                          M_c=6c^2                                 \tag{5}
\]

below. Similarly, log(u)<=u on u>=1 gives

\[
 \int_{\mathbb R}|x h_\sigma(x+iy)|dx
 \le6c\int_1^\infty\log(u)e^{-u^2/c}du\le3c^2=:J_c.                  \tag{6}
\]

The reciprocal theta identity supplies the negative side of (3); absolute summation of the unreversed small-argument theta series alone does not do so. Holomorphy and derivative decay on slightly wider closed log-plane strips follow from the accepted theta argument. Thus contour shift and inversion remain valid. Shifting to y=+/-1/4 now yields

\[
                    |F_\sigma(t)|\le6c^2e^{-|t|/4}.                 \tag{7}
\]

The bounds are uniform for every sigma in the full requested slab. No term is singular at sigma=1 or 2.

## 3. Arbitrary-height and arbitrary-tolerance parameters

Let the requested height H>=0 and tolerance e>0 be rational. Replace H by H0=max(1,H), which only enlarges the evaluation interval. The tolerance in this section is a norm error for F_sigma(t). Section 5 converts it to the common analytic function Lambda.

### Time copies

Choose an integer K>=1 such that

\[
                24c^2(3/8)^K<e/4,
 \qquad P=2H_0+4K.                                                  \tag{8}
\]

Then P>2H0 and P>=6. Poisson summation and (7) give, uniformly for |t|<=H0,

\[
 \sum_{j\ne0}|F_\sigma(t+jP)|
 \le\frac{12c^2e^{-(P-H_0)/4}}{1-e^{-P/4}}
 <24c^2e^{-K}<e/4.                                                   \tag{9}
\]

The denominator exceeds 1/2 because P/4>=3/2 and e^1>2. The rational comparison uses e^1>8/3.

### Frequency range

Choose an integer L>=1 with 18c(3/8)^L<e/4. Next choose an integer x>=1 satisfying

\[
                  (8/3)^{2x}\ge c(2x+L).                            \tag{10}
\]

Let N be the smallest power of two at least Px/3, and write

\[
 \omega=2\pi/P,\quad X=N\omega/2=\pi N/P,\quad D=88x/21.
\]

Here Px/3>=2, so N>=2, N<2Px/3, X>x, omega<2, and omega*N<D using 3<pi<22/7. N is just an integer in the scalar construction; no array is allocated by the accompanying checks.

Keep the single centered set J_N={-N/2,...,N/2-1}, with no additional frequency folds. The positive omitted frequencies begin at X; negative omitted frequencies begin at X+omega. Equation (10) gives e^(2x)/c>2x+L, so Q_c decreases for r>=x. Its logarithmic slope is 1-2e^(2r)/c, bounded above by -1 there. More precisely, the ratio along a frequency progression is at most exp(-omega*(2e^(2X)/c-1)). Hence

\[
 E_{\rm freq}
 \le2Q_c(X)\left(\omega+\frac1{2e^{2X}/c-1}\right)
 <6Q_c(x)<18c e^{-L}<e/4.                                           \tag{11}
\]

This uses 1/(1-e^(-z))<=1+1/z, and overcounts the negative endpoint rather than dropping it. It bounds the omitted-frequency error at every real t, since each complex exponential has modulus one.

### Gaussian sums

For a retained frequency r=|n*omega|, both the direct positive formula and the inverse-character negative formula have absolute Gaussian parameter v=pi*e^(2r)/c>3e^(2r)/c. Truncate the n-series before n0=M+1. To avoid conflict between its series index and the frequency index, n0 always denotes the first omitted positive theta index below.

Consecutive tail terms have ratio at most

\[
 ((n_0+1)/n_0)^a e^{-v(2n_0+1)}\le e^{-z},\qquad
 z=3(2n_0+1)/c-1/n_0.
\]

The direct/reciprocal prefactor exponents are sigma+a and 1-sigma+a; both are at most 3. Put V=3n0^2/c. If V>=2 and z>0, the numerator e^(3r-v*n0^2) decreases as r grows, and the ratio denominator improves. Since c^(-(sigma+a)/2)<=1, a uniform per-frequency series bound is

\[
 B_{\rm series}
 =2n_0(1+1/z)(3/8)^{\lfloor V\rfloor}.                               \tag{12}
\]

Choose n0 by increasing or doubling it until V>=2, z>0 and

\[
                         D B_{\rm series}<e/4.                      \tag{13}
\]

The factor D bounds omega*N, so (13) is the total output contribution of all N retained coefficient tails, not merely a per-coefficient estimate.

### Rounding and finite transform

Require each retained coefficient's additional norm error, including its exact character value, W when used, powers, pi, finite sum and exponential arithmetic, to be at most e/(8D). Require the finite transform's additional **normalized output** norm error to be at most e/8. The latter includes multiplication by omega (or omega*N when using normalized `invDFT`). Then the total error is strictly less than

\[
                  e/4+e/4+e/4+e/8+e/8=e.                            \tag{14}
\]

These rounding contracts are input proof obligations. They are not replaced by a floating-point accuracy assumption. A finite rational interval implementation of elementary functions can satisfy any prescribed positive rounding tolerance by increasing its order and precision. The finite transform can use either certified radix-two arithmetic or direct finite sums. The already reviewed fixed-precision, bounded-depth FFT example must not be applied to an arbitrarily large N without rechecking its stage budget.

At grid points t_m=mP/N, the positive-exponent finite DFT is applicable. For an arbitrary rational t, directly evaluating the same finite trigonometric polynomial is a valid evaluator with the same analytic error bound; calling such a point an FFT grid point without checking its index would be incorrect.

## 4. Why all parameter searches terminate

For fixed c,H0,e, the searches for K and L terminate because (3/8)^j tends to zero. For x>=1 and L>=1, the ratio of successive values (8/3)^(2x)/(2x+L) is at least (64/9)*(3/5)>1. Thus (10) is eventually true. The power-of-two search for N has a finite positive rational threshold.

For the series search, once n0>=c one has z>6 and V>=3n0. Therefore the expression in (12) is bounded above by

\[
                       3n_0(3/8)^{3n_0},
\]

which tends to zero; its successive-integer ratio is at most 27/256. Thus (13) eventually holds, including along a doubling search. All these are explicit scalar inequalities, independent of unknown zeros or zero spacing. No cH cap is required.

This proves termination of the **finite-accuracy evaluator parameter selection**, not termination of a search for a zero-free contour. The final finite computation may be prohibitively large; this note makes no runtime claim. Choosing zero tilt also leaves exponential decay in |t|, so relative accuracy or a nonzero certificate at a high ordinate can require a very small absolute tolerance. That is a conditioning cost, not a fixed analytic error floor.

## 5. One analytic function and full panels, including horizontal connectors

To assemble a contour, return enclosures of the single entire function Lambda_chi(s), rather than treating separately scaled functions F_sigma as one holomorphic function. Recover

\[
                 \Lambda_\chi(\sigma+it)=c^{(\sigma+a)/2}F_\sigma(t).
                                                                    \tag{15}
\]

The multiplier is positive and at most c^(3/2)<c^2 on the full slab. It must itself be enclosed with certified rounding; multiplying only by an approximate midpoint without its error is insufficient. For any desired point tolerance, choose a smaller F tolerance and a smaller multiplier tolerance so the interval product has the desired norm radius. For example, the uniform |F|<=M_c and multiplier bound c^2 make this a finite explicit error budget. Both elementary multiplier evaluation and Section 3 can be refined arbitrarily.

There is also a useful exact cancellation. Differentiating the kernel in sigma gives

\[
 \partial_\sigma G_\sigma(x)=(x-\tfrac12\log c)G_\sigma(x).
\]

The log(c)/2 term cancels when differentiating (15). Dominated differentiation is justified by (4)-(6) and the entire theta-Mellin identity. Consequently

\[
 \Lambda_\chi'(\sigma+it)
   =c^{(\sigma+a)/2}\int_{\mathbb R}xG_\sigma(x)e^{itx}\,dx,
 \qquad |\Lambda_\chi'(\sigma+it)|\le3c^{7/2}<3c^4.                   \tag{16}
\]

The same complex derivative governs horizontal and vertical segments; no independent assumption about horizontal behavior is needed. On any straight segment contained in the closed slab, integrate that derivative to obtain

\[
                  |\Lambda(s)-\Lambda(s_0)|\le3c^4|s-s_0|.          \tag{17}
\]

If a point enclosure at a rational midpoint s0 has norm error at most e0, the entire panel of radius r about s0 is enclosed by adding the disk of radius e0+3c^4 r. A rational upper bound for r may use the sum of absolute real and imaginary displacements. This construction covers horizontal connectors as well as vertical sides, including sigma=1 and sigma=2. It does not interpolate a collection of fixed-sigma FFT samples without justification.

For a desired whole-panel radius e_panel, one possible allocation is e0<=e_panel/2 and r<=e_panel/(6c^4). The derivative bound is deliberately coarse. A tighter local Cauchy or finite-polynomial enclosure can replace it only after its own error proof.

Equivalently, one can interval-evaluate the finite Fourier coefficient formulas with sigma varying over the panel's real projection; all analytic tail bounds here are already uniform in sigma. That retains genuine coefficient variation, which must not be mislabeled as numerical rounding error. The point-plus-derivative route is a simpler, explicit correctness adapter.

## 6. What nonvanishing and winding still require

For a polygonal boundary wholly inside the slab, generate ordered panels, shared rational image vertices and strict half-plane witnesses using the analytic Lambda enclosures above. The already accepted polygon crossing proof then computes the winding, and the argument principle counts zeros with multiplicities. On the present real range the completion factor is nonzero, so the count is also the L-function count.

If the actual boundary is compact and zero-free, continuity gives a positive minimum modulus. Arbitrarily small point errors and arbitrarily fine panels, together with (17), eventually give strict half-plane witnesses under a fair refinement schedule. This is a conditional termination theorem with a genuine boundary-nonvanishing hypothesis. If the actual contour contains a zero, the nonvanishing checker cannot be forced to accept. A computed nonzero winding also need not be zero merely because the computation succeeded.

In particular, a zero exactly at Re(s)=111/200 is allowed by the desired weak strip inequality but blocks a contour using that line as a strict nonzero boundary. The earlier equality/factor or cluster handling issue remains. For an inclusive target height, an enclosing contour and its horizontal connectors must actually cover that height; an unverified top or an omitted endpoint cannot be excused by the evaluator's availability.

Thus three outputs stay distinct: a certified point value, a certified full-panel enclosure, and a successful geometric certificate of the desired zero statement. This note gives a refinable construction for the first two and a valid input interface for the third. It supplies no new instance of the third.

## 7. Exact scalar checks, without allocating transforms

The adjacent `full_right_slab_fourier_parameters_20261111.py` chooses the parameters by rational arithmetic, checks (8), (10), (12)-(14) exactly, and records four examples. It creates no characters, evaluates no special functions and allocates no length-N arrays.

| c | H used | F tolerance | K | L | x | N as an integer | n0 |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 3 | 10 | 10^-12 | 36 | 34 | 3 | 256 | 8 |
| 101 | 1000 | 10^-30 | 85 | 80 | 5 | 4096 | 64 |
| 300000 | 100000000 | 10^-40 | 125 | 112 | 9 | 1073741824 | 4096 |
| 4 | 1, enlarged from 0 | 10 | 6 | 4 | 2 | 32 | 2 |

The large third N is a mathematical parameter witness, not an executed or forecast production calculation. The recorded upper-error fractions of tolerance are approximately .528, .554, .479 and .731, respectively. All decisions used exact fractions rather than those rounded diagnostics.

Frozen scalar files:

* Script SHA256 `0F3987B2F5BA8CF45A3D51663E2466207976D5FED520B9E2552D161B1D9872FE`.
* Receipt SHA256 `87E2731447C2FB0B189F4EE77A3189844DA253DF56460BF8860C8056D2F2736B`.

Read-only recomputation from the repository root:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/full_right_slab_fourier_parameters_20261111.py --recompute
```

## 8. Source and implementation status

This extends the accepted `OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md`, SHA256 `BA7A5D0517972FD9C93496E6166DEC471B36C18CA0B6BBA734985016ECD24B25`, reviewed in `../moebius/REVIEW_OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md`, SHA256 `F9431FA70E33B7FFA3A16B6C12CB254A14D590C8FEEF81CC86E328418A304D0F`. The accepted Gaussian and alias source inventories are inherited without changing their statements or frozen bytes.

Source pins remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The main interfaces are the actual nonprincipal completed continuation and functional equation in `LSeries/DirichletContinuation.lean`; primitive Gauss orthogonality; the complex Gaussian transform and scaled Poisson adapter; the entire theta-Mellin identity; Fourier inversion; and the geometric-series/finite inverse-DFT normalization adapters listed in the predecessors. The source completed Gamma factor is nonzero here because Re(s+a)>0.

New work still to implement includes packaging the uniform Gaussian and derivative estimates, scalar-search termination proofs, certified elementary input balls at arbitrary requested precision, the generalized finite-transform stage ledger, the common-Lambda panel adapter, and actual full contour records. The character manifest must still identify every actual primitive character without duplication. Neither the availability of an evaluator nor the four scalar examples produce the missing family spectral evidence.

Independent review is requested from the moebius worker. The principal c=1 case remains outside every statement in this note.
