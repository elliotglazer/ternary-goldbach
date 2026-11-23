# Shorter Hurwitz output Taylor orders

2026-11-11. Conditional paper proof and exact rational parameter checks only. No function, coefficient, prime, zero or transform values were generated. The existing source orders, EM corrections, height recurrence, finite translation circuits and their numerical budgets are retained. This packet changes only the consumed output Taylor length and supplies no aggregate operation saving or runtime estimate.

At the five certified band tops, the sufficient output lengths are respectively **19, 19, 19, 20, 19**, rather than20 throughout. The actual fifth-band requested height range, including the existing640 extra-node scenario, needs only17 or18 coefficients under the retained budgets. Every statement below concerns the isolated alpha allocation2^-82. It does not certify signs, completeness, or the other components of an L-value enclosure.

## 1. Exact function and the shorter target remainder

The pinned source interface is REDUCED_NONPRINCIPAL_PLATT_COST_MODEL, section2, lines19–41. It uses the continued function

    f(alpha)=zeta(s,1+alpha), s=1/2+it, alpha in[0,1],
    C_k(b)=f^(k)(b)/k!=(-1)^k(s)_k zeta(s+k,1+b)/k!.

These are continued-function derivative identities, obtained first in the absolutely convergent half-plane and then by continuation. This proof does not differentiate the critical-line Dirichlet series termwise. The cited source interface and its analytic justification remain required formal inputs; this packet is not a new Lean implementation of them.

Let K be an integer with2<=K<=20. On the real segment from a nearest fine anchor b to the requested alpha, the shifted base remains at least1. Absolute convergence applies to the K-th derivative because Re(s+K)=K+1/2>1. The first term plus decreasing integral gives

    |zeta(s+K,1+alpha)| <=1+1/(K-1/2)<2.

Each rising factor satisfies |s+j|<=|t|+j+1/2<|t|+K for0<=j<K. The complex-valued real Taylor integral remainder consequently proves

    |f(alpha)-sum_(k<K) C_k(b)(alpha-b)^k|
      <2 (|t|+K)^K |alpha-b|^K/K!.

All five fine meshes have denominator2D_out, with exact nearest-anchor selection and a fixed tie rule. Thus |alpha-b|<=1/(4D_out), including clipped endpoint cells. The normalized output coefficient is C_k(b)/D_out^k, and its polynomial variable is h=D_out(alpha-b), |h|<=1/4. There is no substitution of the final source denominator4096 for D_out8192.

The source character normalization is c^-s times the complete sum over unit residues. Its absolute amplification is phi(c)/sqrt(c)<=sqrt(c)<633 on the selected nonprincipal domain. We retain633 without exploiting its slack. Any normalized character transform must still restore its exact normalization. Therefore

    T_K(t,D_out)=1266*((|t|+K)/(4D_out))^K/K!             (1)

is a sufficient character-summed target remainder. It is valid for both signs of t and at t=0. The finite head a^-s, conductor factor, character transform and their errors are unchanged. No complex s-panel estimate is claimed.

Deleting the last coefficient from a previously accepted degree19 polynomial does not itself prove(1). The new conclusion uses Taylor's theorem at length K and separately compares its genuine coefficients with the retained finite translated coefficients, as follows.

## 2. The finite translation bias is still paid

SHIFTED_HURWITZ_JET_SEED_EFFICIENCY, section2, proves for an actual coarse polynomial of order P, coarse anchor a and fine anchor b,

    |C_k(b)-Ctilde_k(b)|
      <=M_P |b-a|^(P-k)/(k!(P-k)!),
    M_P=2(|t|+P)^P.

For every K<=20<=P, multiply by |alpha-b|^k and sum only k<K. All terms are nonnegative, so the same complete binomial bound applies:

    sum_(k<K) |alpha-b|^k |C_k(b)-Ctilde_k(b)|
      <=M_P (|b-a|+|alpha-b|)^P/P!.                    (2)

In the first four bands, P27 and the source/output normalization D coincide. The midpoint shift is1/(2D), so the combined real displacement is at most3/(4D). Retain the original common upper bound

    S_first=1266*(15/16)^27/27!.

