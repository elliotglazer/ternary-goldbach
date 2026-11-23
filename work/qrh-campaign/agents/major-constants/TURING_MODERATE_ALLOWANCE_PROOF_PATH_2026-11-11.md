# A moderate Turing allowance with one explicit analytic gap

2026-11-11. Source and paper research only. The quantitative derivation below gives an allowance below 18 when log(cH/(2pi))<=18, conditional on a precisely stated finite real partial-fraction approximation for the actual completed L-function. That approximation is not claimed proved here. The derivation avoids Rademacher's sharp upper bound, a full infinite Hadamard product, Booker's sharp zero-pair inequality, numerical zeta-derivative data, and sharp Gamma constants. It creates no new permitted premise of the final theorem. No function values, spectra, prime scans, Lean declarations/builds, or frozen-file changes were produced.

The current elementary allowance is 42+6.93*18=166.74 per character. Its complete paper proof remains the usable input. A historical width-10 choice is not a universal successful guard. This note identifies a substantially smaller analytic target and the exact source adaptation needed before it can replace that input.

## 1. Constants and the resulting target

Let chi be primitive of conductor c>1, t>50, and put

\[
 Z_t=\log(ct/(2\pi)),\qquad
 I_\chi(t)=\int_{1/2}^{\infty}\log|L(\sigma+it,\chi)|\,d\sigma.
\]

The already reviewed elementary upper bound is

\[
 I_\chi(t)<3.434+\tfrac34 Z_t. \tag{U}
\]

The proposed lower argument has the following quantitative inputs. Sections 2-4 prove the new elementary reductions; section 5 isolates the missing analytic producer.

| Input | Sufficient bound | Status |
|---|---|---|
| Integrated zero-ratio loss | at most 4 times the real resolvent at 3/2+it | Elementary scalar proof below, independently corroborated |
| Half-digamma and compact Gamma ratio | errors at most 1/40 about their log(t/2) main terms | Derived below from accepted normalized Binet/P2 identity |
| Euler derivative at 3/2 | C3<5/2 | Elementary series/integral reduction below |
| Two Euler tails | lower bound >-2.368 | Follows from accepted J(5/4)<1.184 |
| Uniform finite real partial fractions for actual completion | statement (F) below | Missing source-level producer; no RH premise allowed |

These yield

\[
 I_\chi(t)>-12.493-\tfrac32 Z_t. \tag{L}
\]

With the already reviewed canonical Littlewood identity, both signs of the integral satisfy

\[
 \left|\int_{t_1}^{t_2}S_\chi(t)\,dt\right|
 <\frac{15.927+2.25Z_{t_2}}\pi,\qquad 50<t_1<t_2. \tag{T}
\]

In particular, Z_{t2}<=18 gives an allowance strictly below 18, since

\[
 15.927+2.25\cdot18=56.427<18\cdot3.14=56.52<18\pi.
\]

Even Z_{t2}<=20 gives an allowance below 20 because 60.927<62.8<20pi. The target is uniform over both parities and all primitive nonprincipal conductors in the stated log range. No character-dependent numerical constant is hidden in (T).

For the current nonprincipal family and conditional auxiliary allocations with h<=500, the already checked scalar log witness gives Z_{T+h}<18. If a future measured deficit D<=1/2 holds, b=18 and h=25 would pass the reviewed RH-only test D+2b/h<2, with surplus 3/50. This is a conditional budget, not a claimed successful guard or a guaranteed factor-ten reduction from h=250. Changing h changes D and requires new valid evaluation domains and evidence.

## 2. Elementary zero-ratio inequality

For 1/2<=a<=3/2 and real y define the integrable log-norm difference

\[
 J(a,y)=\int_0^1\bigl(\log|a+iy+u|-\log|a+iy-u|\bigr)\,du.
\]

At a real zero of the denominator the integrand is interpreted almost everywhere; no pointwise totalized quotient identity is used there. The claim is

