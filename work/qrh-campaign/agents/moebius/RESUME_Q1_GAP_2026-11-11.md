# The remaining reduced-denominator-one base gap

Research, 2026-11-11. Pinned source `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, canonical source change, new axiom or new final hypothesis. This note gives an exact obstruction to the present positive Type I/II envelopes, an explicit sufficient arithmetic alternative, and the precise reason the current major certificate cannot absorb this interval. It does not prove a lower bound for the true exponential sum.


## Updated result: a complete conditional hybrid for q1

The obstruction below remains valid for the positive Type I/II route alone. A second argument now bypasses it using the SAME unproved finite beta<=111/200 spectral certificate already selected in the shared major-family research. The new exact budgets cover

    low twists: 1200000/49<=u<=190000, every y>=1e25,
    high twists: 190000<=u<=1200000, every y>=1e25.

The low branch has normalized upper bound<.04530054<.04712. The high branch has exact minimum comparison margin.000338635937. The two closed intervals meet exactly, so together they cover every permitted q1 twist. This is a conditional research implication, pending independent review. The finite spectral statement, global QRH provider/analytic bridges, and high-branch Type I/II producers must still be proved; none is admitted as a new final Goldbach assumption. No denominator count is changed here.

## Exact domain and scales

Here q=1 is the reduced denominator of2alpha. The original reduced denominator of alpha is1 or2. Put x=49y, y>=1e25 and write

    2alpha=A+Delta/y modulo an integer,
    u=|Delta|,
    1200000/49<=u<1200000.

The original additive twist at the smoothing scale y is delta_y=Delta/2, so

    600000/49<=|delta_y|<600000.

At convolution scale z=wy the Approx2 twist is delta_z=wDelta and D=|delta_z|=wu. The unchanged consumer is

    |S_etaStar(alpha,49y)|/y <= ghatY(y,150000).

On .05<=w<=8, D>=60000/49>1224. Every point lies in the large-twist regimes of both general Type I2 and Type II. The approximation condition wu<=4(wy)^(1/3)/3 holds throughout the full domain. The exact source geometry and transport are `MinorArcs/BaseGap2.gap_point:185`, `Prop1123b.norm_S_etaStar_le_of_pointwise:33`, and `LinftyLevels.ghatY:351`.

The Type I mu coefficient now uses2q/phi(2q)=2, whereas q/phi(q)=1. The q90090 even-denominator equality must not be reused. The obstruction below does not depend on either mu coefficient, so this distinction cannot remove it.

## An explicit sufficient source inequality

For each positive w in[.05,8], choose natural U,V and a real epsilon in(0,1] satisfying the existing general source contracts. Put z=wy, H=3z^(2/3)/4, p=UV/z, lambda=log(1/p),

    c=D*(1+z/(2UH))/4,
    Phi=log(c)*log(1+lambda/log(V/c)),
    K=2/pi^2+27sqrt(z/V)/U,
    cPlus=1+8log(2)*UV/z.

The conditions include U>=sqrt3, U<=min(z/4,z/e,H/2), V>=2.5e7, V<=z/4, UV<=z, V<=z/U, V<=H/16, V<=H, and c*e<=V. The source Type II640 also requires z<=H^2, which holds at the present scales. All logarithms in these expressions then have their source positive domains.

Let B1 be the exact RHS of `TypeITotal.typeI1_le:101`, divided by z. Its complete `bound_4_41`, actual phase minima and muBound are retained. Let B2 be the following fully normalized RHS of `TypeI2Large.typeI2_le_large:223`, specialized to q=1:

    B2 = .5*minInv(32,pi*delta_z)*muBound(min(H/(2V),U),1)*log(V)
       +32*(1/8-1/(2pi^2))/z^2*
          [.511U^2 V^2+.511(2U+1)V^2]
       +1.0064*(2sqrt(32cPlus)/pi)*(1+(1+epsilon)*(1+V/H)/e)*p
       +1.0064*(3cPlus/2)*(2+(1+epsilon)/epsilon*logPlus(2pD))*V/H
       +1.0064*(35*32*c2/(3pi^2))*H/z
       +(2sqrt(32cPlus)/pi)*(1+epsilon)*sqrt(3+2epsilon)*
          [(1.03883+logPlus(6pD/sqrt2))/D+1.0064V/z],

where c2=6pi/(5sqrt32). The Vq logq term vanishes because log1=0. This specialization does not remove the source1.03883 producer condition.

The exact Type II640 RHS, normalized by z and using zeta3<=27, is

    BII=2/sqrt(D)*sqrt((lambda+Phi)*(.60428lambda+.0924+216sqrt(z/V)/U))
       +4sqrt(K/(2z))*[2sqrt(z/U)+sqrt(logc)*
          (2e sqrtc+4sqrt((z/U)/log(z/(Uc))))]
       +8*1.4262*sqrt(K*(.5+1/U))/sqrtV.

This is `MinorArcs/TypeIITotalGen.lean:504`, `typeII_640`; the twist-insensitive `typeII_637` should not replace it in this q1 calculation.

The precise sufficient inequality from these source shapes is

    integral_(.05)^8 [B1+B2+BII+3log(wy)/(wy)]*w^2*exp(-w^2/2) dw
      +17*.05^3/3+17*(65/8)*10^(-13)
      <=ghatY(y,150000),                                      (S)

uniformly for every y>=1e25 and every permitted u. The choice U,V,epsilon may vary measurably with w,u,y. The ordinary source convergence and smoothing transport apply, since a finite bounded piecewise majorant on this compact w interval is integrable and the Gaussian tails are integrable. All analytic producer obligations of the three source inequalities remain; (S) is a sufficient research test, not a new allowed final assumption.

## The first obstruction is independent of Mobius

Two positive terms already prevent(S) for the smallest twists, even if every other term is removed. The UV term of B2 satisfies

    B2>=A*p,
    A=1.0064*(2sqrt32/pi)*(1+1/e)>4.9.

This uses cPlus>=1, epsilon>0 and V/H>=0. The Type II main term satisfies

    BII>=2sqrt(.60428)*lambda/sqrtD>1.55*log(1/p)/sqrtD.

Indeed0<p<=1, lambda>=0 and Phi>=0 because V<=z/U and c*e<=V. All other coefficients in the square root are nonnegative. This is an inequality about the explicit source RHS, not an additional inequality in the direction of the true exponential sum.

Minimize the sum of the two lower bounds over every real0<p<=1. SinceD>=1224, the minimizer

    p0=1.55/(4.9sqrtD)

lies below1. The elementary derivative calculation gives the parameter-independent floor

    B1+B2+BII+3logz/z
      >=F(D):=1.55/sqrtD*[1+log(4.9sqrtD/1.55)].              (F)

This allows more freedom than integer U,V and the source size restrictions. It is therefore a valid obstruction for every admissible parameter choice, including arbitrary pointwise changes and every epsilon>0. Taking epsilon towards zero, improving the Mobius profile, or deleting all Type I1 contributions cannot evade(F). The Type II coefficient and the Type I2 UV cost are the first bottleneck.

F decreases throughout the relevant D range. Therefore its integral against the positive Gaussian weight decreases with u. The adjacent `resume_q1_obstruction.py` proves exact lower integral bounds using positive rectangular lower sums on795 bins covering[.05,8]. It does not rely on Simpson sampling. On a bin[a,b], use

    F(wu)>=F(bu),
    w^2 exp(-w^2/2)>=a^2 exp(-b^2/2).

The exponential is enclosed upward by its rational Taylor polynomial plus geometric remainder, so its reciprocal is a lower bound. Logs and square roots use the previously reviewed directed rational utilities. Omitting the positive integral outside[.05,8] only weakens the lower bound.

The same script proves an upper bound for the actual source consumer at y=1e25:

    ghatY(1e25,150000)<=15067915811/250000000000
      =.060271663244.

It uses the source unconditional `SecondNumerics.exp_gamma_le_sharp`, e^gamma<=1.7882, so it does not require a numerical assumption about Euler's constant. It bounds both gx and hfun in the actual max definition. The looser upper allowance deliberately makes the obstruction harder to prove.

| u | certified integral lower bound | excess over consumer upper |
|---|---:|---:|
|1200000/49|.076708860141|.016437196897|
|33000|.067427071152|.007155407908|
|40000|.062031870588|.001760207344|

Every displayed number comes from exact fractions in the saved JSON. Since the lower bound decreases with u, the u40000 row shows failure of(S) throughout the entire interval1200000/49<=u<=40000 at y=1e25. A proposed all-scale proof through(S) must include this endpoint scale, so it cannot succeed as stated. No upper bound on the actual exponential sum has been disproved. A different decomposition, an estimate exploiting phase cancellation within these positive terms, or a different arithmetic argument may still work.

## A sufficient independent prime-counting alternative

The earlier `mellin/BASE_GAP_Q1_ALTERNATIVE.md` derives an alternative from the actual etaU convolution. Let psi_R(v) be the floor extension of the source natural-number psi. A sufficient conventional arithmetic inequality is

    |psi_R(v)-v|<=1.1*10^(-8)*v for every v>=exp45.            (P)

It is a target to prove, not an additional hypothesis to attach to Goldbach. The exact moments of etaU give

    integral t*etaU(t)dt=9/8,
    integral t*|etaU'(t)|dt<6.27.

Stieltjes partial summation, with all endpoint and small-v contributions retained, yields uniformly

    |S_delta(y)/y-Fourier(etaU)(-delta_y)|
      <=1.1e-8*(6.27+(9pi/4)|delta_y|)+1e-12.

The Fourier term is<7e-9, and the original-denominator2 correction is<4e-9. Thus(P) would imply the full q1 target with normalized upper bound<.046673, below the reviewed uniform ghat lower bound.04712 at every scale. The lower-v region uses an elementary bound and actual smoothing vanishing, so(P) does not hide an additional finite-coverage assumption.

No current campaign result supplies(P) without the excluded finite-height RH input. The source-shaped Mobius weakening under investigation is not a substitute for(P), and(F) explains why strengthening only the Mobius terms cannot close this positive Type I/II route. The older exact scalar script `mellin/base_gap_q1_pnt_constants.py` checks the arithmetic; it does not prove(P).

## Why current major certificates do not absorb this gap

The scale conversion is essential. The original major-arc twist is

    delta_x=(alpha-a/q_original)*x=49delta_y=49Delta/2.

The q1 base gap therefore corresponds to

    600000<=|delta_x|<29400000.

It is not an extension from twist4 to twist12244 in the same normalization. The reviewed principal local lower-energy certificate in `mellin/JointPrincipalL2.md` covers only|delta_x|<=4, for the actual etaPlus smoothing and an L2 norm. It supplies neither a pointwise etaStar estimate nor the cubic contribution of additional arcs.

The latest shared-family principal route in `major-constants/RESUME_FAMILY_CAPS_2026-11-11.md` and the principal corollary of `RESUME_CUTOFF_OPTIMIZATION_2026-11-11.md` targets the current principal support|delta_x|<=600000. Its finite beta<=.555 input remains unproved. The older translated-mass beta<=2/3 proposal in `mellin/RESUME_PRINCIPAL_2026-11-11.md` is a distinct alternative. Neither supplies a major-arc estimate on any open interval beyond the boundary600000. Its high-height tail condition already requires height at least200+10pi|delta_x|. Extending to the full endpoint29400000 would require an outer height beyond approximately923 million even before checking the low-height estimate and its error budget.

Even covering just the rigorously obstructed subinterval u<=40000 by enlarging major arcs requires reaching|delta_x|=980000, a factor49/30 beyond the current600000 boundary. The local[-4,4] certificate provides no estimate there. Enlarging a set increases its nonnegative L2 integral, but the cubic major integrand has a real part of variable sign. Therefore the existing lower cubic bound does not automatically survive the addition. One must supply a new signed cubic/error estimate on the added arcs, update the mixed/principal budgets, and recheck the disjointness and measure arguments.

The present major-arc estimates therefore do not absorb this region by enlarging the arcs. However, the same finite spectral contract can be consumed afresh in a pointwise etaU estimate, as proved below. That does not enlarge the major arcs or reuse a certificate outside its proved smoothing/twist domain.

## Status and concrete next step

The completed new result is the exact lower obstruction(F) for the source envelopes and its comparison with the actual consumer. It explains why the successful smooth-denominator P128 rectangle does not extend to q1 merely by parameter tuning or stronger Mobius constants.

A viable continuation must change a leading estimate: reduce the Type II main cost or the Type I2 UV cost by an argument using more cancellation, prove a signed explicit-formula estimate in the stationary-height region, or establish an arithmetic estimate such as(P). The current major-arc certificate supplies no such change. All frozen coverage certificates remain untouched, and this note changes no denominator count or final theorem hypothesis.

## New low-twist estimate under the same shared finite certificate

Assume, only as the existing unresolved research contract, that every actual nontrivial zeta zero through the shared plus height has beta<=111/200. The selected original plus height is60343058; the proposed optimized height41485915 also suffices for the new argument. No height beyond either existing profile is requested. The genuine global7/8 provider and reflection supply1/8<=beta<=7/8 at all heights. Neither global QRH alone nor the older local major-energy certificate implies the finite.555 condition.

For this low band, the actual etaU twist is

    d=delta_y=Delta/2,
    600000/49<=|d|<=95000.

It is not d/49 again. The identity from `BaseGap2.S_etaStar_eq_expTsum:230` is

    S_etaStar(alpha,49y)=sum_n Lambda(n)*etaU(n/y)*e(nalpha).

For original denominator1 this is the ordinary twisted von Mangoldt sum at d/y. For original denominator2, its numerator is odd and the exact parity identity is minus that sum plus twice its even-prime-power part. The existing elementary noncoprime bound contributes at most4e-9 after normalization by y.

Choose a new pointwise splitting height

    H=ceil((484/7)*95000)=6568572.

This is larger than the old star cutoff1231487, which could not be reused at the enlarged effective twist. It is nevertheless less than both shared plus heights. Since pi<22/7, H>=22pi|d| for every twist in this band. Low zeros through H therefore satisfy the SAME already selected finite certificate; this argument introduces no separate spectral assertion.

### Fresh off-line count and the actual smoothing

Use `Explicit/ZeroSumGen.sum_multRectD_le:59` with radius3 on windows of length3.48. If0<beta<1 and|gamma-c|<=1.74, then

    (2-beta)^2+(gamma-c)^2<4+1.74^2<9.

The zeta polynomial `Explicit/ZetaPoly.BPz2:425` satisfies

    BPz2(H+3.48)/.355<(10/3)^400,

as checked by exact rational arithmetic in `resume_q1_finite_budget.py`. Thus every such window has multiplicity<400, without assuming beta=1/2. In particular `count_line_windowG`, whose hypothesis is critical-line equality, is NOT invoked. Covering[-H,H] gives

    N<=ceil(400*(2H/3.48+2))=1510017352.

For the actual etaU=eta2*_M phi smoothing, uniformly for every real d and1/8<=beta<=7/8,

    |F_U(beta+i gamma,d)|<=Mellin(etaU)(beta)<4.

Indeed Mellin(eta2)(beta)<=4(log2)^2<2. The Gaussian moment integral t^(beta+1)exp(-t^2/2)dt is at most sqrt(pi/2)<1.254, by weighted AM-GM between beta0 and beta1. Their product is<2.508<4. This uses the actual compact eta2 mixture and Gaussian kernel, not a surrogate smoothing.

The normalized low zero sum is consequently bounded by

    4N*y^(-89/200).

For every y>=1e25, y^(-89/200)<=7.5e-12. The script verifies the endpoint inequality by raising positive quantities to the200th power. Thus the low contribution is at most

    566256507/12500000000=.04530052056.

All phases y^(i gamma) and all multiplicities are retained by the triangle inequality. This bound is uniform over the entire infinite scale range, without evaluating a signed sum at one y.

### High zeros and vertical contour

Above H use the global reflected QRH strip and the actual etaU Gaussian-mixture tail. The reviewed new22pi argument in `major-constants/RESUME_CUTOFF_OPTIMIZATION_2026-11-11.md` applies with the enlarged effective twist dmax95000. Its star geometric-window factor must be recomputed: use

    G=3+95000/2.7,
    each geometric window sum<=803G.

It is incorrect to reuse the smaller four-million bound from the old star twist range. The new script includes the full enlarged factor. The off-line tail source is `ZeroSumGen.count_tail_windowG:121`, which requires only0<beta<1, counts both signs and multiplicities, and has radius3. The exact polynomial inequality gives Z3g(BPz2,H)<400, while c3g(10,H)<53/H follows from log(10/3)>1 and44<53.

The Gaussian EA envelope at ratio22 is<2e-20. Its coefficient, with the actual eta2 mass bound2, is at most2*(803G)*2e-20. The EB coefficient is bounded by

    2*.892*250*(5*250+2500)*exp(-.1598*250)<1e-11,

using the reviewed decreasing polynomial-exponential envelope for all heights>=250. After normalization, y^(-1/8)<1/1333, so the combined high-zero contribution is<1e-14. The exact script certifies the exponential comparisons with positive rational Taylor sums. The analytic Gaussian tail bounds and geometric summation are the same reviewed bridges as the shared family route, now evaluated at the correct larger twist.

For the actual etaU vertical contour, the derivation in `mellin/BASE_GAP_STATIONARY.md`, final section, gives

    |normalized vertical remainder|<=5e16*y^(-3/2)

uniformly for|d|<=1.2e6. It comes from the Gaussian source contour bound, the actual eta2 Mellin factor A(-1/2)<2.746, and the source Cor713 vertical constant. Our d<=95000 lies in that domain. At y>=1e25, the weaker rational upper bound5e-21 suffices. Zeta has no zero at0, already source-proved, so no artificial zero-origin term is needed.

All estimates apply to each finite source zero rectangle with its true multiplicities. The high tail proves absolute convergence; the uniform bounds pass to the same good-height sequence in the source explicit formula. The etaU GoodSmoothing, convolution/Fubini and contour-limit bridges remain to be formalized. They cannot be replaced by an assumed explicit formula with arbitrary zeros.

### Pole, parity, and final finite-band budget

The pole contributes exactly Fourier(etaU)(-d). The source Fourier bound gives

    |Fourier(etaU)(-d)|<=1.016/d^2<7e-9.

The denominator2 parity correction contributes at most4e-9. Therefore the exact combined budget is

    .04530052056 + high_tail + vertical + 1.016/(600000/49)^2 +4e-9
      <.04530054<.04712<=ghatY(y,150000).

`resume_q1_finite_budget.py/.json` exited successfully and records all rational terms. The displayed total before upward simplification is approximately.04530053133616165; the asserted rational cap is.04530054. This is a complete conditional sufficient estimate for the low band, with the same shared finite certificate as the major-family route.

## High twists: an exact all-scale raw certificate

For190000<=u<=1200000 use the original raw first-choice envelope on .02<=w<=8. The source inputs remain conditional on the separately tracked Type I/II producers. Here q=phi(q)=1 and t=wu/4. Thus950<=t<=2400000, and z=wy>=2e23.

For fixed z, the raw envelope decreases with t on this rectangle. To prove this for its main square-root product, set

    ell=logt, v=log(9z^(1/3)/(2.004t)),
    a0=ell/2+log2, C=log(1+a0/v),
    A=C*(ell+.002)+a0, B=.30214ell+.7468.

We have ell>6 and v>4. Differentiating with respect to ell gives

    C'=(v/2+a0)/(v*(v+a0))<1/v.

Since A>=(C+.5)ell, B>=.30214ell,

    A'/A+B'/B
      <=2/ell+(2/v)*(1+.002/ell)<1.

Therefore AB/exp(ell) and its square root decrease. The reciprocal square-root and reciprocal terms decrease; the remaining(logt)/t terms decrease because ell>1. The z-only remainders do not change with t. This proves that every u in the high interval is bounded by the same raw envelope at u=190000. The exact script checks the scalar conditions using T>58000000,950>3^6, and9T/(2.004*2400000)>81>e^4.

Now partition[.02,8] into399 bins of width.02. On each bin use tmin=w0*190000/4 and tmax=w1*190000/4. Bound C at z=w0*y,t=tmax and freeze it. With C frozen, the same raw product decreases in t because its logarithmic derivative is at most2/ell<1; evaluate the other terms at tmin.

The all-scale C bound again uses

    r=1/(logy/3+log(9/601200)),
    C<=log(1+aq*r/(1+hr*r)),
    aq=log(4tmax)/2,
    hr=log(300000/tmax)+log(w0)/3.

Here hr may be negative, but every denominator1+hr*r stays positive throughout[0,rmax], checked exactly. The expression still increases with r because the derivative of r/(1+hr*r) is positive. The consumer lower envelope also increases with r. Evaluate the upper bound at each r-cell's right endpoint and the lower allowance at its left endpoint. The Gaussian bin masses retain their explicit Simpson remainder, and the two tails contribute17*.02^3/3+17*(65/8)*1e-13.

`resume_q1_high_certificate.py/.json` checked all128 r-cells with exact fractions and directed log/root bounds. Every cell passed. The worst cell is0, including the limiting r=0 endpoint, with certified margin

    338635937/10^12=.000338635937.

This proves the scalar comparison for every finite y>=1e25, not merely sampled scales. Both branches contain u190000, so their union covers the complete q1 gap without a missing endpoint. The original finite-strip and analytic producer conditions are still unresolved campaign obligations; this result provides a compatible q1 branch of that same proposed proof package.
