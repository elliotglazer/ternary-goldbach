# Minor-arc tolerance for the smoothed energy coefficient

The existing numerical envelopes permit replacing the linear energy majorant

    sigma(x) <= .640208000017 log(x) - .021095

by

    sigma_a(x) = a log(x) - .021095,  a=.65,

while preserving lower J>=8.6296, the resulting lower prime-supported major energy8.6294, and final minor bound1.0376. In fact the maximum rational coefficient certified by the same finite-cell envelopes is

    a_max =381605715428698635087625105/584653183815430767285135948
          =.6527044168960991... .

The safe decimal .6527 is below this exact fraction and passes every cell and the asymptotic branch. The recommended first analytic target is .65, which leaves more numerical margin. This is an exact rational audit of existing source inequalities, not a newly compiled Lean proof or a proof of the replacement prime-energy estimate.

The script minor_energy_tolerance.py extracts the actual lists and constants from pinned NumericsCells.lean, uses Python Fraction throughout all inequality checks, and writes the displayed diagnostic values when run. Its output is saved in minor_energy_tolerance_results.json. Decimal renderings are for readability; the comparisons and caps use exact fractions. No upstream files were changed and no compiler ran.

## What has to be bounded

The consumer is MinorTotal.T_le at line216:

    T(x)=sum'_n ||a1(x,n)||^2 <= sigma(x)*x.

Here a1 is the source's prime-supported coefficient sequence. Its definition must remain unchanged. The existing proof gets this from a stronger signed weighted-von-Mangoldt identity. That stronger identity is not needed downstream, as independently checked by the statement-audit worker. A new proof must still establish summability, or prove the inequality for every finite partial sum of these nonnegative terms. A bare upper bound on a totalized tsum without summability can be vacuous.

MinorTotal.lean:70 defines the original sigma by

    (.640208 +366.91/sqrt(x))*log(x)-.021095.

NumericsCore.sig_le_lin at lines204-213 absorbs the correction into .000000000017. Thus the new coefficient a is the coefficient of the COMPLETE linear upper envelope. If one retains the correction366.91/sqrt(x) separately, the base coefficient must be at most a-.000000000017 using the same source bound. Do not add that correction on top of a=.6527 without accounting for it.

## Exact sensitivity before numerical envelopes

Write D=Dx(x), L=log(x), G_n=ghatY(x/49,n), c_n=cL(n), and r=r2. The source Mexpr, MinorTotal.lean:78-81, is affine in sigma:

    Mexpr_a(x,r)=sigma_a(x)*K(x,r)-8.6294*G_150000,

    K(x,r)=G_150000*c_150000/D
          +sum_(150000<n<r)G_n*log((n+1)/n)/D
          +G_r*(1-c_(r-1)/D).

All terms of K are nonnegative under the existing size conditions, including c_(r-1)<=D. Therefore increasing a by Delta increases this exact expression by Delta*L*K(x,r). Nothing in this calculation changes the lower energy8.6294 or any ghat estimate.

## Exact cell envelope and its slope

For each cell reuse its certified L0<=log(x)<=L1, cl0, clt, G0, Gt, and block lists G_i,ell_i. Put

    S=sum_i G_i*ell_i,
    d0=L0/2-1.3066,
    h=1-clt/(L1/2-1.3064).

The source cell_bound proof, NumericsCore.lean:274-410, then gives the affine majorant

    F_i(a)=(G0*cl0+S)*(a*L0-.021095)/d0
           +Gt*(a*L1-.021095)*h -8.6294*G0.

Its exact slope is

    K_i=(G0*cl0+S)*L0/d0 +Gt*L1*h.

The cap is the exact rational solution of F_i(a)<=1.037. The table keeps every source block, logarithmic rounding, ghat bound and r2 fixed.

| Cell | x interval | K_i, rounded | F_i(original a), rounded | Maximum a, rounded | F_i(.65), rounded |
|---|---|---:|---:|---:|---:|
|0|[4.9e26,1.47e27]|2.386882616898|1.007172519778|.652704416896|1.030544874322|
|1|[1.47e27,4.9e27]|2.346646893399|.985537487548|.662138232723|1.008515853889|
|2|[4.9e27,4.9e28]|2.308872316255|.965507149889|.671172401819|.988115627571|
|3|[4.9e28,4.9e29]|2.243340270271|.930588742318|.687642292127|.952555530206|
|4|[4.9e29,4.9e31]|2.193544484806|.904774461088|.700487397051|.926253648646|
|5|[4.9e31,4.9e35]|2.123818698594|.870091315850|.718796951259|.890887748510|
|6|[4.9e35,4.9e43]|2.019833272143|.817829379300|.748717263491|.837607586667|
|7|[4.9e43,4.9e59]|1.923855322920|.773657657786|.777090612278|.792496049076|
|8|[4.9e59,4.9e101]|1.858490569686|.748796448023|.795281992147|.766994787650|

