# All-scale Q90090 small-twist extension

Research result, 2026-11-11. Source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical source edit was performed. This note gives an analytic reduction and an exact rational certificate. The Type I/II prime and Mobius producer obligations remain separate. Independent review is requested; no kernel-checked theorem is claimed.

## Result and remaining gap

For the reduced denominator q=90090 of 2alpha, the parameterized Type I/II route now supplies the unchanged etaStar base-gap comparison on

    y >= 10^25,
    1200000/49 <= u=q|Delta| <= 33000,
    2alpha=A/q+Delta/y modulo an integer,
    gcd(A,q)=1.

The comparison is conditional on exactly the original analytic inputs of `TypeITotal.typeI1_le`, `TypeI2Sum.typeI2_le_small`, and `TypeIITotal.typeII_637`. These are presently Platt-dependent source theorems. The analytic argument here neither discharges their inputs nor replaces them by an assumption of the desired conclusion.

Use the new Vaughan parameters on .05<=w<=2, the old raw first-choice bound on2<=w<=8, and the trivial coefficient17 on the two tails. The exact scalar comparison holds for every y>=10^25, with margin at least

    70212357/200000000000 = .000351061785.

A second certificate retains the original w cutoff2.5 and u<=26000. It has margin at least

    1305758681/1000000000000 = .001305758681

for every y>=10^25. It extends the earlier certificate whose scale was restricted to [10^25,1.1*10^25].

The normalization is the source one:

    |S_etaStar(alpha,49y)|/y
      <= integral_0^infinity B(wy)*w^2*exp(-w^2/2) dw
      <= ghatY(y,150000).

This preserves the large-case x=49y>=4.9e26 and the final10^27 endpoint. It adds no finite-coverage premise and does not change BinaryGoldbachInput.

The reviewed raw-tangent branch starts at u=26400000/49, approximately538775.5102. Consequently the interval

    33000 < u < 26400000/49

is still unclassified for q90090 by these two results. There is no overlap between the two twist bands. This denominator must not be added to the all-twist coverage count. The q=1 base gap is also untouched. `BASE_GAP_90090_MIDDLE.md` records the diagnostic obstruction in the remaining middle band.

## Source contracts

All paths below are relative to `work/ternary-goldbach/TernaryGoldbach/`.

* `MinorArcs/TypeITotal.lean:101`, `typeI1_le`, bounds Type I1 for real U under Approx2, sqrt3<=U, U<=min(z/4,z/e), U<=H/2. Its complete `bound_4_41` is retained.
* `MinorArcs/TypeI2Sum.lean:300`, `typeI2_le_small`, bounds Type I2 for real U,V under Approx2, qV<=H,16V<=H,U>=1,V>=2.5e7,UV<=z and |Delta_z|<=1/(2c2). Both `coefUV` and `coefQ*H` are retained.
* `MinorArcs/TypeIITotal.lean:331`, `typeII_637`, uses natural U,V, z>0,U>=1,V>=2e6,V<=z/U,3.5z/U<=H,2e q<=V and the rational approximation error. Both Type II remainders are retained.
* `MinorArcs/Assembly.lean:64`, `norm_S_le_parts`, combines the three terms and3logz for z>=1,V<=z/4.
* `MinorArcs/Prop1123.lean:30`, `norm_S_eta2_le_trivial`, supplies17z for every positive z from the unconditional Chebyshev bound. Its proof has no Fact PlattGRH binder. The convolution identity used here is the source `S_etaStar_eq`.
* `MinorArcs/TypeITotal.lean:24`, `muBound`, is1 up to2q^2 and then min(1,M/log(X/(2q^2))), where M=2.8*(2q/phi(2q)). Here M=2.8q/phi(q), since q is even.
* `MinorArcs/GBound.lean:25,29,33` and `MinorArcs/LinftyLevels.lean:351` define the unchanged consumer `ghatY`. The previously reviewed rational lower envelope is LOWA*R(y,300000)+LOWB, using the exact constants in `base_gap_binned.py`.

The full source expressions are transcribed in `BASE_GAP_90090_PARAMETERS.md`. This note proves a new all-scale upper envelope for those same expressions. The ten Type I/II producer interfaces remain tracked in the integration chapter. In particular, the prime squared-log sum, the .511 weighted von Mangoldt moment, the1.0064 psi bound, and the Mobius/Liouville inputs have not been removed by this certificate. The new unconditional nonprime1.4262 route being developed by prime_estimates would discharge that one coefficient, without changing the argument here.

## Parameters and integer floors

