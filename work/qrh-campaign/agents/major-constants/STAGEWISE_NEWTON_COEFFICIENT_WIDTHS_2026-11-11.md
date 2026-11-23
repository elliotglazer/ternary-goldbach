# Stagewise Newton widths from stored coefficient envelopes

2026-11-11. New conditional finite-polynomial and exact-size metadata. No coefficient array, polynomial value, analytic function, prime, transform or spectral datum was evaluated. No build, declaration, source/dependency edit or frozen-file mutation was made. This supplies width inputs for a future matched comparison, not a cost winner.

The reviewed stored-degree envelopes also apply to finite-difference initialization. The partial polynomial at degree i contains only coefficients19-i through19. Its state and raw products must be bounded from that tail. In particular the large degree-zero coefficient appears only in the last order-zero insertion. It must not inflate all earlier products or positive-order differences. The formulas below retain both individual coefficient bounds and the simpler maximum-tail alternative C_i.

## 1. Exact source objects and conversion requirement

Let Z_k be the first-four or final stored-center envelope from STORED_HURWITZ_DEGREE_MAGNITUDE, reviewed at10281561. These are bounds on the ACTUAL delivered finite-polynomial centers, including source/translation numerical errors. They are not true fine-anchor derivative values. The first-four and final coefficient classes have different Z_k; choose the class matching the source height, normalization and anchor object.

Require direct nearest-coordinate conversion of every original delivered center to grid2^-100, with its exact signed witnesses. Then the complex conversion error is at most2^-100/sqrt(2)<(3/4)2^-100. Define

    c_k=Z_k+(3/4)2^-100,       |z'_k|<c_k,
    z'_k=n_k/2^100,            k=0,...,19.             (1)

The stronger3/4 constant uses the actual coordinate-nearest contract. A merely abstract norm-error<2^-100 record would require replacing3/4 by1 and recomputing the envelopes; it cannot consume these exact receipt entries automatically. All twenty conversions remain required, even for a short bucket or a truncated difference state. They are per distinct source object with actual input decoding and cache lifetime, not free consequences of the magnitude bound.

The source numerical errors, analytic shift/target errors and downstream character normalization are unchanged. Equation(1) changes no evaluation allocation. Full-state, rounded-initial or truncated variants retain their own accepted arithmetic-error theorem and output coverage.

For the exact Newton initializer set v=2c, F=2D_out, h=q0/v, s=F/v at the physical first numerator of a fixed ties-down anchor bucket. The final sourceD4096 still has D_out8192 and F16384. After partial degree i define

    P_i(x)=sum_(ell=0)^i z'_(19-i+ell)x^ell,
    J_i(t)=2^100 v^i P_i(h+s*t),
    D_j^(i)=Delta^j J_i(0),   0<=j<=i.                (2)

The source initializer gives these exact integer identities. They imply P_i(x)=z'_(19-i)+xP_(i-1)(x). Put C_i=max_{19-i<=k<=19} c_k. This increases with i, but only as the actually inserted coefficient requires. Before stage i the available state belongs to P_(i-1), so its bounds use that earlier tail, not C_i or the final polynomial indiscriminately.

## 2. Guarded finite Stirling envelopes

For a step bound sigma define the nonnegative finite kernel

    K_(ell,j)(sigma)=sum_(m=j)^ell binom(ell,m)
                       4^(-(ell-m))*sigma^m*j!*S(m,j),
    G_(i,j)(sigma)=sum_(ell=j)^i c_(19-i+ell) K_(ell,j)(sigma).   (3)

Here S(m,j) are the usual nonnegative Stirling numbers with the reviewed finite recurrence. The finite identity for Delta_s^j x^ell at h, followed by the triangle inequality, gives

    |D_j^(i)|/(2^100 v^i)<G_(i,j)(sigma)              (4)

whenever |h|<=1/4 and |s|<=sigma. The sigma=1/20 table is admitted under c>10F; sigma=1/40 under c>20F. The latter is a separate stronger-domain option. Actual positive s is strictly below the stated sigma; the finite bound also covers the closed scalar rectangle. Polynomial support may leave the cell in this guarded proof, but no analytic-function estimate is consumed there.

The simpler maximum-tail version is

    G_(i,j)<=C_i sum_(ell=j)^i K_(ell,j)<(4/3)C_i.

This follows from the accepted sharp Stirling certificate and nonnegative truncation. The individual-coefficient expression(3) is the primary receipt value. It avoids replacing every member of the tail by its largest one and, because ell starts at j, excludes all coefficients of degree below the difference order. Thus z0 does not enter G_(19,j) for j>=1.

