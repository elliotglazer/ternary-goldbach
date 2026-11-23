# Actual etaU Mellin transform in the stationary-height band

Research only; no Lean compilation or source implementation. This chapter derives signed contour envelopes for the actual eta2–Gaussian convolution, states an explicit zero-window summation target, and tests its scale. It does not prove the principal Q=1 base-gap branch. The current absolute-value local-count route is quantitatively inadequate; a density improvement near the right edge, cancellation, or a different arithmetic estimate is still needed.

## Domain and available budget

Use the reduced denominator Q for 2alpha from BASE_GAP_HYBRID.md. At scale y=x/49>=1e25 the twist D=|delta| satisfies

    600000/(49Q) <= D <600000/Q.

For Q=1 the original modulus is q=1 or2, and all primitive character zeros are zeta zeros. The twist interval is [12244.8979...,600000). For Q=101, q=101 or202, and D is in [121.2366...,5940.5941...). The inducing-character weights must use the original q, not Q.

The major-constants variable-budget calculation gives the sufficient all-y target

    weighted absolute zero coefficient + scaled contour remainder <=79.       (Z)

Its definition subtracts the paper main-term allowance .000481 and coprime-removal allowance .000001098 from ghatY(y,150000), then multiplies by y^(1/8). The resulting lower bound is >79.11. Thus (Z) has room for a small contour remainder. It is not enough to prove an unweighted per-character bound79 for every nonprincipal character: the exact Gauss weights remain.

For q=1 the coefficient in (Z) is simply sum_rho m_rho |F(rho,delta)|. For q=101 the total primitive weight divided by phi(q) is 99*sqrt(101)/100, about9.95. A common bound for those primitive-character coefficients would therefore need to be less than about7.94 even before allocating the principal and remainder terms. The q=202 reconstruction has corresponding induced weights. These are sufficient absolute-value budgets, not claims about the signed sum's true magnitude.

## Exact transform and convolution

Let phi(t)=t^2 exp(-t^2/2), etaU=eta2 *_M phi, and

    F(s,delta)=integral_(u>0) etaU(u) u^(s-1) exp(2pi i delta u) du.

This is the smoothing appearing in MajorArcs/Cor713.lean and MinorArcs/BaseGap2.lean; there is no extra division of delta by49. For beta=Re s>-2, Fubini and u=r t give

    F(s,delta)=integral_(1/4)^1 eta2(r) r^(s-1) G(s,delta*r) dr,              (C)
    G(s,d)=integral_(t>0) t^(s+1) exp(-t^2/2+2pi i d t) dt.

The source G is `Explicit.Gr s d 0`, identified with the Mellin transform of `Explicit.fδ` in Explicit/GMellin.lean:22. The eta2 support and nonnegativity are essential: neither smoothing is replaced by a compact surrogate.

Write

    A(b)=Mellin(eta2)(b)=4*((1-2^(-b))/b)^2,
    H(b)=Mellin(etaU)(b)=A(b)*2^(b/2)*Gamma(1+b/2),

with the removable value A(0)=4(log2)^2. For 1/8<=beta<=7/8, A(beta)<=A(0)<2 and the Gaussian moment 2^(beta/2)*Gamma(1+beta/2)<=sqrt(pi/2)<1.2534. Consequently |F|<2.5068 at every height.

## Signed rotation, without discarding the sign of delta*gamma

The source contour identity is `Explicit.Gr_eq`, Explicit/MellinRotate.lean:346, for |theta|<pi/4 and beta>-2. Its exact norm formula `norm_Jr` at line56 gives

    |G(beta+i gamma,d)|
      <=exp(-theta*gamma)*integral_0^infinity
            t^(beta+1) exp(-cos(2theta)t^2/2-2pi*d*sin(theta)*t) dt.          (R)

Choose the rotation sign to match gamma. Put tau=|gamma|, 0<theta<pi/4, c=cos(2theta), and r in[1/4,1]. If delta*gamma>=0, the linear term damps the integrand. If delta*gamma<0, it grows as exp(b_r t), with b_r=2pi*D*r*sin(theta). Formula (C) retains the eta2 average of (R); replacing b_r by b=2pi*D*sin(theta) gives a convenient uniform envelope.

### Favorable sign: a genuinely small bound

For delta*gamma>=0 use theta=.28 with the common sign of delta and gamma; at gamma=0 choose the sign of delta. Since r>=1/4,

    2pi*D*r*sin(.28) > .43D.

This follows from pi>3.14 and sin(.28)>=.28-.28^3/6. Drop the Gaussian factor, integrate the resulting Gamma integral, and use Gamma(beta+2)<=2. For .43D>=1,

    |F(beta+i gamma,delta)|
      <= 4*(.43D)^(-17/8)*exp(-.28tau).                                  (F+)

