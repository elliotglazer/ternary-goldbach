# Holomorphically tilted evaluation on the full right slab

2026-11-11. Paper derivation and five small exact rational parameter checks. No character values, L-values, FFT arrays, contours or spectral data were computed. No Lean/Lake build, dependency change or canonical/frozen edit.

There is a holomorphic normalization that retains the useful near-pi/4 tilt without losing the phase needed for a complex contour. Its norm and derivative admit bounds polynomial in conductor and height on the entire real range [111/200,2]. This removes the need to approximate exponentially decaying unnormalized values merely to use a contour method. It does not give a lower bound for the actual normalized function, guarantee nonvanishing, or establish a faster implementation.

## 1. One analytic function per slab

Let c>1 and chi be an actual primitive nonprincipal character of conductor c, with parity a in {0,1}. Use the entire source completion

\[
 \Lambda_\chi(s)=c^{(s+a)/2}\operatorname{completedLFunction}_\chi(s).
\]

The principal conductor-one row remains excluded. Choose a fixed real b with |b|<pi/4 and define the single entire function

\[
                         Z_{b,\chi}(s)=e^{-ibs}\Lambda_\chi(s).       \tag{1}
\]

The exponential is entire and nowhere zero. Consequently Z_b and Lambda have exactly the same zeros and multiplicities. On a closed contour avoiding those zeros,

\[
 \frac{Z_b'}{Z_b}=-ib+\frac{\Lambda'}{\Lambda},
 \qquad \oint -ib\,ds=0,
\]

so their windings and argument-principle counts agree. No logarithm branch for Lambda, root-number square root, Hardy realness or critical-line premise is needed.

Retain the accepted Fourier normalization with epsilon=1:

\[
 F_{\sigma,b}(t)=e^{bt}c^{-(\sigma+a)/2}\Lambda_\chi(\sigma+it),
 \qquad G_{\sigma,b}(x)=h_\sigma(x+ib),
\]

\[
 h_\sigma(w)=2c^{-(\sigma+a)/2}e^{(\sigma+a)w}\theta_\chi(e^{2w}),
 \quad F_{\sigma,b}(t)=\int_{\mathbb R}G_{\sigma,b}(x)e^{itx}\,dx.
\]

For s=sigma+it, the exact conversion is

\[
 \boxed{Z_{b,\chi}(\sigma+it)=e^{-ib\sigma}c^{(\sigma+a)/2}
                                          F_{\sigma,b}(t).}          \tag{2}
\]

The factor exp(-ib*sigma) is essential. Merely multiplying Lambda by exp(b*t), or dropping this phase from (2), does not define the claimed holomorphic function. Formula (2) includes no second exp(b*t): that real tilt is already inside F.

The Gaussian transform convention remains positive in the inverse integral; the forward transform has exp(-ixt)/(2*pi). Negative frequency uses the exact reciprocal theta expression, with the actual inverse character and W_chi=tau(chi)/(i^a sqrt(c)), as in the accepted full-slab note.

## 2. Uniform bounds with the Gaussian retained

For 111/200<=sigma<=2 and |y|<pi/4, suppose cos(2y)>=q>0 with q<=1. The split-Gaussian estimate in the accepted off-critical derivation gives

\[
 |h_\sigma(x+iy)|
 \le\frac{2c}{q}\exp\left(|x|-\frac{q}{c}e^{2|x|}\right).            \tag{3}
\]

Indeed K_a A_(sigma,a)<=2c/q, both linear exponents sigma-1 and -sigma are at most 1, and pi*cos(2y)/(2c)>q/c. Equation (3) covers both parities and both frequency signs. Its negative-frequency side uses primitive theta reciprocity; it is not inferred from the direct small-argument theta sum by ignoring cancellation.

Substitute u=exp(|x|). Using 1<=u and log(u)<=u for u>=1 gives

\[
 \int_{\mathbb R}|h_\sigma(x+iy)|dx\le\frac{2c^2}{q^2},\qquad
 \int_{\mathbb R}|x h_\sigma(x+iy)|dx\le\frac{2c^2}{q^2}.              \tag{4}
\]

For example, each estimate is bounded by (4c/q) times integral_1^infinity u exp(-q*u^2/c)du, which is at most 2c^2/q^2. Stronger Gaussian integral constants are possible but unnecessary here. Holomorphy and higher derivative domination are inherited from the theta proof on any slightly wider closed log-plane strip.

## 3. Height-dependent fixed tilt and polynomial conditioning bounds

