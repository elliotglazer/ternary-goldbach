# Matched costs for rounded initial differences

2026-11-11. Conditional ordinary-arithmetic schedules and exact size metadata only. No actual coefficients, arithmetic values, primes, transforms, analytic evaluations, builds or new occupancy scans. Frozen predecessors are unchanged. No runtime conversion or method adoption is made.

The new circuit exchanges per-unit arbitrary-denominator rounding and wide traversal for twenty wide initialization conversions, narrow exact traversal and per-unit dyadic rounding. This can help long buckets with enough unit outputs. It can lose on short buckets. The decision must use the actual bucket length L, unit count U, conductor, anchor and source representation; neither L nor phi(c) alone determines it.

## 1. Mathematical inputs and comparison domain

The rounded-initial theorem FB0B0F9A and independent review B493A996 prove the full-state option for the same b100 polynomial, c>10F, L<=260 and all twenty orders. The stronger old c>20F guard may be retained with its own smaller capacities. With

    S=sum_{k=0}^{min(19,L-1)}binom(L-1,k),
    p=102+bitlength(S),

all live-state errors are below2^-102, the final source-polynomial error is below(31/12)2^-100, and the old mixed-character allowance remains valid. This report uses its conservative geometric capacities, not the pending stronger Stirling envelope or a pending truncated/pruned circuit.

The exact normalized-FD comparator is the power-only order normalization EFB31BE5, as consumed by integration's matched interface4E01AE12. The full-factorial variant and any cheaper future circuit are not silently assigned the same counts. The Horner alternatives include the accepted uniform b100 circuit, the accepted linear degree grid and the reviewed bounded optimized degree-grid profile. Their complete prices, not just their product subtotals, enter the minimum below.

The compared cell must have identical required unit outputs, source height, anchor convention and final normalization. Full-state FD traverses all L-1 numerator steps, including nonunits, and initializes all twenty orders even in short or zero-unit buckets. Horner evaluates only the U required units. A proved empty-output skip or other pruning rule must be applied consistently and priced as a separate policy. Nothing here requires preparing a difference state before deciding whether to use it.

## 2. Use the normalized initializer fairly

For the normalized source let v'=2c/2^t, F'=F/2^t=2^delta, D=v'^19 and lambda_j=j*delta+nu2(j!). The accepted integer state satisfies

    E_j=Delta^j I'/2^lambda_j,
    d_j=Delta^j P_100(h(a0))=E_j*2^lambda_j/(2^100 D).

Consequently the new initial grid-p conversion can use

    X_j=E_j*2^(p-100+lambda_j), denominator D.           (1)

The exponent is nonnegative because p>=103. Set a_j=min(p-100+lambda_j,nu2(D)). Exact power cancellation gives the identical quotient

    Xbar_j=E_j*2^(p-100+lambda_j-a_j),
    Dbar_j=D/2^a_j.                                   (2)

This proves the representation adapter needed to share the SAME exact normalized initializer. It is not a claim that the normalized E_j itself is a dyadic approximation to d_j. All twenty shifts/cancellations, source bindings and conversion witnesses are new charged work. The shifted numerator and product widths must be bounded after (2); stored E_j widths alone are insufficient. Using the unreduced version instead is allowed with the wider bounds from FB0B0F9A.

The exact normalized comparator advances E_j by a shifted E_(j+1), with shift delta+nu2(j+1); the rounded comparator advances ordinary grid-p numerators by plain additions. The same accepted normalized Newton initialization N_init may cancel in their comparison only after this exact adapter and actual shared source/geometry identities are supplied. An unnormalized or other initializer requires its own separate N_init price.

At exact-FD unit outputs, retain the target-only extra factor2^19 cancellation where its source hypotheses apply, and the option to prove the odd-core product then restore powers of two by shifts. Offer the same target fraction reduction to Horner. These changes affect the actual output denominator and price. The rounded initial conversions concern all orders at the physical bucket start; they must not use a unit-only cancellation without that unit condition. Cancellation (2) is valid without such a condition.

