# Smaller finite-RH heights for the actual plus consumer

2026-11-11. Source/paper research and exact rational scalar checks. This gives a sufficient replacement height for the original finite-RH plus analysis at R=132900. It preserves the old pointwise plus error, which is stronger than the requested relaxed nonprincipal energy target. No spectral values, primes, analytic functions, transforms or Lean builds were evaluated, and no source or frozen artifact was changed. The new finite-RH facts are requirements, not supplied certificates.

## 1. Explicit candidate and theorem scope

Let qt(c)=c for even c and 2c for odd c. For every active primitive nonprincipal conductor c, set

    d_c=1063200/qt(c),
    u_c=19.89 if c is even and c>60000,
        23.3 otherwise,
    Tplus(c)=ceil(200+max(260,u_c*3.1416*d_c)).         (1)

The ceiling is an integer ceiling of the displayed exact rational number. Require the actual closed finite-RH statement

    for every primitive nonprincipal chi of conductor c,
    every L-function zero with 0<Re rho<1 and |Im rho|<=Tplus(c)
    has Re rho=1/2.                                   (2)

The range is odd c<=132900 and even c<=265800. Modulus one is excluded from (1)-(2): retain the original principal RH input through 10^8. The formula can harmlessly be assigned to c=2, although its primitive nonprincipal family is empty. Central zeros and endpoint ordinates are included by the actual `GRHUpTo` convention. There is no global QRH assumption and no beta=.555 or global 7/8 input.

Under (2), for every x>=4.9e26, every such chi and every real |delta|<=d_c, the source argument gives

    |Schar(chi,Lambda(n)*etaPlus(n/x),delta/x)|/x
       <= (7.5e-8+7.7e6/sqrt(x))/sqrt(c).             (3)

This is exactly the old nonprincipal pointwise bound. The gain comes from redoing the actual high-zero error at the smaller height, while using monotonicity only for the positive low-zero bound. It is not inferred from admissibility alone.

Examples of exact closed integer heights are:

| c | Tplus(c) | Original finite height |
|---:|---:|---:|
| 3 | 12971113 | 100000000/3 |
| 4 | 19456569 | 25000000 |
| 5 | 7782748 | 20000000 |
| 10001 | 4091 | 100000000/10001 |
| 60000 | 1498 | 5000/3 |
| 100000 | 865 | 1000 |
| 125000 | 732 | 800 |
| 132899 | 493 | 100000000/132899 |
| 265800 | 460 | 213600/443 |

These are required plus heights, not a forecast of verified zeros, samples or runtime. No search over parameter choices was performed and no optimality is claimed.

## 2. Every source error term and the exact new hypothesis

`Prop942.prop_9_4_2:76` accepts an explicit `GRHUpTo chi T0` and the condition

    200+max(10*pi*|delta|,50)<=T0.

It bounds the normalized nonprincipal sum by the actual `errP c T0 delta x`, whose four terms are

    E0(c)/x + E1(c,T0)/sqrt(x) + E2(c,T0,delta)
       + V(c,delta)/(2*pi*x*sqrt(x)).                 (4)

The definitions at `Prop942:50-53` are retained, including Cg, aH, the BP polynomial, the logarithmic derivative constant DN, and the actual etaPlus Mellin transform. The consequences of the new height are as follows.

* E0(c)=Cg*300*(2*aH)*Z3g(BP c,0) does not depend on T0. The source proof in `Thm714.errP_le_of:430-482` still gives E0/x<=1e-17/sqrt(c).
* The vertical term also does not depend on T0. Its bounds use c<=300000, |delta|<=600000 and x>=4.9e26. All remain valid, and it is at most 1e-17/sqrt(c).
* E1 has a positive expression in the height and decreases when that height is reduced. Section 3 proves the needed comparison, without assuming cancellation of a shortened zero sum.
* E2 must be recalculated. Section 4 checks the EB and EA tails, both geometric denominators, both zero-count constants, and the prefactor.