Let H>=0 be a rational bound for all ordinate magnitudes in one contour or slab and put H0=max(1,H), B=cH0. For a positive-height slab choose sign j=+1, and for a negative-height slab choose j=-1. Set

\[
 b=j\frac\pi4(1-1/H_0),\qquad
 R=\frac\pi4-\frac\pi{8H_0}.
\]

Both b and R are fixed while evaluating that slab. At H0=1 the tilt is zero. The elementary sine lower bound on [0,pi/2] gives

\[
 \cos(2b)\ge1/H_0,\quad \cos(2R)\ge1/(2H_0),\quad
 R-|b|=\pi/(8H_0)>3/(8H_0).
\]

Thus at the actual Fourier sampling height y=b one can use

\[
 Q_b(r)=2B\exp(r-e^{2r}/B),\qquad
 M_b=J_b=2B^2,                                                       \tag{5}
\]

where M_b bounds the L1 kernel norm and J_b its first absolute moment. On the outer shift lines y=+/-R, take M_R=8B^2. The shifted time bounds are

\[
 |F_{\sigma,b}(t)|\le M_R
 \begin{cases}e^{-(R-b)t},&t\ge0,\\e^{-(R+b)|t|},&t\le0.
 \end{cases}                                                        \tag{6}
\]

In particular, both rates exceed 3/(8H0), although one is much better than this for H0>1. The sign j selects which time direction is enlarged by the tilt.

Now differentiate (2). Because

\[
 \partial_\sigma G_{\sigma,b}(x)
          =(x+ib-\tfrac12\log c)G_{\sigma,b}(x),
\]

the ib and log(c)/2 terms both cancel the derivatives of its prefactor. Dominated differentiation is justified by (3)-(4). The exact complex derivative is

\[
 Z_{b,\chi}'(\sigma+it)
   =e^{-ib\sigma}c^{(\sigma+a)/2}
                       \int_{\mathbb R}xG_{\sigma,b}(x)e^{itx}\,dx.  \tag{7}
\]

The t derivative is i times (7), as required by holomorphy. For the full real range of interest,

\[
 |Z_{b,\chi}(s)|\le2c^{7/2}H_0^2<2c^4H_0^2,
 \qquad |Z_{b,\chi}'(s)|\le2c^{7/2}H_0^2<2c^4H_0^2.                 \tag{8}
\]

These bounds are polynomial in c and the selected height bound. They hold for every real ordinate for the fixed b; the parameter H0 is used to define that b, not as an additional hidden restriction on the derivative proof.

The conditioning change is exact: |Z_b(sigma+it)|=exp(b*t)|Lambda(sigma+it)|. On the intended sign of the ordinate, this removes the prescribed exponential smallness caused by choosing zero tilt. The kernel norms and first moments needed to approximate Z_b grow only polynomially in H0. No Gamma asymptotic is needed for these bounds. There is still no lower bound for |Z_b|: cancellation, proximity to a zero or an actual zero can make it arbitrarily small. In particular, polynomial upper bounds do not imply a polynomial-time or uniformly successful nonvanishing algorithm.

## 4. Arbitrary tolerance without a cH cap

The following rational selection is a sufficient finite-accuracy protocol for F_(sigma,b) uniformly over the full sigma slab and |t|<=H0. Let e>0 be its requested norm tolerance. Unlike the older fixed-height example, it assumes no bound on cH0.

Choose an integer K>=1 so that

\[
                       32B^2(3/8)^K<e/4,
 \qquad P=(2+4K)H_0.                                                \tag{9}
\]

Then P>2H0 and P>=6. By (6), each unwanted time copy has a geometric majorant. The smaller rate exceeds 3/(8H0), the denominators are greater than 1/2, and rate*(P-H0)>K. Therefore

\[
              E_{\rm time}<4M_R e^{-K}=32B^2e^{-K}<e/4.              \tag{10}
\]

Choose L>=1 with 12B(3/8)^L<e/4, then x>=1 satisfying

\[
                         (8/3)^{2x}\ge B(2x+L).                     \tag{11}
\]

Let N be the smallest power of two at least Px/3. With omega=2*pi/P, X=pi*N/P and D=88x/21, one has X>x, omega<2 and omega*N<D. Keep one centered block of N frequency indices. The same decreasing-progression estimate as in the zero-tilt note, now with Q_b from (5), gives

\[
 E_{\rm freq}
 \le2Q_b(X)\left(\omega+\frac1{2e^{2X}/B-1}\right)
 <6Q_b(x)<12B e^{-L}<e/4.                                           \tag{12}
\]