## 3. A complete declared rounding schedule

The following schedule makes the previously abstract conversion price reproducible. It is an ordinary integer witness scheme; it does not trust a numerical quotient. For a supplied nearest integer m to X/D, D>0, prove the product P=mD and signed residual identity P+R=X. Supply nonnegative W,g and prove

    2R+D=W,       W+g+1=2D.                           (3)

These imply 0<=2R+D<2D, hence -D<=2R<D, exactly nearest rounding with ties toward positive infinity. Conversely a correct nearest m admits these witnesses. Signed zero conventions, magnitude decompositions and the input/denominator identities are part of acceptance. Bounds on the supplied encodings may be imposed before arithmetic; valid witnesses satisfy them. This does not infer a small residual from an unverified equality.

Use the inherited byte templates

    A(w)=2*ceil(w/8)+1,
    M(a,b)=5*ceil(a/8)*ceil(b/8)+2*min(ceil(a/8),ceil(b/8))+1.

A prices a padded unsigned adder with carry-in. M puts the shorter factor in the outer-row position. Both are proposed macro-event counts, not MM0 opcodes or times. A signed addition proof reduces to one of the magnitude-addition equalities according to the checked sign case; charge its signed bridge, term interpretation and branch proof separately. The tables/ordinary arithmetic library are existing prerequisites with charged construction/import lifetimes.

For denominator magnitude d bits, output m magnitude q bits and a sufficient raw residual signed capacity w, the unsigned product/addition core of ONE coordinate conversion is

    Rcore(q,d,w)=M(q,d)+A(w)+A(d+3)+A(d+2).            (4)

The three adders prove P+R=X, 2R+D=W and W+g+1=2D. The latter uses the template's carry-in, not an uncharged extra addition. Supplied R can be encoded with d+1 signed bits, since every successful residual is at most D/2; W,g fit the corresponding nonnegative interval. The d+3 capacity safely covers the raw signed formation of2R+D before the range is inferred.

A COMPLETE coordinate conversion price is (4) plus the two exact doubling/shift proofs, all signed-product/addition bridges, input decompositions/range facts, source/denominator/output bindings, witness term/reference costs and any producer quotient-discovery cost for the objective being priced. Call this additional explicitly named charge K_round. Initial conversion adds its numerator shift/cancellation from (1) or (2). Checking may receive quotient/residual witnesses; generation must obtain them. Neither cost is declared zero.

For final dyadic conversion D=2^(p-100), replace M by the exact product-shift proof and its term cost. The same residual/range scheme (3) still applies. Thus the product-free core is

    RDcore(q,d,w)=A(w)+A(d+3)+A(d+2),                  (5)

with THREE doubling/product shifts rather than two, plus its own K_round. A more direct signed bit-split proof is an alternative schedule, not counted automatically as free.

Exact narrow traversal similarly costs one signed addition per coordinate, with its magnitude adder, sign/term bridge and state-binding proof. Normalized exact traversal additionally prices the order-specific shift and its input binding. These terms must be included even when they are numeral constructors rather than general multiplications.

## 4. Actual widths and a limited numerical specialization

With d=bitlength(Dbar_j), conservative ten-guard initial conversion bounds give q<=p+43 and w<=p+d+45. The corresponding old-guard values are p+37 and p+d+39. The full exact-initialization bounds remain separate. Without denominator cancellation d<=362; at p197 the ten-guard raw comparison can require605 signed bits, as in the reviewed theorem. Reduced denominators may lower these capacities but do not remove the twenty conversions.

For exact-FD final conversion, use the actual target denominator after admitted reduction. The physical order-zero polynomial bound gives output magnitude117 bits and dividend magnitude at most d+117. A safe raw residual signed capacity is d+119. Do not use a worst auxiliary-order state here.

