# Mellin estimates on the QRH strip

Source commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. This note gives mathematical derivations. No new Lean theorem has been compiled. The existing source bounds quoted below are present in the pinned source. Numerical quadrature is exploratory.

Write a=1/8, b=7/8, w=b-a=3/4 and M_f(s)=integral_0^infinity f(v)v^(s-1) dv. A modulation f(v)=eta(v) exp(2 pi i delta v) has the same absolute value as eta. Every bound below is uniform in real delta unless its rate explicitly depends on delta.

## Existing source estimates

Explicit/EtaPlusMellin.lean defines fP and proves norm_fP_le, namely |fP(delta,v)| <= 3.15 v exp(-v^2/2) for v>=0. Its norm_mellin_fP_uniform, at line 236, covers -1/2<=Re(s)<=2 and gives

    |M_fP(s)| <= Cg (2 aH) 300 e exp(-min(thetaD(delta),1/200)|Im(s)|).

Explicit/EtaPlusCg.lean proves cA_le, namely Cg (2 aH)<=129.24. Explicit/ZeroSumBound.lean, lines 19 and 40, defines thetaD(delta)=0.28/(1+|delta|) and proves |G_delta(s)|<=112 exp(-thetaD(delta)|Im(s)|) on -1<=Re(s)<=1. Thus the etaPlus constant is at most 129.24*300*e, approximately 105393.2231. The rate is min(0.28/(1+|delta|),0.005). A conductor-independent exponential estimate is already available throughout the desired strip.

## New small pointwise etaPlus bound

For a<=sigma<=b, the Mellin triangle inequality and norm_fP_le give

    |M_fP(sigma+i t)| <= 3.15 integral_0^infinity v^sigma exp(-v^2/2) dv
                      <= 3.15 [8/9 + exp(-1/2)] < 4.72.

On (0,1), v^sigma<=v^(1/8), and exp(-v^2/2)<=1. On [1,infinity), v^sigma<=v, whose Gaussian integral is exp(-1/2). This proof uses no cancellation or numerical quadrature. To certify the last decimal, exp(1/2)>=1+1/2+1/8+1/48+1/384=633/384 implies exp(-1/2)<=384/633, and 3.15*(8/9+384/633)<4.72 by rational arithmetic.

The stronger exact integral envelope is 3.15*2^((sigma-1)/2)*Gamma((sigma+1)/2). It is log-convex in sigma, so its maximum on the strip occurs at an endpoint. The simple 4.72 bound is easier to formalize.

Together with the existing estimate, use the pointwise envelope min(4.72,129.24*300*e*exp(-c|t|)). A window sum of this envelope has order c^(-1), so it loses the useful square-root dependence on the modulation range.

## Rectangle Sobolev estimate

Let F(sigma,t)=M_f(sigma+i t), and suppose for j=0,1,2 that

    integral_R |partial_s^j M_f(sigma+i t)|^2 dt <= A_j

uniformly for a<=sigma<=b. Define H(t)=max_[a,b]|F(sigma,t)| and B(t)=max_[a,b]|partial_t F(sigma,t)|. Smoothness of the Mellin transform and compactness of [a,b] ensure both maxima exist. The fundamental theorem of calculus and Cauchy-Schwarz imply

    ||H||_2^2 <= A_0 + 2w sqrt(A_0 A_1),
    ||B||_2^2 <= A_1 + 2w sqrt(A_1 A_2).

For the first inequality, for each t and any sigma,r in [a,b],

    |F(sigma,t)|^2 <= |F(r,t)|^2
                      + 2 integral_a^b |F(u,t)| |partial_sigma F(u,t)| du.

Average over r, take the maximum over sigma, integrate over t, and apply Cauchy-Schwarz to the double integral. Holomorphicity identifies the norms of sigma and t derivatives. Apply the same argument to partial_t F for the second inequality. These steps require mixed second derivatives, which exist because all relevant log-weighted smoothing moments are integrable.

For any real interval I of length h,

    sup_I H <= h^(-1) integral_I H + integral_I B.

