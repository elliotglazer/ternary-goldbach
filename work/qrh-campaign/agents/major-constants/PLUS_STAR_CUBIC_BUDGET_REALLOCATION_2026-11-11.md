# Reallocating the cubic budget with the preserved plus energy

2026-11-11. Conditional paper implication and exact rational checks. No actual prime, zero, L-function, transform or integral values were evaluated. No Lean declaration, source edit or build was made. This note changes an allocation, not the final error allowance or a spectral conclusion.

The preserved nonprincipal plus energy permits the full plus radius **rho=5.12e-7**. With the same final cubic-error constant, one may replace the old star parameter 3.67e-6 by **u=1.194e-5**. Two useful sufficient alternatives are **A<=9e-12, B<=3500** and **A<=1e-10, B<=2000**. A newly supplied etaU coefficient estimate, if established with its stated principal-only inputs, makes the existing source prime sieve prove B<1915. The separate A bound remains unproved.

## 1. Actual functions and the plus radius

Keep R=132900, x>=4.9e26, y=x/49, q in Qset R, delta=x*beta and |delta|<=Dq=8R/qt(q). Write a_q=mu(q)/phi(q), P(delta)=Fourier(etaPC)(-delta), s=Sp/x and r=s-a_q P. All sums over b run over the actual unit numerators Bset(q). The finite tagged measure is counting measure in q,b and Lebesgue measure in delta; physical beta integrals have the extra factor 1/x.

The reviewed reduced-height plus theorem preserves the original energy

    Eplus_q = (1/(phi(q)*x^2)) sum_(psi != 1) |tau_q(psi)|^2
                 |Schar(psi^-1,coprimePart(q,Lambda*etaPlus_x),delta/x)|^2
            <= 1.80625e-13.

It is conditional on its stated primitive finite-RH certificates; this note does not supply those certificates. The bound also preserves the earlier plus consumers. Inverse labels, imprimitive characters and supported Gauss weights remain unchanged.

The exact centered coprime vector has zero sum over b. Hence its principal constant vector is orthogonal, giving

    sum_b |r|^2 <= [sqrt(Eplus_q + mu(q)^2*p0^2/phi(q))
                         + sqrt(phi(q))*d0]^2,
    p0=2.83e-7, d0=1e-15.

Here p0 already includes the inner principal coprime removal; d0 is the outer additive removal. This is the identity and triangle step of DIRECT_PLUS_RESIDUAL_ENERGY_TARGET, section 2, rather than the source's factor-3 generic bound. Since phi(q)<=265800<516^2 and mu(q)^2/phi(q)<=1,

    1.80625e-13 + (2.83e-7)^2 < (5.12e-7 - 516e-15)^2.

Thus sum_b |r|^2<rho^2 uniformly, with rho=5.12e-7. The right difference is positive. At q=1 the nonprincipal sum is empty; the same upper bound is valid.

For clarity, this stronger pointwise bound also preserves the integrated inputs without any new spectral estimate. There is no extra phi(q) after integrating a bound that already sums over b:

    Z=sum_q integral sum_b|r|^2 <=16*150000*19*rho^2 < .006^2.

The harmonic-sum bound 19 is the previous finite dyadic-block estimate. The unchanged Fourier/mass input gives Y/x<=a=.640208*13.59756<2.951^2. Therefore X/x<(2.951+.006)^2<j=8.79. One can retain these deliberately loose old constants.

## 2. Complete cubic error and the new star allocation

Use exactly the physical moments of INTEGRATED_CUBIC_RESIDUAL_CONTRACT:

    X=integral|Sp|^2, Y=integral|Ap|^2,
    Wstar=integral|Sp|^2|Ss-As|^2,
    Wplus=integral|As|^2|Sp-Ap|^2.

The identity Sp^2 Ss-Ap^2 As=Sp^2(Ss-As)+As(Sp-Ap)(Sp+Ap), followed by Cauchy and the triangle inequality, bounds the cubic discrepancy by

    sqrt(X Wstar)+(sqrt X+sqrt Y)*sqrt(Wplus).

The oscillatory factor e(-N alpha) has norm one. No sign, realness, cancellation or independence of residuals is assumed. In particular all mixed terms survive this bound.

The new plus radius and the unchanged etaU Fourier-energy and modulus weights imply

    49^2 Wplus/x^3 <=49*rho^2*v, v=7.78*2.85.

This follows by bounding max_b|r_b|^2 by sum_b|r_b|^2 and integrating the actual |Fourier(etaUC)(-delta/49)|^2; the change of variable supplies 49. The exact weight is sum_q mu(q)^2/phi(q)^2<=2.85. It is not replaced by a primitive-character average.

If 49^2 Wstar/x^3<=j*u^2, the normalized cubic discrepancy, in units x^2/49, is at most

    j*u + rho*sqrt(49v)*(sqrt j+sqrt a)
       <=j*u+rho*C,
    C=49*(j+a)/9+9*v/2=914205504131/4687500000.

The latter is the inherited rational AM-GM envelope: (sqrt j+sqrt a)^2<=2(j+a), and C^2-2*49*v*(j+a)=(49*(j+a)/9-9*v/2)^2>=0.

The old exact allowance is

    Eold=64019155993729/312500000000000000
        =j*(3.67e-6)+(8.85e-7)*C.

For the new rho, the exact largest u admitted by this same linear envelope is

    umax=492214121790863/41203125000000000000.

It lies strictly between 1.194e-5 and 1.195e-5. Select u=1.194e-5, the largest multiple of 1e-8 admitted by this envelope. Its exact positive reserve is

    Eold-j*u-rho*C=248809290863/4687500000000000000.