Since Tplus-200>=260, u_c>=19.89>10 and pi<3.1416, (1) gives the exact admissibility condition. The principal approximation is unchanged and is not proved from (2).

The earlier `zero-sum/SHARED_HIGH_CONDUCTOR_HEIGHT_REDUCTION_2026-11-11.md` uses a finite .555 strip and global reflected [1/8,7/8] tails. That is a different route and is not used here. This report uses the original-RH `Prop942` error on the full nontrivial strip above Tplus.

## 3. Ceiling-safe comparison with the original low-zero bounds

Define the original endpoint

    Hold(c)=1e8/c                                  for odd c,
    Hold(c)=max(1e8/c,200+7.5e7/c)                  for even c.

Put

    Ao=23.3*3.1416*531600,
    Ae=23.3*3.1416*1063200,
    Ah=19.89*3.1416*1063200.

The ceiling satisfies Tplus<201+max(260,A/c), with A chosen from these three constants. The following rational endpoint tests prove Tplus<Hold throughout the specified ranges:

| Range | Sufficient endpoint inequalities |
|---|---|
| odd c<=132900 | 461*132900<1e8 and 201*132900+Ao<1e8 |
| even c<=60000 | 461*60000<1e8 and 201*60000+Ae<1e8 |
| even 60000<c<=125000 | 461*125000<1e8 and 201*125000+Ah<1e8 |
| even 125000<c<=265800 | 261*265800<7.5e7 and 265800+Ah<7.5e7 |

Each expression is increasing in c, so these are whole-range arguments, not sampled checks. The last line compares directly with 200+7.5e7/c, the active old endpoint in that range. All four tests include a full unit of ceiling overshoot.

The exact low-zero bound is

    E1g(BP c,T,Q1,Q2)
       = ZLg(BP c,T)*[(1/3.48)*sqrt(Q1*2*Jl(T)*3.48)
                       +sqrt(Q2*2*Jl(T)*3.48)],
    Q1=2*pi*.6403, Q2=2*pi*1.129,
    Jl(T)=floor(T/3.48)+1.

For T>=0, BP and its logarithm are increasing, ZLg is nonnegative, Jl is nondecreasing and both square roots are nonnegative and nondecreasing. Therefore E1g is nondecreasing in T. This proves E1(c,Tplus)<=E1(c,Hold) directly from `ZeroSumGen:191` and `ZeroSumBound` monotonicity. It does not invoke the old finite-RH theorem at Hold.

The old unconditional numerical E1 proofs use:

    K1=145.21*(28515/3.48+37864) <7.66e6,
    K2=143.21*(33086/3.48+43934) <7.66e6.

K1 applies to odd c and even c<=125000, via the original endpoint 1e8/c. K2 applies to even c>125000 via 200+7.5e7/c. `Thm714.E1P_le:247`, `Cor713.ZL_le:344` and `Thm714.ZL_R3_le:315` establish these without a finite-RH hypothesis. Thus

    E1(c,Tplus)<=7.66e6/sqrt(c).                     (5)

The same endpoint comparison and BP monotonicity yield

    0<=Z3g(BP c,Tplus)<=177.26.                      (6)

For the high even range use the stronger source endpoint bound 174.82 and weaken it. For all other ranges use `Cor713.Z3_le:351` at 1e8/c. These are analytic count upper bounds, not lists of certified low zeros.

## 4. Recomputed high-zero errors

Use `Thm714.E2_gen_le:101` with the following exact inputs:

    T1=260, Z=177.26, C=.09,
    EBb=.892*260/2^59.

The common tail-growth bound is valid because Tplus>=460 and

    11*4.4 <= .09*(460*1.2039),

using the source log(10/3)>=1.2039. Nonnegativity is unchanged. For the EB input, the four positive Taylor terms give

    exp(.7)>=1+.7+.7^2/2+.7^3/6>2,
    .1598*260=41.548>59*.7.

