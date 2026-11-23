# P4 needs no additional narrow principal strip

Research derivation, 2026-11-11. This note is a conditional paper proof, not a Lean declaration or compiled theorem. The new reduction removes both the additional narrow principal strip and the quantitative head-moment certificate from the P4 consumer. It uses the already selected shared principal strip, global QRH, the unconditional analytic count majorant, the sharper xi mass at 2, and the unconditional height floor. The narrower principal strip and accurate moment remain required by other consumers of the common psi envelope.

No Lean source, frozen declaration or package was changed. No spectral evaluation, sieve or build was run. A twenty-check exact rational calculation supports the scalar inequalities below.

## 1. Actual target and inputs

The unchanged target is `TernaryGoldbach.Prelim.sum_vonMangoldt_le_a14` at `Prelim/LambdaMu.lean:1375`: for real y>=25000000, the sum of Lambda(n) over natural 1<=n<=floor(y) is at most1.0064*y. Source commit is `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

Retain the finite-prime branches, upper smoothing sandwich, true-multiplicity convention and final floor transfer in [PRIME_CONSUMER_SOURCE_JOIN_2026-11-11.md](../prime-estimates/PRIME_CONSUMER_SOURCE_JOIN_2026-11-11.md). Replace that note's sections2-4 low-moment derivation as follows. Write rho=beta+i*gamma for actual nontrivial zeta zeros, and m(rho) for their analytic orders.

Required spectral statements remain to be proved in Lean:

1. Global QRH and reflection give 1/8<=beta<=7/8.
2. The shared conductor-one certificate gives .445<=beta<=.555 through inclusive height60343058. Only its restriction through1000000 is used for the new low moment.

The following unconditional paper results are also used, with their existing formalization obligations:

* The height floor |gamma|>=2.39, obtained from `ZetaLowZeroFree` and xi reflection as detailed in the P4 source join. In particular there are no real nontrivial zeros to omit.
* Every finite collection of actual zeros has mass sum m(rho)*w2(rho)<=.07, where w2(rho)=(2-beta)/((2-beta)^2+gamma^2). This is the sharper [XiMass review](XIMASS_REVIEW.md), with log derivative at2 at most27937/400000, combined with [FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md](../zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md). The translated bound3 at center0 would not suffice.
* For the closed positive-ordinate count N(t), with multiplicities, [RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md](../mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md) proves on paper

      N(t) <= t/(2*pi)*(log(t/(2*pi))-1)+7/8+5*log(t)+20,
      for every real t>=1500.

  This is an analytic count majorant, not an exact head count or a historical zero table.
* Complex conjugation preserves actual zero orders. The source xi/zeta reflection and analytic-order transport must be used on actual source carriers. No simplicity assumption is made.

The finite mass transfer applies to a fixed outer source carrier with height greater than1000000, filtered to the inclusive requested window. One can work with that entire finite low collection and bound any smaller collection by positivity. No convergence of an infinite reciprocal-zero series is asserted.

## 2. Coarse count consequences without head data

Elementary series give 2.7<exp(1)<11/4. Hence log1500<8, log1000000<14, and log(1000000/1500)<7, by the exact power comparisons2.7^8>1500,2.7^14>1000000 and2.7^7>2000/3. Since2*pi>6>exp(1), log(2*pi)>1.

The count majorant therefore gives

    N(1500) < (1500/6)*(8-1-1)+7/8+40+20 <1600.

For1500<=t<=1000000 it gives

    N(t) <2*t+727/8 <(25/12)*t,

because727/8<1500/12. To compare the first term, first bound log(t/(2*pi))-1<12 and then use1/(2*pi)<1/6. This does not presume a lower bound for that logarithmic expression.

These estimates have no finite-RH or head-location input. The global strip is not used in this section.

## 3. The reciprocal moment is below151/3

Put a=2-beta. The global reflected strip gives9/8<=a<=15/8. For each zero the height floor and positivity imply

    (1/|rho|^2)/w2(rho)
      =(a^2+gamma^2)/(a*(beta^2+gamma^2))
      <=1/a+a/gamma^2
      <=8/9+(15/8)/(2.39^2) <5/4.                  (1)

On the closed window |gamma|<=1500, conjugation and the absence of real zeros give total multiplicity2*N(1500)<3200. Weighted Cauchy-Schwarz, taking one factor sqrt(m*w2) and the other sqrt(m)/(|rho|*sqrt(w2)), now gives

    (sum_(|gamma|<=1500) m/|rho|)^2
      <=(sum m*w2)*(sum m/(|rho|^2*w2))
      <.07*3200*(5/4)=280 <17^2.

Thus the low reciprocal sum is below17. This is a true-multiplicity inequality, not a bound on the number of distinct zero locations.

For the positive ordinates in1500<gamma<=T=1000000, use1/|rho|<=1/gamma. Finite summation by parts for the closed count gives

    sum_(1500<gamma<=T) m/gamma
      =N(T)/T-N(1500)/1500+integral_1500^T N(t)/t^2 dt
      <=(25/12)*(1+log(T/1500)) <50/3.

This identity follows by integrating1/gamma=1/T+integral_gamma^T t^(-2)dt for each of the finitely many zeros. Zeros exactly at1500 belong to the preceding low piece; zeros atT belong to this piece. The discarded term is nonpositive. Conjugation supplies the same estimate on negative ordinates, with no additional reflection or simplicity assumption.

Combining both pieces,

    sum_(|gamma|<=1000000) m/|rho| <17+100/3=151/3.  (2)

No narrow principal strip, exact N(1500), or Q1500 moment is used.

## 4. Shared strip gives the weighted moment below381

On the same closed window the shared .555 upper bound implies

    35*max(beta-1/2,0) <=35*(.555-.5)=1.925<2.

Therefore the actual weighted moment used in the P4 smoothing estimate satisfies

    W35=sum m*exp(35*max(beta-1/2,0))/|rho|
       <(151/3)*exp(2)
       <(151/3)*(11/4)^2=18271/48<381.             (3)

This is weaker than the accurate moment below24 needed elsewhere but stronger than P4's previously sufficient436. It has a different dependency path: analytic count plus sharp xi mass replaces both the narrow strip and the head-moment certificate for P4 only.

## 5. Recheck the Mellin endpoint factor on the wider strip

For5e9<=x<=exp35, retain L=log(x), K=sqrt(L+10), delta=.002/(L*sqrt(L+10)), a=+/- .002/L, y0=1000, b=log(y0/x), and the already checked22.33<=L<=35. The normalized low-zero term is bounded by

    exp(delta^2/2)*(exp(.555*|a|)+exp(-.445*(L-7)))
         *x^(-1/2)*W35.                           (4)

Indeed0<beta<1 suffices for the enlarged Gaussian prefactor, log1000<7 controls the lower Mellin endpoint, and the shared strip supplies both endpoint exponents. Each displayed endpoint bound decreases asL increases. AtL=22.33 the exact scalar script proves the coefficient in (4) is below1.002. It bounds exp(-.445*(22.33-7)) by1/900 using a positive degree32 Taylor lower sum for the inverse exponential. The two small positive exponentials use

    exp(z) <=1+z+z^2/(2*(1-z/3)),  0<=z<1.

This follows by a geometric majorant from the quadratic term onward. Thus no approximate transcendental evaluation enters this comparison.

Since70700^2<5e9, equations(3)-(4) give E_low<1.002*381/70700<.0054. Every other term in the accepted P4 allocation is unchanged: the intermediate range already uses the shared strip, the high range uses global QRH, and the vertical and desmoothing terms use neither the narrow strip nor a head count. Their sum after multiplication byL is.002188002001, so their unscaled sum is below.0001 forL>22. The same upper denominator multiplier at most1.000001 gives

    |psiR(x)-x|/x <(.0054+.0001)*1.000001
                 =.0055000055<.005501<.0064.       (5)

Forx>=exp35 the already reviewed shared-strip/global-QRH estimate .0081/log(x) is unchanged. The finite prime intervals and the final floor transfer are exactly those of the P4 source join. Consequently this reduction gives the same final coefficient1.0064 and threshold25000000.

## 6. Scope, checks and pins

The companion [p4_shared_strip_scalars_20261111.py](p4_shared_strip_scalars_20261111.py) exited0 and passed20 exact Fraction comparisons. It checks exponent-series and rational implications only. It does not prove the analytic count, mass identity, source smoothing theorem, finite prime data, QRH or the finite shared strip.

No global strategy change is proposed. The common .01/log(x) envelope still requires its sharper low-zero information. This note removes an unnecessary dependency from one consumer and makes P4 available earlier in a future formal implementation. Independent review is required before adoption.

| Input | SHA256 |
| --- | --- |
| Scalar script | 641D47F7ADB06F1266A7D3C15BC5514818FBE1A85139942B6DCE3F4AAEC6ACBA |
| Analytic count note | 4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303 |
| XiMass source | DC2F179566C4DD7EFEBBC295CD49C1E40CD1B861EAC5555ABF6EA4377765A899 |
| XiMass review | F285D46C3275A3A605A52974A5FA30BCAA87912007C6A28CC5BFD3772C5DD436 |
| Finite mass order transport | C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D |
| Prior P4 source join | B5F377CEED926B70B22E2539086D5C423D474A065D3E10F56D93C93108377B61 |
| Low-zero smoothing refinement | 33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61 |
