# Joint principal L2 route: independent review

Status: the conditional argument is mathematically consistent, but the proposed uniform quartet bound85 is not proved. The current evidence is exploratory compact-smoothing quadrature. No Lean compiler was launched and no source was changed.

Reviewed evidence: mellin/joint_principal_model.py, SHA256 D9D4877C223D91ADBBDFD76EDC2BD2EF0BB08E07EF0CE21DF87CD07E22448DA2; mellin/PointwiseSmoothingTail.md and TwistBounds.md; exact equations and refinements communicated by the Mellin worker. The worker's full joint report was not yet saved at the final source read. Original source pin remains23b2d68ca344203d4384e0aff7affa4ec034bef9.

## Main restriction

The proposed x^(-1/4) squared-error factor requires every zero used in the quartet argument to satisfy beta<=7/8. Reflection then supplies beta>=1/8. This is a global7/8 zero-free input, or it must be replaced by a rigorously separated high-zero estimate. The currently audited local beta<=249/250 result and the weaker global23/24 provider do not supply it. No conclusion in this note removes that requirement.

## Exact weight and multiplicity

At s=2, XiPartial's partial fraction identity has sign

    xi'/xi(2) + sum m/(rho-2) ->0.

Taking real parts gives the positive sum

    W2=sum m*(2-beta)/((2-beta)^2+gamma^2)=Re(xi'/xi(2)).

There is no extra factor2. The source normalization of xi without the conventional1/2 factor does not affect its logarithmic derivative.

For applications, one can first prove the stronger-useful finite-set statement: every finite collection of original rectangle zeros, with their original multiplicities, has this weighted mass at most Re(xi'/xi(2)). Embed it in a sufficiently large xi approximation, use positivity and exact multiplicity transfer, then let the approximation error tend to zero. This avoids needing an infinite zero enumeration initially.

XiPartial.xi_partial_approx explicitly provides membership and multiplicity>=1, but that inequality alone is insufficient to transfer arbitrary multiplicities. Existing unconditional WeilBridge.multRectD_eq_mult supplies equality of the zetaF rectangle and xi-square multiplicities once both height conditions are met. The pointwise analytic-order argument in WeilBridge is the appropriate basis for independence from the containing region. Exact order preservation under conjugation and reflection is also required when constructing quartets; mere preservation of the zero set is not enough.

For beta>1/2 and gamma>0, the four zeros beta+-i gamma and1-beta+-i gamma are distinct, with equal multiplicity m. Their total weight is m*w, where

    w=2(2-beta)/((2-beta)^2+gamma^2)
      +2(1+beta)/((1+beta)^2+gamma^2).

At beta=1/2 there are only two distinct zeros. Using the same duplicated-quartet formula is valid only with atom weight m/2 for both the function and w. Counting it with coefficient m would double the actual sum. The unconditional height floor excludes gamma=0, so no real-zero degeneracy remains.

## Exact quartet and phase

Let M_sigma,gamma(delta)=integral etaPlus(r)*r^(sigma-1+i gamma)*exp(2*pi*i*delta*r) dr on r>0. Divide a quartet's explicit-formula contribution by x^(7/8). Its inverse-Fourier integrand is exactly

    2*x^(beta-7/8)*etaPlus(r)
      *(r^(beta-1)+x^(1-2beta)*r^(-beta))
      *cos(gamma*log r+gamma*log x).

Thus the worker's equation has the correct powers, reflection term and Fourier normalization. The L2 norm is on ordinary Lebesgue delta in[-4,4], with no1/8 average or2*pi measure factor.

For a leading conjugate pair at fixed beta, let M(delta)=M_beta,gamma(delta), D=integral|M|^2 and C=integral M(delta)M(-delta). Its phase-maximized squared norm is2D+2|C|. The prototype's reflected index and complex product implement this expression correctly. A calculation at the phase gamma*log(x0) would not be uniform in x; maximizing the phase avoids that mistake.

## Actual smoothing and beta variation

The source-derived pointwise bound|etaPlus-etaO|<=.00221*r*exp(-r^2/2) gives, by full-line Fourier Plancherel, a one-term L2 perturbation at most.00221/sqrt2 for beta in[1/2,7/8]. Indeed integral r^(2beta)exp(-r^2) dr<=1/2, interpolating between powers r and r^2. Therefore the pair perturbation is<=sqrt2*.00221<.00313. This is a valid improvement over the older.00418 figure, but the pointwise Fourier-inversion bridge itself remains unformalized.

For compact etaO, the displayed beta derivative bound D_beta<.313 is valid. On(0,1), bound the squared integrand by r^5(2-r)^6(log r)^2; on(1,2), bound it by r^6(2-r)^6(r-1)^2. The exact total is

    19896184597/266250045600 +1024/45045
      =.09746026381987884... <.313^2.

The leading pair is therefore .626-Lipschitz in beta in L2. With d=7/8-beta and logx>=61, its scaled norm is at most exp(-61d)*(A+.626d), where A=N0(gamma)+.00313. Maximizing over all d>=0 gives exactly

    F(A)=A if A>=.626/61;
    F(A)=(.626/61)*exp(-1+61A/.626) otherwise.

The reflected pair has a separate uniform bound8*x^(-3/8)<1e-9 at x>=x0. Also w>=6/(gamma^2+(15/8)^2). Thus the finite-height scalar sufficient condition stated by the worker is valid:

    (gamma^2+(15/8)^2)/6 * (F(N0(gamma)+.00313)+1e-9)<=85.

All these reductions preserve uniformity in x and beta. They do not prove the remaining bound on N0 over a continuous gamma interval.

## Numerical evidence and missing certification

The original saved experiment sampled etaO at beta=7/8. The revised worker reports a fine1024-by256 Simpson scan with largest sampled scalar ratio about83.170747 at gamma26.5. The worker also reports that the coarser512 grid aliases badly near gamma250, producing a false ratio about158. This observed instability is a concrete reason not to treat the quadrature as a certificate.

No interval quadrature error, continuous-height interpolation bound or verified global maximum has been supplied. A quarter-spaced height grid is not enough using the crude available derivative bound: N0 is at best .626-Lipschitz from the beta/log-r estimate, and near gamma26.5 the resulting half-mesh error can cost roughly9 in the scalar ratio, larger than the roughly1.83 sampled margin below85. A finer/adaptive mesh, sharper derivative enclosure or direct analytic bound is required. The necessary quadrature certificate must address the logarithmic oscillation at r=0 as well as the delta integral and the absolute Gram cross term.

## Large-height split

The existing exported norm_mellin_fP_tail cannot be used with threshold250 uniformly for|delta|<=4: it requires T0>=200+max(10*pi*|delta|,50), whose worst case is200+40*pi>325. This potential invalid extrapolation was reported to the worker, who explicitly replaced it with a proposed new signed-contour argument.

The revised proposed bounds use theta=.17 and the source-derived near/tail decomposition:

    |M|<=4sqrt184/gamma^2 +800000 exp(-.085gamma), 250<=gamma<400,
    |M|<=800000 exp(-.17(gamma-200)), gamma>=400.

They correspond to B=gamma/2 below400 and B=200 at/above400, when the Fourier tail is exactly empty. The choices meet the stated geometric conditions and appear sufficient numerically for a weighted quartet ratio below80. The constant800000 requires rigorous trigonometric/exponential enclosures of the signed-contour prefactor; the near/tail analytic theorem itself also remains to formalize.

For arbitrarily large gamma, the reflected pair must be bounded with the same decaying contour estimate and x powers, using

    x^(beta-7/8)+x^(1/8-beta)<=1+x0^(-3/8).

One must not keep the fixed1e-9 reflected error and divide it by w~6/gamma^2 all the way to infinity. The fixed-error method is only suitable on the bounded-height interval.

## W2 numerical certificate

The logarithmic derivative at2 equals

    3/2 -(1/2)log pi -(1/2)EulerGamma -sum Lambda(n)/n^2.

The worker's bounded mass-only script ran successfully under this review. Its exact rational log bounds, harmonic-log lower bound H1000-log1001 for EulerGamma, and lower sum over primes<=2000 of log(p)/(p^2-1) giveW2<=.06981243158646303<.07. The prime-power geometric series denominator is correct. The script's log interval remainder has the correct sign after binary range reduction. Primality/finite arithmetic certificates and the analytic Euler-product/derivative identities still need Lean proofs; a floating printout is not substituted for those.

## Conditional L2 consequence and remaining errors

If every quartet satisfies the actual-smoothing bound||Q||2<=85w and the finite weighted mass is<=.07, weighted triangle inequality gives the normalized zero-sum squared norm at most

    x^(-1/4)*(85*.07)^2.

At x0=4.9e26 this is about7.524625872e-6. A simple rational check suffices:4700000^4<x0, so it is<7.54e-6. Thus there is some room below8e-6 for the contour remainder.

For|delta|<=4, thetaD>=.056 and hence thP=1/200. The source uniform Mellin bound gives Kv<110000 using Cg<=2.03, e<2.72 and2aH=200/pi<64. Then VgL(3,Kv,1/200)<2e11 from its explicit definition. The normalized contour error is bounded pointwise by x^(-3/2)VgL/(2*pi), and its delta-L2 norm is<1e-28 already using x>=1e26. A1% square split yields total squared error<1.01*7.54e-6+101e-56<8e-6. These are straightforward remaining numeric checks, not a problematic error budget.

The principal main term M(1,delta) is Fourier(etaPlus)(-delta); the raw sum is the actual von Mangoldt smoothing. No omitted prime-power correction is needed at q=1. Coprime removal at other q can use the already available1e-15 normalized pointwise bound.

Use the source's common good-height sequence and either an L2 convergence argument or Fatou after pointwise explicit-formula convergence. The estimates must apply to the same rectangle multiplicities and measurable delta functions. An arbitrary delta-dependent sequence should not be silently substituted.

A proved local principal L2 squared error<8e-6 can replace the earlier pointwise.001 hypothesis in the lower-J argument, because that argument consumed its integrated error8*.001^2. It would not by itself prove the full-range principal Ep target, upper J, nonprincipal estimates or the cubic Cross term.

## Minimal rigorous next target

First formalize the finite weighted-mass bound<=.07 with exact multiplicity transfer; its numerical certificate is already small and positive-margin. In parallel with no false closure claim, construct a rigorous certificate for the actual etaPlus quartet bound on the bounded height interval, with phase and beta uniformity as above, then prove the separate large-height contour estimate. These are the substantive missing steps. The bound85 must remain an unproved target until those checks exist.

## Addendum: explicit high-height certificate

Reviewed and executed work/qrh-campaign/principal_high_height.py, SHA2568686EE00B94E500A61AC3B6107747D7C7E30E073687280EAB596650FB66D5D20. All exact-rational assertions passed. This addendum supersedes the earlier unresolved arithmetic for the proposed large-height estimate; it does not turn the new contour/Fourier lemmas into compiled Lean results.

The script uses theta=.17, c0=.94 and b0=8*(22/7)*.17. The elementary inequalities cos(.34)>=1-.34^2/2>=c0, sin(.17)<=.17 and pi<22/7 bound both twist signs uniformly for|delta|<=4. The source Gr_eq requires only|theta|<pi/4 and Re(s)>-2, satisfied by s=sigma-1+i*tau with sigma in[1/8,7/8]. Its norm_Jr has radial power r^sigma, exactly the power used by the new bound. Thus there is no hidden height325 threshold from the different exported tail theorem.

Completing the square gives I0<=exp(b0^2/(2c0))*sqrt(2pi/c0). The script checks b0^2/(2c0)<10 and sqrt(2pi/c0)<2.59. Its Taylor upper bound for exp10 is valid: the omitted tail begins at j=80 and successive ratios are<=10/81. Hence I0<=22027*2.59. Integration by parts gives I1<=1/c0+(b0/c0)I0. The script verifies that this latter majorant also exceeds the I0 majorant. With the pending Fourier-L1 boundW<=3.01, their product is at most780834.6696...<800000. All inequalities enlarge in the correct direction.

For250<=gamma<400, B=gamma/2 satisfies0<B<200 and B<=gamma. The Fourier tail is bounded bysqrt184/B^2=4sqrt184/gamma^2. The signed contour term is bounded by800000 exp(-.085gamma). For gamma>=400, B=200 is allowed and the Fourier tail is identically zero; the remaining term is800000 exp(-.17(gamma-200)). Both real parts beta and1-beta stay within[1/8,7/8], so these bounds cover all four zeros.

The improved quartet amplitude factor is valid:

    x^(beta-7/8)+x^(1/8-beta)<=1+x^(-3/4),

for x>=1 and beta in[1/2,7/8]. The left side is convex in beta; at beta=7/8 it equals the right side, and its beta=1/2 endpoint value2x^(-3/8) is smaller by(1-x^(-3/8))^2. Therefore for x>=10000 the factor is<=1.001. This controls the reflected pair with the same decaying contour estimate and eliminates the invalid fixed-error-at-infinity concern.

The quartet L2 norm on[-4,4] is at most2sqrt8 times that amplitude factor times the pointwise Mellin majorant. Dividing by w>=6/(gamma^2+225/64) gives the script's prefactor(sqrt8/3)*1.001<.943*1.001. There is no missing factor2 or normalization by the interval length.

The factor(gamma^2+a)/gamma^2 decreases for gamma>0. For the exponential terms, differentiation gives sign2gamma-k(gamma^2+a). The script checks negativity at the relevant initial points250 and400. It then stays negative because k(gamma^2+a)-2gamma is increasing beyond1/k, well below both starting points. Thus evaluating those majorants at the starting point is valid throughout each interval.

The exact100-term Taylor lower bound proves exp(21.25)>1.69e9. At gamma250 the exponent is21.25. At gamma400 the second exponent is34>21.25, so using the same reciprocal bound is conservative. The certified rational bounds are

-250<=gamma<400: quartet ratio<79.1501068154<80;
-gamma>=400: quartet ratio<71.4954786034<80.

At gamma400 the second branch applies, withB=200 and no Fourier tail. The discontinuity of the chosen upper bounds at that point is harmless; no height gap is left.

Conclusion: the large-height numerical reduction now passes independent review. Its remaining requirements are the new signed-contour near/tail lemma, the Fourier-L1 bound and their ordinary analytic justification/formalization. It still uses the global7/8 strip and does not resolve the actual-smoothing Gram certificate for gamma<250. No Lean validation is claimed.

## Finite quadrature and compact outer-range addendum

Reviewed JointPrincipalL2.md SHA256 798E4239536A153E40C6F21CB639F4E675FAD64027BB6B1A13FCA2AF1567ABA0 and joint_principal_certificate.py SHA256 3F511989A4E0F9F4D9206CEAF5C61CCDA80A30303C87484D6292B0CB42E57A67. This review concerns the reduction and checker source. It does not report a completed 2750-cell run or Lean validation. No mathematical defect found in these reductions or the current checker.

The compact contour formula uses the correct exponent 23/8 before the logarithmic change of variable and 31/8 after it. Rotating the finite segment retains the radius-2 connecting arc. Along the angle-1/2 ray, cos(1)>0 makes the quadratic Gaussian term nonpositive, and the remaining exponent is at most 3/2+8*pi<27. The bounds |2-z|^3<=64 and integral r^(23/8)<=49/12 yield the stated 262 coefficient. On the connecting arc, |2-2exp(i*a)|^3<=8*a^3, the power contributes at most 8exp(-gamma*a), and arc length contributes 2. The Gaussian exponent is at most 1/2 for 0<=a<=1/2. For example cos(a)>=7/8 gives 2cos(a)-1/2-2cos(2a)<=3/16. Integrating a^3 exp(-(gamma-16*pi)*a) over the larger interval [0,infinity) gives the coefficient below 1268. Thus no endpoint term is dropped.

The weighted ray and arc terms decrease for gamma>=75. Bounding the residual F(.00313) term at the upper endpoint of each outer interval is conservative. The inequality F(N+e)<=N+F(e) follows because F(A)=sup_{d>=0}exp(-61d)*(A+.626d), and exp(-61d)<=1. The exact rational outer checks replayed successfully: Cstar<77.990069 on [0,16], <65.394045 on [75,100], and <56.482200 on [100,250]. These values use the displayed contour estimates, not sampled oscillatory integrals.

For the u truncation, the omitted Mellin integral is at most (64/31)exp(-15.5). The conjugate-pair norm on [-4,4] is at most 2sqrt(8) times this quantity, below 2.2e-6. The estimate includes both conjugate terms and the full delta interval.

The transformed H(u) is entire. The radius-.2 disks around all 47 panel centers satisfy Re(u)<=log(2)+.2 and |Im(u)|<=.2. With rmax=2exp(.2), a sufficient bound is

`rmax^(31/8) * exp(15) * (2+rmax)^3 * exp(rmax+rmax^2/2-1/2+8*pi*rmax/5) < 10^18`.

This is also explicitly asserted by the checker in ball arithmetic. The bound uses |sin(Im(u))|<=1/5 for the twist term. Panel width is less than .1, hence h/R<=1/4. Cauchy coefficient bounds and positivity/exactness of 26-point Gauss quadrature give the total absolute transform error <=6.573840876842e-13. The factor 2 accounts separately for the true integral and the quadrature of the Taylor remainder.

For delta, Mtr(z)*conj(Mtr(conj(z))) is an entire extension of |Mtr(delta)|^2. Mtr(z)*Mtr(-z) is the correct entire cross-term extension. The real amplitude integral is at most 3, so both are bounded by 9exp(64*pi)<10^90 on |z|<=8. The 180-point rule has exactness through degree 359; the same Taylor argument bounds each integral error by 1.362547148803e-17. There is no use of a nonanalytic complex absolute value in this contour/Taylor step.

CELL uses the center g, half-width h, upper weight endpoint b, and adds .626*h before applying the increasing function F. The .626 Lipschitz constant follows by the triangle inequality for phase-maximized pair norms and the previously reviewed .313 Mellin derivative bound. This covers every height inside a cell, not only its center. The intervals [16,40] with step .01 and [40,75] with step .1 give exactly 2750 cells, with neither gaps nor missing endpoints.

The checker evaluates nodes, weights, log(2), exponentials, and matrix operations as Arb/Acb balls. It adds an error box with each coordinate radius eu, which encloses a complex absolute error <=eu conservatively. It then integrates the enclosed products and adds ed. The acceptance inequality uses the resulting upper bound directly; it does not assume a fixed 1e-12 roundoff radius. Thus wider arithmetic enclosures cause failure or a weaker bound, not a false pass.

The cross term uses vals[179-j] for Mtr(-delta_j). The installed `arb.legendre_p_root` documentation explicitly says roots are indexed in decreasing order. Legendre parity and distinct real roots imply z_(179-j)=-z_j, justifying this indexing exactly. Both occurrences of the same transform being enclosed independently only widens the product enclosure. F_upper takes an upper endpoint, handles both branches, and uses the union in any threshold overlap. A strict comparison with 85 is conservative for the required non-strict inequality.

Remaining evidence required: successful output for every cell, bound to this source hash and all run parameters; the global QRH provider; analytic quadrature and contour lemmas in Lean; the smoothing bridge; weighted-mass and orbit/multiplicity transport; and the explicit-formula Hilbert limit. A completed Arb run certifies the finite inequalities relative to these paper reductions and the ball-arithmetic implementation. It is not Lean kernel evidence for the principal L2 theorem or the Goldbach roots.
