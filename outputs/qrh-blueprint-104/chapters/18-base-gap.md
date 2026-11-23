# Base-gap QRH research: exact domain, extra main-term room, and the family obstruction

Status: research only. No Lean compiler ran and no Lean files changed. Source: `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The accompanying `base_gap_qrh_model.py` writes `base_gap_qrh_results.json`; its `Fraction` checks are exact arithmetic checks, while its displayed floating-point values are diagnostics, not Lean certificates.

## Exact target and downstream latitude

The declaration is `TernaryGoldbach.MinorArcs.norm_S_etaStar_le_gap`, in `MinorArcs/BaseGap2.lean:243`. Its hypotheses are x>=4.9e26, alpha in majorArcs 8 r0 (x/49), and alpha outside majorArcs 8 r0 x. It concludes

    |S_etaStar(alpha,x)| <= .0121*y,   y=x/49>=1e25.

It currently has a `Fact PlattGRH` binder. The explicit analytic use is the character estimate `PartIICited.cor_7_1_3`; the original proof also invokes `Prelim.div_totient_lt`, whose inherited proof route contains another Platt dependency. That second dependency is avoidable by the finite-prime argument below.

The exact consumer has latitude: `MinorTotal.lean:395-403` only needs the gap bound `|S_etaStar|<=y*ghatY(y,150000)`. Its unconditional `gx_r0_ge` at line166 gives gx>=.01. Since `LinftyLevels.lean:351` defines

    ghatY(y,n)=1.398*max(gx(y,n),hfun(y)) + 17*(670/n)^3/3,

it follows that ghatY(y,150000)>=.01398. Thus proving the weaker uniform bound .01398*y suffices for this consumer without increasing the existing minor-arc envelope or changing its numerics. A theorem with precisely the old .0121 conclusion would still need the stronger budget. The additional positive tail in ghatY is not needed here.

## The actual twist region

Let delta=(alpha-a/q)*y. Preserve the parity split from the definition of majorArcs rather than only the weaker statement of `gap_point` at BaseGap2:177. The chosen reduced rational has:

| q | allowed q | lower absolute delta | upper absolute delta |
|---|---|---|---|
| odd | 1<=q<=150000 | 600000/(49q) | 600000/q, strict |
| even | 2<=q<=300000 | 1200000/(49q) | 1200000/q, strict |

The lower endpoint is allowed because the narrower arcs are open; the upper endpoint is excluded. In particular, every chosen rational satisfies q*|delta|>=600000/49, and the smallest possible twist is 4/49, approached or attained at the largest parity-appropriate denominators. `gap_point` forgets parity and gives only 600000/(49q)<=|delta|<1200000/q, which unnecessarily permits twists down to 2/49 for even q.

These statements follow for the rational selected by the wider-arc membership. The global exclusion of all narrower arcs imposes more than exclusion of that one rational. For the diagnostic examples near its lower endpoint, distinct reduced rational arcs are disjoint at y>=1e25: use the determinant separation >=1/(q*q') and the radius bound, which is already more than sufficient once y>7.2e11. A nearby rational does not invalidate those example cells.

Examples (absolute twists, rounded diagnostics): q=1 or2 has lower12244.898 and upper600000; q=101 has lower121.2366 and upper5940.594; q=1009 has lower12.13568 and upper594.6482; q=10007 has lower1.223633 and upper59.95803. At p=149993 and q=2p=299986 both ranges are [.08163646,4.00018668). The script verifies that p is prime by trial division.

The transform in this task is F(s,delta)=Mellin(etaU(u)*exp(2*pi*i*delta*u))(s). Its twist is delta, not delta/49: the 49 has already entered y and the definition of delta. Confusing this with the mixed-moment chapter's x-normalized twist would lose the main geometric benefit of the gap.

## A rigorous paper improvement: the main term is below .000481*y

The source already supplies two independent Fourier estimates, with no Platt hypothesis in their declarations:

    |Fourier(etaU)(-delta)| <= 1.2534,
    delta^2*|Fourier(etaU)(-delta)| <= 1.016.

The first is `MajorTotal.norm_fourier_etaUC_le` at line475; the second combines `MinorArcs/EtaU.norm_fourier_etaU_le` with `BaseGap2.fourier_const_le`. Consequently

    |delta|*|Fourier(etaU)(-delta)|
       <= sqrt(1.2534*1.016) < 1.129.

This is just multiplication of the two inequalities followed by square roots. It avoids taking the decay estimate at the smallest delta while independently taking the largest totient ratio.

For q<=300000 one has the unconditional finite bound

    q/phi(q) <= 30030/5760 = 5.213541666... .

Indeed, seven distinct prime factors would have product at least 2*3*5*7*11*13*17=510510. For at most six factors, replacing them by the first six primes only increases the product of p/(p-1). Source `Prelim/MertensProduct.lean:2129` (`div_totient_eq_prod`) and :2156 (`exch`) provide the two exact comparison ingredients, outside the Fact blocks. `Nat.prod_primeFactors_dvd` bounds the prime-factor product by q. A finite first-seven-primes verification and the six-factor corollary are still to be formalized; this is a complete elementary proof route, not an appeal to the Platt-dependent global totient theorem.

The true principal main term includes |mu(q)|, but even dropping it gives

    |Fourier(etaU)(-delta)|/phi(q)
       <= (30030/5760)*1.129*49/600000 < .000481.

For even q the parity-aware lower bound halves this bound. The last rational comparison is checked exactly by the script. This replaces the original proof's .01125 main-term allowance. Direct finite enumeration with the stronger min(1.2534,1.016/delta_min^2), exact phi and |mu| suggests a maximum .0002176041667 at q=15015,30030. That diagnostic maximum is not required for the .000481 proof.

This leaves .011619 for normalized character errors and removals under the old target, or .013499 under the downstream .01398 target. It does not itself bound those errors.

## Exact reconstruction and the QRH obligation

`BaseGap.totient_mul_norm_le` at line21 gives the exact character reconstruction before inequalities; `norm_expTsum_le_of_chars` at line93 then replaces the Gauss weights and every character error by maxima. The latter yields

    |S|/y <= d + main + sqrt(q)*(E/y+d),

where d is the normalized removed-prime-power sum. The source proves d<=2e-9 uniformly using its elementary ceil/log estimate. Keeping this estimate costs at most (1+548)*2e-9=1.098e-6. Sharper elementary removal estimates are available, but this cost is already small relative to .011619.

For a better QRH argument preserve the individual weights. For a primitive character chi let

    Zchi(delta)=sum_(nontrivial rho of chi) m_rho |F(rho,delta)|,
    rho real part <=theta=7/8.

QRH plus an explicit formula gives a normalized error bounded by y^(-1/8)*Zchi(delta)+rchi(y,delta), once all contour/trivial-zero terms and convergence have actually been controlled. The principal pole is subtracted; the principal character's nontrivial zeros are zeta zeros. Then the concrete sufficient estimate is

    main + (1+Wq)*d
      + y^(-1/8)/phi(q) * sum_psi |tau_q(psi)| Z_cond(psi)(delta)
      + 1/phi(q) * sum_psi |tau_q(psi)| r_cond(psi)(y,delta)
        <= .0121   [or .01398],

    Wq=sum_psi |tau_q(psi)|/phi(q).

Here |tau_q(psi)|=sqrt(c) exactly on q/c squarefree and coprime to c, and zero otherwise; c=cond(psi). The inducing character is that of psi^-1, as in the source. All multiplicities and the q-dependent coprime correction remain present.

At y=1e25 the prefactor y^(-1/8) is about .0007498942093. Ignoring remainders and removals only to display scale, the weighted Z aggregate must be <=15.4942 for the old target or <=18.0013 for the relaxed target. Those are diagnostic ceilings, not certified safe allocations. Keeping d and positive contour remainders tightens them.

A uniform per-character Z<=C combined with sqrt(q)<=548 therefore needs C roughly .0283 for .0121 or .0328 for .01398. That is too small for a generic allowance of a right-edge low zero. The exact Gauss sum is better than sqrt(q), but it does not remove this issue at large prime conductors.

## Concrete obstruction to the uniform absolute recipe

This is an obstruction to a specified method, not a claim that actual L-functions have the hypothetical zeros below and not a counterexample to the base-gap theorem.

The preceding chapter derives, from the actual log-tent eta2 and Gaussian phi,

    A(s)=Mellin(eta2)(s)=4*((1-2^(-s))/s)^2,
    H(s)=Mellin(etaU)(s)=A(s)*2^(s/2)*Gamma(1+s/2).

For beta=7/8 and |delta|<=.082, the elementary cosine inequality gives

    Re F(beta,delta) >= H(beta)-2*pi^2*delta^2*H(beta+2).

Here is a deliberately coarse rigorous paper lower bound, avoiding numerical Gamma quadrature. Since eta2>=0, has support [1/4,1], and integral1, A(beta)>=1. Splitting the Gaussian integral at1 and2 gives

    H(beta) >= .6*(8/23)+.13*(3/2).

Use exp(-1/2)>.6 and exp(-2)>.13; on [0,1] integrate u^(15/8), and on [1,2] use u^(15/8)>=u. For the upper moment, A(beta+2)<=A(2)=9/16. Weighted AM-GM u^(7/8)<=1/8+7u/8, together with integral u^3 exp(-u^2/2)=2 and integral u^4 exp(-u^2/2)=3*sqrt(pi/2)<4, gives H(beta+2)<=135/64. With pi<22/7,

    Re F(7/8,delta)
       >= 55673979/450800000 > .12.

The final rational arithmetic is checked by `Fraction`; the analytic inequalities have not been formalized in this task.

Take p=149993, either q=p or q=2p, and delta=.082. Both are genuine admissible gap cells. There are p-2 primitive characters modulo p, each with absolute Gauss weight sqrt(p), and phi(p)=p-1. The total primitive weight divided by phi is about387.2867155. Thus a uniform recipe that must allow one such right-edge low zero in every primitive character cannot have a normalized error allowance below

    .12*y^(-1/8)*(p-2)*sqrt(p)/(p-1) = .0348508878...

at y=1e25. This exceeds both .0121 and .01398 even before adding main or remainder terms. Equivalently, the uniform per-character allowance needed for these exact weights is below .04001 for the old target and .04649 for the relaxed target, while this one-point transform is above .12.

The inventory is only adversarial data admitted by QRH location and the displayed coarse positive-mass information. Compatibility with any additional local-count theorem has not been checked. It can be reflected and conjugated to respect those symmetries; adding the reflected partners only increases an absolute zero sum. If one wishes to avoid an exact real zero for complex characters, continuity gives the same obstruction at sufficiently small nonzero conjugate heights, with a slightly weaker constant. No positive first-zero height for all primitive characters has been established here. Existing zero-free or zero-density information may rule out many such inventories, but that is precisely extra input that the uniform strip-only recipe lacks. No assertion about the realizability of this inventory by actual Dirichlet L-functions is made.

The relevant bad cells are therefore large conductor and small |delta|, with beta near7/8 and small |gamma|. The total-mass estimate at s=2 does not itself exclude a reflected pair: its mass is of order1.42 at gamma0, much smaller than the order-log(p) upper allowance. Additional family or cancellation information is necessary for this uniform absolute recipe to reach the fixed .0121 or .01398 caps. This inventory calculation alone does not exclude the actual variable ghatY target.

## Low q is a different regime: large twist suppresses low-height zeros

The principal q=1,2 cells have |delta|>=12244.898, not delta close to0. In that regime the Fourier main term is tiny and low-height Mellin terms can be bounded by integration by parts. This is why a local principal delta in [-4,4] estimate is not the relevant base-gap bottleneck.

Twice differentiating u^(s-1)*etaU(u), using the actual Mellin convolution with phi, gives the following paper estimate for beta=Re(s)>0 and delta!=0:

    |F(s,delta)| <= A(beta-2)*G(beta)/(2*pi*delta)^2
                    * (|s(s+1)|/beta+|2s+3|+beta+2),
    G(beta)=2^(beta/2)*Gamma(1+beta/2).

For completeness, after inserting etaU(u)=integral eta2(r) r^-3 u^2 exp(-u^2/(2r^2)) dr, the second derivative has three terms with coefficients s(s+1), -(2s+3)/r^2, and1/r^4. Their absolute integrals are respectively A(beta-2)*G(beta)/beta, A(beta-2)*G(beta), and A(beta-2)*(beta+2)*G(beta). Boundary terms vanish for beta>0; the second derivative is integrable there. These facts and Fubini still require Lean proofs.

For gamma=0 and 1/8<=beta<=7/8, A(beta-2)<=A(-2)=9. Weighted AM-GM u^beta<=(1-beta)+beta*u inside the Gaussian integral gives G(beta)<=(1-beta)*G(0)+beta*G(1)<=sqrt(pi/2)<1.2534. The bracket is4beta+6<=9.5. Therefore

    |F(beta,delta)| < 2.72/delta^2.

This makes each height-zero term below1.82e-8 at q=1,2. The same estimate with its displayed gamma-dependent bracket handles a fixed low-height band. It grows quadratically in gamma, so it cannot be summed over all zeros without a height split.

At large negative gamma for positive delta, stationary phase occurs roughly at u=-gamma/(2*pi*delta), within the Gaussian smoothing scale. Thus low q can move its difficulty to large zero heights |gamma| comparable to |delta|. The two integrations by parts alone do not dispose of those stationary cells. Signed Gaussian contour rotation and the actual eta2 factor, followed by multiplicity-aware height counts, are needed. One must not import the main-term Fourier decay as though it held unchanged at every complex s.

## One bounded next test: optimized positive family detectors at a single hard modulus

The next proposed experiment is finite and diagnostic: use p=149993, delta=.082, theta=7/8, and y0=1e25. Test whether exact character-family logarithmic-derivative moments, stronger than a separate total-mass cap, can improve the weighted absolute zero bound at this hard cell. Do not begin by scanning all moduli.

Use abscissae sigma in {9/8,5/4,3/2,2} and centers t in {0,+/-1/2,+/-1,+/-2,+/-4,+/-8,+/-16,+/-32}. Each supplies a positive zero detector

    P_(sigma,t)(beta,gamma)=(sigma-beta)/((sigma-beta)^2+(t-gamma)^2).

Its summed value over one primitive character is the real part of the completed logarithmic derivative, including the correct parity gamma term and no principal pole for nonprincipal characters. Sum this identity over all p-2 primitive characters before taking bounds. Character orthogonality computes the family Euler-series mean explicitly from residue classes n=1 mod p, with the omitted principal character subtracted; parity-specific sums similarly use n=+/-1 mod p. The Euler-series tail beyond a finite cutoff L is bounded explicitly by the corresponding integral of log(t)/t^sigma, so the computation is finite. Start with a practical fixed cutoff, such as L=10^6, and record the tail loss rather than treating it as negligible.

Fit nonnegative coefficients lambda_j to majorize the actual |F(beta+i*gamma,.082)| over beta in [1/8,7/8] and |gamma|<=64 by sum lambda_j P_j. Fit conjugate/reflected pairs together if that decreases the bound. Use the etaU Mellin/Taylor formula with certified remainders to enclose transform values on cells. Control |gamma|>64 with signed rotation and a separate positive detector/tail estimate; a grid without between-cell derivative bounds is not a certificate.

This is a finite linear-optimization test with explicit inputs and a definite output: a rational detector, a certified total family upper bound, and its comparison with the old/relaxed aggregate budgets after the exact sqrt(p)/(p-1) weight. If the best detector in this fixed basis still exceeds the budget, report its numerical value and which cells force the cost; do not call that a general impossibility theorem. If it passes, independently certify all cell inequalities and Euler tails before extending to other q. The small-conductor and high-height cases would still remain.

This test is more specific than asking for an unspecified family density theorem. It uses actual character orthogonality in the Euler series and optimizes a positive majorant of the actual etaU transform. It may still fail because first moments of positive detectors are too weak; a failure would identify whether second family moments or a finite zero-location certificate is the next necessary input. No implementation or result from this proposed optimization is claimed here.

## Uniformity and remaining proof status

The improved main bound and finite totient comparison are uniform for all x>=4.9e26. The gap delta region is independent of x after normalization. An absolute zero coefficient bounded uniformly over that region gives a decreasing y^(-1/8) factor, so checking its worst scale y0 is legitimate. In contrast, a cancellation computation of y^(i*gamma) at y0 is not automatically uniform for larger y; it needs a phase-uniform operator bound or a separate all-y argument.

The explicit formula remainders must be bounded in the same all-y domain. Removed-prime powers have an elementary uniform treatment already present in BaseGap2; a new QRH spectral estimate does not remove their contribution. Neither the paper IBP bound nor the exact etaU Mellin identity supplies the required all-character zero sum on its own.

Completed research outputs are: exact domain audit; elementary main-term improvement below.000481; exact-rational arithmetic checks; an explicit obstruction to a uniform strip-only absolute recipe, including the relaxed.01398 target; the low-height large-twist IBP bound; and a finite family-detector experiment specification. The base-gap replacement theorem, the family bound and all new Lean bridges remain unproved.


Review status: the independent auditor confirmed the source-level .01398 relaxation and the exact ghat consumer. The new .000481 main-term derivation, cosine transform lower bound and twice-IBP formula have not received a completed independent review; the auditor's active scope moved to minor-energy dependencies. Their status remains paper derivations with the listed rational checks, not independently approved analytic lemmas.


Follow-up: FAMILY_DETECTOR_TEST.md executes the proposed bounded experiment and proves a separate paper obstruction for all nonnegative detector combinations with sigma>=1.02, now exceeding the source upper bound .060272 for the actual ghatY consumer. That stronger conclusion uses a new transform lower bound and explicit family means; it does not follow from the earlier .03485 inventory example. The auditor subsequently approved the mathematics of the original main/cosine/IBP derivations, subject to the qualifications above; no Lean verification occurred.
