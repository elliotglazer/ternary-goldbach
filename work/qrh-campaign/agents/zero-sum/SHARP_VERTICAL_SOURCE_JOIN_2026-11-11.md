# Sharp vertical bounds for the actual smoothings

Source-supported paper proof, 2026-11-11. No Lean declarations, builds, numerical evaluator runs, scans or frozen-file changes were made. The source is `work/ternary-goldbach` at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

The selected etaU constant 900 is valid on the vertical line Re(s)=-1/2. Its proof uses the actual multiplicative convolution, an eta2 moment, and the source Gaussian estimate with the twist delta*r. The source's stronger bound 112 in fact gives a vertical constant below 308. EtaPlus has a different Mellin argument, shifted by -1, and needs the extended Gaussian domain; the selected constant 106000 follows from its existing source theorem. None of these bounds is obtained by substituting the potentially enormous qualitative GoodSmoothing constant into the numerical error budget.

The earliest missing join was the passage from the actual etaU integral to a sharp vertical-line envelope with the correct moment and twist. Sections 1-3 give that passage. Section 4 supplies the precise source integral and normalization interface. The optional improvements 308 and 216 below are not substituted into any frozen numerical packet.

## 1. Actual Mellin identity and domains

Use the actual source definitions

    phi(v)=v^2 exp(-v^2/2),
    f_U(delta,t)=etaU(t) exp(2*pi*i*delta*t),
    M_U(s,delta)=mellin(f_U(delta))(s),
    thetaD(delta)=.28/(1+|delta|).

The reviewed `major-constants/ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md`, Section 4, proves on paper, for real delta and Re(s)>-2,

    M_U(s,delta)
      = integral_[1/4,1] eta2(r) r^(s-1) Gr(s,delta*r,0) dr.  (1)

The equality uses absolute Fubini before swapping the original convolution and the substitution t=r*v. The source Gr is the Mellin transform of phi(v)exp(2*pi*i*delta*r*v). It is not Gr(s-1,...). In the equivalent dr/r measure the factor is r^s; in (1), with dr, it is r^(s-1). All powers use positive real r and the real logarithm. Eta2 is nonnegative and supported in [1/4,1].

For completeness, the absolute integrand before Fubini factors into eta2(r)r^(Re(s)-1) and v^(Re(s)+1)exp(-v^2/2). The r integral is finite because its support is compact and bounded away from zero. The v integral is finite exactly for Re(s)>-2. Thus (1) holds at s=-1/2+i*t and at s=0 for every real delta,t, independently of any zero location.

The same reviewed note proves qualitative GoodSmoothing with a full-strip constant such as 3*Kdelta(delta). That is a separate input to the explicit-formula limit. It does not replace the quantitative constants below.

## 2. EtaU: the precise moment proves 900, and even 308

For 1/4<=r<=1, positivity of the denominator gives

    |delta*r|<=|delta|,
    thetaD(delta*r)>=thetaD(delta)>0.                       (2)

At s=-1/2+i*t, the norm of r^(s-1) is r^(-3/2)=1/(r*sqrt(r)). The source theorem `MajorArcs/Eta2Moments.moment_3half:176` gives

    integral_(r>0) eta2(r)/(r*sqrt(r)) dr <= 2.74517 < 3.    (3)

Its exact moment is 48-64/sqrt(2)=16(sqrt(2)-1)^2. No factor r, c, 49 or 2*pi is missing from (3).

The selected proof may use `Explicit/GrExtend.norm_G_uniform_ext:73`, which states

    |Gr(s,d,0)| <=300 exp(-thetaD(d)*|Im(s)|)
    for -3/2<=Re(s)<=1.

This domain contains the etaU line. Applying the norm-of-integral inequality to (1), then (2)-(3), gives

    |M_U(-1/2+i*t,delta)|
      <=300*2.74517 exp(-thetaD(delta)*|t|)
      =823.551 exp(-thetaD(delta)*|t|)
      <=900 exp(-thetaD(delta)*|t|).                        (4)

Every integral here is absolutely convergent by Section 1. The comparison in (2) has the correct direction: a larger positive decay rate gives a smaller exponential at |t|>=0. It holds equally for negative delta, negative t, and delta=0.

A stronger existing source theorem is available without changing the argument. `Explicit/ZeroSumBound.norm_G_uniform:40` gives the constant 112 on -1<=Re(s)<=1. Since -1/2 lies in that domain, (4) can be strengthened to

    |M_U(-1/2+i*t,delta)|
      <=307.45904 exp(-thetaD(delta)*|t|)
      <308 exp(-thetaD(delta)*|t|).                         (5)

