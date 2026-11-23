# Uniform stability and a conditional output-radius allocation

2026-11-11. Bounded paper proof and exact rational scalar metadata only. No function, kernel, character, root, transform, sign or prime values were evaluated. No builds, declarations, source changes or inventories. This is a sufficient producer contract, not evidence that its numerical inputs have been produced.

For the reviewed h=159/500,m=41 window, the exact finite kernel has sum of absolute values below 5. The actual completion multiplier has magnitude below 27 on the required sample domain. These bounds admit a complete interpolation radius below `(7/10)*2^-45` under the explicit producer tolerances below, including intrinsic transform error `2^-60`. Consequently the p112 intrinsic case can participate in a valid common-radius contract. It is not selected as a production precision, and no sign or count success follows.

## 1. Frozen inputs and exact scope

Paths below are relative to `work/qrh-campaign/agents`.

|Input|SHA256|
|---|---|
|audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md|96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D|
|audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md|32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E|
|major-constants/REVIEW_SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md|61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730|
|integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md|DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C|

The first source and its independent review F6F38CBF fix actual L, the unnormalized character transform, source alpha, actual completion and sign/count meanings. The shorter-window paper and its review retain Platt's section 6 endpoint-normalized Gaussian interpolation. Their primary-source and earlier review pins remain in force.

Fix a primitive nonprincipal chi, c<=265800 and its exact root phase. Every retained sample must satisfy |t|<=7000. Target heights merely being <=7000 is not enough: the guards must also satisfy this condition. The current maximal target 424195/64 plus the conservative 42*(5/64) guard distance is below 7000, so the current guarded route fits this analytic domain if those guards are actually produced. Neither their presence nor their cost is assumed here.

The actual real sample is

    Y(t)=epsilon_chi (c/pi)^(it/2) Gamma(alpha+it/2)
          exp(pi*t/4) L(1/2+it,chi),   alpha=(2a+1)/4.

It is not the elementary positive-cosine sign proxy. The canonical Gamma phase, magnitude and fixed root phase are needed to construct Y or an equivalent exact multiplier. All errors below are absolute real or Euclidean complex errors as appropriate. A rectangular enclosure must pay its norm conversion.

## 2. Stability without kernel or function values

Let Delta=5/64, h=159/500, m=41, and t0=(k+theta)Delta with k=floor(t0/Delta) and 0<=theta<1. For d=-41,...,41 the exact real kernel is

    K_d=exp(-((d-theta)Delta)^2/(2h^2))*sinc(pi*(d-theta)).

The two central terms d=0,1 have absolute value at most 1, including the removable sinc value. The left terms d=-j, 1<=j<=41, have distance at least j, and the right terms d=j+1, 1<=j<=40, also have distance at least j. Dropping the Gaussian factor and using `|sin|<=1` gives

    sum_d |K_d| <= 2+(H_41+H_40)/pi < 5,              (K)

where H_j is the exact finite harmonic sum. The final strict inequality follows rationally from pi>157/50. No sampled kernel magnitudes enter this proof.

The tightened Gamma proof in the shorter-window paper gives a first branch bounded by

    (27/10)*(3/2+max(t,0))^(1/4),

and a second branch below 6. Since 7001.5<10^4, the actual completion amplitude satisfies

    A(t)=exp(pi*t/4)|Gamma(alpha+it/2)| < 27.          (G)

This holds for both parities and both signs of t in the sample domain. The conductor and root factors in the completion are unit factors and add no amplitude.

Rademacher's source bound, the reviewed conductor-power cap28 and zeta(9/8)<=9 give

    |L(1/2+it,chi)| <= 9*28*(7001.5)^(5/16) < 4032, (M)

because `(7001.5)^5<16^16`. Hence |Y(t)|<108864. These are actual-function upper bounds under the source hypotheses, not lower bounds on sign margins or arithmetic precision.

## 3. Complete L-stage allocation

Retain the exact raw-head plus shifted-Hurwitz source assembly. Let q=c^-s, s=1/2+it, and let Shat be the unnormalized character transform center of those actual stored residue centers. The full joint polynomial allowance A_alpha already includes its Taylor, shift, numerical-source and polynomial-evaluation terms. It is not charged again per transform stage.