Even fine anchors require no translation, but this same positive allowance is harmless. At the right coarse endpoint, the existing first20 coefficients suffice for every K considered; no missing P27 endpoint is silently requested.

In the fifth band, P28 and D_source4096 remain fixed. The actual source shifts are0,1/4,1/2,-1/4 in source coordinates, followed by2^-k output normalization. The target displacement in source coordinates is at most1/8. Retain the reviewed bound with V7000,

    S_final=1266*(5*(7000+28)/(8*4096))^28/28!.

The selected m159 change preserves the same joint output and remainder contracts. All actual real segments lie in[0,1], including the negative-quarter translation from the right endpoint. The shortened polynomial consumes a prefix of the same finite translated output. It is not asserted to have exact fine derivatives, and its analytic bias(2) is not folded into the numerical coefficient radius.

## 3. Complete error contract, including numerical coefficients

Set eta=u_H=2^-100 and u_T=2^-110. Keep the entire original first-four numerical allowance

    N_first=2532eta+633*330*u_T+1688u_H.                (3)

This follows directly from SCALED_HURWITZ_EM_SEED_PRECISION, sections5–6. Initial errors and injected shift errors are bounded through a nonnegative matrix. Replacing the evaluation row sum over k<20 by k<K only removes nonnegative terms. In particular each injected error still has weight at most

    sum_(k<K) 4^-k binom(j,k)2^(-(j-k)) <=(3/4)^j<=1.

No per-slot eta assertion is made for the first-four translated centers. Their weighted numerical error proof is the one actually consumed. The330 updates are still charged and performed under this proposal.

For the final joint band, each delivered numerical coefficient has radius less than eta relative to its finite translated polynomial, after the2^-k scale and final rounding. Since sum_(k<K)4^-k<4/3, retain

    N_final=844eta+1688u_H.                            (4)

Its shift-rounding errors are already inside eta and are not added a second time. The existing350-update shifts and full20-slot delivery are retained. Neither the source order nor seed setup is reduced here.

For ordinary Horner with complex multiplication and addition errors at most u_H each, the shorter evaluation has error at most2u_H sum_(k<K-1)4^-k<8u_H/3. The imported highest coefficient is copied, not given a fictitious first multiplication. After character amplification this is below1688u_H. Exact rational h is required; an approximate h needs its own argument-error allowance.

An already proved direct-conversion, product-only-rounded Horner profile may also be restricted to degrees0..K-1 when its positive weighted coefficient-conversion and round-error sum stays below8u_H/3. The existing sufficient20-term profiles have this property after dropping their omitted terms. This statement concerns the error contract only. All stage grids, shifted integers, witnesses, signs and raw widths must be rebound to the shorter actual circuit. It does not transfer an old cost subtotal.

The admission condition checked by this packet is strictly

    T_K(t,D_out)+S_class+N_class <2^-82.               (5)

The numerical terms, analytic translation bias, and new target remainder are distinct. Other function, phase, transform and interpolation budgets are outside(5). This proposal spends some of the previous alpha slack. It retains the allocation2^-82, not every earlier stronger fractional sub-bound such as the final band's .16 fraction at order20.

The exact retained interface is stated in QUARTER_MESH_P28_SHARED_SEED, opening paragraph and section3 equation(5), lines78–80: the required isolated alpha radius is2^-82, and the achieved fraction below.16 is recorded separately. The joint m159 successor preserves that construction. The reconciled schedule reports the stronger achieved fraction but supplies no downstream mathematical use of it. This packet explicitly offers the weaker2^-82 successor interface. Any other consumer requiring.16*2^-82 must retain the old order or pass a new check against that smaller allowance; no such consumer is silently promoted by this proposal.

## 4. Band-top admission and exact height selectors

The scalar receipt checks every K in2..20. At the declared band tops:

|V|D_out|Smallest K admitted by(5)|Strict upper bound for total /2^-82|
|---:|---:|---:|---:|
|500|512|19|352287/1000000|
|1000|1024|19|282137/1000000|
|2000|2048|19|254939/1000000|
|5000|4096|20|249105/1000000|
|7000|8192|19|161478/1000000|

