# Upper major energy: the broad principal contribution

Research only. This note does not prove Ep<=1e-4 or J<=10. It gives an exact finite-window formulation, a numerical sufficient kernel bound, and a rigorous model obstruction to deriving that bound from only the global7/8 strip, the mass bound .07, functional-equation symmetry, and the source Jensen zero counts. The model is not asserted to be the zero set of zeta or of any function satisfying every source analytic identity. No Lean process or canonical source edit was used.

## Actual target and common principal residual

Follow BLUEPRINT_AVERAGES.md and prime-estimates/L2_REPLACEMENT.md. For q in Qset150000, put mPhi(q)=mu(q)^2/phi(q), Dq=1200000/qt(q), and

    W(delta)=sum_q mPhi(q) 1_(|delta|<Dq).

Here qt(q)=2q for odd q and qt(q)=q for even q. Thus W(0)<=13.59756 and W is supported on[-600000,600000]. Importantly,

    W(delta)>=3 for |delta|<200000,

because q=1,2,3,6 contribute respectively1,1,1/2,1/2. These are all legitimate squarefree moduli in Qset.

Let P(delta)=Fourier(etaPlus)(-delta), and

    e(delta,x)=SsumG 1 (fP delta) x/x-P(delta).

The desired Ep uses the q-dependent COPRIME principal residuals g_q-P. The existing uniform removal error is <=1e-15. Minkowski on the finite disjoint union of weighted q-windows therefore gives

    sqrt(Ep)<=||e||_(L2(W ddelta))+1e-15 sqrt(L),
    L=sum_q 2Dq mPhi(q) <=1200000*13.59756 <5000^2.              (1)

So the removal term is <5e-12. This is a weighted direct-sum norm identity, not an assumption that all g_q coincide.

The target remains Ep<=1e-4 for every x>=x0=4.9e26. With the separately required nonprincipal N<=1.23, the reviewed square splits imply J<10. No upper bound is obtained by discarding broad twists and keeping only[-4,4].

## Finite-window Mellin criterion

For each source rectangle S=zerosRectD zetaF T, with multiplicity m_T, define

    Z_T(delta,x)=sum_(rho in S) m_T(rho) x^(rho-7/8) F(rho,delta),
    F(rho,delta)=mellin(fP delta)(rho).

An exact sufficient new analytic estimate is

    ||Z_T||_(L2(W ddelta))<=21                                (2)

uniformly in T and x>=x0. It must be proved for the ACTUAL zeros, with no new hypothesis substituting for (2). The unconditional common-sequence explicit formula and Fatou then bound ||e|| by21*x^(-1/8) plus the vertical remainder.

The vertical term is harmless on the full twist domain. The existing norm_mellin_fP_uniform gives Kv<106000 and thP(delta)>=.28/600001>4e-7. From VgL,

    VgL(3,Kv,thP)<3e19.

After dividing by2pi*x the pointwise normalized remainder is <5e18*x^(-3/2). Since x>=x0>1e26, its weighted norm is <1e-15. The pole term is precisely xP(delta); source rectangle zeros exclude the trivial zeros and0. Hence (1),(2) and2125^8<x0 give

    sqrt(Ep)<21/2125+1e-15+5e-12<.01.                         (3)

The adjacent Fraction script checks these scalar inequalities. The standard measurable finite-sum/Fatou and source-carrier bridges remain formal proof obligations.

The exact Gram kernel is

    G_W(rho,sigma)=integral W(delta) F(rho,delta)
                                      conjugate(F(sigma,delta)) ddelta.

For finite sums, Tonelli/Fubini after absolute-integrability checks yields

    G_W(rho,sigma)=integral_(t,u>0) etaPlus(t) etaPlus(u)
       t^(rho-1) u^(conjugate(sigma)-1) K_W(t-u) dt du,

    K_W(v)=sum_q mPhi(q) sin(2pi Dq v)/(pi v),
    K_W(0)=sum_q 2Dq mPhi(q).

The desired squared norm is exactly

    sum_(rho,sigma in S) m_T(rho)m_T(sigma)
      x^(rho+conjugate(sigma)-7/4) G_W(rho,sigma).              (4)

This finite-window operator is a faithful possible route. The oscillatory kernel and phases in (4) cannot simply be replaced by their absolute maxima without paying for coherent clusters.