\[
 0\le J(a,y)\le4\frac{a}{a^2+y^2}. \tag{J}
\]

Set r2=a^2+y^2. For almost every u, the integrand equals

\[
 \tfrac12\log\left(1+\frac{4au}{(a-u)^2+y^2}\right).
\]

It decreases with y^2, so J(a,y)<=J(a,0). Direct integration gives

\[
 J(a,0)=(a+1)\log(a+1)+(a-1)\log|a-1|-2a\log a.
\]

It is continuous at a=1 by v log|v|->0. Away from 1 its derivative is log|1-1/a^2|. Therefore its maximum on the specified interval occurs at a=1/sqrt(2), with value 2log(1+sqrt(2))<2. The last comparison follows from 1+sqrt(2)<5/2<exp(1).

If r2<=2a, this gives J<2<=4a/r2. If r2>2a, then

\[
 y^2=r2-a^2>r2(1-a/2)\ge r2/4.
\]

Use log(1+v)<=v and integrate 2au/((a-u)^2+y^2)<=8au/r2. This gives J<=4a/r2. No zero pairing, simplicity, or finite-RH statement enters (J).

For a zero rho=beta+i gamma in the critical strip, a=3/2-beta and y=t-gamma. A change of variables then gives

\[
 \int_{1/2}^{3/2}\log\left|\frac{\sigma+it-\rho}{\sigma+1+it-\rho}\right|d\sigma
 =-J(3/2-\beta,t-\gamma).
\]

The finite sum version with actual positive analytic multiplicities follows by linearity. Independent corroboration is `prime-estimates/UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md`, SHA256 `D315AE5C7B98C8A8E1042FE548B7A5FB704CEB200CFA48E36509A5A23910DB1B`, reviewed in `moebius/REVIEW_UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md`, SHA256 `B42C970619E291A81BCFD1B3FBB39498CA471FB07F7DDC47B9DB8D52BAC8D3D4`.

## 3. Coarse Gamma and Euler inputs without numerical evaluations

The accepted normalized Binet construction gives a holomorphic logarithm of Gamma on Re z>0. Its already derived periodic-P2 formula is

\[
 \log\Gamma(z)=(z-1/2)\Log z-z+C+R(z),\quad
 R(z)=\frac1{12z}-\frac12\int_0^\infty\frac{B_2(\{v\})}{(z+v)^2}dv,
\]

where C is real and |B2|<=1/6. On compact right-half-plane sets the integrand and derivative admit integrable majorants, so differentiation gives

\[
 R'(z)=-\frac1{12z^2}+\int_0^\infty\frac{B_2(\{v\})}{(z+v)^3}dv.
\]

For z=sigma+iy, sigma>0 and y>0, splitting v at y proves

\[
 \int_0^\infty|z+v|^{-3}dv\le y^{-2}+(2y^2)^{-1},
 \qquad |R'(z)|\le\frac1{3y^2}.
\]

Consequently, for 1/4<=sigma<=7/4 and y>25,

\[
 |\Re\psi(z)-\log y|
 \le\frac1{2y}+\frac{49}{32y^2}+\frac1{3y^2}
 <\frac1{50}+\frac{49}{20000}+\frac1{1875}<\frac1{20}. \tag{G}
\]

Here psi is the actual Gamma logarithmic derivative. The log term uses log(1+v)<=v; no sharp complex Stirling theorem is imported. For parity a=0 or 1, all arguments in the compact shift ratio are (sigma+a+u+it)/2 with sigma in [1/2,3/2] and u in [0,1], so their real parts lie in [1/4,7/4]. Integrating the derivative over the half-unit Gamma shift and then over the unit sigma interval yields

\[
 \int_{1/2}^{3/2}\log\left|\frac{\Gamma((\sigma+1+a+it)/2)}{\Gamma((\sigma+a+it)/2)}\right|d\sigma
 \ge\tfrac12\log(t/2)-\tfrac1{40}. \tag{G0}
\]