Indeed |H(t)-H(r)|<=integral_between(r,t) B, by taking the supremum in sigma after the ordinary fundamental theorem. Average over r. Therefore for disjoint height windows of common length h and union of measure L,

    sum_windows sup_I H <= sqrt(L) [sqrt(A_0+2w sqrt(A_0 A_1))/h
                                   +sqrt(A_1+2w sqrt(A_1 A_2))].

If each window contains total zero multiplicity at most Z, and all relevant beta belong to [a,b], then for x>=1 their contribution satisfies

    sum_rho m_rho |M_f(rho) x^rho| <= x^(7/8) Z sqrt(L) C,

where C is the bracket above. Half-open windows assign endpoints once. The zero_sum worker owns the counting estimate and the precise covering length. h=3.48 matches that worker's strip windows. This proof avoids asserting that maxima over different sigma lie on a common vertical line.

## Explicit etaPlus moments

Mellin-Plancherel gives

    integral_R |partial_s^j M_fP(sigma+i t)|^2 dt
      =2 pi integral_0^infinity v^(2sigma-1) |log v|^(2j) etaPlus(v)^2 dv
      <=2 pi (3.15)^2 integral_0^infinity v^(2sigma+1) exp(-v^2)|log v|^(2j) dv.

Explicit/MellinPlancherelGen.lean currently specializes sigma to 1/2. Its Fourier proof applies after replacing PhiG(u) with exp(-sigma*u)*f(exp(-u)). Thus the exact remaining analytic formalization is weighted Mellin-Plancherel, including its first two derivatives, followed by the rectangle argument above.

Entirely elementary bounds valid for j=0,1,2 are

    A_j = 2 pi (3.15)^2 [(2j)!/(9/4)^(2j+1) + (j+1)!/2].

On (0,1), use v^(2sigma+1)<=v^(5/4) and drop the Gaussian. The integral is (2j)!/(9/4)^(2j+1). On [1,infinity), use v^(2sigma+1)<=v^3 and log v<=v. Extend the resulting v^(3+2j) exp(-v^2) integral to (0,infinity), obtaining (j+1)!/2. These yield A_0 approximately 58.88131, A_1 approximately 73.29162 and A_2 approximately 212.98247. For h=3.48, use the exact displayed expressions, or the conservatively rounded C=19.76. Rational pi<=22/7 suffices to certify C<19.76 by squaring positive quantities.

For sharper constants, the integrals are convex in sigma, so the maximum is bounded by the maximum of the two endpoint integrals. Exploratory Simpson quadrature of the Gaussian majorant gives A_0=29.721245, A_1=11.295327, A_2=25.555900 and C=8.238075. These decimals are not certified. A_0 comes from sigma=7/8, A_1 and A_2 from sigma=1/8. The attached script reproduces this computation without claiming interval certification.

## etaStar and the scaled etaU convention

Helfgott/Defs.lean defines etaStar(t)=(eta2 *_M phi)(49t), phi(t)=t^2 exp(-t^2/2). eta2 is nonnegative, supported on [1/4,1], and is the Mellin convolution of 2*1_[1/2,1] with itself. MajorArcs/ArcCharsStar.lean works instead with etaU=eta2 *_M phi at y=x/49. This scaling matters for the modulation parameter and the x^rho factor.

For fU_delta(v)=etaU(v) exp(2 pi i delta v), Fubini and v=r*u give

    M_fU_delta(s)=integral_(1/4)^1 eta2(r) r^s G_(delta*r)(s) dr/r.

For fStar_delta(v)=etaStar(v) exp(2 pi i delta v),

    M_fStar_delta(s)=49^(-s) M_fU_(delta/49)(s).

Define m2(sigma)=integral eta2(r) r^sigma dr/r=[2(1-2^(-sigma))/sigma]^2. The removable value at sigma=0 is 4(log2)^2. For sigma>=0, m2(sigma)<=4(log2)^2<1.922. Since |delta*r|<=|delta|, the existing Gaussian estimate gives the new convolution consequence

    |M_fU_delta(sigma+i t)| <= 112 m2(sigma) exp(-0.28|t|/(1+|delta|))
                           <=216 exp(-0.28|t|/(1+|delta|)).

