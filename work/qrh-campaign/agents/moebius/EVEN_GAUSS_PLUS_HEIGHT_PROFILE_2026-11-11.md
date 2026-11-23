# Even-family plus heights using exact Gauss support

2026-11-11. Conditional paper construction and exact rational witnesses. No analytic, zero, prime or transform value was evaluated; no Lean declaration, build or frozen source was changed. This note proposes one profile. Independent review remains required.

The even Gauss-support fraction permits a further decrease of0.4 in the four even height parameters of the coupled profile. Odd parameters remain unchanged. The resulting full plus residual radius is at most7.58e-7. This fits the original8.85e-7 interface when the common finite-RH certificate also supplies the star statistic. It does not claim the earlier5.75e-7 radius. The direct-B1915 route is not used: ordinary RH through the already dominated star cutoff supplies a much smaller B without that extra source-sieve input.

## 1. One profile, closed spectral domain

Fix R=132900, x>=4.9e26 and y=x/49>=1e25. Put Dc=1063200/qt(c), where qt(c)=2c for odd c and c for even c. Define

    u0(c)=23       for c<100,
          21.5     for100<=c<1000,
          20.5     for1000<=c<10000,
          19.5     for c>=10000.

For odd c>1 use u(c)=u0(c). For4|c use u(c)=u0(c)-.4. The required height is

    Hplus(c)=ceil(200+max(255,3.1416*u(c)*Dc)),
    Hbase(c)=ceil(27000000/c) for odd c,
             ceil(54000000/c) for4|c,
    H(c)=max(Hplus(c),Hbase(c)).                         (1)

All decimals are exact rationals. Require actual GRHUpTo chi H(c) for every primitive nonprincipal character at odd c<=R or4|c<=2R. This retains the closed absolute height boundary, both signs and all nontrivial real zeros. The exact multiplicities are those in the underlying analytic zero carrier. No simplicity or numerical zero list is supplied here. Conductor1 remains the separate principal RH-through1e8 input; conductors of exact2-adic valuation one have no primitive characters.

In fact Hbase<=Hplus throughout this profile:19.1*3*1063200>54000000 and the odd comparison divides both sides by2. Thus the explicit maximum in (1) costs no extra height, while recording the independent base-gap requirement. The star height ceil(max(300,704*Dc/343)) is also smaller, because Hplus>=455 and19.1*3>704/343. These are pre-ceiling comparisons followed by ceiling monotonicity, not rounded sample evidence.

## 2. Why the factor one-half applies to the entire even branch

Use the actual ambient quantity

    t(q,psi)=|tau_q(psi)|*|Schar(psi^-1,coprimePart(q,cP(x)),beta)|/x,
    Eplus(q)=(1/phi(q))*sum_(psi!=1)t(q,psi)^2.

The independently reviewed demand matrix proves the nonzero-Gauss support fraction

    kappa(q)=product_(p^2|q)(1-1/p)-1_(q squarefree)/phi(q).

For4|q, every supported inducing conductor c has the full2-adic exponent of q, hence4|c, and kappa(q)<=1/2. No odd-conductor term with nonzero Gauss weight remains in this branch. For4 not dividing q, no supported even primitive conductor occurs; q=2 times an odd number remains an ambient modulus, with odd ancestors. Inversion preserves the conductor.

Consequently uniform full ambient bounds b_odd and b_even imply

    Eplus(q)<=b_odd^2                       if4 does not divide q,
    Eplus(q)<=b_even^2/2                    if4 divides q.          (2)

This is not an average over primitive conductors and is not a half-support claim at every even q. Both bounds must already include the primitive-to-coprime removal multiplied by sqrt(c). The source proof in ArcChars:378-440 supplies that transfer and the inducing-conductor twist inequality qt(c)<=qt(q).

The matrix review is `prime-estimates/REVIEW_FINITE_RH_CONSUMER_DEMAND_MATRIX_2026-11-11.md`, SHA256 `BF51DF7E0C1B99A59FCECF73941BD18DBA55029700EE2AFB84948B95703B289A`. It independently checks the support and ambient normalization used in (2).

## 3. All four explicit-formula terms

The starting coupled profile is `major-constants/COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md`, SHA256 `6767F9E14E5B6D7264D972085EA9C70359C87544403D37DAE315CBEF2510FC54`. Its four-band shape and conductor-dependent geometric bound are used here; its independent review is separate. This note recomputes both unchanged odd and new even scalar rows.

The present Hplus is no larger than the coupled profile, which is no larger than the independently reviewed fallback Tplus. The fallback's ceiling-safe comparison with the original source endpoints therefore remains available. The positive E1/count functions are monotone in height; this does not assume RH at the original larger endpoint. The source constants give

    sqrt(c)*E1/sqrt(x) < 3.47e-7,
    Z3g<=177.26.

The inequality7.66e6/(2.21e13)<3.47e-7 and (2.21e13)^2<4.9e26 verifies the first uniform scale conversion. The E0/x and vertical terms are unchanged and each at most1e-17 after multiplication by sqrt(c). Their source domains c<=300000, |delta|<=600000 and x>=4.9e26 hold. These estimates descend from the reviewed fallback source proof, not from a blanket PlattGRH wrapper.

For E2 use actual `Thm714.E2_gen_le:101` with T1=255, Z=177.26, C=.09 and IB=2.1768. Every Hplus>=455, and11*4.4<=.09*455*1.2039, so `c3g_le` supplies C. Every u>=19.1>10 supplies the shifted-height ratio. At delta=0 the source EA term is its separate zero branch. Thus no division by a zero twist occurs.