Consequently exp(-.1598*260)<2^-59, which proves the required EBb inequality. The source monotonicity for T exp(-.1598T) applies since T1>=7 and Tplus-200>=T1. No exponential is evaluated.

There are two EA/geometric-denominator rows:

| Conductors | u0 | EAb | IA upper bound |
|---|---:|---:|---:|
| odd c, or even c<=60000 | 23.3 | 6e-23 | 222000 |
| even c>60000 | 19.89 | 1.2e-16 | 8.77 |

`Thm714.EAb_233:202` and `EAb_1989:196` are exact source exponential-series certificates for these constants. The definition of Tplus and `u_le:236` prove u0<=(Tplus-200)/(pi*|delta|) whenever delta!=0. At delta=0 the source EA branch is zero and is covered separately by its nonnegativity proof.

For the first row, |delta|<=d_c<=531600<600000 even if c=2 is included. The source `IA_le:208` gives IA<=222000 from

    1+3.1416*(600000+1)/(1.93*4.4)<=222000.

For the second row, |delta|<=1063200/c<17.72<20. The same source lemma gives IA<=8.77 using D=20. The EB geometric inverse remains at most 2.1768 in both rows.

The actual E2 upper bound in each row is therefore

    129.24*{
      EBb*[2*177.26*2.1768+2*.09*(2.1768)^2]
      +EAb*[2*177.26*IA+2*.09*IA^2]}.

Exact rational composition gives, respectively,

    15059289053776023968213817 /
      137438953472000000000000000000000000,
    60888193779268136313198621 /
      687194767360000000000000000000000000.

Both are less than 1.12e-10, and

    547.73*(1.12e-10) <6.9e-8.                       (7)

Thus the existing hypotheses of `errP_le_of` hold with E2b=1.12e-10 and K<=7.66e6. Combining (4)-(7) gives (3) for every x in the unbounded source domain. No coefficient has been rescaled merely because the analytic threshold or R changed.

## 5. Gauss weights, coprime transfer and all plus consumers

For an ambient modulus q with qt(q)<=265800 and |delta|<=1063200/qt(q), every inducing primitive conductor c divides q. If c is even, qt(q)=q and c<=q. If c is odd, the same elementary argument as `ArcChars:411-426` gives 2c<=qt(q). Hence every primitive sum needed by the actual inverse-character expansion lies in the d_c domain of (3).

Retain the unconditional coprime-removal bound 1e-15*x and the actual Gauss inequality |tau_q(psi)|<=sqrt(c). The unchanged source calculation `ArcChars.err_scaled_le:324` then gives

    |tau_q(psi)|*|Schar(psi^-1,coprimePart(q,cP(x)),delta/x)|
      <=4.25e-7*x

for every nonprincipal character psi, including imprimitive ones. The inverse label and its conductor are exactly those in the source. No squarefree Gauss factor is omitted, and zero-Gauss characters are harmless rather than assumed absent.

The exact character Parseval identity therefore proves

    E_q=(1/(phi(q)*x^2)) sum_(psi!=1)
              |tau_q(psi)|^2*|Schar(psi^-1,coprimePart(q,cP(x)),delta/x)|^2
        <=(4.25e-7)^2=1.80625e-13 <7.02e-13.          (8)

The principal-only estimate remains 2.83e-7*x, using modulus-one RH through 10^8 and the same coprime removal. Thus both parts of the original `arc_chars` energy conclusion are retained, including the smaller upper-J allowance. This candidate does not require spending the orthogonal-splitting slack of the relaxed plus target. The lower-J bound, old plus residual, cubic consumers and original minor constants can keep their prior plus inputs. The x lower bound and the previously reviewed N0 passage are unchanged.