## 3. Guard-free retained in-cell envelopes

For the accepted all-cell truncated initializer, m=min(20,L) and only j<=min(i,m-1) is retained. Every supporting h+ell*s, ell=0,...,j, lies in the same physical bucket and has magnitude<=1/4. No c/F guard or bound s<=1/20 is needed.

A useful refinement of its geometric estimate first removes the polynomial of degree below j, which Delta^j annihilates exactly. Applying the alternating-binomial formula only to the remaining tail gives

    T_(i,j)=2^j sum_(ell=j)^i c_(19-i+ell)4^-ell,
    |D_j^(i)|/(2^100 v^i)<T_(i,j).                    (5)

The cancellation used here is the proved algebraic annihilation of lower-degree monomials. It is not assumed numerical cancellation of a raw product. It is valid at j=0 and for every retained j, including L=1 where only j0 exists. The looser bound T_(i,j)<(4/3)2^j C_i recovers the accepted all-cell envelope. Formula(5) is materially more specific: z0 is absent from every positive-order row even in this guard-free table.

The receipt stores rows through j=i for reuse, but an all-cell row is consumable ONLY when j<L. It does not turn a short cell into one with nineteen available physical support points. When a higher order is not retained, its initialization and traversal are omitted only according to the separately reviewed truncated circuit, not by a new assertion in this note.

## 4. Raw Newton products and coefficient insertion

All bounds in this section are normalized by the NEW stage scale2^100 v^i. The actual update first creates a new top if retained, then updates interiors downward, and inserts the order-zero coefficient last. Denote the appropriate OLD state bound by E_(i-1,j), using G for a guarded table or T for the all-cell table.

For a guarded interior1<=j<i, the two raw product bounds are separately

    general:  (1/4+j*sigma) E_(i-1,j),
    secondary: j*sigma E_(i-1,j-1).                  (6)

Their sum bounds the raw addition before using the new-state invariant. The new top j=i uses only i*sigma E_(i-1,i-1), not a fictitious old order-i entry. At j0 the general product bound is E_(i-1,0)/4, and the newly inserted coefficient prescale has bound c_(19-i). Thus its raw sum is

    E_(i-1,0)/4+c_(19-i).                            (7)

The source factorial/kernel identity at order zero shows this equals the new degree-zero envelope. No large inserted coefficient is charged to a previous-stage product.

For all-cell retained j>0, both first and jth supporting points are in-cell. Hence |h+j*s|<=1/4 and j*s<1/2. The separate raw product bounds become

    general:  T_(i-1,j)/4,
    secondary: T_(i-1,j-1)/2.                        (8)

The new top has only the second term. Their sum is the recorded raw temporary bound; it is not replaced by a possibly smaller new stored-state bound. Order-zero insertion remains(7) with T. At L1 no positive-order step bound is invoked. This distinction prevents an invalid s<1/20 premise from entering the guard-free case.

The small-scale binary expansion of jF uses shifted multiples with the same scalar sign in each coordinate. Its partial-sum magnitude is no larger than the completed secondary product, so(6) or(8) also bounds those intermediate additions. The general products, secondary products, inserted prescales and raw sums each receive their own recorded bound. None is narrowed by presuming cancellation after the addition.

The script verifies that each guarded raw sum is below(4/3)C_i and each all-cell raw sum is below(4/3)2^j C_i, consistent with the accepted generic bounds. These comparisons are checks on the new stronger formulas, not their proof: equations(6)--(8) follow directly from the actual update and old-state normalization.

## 5. Sufficient signed capacities and normalization

For a positive envelope E choose an integer q with E<=2^q. The actual norm is STRICTLY below E because(1) bounds the actual coefficients strictly and all used positive majorants have a nonzero term. Therefore the corresponding integer at degree i has magnitude below2^(100+r_i+q), where r_i=ceil(log2(v^i)), with r0=0. A sufficient signed capacity is

    101+r_i+q.                                       (9)

The ceiling is an integer bit-length fact, not an analytic logarithm evaluation. The receipt uses the uniform selected-domain bound v<=531600 to illustrate maxima, calculating r_i=bitlength(531600^i-1). Actual conductor powers can be used instead. It retains q separately so a future backend can price exact widths. Coefficient-input numerators use101+q(c_k); their prescaled outputs use(9). The input to a general product at stage i comes from E_(i-1,j), not the new-stage output bound. Its factor is the actual q0+jF. Both input and raw-output bindings remain necessary.

