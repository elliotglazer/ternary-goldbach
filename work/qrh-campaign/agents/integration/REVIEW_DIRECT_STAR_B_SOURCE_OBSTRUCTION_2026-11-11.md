# Review of the direct star-B source comparison

2026-11-11. PASS at the stated source/paper and conditional-comparison scope. This binds the versioned successor `audit/DIRECT_STAR_B_SOURCE_OBSTRUCTION_V2_2026-11-11.md`, SHA256 `65B892756EA24A086C673082D3CA551AF99EECA5DDA63CB3523EE3F5514A88A9`. Two source qualifications were corrected before acceptance: the 21/4 totient bound is a paper specialization, not an existing declaration with that literal constant; and the source mass comparison is non-strict. The original predecessor retains hash 8C137D3E and is not the version accepted here.

I checked the actual source interfaces and independently reconstructed the normalization, principal subtraction, mixture lower bound, asymptotic comparison and four allocation maxima. A standard-library script passed 56 exact scalar/hash checks without importing the author's script. No prime or analytic function values, builds or source edits occurred.

## Physical identity and normalization

For x=49y, the actual coefficient sequence is `a_y(n)=Lambda(n)etaU(n/y)`, and the source identifies its exponential sum with `S etaStar x`. The coprimePart operation remains q-dependent. Finite character Parseval gives the sum over unit numerators as a sum over ambient characters with the Gauss-square weight and inverse-character label. Removing the ambient principal character subtracts exactly

    mu(q)^2/phi(q) * |F'_q(delta/x)/y|^2.

The denominator is phi(q), not its square. I checked this against `MajorArcs/ArcChars.lean:159–215`, particularly `Schar_one_eq_expTsum`, `norm_sq_gaussSum_one` and the exact `totient_mul_sum_units` use before the subsequent inequality. No nonprincipal upper estimate is needed for this identity. The separate A target includes another main-term weight and must not be substituted for this principal projection.

The change delta=x*beta contributes x/y^2=49/y. `LargeSieveArcs.integral_majorArcs_le:92` and `MajorArcs/ArcsEq.sum_arcs_le_integral_majorArcs:34` supply the two directions of the arc-union identity. Their hypotheses hold because 16R^2<=x, 8R<=x and x>0. The source periodization retains q=1 and the boundary arcs of (0,1]; finite endpoints have measure zero. Thus the displayed Cfull is correctly normalized.

The finite disjoint-union L2 triangle inequality gives the coprime total at most `(sqrt(Cfull)+d0*sqrt(V))^2`. Subtracting the exact nonnegative principal projection then yields the author's B upper bound. This step does not replace an upper bound on principal energy with a lower bound. For even R, Qset contains R/2 odd moduli and R even moduli. Each phi(q)/qt(q)<=1/2, including q=1 and q=2, so V<=12R^2. The source star removal is actually bounded by 1e-12*y in `ArcCharsStar:85–110`; the chosen d0=2e-9 is a conservative weakening.

## The actual prime large-sieve input

`MinorArcs/LargeSievePrimes.lean:36` defines PrimeSupported as absolute summability and support on primes strictly greater than sqrt(x). Splitting at n>7sqrt(y) therefore gives the right input for `LargeSieveProof.cor_12_2_5:378–396` with delta0=8 and Q0=R. Its denominator is

    log(2sqrt(x/16))+cE = (1/2)log y+log(7/2)+cE.

I checked the size hypotheses at y=10^25 by exact integer inequalities; they persist for larger y. In particular `(2R)^10<y^3` is a sufficient stronger condition for the fractional-power hypothesis. The coefficient split leaves the prime powers and small primes in h_y, and Parseval plus Minkowski yields the factor 49 in the author's equation (6).

The actual corollary still has a `Fact PlattGRH` binder. Its body invokes `LSQuot6.prop_12_2_4:69`; that theorem is a quotient/totient estimate, not a nonprincipal character estimate. The previously accepted principal-only dependency localization is still an obligation to implement. This review does not use the old bundled fact as a newly permitted replacement premise. It also does not recursively re-audit the entire quotient library.

The sharp coefficient input is explicitly favorable additional information. The existing etaPlus coefficient theorem cannot establish the required etaU bound by renaming variables. A new weighted prime partial-summation and prime-power argument would have to prove `tlarge=V_U log y+O(1)` and `esmall=o(1)` if this comparison were implemented. The report does not claim those asymptotics were evaluated or already formalized.

The unconditional full-circle fallback is also consistent. Positivity, etaU<=2, and t^2 etaU(t)<6 imply `Lambda(n)^2 etaU(n/y)^2 <= Lambda(n)etaU(n/y)(2log y+6)` for n>=1; n=0 vanishes. `MinorTotal.norm_S_etaStar_le_uniform:49–66` has no Platt binder and bounds the positive coefficient sum at frequency zero. This gives the reported coarse t(y) bound, but its logarithm is not an obstruction once the prime-arc quotient is retained.

## What the limiting obstruction actually proves

