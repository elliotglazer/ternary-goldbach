# Independent review: joint principal plateau at H=88,000,000

Date: 2026-11-11. **PASS for the stated paper implication; no correction required.** Assuming actual RHBelow 88,000,000, the proposed parameters give the unchanged plateau for every real x>=1e17. This is not a lower complete principal target, numerical RH evidence, or a new kernel-checked theorem.

## Reviewed inputs and independent checks

| File under `work/qrh-campaign/agents/integration/` | SHA-256 |
|---|---|
| `PRINCIPAL_JOINT_PLATEAU_CANDIDATE_2026-11-11.md` | `CDE39E8AFDB868AFE2F5258BD154C79A36D43F1DBB0EE527DA633BD452EC0BB8` |
| `principal_plateau_joint_candidate_20261111.py` | `0FF34B0508C8A268C9AF99C31DFE79D298A66B237671CE8F132F63FEC689A0FF` |
| `principal_plateau_joint_candidate_20261111.json` | `91C743E7070DEE7CED577B3243489A55858B2BD8177992210EDD31505D52FBC5` |

I read the complete note and scalar program, then independently reconstructed all 21 stored rational values and all 25 scalar comparisons using Fraction arithmetic. The exponential witness was independently formed as the sum of powers divided by factorials, rather than the author's successive-term recurrence. All values matched and all comparisons passed. All seven source hashes and three packet hashes matched disk. No author program was imported or run, and no analytic function or zero was evaluated.

Source bodies inspected include the generic Gaussian error and both unsmoothing theorems, the exact line/tail/vertical definitions, the Gaussian tail proof, and the line and vertical estimates used by the old plateau. The source boundary remains the existing explicit formula, smoothing, Jensen counting, log/pi estimates and exponential-series facts. This review does not reprove those foundations or establish elaborated axiom closure.

## 1. Actual source contract and parameters

The tuple is

    H=88,000,000, K=13/2, delta=13/176,000,000,
    a0=K*delta=169/352,000,000, y0=1e10,
    b=log(y0/x).

`Explicit/PsiExplicit.lean:120–207` proves the actual Gaussian error from H>0, RHBelow H, delta>0, b<=a, b<=0 and x>=1. It does not require H>=1e8. Its finite zero sums are bounded before taking the explicit-formula limit. Its line part uses the closed RH range abs(gamma)<=H, and its Gaussian tail treats the full strip with abs(gamma)>H. No zeros at the dividing height are omitted, no tail RH is assumed, and multiplicities remain those of the actual source carrier.

Thus neither `rh_upto_1e8` nor the separately reviewed lower-height WeilWindow adapter is used to obtain this particular plateau. The old plateau theorem itself is not invoked with substituted constants.

## 2. Line and vertical terms

`PsiExplicit.LineB2H:110` contains the nonnegative weighted window sum over JlH(6,H). Since H<=3e10, its range is a subset of the range in `PsiPlateau.window_sum_le:204`; the summands have the same centers and are nonnegative. The source theorem's actual height is 3e10, regardless of the neighboring historical prose. The bound 571 can therefore be reused without computing new window values.

For either sign of a0, the source elementary exponential bounds give

    exp(delta^2/2)<=1.000001,
    exp(a/2)<=1.000001,
    exp(b/2)<=0.000317.

For the middle inequality use a/2<=abs(a)/2 and exp(t)<=1+2t at t=abs(a)/2. The exact line majorant is consequently

    1.000001*(1.000001+0.000317)*1142 <1143.

The vertical integral is reconstructed from the formula for Vg, including its 1/delta dependence and the outside x^(-1/2)/(2pi). The identity exp(-b/2)=sqrt(x)/1e5 cancels the growing part of the endpoint contribution. The source estimates 2/log(2)+4.8<=7.6856, sqrt(2pi)>=2.5066 and sqrt(x)>=3.16e8 give

    7.6856*82.6*1.000001/(delta*2.5066)
      *[1.000001/(3.16e8)+1e-5] <37000.