Cell0 is the bottleneck. At a=.65 its Mexpr margin below1.037 exceeds .006455. The exact endpoint expressions are slightly sharper than the source's rounded sD' and tau' majorants, but no analytic estimate was sharpened.

The source already allows enough margin; no change to r2 or repartition of cells is needed. This is a maximum for these chosen envelope bounds, not a proof that larger coefficients are mathematically impossible with sharper estimates.

## Why the existing rounded sD' and tau' must be recomputed

Each existing cell hardcodes rational sD' and tau'. If those two auxiliary numbers also remained fixed, the available tolerance would be tiny: the most restrictive fixed-auxiliary cap is approximately .640208055210 in cell8. They were rounded just above the original energy coefficient.

Instead replace those two derived quantities by the exact rationals

    sD_i(a)=(a*L0-.021095)/(L0/2-1.3066),
    tau_i(a)=(a*L1-.021095)*(1-clt/(L1/2-1.3064)).

For rational a all inputs are rational. One may use the exact expressions directly or round upward while keeping the final inequality checked. This is an explicit change to coefficient-dependent auxiliary values, not permission to weaken unrelated constants.

The Core proof's monotonicity arguments survive. For a>=.640208000017 and d in[1.3064,1.3066], the derivative of (aL-.021095)/(L/2-d) has sign .021095/2-a*d<0. Positivity of sigma and all tail factors holds on the same range. The lower8.6294 condition and nonnegative tau conditions remain valid when a increases. These observations justify parameterizing sig_div_Dx_le, tail_le and cell_bound by the proposed energy envelope.

## The asymptotic branch also has room

NumericsAsymp.asymp_goal, line385 onward, covers x>=4.9e101. Reuse all source estimates, including L0=234.14, G0=.0510741, cl0=14.61155, the fixed chain bound and the bounds for Xi and Phi1. The only coefficient-dependent envelopes become

    sD(a)=(234.14*a-.021095)/(234.14/2-1.3066),
    sigma_a(x)<=a*(log(x/49)+3.9).

The latter follows from log49<=3.892 and a>=0. The resulting envelope is

    F_inf(a)=.0510741*(14.61155*sD(a)-8.6294)
       +sD(a)*(.165282706731081808+.00084+1.398e-10)
       +a*(2.3786*.00014+1.398e-10).

Its exact slope is333854049274180140383/180880312500000000000, approximately1.845718003579. Its intercept is approximately-.440905099737. The cap for F_inf(a)<=1.037 is

    2138591490285544855959247/2670832394193441123064000
    =.8007209643461635... .

Thus the asymptotic branch does not reduce the global cell0 cap. The original sD'=1.2947 and coefficient.6403 in its tail step must also be recomputed explicitly. The Xi/Phi1, ghat and chain estimates are unchanged.

## Final minor constant and an optional additional margin

MinorTotal.minor_total fixes t=.0005 and bounds the other coefficient energy by8e-11*x. Its last square split is

    minor/(x^2/49) <=1.0005*Mexpr +2001*22.75*8e-11.

The additive term is exactly.00000364182. Mexpr<=1.037 therefore still proves the existing finalminor1.0376, with no change to t,22.75,8e-11 or the lower-J input.

If one explicitly changed the intermediate NumericsGoal cap while retaining those final constants, the largest permitted Mexpr would be

    (1.0376-.00000364182)/1.0005
    =51879817909/50025000000
    =1.037077819270365... .

This would raise the cell0 coefficient cap to .6527370197856648... . It is unnecessary for a=.65 or.6527. The primary recommendation keeps NumericsGoal at1.037 and does not spend this extra margin.

## Even a bound without the negative offset suffices

For a replacement proof that naturally yields T(x)<=a*x*log(x), use the same cell formula with the intercept .021095 set to0. The maximum global coefficient becomes

    31783786807619686162862000/48721098651285897273761329
    =.6523618655463307... .

Thus T(x)<=.65*x*log(x), with summability established, is already enough for the unchanged minor1.0376. The safe decimal.6523 also fits these fixed envelopes. This is often a more convenient analytic target than recovering the original negative constant. The asymptotic branch remains less restrictive.

## Proof work remaining

The numerical audit does not prove T(x)<=.65*x*log(x). That smoothed prime-energy estimate is the substantive analytic task. Once established, parameterize the Core lemmas as described, use exact rational sD/tau values in the existing cells, and repeat the asymptotic assembly. Reuse all existing size conditions and every ghat certificate. An independent statement/constant audit and Lean check are still needed before using this replacement in the theorem.

The campaign's corrected major1.0404, minor1.0376 and nonprime reserve.00271 remain the primary final budget. No earlier unreserved cubic margin is used in this calculation.