For zeta, combine this directly with the positive mass sum m_rho w2(rho)<=.07, where w2=(2-beta)/((2-beta)^2+tau^2). The elementary maximum of tau^2 exp(-.28tau) is 4/(.28^2 exp2). Since exp2>7 and beta is in[1/8,7/8],

    exp(-.28tau)/w2(beta+i gamma) <10.

Thus the entire favorable-sign zeta contribution is at most

    2.8*(.43D)^(-17/8).                                                   (SF+)

It is negligible at the Q=1 twists. This proof uses no first-zero gap. Applying it to nonprincipal characters requires their own positive mass bound, not the zeta value .07.

### Opposite sign: a usable all-height envelope, but too broad

For beta in[0,1], t^(beta+1)<=t+t^2. Define

    J0(c,b)=integral_0^infinity exp(-ct^2/2+bt)dt
           <=sqrt(2pi/c)*exp(b^2/(2c)),
    J1=(1+b*J0)/c,
    J2=(J0+b*J1)/c.

Integration of the derivative of the Gaussian gives the last two identities. From (C) and (R),

    |F| <= E_theta(tau,D),
    E_theta=2exp(-theta*tau)*[
       1/c+b/c^2 +(b/c+1/c+b^2/c^2)*sqrt(2pi/c)*exp(b^2/(2c))].            (F-)

This envelope holds for every opposite-sign height. A practical fixed choice is

    theta=min(.28,tau/(4pi^2 D^2)),

with theta=0 interpreted by its continuous bound at tau=0. It has Gaussian-type decay in tau/D until the cap is reached, and exponential decay thereafter. One may take the infimum over other allowed angles or retain the r integral in (C) to improve constants. Neither operation creates a D^(-1/2) stationary-phase gain by itself.

An additional low-height envelope is the independently reviewed twice-IBP formula from BASE_GAP_QRH.md:

    |F(s,delta)| <= A(beta-2)*2^(beta/2)*Gamma(1+beta/2)/(2pi D)^2
        *[|s(s+1)|/beta+|2s+3|+beta+2].                                  (IBP)

A simple uniform version replaces A(beta-2) by9, the Gamma factor by1.2534, and the bracket by

    8*(tau+7/8)*(tau+15/8)+2tau+61/8.

Take the minimum of this bound, 2.5068, and (F-). This gives a completely explicit all-height candidate E(tau,D), with no unproved zero information. Formula (IBP) is useful below the stationary band, but its quadratic growth prevents using it alone in an infinite zero sum.

## An exact window target using source-proved counts

Set h=3.48 and partition the unfavorable-sign heights by tau in[kh,(k+1)h). The rectangle zeros have beta in[1/8,7/8]. Every such window lies in the disk of radius2.7 centered at2-i(k+1/2)h when delta>0, or its conjugate when delta<0. Indeed (15/8)^2+1.74^2<2.7^2.

`Explicit.sum_multRectD_le`, Explicit/ZeroSumGen.lean:65, therefore gives the local multiplicity cap

    C_k = log(BPz2((k+1/2)h)/.355)/log(10/2.7),

where the exact source polynomial is

    BPz2(T)=9200*(|T|+22)*(1.25*(|T|+11))^9
             +20*(|T|+22)^3*(1.25*(|T|+11))^2.

No critical-line count is being used. The needed explicit sufficient principal inequality is

    2.8*(.43D)^(-17/8)
       +sum_(k>=0) C_k*sup_(kh<=tau< (k+1)h) E(tau,D)
       +scaled_vertical(D,y) <=79                                      (WINDOW)

uniformly for D in[600000/49,600000) and y>=1e25. At gamma=0 assign the zero to the favorable side only, to avoid double counting. Multiplicities remain in the source count; no zero-spacing or simplicity claim enters (WINDOW). The fixed-angle exponential tail makes the series convergent, so a finite truncation plus explicit geometric/polynomial tail bound is available.

For characters of conductor101, the analogous window bound must use the character PolyDatum and then the exact Gauss-weighted reconstruction. Substituting zeta BPz2 for those characters would be invalid. Global positive mass can additionally constrain the window allocation, but should be imposed jointly; applying its full .07 allowance independently to each window throws away the constraint.

## Why the current window/contour route does not close Q=1

`base_gap_stationary_diagnostic.py` evaluates the explicit envelope and two distinct diagnostics. They are not interval certificates, and no acceptance theorem is inferred from their decimals.

At Q=1 and D=600000/49, the opposite-sign height tau=2pi D corresponds to about76937. The envelope E is still2.5068 there. It remains2.5068 at tau=2*(2pi D), drops to about.0353 at tau=4*(2pi D), and to about4.6e-12 at tau=8*(2pi D). The source multiplicity cap at the central height is about95.2 per interval of length3.48. A continuous proxy for the sum in (WINDOW), using the source count formula and the stated envelope, is about1.48e7, against a target79.