This is a genuine optional improvement, not a use of the 112 theorem outside its domain. We retain 900 when checking the selected budget.

At s=0, `Eta2Moments.moment_one:154` gives integral eta2(r)/r<=1.92182<2. Applying either Gaussian source estimate at Im(s)=0 gives the selected

    |M_U(0,delta)| <=600,

and the 112 estimate gives the optional stronger bound 215.24384<216. These are the Mellin factors for a possible trivial zero at the complex number 0. They say nothing about its multiplicity; that remains the separate source zero-count bound.

## 3. EtaPlus uses its own shifted Gaussian representation

The actual etaPlus transform has the source representation

    M_+(s,delta)=integral_[-aH,aH]
       Fourier(gC)(xi) Gr(s-1+2*pi*i*xi,delta,0) dxi,
    2*pi*aH=200.

At Re(s)=-1/2 the Gaussian argument has real part -3/2. Therefore the 112 theorem from Section 2 cannot be used here. `EtaPlusMellin.norm_mellin_fP_uniform:237` already proves

    |M_+(s,delta)| <= Cg*(2*aH)*300*exp(1)
                         *exp(-thP(delta)*|Im(s)|),
    -1/2<=Re(s)<=2,
    thP(delta)=min(thetaD(delta),1/200).                     (6)

Its proof keeps the frequency shift |2*pi*xi|<=200. The factor exp(1) follows from 200*thP<=1, rather than dropping the shift. `EtaPlusCg.cA_le:89` gives Cg*(2*aH)<=129.24. The source bound exp(1)<2.72 therefore gives

    Cg*(2*aH)*300*exp(1) <129.24*816=105459.84<106000.      (7)

The zero-at-zero bound is separately supplied by `EtaPlusMellin.norm_mellin_fP_zero`:

    |M_+(0,delta)| <=300*Cg*(2*aH)<=38772<39000.             (8)

Thus the selected plus pair is Kv=106000 and rate thP(delta); the selected star pair is Kv=900 and rate thetaD(delta). Neither transform has been identified with the other. The qualitative etaU GoodSmoothing result and the existing etaPlus GoodSmoothing theorem provide their admissibility independently of these numerical choices.

## 4. The exact vertical integral and normalization

For primitive nonprincipal chi of positive conductor c, the existing unconditional theorem `ExplicitBoundGen.norm_integral_hIntG_le:32` consumes

    Kv>=0, theta>0,
    for all t, |mellin(f)(-1/2+i*t)|<=Kv exp(-theta|t|),
    z>0,

and proves

    |integral hIntG(chi,f,z)(-1/2+i*t) dt|
      <=z^(-1/2) VgL(DN(c),Kv,theta),
    VgL(D,Kv,theta)
      =Kv*(2/log(2)+4.8)*((D+37)*2/theta+2.6*2/theta^2).    (9)

There is no finite-RH hypothesis in this theorem. Do not replace it with the later `norm_SsumG_le_gen`, whose low-zero binder still asks for the critical line.

For the primitive principal character, `ExplicitBoundGen.norm_integral_hZeta_le_gen:74` gives exactly (9) with D=3 and the actual hZeta integral. It is not the hIntD integral for zetaF. The specialized zeta formula has already separated the s-1 factor and its pole main term.

Both explicit formulas multiply the vertical integral by 1/(2*pi). After normalizing the additive sum by its physical scale z, the resulting error is

    vertical_error <= z^(-3/2)*VgL(D,Kv,theta)/(2*pi).       (10)

For etaPlus z=x. For etaStar, rewrite etaStar(n/x)=etaU(n/y) with y=x/49, so z=y. On the common major-arc coordinate delta, the star twist is delta/49; no further Jacobian or factor 49 enters (10), because this is a pointwise bound, not an integral over delta. A change of variable in a later L2 integral is a different operation.

The selected real-twist domains give the following valid uniform rates:

| Use | Actual twist d | Bound on abs(d) | Kv retained | Rate retained |
| --- | --- | ---: | ---: | ---: |
| Major etaPlus | delta | 600000 | 106000 | 4e-7 |
| Major etaU/star | delta/49 | 600000/49 | 900 | 2e-5 |
| Base-gap etaU | delta_y | 600000 | 900 | 4e-7 |

