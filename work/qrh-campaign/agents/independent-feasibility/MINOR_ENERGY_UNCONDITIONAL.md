# Unconditional routes to the minor-arc smoothed prime energy

Research review, 2026-11-10. Source pin is calr3/ternary-goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean compilation, implementation changes, or new interval computation occurred. Numerical values below were evaluated from the displayed formulas in JavaScript. The analytic reductions are paper arguments with formal bridges still required.

## Actual consumer and available slack

Put f(t)=etaPlus(t)^2, L=log x, and

    S(x)=sum_n Lambda(n)*log(n)*f(n/x).

The existing minor consumer needs S(x)<=x*((.640208+366.91/sqrt(x))*L-.021095) for every x>=x0=4.9e26. `MajorArcs/Prop715.lean:299` proves its stronger approximation using two zeta explicit formulas, with smoothings phi1=f and phi2=f*log. Its input is RH to height500. It does not currently obtain this estimate from a psi envelope. `prop_7_1_5'` at line356 supplies the resulting conditional estimate.

The exported unconditional integral approximation in `EtaPlusSqLog.lean:889` has error1.95e-6*L+5.3e-7 around .640206*L-.021095. At x0, this leaves only about4.1393e-8 in S/(xL) for prime-distribution error. However, that exported constant leaves substantial internal slack.

The mellin_strip worker recomputed the signed upper constants directly from the proof, and the present source review confirms its ingredients. `etaO_numerics` bounds the compact mass by .640205998 and log moment by -.02109477. The actual squared derivative bounds are1000 and60. The proof uses lambda1.6 and.4, with g'' energy368 and H=200. These yield

    integral f <= .640206 + .871625e-6,
    integral f*log(t) <= -.021095 + .50085e-6.

For example the mass cross contribution is (1.6*368+1000/1.6)/200^4=.758625e-6, and the square remainder contributes .115e-6. Thus prime-distribution error below

    1.128375e-6 - .50085e-6/L

in S/(xL) would recover the original upper bound even after discarding the favorable366.91/sqrt(x) term. At x0 this allowance is1.120225326e-6. The source comment claiming a2.6e-7 integral error does not follow from these actual proof constants.

The parent subsequently reported an exact minor-numerics replay allowing the coefficient .65 in place of .640208, with other changes explicitly propagated through the minor formulas. This report does not independently certify that replay. If its proposed .65*L-.021095 upper-energy interface is adopted, the energy allowance increases to

    .65-.640206-.871625e-6-.50085e-6/L,

about .00979312. This changes which analytic route is economical.

## A complete partial-summation reduction

Define E(y)=psi(y)-y and h_x(t)=f(t)*log(xt). After justifying convergence and vanishing boundary terms, Stieltjes integration by parts gives

    S(x)-x*integral h_x(t)dt = -integral E(xt)*h_x'(t)dt.

Consequently an envelope |E(y)|<=epsilon*y on y>=A gives

    |S-x*integral h_x|/(xL)
      <=epsilon*(V0+V1/L) + low(x,A),
    V0=integral_0^infinity t*|f'(t)|dt,
    V1=integral_0^infinity t*|(f(t)log(t))'|dt.

Here low(x,A) bounds the same integral below t=A/x with an unconditional coarse envelope. This formulation retains the entire Gaussian tail. A statement only near y=x is insufficient.

There are straightforward global bounds V0<45 and V1<105 from existing smoothing energies. Let w=2*pi*xi. Source `HHFourier.lean:194` gives integral w^2*|ghat|^2<=19.5, and `HHFourier2.lean:195` gives the corresponding fourth-moment bound368 after the Fourier derivative identity. Cauchy-Schwarz yields

    integral |w*ghat| <=sqrt((16*19.5+368)/8)=sqrt85<9.22,

because integral_R (16+(2*pi*xi)^2)^(-1) dxi=1/8. The established paper extraction in `mellin/TwistBounds.md` gives integral|ghat|<3.01. Both statements also bound the truncated Fourier integrals defining hH200. With H=3.01 and D=9.22,

    |etaPlus(t)|<=H*t*exp(-t^2/2),
    |etaPlus'(t)|<=[D+H*(1+t^2)]*exp(-t^2/2).

The derivative follows by differentiating hH200(log t) and its Gaussian factor. These Fourier differentiation bridges still require proof at the source definitions.

Using I2=integral t^2 exp(-t^2)=sqrt(pi)/4<.444 and I4=3sqrt(pi)/8<.665 gives

    V0<=2H*((D+H)*I2+H*I4)<44.739256<45.

For V1, use |log t|<=t+1/t, the triangle inequality, integral(t^3+t)exp(-t^2)=1, and integral(t^5+t^3)exp(-t^2)=3/2. Then

    V1<=2H*(D+2.5H)+H^2*I2<104.827585<105.