This is not an optimum over all allocations: retaining the two square roots, tightening X or principal norms, or choosing a smaller rho can change it. No such change is needed here. The unchanged Fourier-tail allowance is 49*2.03e-5*2.85 in the same units. The main term, singular-series lower bound, reduced J lower bound, minor cells, nonprime subtraction and finite-range coverage are unchanged. Base-gap control is still a separate obligation.

## 3. The actual A/B targets, including the principal term

Let u_q,b be the normalized nonprincipal coprime etaU additive contribution and v_q,b the remaining principal plus inner/outer removals. Thus Ss/y-As/y=u+v. Define

    E_q(delta)=sum_b|u_q,b|^2
       =(1/phi(q)) sum_(psi!=1)|tau_q(psi)|^2
             |Schar(psi^-1,coprimePart(q,Lambda*etaU_y),delta/x)/y|^2,
    A=sum_q a_q^2 integral |P(delta)|^2 E_q(delta),
    B=sum_q integral E_q(delta).

The intervals are [-Dq,Dq]. These are unaveraged numerator energies, with the original Gauss/inverse conventions. The reviewed weighted-principal proof uses |v_q,b|<=1.502e-6|a_q|+2e-9 and the finite Euler-product bound sum mu^2/phi^3<=32/13. Since Z<.006^2 and X/x<=j remain true, it still gives the full integrated norm

    ||s*v||_2 < 1.502e-6*1.262+2e-9*3
               =1.901524e-6 < pbar=1.902e-6.

This pbar must not be multiplied by sqrt(j) again. For the nonprincipal term, s=a_q P+r and max_b|r_b|^2<=rho^2 give ||s*u||_2<=sqrt A+rho*sqrt B. Minkowski, retaining the cross terms, now proves

    sqrt(49^2 Wstar/x^3)<pbar+sqrt A+rho*sqrt B.

Consequently the exact sufficient frontier is

    sqrt A+rho*sqrt B <=sqrt j*u-pbar.

The following alternatives are proved by squaring positive rational reserves with 2.964^2<j. They are sufficient budgets, not evaluated or optimal energies.

| A upper bound | B upper bound |
|---:|---:|
|0|4200|
|1e-12|4000|
|4e-12|3750|
|9e-12|3500|
|1e-10|2000|
|4e-10|650|

The A=0 row is just a boundary allocation, not a claim that this energy vanishes.

## 4. Conditional source-sieve join for B

The new ETA_U_PRIME_COEFFICIENT_ENERGY paper, whose independent review is pending at this freeze, supplies a precise candidate input. With L=log y and primes retained above 7sqrt(y), it states

    tlarge <1.254*(1.000468 L+.502756)+2e-60,
    esmall <2.1e-9, y>=1e25.

Its principal theta, finite arithmetic and prime-power premises must be proved/localized as stated there. They are not consequences of the present scalar calculation. The reviewed source-sieve reduction gives

    C_R=(log(2R)+2)/(.5L+log(7/2)+1.33258),
    Cfull <=49*(sqrt(C_R*tlarge)+sqrt(esmall))^2,
    B<=(sqrt(Cfull)+.0010632)^2-Lcop,
    Lcop>=0.

These are actual physical-arc/coprime identities, including the exact principal subtraction. Dropping the nonnegative Lcop weakens the bound safely. In contrast, dropping an adverse residual cross term would not be valid.

Here is a uniform elementary closure requiring no analytic evaluation. Since e<3 and 3^50<10^25, L>50. Also e>27/10, witnessed by the first six exponential-series terms, and (27/10)^13>265800, so log(2R)<13. The denominator is greater than L/2. Therefore

    C_R*tlarge
      <30*1.254*(1.000468+.502756/50)+(30/50)*2e-60 <39.

Using 39<6.25^2 and 2.1e-9<(46e-6)^2 yields

    sqrt B <7*(6.25+46e-6)+.0010632 =43.7513852,
    B <1915<2000.

Every step is uniform for unbounded y, not an endpoint sample. The source sieve conditions R>=1e5, (20000R)^2<=x/16 and 2R<=(sqrt x/2)^(3/5) hold already at x=49e25; exact integer checks are in the receipt. The broad source Fact PlattGRH remains to be replaced by its inspected principal-only quotient/totient premises, rather than reintroduced as a blanket assumption.

Thus the coefficient theorem and existing principal-only sieve route would close the B part of the row A<=1e-10,B<=2000. This removes the earlier *allocation* obstruction for this particular sieve comparison; it does not contradict the old lower bounds on its limiting upper expression. It does not prove A<=1e-10. It also does not justify removing plus certificates, principal certificates, or the independent base-gap requirement. No production cost reduction is credited here.

## Evidence and remaining work

The companion plus_star_budget_reallocation_20261111.py uses only Fraction/integer arithmetic and hashing. Its JSON records 34 exact checks, six A/B rows, the positive cubic reserve and nine input SHA256 pins. The input set binds the integrated contract, weighted-principal proof, upper-L2 adapter, reviewed plus-height theorem, orthogonal direct-plus identity, weighted spectral definitions, earlier B sieve reduction, pending etaU coefficient theorem, and actual MajorTotal source.

Key source joins are MajorTotal.lean:760 (old pointwise constants and oscillatory main identity), :808 (integrated error and Fourier tail), and :887-915 (Fourier energy bounds). The orthogonal principal identity and inverse-character normalization were independently checked in REVIEW_DIRECT_PLUS_RESIDUAL_ENERGY_TARGET; the newly preserved plus bound was independently checked in REVIEW_PLUS_FINITE_RH_HEIGHT_REDUCTION. All frozen predecessors are unchanged. This note is a new conditional allocation awaiting independent review, not a compiled theorem or a proof of actual A/B energies.
