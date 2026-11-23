# Length guards and stagewise finite-difference costs

2026-11-11. Bounded finite geometry, rational envelopes and declared arithmetic-template metadata only. No coefficient/function/transform values, prime candidates, production scans or builds. Frozen predecessors remain unchanged. The new result is a guard implication and a concrete conditional per-cell cost interface; it is not an aggregate selection or a method winner.

## 1. Derive the guard from the actual tie convention

For integers c,F>0 and physical numerator a, the accepted ties-down anchor is

    k=floor((2Fa+c-1)/(2c)).

The defining floor inequalities and integrality are equivalent to

    2kc-c+1<=2Fa<=2kc+c.                              (1)

This is open on the left and closed on the right in the real nearest-anchor interval. Let a0 and a1=a0+L-1 be the first and last members of one nonempty consecutive bucket. Applying(1) to both gives

    2F(L-1)<=2c-1,  hence F(L-1)<c.                  (2)

In particular L<=ceil(c/F). Endpoint clipping to1<=a<c cannot invalidate(1) or enlarge L, so the result includes both clipped cells. At c=10F an eleven-point cell would contradict(2); equality cannot be hidden at a tie. Likewise c=20F forbids L21.

Thus the following deterministic width-domain policy is sound:

    L<=10: use retained in-cell all-cell bounds;
    11<=L<=20: c>10F, use sigma=1/20 bounds;
    L>=21: c>20F, use sigma=1/40 bounds.               (3)

This policy may be conservative when the actual c,F prove a stronger guard at a shorter length. It is not an optimal-domain-selection claim. It supplies a legal way to consume existing length histogram rows, but a histogram alone does not determine unit counts U, conductor powers, anchor parity or operand widths. Those inputs must remain bound to actual cells.

## 2. Circuit and width choices

Use the accepted degree19 b100 source-bound polynomial and all twenty direct coordinate-nearest coefficient conversions. The stagewise source theorem61A6DD47, reviewed atF8A063A5, supplies the separate old-state, general-product, secondary-product, inserted-coefficient and raw-sum envelopes. It includes the actual stored-vector numerical error plus the explicit coefficient conversion error. The all-cell rows annihilate polynomial degrees below the difference order before bounding the retained in-cell tail. Therefore z0 never enters a positive-order envelope.

Set m=min(20,L). Both exact and rounded variants use the accepted truncated initializer, all nineteen coefficient prescales, and only initial orders0,...,m-1. Their counts are

    G(m)=m(39-m)/2 general complex products,
    G(m)+sum_(j=1)^(m-1)(20-j)(popcount(j)-1) additions,
    sum_(j=1)^(m-1)(20-j)popcount(j) shifted operands.

The shifted operands include copies with shift zero. They do not disappear merely because a backend represents them by a reference. At each physical position n the traversal updates j=0,...,min(18,L-2-n) upward. It includes nonunit positions and discards an order only after its final dependency. The number of complex additions is sum_{n=0}^{L-2}min(19,L-1-n). All source coefficients remain even when m=1.