In the favorable comparison model, C_R(y)*tlarge(y) tends to `2(log(2R)+2)V_U`. Vanishing small/removal costs and exact principal subtraction then give the limiting upper-comparison expression

    98(log(2R)+2)V_U-L0.

The principal term satisfies `L0<=49 M_R V_U`: change delta to 49 times the Fourier variable, extend each nonnegative interval integral to the whole line, and use the source Fourier normalization in Plancherel. `SumMuPhi.sum_Qset_mPhi_bounds:108–113`, nonnegative summands and inclusion of Qset R into Qset 150000 give `M_R<=13.59756<14`. The corrected non-strict inequality is sufficient.

The lower bound V_U>1/5 is analytical, not sampled. In `Cor933.etaU_eq:49`, integrate the positive eta2(r)g(u/r)/r mixture in u. The Jacobian r cancels 1/r and `integral eta2=1`, yielding total mass sqrt(pi/2)>1. Since 1/4<=r<=1 on the mixture support, the mass above 2 is at most the Gaussian g-tail above 2. Integration by parts gives `2 exp(-2)+integral_2^infinity exp(-t^2/2)dt`; the latter is at most exp(-2)/2 by t/2>=1. Since exp(2)>7, the mass on [0,2] exceeds 9/14. Cauchy-Schwarz yields `V_U>81/392>1/5`. The source Gaussian mixture also supplies integrability, so this is not an inequality involving a default divergent integral.

Finally exp(1)<3 and 3^11<2R imply log(2R)>11. These estimates make the comparison expression strictly larger than

    49*(2*(11+2)-14)/5 = 588/5 = 117.6.

The direction is correct: an upper bound on L0 limits how much subtraction can help. This is a lower bound on the limiting value of this particular upper-bound expression. It is not a lower bound on actual B. The argument rules out closing the displayed uniform allocation through the scalar corollary plus sharp scalar coefficient energy and principal subtraction alone. It does not rule out exact Gq structure, a centered variance estimate, a sharper sieve, or a different joint allocation.

The optional projection-error estimate is valid after the source correction. For q<=265800, seven distinct prime factors would force q>=510510. At most six factors give `q/phi(q)<=30030/5760=1001/192<21/4`. `MertensProduct.div_totient_eq_prod:2129` and `exch:2156` provide the product and exchange interfaces; the finite specialization remains a paper lemma. Then qt(q)>=q and sum n^-2<2 imply K_R<168R. This is ancillary and does not enter the 117.6 calculation.

## Allocation frontier and its scope

For the fixed displayed uniform remainder p=1.504e-6, j=8.79, rho=8.85e-7 and u=3.67e-6, the exact sufficient frontier is

    sqrt(A)+rho sqrt(B)<=sqrt(j)(u-p).

The four maximal integer B values are 14,24,37,52 for A=9e-12,4e-12,1e-12,0. My checker proves acceptance of each value and rejection of the next with separately certified rational square-root intervals, rather than importing the author's squared-inequality test. At A=0 the exact ceiling is `114552159/2175625`, strictly between 52 and 53. Monotonicity in B makes these adjacent checks sufficient.

This B<53 ceiling belongs only to this fixed-p sufficient inequality. It is not a universal necessary condition for the true Wstar target. In particular, a successor argument retaining the q-dependent principal coefficient may improve the remainder norm and allocation. That successor needs its own proof and comparison; it is neither accepted nor excluded by this review. The author and parent have identified such follow-up work. The obstruction at 117.6 is independent of this particular p choice, but its usefulness must be compared against whichever new allocation is actually proved.

The report correctly refuses to subtract an outside-energy upper bound from a full-circle upper bound to infer an inside upper bound. Existing off-arc minor estimates and their bundled final proof do not supply the new inner-arc etaU variance bound. No circular use of an old nonprincipal estimate is accepted here.

## Evidence and remaining work

| Owned artifact | SHA256 |
|---|---|
| integration/review_direct_star_B_20261111.py | 70859ABF0B8BA761E595F4B2F92CD8A4FF891F4AFE2B33D26AC3DB5B818A2FB5 |
| integration/review_direct_star_B_20261111.json | C3B35C9AE089EEC40D4E3CFA67F7AF4FAB02FAC54DF0E0A901C40F8F2A87E5C8 |

The receipt verifies the revised author hash and all 17 source/predecessor/evidence pins in its table. It records 56 total checks, including the allocation witnesses, scalar size conditions, totient specialization and comparison constants. Relevant additional source bodies read were `ArcChars:159–215`, `ArcCharsStar:85–110`, `LSQuot6:69–103`, and the cited arc, smoothing, Parseval, mass and Mertens interfaces. This is bounded source inspection, not a build or axiom audit.

The actual aggregate targets remain unproved. Principal RH localization, the source-faithful etaU coefficient adapters, and a sharper centered argument remain potential work. The revised report establishes a useful reduction and a precisely scoped failed comparison, without claiming that actual B, Wstar or the final root fails.