`Thm714.IA_le:210` implies

    IA<=1+3.1416*(|delta|+1)/8.492
       <=a+K/c,     a=1.371, K=393400.

The two coefficient inequalities follow by exact rational arithmetic using |delta|<=1063200/c. This deliberately remains conservative for odd conductors.

For a band L<=c<=U with sl^2<=L and U<=su^2, expanding before bounding c gives

    sqrt(c)*(2Z*IA+2C*IA^2)
      <=(2Za+2Ca^2)*su+(2ZK+4CaK)/sl+2CK^2/(L*sl)=G(L,U).

All coefficients are nonnegative. The bounds therefore hold on the complete band, including all integer conductors and twists, rather than only at test points.

For z>=0 let P(z)=sum_(k=0)^16(z/64)^k/k!. Positivity of the exponential series gives exp(z)>=P(z)^64. The companion verifies

    .892*255 < (4.6e-16)*P(.1598*255)^64,
    .588*u^2 < EA_cap*P(.1065*u^2)^64.

Together with the source monotonicity lemmas these are exact proofs of the EB and EA upper bounds, without an exponential evaluator. The new even rows are:

| Bounding band | u | sl | su | EA cap |
|---|---:|---:|---:|---:|
|4<=c<=100|22.6|2|10|7.16e-22|
|100<=c<=1000|21.1|10|32|6.7e-19|
|1000<=c<=10000|20.1|31.62|100|4.891e-17|
|10000<=c<=265800|19.1|100|516|2.872e-15|

The overlapping closed bounding bands contain the half-open definition bands. In each row the exact source majorant

    129.24*[516*(4.6e-16)*(2Z*IB+2C*IB^2)+EA_cap*G(L,U)]

is less than6.46e-7. The516 in the EB part bounds sqrt(c); it does not count characters. The companion also rechecks the coupled odd rows with their original EA caps and G parameters, giving less than1.49e-7. All source geometric, count and shifted-tail factors remain present.

Adding the low term, both T-independent terms and the inner coprime removal yields

    b_odd <3.47e-7+1.49e-7+2e-17+516e-15 <5e-7,
    b_even<3.47e-7+6.46e-7+2e-17+516e-15 <9.94e-7.     (3)

No direct invocation of the old `errP_le_of` small-E2 guard is used for the larger even error. The four terms of the actual Prop942 error are combined explicitly.

## 4. Residual and complete common-RH composition

Equations (2)-(3) give uniformly

    Eplus < (9.94e-7)^2/2
          =247009/500000000000000000
          =4.94018e-13.

The odd bound2.5e-13 is smaller. With the retained principal error p0=2.83e-7 and outer removal d0=1e-15, the exact orthogonal principal split gives the sufficient test

    Eplus+p0^2 < (rho-516*d0)^2.

It holds at rho=7.58e-7. In particular the older rho=8.85e-7 interface remains valid. The same integrated residual proof gives Z/x<.006^2 and X/x<=8.79; it does not reuse an upper-J theorem whose premise was the smaller old Eplus number.

The common ordinary-RH certificate also restricts to the complete floor300 star carrier. There is no reason to replace its B statistic by the looser direct-B1915 bound for this comparator. The independently reviewed floor300 estimates and remainder bounds give

    QA<=2.321e-19, QB<=1.753e-12,
    sqrt(A)<1.284e-6, sqrt(B)<.004.

The last two inequalities follow by checking7e6*QA<(1.284e-6-8e-9)^2 and7e6*QB<(.004-.00048)^2. They are conditional analytic-count upper bounds under the actual finite-RH premise, not evaluated zero statistics. They hold for every y>=1e25. The source high tails still use only0<beta<1.

An even simpler conservative composition is to weaken these bounds to the previously reviewed A<4e-12 and B<42<62. At rho=8.85e-7 the accepted weighted-principal A4e-12/B62 row gives exactly the old Wstar allowance. Its integrated principal constant1.902e-6 is already a norm and receives no second sqrt(j). The accepted cubic contract then retains the original cubic error and Fourier tail. Thus this candidate does not depend on the new sharper joint-budget calculation to establish sufficiency.

The explicit maximum with Hbase preserves the separately reviewed direct-ghat base-gap argument. The odd profile, principal RH through1e8, exact principal head data, original finite inputs and full Goldbach coverage are unchanged. Natural-R and principal-only source localizations, the final joint R132900 budget and all proof-system validation remain required. No new final hypothesis or verified spectrum is supplied.

## 5. Exact height examples and scope

| c | Coupled profile | This profile | Hbase |
|---:|---:|---:|---:|
|4|19206058|18872043|13500000|
|100|718333|704972|540000|
|1000|68674|67337|54000|
|10000|6714|6580|5400|
|60000|1286|1264|900|
|100000|852|838|540|
|125000|722|711|432|
|265800|455|455|204|

These are rational ceiling values, not a spectral computation. Floor-controlled heights need not decrease. No operation-count, auxiliary-height, sign-success or runtime reduction is inferred. This is one coherent profile, not a search for an optimum. Further odd changes or a different rho allocation require their own complete estimates.

Own `even_gauss_plus_height_20261111.py`, SHA256 `0A2F8DE733652B502BE6F630273364FA07136A663FB8372DF6D9472AB8342079`, checks51 exact assertions and11 height examples. Its JSON SHA256 is `EEFA6D42ACF703E65C456BA8DC2A6F678F20E288983E5CCD4CB0B85CDDD392AB`. The receipt binds ten source/predecessor files, including the actual E2 and ambient transfer source. No author script was imported or executed. The sole new analytic argument is the displayed positive-polynomial majorization and its combination with those source inequalities; actual finite-RH certification and formal implementation remain open.