For the long cells admitted by(3), the numeric schedule uses the accepted power-only normalized initializer with v'=v/2^t, F'=F/2^t and lambda_j=j*nu2(F')+nu2(j!). Its exact identities and setup are charged. For L<=10 this bounded schedule uses the unnormalized all-cell initializer, avoiding an unproved automatic extension of the normalized input's domain. This is a specified candidate family, not the strongest possible future short-cell circuit.

The exact traversal uses the actual order-dependent normalized shifts in the long-cell cases. It bounds each raw update by the SUM of the two relevant positive stagewise envelopes, divided by the correct2^lambda_j. The new rounded traversal instead uses a common grid p(L), with

    p=102+bitlength(sum_(j=0)^(m-1)binom(L-1,j)).       (4)

For every retained live order its represented value differs from the exact difference by less than u/4, u=2^-100. A stored-state magnitude bound is therefore E_j+u/4 and a raw ascending-add bound is E_j+E_(j+1)+u/2. Both are multiplied by2^p before integer capacity is assigned. The metadata uses these rational sums directly; it never adds an error to a bare strict power cap without proving slack.

At initialization the order-j nearest grid-p numerator is bounded by2^p(E_j+2^-p). Its exact quotient from a normalized initial state is

    E_integer,j *2^(p-100+lambda_j) / v'^19.

Cancel only the proved common power of two between that displayed shift and the denominator. All m initial complex conversions remain wide rational witnesses, distinct from final dyadic rounding. The shifted numerator, product, residual and range temporary use their actual reduced denominator and degree/order bound. In the short-cell unnormalized case lambda_j=0 and v'=v.

At final exact-FD unit outputs, apply the same admitted target fraction reduction as Horner. The denominator may be factored into its odd core and a restored power-of-two shift for the product witness; this does not remove the residual or shift proof. Rounded outputs instead divide by2^(p-100). The physical order-zero source bound plus u/4 and final-round error gives the output numerator bound. Final output rounding is never fed back into traversal.

All numerical error statements remain those of the accepted truncated and rounded circuits. Their total source-polynomial error is below31u/12 and hence below8u/3; mixtures retain the inherited1688u character allowance unless actual subset weights justify more. The stagewise magnitude theorem changes capacities, not the error allocation or spectral requirements.

## 3. Declared ordinary-arithmetic schedule

The receipt uses the previously reviewed unsigned byte macros

    A(w)=2ceil(w/8)+1,
    M(a,b)=5ceil(a/8)ceil(b/8)+2min(ceil(a/8),ceil(b/8))+1.

These are padded magnitude-adder/product template events. Every multiplication is oriented with the shorter byte operand as outer rows. The schedule prices general Newton products at their OLD partial-state widths and actual geometry-factor widths. Prescales use the individual new coefficient width and v'^i. Binary secondary scales use the stated shifted operands and the separately proved secondary raw bound. No product is assigned the global final-state width unnecessarily.

The exact nearest-round witness proves P=qD, P+R=X, 2R+D=W and W+g+1=2D for nonnegative W,g. It therefore checks -D<=2R<D, including signed ties. The numeric core charges its product and THREE magnitude adders; exact shifts, signed bridges, encoding/range/binding and quotient discovery remain separate named rows. The last addition uses carry-in. Dyadic products use a shift instead of M. Odd-core denominator multiplication also restores its power of two by a charged shift. No native division or multiplication is an acceptance premise.

For each fixture the receipt retains separate ledgers for cold geometry powers, initializer, exact advances, rounded advances, initial conversion, exact unit conversion, dyadic unit conversion, and each Horner profile. A ledger records magnitude core events, product/adder macro counts, a list of [operand-capacity,shift-distance] terms including zero shifts, and signed-wrapper occurrences. It is not a scalar grand total: signed bridges and shift/reference terms can have different width-dependent prices. The generic wrapper convention also charges a sign bridge for nonnegative power products; an implementation may separately prove and price a natural-number specialization.

The cold power schedule constructs v'^1,...,v'^19 by nineteen declared products. It does not assume a retained power cache. Sharing that setup requires the actual conductor/normalization key and checked lifetime, and replaces the cold cost rather than being added to it. Remaining geometry construction includes the actual anchor identity, r0, v, normalization, factors and lambda facts. It is an explicit additional setup row, alongside all twenty original-center conversions, source/height/anchor bindings, ordinary arithmetic-library proofs, term construction, policy, storage, transport and coverage. No numerical source encoding is available here to price its conversion widths honestly.

The exact normalized and rounded options share the SAME initializer only with the proved normalized-to-dyadic adapter. Each gets its own subsequent work. The Horner alternatives use the three reviewed fixed profiles and their actual stored-degree envelopes. At every unit they receive the same available r/v power cancellation and alignment cancellation. Both the numerator product and nearest-witness product, the three residual/range adders and final exact coefficient addition are counted for every stage. All nineteen stages and profile-dependent shifts remain. Direct conversions for the degree-grid objects are different from the uniform b100 cache and are not free re-roundings of it.

## 4. Twelve bounded geometry fixtures

The examples below use actual c,F,k and exact clipped bucket endpoints. U is counted only by gcd(a,c)=1 over those at most260 numerators. This is bounded integer metadata, not a prime search or a new family inventory. Each conductor is in the selected even large family; the receipt checks a source-band grid index below its reviewed target height. The final row uses the final coefficient class; the others use the first-four class. There is no claim that these examples represent the distribution of all buckets.

|c|F|k|L|U|m|p|Width domain|
|---:|---:|---:|---:|---:|---:|---:|---|
|10004|8192|1|1|1|1|103|all-cell|
|16388|8192|1|2|1|2|104|all-cell|
|20484|4096|1|5|2|5|107|all-cell|
|10244|1024|1|10|4|10|112|all-cell|
|11268|1024|1|11|3|11|113|10F|
|20484|1024|1|20|7|20|122|10F|
|21508|1024|1|21|10|20|122|20F|
|40964|1024|1|40|14|20|141|20F|
|81924|1024|1|80|27|20|163|20F|
|133124|1024|1|130|62|20|177|20F|
|265800|1024|1|260|70|20|197|20F|
|10004|16384|2|1|1|1|103|all-cell, final source|

The following are ONLY the product-and-magnitude-adder cores for those fixed padded schedules. FD includes the nineteen cold power products and all prescales; both variants include their actual conversions and retained advances. Horner uses the previously reviewed fixed optimized profile here, not a newly optimized grid for the new envelopes. The JSON also retains uniform and linear profile ledgers.

|L, source class|Exact FD core|Rounded FD core|Fixed optimized Horner core|
|---|---:|---:|---:|
|1, first-four|63655|63781|9168|
|2, first-four|74007|78601|9228|
|5, first-four|120151|132631|16690|
|10, first-four|184227|202975|34906|
|11, first-four|147195|172337|25738|
|20, first-four|217331|244409|64596|
|21, first-four|231621|234849|90514|
|40, first-four|319037|291329|128602|
|80, first-four|523807|388747|252180|
|130, first-four|897392|500984|578306|
|260, first-four|1333396|753864|653154|
|1, final|61973|62123|8584|

The table is deliberately not a method-selection table. For example the L130 row has a smaller rounded-FD core but still must pay its own shift, signed, setup, conversion-cache and proof costs against Horner's corresponding costs. The L260 row has a different unit density and does not inherit that projected advantage. Both comparisons are against specified padded schedules, not an implementation-independent subtraction of arbitrary cost upper bounds. Better zero-factor, table, cache, odd-core or normalized short-cell algorithms remain alternative competitors requiring their own admitted schedules.

## 5. Complete adoption test and limitations

For a method M and actual cell, define

    Cost_M = Core_M
       +sum actual shift/reference prices(width,distance)
       +sum signed/range/representation proof prices
       +quotient discovery for the generation objective
       +geometry/source conversion/cache/policy/coverage costs
       +storage/transport/library costs.                            (5)

Every term uses its actual objective: native generation, proof production and ordinary checking need not have the same price or winner. Exact normalized FD, rounded FD and the best fully priced accepted Horner option can be compared only after(5) is supplied. Common costs cancel only for the same exact source object and retained proof/cache lifetime. If using bounds instead of exact charged schedules, a robust saving needs a new upper bound below a comparator lower bound; unrelated upper bounds do not establish a saving.

The rounded option retains simultaneous wide initialization and conversion scratch, then narrow state storage. Short cells keep only m orders; initialization still consumes all twenty coefficients and nineteen prescales. Long cells may reuse powers or coefficient objects across heights only under their own checked identity. A length histogram proves the guard in(3) but cannot replace actual U, geometry or cache accounting. No broad sweep or aggregate saving is inferred from the twelve rows.

## 6. Evidence and review boundary

The new length implication(2) is an exact integer proof for the existing tie rule, not a floating-point ceiling heuristic. The scalar script checks all chosen bucket memberships, lengths, unit counts and selected source-band height domains. It composes actual rational stored-degree bounds, order normalizations, rounded-state slack and reviewed Horner envelopes. Its637 assertions involve only bounded integer geometry and exact rational metadata. It imports no author evaluator and constructs no coefficient values.

Script `major-constants/length_guard_fd_costs_20261111.py`, SHA256 `D1D3DC304F17B1FC9314BAF789FD6E2F16001F7DC893176CC271C9D107AA972A`; receipt same stem JSON, SHA256 `5388F1D02DBA2A7BD4F921DAAE55AA4BEEAFC3217E6DC0C7F65DFBECC8A2CA50`.

Eight complete input pins are embedded in the receipt: stagewise author61A6DD47/data717D0A36/reviewF8A063A5; all-cell author52136903/review365EA347; fixed-Horner data4F114004/review57D7DEDB; prior complete-round cost interfaceBB570E4A. The normalized identities are inherited through the stagewise packet's pinned source EFB31BE5/review9F1C14DF. The even-height domain check uses the already reviewed D3408AA2 profile, with u=19.1 and floor255 for these c>10000; Hbase is already dominated there. These remain paper/source interfaces awaiting actual ordinary-rule records and final spectral certificates. Independent review of this new composition is required before cost adoption.