Implementation must replace the old nonprincipal calls to `thm_7_1_4_odd/even` by the explicit-profile lemma derived here. Calling their original wrappers under blanket `Fact PlattGRH` would retain the old height obligation despite the new scalar proof. The numerical E1/E2 lemmas and `Prop942` are the relevant reusable bodies; they do not need the larger finite-RH premise.

## 6. Certification union and the exact limit of this result

The plus-only height is genuinely smaller, but a shared certificate must meet every other consumer. If the original Cor713 nonprincipal star and base-gap calls remain unchanged, they still request RH through 1e8/c. The resulting requirement is at least

    max(Tplus(c),1e8/c),                              (9)

with the principal height still unchanged. In particular (9) gives no reduction for odd c or even c<=125000, despite the large plus-only reduction for c=3 and c=10001. It can reduce the extra high-even plus extension beyond 1e8/c, subject to the rest of the localized consumer inventory. No entire-family work saving is inferred from the table in section 1.

Two other workers are independently investigating replacements for these retained consumers. The developing star aggregate profile is a separate finite statistic and full-strip remainder proof; the developing base-gap profile uses a different pointwise allocation. Neither is adopted here. For coordination only, the announced base-gap heights 27e6/c for odd c and 54e6/c for even c are below Tplus, since

    23.3*3*531600>27e6,
    19.89*3*1063200>54e6.

That dominance is exact arithmetic, but it does not prove the announced base-gap theorem. A separate star height floor can still dominate Tplus near the upper conductor range. If its certificate asks only beta<=b rather than RH, its logical requirements and production method must also be distinguished; taking the maximum of heights is conservative only when the implementation verifies the stronger common property.

The correct next comparison is a reviewed union of the actual plus, star, base-gap and any exact-count requirements, with their respective properties. Turing guard extensions and point-evaluation error domains must be priced after that union. No such inventory, sign-success prediction or runtime estimate is made by this note.

## Source pins and exact checks

Source baseline is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Paths below are relative to `TernaryGoldbach`.

| File | Relevant source | SHA256 |
|---|---|---|
| MajorArcs/Prop942.lean | errP 50; actual explicit-RH consumer 76 | 35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716 |
| MajorArcs/Thm714.lean | E2_gen_le 101; EA/IA 196-218; E1P_le 247; high-even count 315-337; errP_le_of 430-482; original parameter uses 590-682 | 7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F |
| MajorArcs/Cor713.lean | unconditional ZL/Z3 bounds 344-360; original nonprincipal star wrapper 802 onward | 11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433 |
| Explicit/ZeroSumGen.lean | ZLg 78; E1g/E2g 191-199 | 9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389 |
| Explicit/ZeroSumBound.lean | BP monotonicity 228; Jl 289; positive ZL/Z3/c3 315-323 | A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4 |
| MajorArcs/ArcChars.lean | removal 314; scaled error 324; inverse conductor and Gauss transfer 378-440 | 0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF |
| Explicit/EtaPlusBound.lean | actual finite-low RH premise and full-strip high error 153-172 | 8A0D0BE027F1560321D3AB4088C49768D0DE3E18D92A074823679A71AD043695 |

The prior direct-plus target is `major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md`, SHA256 `E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1`, reviewed at `prime-estimates/REVIEW_DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md`, SHA256 `89DEB7CACE2D0AC4030C349D5E8E715C0B8DFFC69A7D33383D701DAB836F6B12`. Its separate upper-J warning is respected by preserving the stronger old bound in (8).

Owned scalar script `plus_finite_rh_height_scalars_20261111.py`, SHA256 `734DB06EE8574E090A4DE2B214B8BA8FC0445A7A07E6481E9774F492052C67DE`, checks 24 rational comparisons and 11 exact ceiling examples. Receipt `plus_finite_rh_height_scalars_20261111.json` has SHA256 `E76E705AD47465021709985BEC1A2A025573C07BD1F9188B1648A984654713D9`. It evaluates no analytic function and proves no finite-RH instance. Independent source/math review is required before adopting the new profile.