Put

    z=wy, T=z^(1/3), H=3T^2/4, phi(q)=17280,
    a=1/(144sqrt(180180)), b=72,
    epsilon=10^(-8), alpha=a(1-epsilon), beta=b(1-epsilon),
    U=floor(aT^2), V=floor(bT).

On w>=.05,y>=10^25 we have T>79000000. Since epsilon*aT^2>=1 and epsilon*bT>=1,

    alpha*T^2 <= U <= a*T^2,
    beta*T <= V <= b*T.

These brackets hold at all larger T. They are ordinary floor inequalities, not floating floor evaluations.

The source size hypotheses follow exactly as in the earlier parameter note. In particular qV<=H follows from96q<T; U>=T^2/61200-1>(14/3)T gives3.5z/U<H; UV<=abz<z; and V>=72T-1>2.5e7. The remaining upper bounds on U,V have much larger margins.

For the new band w<=2,u<=33000, wu<=66000, so |Delta_z|<=66000/90090<1/(2c2), where c2=6pi/(5sqrt32). The inequality is checked rationally with interval bounds for pi and sqrt32. The approximation error requires wu<4T/3, which holds with margin. For the old band w<=2.5,u<=26000 replace66000 by65000. On either upper-w region, w<=8 and u<=33000 imply |Delta_z|<8 and t=max(2q,wu/4)=2q. The existing raw first-choice formula therefore applies throughout the upper interval.

## Uniform treatment of the Type I logarithms

Let s=logT and M=2.8q/phi(q). The function muBound(X,q) is nonincreasing in X. Thus

    log(z/U)*muBound(U,q)
      <= (s-logalpha)*min(1,M/(2s+log(alpha/(2q^2))))

when the denominator is positive, with the minimum interpreted as1 otherwise. This right side increases up to the saturation point and decreases after it. Its global maximum is

    G1=M/2-(3/2)logalpha+(1/2)log(2q^2) <35.586.

For Type I2, H/(2V)>=T/192 and U>=T/192. Consequently min(H/(2V),U)>=T/192 and

    log(Vq)*muBound(min(H/(2V),U),q)
      <= (s+log(72q))*min(1,M/(s-log(384q^2)))
      <= G2=M+log(384q^2)+log(72q) <59.051.

Again the expression is1 times its logarithmic numerator until saturation. Afterwards its derivative is negative. These bounds address the entire unbounded scale range; replacing muBound by1 forever would incorrectly leave an unbounded logarithm.

The other Type I1 main terms use muBound<=1, minInv<=1 and logFourierBound<=2-log4. All their multipliers are nonnegative on the source domain. The actual script uses directed intervals for G1,G2, not the rounded display bounds35.586 and59.051.

## Decaying remainder bounds

For a w-bin [w0,w1], set T0=(w0*10^25)^(1/3). After normalization by z, every remaining Type I term and each Type II remainder is bounded at T=T0. The following details specify every replacement used by `constants(w0)` in the certificate.

Write p=ab, etaL=8log2, c1(T)=1+etaL*a/T and cPlus=1+etaL*p. Then c1 decreases. The Type I1 quadratic correction is bounded by

    32*(1/2-2/pi^2)*
      [a^2/(4qT^2)*log(sqrt(e)*T/alpha)+1/(eT^3)].

The normalized `bound_4_41` is bounded by

    2sqrt(32c1)/pi * a/T * log(eT/alpha)
    +q/T^3 * [6etaL/pi*logT
       +2sqrt(32c1)/pi*(sqrt3+.5log(2aT^2/q))*log(q/c2)]
    +1.5c1*sqrt(2/c2)/T^(3/2)*log(2T^3/c2)
    +20*32*c2^(3/2)*sqrt2/(3pi^2*T^(3/2))*log(2eT^3/c2).

Its omitted logPlus term is identically zero because aq/(c2T)<1. The other max(log(...),1) equals1 because its argument is at most e at T0 and decreases afterwards. These two facts are explicitly checked in the script.

The Type I2 quadratic correction is bounded by

    32*(1/8-1/(2pi^2))*
      [.511p^2/q+a^2*b*logq/T+1.022a*b^2/T^2+.511q*b^2/T^4].

Its main UV term is at most1.0064*coefUV(cPlus)*p. The remaining Q term is bounded by

    1.0064*(3/(4T))*[
      sqrt(32cPlus)/pi*(log(2aT^2/q)+1/e)
      +2etaL/pi+2sqrt(96cPlus)/pi+3cPlus/(2c2)
      +55*32*c2/(6pi^2)].

Here its max(log(...),1) is also1 throughout the range. The script verifies this at T0 and the argument decreases as T^(-2).

