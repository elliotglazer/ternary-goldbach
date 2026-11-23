# Retaining the plus Fourier weight in high-zero star bounds

2026-11-11. Bounded source/paper derivation with exact polynomial and rational checks. No L-function, zero, Fourier, Gamma or other analytic value was evaluated. No Lean declaration, build, source edit or frozen-artifact change occurred.

There is a source-faithful full-strip improvement over discarding |P(delta)|. This report proves an explicit weighted zero-band estimate and a convergent high-zero remainder without assuming global QRH or any upper bound on beta below 1. It does not demonstrate that a shorter spectral cutoff meets the actual A budget. The first closed-form allocation below is too coarse even at H=10^6 for the conductor-3 contribution. This is a failure of that sufficient allocation, not a lower bound on the true tail or an impossibility result.

The separate baseline investigation by zero_sum is comparing averaged zero counts at the source star-tail cutoffs. Its reported improvement over the original Platt-height carrier is not a premise here. No new carrier is adopted by this report.

## 1. Actual normalization and the new band theorem

Use the exact notation of the reviewed `audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md`:

    P(delta)=Fourier(etaPC)(-delta),
    F_U(s,d)=integral_(t>0) etaU(t)*exp(2pi*i*d*t)*t^(s-1) dt,
    y=x/49 >= 10^25.

For a primitive nonprincipal character chi of conductor c, take a finite multiset of its actual nontrivial zeros in

    H < |Im rho| <= 2H,  0 < Re rho < 1,

with each occurrence counted according to its actual analytic order. Let

    Z(delta)=sum_rho y^(rho-1) F_U(rho,delta/49),
    N=sum_rho 1,  S=sum_rho y^(2 Re rho-2).

Repeated rows, both ordinate signs, and inverse-character labels are retained. A minus sign on the explicit-formula zero sum does not change the norm. Let L be an upper bound for the number of these occurrences in every half-open ordinate interval of length h=87/25=3.48. For D>=1 define

    E(H,D)=min(H/8, 2401 H^2/(320 D^2)),
    B(D)=(116+55 log D)/(9D^2).

The new bound is

    ||P Z||_L2(R)
       <= sqrt(S) [32 sqrt(N) exp(-E(H,D))
                    +B(D) sqrt(17500 L)].            (1)

It holds uniformly for every y>=1. No beta-dependent Mellin phase or kernel is replaced by one at a reference beta. The low-twist term retains the actual Gaussian damping, while the high-twist term retains decay of the actual plus Fourier transform. All zero cross terms within the band are controlled by the full-strip Gram estimate; (1) is not a diagonal-only calculation.

The same upper bound applies on any restricted twist interval [-Dq,Dq]. If D>=Dq, the high-twist term is absent and the low-twist estimate uses Dq. This matters in applications: extending the weighted integral to the whole real axis is valid but can be very wasteful for small conductors.

## 2. Explicit Fourier decay of the actual etaPlus

The source writes, for t>0,

    etaPlus(t)=hH(200,t)*t*exp(-t^2/2).

Put g(u)=hBase(exp u) and b(u)=hH(200,exp u). `HHFourier.hH_eq_fourier:278` represents b as the Fourier transform of ĝ restricted to |xi|<=200/(2pi). The source proves ||g'||_2^2<=19.5. Differentiation of that finite-frequency integral and Cauchy-Schwarz give

    |b'(u)|^2 <= (200/pi)*||g'||_2^2 < 40^2.           (2)

Here derivatives are ordinary derivatives in the logarithmic variable u. The 2pi factors are absorbed by the Fourier derivative identity; they are not omitted.

A second derivative estimate follows from a new elementary polynomial integral. On 0<t<2,

    g''(log t)=exp(t-1/2)*P2(t),
    P2(t)=32t^2-68t^3+20t^4+17t^5-5t^6-t^7.

This is obtained by applying t*d/dt twice to exp(t-1/2)*t^2*(2-t)^3. At t=2 the function and its first two derivatives vanish; at t=0 these expressions are O(t^2). Thus g,g',g'' are integrable and square integrable, with the needed global differentiability for two Fourier derivative identities. Exact polynomial integration gives

    integral_0^2 P2(t)^2 dt/t =16128/715.

Since exp(2t-1)<=exp(3)<21 on [0,2],

    ||g''||_2^2 <338688/715,
    |b''(u)|^2 <= (200/pi)*||g''||_2^2 <180^2.         (3)