This is a constant error over the whole real x-domain. It is not an additional coefficient of x. The new delta was used explicitly, so the old fixed-delta vertical theorem is not silently transplanted.

## 3. Gaussian tail at the new height

The source `ZetaZeroSums.tail_sum_gauss:530ff` is valid at arbitrary positive H and delta. Above H it uses x^beta<=x for x>=1 and beta<1; it does not require beta=1/2. Its definitions are

    EBg=2 exp(delta^2/2+abs(a))*exp(-delta^2 H^2/2)/H,
    rhoG=exp(-4.4 delta^2 H).

With t=4.4 delta^2 H and r=t/(1+t)>0, exp(t)>=1+t gives 1-rhoG>=r. The source log bound and count monotonicity yield Z3g<=210.6 and c3g<=36.6/H. These estimates retain both the constant and the linear-in-window multiplicity terms. Using abs(a)<=a0 gives the exact prefactor

    Ctail=(2*1.000001/H)*[421.2/r+(73.2/H)/r^2] <5.

The identity delta*H=K gives exp(-delta^2 H^2/2)=exp(-169/8). The degree-80 positive Taylor polynomial P80 satisfies

    exp(169/8)>=P80>10^10/7.

The second inequality is an exact rational comparison, not a floating-point evaluation. Positivity then gives g=exp(-169/8)<7e-10 and hence TailBH<3.5e-9. The old theorem `TailBH_1e8_le` is correctly not used.

The complete error at both signs of a0 is therefore at most

    1143 sqrt(x)+3.5e-9 x+37000.

## 4. Both unsmoothing directions

The upper theorem is `PsiLarge.psi_upper_of_err:296ff`; its K is a real parameter. Put gbar=7e-10, d=1-2gbar and e=delta^2/2+a0. Since 0<=e<=1, `PsiPlateau.exp_small_le2:262` bounds exp(e) by 1+e+e^2. The source denominator 1-2g is greater than d>0. All numerator majorants are nonnegative, so replacing that denominator by d gives the required upper bound.

Independently reconstructed relative margins against 4.91e-7 are

    upper: 22975066960690167558371439 /
           3838050298626729574400000000000000 >0,
    lower: 1009/220000000000 >0.

Here the lower coefficient is a0+3.5e-9+4gbar. It uses exp(-a0)>=1-a0 and includes the full four-gbar loss from `psi_lower_of_err:326ff`. No upper-direction denominator is incorrectly imposed on the lower formula.

The remaining comparisons are also strict:

    1143/d<1145,
    4e10*(1+a0+a0^2)+37000/d<4.2e10,
    2e10+37000<4.2e10.

The first and second pay the division of the entire upper error, not merely its relative term. The third pays the separate lower endpoint correction. Thus both directions imply the same claimed plateau.

All source domains hold for every real x>=1e17. In particular y0 exp(a0)<=1e17<=x; b<=1e-7-1<=-a0 by log(u)<=u-1. This gives b<=a at both signs, and b<=0. Also delta<=1, delta<=K, K>=0 and delta>0. There is no upper cutoff on x and no restriction to integer x.

## 5. Scope of the improvement

The paper implication is accepted:

    RHBelow 88,000,000 implies, for all real x>=1e17,
    abs(psiR(x)-x)<=4.91e-7*x+1145*sqrt(x)+4.2e10.

This does not conflict with the earlier fixed-K=7 obstruction: the new K is 13/2. The earlier audit and review remain unchanged; the latter is `moebius/REVIEW_PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md`, SHA-256 `30736389905515E2AA502E924A299DCBEB4CBE6F9151477838592FA87B4E69D9`.

The finite psi tables, their window geometry and scalar certificates, Mertens/E1 windows, and the high-x zero-free transition are still separate requirements. Retaining the same plateau conclusion simplifies its eventual replacement but does not discharge those other uses of RH through1e8. No cost reduction for the complete Lean/MM0 proof follows yet. Actual RH evidence, localized formal input adapters, implementation and complete root reconciliation remain open. Author and source files were not modified.
