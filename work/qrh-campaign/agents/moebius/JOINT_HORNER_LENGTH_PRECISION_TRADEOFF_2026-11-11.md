# Joint Taylor length and Horner precision

2026-11-11. Bounded paper and exact-rational metadata research. The only candidates are prefixes of three already reviewed grid shapes, shifted by one common integer offset. No coefficient, analytic function, prime, zero or transform values were evaluated. No build, new declaration, geometry scan, arbitrary-profile optimization or production choice was made.

The shorter-order proof does leave room to reduce the output grid from100 to93 or94 fractional bits. Retaining one extra coefficient can sometimes reduce the product subtotal further. It does not necessarily reduce the combined arithmetic subtotal, much less complete proof work. At the actual final height cap, the fixed shape with K19,b0=93 saves74 product-template events but adds28 addition-template events compared with K18,b0=94. Its extra conversion and proof steps must still be paid. In the first three bands, K20,b0=93 saves only10 products and adds40 adder events compared with K19,b0=94.

All conclusions retain the isolated absolute alpha allocation2^-82. The source precision, source Taylor orders, EM corrections, full finite translations and their numerical errors are unchanged. The old stronger final-band .16 fraction and any previous numerical sign successes are not transferred.

## 1. Fixed search domain and inputs

The admitted shorter-order source is prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md, SHA256 `0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A`, independently reviewed in integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md, SHA `B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E`.

The six worst-height cases are:

|Case|V bounding absolute height|Output normalization D|
|---|---:|---:|
|Band1|500|512|
|Band2|1000|1024|
|Band3|2000|2048|
|Band4|5000|4096|
|Band5 declared domain|7000|8192|
|Band5 actual requested domain|424195/64|8192|

The last value is84839*5/64 and covers all existing final-node scenarios with last index84199+e, e in{0,167,320,640}. It is a restriction of the actual requested heights, not a replacement for the declared7000 contract in unrelated consumers. Both signs of height use the same bounds. Source final-band envelopes and its shift error still use V7000 even in the restricted case.

For each case choose K in10..20 and integer b0 in90..100. Let s_j be one of these original shapes in degree order0..19:

    uniform = [100]*20;
    linear = [100,100,98,97,96,95,94,93,92,91,
              90,89,88,87,86,85,84,83,82,81];
    fixed = [100,100,100,100,97,95,95,95,89,87,
             87,87,81,79,79,79,71,71,71,71].

Consume only degrees0..K-1 and use b_j=s_j+b0−100. There are6*3*11*11=2178 candidates. This is an exhaustive comparison only within those finite choices and the declared sufficient inequalities. It says nothing about other shapes, ranges, sharper analytic estimates or observed errors. Source production continues to deliver its full twenty output centers, with P27/P28 and330/350 finite-shift updates as before. No source-work reduction is credited.

## 2. Complete alpha inequality

Let eta=2^-100 and u_T=2^-110. The target Taylor remainder after character amplification is

    T_K(V,D)=1266*((V+K)/(4D))^K/K!.                 (1)

The source proof applies real Taylor's theorem to the continued Hurwitz function, with K-th derivative controlled by the absolutely convergent series at Re(s+K)>1. It does not differentiate the critical-line series termwise. Nearest-anchor geometry gives |h|<=1/4 with the actual D_out, including clipped real endpoints.

Retain the complete fixed finite-translation bounds

    S_first=1266*(15/16)^27/27!,
    S_final=1266*(5*7028/(8*4096))^28/28!,

and the fixed numerical source/coefficient allowances

    N_first=2532eta+633*330u_T,
    N_final=844eta.                                 (2)

There is no old1688u_H evaluation term in (2). It is replaced below, not added again. Final finite-shift rounding already lies inside the final eta contract and is not counted twice.

The retained finite translated coefficients differ from the genuine fine-anchor derivatives by a separately proved absolute bias. Its weighted sum over k<K is bounded by the old sum over k<20, and then by the same full positive binomial bound used for S_first or S_final. Likewise the source coefficient error and injected translation errors have nonnegative weighted bounds; dropping terms cannot increase them. These statements justify retaining (2) for a shorter output polynomial. They do not identify the stored centers with exact fine derivatives. The new genuine Taylor target remainder is (1), rather than an unproved claim obtained by deleting old polynomial terms.

Round each ORIGINAL retained center directly to its chosen b_j grid. Set e_j=(3/4)2^-b_j. Initialize the top converted coefficient exactly; at each lower degree round only the real-displacement product to b_j, then add the coefficient exactly. Its total conversion-plus-evaluation error relative to the stored polynomial is strictly below

    E(K,b)=sum_(j=0)^(K-1) (2 if j<K-1 else1)*e_j*4^-j
          =2^-b0 * Eshape(K),                        (3)

where

    Eshape(K)=(3/4)*sum_(j<K)(2 if j<K-1 else1)
                           *2^(100-s_j)*4^-j.

