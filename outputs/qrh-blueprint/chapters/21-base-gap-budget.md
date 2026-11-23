# Variable base-gap allowance from the actual ghatY formula

For every y>=10^25, the explicit source formula gives the following paper bounds:

    ghatY(y,150000) > .04712,
    y^(1/8) * (ghatY(y,150000)-.000481-.000001098) >79.

The second bound permits any proved normalized aggregate of the form C*y^(-1/8), C<=79, after reserving .000481+.000001098 for the two stated non-spectral errors. It does not prove that spectral aggregate. Both bounds use lower estimates directly from the definition. The source's c0_g0 upper bound .060272 is never treated as a lower bound.

All scalar certificates in base_gap_variable_budget.py use exact rational arithmetic. Its printed decimals are diagnostics. The analytic monotonicity proof is below; neither it nor the rational certificates has been compiled in Lean. Sources remain read-only.

## Source formulas

At the pinned ternary-goldbach source:

- PointwiseBound.lean:26 defines R(y,t).
- GBound.lean:25,29,33 define Fr, Lg and gx.
- LinftyLevels.lean:351 defines ghatY.
- NumericsCells.lean:10, c0_g0, proves ghatY(10^25,150000)<=.060272.

Set n=150000, t=log(y), H=log(1200000), and

    v(t)=t/3+log(9/601200).

The source R at 2n is

    R(t)=.41415+.27125*log(1+H/(2v(t))).

The remaining definitions are

    F=exp(gammaEuler)*log(log(n))+2.50637/log(log(n)),
    Lg(2n)=F*((13/4)*log(2n)+7.82)+13.66*log(2n)+37.55,
    gx(y,n)=((R(t)*log(2n)+.8764)*sqrt(F)+2.526)/sqrt(2n)
              +Lg(2n)/n+3.8*y^(-1/6),
    ghatY(y,n)=1.398*max(gx(y,n),hfun(y))+17*(670/n)^3/3.

The lower bound uses max(gx,hfun)>=gx and discards the two nonnegative terms involving y^(-1/6) and (670/n)^3. No bound on hfun is needed.

## Certified rational constant choices

Let

    cLo=2.478081, cHi=2.478088,
    F0=1.78*cLo+2.50637/cHi,
    sF=2.3286, sq=547.723, ell=12.61153,
    L0=F0*((13/4)*ell+7.82)+13.66*ell+37.55,
    a=1.398*ell*sF/sq,
    b=1.398*((.8764*sF+2.526)/sq+L0/150000).

All are exact rationals. Their diagnostic values are

    F0=5.422397011182751...,
    L0=474.4769928073843...,
    a=.0749564247688777...,
    b=.0160783194627960... .

The script verifies

    log(log(150000)) in[cLo,cHi],
    log(300000)>=ell,
    sF^2<=F0, sq^2>=300000,
    .07<=a<=.076.

To prove exp(gammaEuler)>1.78, it uses the existing Mathlib theorem Real.eulerMascheroniSeq_lt_eulerMascheroniConstant, NumberTheory/Harmonic/EulerMascheroni.lean:158. The finite lower sequence is

    H_5000-log(5001)>.5771156815...>.577.

The positive Taylor sum through degree11 for exp(.577) is greater than1.78. Thus exp(gammaEuler)>1.78. This is a finite analytic certificate, independent of prime estimates, zero verification or PlattGRH.

The logarithm certificate reduces a positive rational q to q=2^k*r, 1<=r<2, then uses z=(r-1)/(r+1):

    log(r)=2 sum_(j>=0) z^(2j+1)/(2j+1).

The first32 terms are a lower bound; the omitted tail is at most

    2*z^65/[65*(1-z^2)].

The same certificate bounds log2 and handles k of either sign with directed endpoints. Nested logs use monotonicity. All comparisons in the script are between fractions.

For y>=Y=10^25, y^(1/3)>=200000000. Since

    log(9*200000000/601200)>8,

we have v(t)>8. Also 0<H<14. Hence R(t)>=.41415. The source formula and the constants above give

    ghatY(y,150000)>=a*R(t)+b.

The exact rational check a*.41415+b>.04712 proves the uniform lower bound. Its more precise value is .04712152278082669... .

## The scaled lower envelope is increasing

Put epsilon=.000481+.000001098=.000482098 and

    f(t)=exp(t/8)*(a*R(t)+b-epsilon).

Differentiation gives

    R'(t)=-.27125*H/[3*v(t)*(2*v(t)+H)],
    f'(t)=exp(t/8)*[(a*R(t)+b-epsilon)/8+a*R'(t)].

Because v>=8 and H<=14,

    |R'(t)| <=.27125*14/(3*8*16)<.01.

The expression in brackets is bounded below by

    .07*.41415/8-.076*.01-epsilon/8
      =.00280355025>0.

We discarded positive b/8. Consequently f is strictly increasing for t>=log(Y). This proves the all-y claim using a lower envelope; it does not require proving that the full ghatY itself, or its max branch, has a derivative.

## Endpoint certificate

For Y=10^25, the exact integer inequality

    200000000^3<=Y<=215443470^3

bounds the cube root. Therefore

    v(logY)<=log(9*215443470/601200)<8.078750753386,
    R(logY)>.5834038640503739... .

The script uses the exact directed logarithmic endpoints, not these rounded numbers. They imply

    a*R(logY)+b>.05980818730836040... .

The exact rational1333.5 satisfies1333.5^8<10^25. Thus

    f(logY)>1333.5*(.05980818730836040...-.000482098)
             >79.1113400926986...>79.

Again, the executable assertion uses the exact rational lower expression, not the printed decimal. Monotonicity then proves

    y^(1/8)*(ghatY(y,150000)-epsilon)>79

for every y>=10^25. At Y, a normalized error79*Y^(-1/8) is approximately.05924164. The available actual-envelope slack is larger; the lower certificate leaves a deliberate margin.

## Minimal fallback from existing coarse constants

Even without the new Euler-constant certificate, the proof inside MinorTotal.gx_r0_ge already supplies log300000>=12.6, sqrt(F)>=1.949, sqrt300000<=548 and Lg300000>=394. Strengthening its R>=0 to the immediate R>=.41415 gives

    ghatY(y,150000)
      >=1.398*[((.41415*12.6+.8764)*1.949+2.526)/548+394/150000]
      =.04041945597149635...>.0404.

This requires only positivity of the inner logarithm, already supported by the same y-range argument. It is an easy first lower-bound lemma if the stronger finite certificate is deferred.

## Consumer implication and limits

A new base-gap proof may replace the old uniform .0121*y target by the actual y*ghatY(y,150000) target used in MinorTotal. The implication is

    |S_etaStar|/y <= .000481+.000001098+C*y^(-1/8), C<=79
      implies |S_etaStar| <= y*ghatY(y,150000).

All characters, Gauss weights, primitive-to-imprimitive corrections and nonprincipal terms must already be included in C. This note supplies the consumer's allowance only. It does not turn a one-character error into the required aggregate, and it does not show that a positive detector bound meets C<=79.

The uniform bound>.04712 separately permits a proved pointwise base-gap envelope<=.04712*y. The independent-feasibility worker is checking such a branch. The two routes can coexist, using the sharper one wherever appropriate.

The same ghatY function still appears in the existing minor numerical sum. No upper envelopes, cell data, major/minor constants or final positivity budgets change. The corrected final budget remains major1.0404, minor1.0376, nonprime reserve.00271. This work only removes waste in comparing the base-gap bound with its existing consumer envelope.
