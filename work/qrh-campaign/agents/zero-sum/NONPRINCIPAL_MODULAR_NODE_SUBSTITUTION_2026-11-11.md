# Modular nonprincipal nodes to complex Taylor and panel certificates

2026-11-11. Paper composition contract. No new theta values, FFT, spectral scan, contour, Lean build or permitted root premise is supplied. The four-case bucket pilot remains four-case evidence; it does not establish a producer bound for other nodes.

This note replaces the direct Gaussian node construction in the accepted joint character/Fourier plan by certified modular signed-bucket values. It derives the nonprincipal derivative quadrature and spatial bounds explicitly. No principal-xi constants are reused.

## 1. Target and exact coefficient identities

Let c>1 and chi be an actual primitive nonprincipal character at conductor c, of parity a in {0,1}. Use the source entire function

\[
 \Lambda_\chi(s)=c^{(s+a)/2}\operatorname{completedLFunction}_\chi(s),
 \quad W_\chi=\tau(\chi)/(i^a\sqrt c),\quad |W_\chi|=1,
\]

where tau uses the positive additive exponential. Fix a single real b with |b|<pi/4 on the complete contour or Taylor packet, and define

\[
 Z_b(s)=e^{-ibs}\Lambda_\chi(s).
\]

The source continuation, rather than a pointwise product of totalized Gamma and L at poles, defines Lambda. On the target real range 111/200<=Re(s)<=2, it differs from actual L by a holomorphic nonzero factor. Z_b is entire and has the same zeros and analytic orders as Lambda. No Hardy realness or root-square-root phase is used.

For a center s0=sigma+it0 in that real range, let

\[
 \lambda=\sigma+a,\quad \mu=1+a-\sigma,\quad
 A_\sigma=e^{-ib\sigma}c^{\lambda/2}.
\]

The accepted kernel and inverse transform are

\[
 h_\sigma(w)=2c^{-\lambda/2}e^{\lambda w}\theta_\chi(e^{2w}),
 \quad G_\sigma(x)=h_\sigma(x+ib),\quad
 F_\sigma(t)=\int_{\mathbb R}G_\sigma(x)e^{itx}dx,
\]

\[
 Z_b(\sigma+it)=A_\sigma F_\sigma(t).
\]

Here theta_chi(z)=sum_(n>=1) n^a chi(n)exp(-pi*n^2*z/c). Differentiation gives partial_sigma G=(x+ib-log(c)/2)G; the constants cancel against partial_sigma A. Repeating this cancellation proves for every j>=0

\[
 f_j:=\frac{Z_b^{(j)}(s_0)}{j!}
 =A_\sigma I_j,\qquad
 I_j=\int_{\mathbb R}\frac{x^j}{j!}G_\sigma(x)e^{it_0x}dx.             \tag{1}
\]

Thus derivative nodes carry the signed power x^j/j!, with no extra ib or log(c) polynomial. All following derivative errors concern these normalized Taylor coefficients; ordinary derivatives require a final factor j!.

## 2. Modular bucket contract and parity conversion

At a nonnegative frequency magnitude v, put z_+=exp(2(v+ib)). The modular producer must return centers b_R and norm radii e_R for the exact **full** signed buckets

\[
 B_{R,a}(z_+)=\sum_{n\in\mathbb Z,\ n\equiv R\ (c)}
                       n^a e^{-\pi n^2z_+/c},\qquad R\in(\mathbb Z/c\mathbb Z)^\times.
\]

The supplied inequalities |B_(R,a)-b_R|<=e_R must include the original input enclosure, every shared modular-word step, exact characteristic phase, principal root and odd-moment factor, reduced-series tail, and finite arithmetic. The internal c^a factor in B=c^a H_a[R/c,0](ic z_+) is part of this bucket contract. It must not be applied again downstream.

For matching parity define the unnormalized positive character transform

\[
 C_\chi(v)=\sum_{R\in(\mathbb Z/c\mathbb Z)^\times}\chi(R)B_{R,a}(z_+)
                         =2\theta_\chi(z_+).                        \tag{2}
\]

The equality uses chi(-1)=(-1)^a and chi(0)=0. An individual positive residue bucket is not half the signed bucket. Opposite-parity contractions vanish and cannot recover the opposite-parity positive theta sum. Discard imprimitive labels before invoking the primitive reciprocity below.

If the character-transform center is c_hat and its extra error against the exact unnormalized transform of the bucket centers is e_char, then