The top copy has no separate product round. The argument uses absolute errors and is valid at h=0, both displacement endpoints and correlated rounding errors. With the original unit-character/conductor amplification bounded by633, the complete condition is

    T_K(V,D)+S_class+N_class+633*E(K,b) <2^-82.       (4)

The script tests (4) exactly with rational arithmetic for every candidate. For a fixed candidate it holds throughout |t|<=V by monotonicity of (1); no height sampling is used. Failure of (4) rejects this sufficient recipe only. It is not a lower bound on actual function error or an impossibility result.

## 3. Fresh magnitude and signed-witness bounds

Stored-degree envelopes Z_j are from the accepted9B777E02 source and10281561 review pinned below. Their formulas bound the actual stored centers independently of the destination precision. They include numerical errors of the finite translation. This packet does not use the source note's separate b>=70 accumulator table: candidate grids reach61.

For every candidate compute fresh rational bounds

    C_j=Z_j+e_j,
    A_(K-1)=C_(K-1),
    T_j=A_(j+1)/4+e_j,
    A_j=C_j+T_j, j=K-2,...,0.                        (5)

The new top is the converted z_(K-1), not an old twenty-term accumulator with discarded stages. Nearest coordinate rounding has Euclidean error below e_j at every integer b_j in this domain, so (5) does not require b_j>=70. Every saved capacity is recomputed from these rational values.

Use the accepted uncancelled signed schedule. With delta=b_j−b_(j+1), input M and rounded product L, prove the products rM and Lv, then

    X=rM*2^delta,
    R=X−Lv, S=2R+v,
    S+C+1=2v, S,C>=0,
    Mnew=L+n_j.                                     (6)

The independent unsigned caps S,C<2^21 precede their guard equality; the guard sum fits3 bytes before checking. It implies the exact nearest interval −v<=2R<v, including negative ties. For the other raw operations use

    mcap=2^b_(j+1) A_(j+1), lcap=2^b_j T_j,
    xcap=132900*mcap*2^delta,
    lvcap=531600*lcap,
    rcap=xcap+lvcap,
    scap=2rcap+531600,
    acap=2^b_j A_j.                                  (7)

The receipt retains per-stage strict powers for these raw quantities and both product operands. Residual bounds are established before accepted cancellation. Signed-add branches, canonical zero, range/representation proofs and exact shifts retain the same separate costs as the reviewed schedule. Degree0 enters only the final exact addition.

The product template is M(m,n)=5mn+2n+1 with the smaller byte operand as row count; the adder is A(l)=2l+1. Each K-term complex evaluation has4(K−1) real product instances,8(K−1) natural-adder instances,6(K−1) signed-add bridges and2(K−1) nearest-range implications. This packet retains uncancelled geometry to compare every candidate identically. No conductor-specific gcd or zero-operand shortcut is credited.

## 4. Bounded comparison results

The following rows minimize the declared P+A template-event sum separately within each shape and case. Ties are broken by P, then K, then b0. This is a transparent metadata objective, not a total-work or runtime objective. The product-only minimizers are also retained and can differ.

|Domain|Shape|K|b0|Smallest grid|Product P|Adder A|Strict alpha ratio upper bound|
|---|---|---:|---:|---:|---:|---:|---:|
|Bands1–3 tops|Uniform|19|93|93|11244|2900|964012/10^6|
|Bands1–3 tops|Linear|19|94|76|10104|2688|751517/10^6|
|Bands1–3 tops|Fixed|19|94|65|9684|2616|741105/10^6|
|Band4 top|Uniform|20|93|93|11632|3012|860830/10^6|
|Band4 top|Linear|20|94|75|10372|2772|648335/10^6|
|Band4 top|Fixed|20|94|65|9858|2688|639054/10^6|
|Band5 declared7000|Uniform|19|93|93|10614|2772|773203/10^6|
|Band5 declared7000|Linear|19|93|75|9354|2544|966377/10^6|
|Band5 declared7000|Fixed|19|93|64|8858|2448|945553/10^6|
|Band5 actual424195/64|Uniform|18|94|94|10346|2696|776953/10^6|
|Band5 actual424195/64|Linear|18|94|77|9296|2492|873539/10^6|
|Band5 actual424195/64|Fixed|19|93|64|8858|2448|939290/10^6|

The first three combined rows use the largest of their individually checked ratios, attained at band1. The receipt retains all three exact rational totals separately. The displayed upper ratios are outward rational roundings of the EXACT complete expression (4), divided by2^-82. They include all fixed source/translation terms, not only evaluation.

For the actual final domain, compare these two admissible fixed-shape candidates directly:

|K,b0|P|A|P+A|Coordinate conversions per new array|Signed-add/product bridges|Range implications|
|---|---:|---:|---:|---:|---|---:|
|18,94|8932|2420|11352|36|102 /68|34|
|19,93|8858|2448|11306|38|108 /72|36|

