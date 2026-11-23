# Joint twist/zero-height L2 route for the principal character

Status: all2750 finite-height interval inequalities have now passed a rigorous Arb/Acb computation, closing the numerical gap in the bound85. The weighted-mass and outer-height constants also have exact rational calculation checks. The analytic reductions and their Lean formalization remain separate obligations. No Lean compiler was launched. This note does not claim the principal error theorem or the full10^27 target kernel-checked.

The meaningful new target is a fixed compact-smoothing Gram inequality on 0≤gamma≤250. If its explicit bound85 is certified, the actual etaPlus principal error on delta in[-4,4] satisfies the lower-major-energy budget, assuming genuine GLOBAL QRH beta≤7/8. Local .996 or23/24 zero-free bounds cannot replace that assumption.

## Required size and why ordinary Plancherel is insufficient

Write X0=4.9e26 and E(delta,x)=S_etaPlus(delta/x,x)/x-Fourier(etaPlus)(-delta). The sufficient lower-energy target in agents/prime-estimates/L2_REPLACEMENT.md is

    integral_{-4}^4 |E(delta,x)|² ddelta ≤8e-6,  x≥X0.

At x=X0, removing the QRH factor x^(-1/4) from this squared norm leaves allowance37.6390806444, or norm about6.135. A bound85 times weighted zero mass.07 gives norm5.95 and squared error

    85²*.07²*X0^(-1/4) =7.5246258716e-6.

For one zero, Fourier Plancherel in delta gives exactly

    integral_R |M(beta+i gamma,delta)|² ddelta
      =integral_0^infinity etaPlus(r)²*r^(2beta-2)dr.

It is independent of gamma. Consequently full-line Plancherel alone discards the localization in[-4,4] which excludes the stationary phase at large gamma. Summing its diagonal terms over all zeros diverges, and replacing coherent clusters by a square-root zero count would be invalid. The route below retains the restricted-delta Gram operator and controls clusters by a positive weighted mass, without spacing assumptions.

## A multiplicity-sensitive positive mass from existing source

For a nontrivial zeta zero rho=beta+i gamma, set

    w2(rho)=(2-beta)/((2-beta)²+gamma²).