For Type II, set

    K(T)=2/pi^2+27/(alpha*sqrtbeta*T).

The normalized remainder is at most

    4sqrt(K(T)q/(2phi(q)))*[
      2/(sqrtalpha*T)
      +sqrt(log(2q))*(2e*sqrt(2q)/T^(3/2)
        +4/(sqrtalpha*T*sqrt(log(T/(2qa)))))]
    +8*1.4262*sqrt(K(T)*(.5+1/(alpha*T^2)))/sqrt(beta*T).

Each displayed remainder decreases for T>=T0. This follows term by term from

    d/dT [(A logT+B)/T^c]
      = [A-c(A logT+B)]/T^(c+1),

with c>0 and the positive logarithmic brackets at T0 already much larger than A/c. In particular logT0>18, log(2aT0^2/q)>2, and log(T0/(2qa))>17. Positive products of decreasing positive functions decrease. The last assembly term9logT/T^3 also decreases.

The certificate's E(w0) is exactly the sum of these Type I bounds, Type II remainders, and the assembly term at T0. It does not discard a source remainder.

## Compact scale variable and Type II main term

Let

    v=log(y)/3+log(9/601200),
    r=1/v,
    ar=log(1200000)/2,
    L=log(1/(alpha*beta)).

For y>=10^25, v>8 and0<r<=rmax. Including r=0 gives a compact interval that contains every finite scale. The added endpoint represents the limiting formulas and imposes no extra assumption on y.

The floor brackets imply lambda=log(z/(UV))<=L. Also

    log(V/(2q)) >= v+h(w0),
    h(w0)=log(beta/(2q))+log(w0)/3-log(9/601200)>0.

Use the exact identity

    Phi=log(2q)*log(1+lambda/log(V/(2q))).

It follows that the normalized Type II main term is at most

    sqrt((L+log(2q)*log(1+L*r/(1+h(w0)*r)))
         *(.60428L+.0924+216/(alpha*sqrtbeta*T0))
         /(2phi(q))).

This expression increases with r. The proof only needs d/dr[r/(1+hr)]=1/(1+hr)^2>0; it does not need any monotonicity of the full source expression in y.

On the upper-w bins the old raw logarithm has the analogous exact form

    C_z <= log(1+aq*r/(1+hr(w0)*r)),
    aq=log(8q)/2,
    hr(w0)=log(300000/(2q))+log(w0)/3>0.

The raw square-root product therefore also increases with r. Its normalized remainders are frozen at z=w0*10^25 by their elementary monotonicity. Finally the consumer lower bound is exactly

    LOWA*(.41415+.27125*log(1+ar*r))+LOWB,

which increases with r. These identities account for the decreasing allowance at larger y instead of reusing the endpoint allowance.

## Exact finite certificate

`resume_minor_allscale_certificate.py` divides [0,rmax] into128 intervals. It encloses rmax upward using rational bounds for log. On each interval it evaluates the upper envelope at the right endpoint and the consumer lower envelope at the left endpoint. Monotonicity then proves the comparison throughout the interval. This is interval coverage, not scale sampling.

The w interval [.05,8] is divided into159 bins of width.05. Both cuts2 and2.5 are bin endpoints. Each envelope uses the bin's left endpoint w0. The Gaussian bin mass is bounded with the reviewed Simpson remainder84*(w1-w0)^5/2880. The tails contribute

    17*.05^3/3+17*(65/8)*10^(-13).

All arithmetic deciding success uses exact fractions and outward rational rounding. Logs and roots use the reviewed utilities in `base_gap_binned.py`; pi uses Machin's identity and alternating arctangent sums; e uses its Taylor sum with remainder. The script imports those utilities from the earlier small-band certificate. Its JSON records all128 scalar cells for each cut.

For cut2.5 the worst cell is48, with lower gap1305758681/10^12. For cut2 the worst cell is55, with lower gap70212357/(2*10^11). All256 cells passed. No floating quadrature or sampled y value decides this result. `resume_minor_allscale_model.py` is a separate exploratory model and is not part of the certificate.

## Remaining proof work

The analytic domination above, rational log/root replay, Gaussian mass bound and source consumer application still need Lean proofs and independent review. The original prime/Mobius producers remain mandatory. The totient work in `TOTIENT_UPDATE.md` addresses other source uses; this central q90090 argument uses exact totients, while its upper-w raw branch still needs the first-choice replacement and other Type I/II inputs.

This result does not address the major nonprincipal or mixed residuals, the unclassified q90090 middle twists, q=1, or the full Mobius profile. Its completed mathematical contribution is a finite exact comparison that covers all scales in a strictly specified small-twist rectangle.