Retaining the cheap high-degree stage permits one fewer bit throughout the shape. It saves74 product events, but adds28 adder events, two source-coordinate conversions, six signed-add bridges, four product-sign bridges and two range implications. Both have14 complex-coordinate alignment instances totaling58 shifted bits; their sizes differ. The new scalar output-to-grid100 shift is7 bits instead of6. The new highest signed input capacity is12 bits instead of18. These are sufficient proof capacities, not observed coefficients.

Let alpha and beta price product- and adder-template events in a common declared model, and let DeltaR include all other new-minus-old costs, including conversion/cache, shifts, sign/range proofs, binding, representation and generation if the objective includes it. Then19,93 wins over18,94 only when

    DeltaR <74alpha−28beta.                          (8)

At alpha=beta this reserve is46 template events. It is not free extra work. The larger alpha ratio also leaves less analytic allocation slack even though (4) remains strict.

For each of the first three bands, the product-only minimum within the fixed shape is K20,b0=93 with P9674,A2656. The P+A minimum is K19,b0=94 with P9684,A2616. Thus the extra-stage candidate wins only if

    DeltaR <10alpha−40beta.                          (9)

At equal event prices it already loses30 before any omitted costs. This gives a concrete reason to retain separate arithmetic categories. No new arbitrary-profile optimum or universal shorter/longer preference follows.

Relative to keeping b0=100 at the shortest admitted K, all table entries reduce their product/adder subtotals, but their cache/representation and end-to-end costs still need the same comparison. No family-weighted aggregate or new production inventory is computed.

## 5. Exact grid100 export and consumer compatibility

For b0<=100, an output coordinate M/2^b0 can be re-encoded exactly as

    (M*2^(100−b0))/2^100.                            (10)

The adapter proves this integer-power identity and binds the sign, source label and new output object. It introduces ZERO numerical rounding error. It also does not improve accuracy or recover the old grid100 computation. The saved result remains the new shortened/coarser-grid polynomial evaluation with complete radius (4). If canonical odd-mantissa dyadic encoding is used, the same exact value can retain its canonical representation; any consumer demanding an explicit grid100 integer still needs the checked shift/binding adapter.

For the displayed candidates the pre-adapter signed output capacities are107 or108 bits, while the exact re-encoded grid100 output needs114 signed bits. These follow from the fresh A0 in (5); degree0 remains large. Materializing the shift, range and canonical-zero proof, numeral traffic and consumer binding is a named additional cost, not part of P+A. The full receipt includes the adapter shift and capacities for every candidate.

The source consumer contract requires the isolated alpha radius2^-82, so (4) supplies that successor input. The existing twenty-slot finite coefficient producer remains unchanged. A consumer asking for twenty separately certified fine derivatives is not satisfied by a shortened scalar polynomial or by zero padding omitted coefficients. A consumer demanding the older achieved .16*2^-82 final-band radius must keep that stronger construction or recheck its budget. No such stronger bound is claimed here.

Downstream conductor scaling, finite head/residue attachment, character transforms, Y/phase conversion, interpolation and Turing bookkeeping retain their own errors and exact normalizations. Every actual strict sign or nonvanishing test must be performed on the new valid enclosure. Neither (10) nor the unchanged scalar allocation transfers old sign successes or a numerical completeness certificate. A typed implementation must replace the evaluation contract and bind its supplied radius, not merely relabel old output bytes as grid100.

## 6. Frozen evidence and remaining gates

Owned script joint_horner_length_precision_20261111.py has SHA256 `73B3A81B55707A6E3D419C2F479F34BEA162DB93C2C19FBD3781A131BDC63C09`; receipt of the same stem has SHA `59EBE87D5E5B2623C8F40A1EADB0F7803106F5005F90826C35F5B08C69284742`. All533654 exact assertions pass. The receipt retains2178 candidates with full rational alpha totals, individual target/evaluation terms, both arithmetic subtotals, fresh stage widths, output capacities and fixed-profile comparisons. K20,b0=100 reproduces all prior product/adder totals. The writer refuses an existing output path. No author program was imported or executed.

Eight frozen input pins are checked. Besides the two shorter-order artifacts in section1:

|Input|SHA256|
|---|---|
|prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md|`9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2`|
|major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md|`1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6`|
|moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md|`96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3`|
|moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md|`531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474`|
|independent-feasibility/REVIEW_SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md|`40AE12EEFE142B932820F6462E6DE7CE127679A0CE220010148C698E984BBFF1`|
|moebius/signed_horner_schedule_costs_20261111.json|`0DF6FF38D7F14A9C3596423BE109E5EEC6CAF18E031F4329B907E43F5A60FF37`|

Independent review of the joint parameter and consumer argument is required before adoption. Concrete ordinary-rule arithmetic, input/source certification, actual output signs and full analytic foundation work remain separate. This packet supplies a bounded design comparison and exact admissible successor contracts, not an end-to-end production choice.