The following are sufficient hypotheses:

|Term|Required bound|
|---|---:|
|Full conductor-scaled polynomial allowance A_alpha|<2^-82|
|Conductor-scaled finite-head radius H|<=2^-63|
|New conductor-scaled representation/assembly error J|<=2^-63|
|Intrinsic conductor-scaled transform arithmetic epsilon_T|<=2^-60|
|Scale-factor center error `|q-qhat|`|<=2^-84|
|Final scale multiplication/serialization error e_scale|<=2^-63|

H and J are errors for the actual chosen input vector. For a pointwise construction, a uniform Euclidean head radius 2^-73 suffices because the reviewed factor phi(c)/sqrt(c)<=633 gives `633*2^-73<2^-63`. The same sufficient rule applies to new representation error. Exact grid100 embedding into p>=100 followed by exact common-grid addition instead gives J=0 for those actions. It does not eliminate errors already inside A_alpha or a separately rounded head.

Before using qhat, the exact-scaled stored-transform comparison gives

    |c^-s Shat-L| <= A_alpha+H+J+epsilon_T < 1.

Together with (M), sqrt(c)<516 and `516*4033<2^21`, this proves

    |Shat| < 2^21.                                  (S)

This bound is independent of qhat and e_scale, so it does not reason circularly from the desired final L radius. It bounds the final transform center, not every internal FFT buffer. The intrinsic transform theorem still needs its own stored-input and intermediate magnitude hypotheses.

Using the exact split from the complete-error contract,

    r_L <= A_alpha+H+J+epsilon_T+2^21*2^-84+e_scale
         < 2^-82+4*2^-63+2^-60 < 2^-59.              (L)

The resulting L center satisfies `|Lhat|<4032+2^-59<2^12`. There is no factor-error times input-error term because the scale split is at exact q times the stored transform center. No table or saved radius is presumed to satisfy these requirements; they are explicit producer/checker obligations.

## 4. Completion and negative-channel tolerances

Write the exact Y multiplier as A*U, where A is (G) and U is the unit root/canonical-phase factor. A sufficient direct sample contract is

    |A*U-mhat| <= 2^-66,
    error of forming/projecting the real sample from mhat*Lhat <=2^-54.

Then, splitting at the exact multiplier applied to Lhat,

    r_Y,direct <= 27*2^-59 + 2^12*2^-66 + 2^-54
                < 2^-52.                            (Y)

Taking the real coordinate of a rational complex center can be exact. Any additional rounding is included in the stated formation error.

For clarity, the multiplier tolerance can be supplied by ordinary component enclosures. One sufficient allocation is:

- actual amplitude error <=2^-69;
- fixed root-phase error <=2^-75;
- total canonical real-phase error <=2^-75, including any analytic approximation remainder;
- numerical cis error at that real-phase center <=2^-75;
- multiplication error when forming the root/cis center <=2^-74;
- multiplication error when forming amplitude times that unit-factor center <=2^-69.

The real-angle Lipschitz bound makes the total cis error at most2^-74. The root/cis product error is below2^-72. Also |Ahat|<28. Thus the total multiplier error is below

    2^-69 + 28*2^-72 + 2^-69 < 2^-66.

These are tolerances for the actual completion, not permissions to substitute the coarse sign-proxy phase. Constructing the Gamma/amplitude, canonical phase, Gauss phase and elementary enclosures with their proofs and costs remains work. This note does not claim that an earlier phase algorithm meets these tolerances cheaply.

For negative samples obtained from an inverse channel, retain

    Y_chi(-u)=kappa*d(u)*Y_(chi inverse)(u),
    d(u)=exp(-pi*u/2),    0<d(u)<=1,    u>=0.

Here kappa in {+1,-1} is exact and bound to the actual root conventions. From (G),(M) and any sample radius below1, both direct and adapted stored samples have absolute value below2^17. Require the damping-factor radius <=2^-72 and the final real multiplication/serialization error <=2^-55. Splitting at exact d times the positive stored sample gives

    r_Y,negative <= 2^-52 + 2^17*2^-72 + 2^-55 < 2^-51.

