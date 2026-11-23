# Production spectral evaluation: a bounded RS and Cauchy-block experiment

2026-11-11. Research and external-library experiments only. No Lean build, dependency installation, native build, canonical edit, or frozen-file change. The existing height-14 and head certificates are preserved. This note does not certify the remaining strip or any family rectangle.

The remaining principal target is exclusion to the right of sigma=201/400=.5025 through height 10^6, with reflection supplying the left boundary .4975. The family target is .555 through Hcert(c)=min(Hp_old(c),10^8/c). The frozen 131-node package is not modified here.

## Result

Complex Riemann–Siegel (RS) replaces the long Euler–Maclaurin sum for high zeta point evaluations. A bounded experiment also supplies a concrete way to turn such point evaluations into whole-panel enclosures: a discrete Cauchy interpolation model, with an explicit alias and truncation bound. Two quarter-unit blocks centered at height 10^6 were enclosed and found nonvanishing, at sigma .5025 and .555. Each used 64 library point evaluations; the first required two half-plane panels and the second one.

This is a local evaluator demonstration, not a production certificate. The samples trust FLINT's RS implementation. Its analytic remainder, correction coefficients and special-function interval primitives still need independent proof/checker bridges. The family case requires a Dirichlet evaluator: zeta's RS routine is not such an evaluator.

## Actual bounded measurements

Existing interpreter: `work/qrh-campaign/interval-env/Scripts/python.exe`, Python3.14.7, python-flint0.9.0, installed FLINT3.6.0. Precision128 bits. Single runs on the current host; no warmed throughput forecast or extrapolated completion time.

| sigma | height | 32 point calls, seconds | minimum reported relative accuracy |
|---|---:|---:|---:|
|.5025|10000|.0323172|112 bits|
|.5025|100000|.0668159|112 bits|
|.5025|1000000|.0438879|111 bits|
|.555|10000|.0223487|119 bits|
|.555|100000|.0600276|117 bits|
|.555|1000000|.0449509|115 bits|

For every row, sixteen adjacent whole-ball panels at widths 1/16 and 1/256 failed the real-or-imaginary strict-sign nonvanishing test; sixteen panels of width1/4096 and1/65536 passed. These sets cover different short lengths and are not a global mesh study. Lower-accuracy balls may invoke less working precision, so panel-call and point-call timings must not be compared as identical workloads.

The improved local models use center sigma+i10^6, outer analytic radius R=1/2, sampling radius rho=1/4, target radius r=1/8, and64 samples:

| sigma | sample time | direct DFT time | polynomial panel time | accepted leaves |
|---|---:|---:|---:|---:|
|.5025|.0897757s|.0015343s|.0042412s|2|
|.555|.0868308s|.0014863s|.0000481s|1|

Both model errors are bounded by 3.240744e-15, in addition to the interval arithmetic already present in their coefficients. The .5025 panel timing includes first-use overhead and is not a stable per-panel cost. No zero search, full contour, or winding computation was performed in this benchmark.

Files: `rs_panel_benchmark_20261111.py/json` and `rs_cauchy_block_benchmark_20261111.py/json`, in this directory. The .555 calls evaluate zeta on that line, not a representative nonprincipal L-function. They demonstrate geometric parameters only.

## Pinned RS implementation and proof obligations

The [FLINT3.6.0 dispatcher](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta.c) selects RS when the imaginary midpoint exceeds 24*prec*sqrt(prec), subject to its real-part restriction. At128 bits this threshold is about34755. Thus the two higher benchmark heights are predicted to use RS from source inspection; the benchmark does not instrument dispatch.

The [RS assembly](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs.c) uses

    zeta(s)=R(s)+X(s)*conj(R(1-sigma+it)),
    X(s)=pi^(s-1/2)*Gamma((1-s)/2)/Gamma(s/2).

Negative heights use conjugation. The second auxiliary value is not interchangeable with the first unless sigma=1/2. For inexact input, the implementation evaluates a midpoint and adds a first-derivative bound times the input radius. This explains the wide-panel limitation observed above; it does not establish any global lower bound for zeta.

The [auxiliary evaluator](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_r.c) has N=floor(sqrt(t/(2*pi))) ordinary Dirichlet terms and a finite correction. Put a=sqrt(t/(2*pi)) and p=1+2(N-a). Its correction is multiplied by a^(-sigma) and a unit phase. The floor must be certified uniquely. Floating heuristics may select truncation order K but must never justify acceptance.