For example, with w(rho)=(2-beta)/((2-beta)^2+gamma^2) and total mass M<=.07, weighted Cauchy--Schwarz gives the sufficient diagonal condition

    sum_rho m_T(rho) x^(2beta-7/4)
          G_W(rho,rho)/w(rho) <=6300.                         (5)

Then ||Z_T||^2<=.07*6300=441. A still stronger sufficient quartet bound would be

    ||Q_(beta,gamma,x)||_(L2(W ddelta)) <=300*w_quartet,

because300*.07=21. Q and w_quartet use all four reflected/conjugate points, with repeated terms at degeneracies as in BLUEPRINT_PRINCIPAL.md. The countermodel below rules out this uniform300 bound for all strip points, and shows why mass/count information alone does not prove (2).

Full-line Plancherel gives G_R(rho,rho)=integral etaPlus(t)^2 t^(2beta-2)dt, independent of gamma. It therefore destroys the necessary high-height localization. It is useful inside a genuinely finite-window or finite-height argument, not as an all-height diagonal summation bound.

## A concrete obstruction respecting multiplicity and all Jensen radii

Consider only the four formal points

    7/8+100i, 7/8-100i, 1/8+100i, 1/8-100i,

each assigned multiplicity15. They have the required conjugation and reflection symmetry and lie in the stipulated strip. Their total mass is

    15*[2*(9/8)/((9/8)^2+10000)
          +2*(15/8)/((15/8)^2+10000)]
      =147487104/16391834329 <.009<.07.                       (6)

They also satisfy every count upper bound supplied by zero_count_polyG with the source BPz2 and centers2+ic, radii0<r<10. A disk meeting these points has |c|>90 and cannot meet both signs of the imaginary part. If it contains both real parts at one height, then r>=15/8 and its total multiplicity is30. If it contains only one, its multiplicity is15 and r>=9/8. The exact rational inequalities

    BPz2(90)/.355 > (10/(15/8))^30,
    BPz2(90)/.355 > (10/(9/8))^15

establish the asserted counts by monotonicity. In particular the fixed3.48 windows also allow this model. This is stronger than checking only the coarse radius2.7 window bound.

These data do not describe actual known zeta zeros. They test the logical strength of the proposed strip/mass/count relaxation. A finite zero-free certificate excluding beta>=3/4 only through height40 would not exclude these formal points either.

## Finite-window energy of the model, for actual etaPlus

The following estimates make the obstruction independent of a numerical oscillatory quadrature. Write etaO(t)=[t(2-t)]^3 exp(-(t-1)^2/2) on[0,2], zero otherwise. Use the source-derived, as yet unformalized bridge from PointwiseSmoothingTail.md:

    |etaPlus(t)-etaO(t)|<=epsilon*t*exp(-t^2/2), epsilon=.00221.

Let a(t)=etaO(t)t^(-1/8), and let phi be any real phase. The compact leading pair is the Fourier transform of

    a(t)[exp(i(100 log t+phi))+exp(-i(100 log t+phi))].

First set A=integral a(t)^2 dt. For0<t<2, t^(-1/4)>=2^(-1/4)>.84. With v=t-1 and exp(-v^2)>=1-v^2,

    A >=.84 integral_-1^1 (1-v^2)^7 dv
      =28672/53625.                                         (7)

The cross integral C=integral etaO(t)^2 t^(-1/4+200i)dt has |C|<.02. To see this, substitute t=exp u and write H(u)=t^(3/4)etaO(t)^2. Its logarithmic derivative in t is

    27/(4t)-6/(2-t)-2(t-1),

which is strictly decreasing from+infinity to-infinity. Thus H is unimodal, vanishes at both endpoints, and sup H<2 because etaO^2<=1 and t^(3/4)<2. Hence its total variation is<4. One integration by parts against exp(200iu) gives |C|<4/200=.02.

By Plancherel, uniformly in phi the compact pair has full-line squared norm at least

    2(A-|C|)>55199/53625>1.01^2.                              (8)

This remains a finite-window lower bound. For each complex wave a(t)exp(+-100i log t), elementary differentiation gives squared derivative norm at most

    2*(784*4/19+49)+2*10001*(64*4/19+1)
       =5508684/19 <600^2.