Indeed thetaD(d)>=.28/600001>4e-7 in the first and third rows. In the second it is at least 13.72/600049>2e-5. The cap 1/200 in thP also exceeds 4e-7. For the base-gap parametrization delta_y=+/-u/(2q), the full u<1200000 and q>=1 imply the third row; the common major coordinate delta/49 must not be applied again there.

## 5. Check of the selected small-error allowance

This section checks scalar implications on paper, without evaluating Mellin functions. For 1<=c<=300000, the source definition `ExplicitFormula.DN:805` is

    DN(c)=log(512*c^9*(c+1)/.355)<150.

A simple sufficient bound is actually <138: exp(1)>8/3 by its positive series, (8/3)^13>300001, and (8/3)^8>512/.355. Therefore log(c),log(c+1)<13 and log(512/.355)<8. Also log(2)>5/8 implies 2/log(2)+4.8<8, and 2*pi>6. These weak inequalities suffice. The principal D=3 is smaller as well.

Substituting the retained constants and D+37<=187 into (9) gives exact rational upper bounds

    major plus:  VgL < 27560792880000000000 <2.76e19,
    major star:  VgL < 93734640000000       <9.4e13,
    base star:   VgL < 234006732000000000   <2.35e17.         (11)

For x>=4.9e26 one may weaken x^(-3/2)<=10^(-39); for y>=10^25 one may weaken y^(-3/2)<=10^(-37). Thus (10) is respectively below 4.6e-21, 1.567e-24 and 4e-21. These are conservative bounds, with no large-argument special-function evaluation.

If the separately selected multiplicity bound m(0)<=400 is used, (8) adds at most 400*39000/x<3.2e-20 for plus. The selected star bound600 adds at most 400*600/y<=2.4e-20. Therefore vertical plus zero0 stays below 4e-20 for major plus and below 2.8e-20 for either star use. This verifies the existing allowance 1e-18 with room to spare. It does not prove the separate m(0)<=400 count here, and the principal zeta case has no zero0 term at all.

High nontrivial zeros and primitive-to-coprime removal are not included in these numbers. Their existing ledger allocations remain separate. The optional 308/216 improvements are unnecessary for this conclusion.

## 6. Remaining proof work and pins

There is no unresolved scalar inequality preventing the selected 900 vertical bound. The paper proof is (1), the twist-rate comparison (2), the source moment (3), and the source Gaussian bound. The newly reviewed continuity/admissibility note supplies the absolute-Fubini normalization required for (1). A Lean implementation still needs the actual etaU mixture wrapper and the integral comparison, plus the already tracked admissibility and source-limit adapters. This note does not validate the finite spectral certificate, global seven-eighths provider, Gram estimates or full Goldbach proof.

The source files below are relative to `work/ternary-goldbach/TernaryGoldbach/`:

| File | SHA256 |
| --- | --- |
| Explicit/ZeroSumBound.lean | `A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4` |
| Explicit/GrExtend.lean | `5D53359BA14E76776DC1EF472BB8BE0B88D2A8F6B7B1F93A9274CA027B7F68F5` |
| Explicit/EtaPlusMellin.lean | `BA9CD4DFA03A6CB36482C52EB135C81D8BA3AD117510A96AF308B2D4FE8DD2BC` |
| Explicit/EtaPlusCg.lean | `910A80A50F5279852B64876A535B35FC6EDFDE4C09023D07B6E35D9242D4235B` |
| Explicit/ExplicitBoundGen.lean | `360706F9766A940C13D1E1FFAA9A3EE4A248F845C2816B5568F207D41BB7E44E` |
| Explicit/ExplicitFormula.lean | `8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35` |
| MajorArcs/Eta2Moments.lean | `3DDC63BE9937E6022B77B80238CC1666A3B122161CC0CFA02081E0E9A2DF0871` |

Research inputs, relative to `work/qrh-campaign/agents/`:

* `major-constants/ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md`, `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D`.
* `major-constants/RESUME_FAMILY_CAPS_2026-11-11.md`, `2990B5B5D7ABA1B8262FB18800CA5CE61DC347B7C5748405A5886D9EE45BBAF3`.
* `integration/RESUME_BASE_GAP_INTERFACE_LEDGER_2026-11-11.md`, `43C2090F15C68D177618D1A7E65119DCE9F0BEC631214D1DB3962FB55FE75701`.

All quoted sharp Gaussian, moment and vertical-integral declarations are unconditional at their own statement boundaries. Their files also contain results with other hypotheses; this argument uses only the stated declarations, not those later consumer theorems.