The displayed rational upper bounds are outward rounded; exact ratios are retained in the JSON. Failure for a shorter K means only that this sufficient envelope does not fit. It is not a lower bound on actual error or a minimality theorem among all Taylor estimates.

The current requested height grid is t_j=5j/64. With the existing four guard scenarios e=0,167,320,640, the last index is84199+e. No conductor counts or value evaluations are needed to obtain the following parameter intervals. The fifth-band rows below extend through the largest scenario84839.

|Band|K|Inclusive j interval|
|---:|---:|---:|
|1|10|0–67|
|1|11|68–238|
|1|12|239–509|
|1|13|510–906|
|1|14|907–1447|
|1|15|1448–2153|
|1|16|2154–3039|
|1|17|3040–4115|
|1|18|4116–5392|
|1|19|5393–6400|
|2|17|6401–8449|
|2|18|8450–11016|
|2|19|11017–12800|
|3|17|12801–17116|
|3|18|17117–22263|
|3|19|22264–25600|
|4|16|25601–25746|
|4|17|25747–34449|
|4|18|34450–44756|
|4|19|44757–56717|
|4|20|56718–64000|
|5|17|64001–68945|
|5|18|68946–84839|

For each fixed K, (1) is increasing in nonnegative |t|. The script uses integer binary search to locate its final admitted grid index, then checks the exact rational inequality there and its failure at the next point when that next point is in the band domain. It also checks every smaller K fails at the start of each displayed minimal-K interval. Monotonicity proves admission and this restricted minimality throughout the interval, with no numerical height sampling assumption.

All four guard scenarios are represented by clipping these intervals at their exact final index. The final K18 threshold under this bound is89533, so every current final-band requested node fits K18; the declared band cap7000 corresponds to89600 and still requires K19. Negative requested heights use |t|. For a new off-grid height, test(5) directly or use an admitted grid upper bound; an interval label does not silently extend beyond its tested threshold. Guard sufficiency for Turing completeness remains unproved by these metadata.

## 5. Implementation and cost boundary

The admitted change is the output polynomial sum_(k<K) V_k h^k, with exact source identity, labels, anchor and normalization. Continue producing the existing certified20-slot finite vectors and consume their first K entries. This deliberately avoids a new pruned-translation or seed-production proof. A future implementation can seek those savings separately.

No height-weighted conductor total, global Horner saving, or priced proof saving is asserted. A per-value Horner circuit now has K-1 product stages, but its new highest coefficient and accumulated magnitude must be bound and priced under the same arithmetic model as its comparator. Conversions, coefficient storage, witness discovery, additions and exact shifts remain charged. Existing degree19 finite-difference initialization counts, traversal widths and table lifetimes do not automatically apply to degree K-1. They need a separate circuit instantiation or continued use of the old degree19 polynomial, which would be a different approximation.

The new mathematical content is a shorter output-order contract for the actual finite translated coefficients, retaining every old analytic and numerical allowance except the explicitly replaced target remainder. No selected production ledger is altered and no successful numerical certificate is claimed.

## 6. Frozen evidence

The script checks these input hashes before performing rational arithmetic:

|Source|SHA256|
|---|---|
|zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md|B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC|
|integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md|861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895|
|prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md|251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231|
|major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md|AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F|
|zero-sum/QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md|A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19|
|work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md|E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9|
|major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md|483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716|

Agent paths are relative to work/qrh-campaign/agents unless prefixed work/. Relevant source locations are the first report lines19–41 for the continued-function coefficients and remainder, the shift report section2 for differentiated translation, scaled report sections5–6 for weighted errors, joint report section3 for final normalization, m159 report lines12–20 for preserved remainders, and reconciled report sections1–2 for exact height and seed domains.

Owned script shorter_hurwitz_output_orders_20261111.py SHA256 `11230A0BFE930FC1578E737A28C68C35B2BC4F6058A47767E07FE62CEB039E31`; receipt of the same stem SHA256 `4385975F56DE8CA2E4B42319DA3B0A2F5F1EB38C4520772F0E8BFC9602692B38`. All339 exact checks pass. The receipt retains all19 candidate orders at each band top, all95 order/grid thresholds with endpoint success/failure witnesses, and complete clipped parameter intervals for all four scenarios. Independent review is required before adoption.