The standard identity is

    W2=sum_rho m(rho)*w2(rho)=Re(xiF'/xiF)(2).

For the argument it suffices to prove the corresponding inequality for every finite set of zeros, so no independent global enumeration theorem is needed. The source `Explicit/XiPartial.lean:777`, xi_partial_approx, supplies finite-square partial fractions with arbitrary error and includes every zero in any fixed ball. Apply it at s=2, take real parts, and use positivity of w2 for every xi zero (0<beta<1). Enlarging a fixed finite zero set then gives its total weighted mass at most Re(logDeriv xiF 2). Multiplicities remain in every sum. Exact multiplicity transport between the explicit-formula zeta rectangles and xi squares is available in `Explicit/WeilBridge.lean`, multRectD_eq_mult; conjugation/reflection invariance of orders still needs an explicit bridge.

`Explicit/Xi.lean:142`, logDeriv_xiF, and the logarithmic derivative of zeta give

    Re(logDeriv xiF 2)
      =3/2-(log pi)/2-EulerGamma/2-sum_{n≥1}Lambda(n)/n².

The pole-removing factor zetaF contributes1/(s-1); missing this term would change the constant by1.

The script `joint_principal_model.py --mass-only` checks a rigorous rational bound on the right-hand expression. It uses

    EulerGamma > H_1000-log1001,
    log pi > log(314159/100000),
    sum Lambda(n)/n² ≥sum_{p≤2000} log p/(p²-1).

There are303 primes in the last finite sum. Every log is enclosed by an exact rational atanh-series enclosure after power-of-two range reduction; no floating logarithm enters the inequalities. It obtains

    EulerGamma lower bound: .5767160812351243...,
    finite prime contribution lower bound: .5694650072033857...,
    W2 upper bound: .06981243158646303... <.07.

Printed decimals are presentations of rationally proved comparisons, not replacement constants. The analytic identities, finite primality certificate, and bridge to Lean are still required. The prime-estimates worker has a cheaper alternative using333 prime-power terms n≤2000 and existing Small.chkLow bounds, giving W2≤.0698425. Either is enough.

This is stronger information than the crude Jensen interval counts. It is derived from already proved partial fractions and positivity, not assumed zero spacing or an inserted result-shaped premise.

## Exact quartet, phase, and degeneracies

Under global QRH and the functional equation, group zeros into orbits with representative1/2≤beta≤7/8 and gamma≥0. The usual four points are beta±i gamma and1-beta±i gamma, with equal multiplicity. Their total mass per unit multiplicity is

    w(beta,gamma)
      =2(2-beta)/((2-beta)²+gamma²)
       +2(1+beta)/((1+beta)²+gamma²)
      ≥6/(gamma²+225/64).

Let M_sigma,gamma(delta)=integral etaPlus(r)*r^(sigma-1+i gamma)*exp(2pi i delta r)dr. After factoring x^(7/8), the quartet sum is the Fourier transform, with positive exponent, of the REAL function

    2*x^(beta-7/8)*etaPlus(r)
      *(r^(beta-1)+x^(1-2beta)*r^(-beta))
      *cos(gamma log r+gamma log x).

In particular the reflected pair has the SAME phase, not its negative. The delta interval is symmetric. For the compact smoothing etaO at sigma=7/8, define

    D(gamma)=integral_{-4}^4 |M^O_{7/8,gamma}(delta)|² ddelta,
    C(gamma)=integral_{-4}^4 M^O_{7/8,gamma}(delta)
                                   *M^O_{7/8,gamma}(-delta) ddelta,
    N0(gamma)=sqrt(2D(gamma)+2|C(gamma)|).

Then N0 is the exact maximum over phase phi of the restricted-delta norm of

    exp(i phi)M^O_{7/8,gamma}(delta)
      +exp(-i phi)conj(M^O_{7/8,gamma}(-delta)).

Equivalently this is the largest eigenvalue of the2x2 cosine/sine Gram matrix, with the appropriate square root. Maximizing over phi makes the bound uniform in x. There is no cancellation assumption between distinct zero orbits; their norms are added using the positive weighted mass.

When beta=1/2, the virtual quartet repeats each point twice. Assign this virtual orbit coefficient m/2 so its zero sum and weighted mass equal the actual pair. If gamma=0, apply the analogous halving for conjugation; at beta=1/2,gamma=0 the coefficient is m/4. Rational positive orbit coefficients are harmless. This also permits covering gamma=0 directly without relying on a zero-free gap. The proposed unconditional2.39 gap remains uncompiled and is NOT needed by this route if the compact certificate covers[0,250]. Restricting that certificate to[2.39,250] would instead require the gap theorem first.

## Keeping the actual etaPlus smoothing

The source-derived pointwise Fourier-tail bridge, still needing Lean formalization, is

    |etaPlus(r)-etaO(r)|≤epsilon*r*exp(-r²/2), epsilon=.00221.

It follows from the existing g'' energy368 and full/truncated Fourier inversion; see PointwiseSmoothingTail.md. Thus it retains the complete Gaussian tail and the actual H=200 bandlimit.

For1/2≤sigma≤7/8, full-delta Plancherel gives

    ||M^Plus_sigma,gamma-M^O_sigma,gamma||_{L2(delta in R)}
      ≤epsilon*sqrt(integral r^(2sigma)exp(-r²)dr)
      ≤epsilon/sqrt2.

The last step uses weighted AMGM between r and r², whose Gaussian integrals are1/2 andsqrt(pi)/4≤1/2. Therefore the leading conjugate pair costs less than.00313 in norm on[-4,4], uniformly in gamma and phase. This perturbation must only be used at bounded gamma: division by w would otherwise grow quadratically.

## Eliminating the beta and x dimensions on the compact interval

The compact formula is etaO(r)=[r(2-r)]³ exp(-(r-1)²/2) on[0,2], zero elsewhere. By Plancherel in delta,

    ||partial_sigma M^O_sigma,gamma||_2²
      =integral_0^2 etaO(r)²*r^(2sigma-2)*log²r dr <.313²

uniformly1/2≤sigma≤7/8. An exact elementary certificate is

    integral_0^1 r^5(2-r)^6 log²r dr
      +integral_0^1 y²(1-y²)^6dy
      =19896184597/266250045600+1024/45045
      =.09746026381987884... <.313².

The first integrand majorizes the original on r≤1; on1≤r≤2 use r^(2sigma-2)≤1, log r≤r-1 and discard the Gaussian. The script checks this rational inequality exactly.

Put d=7/8-beta and A=N0(gamma)+.00313. The leading scaled pair has norm at most

    exp(-61d)*(A+.626d),

because log x≥log X0>61. Its maximum for d≥0 is the explicit function

    F(A)=A                                      when A≥.626/61,
         (.626/61)*exp(-1+61A/.626)              otherwise.

Using d≥0 rather than0≤d≤3/8 weakens the estimate safely. The reflected pair has exponent1/8-beta≤-3/8; the coarse source Gaussian envelope gives norm at most6*x^(-3/8)<1e-9. Hence the following SINGLE-VARIABLE certificate is sufficient on0≤gamma≤250:

    Cstar(gamma)
      :=(gamma²+225/64)/6*(F(N0(gamma)+.00313)+1e-9) ≤85.       (COMPACT)

This is a concrete inequality for an explicitly defined compactly supported elementary function. It is not an assumption inserted in a final theorem: proving it is the remaining analytic/numerical obligation. Every dependence on beta, phase, x, and the etaPlus tail has been bounded above explicitly.

## Exploratory calculation, including a failed coarse grid

Commands:

    python joint_principal_model.py --mass-only
    python joint_principal_model.py --fine
    python joint_principal_model.py --log-grid

The last two use ordinary floating-point Simpson quadrature, not intervals. The fine linear-r scan samples gamma every.25 up to60, then every5 up to250, with1024 r panels and256 delta panels. Its largest sampled Cstar is83.170747 at gamma26.5. An independent logarithmic-r grid from u=-16 tolog2 with8192 panels gives83.170751 there. The omitted logarithmic tail and Simpson errors have not been certified.

| gamma | N0 from logarithmic grid | Cstar sampled |
|---:|---:|---:|
| 0 |1.60866064246|.94441|
| 10 |1.13478509729|19.6320|
| 20 |.99032733590|66.8126|
| 25 |.78145472628|82.1873|
| 26.5 |.70393830423|83.1708|
| 30 |.51601495176|78.1759|
| 40 |.13729485666|37.5289|
| 60 |.00518184419|5.09657|
| 100 |.00007555600|8.60219|
| 150 |.00000744101|19.2231|
| 200 |.00000190794|34.1537|
| 250 |.00000071456|53.3572|

The unqualified default512-panel linear-r grid falsely suggests Cstar≈158 at gamma250. Refining and moving to log r exposes this as oscillatory quadrature aliasing. This is an explicit reason not to treat any grid maximum as a certificate.

A practical certificate can use the rigorous gamma-Lipschitz estimate

    |N0(gamma)-N0(gamma')|≤.626*|gamma-gamma'|,

which follows from the same logarithmic moment bound. The existing quarter-height scan is too coarse for the1.83 margin: its Lipschitz allowance near26.5 can exceed9 after the weight. A mesh of step.01 has norm allowance.00313; together with a certified node quadrature error≤.0001 this adds about.38 near the sampled maximum, leaving usable margin. One must still actually produce node enclosures and verify the weighted upper bound on EVERY mesh cell, using the upper endpoint for gamma² and F's monotonicity. Faster interval-specific quadrature or an analytic nonstationary-phase bound for100≤gamma≤250 may reduce certificate size. The subsequent native Arb/Acb implementation below has now produced the complete interval certificate; the floating-point script remains exploratory.

## All gamma≥250: separate contour argument with rational checks

This part uses the NEW signed-contour/Fourier-tail derivation in TwistBounds.md, not the existing norm_mellin_fP_tail theorem (whose threshold at delta4 is larger than325). It applies to the actual etaPlus transform for all1/8≤sigma≤7/8 and|delta|≤4.

Choose theta=.17. Then c=cos(.34)≥.94 and b≤8pi*.17≤8*(22/7)*.17. Completing-square bounds give R<260000, so W(B)R<800000, using the source-derived Fourier L1 bound W≤3.01. For250≤gamma<400 choose B=gamma/2. For gamma≥400 choose B=200, where the Fourier tail is empty. Consequently

    |M(sigma+i gamma,delta)|
       ≤4sqrt184/gamma²+800000 exp(-.085gamma),   250≤gamma<400,
       ≤800000 exp(-.17(gamma-200)),             gamma≥400.

For the whole quartet the scaled coefficient sum satisfies

    x^(beta-7/8)+x^(1/8-beta)≤1+x^(-3/4).

This follows by convexity on beta in[1/2,7/8]; the endpoint at1/2 is bounded by1+x^(-3/4) using2sqrt u≤1+u. Thus the quartet norm divided by w is bounded by

    (sqrt8/3)*(gamma²+225/64)*(1+x^(-3/4))*the_displayed_M_bound.

The parent-provided `work/qrh-campaign/principal_high_height.py` checks all required arithmetic with Fractions and Taylor remainders. In particular exp10<22027, exp21.25>1.69e9, W R<800000, sqrt184<13.565 andsqrt8<2.829. For x≥10000 the coefficient factor is≤1.001. Each weighted exponential decreases on its stated range. The resulting upper ratios are79.15011 on[250,400] and71.49548 on[400,infinity), both below80. The latter uses a deliberately weak exponent comparison at400.

These are rigorous paper implications of the contour/Fourier-tail lemmas and exact rational arithmetic. Those new analytic lemmas are not yet Lean-checked. A fixed1e-9 reflected-pair error must NOT be used at arbitrarily large gamma; the displayed coefficient sum keeps its contour decay instead.

## Explicit formula, convergence, and leftover terms

If(COMPACT) is proved, the quartet norm is≤85w at every height. Triangle inequality over orbits, with their actual multiplicities, gives

    ||sum_rho m(rho)x^(rho-7/8)M(rho,delta)||_{L2[-4,4]}
      ≤85W2≤5.95.

The weighted mass also proves absolute convergence in this Hilbert space. It justifies passing to the source explicit-formula rectangle limit without any assumed cancellation between different orbits.

The unconditional starting formula is `explicit_formula_zeta`, used in `Explicit/ExplicitBoundGen.lean:191`. Its pole term is exactly x*M(1,delta), matching Fourier(etaPlus)(-delta). The contour is moved to real part-1/2. Nontrivial zeros lie inside; negative even trivial zeros do not. There is no zero at0: zetaF(0)=1/2, already proved in `Explicit/ZetaZeroSums.lean:36`. Thus the generic G0*Z3g term can be eliminated in this principal specialization instead of being mistaken for a missing zero contribution.

The remaining vertical integral is controlled unconditionally by `norm_integral_hZeta_le_gen` and `VgL` in ExplicitBoundGen.lean:28ff. For|delta|≤4, thetaD=.28/(1+|delta|)≥.056, hence thP=.005. Existing constants give Kv=Cg*(300e)*(2aH)<106000. Therefore

    VgL(3,Kv,.005)/(2pi)<3e10.

After division by x the vertical error is at most3e10*x^(-3/2) pointwise, or less than1e-28 in L2[-4,4] for x≥X0. This is far below the norm gap between5.95*X0^(-1/8) andsqrt(8e-6). If one retained a spurious generic zero-origin bound instead, it would also be tiny after division by x, but eliminating it is cleaner and source-faithful. Prime-power removal is not needed here because S uses the same von Mangoldt coefficients as the explicit formula; the lower-energy argument separately accounts for the already bounded coprime removal.

The bound improves as x increases: the zero factor is x^(-1/8), beta suppression was bounded with log x≥61, reflection suppression was bounded at X0, and the vertical error decays as x^(-3/2). There is no hidden bounded-x window.

## What this changes and what remains

This route gives a quantitatively plausible replacement for the principal lower-major-energy input. It replaces a difficult pointwise .001 demand by an explicit compact Gram certificate with observed margin, while retaining actual smoothing tails and unrestricted zero multiplicities.

The remaining proof obligations are: positive weighted-mass extraction and numerical bridge; multiplicity-preserving orbit grouping; pointwise smoothing/Fourier L1 and signed-contour lemmas; the continuous interval certificate(COMPACT); Hilbert-space convergence and the unconditional explicit-formula specialization. The sampled83.1708 alone is not a proof; the separate complete interval computation recorded below establishes the finite inequalities for85.

Even after those tasks, the full10^27 ternary Goldbach target remains open in this campaign. This only supplies the independent lower J input, not the nonprincipal upper-energy estimates, the broad-twist principal cubic terms, or the etaStar/cross-term budgets. No conclusion about them follows from a norm restricted to[-4,4]. The global QRH theorem and its genuine dependency audit also remain separate from this calculation.

## Refinement: explicit finite certificate on [16,75]

The following additional paper bounds reduce(COMPACT) to2750 precisely specified interval checks. The script's elementary_interval_certificate verifies the rational arithmetic and Taylor comparisons below. The separate joint_principal_certificate.py now evaluates and passes all2750 checks using Arb/Acb.

### The two analytic outer ranges

Full-delta Plancherel and the elementary bound on etaO give

    N0(gamma)²≤4*(1255/2772+1024/3003)<1.8².

Indeed on r≤1 majorize etaO²*r^(-1/4) by r^5(2-r)^6, and on1≤r≤2 majorize it by[r(2-r)]^6. These integrate to the two rational numbers. It follows directly that Cstar<77.991 on0≤gamma≤16.

For large gamma there is a useful contour estimate for the COMPACT smoothing itself. Its Mellin integrand is

    z^(23/8+i gamma)*(2-z)^3*exp(z-1/2-z²/2+2pi i delta z).

Rotate the segment[0,2] to angle1/2, retaining the circular connecting arc z=2exp(i alpha),0≤alpha≤1/2. The branch at0 causes no difficulty because the real power is23/8>−1. The ray has absolute integral at most

    262*exp(27-gamma/2).

To see this, |2-z|³≤64, integral_0^2 r^(23/8)dr≤49/12, and the exponential real part excluding−gamma/2 is≤3/2+8pi<27. On the arc, |2-2exp(i alpha)|³≤8alpha³; |z^(23/8+i gamma)|≤8exp(−gamma alpha); |dz|=2dalpha; and

    Re(z-1/2-z²/2)≤1/2,
    |exp(2pi i delta z)|≤exp(16pi alpha).

Since exp(1/2)<1.65, the arc is bounded by1268/(gamma−16pi)^4 for gamma>16pi. Thus

    N0(gamma)≤2sqrt8*[262exp(27-gamma/2)+1268/(gamma−16pi)^4].

This contour step is new and uncompiled, but its finite-segment geometry and all constants are explicit. It is not an application of the whole-ray Gaussian contour formula without an endpoint term: the connecting arc is essential.

Use F(N+e)≤N+F(e), where e=.00313. A cubic Taylor lower bound shows

    F(.00313)≤(.626/61)*.51.

The products(gamma²+225/64)exp(−gamma/2) and(gamma²+225/64)/(gamma−16pi)^4 decrease for gamma≥75. With pi≤22/7, exp(10.5)>36000, and exp23>1e9, exact rational arithmetic gives

    Cstar<65.395 on[75,100],
    Cstar<56.483 on[100,250].

Together with the actual-etaPlus high contour bound, the sole remaining numerical interval is[16,75].

### Mesh and exact node obligations

Partition[16,40] into2400 cells of width.01 and[40,75] into350 cells of width.1. For each cell[a,b], let g=(a+b)/2 and h=(b-a)/2. Compute a CERTIFIED upper bound U_g≥N0(g). The exact cell obligation is

    ((b²+225/64)/6)
      *[F(U_g+.626h+.00313)+1e-9] ≤85.                 (CELL a,b)

It implies(COMPACT) throughout the cell by the proven.626 Lipschitz bound and monotonicity of F. Every coefficient and endpoint in(CELL) is rational except the explicit exponential in F. There are2750 obligations. The coarse exploratory grid does not prove any missing cell; a failing or unresolved interval evaluation must be retained as a failure.

### A rigorous quadrature design with explicit errors

This provides an implementable checker specification without depending on undocumented accuracy of machine sin, exp, or log.

For fixed g and real delta, truncate the u=log r integral at u=-4 and integrate to log2. The omitted tail contributes less than2.2e-6 to the CONJUGATE-PAIR L2 norm on[-4,4], because

    2sqrt8*integral_0^{exp(-4)}8r^(23/8)dr
      =2sqrt8*(64/31)*exp(-15.5)<2.2e-6.

Call the truncated transform Mtr. Its integrand is the entire function of u

    H_g,delta(u)=exp((31/8+i g)u)*(2-exp u)^3
                *exp(exp u-1/2-exp(2u)/2+2pi i delta exp u).

Use47 equal panels on[-4,log2], each of width<.1, and26-point Gauss-Legendre quadrature on each panel. For every complex u in the disk of radius.2 around a panel center, g≤75 and real|delta|≤4 give

    |H_g,delta(u)|<1e18.

For example |exp u|<2.45, the algebraic factor is<37*89, exp(g*|Im u|)<3.3e6, and the remaining exponential has real part<17.3, hence norm<3.3e7. Their product is<1e18.

A positive quadrature rule exact through degree n-1 on a panel of half-width h has error at most

    2*(panel length)*M*(h/R)^n/(1-h/R)

when the integrand is analytic and bounded by M in the radius-R disk. This follows by applying the Cauchy coefficient estimate to its Taylor remainder; both the integral and the positive rule have total mass equal to the panel length. Here n=52,h/R≤1/4,total length<5, so the combined u quadrature error is at most

    2*5*1e18*2^(-104)/(1-1/4)<6.574e-13.

Evaluate the algebraic Gauss nodes/weights and all elementary functions with outward interval arithmetic, so each Mtr value is enclosed with radius at most1e-12 after including this analytic error. This is a required checker tolerance, not a property claimed for the current float script.

To integrate the two Gram entries in delta, use a SINGLE180-point Gauss-Legendre rule on[-4,4]. The analytic extensions

    Mtr(z)*conj(Mtr(conj z)),
    Mtr(z)*Mtr(-z)

are bounded by1e90 on|z|≤8: |Mtr(z)|≤3exp(32pi), and9exp(64pi)<1e90. The same Taylor argument, with n=360,h/R=1/2 and length8, gives error

    2*8*1e90*2^(-360)/(1-1/2)<1.363e-17

for each Gram entry. On the real integration nodes|Mtr|≤3, so the1e-12 transform enclosures introduce less than5e-11 additional error in each integrated product. Isolate the Gauss nodes as the roots of the exact Legendre polynomial and the weights as

    2/((1-z_j²)*P_n'(z_j)²),

then propagate their interval enclosures outward; this avoids treating tabulated floating nodes as exact. The final U_g is

    sqrt(2*upper(Dtr)+2*upper(abs(Ctr)))+2.2e-6.

The total analytic/enclosure error in this norm is below2e-5 if the stated transform tolerance is met. The exact CELL check uses the interval U_g itself, so it need not rely on this summary error estimate.

A direct implementation entails about2750*47*26*180≈605 million complex quadrature products. The elementary-function values factor into a g-by-u table and a delta-by-u table and should be cached; the remaining product is an interval matrix multiplication. This cost is substantial for a naive pure-Python Decimal implementation. The initial pure-Python cost concern was resolved by caching the twist matrix and using native Acb matrix multiplication; the completed run below took52.43 seconds on one thread. The exploratory script remains separate from the interval checker. Increasing precision never authorizes accepting a cell whose interval still crosses85.

The2750(CELL) inequalities are now computationally certified. The remaining task is to formalize the analytic quadrature and contour lemmas and connect the verified inequalities to the Lean theorem. No unknown zero locations, spacings, multiplicities, or conclusion-shaped hypotheses enter these finite checks.


## Completed interval certificate

`joint_principal_certificate.py` ran to exit0 in52.4272877 seconds with python-flint0.9.0,128-bit Arb precision and exactly one FLINT thread. It used native Acb matrix multiplication, not floating BLAS. A cached1222-by180 twist matrix and batches of32 height rows kept memory bounded. No machine float participates in an acceptance comparison; floats are used only for elapsed-time reporting.

All2750 cells passed. The largest rigorous upper bound is

    83.571300905827202546089902080922956536 <85,

at cell1054, [26.54,26.55]. This includes the analytic u-quadrature error, delta-quadrature error, small-r truncation, height interpolation, actual etaPlus Gaussian remainder, beta reduction, and reflected-pair allowance. The outward Arb computation also propagates uncertainties in Gauss nodes, weights, log2 and all elementary functions. It does not assume that128-bit working precision automatically yields a given error radius.

Evidence files in this directory:

- `joint-principal-cells.jsonl`: header, all2750 cell records, progress and final PASS_ALL_2750 summary.
- `joint-principal-cells.exit`:0.
- `joint_principal_certificate.py`: exact checked source SHA256 `3f511989a4e0f9f4d9206ceaf5c61ccda80a30303c87484d6292b0cb42e57a67`.
- Canonically sorted cell-record aggregate SHA256 `06d59f3d77455c573f3ce4d52cfe381c5dc4a3307b40cd946f003aa102795ed7`.

The local python-flint API documents Legendre roots in decreasing order; exact Legendre parity then gives z_(179-j)=-z_j, justifying the reversed index used for C. The corresponding reflected weights agree. The implementation uses each actual ball output and inserts the analytic integration-error ball before forming the Gram products. Native Acb multiplication performs rigorous ball arithmetic. Relevant primary documentation: [Arb real balls and Legendre roots](https://python-flint.readthedocs.io/en/stable/arb.html), [Acb matrices](https://python-flint.readthedocs.io/en/latest/acb_mat.html), and [global context/thread setting](https://python-flint.readthedocs.io/en/latest/general.html).

A simpler rational final-budget bridge is available for Lean:2125^8=415787544310092926025390625<X0, so the zero-sum norm is at most85*.07/2125=.0028. The vertical norm is far below.00001. Hence the whole principal error norm is below.00281, and(.00281)^2=.0000078961<8e-6. This avoids relying on the displayed floating value7.5246258716e-6.

This is a completed COMPUTATIONAL certificate of the explicit finite inequalities, coupled to source-faithful paper reductions. It is not a new Lean proof, a proof of global QRH, a verification of any zero locations, or a completion of the nonprincipal/cubic estimates. The parent and independent statement auditor are checking the full record sequence, hashes, and analytic dependencies separately.