The elementary exp(3)<21 follows from exp(1)<11/4 and (11/4)^3<21. A finite exponential-series sum and a geometric bound on its positive tail prove exp(1)<11/4; no exponential value is evaluated. The source already proves |b|<=3.15, which we weaken to 4.

Write f(t)=etaPlus(t), set f=0 for t<=0, and use b',b'' for the logarithmic derivatives above. For t>0,

    f'(t)=exp(-t^2/2)[b'+(1-t^2)b],
    f''(t)=exp(-t^2/2)[(b''+b')/t-2t b'+(t^3-3t)b]. (4)

We do not assert that f'' is absolutely integrable at zero. That is exactly why an unsplit twice-integrated Fourier bound would be unjustified. Instead let X=|delta|>=1, a=1/X and Omega=2pi X. Split the Fourier integral at a, and integrate the tail [a,infinity) twice by parts. The finite boundary terms at a must be retained. Equations (2)-(4), pi>3 and elementary Gaussian integrals give

    integral_0^a |f| <=2/X^2,
    |f(a)|/Omega <=(2/3)/X^2,
    |f'(a)|/Omega^2 <=(4/3)/X^2,
    integral_a^infty |f''| <=220 log X+320.

For the last inequality, split the t^-1 term at 1 and use

    integral_a^infty exp(-t^2/2)dt/t <=log X+1,
    integral_0^infty t exp(-t^2/2)dt=1,
    integral_0^infty t^3 exp(-t^2/2)dt=2.

The Gaussian factors make both boundary terms vanish at infinity. Therefore

    |P(delta)| <= (116+55 log X)/(9X^2),  X>=1.        (5)

The right side decreases for X>=1, so it is at most B(D) when X>D>=1. This is a bound on the actual hH-defined etaPlus. It does not replace it by the compact smoothing etaCirc or charge an unproved small high-frequency difference. The unconditional full L2 source bound is

    integral_R |P(delta)|^2 ddelta <=0.640208<1.       (6)

Sections (2)-(5) require new formal adapters around existing Fourier differentiation and Plancherel, but all constants have explicit producers. No finite-RH assumption occurs in them.

## 3. An adjustable-angle full-strip etaU bound

The actual positive mixture in `Cor933.etaU_eq:49` is

    etaU(t)=integral_(r>0) eta2(r)*phi(t/r) dr/r,
    phi(v)=v^2 exp(-v^2/2),

where eta2 is supported on [1/4,1] and its dr/r mass is less than 2. Absolute Fubini and the substitution t=rv give, for 0<=beta<=1,

    F_U(beta+i gamma,delta/49)
      =integral eta2(r) r^(beta+i gamma)
           Gr(beta+i gamma,delta*r/49,0) dr/r.         (7)

In particular |r^(beta+i gamma)|<=1. These are the source mixing powers; no extra factor 49 appears in (7).

Use `MellinRotate.norm_Gr_le:359`, with a signed angle whose sign agrees with gamma and whose magnitude theta lies in (0,1/4]. Its hypotheses hold for the entire closed beta range [0,1]. For |delta|<=D, cos(2theta)>=1/2, |sin theta|<=theta and v^(beta+1)<=v+v^2 give

    |F_U| <=32 exp[-|gamma|theta+(80 D^2/2401)theta^2]. (8)

Here the elementary completion of the square is

    -v^2/4+bv <=-v^2/8+2b^2,
    b<=2pi D theta/49,
    integral_0^infty (v+v^2)exp(-v^2/8)dv<16.

The last integral is 4+4sqrt(2pi)<16. Multiplication by the mixing mass less than 2 gives 32. The exponent uses pi^2<10. This retains the square theta^2 in the twist cost; replacing it by a fixed-angle constant would lose the useful joint dependence.

For |gamma|>H choose

    theta=min(1/4,2401 H/(160D^2)).

In the first case the exponent in (8) is at most -H/8. In the other case it is at most -2401H^2/(320D^2). Thus

    |F_U(rho,delta/49)| <=32 exp(-E(H,D)).             (9)

All inequalities hold with either sign of gamma or delta. No finite or global RH is used, and beta approaching 1 is allowed. The needed mixture Fubini and dominated differentiation are also covered by the previously reviewed actual-smoothing continuity construction.

## 4. The weighted band estimate, with all cross terms

The reviewed full-strip Gram bound derives

    |Mellin(etaU^2)(sigma+i*tau)|
       <=min(24,2904/(1+tau^2)),  -1<=sigma<=1.

For any finite zero multiset with at most L occurrences per ordinate interval of length h=3.48, its absolute row sum gives

    integral_R |Z(delta)|^2 ddelta
       <=49*2L[96+2904/(3h^2)]*S <17500 L S.         (10)

The 49 in (10) is exactly the star-twist Fourier scaling. It is not an additional factor in the weighted convolution identity. Repeated multiplicities are repeated rows and are counted in L and S. The calculation retains actual beta+beta'-1, actual ordinate differences, and arbitrary coefficient phases.

On |delta|<=D, (9) and finite Cauchy-Schwarz yield |Z|<=32 exp(-E)*sqrt(NS). Multiplying by P and using (6) bounds this part of the L2 norm by 32 exp(-E)*sqrt(NS). On |delta|>D, (5) and (10) give B(D)*sqrt(17500LS). Their disjoint-support norms can be combined in squares, or more conservatively by a sum. The latter gives (1).

An alternative exact interpretation is the Fourier autocorrelation of etaPlus: the weighted two-zero Gram kernel is a double Mellin integral against the autocorrelation evaluated at (t-u)/49. There is no standalone 49 in that identity. The present proof avoids differentiating that two-variable kernel and instead combines (5) and (9). It is a bound, not an identity-based assertion of computational saving.

## 5. A source-derived count input at arbitrary heights

The constant 400 from the old finite domain is not reused at arbitrary H. Define

    BP(c,T)=1400*c^9*(c+1)*(|T|+22)*(1.25*(|T|+11))^10,
    L_c(H)=log(BP(c,2H+h)/0.355)/log(10/3).

The source theorem `ZeroSums.zero_count_poly:76` gives this bound in a radius-3 disk centered at 2+i*v. A full-strip ordinate interval of length h is inside that disk: its real displacement is less than 2 and half-height is h/2, with 4+(h/2)^2<9. If the interval contains band zeros, its center can be chosen with |v|<=2H+h. Monotonicity of BP therefore proves the required arbitrary-window bound L=L_c(H). It counts true orders throughout the strip, not only critical-line zeros. Closed endpoints and half-open partitions are compatible because the disk count is inclusive.

Covering [-2H,2H] by such windows gives

    N <=(4H/h+2)L_c(H) <=2H L_c(H),  H>=1024.         (11)

This is intentionally a coarse unconditional count. The sharper averaged-count method in the separate baseline investigation may replace N, but cannot replace the local Gram input L without its own proof.

## 6. An explicit summable cutoff tradeoff

For H>=1024, choose

    D(H)=49H/sqrt(1920 log H).

Elementary inequalities give 1<=D(H)<=H and H>=48log H. Thus E(H,D)>=6log H. With S<=N, (1), (5) and (11) imply the uniform band remainder

    ||P Z||_2
      <=L_c(H)[64/H^5
          +17 log H (116+55log H)/H^(3/2)].            (12)

This is an actual full-strip gain, not a y^(-1/8) or y^(-1) bound borrowed from another spectral hypothesis. The loss of such y factors is explicit.

For a cutoff H0>=1024, partition all |gamma|>H0 into the disjoint bands (2^j H0,2^(j+1)H0], counting both signs. Write l=log H0 and a=L_c(H0). From the exact BP polynomial,

    L_c(2^jH0)<=a+11j,
    log(2^jH0)<=l+j.

Minkowski and 2^(-3j/2)<=2^(-j), followed by the elementary sums of j^k/2^j for k=0,1,2,3, give

    ||P sum_(|gamma|>H0) y^(rho-1) F_U(rho,delta/49)||_2
       <= E_c(H0),                                   (13)

where, putting B0=116l+55l^2 and B1=116+110l,

    E_c(H0)=128(a+11)/H0^5
       +(17/H0^(3/2))*[a(2B0+2B1+330)
                         +11(2B0+6B1+1430)].         (14)

Equation (13) is first an assertion that the finite band sums form a Cauchy family in the weighted L2 space. To identify its limit with the high-zero part of the actual explicit-formula remainder, use the existing finite good-height formulas, actual smoothing admissibility, and the measurable residual/subsequence transfer. This does not absorb the vertical integral, the zero at 0, or primitive-to-coprime removals. Those remain separate components of the consumer remainder.

The same proof yields the more useful finite-statistic version before S<=N: sum over bands of sqrt(S_chi,j) times the bracket in (1). This weights high ordinates without changing actual kernels or beta. Cross-band terms are paid by Minkowski; they cannot be dropped by pretending the bands are orthogonal.

For the actual A target, exact supported Gauss weights give the sufficient high-zero allowance

    T_A,high^2 <=sum_(c>1) omega_A(c)*primitiveCount(c)*E_c(H_c)^2,
    omega_A(c)=sum_(eligible q) mu(q)^2*c/phi(q)^3.     (15)

The inverse-character map permutes the primitive labels. There is no conjugation halving or extra phi average. A proof of (15)<=a chosen share of 10^-12 would pay the high-zero part of T_A<=10^-6; the other remainders still require their own shares. The unweighted B target and the pointwise base-gap target are not consequences of (15).

## 7. What this does and does not yet save

The closed bound (14) is not competitive enough to certify a new short cutoff. This can be seen without evaluating logarithms. At c=3,H0=10^6, both a>1 and l>1. Hence B0>171, B1>226 and the square bracket in (14) exceeds 35532. Therefore

    E_3(10^6)>604044/10^9.

Since omega_A(3)>=3/4, even the single-conductor sufficient norm majorant sqrt(omega_A(3))*E_3 exceeds 302022/10^9, far above 10^-6. This is a lower bound on our explicit upper-bound expression, not on actual zeros, actual A, or the optimal weighted tail. It does not rule out a better choice of D, use of the finite q-dependent twist interval, sharper Fourier decay, a sharper Gram estimate, or retained spectral beta information.

The immediate quantitative gap is now specific. Formula (1) is a valid candidate replacement for the discarded-weight Gram step. To credit shorter carriers one must actually close the sum with the exact finite Dq intervals, sharper local/averaged counts as appropriate, and all other remainder allocations. The coarser closed formula (14) alone does not do so. In particular, unknown beta near 1 removes the very large y-decay available under RH; this cost has not been hidden in the notation.

The new mathematical content is the actual etaPlus derivative/Fourier estimate, the adjustable-angle Gaussian estimate with its 49 scaling, and their weighted band composition. Further work should attack the constants in that composition or the actual two-variable weighted kernel, rather than infer a production saving from the Fourier identity alone.

## Sources and exact checks

Actual source is under `work/ternary-goldbach/TernaryGoldbach`, baseline commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The source conclusions below are read at their displayed scopes; new wrappers in this report have not been elaborated.

| File | Source used | SHA256 |
|---|---|---|
| Helfgott/HHBound.lean | hP/hP' 191-196; hH200 sup 414 | D2006ECE07FB59B4B9EA7F818CD314DAEEE89637F56ECC43237E923C42C5E0FF |
| MajorArcs/HHFourier.lean | gL 74; derivative energy 194; finite-frequency representation 278; Fourier derivative/Plancherel pattern 431-479 | C2672D93F08DD59A8FB1D8B474BD5393F1B8823938F4D7ACF39FB9AC97CFF665 |
| MajorArcs/EtaPlusL2.lean | full norm bounds 113; etaPC 124; Plancherel 148 | 0E86FF780F7F4A817F3093787D24D0C5DC10290B56B8555C7EA62362E049D949 |
| MajorArcs/Cor933.lean | actual positive mixture 49 | 554F00DE4FA6F8F0B6B184F8E8535B8AC5C28C0DB47FA2A95119B6BA4899F66E |
| MajorArcs/Eta2Moments.lean | nonnegativity 17; dr/r mass 154 | 3DDC63BE9937E6022B77B80238CC1666A3B122161CC0CFA02081E0E9A2DF0871 |
| Explicit/MellinRotate.lean | arbitrary signed-angle inequality 359 | 31E5CE91E6527D35DBC22E17FAC8F7BED38C116D7356D7479F1B5F96B16C01A4 |
| Explicit/ZeroSums.lean | BP 18; arbitrary-radius Jensen count 76; actual zero carrier 167 | 3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D |
| Explicit/ZeroSumBound.lean | BP monotonicity/growth 228-265; finite count transfer 325 | A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4 |

Reviewed paper inputs under `work/qrh-campaign/agents`:

| File | SHA256 |
|---|---|
| audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md | AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B |
| independent-feasibility/REVIEW_WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md | 85849ED642AEED600A71F41E56D4C7DC86ACAB23F338E19979CD15B58B8D60DE |

The companion `weighted_star_band_scalars_20261111.py`, SHA256 `124D60F621E69557114323701A6B3A004CEE22E57C8A30460CCCEFF3915B496F`, performs 16 exact checks. Receipt `weighted_star_band_scalars_20261111.json` has SHA256 `F30F57DD783BC9112980FA6DFCBFD509B4AF00DA7D4D76212B36831E889E8972`. It reconstructs P2, integrates its square as a rational polynomial, checks the Fourier/Gram constants and proves the failed closed allocation comparison. It does not evaluate any analytic function or verify any actual spectral statistic.