Thus the common sample contract is `rY<=2^-51` and `|Yhat|<=2^17`. No unchanged-radius copy across inverse channels is assumed. At zero the damping is exactly1 if that representation is used; the stated bound also covers it. Character pairing, fixed phase signs and central counting remain unchanged.

## 5. Complete finite interpolation radius

Require a real enclosure of each of the 83 exact kernels with radius rK<=2^-72. A uniform finite-arithmetic allowance e_acc<=2^-51 suffices. For example 83 rounded products, 82 rounded additions and one final serialization round, each with absolute error <=2^-59, have total below2^-51. This is a sufficient absolute-error schedule, not an assertion of primitive proof counts or particular bit widths.

There is also a conservative finite-state capacity bound for that direct schedule. Since `|Khat_d|<=1+2^-72` and `sum|Khat_d|<5+83*2^-72`, each exact center product is below2^18 and the sum of their absolute values is below `2^17*(5+83*2^-72)`. Adding all166 rounding allowances still leaves every partial sum below2^20. A backend must represent these magnitudes, the required fractional grids and the raw multiplication/rounding witnesses without overflow. These bounds do not price those witnesses or silently identify their widths with the transform's p112 grid.

Use the exact algebraic error split

    K_d*(Y_d-Yhat_d) + (K_d-Khat_d)*Yhat_d.

It gives `sum|K_d|*rY + sum|Yhat_d|*rK`. This is why the exact bound (K) can be used without another kernel/input cross term. It would be incorrect simply to replace `sum(|Khat_d|+rK)` by5 in the older conservative formula. Here the stored-sample magnitude bound is independently certified.

The reviewed shorter window has analytic tail strictly below2^-46. Therefore the complete radius is bounded by

    r_I < 2^-46 + 5*2^-51 + 83*2^17*2^-72 + 2^-51
        = (691/1024)*2^-45
        < (7/10)*2^-45 < 2^-45.                     (I)

This proves the promised conditional common radius. Every analytic, sample, kernel and finite-arithmetic term is charged once. A padded convolution computing the same finite sum must establish its own e_acc; it cannot inherit the direct-sum gate allowance merely by sharing the kernel.

## 6. What this says about p112

The reviewed transform case p112 proves epsilon_T<=2^-60 under its actual stored-input magnitude bound `M_input+1<=2^14`, complete arithmetic/root/kernel hypotheses and safety conditions. Its constant is `1266*202305920*2^14`; multiplying by2^-112 is at most2^-60. That is exactly the intrinsic premise in section3. All other source and downstream producer conditions remain separate.

The intrinsic contribution alone is amplified by less than `5*27=135` at the output, and `135*2^-60<(1/200)*2^-45`. Thus p134 is not mathematically necessary merely because the full source alpha allocation is2^-82. The explicit tolerances above show that p112 can fit a complete radius target. They neither establish actual producer performance nor select p112 for the production circuit. Internal transform widths, new kernel widths, completion/phase costs, stored-center binding and the source error contracts must all be retained when comparing total costs.

A numerical sign still requires the actual real center to exceed its certified radius in absolute value. Unknown margins can require smaller errors, different points or another evaluator; a zero has no strict sign. This common radius supplies no successful brackets, no principal certificate, no canonical Turing integral and no completeness surplus. The original final mathematical consumer is unchanged.

## Evidence

Owned script `audit/large_branch_stability_allocation_20261111.py` has SHA256 `84E00DA5BF28BB94B708BCDB0EBB604D4F87EFB1400F8157650F79402133989E`; its exclusive JSON receipt has SHA256 `972E12C7DBA2AD2F648D9C972B1CC8DE069411F7CF5AEFEE5F7108A6E24FEA82`. It checks29 rational/power/source-pin assertions, including the exact harmonic sum, magnitude powers, all allocation comparisons and output ratio691/1024. There is no scalar search in this packet and no analytic evaluator import. All predecessors remain immutable. Independent review is pending.