Here on(0,1), |etaO'|<=28t^2 and etaO<=8t^3; on(1,2), |etaO'|<=7 and etaO<=1. Consequently the pair derivative norm is<1200. Fourier Plancherel with a derivative shows its norm outside[-200000,200000] is <1200/(2pi*200000)<.001.

The actual-minus-compact leading-pair norm, on the whole delta line, is at most

    2epsilon sqrt(integral t^(7/4)exp(-t^2)dt)<.00442.

The last integral is<1: on(0,1) use t^(7/4)<=t and on(1,infinity) use t^(7/4)<=t^2; the corresponding integrals are bounded by1/2 andsqrt(pi)/4<1/2.

At x=x0 the reflected pair has norm<8*x0^(-3/4)<1e-18. For this deliberately loose bound, each reflected wave etaPlus(t)t^(-7/8) has norm<4, using etaO<=8t^3 below1, etaO<=1 on[1,2], and the same Gaussian-tail bridge. Therefore the ACTUAL four-term normalized quartet satisfies

    ||Q||_(L2[-200000,200000])
       >1.01-.001-.00442-1e-18 >1,                           (9)

for every phase phi, including phi=100 log x0. This lower bound uses the true reflected phase and retains its small contribution through reverse triangle; no favorable phase assumption is needed.

Since W>=3 on that interval and the multiplicity is15, the formal spectral residual associated to these data has

    ||x0^(-1/8)*15Q||_(L2(W))^2
       >3*15^2*x0^(-1/4)
       >675/(5e6)=.000135>.0001,                             (10)

where x0<(5e6)^4. Coprime and vertical corrections of the sizes above cannot erase this strict margin. Even the quartet norm/mass ratio is >sqrt(3)/.0006, far larger than300.

This demonstrates an obstruction to proving the target by treating the permitted zero data as arbitrary. It does not refute the target for zeta: the actual zeros obey additional analytic and arithmetic constraints not encoded in this relaxation. Assuming simplicity alone is also insufficient for this relaxation: continuity permits replacing each multiple point by a sufficiently tight symmetric cluster of distinct points while preserving all strict inequalities. A quantitative spacing or density statement would be additional information.

## Consequence for the research route

The broad principal target needs new information controlling off-line zeros in the stationary height ranges, or a signed operator estimate using more of zeta than these aggregate upper bounds. Possibilities include a certified finite right-edge zero-free region plus a sufficiently strong high-height density bound, or a genuinely arithmetic estimate for the broad twisted residual. The existing local2750-cell certificate does not imply either one: it deliberately restricts delta to[-4,4], excluding the height100 stationary region that is included here.

The Gram identity (4), sufficient condition (5), and numerical allowance21 are usable handoff targets. They are not approved theorem types or extra assumptions for the final result. The adjacent major_upper_principal_constants.py checks all rational comparisons in (3),(6)--(10), including BPz2 thresholds, and exited0. It does not certify the analytic steps or assert actual zeta zeros.

## Source references

Pinned ternary-goldbach23b2d68:

- MajorArcs/L2Major.lean:309: existing combined lower/upper major-energy theorem; the new Ep/N decomposition is in prime-estimates/L2_REPLACEMENT.md.
- Explicit/EtaPlusMellin.lean: fP, norm_mellin_fP_uniform, goodSmoothing_fP and norm_mellin_fP_tail. The last tail theorem requires T0>=200+max(10pi|delta|,50); at the broad endpoint its threshold is about18.85 million, not250.
- Explicit/ZeroSumGen.lean: zero_count_polyG and sum_multRectD_le, with arbitrary radius below10.
- Explicit/ZetaPoly.lean:425: BPz2.
- Explicit/ZetaExplicit.lean:122: common-sequence unconditional explicit formula.
- Explicit/ExplicitBoundGen.lean:28,71: VgL and norm_integral_hZeta_le_gen.
- MajorArcs/EtaCirc.lean:33 and its P0/P1 formulas: compact etaO and derivative identities.
- MajorArcs/HHFourier2.lean:195 onward: source Fourier derivative energy used by the actual-tail bridge.

No theorem here removes the separate need to validate the global7/8 provider, weighted mass identity, Fourier inversion bridge, or the nonprincipal N estimate.