This proxy is not a rigorous evaluation of (WINDOW), but the discrepancy is not a small tail or rounding issue. The contour bound lacks stationary-phase amplitude decay. Replacing it by an accurate oscillatory bound is mathematically worthwhile; the next calculation shows why even that alone is unlikely to close the branch.

For delta=D>0 and gamma=-2pi D v with fixed v>0, stationary phase for the actual integral gives the leading term

    |F(beta-i2pi D v,D)| approximately etaU(v)*v^(beta-1/2)/sqrt(D).

This is a large-D asymptotic on bounded v intervals away from0, not a certified error estimate at the concrete twists. If one uses the leading zeta height-density model (2pi)^(-1)log(tau/(2pi)), its integrated absolute coefficient is approximately

    sqrt(D)*[H(beta+1/2)*log D+H'(beta+1/2)].                             (MODEL)

At beta=7/8, H(11/8) is about1.165918 and H'(11/8) about-.161840. The model coefficients are:

| Q | twist | single-character zeta-density model | half-density right-edge model |
|---:|---:|---:|---:|
|1|600000/49|1196.51|598.25|
|1|600000, limiting endpoint|11890.32|5945.16|
|101|600000/(49*101)|59.81|29.90|
|101|600000/101, limiting endpoint|768.40|384.20|

The half-density column respects the required reflection partner at real part1/8: placing all zeros at7/8 would violate symmetry, so at most half of such an off-line inventory is at the right edge. The left partner is strongly suppressed by y^(beta-7/8); using the half-density column avoids a spurious factor2 in the diagnostic. This is a counterfactual density model, not a statement that actual zeta zeros lie off the critical line.

For Q=101, multiplying even the optimistic half zeta-density value by99sqrt101/100 gives about297.5 at the minimum twist, already above79. The actual conductor101 leading density is larger, roughly replacing log D by log(101D). Thus that table is optimistic for the character family. It cannot serve as an actual character zero count.

Mellin-Plancherel and Sobolev window averaging improve the crude O(D log D) envelope to the natural O(sqrt D log D) scale, but do not by themselves remove the discrepancy seen in (MODEL). A bounded low-zero gap or a better strip only below height40 is irrelevant to the Q=1 band near height10^5–10^7. The positive mass bound at s=2 is also weak there: a density-sized inventory at height comparable to D uses only O(log D/D) of the mass budget.

These observations reject the present absolute-value recipe as a completed Q=1 argument. They do not prove that no refined use of actual local zero information could succeed, and they are not a lower bound on the signed explicit-formula sum. Oscillations of y^(i gamma) may cancel. A pointwise cancellation computation at y=1e25 would, however, need a separate uniformity argument for all larger y.

## Explicit-formula remainder and what is still required

The actual etaU smoothing can be given a GoodSmoothing interface by integrating the Gaussian interfaces over r in[1/4,1]. On Re s=-1/2, `norm_G_uniform` and A(-1/2)=16(sqrt2-1)^2<2.746 imply

    |F(-1/2+i tau,delta)| <=308 exp(-thetaD(delta)*|tau|),
    thetaD(delta)=.28/(1+|delta|).

Here thetaD(delta*r)>=thetaD(delta); this direction matters. The source Cor713 `Vz_le` bounds the corresponding112-prefactor zeta vertical constant by1e17 for |delta|<=1.2e6. Scaling by A(-1/2) bounds the etaU vertical integral constant by2.746e17. After division by2pi and by y, a safe normalized remainder is5e16*y^(-3/2), or scaled remainder5e16*y^(-11/8) in (Z). At y>=1e25 this is below1e-17. Thus vertical contours do not account for the failed stationary budget.

The pole residue is y*F(1,delta), exactly the Fourier main term already allocated in the variable budget. The nontrivial rectangle zeros exclude zero and the negative even trivial zeros by the source zeta classification. The future etaU GoodSmoothing and convolution bridge must justify Fubini, differentiability and the pointwise limit; they cannot be replaced by an assumed error formula.

Concrete remaining alternatives are:

1. A height-dependent right-edge zero-density bound strong enough in tau comparable to D, with exact principal and character-family weights. This is stronger information than the generic Jensen window caps used above.
2. A cancellation-sensitive explicit-formula estimate uniform in y, rather than the sum of absolute Mellin terms.
3. A different direct arithmetic bound for the small-denominator, large-twist regime, perhaps refining the fixed-approximant Type I/II route. The existing final eta2 bound is too coarse in the low-Q diagnostics in BASE_GAP_HYBRID.md, but that is not a limitation theorem for all arithmetic methods.

The strongest concrete output here is the signed contour derivation (C), (F+), (F-), the explicit all-height envelope and target (WINDOW), and a clear identification of the stationary obstruction. No complete principal Q=1 or Q=101 base-gap branch is claimed.