The following peak capacities are over all recorded orders at that stage. For the all-cell table only orders admitted by L are usable. The same peaks happen to hold across the two guarded tables and all-cell table for these source envelopes; their individual order rows differ and must not be identified.

|Partial degree i|First-four peak stored/raw signed bits|Final peak stored/raw signed bits|
|---:|---:|---:|
|0|53/53|44/44|
|4|146/146|138/138|
|8|235/235|230/230|
|12|323/323|320/320|
|16|408/408|406/406|
|18|448/448|447/447|
|19|476/476|476/476|

The largest completed exact b100 state/raw temporary is bounded by476 signed bits in this table, compared with480 for the accepted uniform-C sharp-Stirling guarded table. More important for pricing, earlier operands are much smaller: the first coefficient needs53 or44 signed bits, while the old generic coefficient cap required117. The large v^i powers still grow with stage. Peak differences alone do not give an arithmetic-cost ratio; the receipt records every product and addition bound.

Where the accepted power-of-two state normalization is admitted, use v',F',delta and lambda_j=j*delta+nu2(j!) from that source. The normalized integer is the exact partial difference divided by2^lambda_j, with the same h=q0'/v' and s=F'/v'. Every state and each raw normalized product/sum can therefore use

    101+ceil(log2(v'^i))+q-lambda_j                   (10)

instead of(9), with the corresponding raw envelope q. This is valid because the accepted normalized recurrence constructs the exactly divided terms; it is not a division of arbitrary intermediate integers. For the secondary term, the identity between jF' and the difference of lambda exponents produces the stated oddpart(j) factor. The coefficient insertion has j0 and lambda0=0. Source prescales do not receive an invented common division.

Equation(10) is consumed only with the separate normalized-circuit/divisibility hypotheses and their domain. This report does not automatically extend that circuit's admissibility to unreviewed all-cell combinations. If a proved integer bound becomes less than one in magnitude, the integer is zero; the implementation must prove that branch or use a conservative zero-capable encoding. Negative bit/digit counts are not valid capacities.

## 6. Costs, errors and evidence boundary

No source coefficient is dropped. Full Newton retains190 general products,357 expanded initialization additions/shifted operands and19 coefficient prescales. Truncated Newton retains its own G(m), B(m), T(m) counts and still all twenty coefficients and nineteen prescales. The present result changes sufficient widths only. It does not merge those circuits, change their guards, remove actual source conversion or erase signed arithmetic, shifts, setup, proof references and cache costs.

The coefficient conversion errors in(1) were included explicitly in every c_k. Exact Newton initialization has no further numerical error. A rounded-initial-state consumer must still pay its separately reviewed initial conversion and propagation errors, and its final output round. It cannot use an exact-state bound for an approximate state without adding that error and verifying quantitative slack. Source/translation errors are already in Z_k; they must not be removed on the ground that the initializer uses exact integers.

This provides a fair input to comparison with newly narrowed Horner stages. A comparison that uses the new small Horner inputs but charges every FD initializer product at the old global width is not the strongest admitted comparison. Conversely, these narrower FD envelopes do not establish FD superiority: unit-only Horner, nonunit traversal, initial/final rounding, representation conversion and all setup remain distinct costs.

The companion checker performed9272 exact assertions. It verifies ten predecessor/source hashes, constructs finite Stirling kernels, computes all210 partial-degree/order rows in each of three domains and two source classes, records separate raw products/insertion/sums, checks the maximum-tail comparisons and compares the two guarded kernels. It generates no polynomial samples or coefficient arrays and performs no occupancy scan. An independent ordinary-rule implementation and concrete record acceptance remain outstanding.

Script `major-constants/stagewise_newton_widths_20261111.py`, SHA256 `E34B2EAB9B5B0DA49A9F61D7AA47D6D1316E74A24071BD9726B72C3D0B4A50F0`; receipt same stem JSON, SHA256 `717D0A360AC84F0FE327F30C18B4821CF700054521B602FADCD6D49F44F0276C`.

The complete ten pins are embedded in that receipt: stored source9B777E02/dataE947C32E/review10281561; Newton55576F70; sharp Stirling4980828A/review212CADE1; truncated all-cell52136903/review365EA347; normalized sourceEFB31BE5/review9F1C14DF. Frozen input bytes are unchanged. This new source-bound width argument requires independent review before any joined cost adoption.