For rounded traversal, all-order stored/raw-add capacities are p+44/p+45 in the ten-guard tier, or p+38/p+39 in the old tier. At a physical order-zero output there is a stronger elementary bound: |P_100(h)|<(4/3)C and propagated error<2^-102 imply the represented value is below2^17; the final nearest grid100 output also stays below2^17. Therefore its output numerator needs117 magnitude bits. Its dyadic dividend has p+17 magnitude bits, its denominator has d=p-99 bits, and w=p+19 safely bounds the raw residual. This physical bound uses no pending Stirling theorem.

The following illustration fixes a padded362-bit arbitrary denominator on BOTH sides of the conversion comparison. It is a specific charged template, not a claim that every normalized cell has that denominator or that padded arithmetic is the best implementation. It omits K_round and all shifts from the NUMERIC core only, keeping them in the complete formulas. Twenty complex initial conversions require forty coordinate instances of (4); each unit output needs two coordinate instances.

|L|p|20 initial complex cores|Exact final core/unit|Dyadic final core/unit|First U with positive conversion-core reserve|
|---:|---:|---:|---:|---:|---:|
|1|103|188960|7580|78|26|
|10|112|198320|7580|90|27|
|20|122|207760|7580|110|28|
|40|141|226480|7580|134|31|
|80|163|254560|7580|170|35|
|130|177|273200|7580|190|37|
|260|197|292000|7580|218|40|

The last column solves U*(exact-core-dyadic-core)>initial-core exactly. For L<=20 in these examples it exceeds L, so the conversion core alone cannot pay itself even if every numerator were a unit. Traversal-add savings could change a full comparison, and a different reduced denominator/template changes the table. For L260 the threshold40 does not assert the existence of forty units in a particular cell or a net total saving.