The positive omitted frequency begins at X, while the negative one begins at X+omega; the displayed estimate safely starts both at X. This retains the centered-index and Nyquist endpoint conventions from the accepted alias proof.

For the finite Gaussian sum use n0=M+1 and define

\[
 V=3n_0^2/B,\qquad z=3(2n_0+1)/B-1/n_0.
\]

The actual Gaussian real part at any retained frequency is at least 3*exp(2|x|)/B. The direct and reciprocal prefactor exponents are at most 3. Thus when V>=2 and z>0 a uniform per-coefficient series-tail bound is

\[
                  E_{\rm series}
           \le2n_0(1+1/z)(3/8)^{\lfloor V\rfloor}.                  \tag{13}
\]

Increase or double n0 until D times (13) is less than e/4. Additional certified norm error at each retained coefficient may be at most e/(8D). The remaining finite-transform implementation budget e/8 applies to the **final scaled Fourier output**

\[
 S_m=\omega\sum_{j\in J_N}C_j e^{2\pi i jm/N}
     =\omega N\,\operatorname{invDFT}(C)_m,
\]

not to the unscaled `invDFT` value. For the supplied finite coefficient representatives, the implementation must prove |S_computed-S_exact|<=e/8, including all transform arithmetic, twiddle errors, multiplication by omega or omega*N, and rounding of that multiplier and product. Coefficient errors are accounted for separately by the preceding e/(8D) input budget. With this final-output contract the total error is less than e.

An implementation that instead certifies the normalized `invDFT` value before scaling can use the following explicit split: bound its norm error by e/(16D), then bound **all additional error in forming the final scaled output** by e/16, including approximation of omega*N and multiplication rounding. Since omega*N<D, the first contribution after exact scaling is less than e/16, and the two contributions total at most e/8. A pre-scaling bound of e/8 alone is insufficient. The source multiplier is omega*N throughout; tilt does not alter it. The scalar receipt's `finite_transform_error_target` field denotes this final scaled-output e/8 budget.

Every parameter search terminates for fixed rational B>=2 and e>0. The K and L inequalities are geometric. The ratio (8/3)^(2x)/(2x+L) grows geometrically for x>=1. For n0>=B, z>6 and V>=3n0, so (13) is less than 3n0(3/8)^(3n0), which tends to zero. These arguments apply also to rational, nonintegral B. Finite roundoff targets must be met by certified elementary arithmetic and a proved finite-transform error bound; they are not machine-accuracy assumptions.

This protocol certifies grid values by FFT if an FFT implementation supplies the required error proof. The same finite trigonometric sum evaluated directly is valid at arbitrary rational t. No grid-alignment claim is made for a general requested endpoint. The zero-tilt protocol can use a shorter period, whereas the near-boundary tilt here has its smaller time-decay rate of order 1/H0. Better conditioning is bought with different evaluation work; no speedup is claimed.

## 5. Full panels with the holomorphic normalization retained

At a point s=sigma+it, compute F_(sigma,b)(t) and the complete multiplier

\[
                 A_b(\sigma)=e^{-ib\sigma}c^{(\sigma+a)/2}
\]

with certified complex enclosures. Its exact norm is at most c^2. The phase and the positive scale both need their own rounding errors. A concrete point-to-panel allocation is as follows. For a desired final panel radius r0>0, compute an F midpoint approximation with norm error at most

\[
 d_F=\min(1,r_0/(8c^2)),
\]

and a multiplier approximation with norm error at most

\[
 d_A=\min(1,r_0/(8(M_b+1))).
\]

Since |F|<=M_b and |A_b|<=c^2, the exact product of those two approximations differs from Z_b by at most r0/4. Allow at most another r0/4 for the finite multiplication, yielding a point error at most r0/2. This is a concrete error allocation, not a claim that a fixed hardware product meets it.

Equation (8) gives the Lipschitz estimate on any segment contained in the real slab,

\[
 |Z_b(s)-Z_b(s_0)|\le2c^4H_0^2|s-s_0|.                              \tag{14}
\]

Hence a panel lying within distance r0/(4c^4H0^2) of its midpoint is enclosed by adding at most r0/2 variation to the point enclosure. This treats horizontal and vertical segments of the same entire function and retains the phase in (2). It is conservative but arbitrarily refinable. A sharper Cauchy or finite-polynomial panel bound can replace it only with its own proof.

Full-panel nonvanishing still requires that the resulting complex enclosure exclude zero, for example by a strict coordinate half-plane. Shared vertices and a winding proof still require the accepted geometric certificate machinery. Existence of arbitrarily precise point and panel enclosures is separate from truth of the desired nonvanishing statement.