At s*=3/2+it the same estimate gives

\[
 \tfrac12\Re\psi((s_*+a)/2)\le\tfrac12\log(t/2)+\tfrac1{40}. \tag{G1}
\]

The source defines C3=sum Lambda(n)n^(-3/2) and proves |L'/L(3/2+it)|<=C3 without RH. For a coarse bound on C3, the absolutely convergent Euler/log-derivative identity gives

\[
 C3=\frac{\sum_{n\ge1}(\log n)n^{-3/2}}{\sum_{n\ge1}n^{-3/2}}.
\]

The denominator is strictly greater than integral_1^infinity t^(-3/2)dt=2. For the numerator, f(t)=log(t)t^(-3/2) is nonnegative and unimodal, with integral 4 and maximum 2/(3e)<1. The elementary unimodal sum-integral estimate sum_{n>=1}f(n)<=integral_1^infinity f+sup f therefore gives numerator<5 and C3<5/2. To prove that estimate, bound the increasing-side integer values by integrals on intervals to their right, the decreasing-side values by intervals to their left, and leave at most one term bounded by sup f. All identities are real convergent-series/integral statements; no prime list or zeta evaluation is used.

Finally, the accepted J(5/4)=integral_(5/4)^infinity log zeta(sigma) d sigma<1.184 implies J(3/2)<1.184. The two Euler lower tails after a unit shift are bounded below by -2J(3/2)>-2.368. Discarding the positive log-zeta(2sigma) contribution avoids the historical sharp I_E(1) numerical leaf.

## 4. A finite bridge instead of an infinite Hadamard product

Let f be the actual normalized completed L-function Psi_chi. All its zeros lie in 0<Re rho<1, and f is entire and not identically zero. Here is the precise sufficient approximation statement.

**(F)** For every compact disk K centered at 1/2 and every epsilon>0, there is a finite set Z of actual zeros of f, assigned their exact positive analytic multiplicities m_rho, containing every zero in K, such that