For etaStar, multiply by 49^(-sigma) and replace delta with delta/49. In particular use 216*49^(-1/8) and rate 0.28/(1+|delta|/49) on the QRH strip. The convolution identity and its bounds require new Lean proofs. They have not been located as existing Mellin declarations.

A small uniform pointwise bound also follows. The Gaussian absolute Mellin integral on 0<=sigma<=1 is bounded by the larger of its endpoint values 1 and sqrt(pi/2), by log-convexity. Therefore

    |M_fU_delta(sigma+i t)| <=4(log2)^2 sqrt(pi/2)<2.41,
    |M_fStar_delta(sigma+i t)| <=2.41*49^(-1/8).

The same rectangle estimate applies to etaU. Here are conservative computable moments avoiding the source's large pointwise etaU bound. Put Lr=log4 and

    Q_k=2 pi [(2k)!/(17/4)^(2k+1)+(k+2)!/2],
    D_j=4(log2)^2 sum_(k=0)^j binomial(j,k) Lr^(j-k) sqrt(Q_k),
    A_j=D_j^2, j=0,1,2.

Q_k bounds the Gaussian vertical derivative moment uniformly on the strip. Its proof repeats the etaPlus splitting with the power v^(2sigma+3), using v^(13/4) below 1 and v^5 above 1. Differentiate the convolution identity in s. The derivative of r^s contributes log r, bounded in absolute value by log4. Minkowski's integral inequality and r^sigma<=1 give D_j. These quantities are uniform in delta even though the Gaussian modulation delta*r varies in the r integral. Working at y=x/49 avoids adding log49 terms to the derivative moments.

## Remaining mathematical and Lean work

1. Formalize the direct etaPlus 4.72 bound through the normal Mellin definition and convergence theorem.
2. Generalize Mellin-Plancherel from sigma=1/2 to variable sigma and the first two Mellin derivatives.
3. Prove the compact-strip maximum and window inequalities, with all continuity and integrability obligations.
4. Prove the etaU modulated Mellin convolution formula and the etaStar scaling identity.
5. Combine with actual strip zero counts and the revised x^(7/8) zero factor. Preserve the existing tail estimates separately when advantageous.
6. Recompute the final major-arc and minor-arc numerical budgets. The bounds derived here do not establish the existing 1e27 threshold.

With the exploratory C=8.239 and a crude low-height cover L approximately 2*1e8/q, the conductor-weighted normalized etaPlus low-zero error is about 54*Z at x=4.9e26. This is much larger than the current 4.25e-7 consumer bound. Exploiting exponential decay can shorten the effective height range, but the factor x^(-1/8) creates a substantive threshold problem. This quantifies the limitation of the present upper bound.

## Stronger bound drafted in Lean

A simpler argument improves the constant to 3.95. For 0<=sigma<=1, weighted AM-GM gives v^sigma<=1-sigma+sigma*v. Consequently the Gaussian integral is at most

    (1-sigma)*sqrt(pi/2)+sigma <=1.2535.

The inequality sqrt(pi/2)<=1.2535 follows by squaring and pi<3.141593. Multiplying by 3.15 gives 3.948525 < 3.95. The requested strip [1/8,7/8] lies inside [0,1]. GaussianEnvelope.lean contains the general analytic proof from the explicit Gaussian pointwise envelope. EtaPlusStrip.lean applies the existing norm_fP_le and concludes the originally requested bound 4.72. At the time of this note these files are awaiting coordinated compilation, so their Lean validation is pending.

## Verified Lean helper

GaussianEnvelopeAudit.lean compiled with Lean 4.35.0, exit 0. It proves norm_mellin_lt_of_gaussian_envelope with conclusion norm(mellin f s)<3.95 for 0<=Re(s)<=1 and the explicit pointwise hypothesis norm(f(v))<=3.15*v*exp(-v^2/2) for v>0. The printed axiom dependencies are exactly propext, Classical.choice, Quot.sound. GaussianEnvelope.log contains the type and audit output, and GaussianEnvelope.exit records 0. GaussianEnvelope.lean contains the same proof body with diagnostic commands removed. Its specialization to the actual fP definition remains queued behind the existing project imports; no claim of completed etaPlus validation is made yet.