\[
                   |C_\chi(v)-\widehat C_\chi(v)|\le
                     E_C:=\sum_R e_R+e_{\rm char}.                  \tag{3}
\]

The character labels, inverse label, CRT permutation and positive exponential are those in the accepted manifest. If an implementation returns a normalized character transform, multiply both its value and its error by phi(c) first. Character-root rounding belongs in e_char unless already included in a separately proved input-product bound. Shared errors need no independence assumption.

## 3. Both frequency signs and the exact conductor/Gauss factors

Substitution of (2) into the Gaussian formula cancels its factor 2 with the signed-to-positive factor 1/2. At x=v>=0,

\[
 G_\sigma(v)=p_+(v)C_\chi(v),\qquad
 p_+(v)=c^{-\lambda/2}e^{\lambda(v+ib)}.                              \tag{4}
\]

For x=-v<0, primitive theta reciprocity gives

\[
 G_\sigma(-v)=W_\chi c^{-\lambda/2}e^{\mu(v-ib)}
             C_{\bar\chi}(\exp(2(v-ib))).                           \tag{5}
\]

The notation C on the right means the signed contraction at that indicated theta argument. Because bucket summands have real integer weights, conjugating their exact input changes b to -b. Together with the exact inverse character this gives

\[
 C_{\bar\chi}(\exp(2(v-ib)))=\overline{C_\chi(v)},\qquad
 G_\sigma(-v)=p_-(v)\overline{C_\chi(v)},
 \quad p_-(v)=W_\chi c^{-\lambda/2}e^{\mu(v-ib)}.                    \tag{6}
\]

The -b argument in this reciprocal coefficient is **not** a change from the analytic target Z_b to Z_(-b). The target retains its one fixed b. In particular, neither G(-v)=conj(G(v)) nor same-character Hardy realness is presumed.

The exact prefactor norms are c^(-lambda/2)exp(lambda*v) and c^(-lambda/2)exp(mu*v). The latter exponent may be negative. A certified approximation to p_- must include W error. W itself comes from the actual primitive positive Gauss sum, divided by i^a sqrt(c); a rounded unit norm is not its proof.

For either sign, with prefactor error rho_p and product rounding rho_mul, a valid node radius is

\[
 e_x=|p|E_C+\rho_p|\widehat C|+\rho_{\rm mul}.                       \tag{7}
\]

Conjugation does not change E_C. Certified upper bounds may replace |p| and |C_hat|. There is **no additional direct-Gaussian cutoff error** in (7): each modular bucket already encloses its full infinite sum. If a node instead uses direct accumulation, its direct tail belongs inside that node's supplied radius, not in a second global tail ledger.

As a normalization cross-check, multiplying the exact nodes by A_sigma gives

\[
 A_\sigma G_\sigma(v)=e^{iab}e^{\lambda v}C_\chi(v),
\]

\[
 A_\sigma G_\sigma(-v)=W_\chi e^{-i(a+1)b}e^{\mu v}
                                      \overline{C_\chi(v)}.         \tag{8}
\]

No explicit outer conductor power remains in (8), because the two source normalization factors cancel. The bucket definition and its internal c^a factor remain unchanged.

## 4. Derivative quadrature and omitted spatial nodes

Choose a real strip margin delta>0 with |b|+delta<pi/4, and rational positive bounds

\[
 q_*\le\cos(2(|b|+\delta)),\quad q_b\le\cos(2b),\quad q_*,q_b\le1.
\]

For sigma in the target real range, the accepted nonprincipal Gaussian estimate is

\[
 |h_\sigma(x+iy)|\le\frac{2c}{q}\exp(|x|-(q/c)e^{2|x|})
 \quad\hbox{when }\cos(2y)\ge q.                                    \tag{9}
\]

Let M_*=2c^2/q_*^2, M_b=2c^2/q_b^2, d_b=q_b/c. The inequality |x|^j/j!<=exp(|x|), followed by u=exp(|x|), gives

\[
 \int_{\mathbb R}\frac{|x|^j}{j!}|G_\sigma(x)|dx\le M_b
                                      \quad(j\ge0).                 \tag{10}
\]

For the trapezoid theorem apply the strip-shift argument to

\[
 w\longmapsto\frac{w^j}{j!}h_\sigma(w+ib)e^{it_0w}.
\]

On Im(w)=+/-delta, |w|^j/j!<=exp(|Re(w)|+delta). The shifted-line integral is therefore at most exp((T+1)delta)M_* whenever |t0|<=T. Summing the two Fourier/geometric tails of the periodization gives the **normalized derivative** quadrature error