\[
 \left|\Re\frac{f'(s)}{f(s)}-
 \sum_{\rho\in Z}m_\rho\Re\frac1{s-\rho}\right|\le\epsilon
\]

for every nonzero point f(s)!=0 in K. The finite set may include additional zeros outside K. Exact multiplicities, rather than lower multiplicity bounds, are required.

Choose K large enough that the compact segment [1/2,5/2]+it is in its interior. Divide f by the finite polynomial P(s)=product_(rho in Z)(s-rho)^m_rho. Local zero factorization extends g=f/P holomorphically across the removed zeros, and g is nonzero near the segment because Z includes all its zeros with exact orders. The real logarithmic derivative of g is bounded by epsilon away from the finite removed set; continuity extends the same bound through it. Hence for 1/2<=sigma<=3/2,

\[
 \log|g(\sigma+it)|-\log|g(\sigma+1+it)|\ge-\epsilon.
\]

Integrating, identifying log-norm differences almost everywhere, and applying (J) to the finite polynomial gives

\[
 \int_{1/2}^{3/2}\log|f(s)/f(s+1)|d\sigma
 \ge-4\sum_{\rho\in Z}m_\rho\Re\frac1{s_*-\rho}-\epsilon
 \ge-4\Re\frac{f'(s_*)}{f(s_*)}-5\epsilon.
\]

Since epsilon is arbitrary, the needed ratio-resolvent inequality follows. This proof needs neither an infinite-product identity nor an interchange of an infinite zero sum and an integral. Horizontal zero singularities are handled by finite factorization and local log integrability.

For f=Psi_chi, its logarithmic derivative at s* equals

\[
 \tfrac12\log(c/\pi)+\tfrac12\psi((s_*+a)/2)+L'/L(s_*,\chi).
\]

By (G1) and C3<5/2, its real part is at most Z_t/2+2.525. The elementary shift decomposition is

\[
 I_\chi(t)=\int_{1/2}^{3/2}\log|L(s)/L(s+1)|d\sigma
 +\int_{3/2}^{5/2}\log|L(s)|d\sigma
 +\int_{3/2}^{\infty}\log|L(s)|d\sigma.
\]

The conductor power contributes Z_t/2 together with the Gamma main term in (G0). Thus

\[
 I_\chi(t)>\tfrac12Z_t-\tfrac1{40}
 -4(\tfrac12Z_t+2.525)-2.368
 =-\tfrac32Z_t-12.493.
\]

This proves the quantitative implication (F) => (L) => (T), keeping (F) visible as an unfinished theorem.

## 5. Concrete source path for the missing approximation

`Explicit/XiPartial.lean:479` proves a finite partial-fraction estimate for actual zeta xi on large good-height squares. Its `xi_partial_approx:776` makes the approximation uniform on any fixed compact disk and includes the true zero carrier. This is substantive reusable proof structure, not a theorem already applicable to a general Dirichlet character.

There are two source-faithful adaptation options.

1. For the individual character, use a two-basepoint residue kernel. With h=f'/f, compare h(s)-h(v) using [(w-s)^(-1)-(w-v)^(-1)]. The kernel is O(M/T^2) on a large square for s,v in a fixed disk. Set v=1-conj(s). The actual completed functional equation plus conjugation gives h(v)=-conj(h(s)). Reflection permutes the square's finite zeros with their exact orders, so the finite resolvent at v is minus the conjugate of the one at s. Taking real parts divides the difference identity by two and gives precisely (F). This route, suggested independently by prime_estimates, does not pretend that nonreal chi itself has holomorphic symmetry f(1-s)=f(s).
2. Work with f=Psi_chi*Psi_inverse instead. This product has holomorphic 1-s symmetry and conjugation symmetry. An adaptation closer to the existing zeta proof yields the paired Turing allowance directly, which is sufficient for the current two-channel consumer. The product's center lower bound is not the LDatum literal .355, so it must not be inserted into that structure unchanged. Individual-character good heights followed by conjugation or a generalized center-bound structure would be needed.

The individual route is narrower. Existing `ZeroSums.norm_L_le_BP:32` bounds L on radius-10 disks by

\[
 BP(c,t)=1400c^9(c+1)(|t|+22)[1.25(|t|+11)]^{10}.
\]

For each fixed c, log BP=O_c(log(|t|+2)). Together with the existing center lower bound, Landau estimate and generic good-height mechanism in `Datum.lean`, this supplies the shape needed for O_c(log^2 T) horizontal logarithmic derivatives. The completion adds elementary digamma and conductor-log terms. Right-boundary control follows from the Euler series, and the left side follows from actual reflection. Therefore the contour error has the form O_c(M log^2 T/T), which tends to zero. The intermediate thresholds may depend on c and the compact set; they disappear from the final uniform numerical bound. This does not require a new numerical zero search.

Important adapters remain to be proved, not inferred from the displayed O notation: a polynomial-BP LDatum or equivalent good-height statement; actual completed-function derivative/reflection identities; nonvanishing on the chosen boundaries; the two-basepoint residue formula; uniform error decay; and equality of divisor multiplicities to analytic orders. `ldatum_L:699` currently uses BT, so its literal instantiation does not automatically provide the needed polynomial logarithmic growth. The source theorem's hardcoded zeta facts must be removed with proofs.

In particular, the zeta proof uses nonvanishing at the central point as a factorization anchor. General characters may have central zeros. Use f(2)!=0 and a sufficiently large ball centered at 2, then filter by the reflection-invariant square centered at 1/2. For T>=8, that square lies inside the ball of radius 4T centered at 2; a larger factorization ball gives room for its analytic neighborhood. Only the filtered square and true orders need reflection invariance. No central-nonvanishing premise may enter (F).

This is an explicit source adaptation plan with a proved final finite bridge. It is not a source-level proof of (F), and no compilation claim is made.

## 6. How much more is needed for allowances near 10 or 4?

For a zero-ratio coefficient lambda in place of 4, the same coarse Gamma/Euler/tail ledger gives

\[
 \left|\int S\right|
 <\frac{5.827+2.525\lambda+(1/4+\lambda/2)Z_H}\pi. \tag{7}
\]

Booker's paired inequality, Trudgian Lemma 2.10, would allow lambda=log4<3/2 after exact same-character reflection pairing. With lambda=3/2 and Z_H<=18, the numerator is 27.6145<9pi. Thus an allowance 9 is possible without Rademacher and without the sharp numerical Gamma, zeta-derivative or I_E constants. The additional proof is the paired elementary inequality itself and its finite pairing adapter. It is cited, not proved by this note; the simpler unpaired constant4 has a complete proof above.

The published Rumely target at Z_H<=18 is 1.8397+.1242*18=4.0753. Its sharp lower ledger uses zero coefficient1.48, Gamma errors .0018/.0011, Euler derivative1.506 and I_E>-1.2183; the sharp upper uses Rademacher interpolation and its zeta-integral constants. Those exact leaves were retained as open in the prior source audit. Trudgian offers a parameterized alternative, but choosing parameters alone does not prove its imported lemmas. No optimized historical-code coefficient is accepted from personal communication.

The next high-value proof task is therefore (F), not another arithmetic tuning of h. Once (F) is proved, the complete coarse reductions above target b18. A later Booker proof could target b9 with the same remaining estimates. Reaching b near4 adds further analytic/scalar work. Comparing that work with a finite-Blaschke improvement of the existing elementary route requires an actual formalization plan, not a runtime assumption. No end-to-end savings are credited here.

## 7. Sources and pins

Primary source newly opened and compared with retained text: [Trudgian, Improvements to Turing's Method, arXiv:0903.1885v3](https://arxiv.org/pdf/0903.1885), Lemma 2.10 and section 3.4-3.5. Retained PDF `audit/trudgian_turing_0903_1885.pdf` SHA256 `E8D021A3C083D0F07427760661478E47390D446D06714257DEE702246FACC878`. The prior Rumely source audit is `independent-feasibility/TURING_BOUND_PRIMARY_SOURCE_AUDIT_2026-11-11.md`, SHA256 `39770248BAFA0EA935FAAB2660FE90E7DB6B0A6C01A1C0021DE0D33F68BD55F0`. Its original-PDF access limitation is unchanged.

Reviewed paper inputs under `work/qrh-campaign/agents`:

| Input | SHA256 |
|---|---|
| integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md | 72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C |
| audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md | A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9 |
| prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md, sections 1-2 | C7B701CF5B02D34142E30F38D1FFE573AE30167A561B9A759FD9964F41FC6E79 |
| moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md, normalized Binet construction | 0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028 |
| major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md | 6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401 |

Actual source at `work/ternary-goldbach`, HEAD `23b2d68ca344203d4384e0aff7affa4ec034bef9`:

| File under TernaryGoldbach/Explicit | SHA256 | Relevant declarations |
|---|---|---|
| XiPartial.lean | 8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770 | xi_partial_frac479; xi_partial_approx776 |
| Datum.lean | 42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE | LDatum18; logDeriv_nearD37; ldatum_L699 |
| ZeroSums.lean | 3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D | BP17; norm_L_le_BP32 |
| ExplicitFormula.lean | 8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35 | C3 definition726; norm_logDeriv_L_right739 |

The exact scalar displays are rational arithmetic and elementary symbolic bounds, not numerical Gamma/zeta/log evaluations. All analytic identities involving the actual source functions remain tied to their stated paper/source status. The only newly isolated major analytic input is (F); the existing canonical-log, Gamma-normalization, zero-carrier and count adapters still require their planned internal proofs.