Under the same padded-add convention, new complex advance cores are38*A(p+45). They are1482,1558,1634,1862,2014,2166,2394 in the listed rows. The exact normalized advance must use its OWN order capacities

    W_j=100+bitlength(v'^19)+25+j-lambda_j,

and its shift delta+nu2(j+1), rather than a blanket506-bit add. W_j+2 is a sufficient raw shifted-add capacity under the inherited bound. If a bound forces a normalized integer to zero, prove that branch; for a conservative encoder use at least a zero-capable one-bit width, never a negative digit count. Per-order sign/shift/reference costs accompany the magnitude adders. The scalar receipt deliberately does not invent a conductor distribution or sum these expressions over unmatched (L,delta,d) triples.

## 5. Complete per-cell comparisons

For an actual cell, let N be the complete chosen exact normalized initialization, including the190 general products,19 coefficient prescales,357 shifted operands,357 additions, degree-specific raw bounds and their ordinary arithmetic proofs. Let A_E(n,j) be the complete exact normalized shifted-add price; A_R(p,j) the complete dyadic-add price. Let I_j(p) be the complete coordinate-pair conversion from (2), including its differing order-dependent denominator. Let R_E(a) and R_D(a,p) be the complete exact and dyadic output conversion prices. Then

    Cost_E = N + sum_{n<L-1,j<19} A_E(n,j)
                 +sum_{unit a} R_E(a) + Setup_E,
    Cost_R = N + sum_{j=0}^{19} I_j(p)
                 +sum_{n<L-1,j<19} A_R(p,j)
                 +sum_{unit a} R_D(a,p) + Setup_R.     (6)

Setup contains the actual coefficient-source conversion union, geometry/normalization powers, tables, range/coverage/policy proofs, storage, transport and cache lifetimes not already charged. The shared N cancellation in (6) is valid only under section2's same-initializer adapter. Otherwise retain N_R-N_E explicitly. Any equal setup cancellation also requires the same actual retained cache objects.

The exact adoption inequality against normalized FD is

    sum_{unit a}(R_E(a)-R_D(a,p))
       +sum_{n,j}(A_E(n,j)-A_R(p,j))
        >sum_j I_j(p)+Setup_R-Setup_E.                (7)

This includes all multiplications, additions, shifts, residual/range proofs and setup through the complete prices. Replacing them by the numeric cores of section4 gives only a projected reserve from which the remaining differential costs must still be paid. It is not a total saving. When upper cost bounds are used instead of exact declared schedule prices, compare a new upper bound with an old lower bound; subtracting unrelated upper bounds cannot establish an implementation-independent advantage.

For Horner let H_profile(a) sum all nineteen complete stages using actual reduced r/v, source grid and corresponding residual proof. Each stage includes the numerator product at the INPUT grid, any alignment shift, witness product at the OUTPUT grid, exact coefficient addition and all round witnesses. Its twenty coefficient conversions are per distinct source object. Let

    Cost_Hbest=min over accepted, fully priced Horner options
                  [sum_{unit a}H_profile(a)+Setup_profile].

Compare Cost_R<min(Cost_E,Cost_Hbest), subject to capacity and coverage constraints. The accepted bounded-DP grid has a15442 padded unsigned-product subtotal, the consistently repriced linear grid16252 and uniform grid17632; none is a complete H_profile. The optimized grid's seven nonzero alignment shifts, direct original-center conversion and grid-specific cache are distinct costs. The older conservative linear16312 subtotal is not the best matched product reference after the tighter accepted widths. Fair target denominator cancellation, proved zero/small-factor branches and any better accepted proof-table backend must be offered to all relevant competitors.

The rounded and exact FD options share a b100 source array with uniform Horner only if its actual conversion and retention match. The degree-grid arrays are different; converting a b100 cache again is not the accepted direct-conversion contract. The per-cell minimum may cease to be globally separable when setup is shared between selected cells or memory limits force eviction. No fixed denominator table, source cache or policy lookup is priced as immortal or free.

## 6. Storage, evidence and status

During traversal, the new state stores twenty complex pairs, at most40(p+44) raw signed bits in the ten-guard tier before object overhead. At p197 this is9640 bits. Exact initialization still needs its wide state and partial products. Conversion may temporarily retain both arrays plus shifted numerators, products, residuals and witnesses. Its605-bit scratch bound does not collapse to the241-bit live-state width. A streamed proof may release completed initial witnesses only after exporting the correctly bound state claims; that release and later reuse must follow actual verifier rules.

Precision selection (1), all-order coverage and the bucket's L/U identities need ordinary proof or previously proved metadata soundness. This report uses existing length examples and checks only exact exponent identities and template arithmetic. It performs no new occupancy scan. The script passed11287 assertions, including seven input pins, all260 length/precision rows, strict core thresholds and the normalization identity(2) on bounded exponent metadata. The general proof of (2) is exact cancellation of powers of two and does not depend on those finite fixtures.

This is a usable conditional price interface and a reproducible conversion-core example. It does not establish a winning backend, actual output count, successful signs, spectral completeness or end-to-end cost. Pending Stirling, truncated-state, new coefficient-grid or cache improvements require separate mathematical and cost joins.

Author script `major-constants/rounded_initial_costs_20261111.py`, SHA256 `C53F39BA5DBE3052C27201FF7C3193E3F160ABCECF5907601ED2A8432FAD0BF1`; receipt same stem JSON, SHA256 `5157CA6B7BEF1826EB0818DF7C1EED239961E0FD642BE622097CECC42902E7DB`. Full predecessor hashes are embedded in that receipt: rounded theorem FB0B0F9A, its10937-check metadata51A09104, independent review B493A996, matched normalized interface4E01AE12, normalized source EFB31BE5, optimized profile A27CD526 and its independent review A9D0D867. The byte templates are inherited from `integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md`, SHA256 `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227`, section3. These remain ordinary-proof templates requiring implementation, not new inference rules.