For A=exp45, a=A/x<=7.2e-8. The source unconditional `Explicit/PsiSandwich.lean:90` has0<=psi(y)<=4y, hence |E(y)|<=3y. Taking K=2H*(D+H*(1+a^2))<74, direct integration on[0,a] gives

    low(x,exp45)
      <=a^3*[K*(1-log(a)/L+1/(3L))+H^2/L]
      <=(7.2e-8)^3*[74*(2+1/183)+9.061/61]
      <6e-20.

This is uniform in x>=x0: L>=61, a decreases, and1-log(a)/L=2-45/L<=2. It handles y<1 as well, where psi(y)=0. The high range needs no separate upper cutoff if its epsilon envelope holds for every y>=exp45.

Therefore a sufficient replacement psi envelope for the original energy coefficient is

    |psi(y)-y|<=2.39e-8*y for every y>=exp45.

The resulting error is below2.39e-8*(45+105/61)+6e-20, which fits the tightened integral allowance. For coefficient .6403, retaining the same negative constant, epsilon=1.99e-6 is sufficient. For coefficient .65, epsilon=.000209 is sufficient. These are explicit sufficient targets, not newly assumed mathematical facts.

## Published envelopes and their dependencies

Faber and Kadiri's corrected Table1 states |psi(y)-y|/y<=1.0412e-8 for all y>=exp45. This is already stronger than the sufficient original-energy target above. Their exp50 and exp60 rows give2.4075e-9 and1.6665e-9. The corrigendum explicitly uses Platt's zeta RH verification to height30610046000 for Table1, together with zero-density and zero-free-region inputs. Table2 uses Gourdon's larger height2445999556030 and gives3.1732e-11 from exp60. These numerical conclusions are strong enough, but importing either table as a premise would retain an unproved finite-zero input in this campaign. A full formal proof of the table would need to certify those inputs or replace them. [Faber and Kadiri corrigendum, Theorem0.1 and Tables1-2](https://www.cs.uleth.ca/~kadiri/articles/New-Bounds-for-Psi-Math-Comp-Faber-Corrigendum-Nov2017.pdf)

Fiori, Kadiri and Swidinsky's version3 gives the global explicit envelope9.22022*(log y)^(3/2)*exp(-.8476836*sqrt(log y)) for y>2. At x0 this is about5.775, far above any of these useful relative errors. Their sharper middle-range treatment explicitly incorporates finite RH and prior numerical estimates. Thus the mere existence of their global formula does not supply a useful finite-RH-free bound at this endpoint. [Fiori, Kadiri and Swidinsky, version3](https://arxiv.org/pdf/2204.02588)

Dusart's paper titled Estimates of some functions over primes without R.H. explains in its introduction that finite RH verification enters its effective estimates. The title cannot be read as absence of a finite verification dependency. This review found no sufficiently sharp published envelope whose full proof avoids all such inputs and was verified here from first principles. This is a bounded search finding, not a mathematical impossibility statement. [Dusart, introduction](https://arxiv.org/pdf/1002.0442)

The useful outcome from the literature is the explicit scale of a sufficient all-y envelope. A formal proof of the much smaller original RH-to500 input in Prop715 may cost less than formally recreating a table calibrated with height3e10. For the new .65 interface, even that finite verification may be unnecessary.

## Direct QRH smoothing after the .65 relaxation

The direct explicit-formula route keeps f and f*log as smoothings and applies the finite weighted zero mass <=.07 at s=2. Let

    w2(rho)=(2-Re rho)/((2-Re rho)^2+(Im rho)^2).

If a global strip bound proves

    |M_f(rho)| + |M_(f log)(rho)|/61 <= K*w2(rho)

for1/8<=Re rho<=7/8 at every height, then the normalized zero contribution is at most .07*K*x^(-1/8), before the separately bounded vertical remainder. At x0 the coefficient of K is .00003227182531. The .65 energy allowance permits K around303; choosing K<=300 leaves explicit room. This target was sent to mellin_strip. Its actual proof and vertical remainder remain that worker's obligation.

Uniform K and L>=61 give the all-x extension automatically through x^(-1/8). The near-zero-height range must be included unless a zero-free height is proved. A pointwise numerical sample of the transform does not certify this inequality. The actual bandlimit and complete Gaussian tails must remain in the large-height argument.

This is currently the preferable research route for the relaxed interface. The partial-summation lemma remains useful as an independent alternative and gives a concrete required psi accuracy. Classical elementary Chebyshev bounds with coefficients around log4 produce an energy constant far above .65 in the existing compact-smoothing calculation. Qualitative elementary PNT supplies no replacement endpoint or epsilon.

## Status

The new contribution is an explicit paper reduction of energy to an all-y psi envelope, with source-based global derivative moments45 and105, a complete low-range bound, and quantified sufficient epsilons. Published corrected tables satisfy the numerical demand but retain finite-zero verification dependencies. The .65 replay, the direct weighted Mellin bound, and every new formal bridge remain uncompiled. No assertion in this note closes the original Goldbach goal.