\[
 Q_j=\frac{2M_*e^{(T+1)\delta}}{e^{2\pi\delta/h}-1},\qquad j\ge0.   \tag{11}
\]

For j=0 one may improve the numerator by removing exp(delta); the uniform formula (11) is sufficient. This derivation accounts for the complex shifted factor w^j. Reusing only the undifferentiated bound without it would be unjustified.

Retain symmetric nodes x_k=kh, -K<=k<=K, and put V=Kh. For the omitted real-node sum, (9) and |x|^j/j!<=exp(|x|) give the majorant

\[
 (2c/q_b)\exp(2u-d_b e^{2u}),\qquad u=|x|.
\]

It is decreasing on u>=V provided d_b exp(2V)>=1. Integral comparison on both omitted tails then gives

\[
                       S_j=M_b e^{-d_b e^{2V}},\qquad j\ge0.        \tag{12}
\]

Equations (11)-(12) are derived for this nonprincipal kernel. They are not the principal-xi P-kernel bounds. In particular the monotonicity threshold here is 1 because the majorant has exponent 2u, whereas the principal derivative packet used a different majorant.

For this symmetric trapezoid construction, Q_j and S_j are the complete quadrature/time-copy and spatial/frequency-omission accounting. The older alias ledger is an alternative presentation of those operations; it is not an additional independent error term to add again.

Gaussian decay and its derivatives justify the strip shifts, periodization and differentiations. The scalar searches terminate: shrink h to reduce (11), enlarge K while maintaining the threshold to reduce (12), and refine each finite modular node to reduce (7). A bound on the time parameter must include every actual center being evaluated. No unknown-zero hypothesis is needed for finite-accuracy evaluation.

## 5. Complete finite error ledger and final conversion

Suppose g_hat_k has radius e_k for exact G_sigma(x_k). Define the exact weights

\[
 w_{j,k}=h\frac{x_k^j}{j!}e^{it_0x_k}.
\]

If computed weight centers w_hat_(j,k) have errors d_(j,k), and I_hat_j differs from their exact finite product-sum with g_hat_k by at most eta_j, then

\[
 |I_j-\widehat I_j|\le E_{I,j}:=Q_j+S_j+
 h\sum_{k=-K}^K\frac{|x_k|^j}{j!}e_k+
 \sum_{k=-K}^K d_{j,k}|\widehat g_k|+\eta_j.                          \tag{13}
\]

The product split is w(G-g_hat)+(w-w_hat)g_hat; hence no mixed error term is omitted. The signed powers x_k^j belong in the center sum, while absolute powers occur only in its radius. Define x^0=1 at zero; for j>0 the zero-node weighted term is zero.

Now approximate A_sigma by A_hat with error rho_A and round the product A_hat I_hat_j with error rho_out,j. The actual Taylor coefficient ball is centered at f_hat_j with radius

\[
 E_j=c^{\lambda/2}E_{I,j}+\rho_A|\widehat I_j|+\rho_{{\rm out},j}.   \tag{14}
\]

This includes the final conductor scale and the phase exp(-ib*sigma). All errors in (13) are in I units; comparing them directly against a Z_b tolerance before (14) is incorrect. Alternatively one may construct the direct Z nodes (8), but then every node and quadrature bound must be expressed consistently in those scaled units.

## 6. Taylor disk and whole panels

Equation (10) proves a bound for **every** true Taylor coefficient at the center:

\[
                       |f_j|\le D_\sigma:=c^{\lambda/2}M_b
                                     \le2c^4/q_b^2.                 \tag{15}
\]

Since Z_b is entire, its Taylor series is the actual function. For any rho<1 and |z|<=rho, (15) gives

\[
 \left|Z_b(s_0+z)-\sum_{j=0}^d\widehat f_jz^j\right|
 \le\sum_{j=0}^d E_j\rho^j+
                         D_\sigma\frac{\rho^{d+1}}{1-\rho}.        \tag{16}
\]

This disk statement is valid even if part of the disk crosses the edges of the original real slab: (15) bounds all derivatives **at the center**, and the function is entire. It does not incorrectly apply a value bound valid only in the real slab to an enlarged Cauchy circle. The coefficient computation needs |Im(s0)|<=T. If one instead computes coefficients by numerical samples on an outer circle, those separate samples require their own larger height and real-part domain bounds.