## 6. Opposite tilts and shared-edge bookkeeping

For the actual inverse character, conjugation gives

\[
 Z_{-b,\chi}(\sigma-it)
             =\overline{Z_{b,\bar\chi}(\sigma+it)}.                  \tag{15}
\]

Same-character reuse in (15) requires a real character. For a nonreal character it uses the exact inverse label from the arithmetic manifest. A reflected contour and reflected image both require their correct orientations; a stored winding sign must not be copied without that geometry check.

Different slabs may use different fixed tilts. Each Z_b is entire and individually has the same count as Lambda, so independently certified counts can be combined by an explicit domain-counting argument. However, their image polygons do not cancel along a shared edge merely because the input edge is the same:

\[
             Z_{b_2}(s)=e^{-i(b_2-b_1)s}Z_{b_1}(s).                  \tag{16}
\]

This ratio is generally neither constant nor of modulus one. There are two valid assembly routes:

* Keep separate closed contours and add their zero counts only after proving that their interiors cover the intended region without double counting, and that shared seams have no missing zeros or have an explicitly accounted boundary contribution.
* Convert the enclosures and vertices on all pieces to one common fixed normalization Z_(b*) using the exact exponential ratio in (16), then perform shared-edge cancellation in that common image. The conversion needs fresh interval error control and can sacrifice conditioning.

In particular, splitting at the real axis does not make that seam automatically zero-free. Primitive nonprincipal L-functions may not be assumed to lack real zeros merely to join positive and negative packets. A single fixed b can also be retained for a larger contour if desired; all identities remain valid, although its conditioning benefit favors one ordinate sign.

## 7. Exact scalar examples and their limited meaning

`tilted_right_slab_parameters_20261111.py` applies only rational arithmetic to (9)-(13). It allocates no transform arrays and evaluates no character, exponential, L-function or zero. Five rows pass:

| c | H0 | F tolerance | K | L | x | N, integer only | n0 |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 3 | 10 | 10^-12 | 41 | 36 | 4 | 4096 | 32 |
| 101 | 1000 | 10^-30 | 99 | 87 | 9 | 2097152 | 2048 |
| 300000 | 100000000 | 10^-40 | 163 | 130 | 19 | 549755813888 | 67108864 |
| 4 | 1, from H=0 | 10 | 6 | 4 | 2 | 32 | 2 |
| 5 | 7/3 | 1/1234567 | 25 | 21 | 3 | 256 | 16 |

The large integers in the third row are conservative existence witnesses. No practical feasibility, memory use or runtime estimate is attached to them. The comparison with zero tilt should not treat these fixed absolute F tolerances as equal relative accuracy for unnormalized Lambda.

Frozen files:

* Script SHA256 `15D058DED942333655F3F8599FA9A893A945E18063970BFC69532F95453E1FDD`.
* Receipt SHA256 `1D009682FFA399B9E9B1A93C81022E4C9A87BB92C74573C52B9801A11C65546B`.

Read-only reproduction from the repository root:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/tilted_right_slab_parameters_20261111.py --recompute
```

## 8. Source status and remaining evidence

This extends the accepted `FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `618FB579D8657C72F2003BE4D60C68E38648C2F30F266938CE40E2C8F5A5E771`, reviewed at `../moebius/REVIEW_FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `AE8F8F852F969B6505EE9AC60E5F4D67B7AF686E94F6A9B4E4FED54D8F9ED271`. Its source pins remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

The actual completed continuation, primitive theta transformation, positive Fourier normalization and finite error adapters are the ones inventoried in the accepted Gaussian/off-critical/full-slab notes. The new steps use only complex-exponential holomorphy and nonvanishing, product/chain rules, the same dominated theta integrals, and the elementary sine lower bound already used in the accepted near-pi/4 alias proof. There is no added root premise or historical GRH import.

What remains includes formalizing the tilted normalization and derivative cancellation, certified phase/scale arithmetic, the arbitrary-size finite transform, actual coefficients and complete panels, and the domain/edge assembly proof. If the chosen boundary is genuinely zero-free, convergent point accuracy and fair mesh refinement eventually yield strict panel witnesses; that is a conditional termination statement. The weak allowed boundary may itself contain zeros, and an interior count may be nonzero. This packet does not resolve either fact for any untested character.

Independent review is requested from the moebius worker. The earlier accepted numerical slab remains a separate actual-data result; nothing in this paper packet enlarges its certified domain.