The [bound routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_bound.c), citing Arias de Reyna Theorem4.2, bounds the correction remainder by

    c1 * ((11/10)*sqrt(2*pi/t))^(K+1) * floor(K/2)!,

for t>0, K>=1, and, when sigma<0, sigma+K-2>=0. Its conservative c1 is obtained from the upper real endpoint: max(1/2,2^ceil(3*ceil(sigma_upper)/2)/7) when positive, and1/2 otherwise. This is the correction error before multiplication by a^(-sigma); the two auxiliary errors must then be combined with |X(s)|. This source-backed bound is an implementation contract awaiting a formal analytic bridge, not a new theorem proved by this experiment.

The correction uses derivatives of an analytic quotient involving cos(pi*p). The [coefficient source](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_f_coeffs.c) must be checked at apparent removable singularities p=+/-1/2. A production evaluator must either implement a certified removable expansion or split/fallback; merely raising precision is not a proof of total success. Gamma, reciprocal gamma, trigonometric denominators, real logarithms of positive integers and powers of positive real bases also need interval contracts. The phase must be enclosed without losing its argument modulo2pi.

The [RS jet implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_jet_rs.c) supports at most value and first derivative. It uses symmetric differences with a Cauchy bound. It is not a ready replacement for the head evaluator's degree23 Taylor series. A direct high-order differentiation of expressions containing floor(sqrt(Im(s)/(2pi))) would also be invalid without further work: those pieces are not holomorphic functions of s separately.

Published analytic reference: J. Arias de Reyna, High precision computation of Riemann's zeta function by the Riemann–Siegel formula, I, Mathematics of Computation80(2011),995–1009, [DOI](https://doi.org/10.1090/S0025-5718-2010-02426-3). The AMS PDF returned403 in this session; the exact implemented bound above was read in pinned primary source code. A production proof must obtain and verify the published theorem's full hypotheses and coefficient normalization. The later author preprint partII explicitly reports unresolved proof details, so it is not silently substituted for that verification.

## A proved mathematical wrapper around certified point values

Here is an elementary reduction, independent of how the point values are obtained. Suppose f is holomorphic on a neighborhood of |z-c|<=R and |f|<=M there. Choose 0<r<rho<R, integer m, roots omega_j=exp(2*pi*i*j/m), and

    b_k=(1/m)*sum_j f(c+rho*omega_j)*omega_j^(-k), 0<=k<m,
    P(z)=sum_(k<m) b_k*((z-c)/rho)^k.

Expanding f(c+z)=sum a_n*z^n and using root orthogonality gives b_k=sum_(l>=0) a_(k+lm)*rho^(k+lm). Cauchy's coefficient bound |a_n|<=M/R^n therefore proves, on |z-c|<=r,

    |f(z)-P(z)| <= M/(1-r/R) *
        ((r/R)^m + (rho/R)^m/(1-(rho/R)^m)).

The first term bounds the omitted true Taylor tail; the second bounds aliases in the retained coefficients. This derivation uses absolute convergence inside R and no zero-spacing premise. With interval sample values and interval roots, the computed b_k enclose their exact definitions; all rounding and sample uncertainty are retained through Horner evaluation. The remaining displayed error can be added as a square enclosure of its disk.

The benchmark takes f=zeta, m64,R1/2,rho1/4,r1/8. Its growth bound is

    M=33*(T+3)/(T-1)*((T+3)/6)^(3/5), T=10^6.

To check it, the outer disks for both centers have sigma>=.0025 and sigma<=1.055, so eta=.1 applies in Rademacher's strip bound. Use |1+s|<=T+3, |1-s|>=T-1, 2pi>6, zeta(1.1)<=11, and exponent(1.1-sigma)/2<.6. The base exceeds1. This gives M<44836 and the stated error. The [pinned growth-bound source](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_bound.c) states and implements this Rademacher inequality. A proof-producing implementation must formally establish that inequality or replace it by a separately proved contour bound; the benchmark does not make its source comment a theorem.

For a zetaF contour, multiply the analytic model by s-1, or use the identity zetaF=(s-1)zeta only away from1 and a separate pole-cancelled low model. Do not apply a zeta model across its pole. All high disks above are far from1. Shared rational endpoints, complete edge partitions, compatible half-plane witnesses and exact polygon winding remain exactly the obligations of the reviewed toy checker. A local nonzero panel does not imply a zero-free rectangle.