For a whole panel, interval-evaluate the polynomial along the actual segment and add (16). A strict half-plane excluding zero then proves nonvanishing everywhere on that panel. A simpler alternative for a segment staying in the original real slab uses the accepted first-derivative bound 2c^4/q_b^2 with a point enclosure. Neither construction assumes that a midpoint or a grid sample alone certifies its neighborhood.

The fixed analytic b must be retained throughout the Taylor packet. Changing b between coefficients would change the function. Separate contour pieces with different tilts require a common-normalization conversion or the reviewed independent-count/domain assembly; raw image vertices from different Z_b functions do not cancel automatically.

## 7. Joint batching, endpoints and exact FFT scales

The full modular bucket values at z_+(v) are independent of sigma, so the accepted joint batching schedule still applies: build each parity's unit buckets, perform its positive character transform, retain matching primitive C values, and reuse them for the required sigma prefactors and both signed frequencies. Root-number data is separately certified once per character. Direct and modular node producers may be mixed if each returns the same full bucket contract.

For the symmetric quadrature in (13), retain x_k=kh for -K<=k<=K. The zero Fourier node is evaluated once by the positive formula (4); it is not omitted merely because chi(0)=0 in the different integer theta index. Both endpoint nodes -K and +K occur once. The negative endpoint can reuse the magnitude K cache through (6).

At fixed sigma,b and a base ordinate t_base, form for each j the array

\[
 a_{j,k}=\frac{x_k^j}{j!}\widehat g_k e^{it_{\rm base}x_k}.
\]

Embed -K,...,K into distinct residues modulo a transform length L>=2K+1. At t_l=t_base+2*pi*l/(Lh), its exact finite synthesis for I_j is h times the unnormalized positive DFT. Thus:

* The source normalized positive inverse DFT is scaled by hL.
* An unnormalized positive Bluestein output is scaled by h.

The implementation contribution eta_j in (13) must be measured in the **final scaled I_j output**, including its hL or h multiplier and scaling rounding. A pre-scaling error is insufficient without propagation through that scale. The final analytic conversion A_sigma is still applied by (14). The j! division is already in the input, so it is not applied again.

If a different centered scheme retains -K,...,K-1, it has omitted the +K node relative to (13). It must add that missing weighted node to the error or use a separately proved asymmetric spatial-tail bound. The symmetric bound cannot silently cover the missing endpoint. Likewise folded frequencies may only be merged at the compatible time grid; off-grid evaluation uses the unfolded sum or a proved interpolation formula.

Character and time transforms can be reordered only through the exact two-branch identity in the joint plan. The negative branch retains the inverse-character transform and W diagonal. Error budgets follow the chosen implementation order; neither shared data nor repeated use of a radius halves its contribution.

## 8. Pinned inputs and remaining work

The relevant accepted packets are:

| Packet | Producer SHA256 | Independent review SHA256 |
|---|---|---|
| `../major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md` | `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D` | `2F5645939D0F3EB3B90860B07BE4A343082F2E8EAE7578888998DB7661117F56` |
| `TILTED_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md` | `695BF1B9AE43BDDA950F111D8A484B35DE774578B6F5A14012763740E28848AE` | `DB9670A184F7CEF9AFA812263EC61592CB288E0F2863B63446D7415E6DA33469` |
| `../integration/NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md` | `2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09` | `FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70` |
| `NONPRINCIPAL_MODULAR_BUCKET_PILOT_2026-11-11.md` | `67B8600CE22CBCEA5C18AC9B969746A93901D694C3B54CD244425A443F6B8448` | `BD769E12B182728E97033CDF2218600D67A862179EBC663425289D7490B2F50F` |

The source revisions remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The actual completed continuation, primitive Gauss formula, inverse-character identification, theta reciprocity, and positive DFT convention are those already source-audited in these packets.

For a future Lean composition lemma, the new algebraic part is finite triangle inequalities (3), (7), (13) and (14), followed by the entire Taylor bound (16). Its analytic inputs still require formal proofs: the source theta identity, modular node evaluator, derivative quadrature and monotone-tail bounds. Actual node packets and their inequalities must be proved rather than installed as permitted final hypotheses. The pilot covers only its four fixed coefficient inputs.

This substitution removes the direct theta truncation term from the global ledger because it is replaced by certified modular node radii. It does not remove quadrature or spatial truncation errors, supply missing nodes, prove a successful nonvanishing test, or certify the family spectrum. The principal conductor-one case remains separate.