## Operation and evidence sizes, not runtime forecasts

At t=10^6, N=398, so a generic off-line RS value uses two398-term sums plus its correction and special functions. The existing head EM choice N=ceil(T/3) would have333334 terms. This compares summand counts, not time or proof complexity.

A fixed quarter-unit cover of the positive vertical edge from height1500 to10^6 has3,994,000 blocks. At64 samples/block that is255,616,000 point evaluations. Bounding every point by two399-term sums (allowing sampling disks) gives fewer than2.04e11 Dirichlet summands, plus corrections. A naive64-by64 DFT has4096 complex products/block; a radix2 transform has192 butterflies, with interval roots and all rounding checked. Neither algorithm controls how many half-plane subdivisions are needed near small values. Increasing m or precision may be necessary, and a real off-line zero would correctly stop the certificate.

With an explicit fixed-width storage choice of four128-bit dyadic fields per complex coefficient (two midpoints, two radii),64 coefficients take4096 bytes/block, about16.36GB over this edge, before metadata, exponents, panel witnesses or any sample proofs. This is a proposed encoding size, not the JSON size or a proof-size bound. If the checker recomputes coefficients from RS, they need not all be stored; arithmetic trace size and verification work remain. Conjugation can reuse the negative-height zeta edge, but must reverse orientation correctly. There is no universal bound on adaptive certificate size from analyticity alone.

The fixed-block RS scheme is a concrete O(T^(3/2)) summand-count route, whereas fixed-block N proportional to T EM has O(T^2) summands. Batched exponential sums could improve this further, but this note has not measured or implemented them. The practical next test is a modest complete height interval with independently checked RS point enclosures and the Cauchy wrapper, not a million-height run or a timing extrapolation from two successful blocks.

## Family evaluator: what is reusable and what is missing

For each conductor c>1 and all characters, the exact identity

    L(s,chi)=c^(-s)*sum_(a mod c, gcd(a,c)=1) chi(a)*HurwitzZeta(s,a/c)

permits a character-group DFT. Primitive and parity filters must be exact, and nonreal conjugate pairs retain both signs. For c1 use the entire zetaF factor with its removable value1, not an uncorrected principal L-product. [Arb's author documentation](https://arblib.org/acb_dirichlet.html) exposes all-character Hurwitz/DFT evaluation; its rational-real approximate-functional-equation API must not be described as a general complex-s routine.

For fixed c and s, a group DFT replaces phi(c)^2 scalar character summations by O(phi(c) log phi(c)) arithmetic, after all required Hurwitz values are enclosed. It does not remove those input evaluations or provide nonvanishing for every primitive character by itself. Large c have smaller Hcert; small c need a height-batched evaluator. These are distinct dimensions of batching.

[Platt's primary paper](https://arxiv.org/pdf/1305.3087) gives rigorous interval methods exploiting Fourier transforms, Hurwitz evaluation and completeness via zero counts. Its critical-line normalization is real-valued and includes an exponential gamma compensation. Reusing that algorithm on sigma=.555 requires new uniform off-line analytic error bounds; merely moving its samples is not justified. Alternatively, replaying critical-line sign changes with a proved Turing/completeness count would establish the stronger finite RH assertion and hence .555. That is a different certificate contract, still requiring every character and the complete height domain.

The suggestive balanced AFE length sqrt(c*T/(2*pi)) is at most3989 at c*T<=10^8. This is not a verified family algorithm or operation estimate. In particular an unrotated theta/incomplete-gamma split can have exponentially large intermediate cancellation after division by Gamma((s+a)/2). Counting its terms without accounting for required precision would be misleading. A stable rotated/smoothed AFE or Platt's batched method needs a complete remainder, gamma normalization and branch proof before it can supply our point-value interface.

The remaining family workload therefore cannot honestly be reduced to '3989 terms times a few values'. It includes5,543,640,188 primitive characters and their complete contours, or a different completeness certificate. The conductor-product method avoids individual zero isolation but does not by itself make interval evaluation of a huge product efficient. An aggregate winding certificate still has to account for every factor and multiplicity, with no pole cancellation. This note provides no new finite-spectrum assertion and no claim that the family computation is now cheap.
