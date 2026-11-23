# Independent review of complex multiplication and Karatsuba composition

2026-11-11. PASS for the original report together with the separate chunk-accounting clarification. This accepts the exact algebra, sufficient widths, and unsigned product/addition subtotals. It does not establish complete PA proof-operation counts, a signed implementation, runtime, numerical precision, or spectral success.

The reviewed report is `prime-estimates/EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md`, SHA256 `86D8A9435A9962CFF95194642E590D65C76B334E5AD24377959006E7AB17BEFF`. The required clarification is `prime-estimates/CLARIFICATION_COMPLEX_KARATSUBA_CHUNKS_2026-11-11.md`, SHA256 `788CB7708B95B05BB9FE12DD823CEE200E6D0468D2532A3963766A61C373278C`. I requested that clarification; the original frozen bytes were preserved.

No complex or candidate values, transforms, analytic functions, arithmetic tables or proof streams were evaluated. No build ran. A separate integer-only script independently reconstructed the saved recurrence and cost tables.

## Exact identities and capacity

For signed a,b on one common grid and c,d on another, all four products have the same product grid. Expansion gives

    c(a+b)-b(c+d)=ac-bd,
    c(a+b)+a(d-c)=ad+bc,
    (a+b)(c+d)-ac-bd=ad+bc.

No fixed-coefficient unit-norm assumption is required. Cached c+d and d-c must be exact sums of these same stored centers. If they instead have residual errors, the earlier magnitude-weighted error terms remain mandatory.

Take positive total bit bounds P,Q after permitted alignment, with |a|,|b|<2^P and |c|,|d|<2^Q. A pre-sum needs P+1 or Q+1 bits. Original products have magnitude below 2^(P+Q). Every fixed-path product is below 2^(P+Q+1), and either output sum is below 2^(P+Q+2). Gauss's large product is below 4*2^(P+Q); subtracting the original products sequentially gives safe intermediate bounds 5*2^(P+Q) and 6*2^(P+Q), covered by P+Q+3 bits. Its real output and both four-product outputs use P+Q+1. These are conservative capacities, not an assertion that the final algebraic result always reaches them.

P and Q are total aligned mantissa widths, not fractional precision alone. For a unit coefficient and a large intermediate input they may be different. Unbounded exponent-gap alignment is outside the formula. The earlier bounded-alignment or rounded-pre-sum interface must be used instead. Equal exact centers imply identical final rounded bits only with the same final grid, rounding rule and sufficient capacity. Exact-center computation does not make intermediate representation cost disappear.

## Unequal product recurrence

The general product recurrence G uses ordinary products, not the cheaper square recurrence or the modular-product Q template. Its third child is h+1 digits and its fixed overhead is the previously reviewed H(n)=12h+8n+21. A fixed multiplier does not by itself turn a product into a square.

For lengths a>=b>=1, the direct rectangular schoolbook term M(a,b)=5ab+2min(a,b)+1 selects the shorter row dimension. The padded G(a) branch is sufficient after proving the leading-zero representation. If a>=4 and b>h=ceil(a/2), both factors have a positive-length high part. The three recursive lengths are

    (h,h), (a-h,b-h), (h+1,h+1).

Each maximum length is strictly less than a. The split is therefore well founded. If b<=h the second high part would have nonpositive declared width, so omitting that branch is required and correct.

The same natural-number middle equation m+z0+z2=zs gives m=x0*y1+x1*y0 by ordinary distributivity and cancellation. Both sums fit h+1 digits. The shorter high part only reduces the product and recombination bounds, so H(a) remains a sufficient version of the old overhead. The output allowance of 2a digits may be larger than the necessary a+b; it does not understate the required capacity. Sign proofs, representation conversions and the precise implementation of these fixed lemmas remain additional.

## Identified chunk-accounting issue and its repair

Splitting the longer factor into radix-B blocks, B=beta^b, is mathematically valid. For a nonzero short factor y<B, maintain carry<y. Each block satisfies

    block*y+carry < B*y < B^2.

Its low block is emitted and the new high carry remains below y. The final carry is emitted at the end. A zero short factor needs the separate zero-product branch; the strict carry<y invariant cannot be asserted when y=0.

However, r*(G(b)+A(2b)) prices only the block product and carry addition. It omits the initial invariant, row algebra, low/high extraction and final reassembly proof applications. Calling that expression an event-complete sufficient product schedule would be incorrect, even after excluding generic byte encoding.

The clarification explicitly assigns all these proofs, including the zero-short-factor branch, to D_chunk. It also states that the minimum R is over subtotals with schedule-dependent omitted terms. This resolves the ambiguity without changing the equations or tables. Acceptance here is of the combined original-plus-clarification packet.

Independently traversing every selected product used in the displayed comparisons found no chunk branch, either at the root or at any selected recursive descendant. Thus this clarification leaves all displayed 25-case comparisons unchanged. It does not validate a future chunk-based total without D_chunk.

## Complex cost formulas and independent replay

With the stated ceilings nP,nQ,sP,sQ,o4,of,og, the four-product formula has four R(nP,nQ) terms and two product-width output sums. The fixed formula has one R(sP,nQ) and two R(nP,sQ) terms, one input pre-sum and two wider output sums. Gauss has two original-width products and one R(sP,sQ), both input pre-sums, one real output sum and two widest imaginary sums. These are exactly the products and sums used by the three identities.

The fixed path's S=2A(sQ) is paid once per usable cached coefficient entry, not omitted. Its storage and exact binding to the original c,d are additional. All uses must satisfy the same grid and cache-precision interface. A newly rounded or differently aligned cache is not automatically the same entry.

The separate script builds G and the full needed R table bottom-up, summing H from its addition widths. It then independently checks all 25 sensitivity rows and 75 method schedules, including output widths, all recorded branch alternatives, setup and strict break-even fields. It also reconstructs the 518 recurrence inequalities. These latter comparisons are sanity checks because M and G are options of the minimum; they do not prove that all excluded proof work is zero.

The byte-radix results match:

| P=Q | Four-product subtotal | Fixed runtime | Fixed once | Gauss |
|---:|---:|---:|---:|---:|
|128|5386|4348|4418|4377|
|192|11074|9072|9174|8840|
|256|18562|14855|14989|14601|
|512|60482|47008|47270|46556|
|1024|190350|145796|146314|144974|

The four-product comparison also receives Karatsuba improvements. At 128 bits the fixed runtime subtotal beats Gauss by only 29 while setup is 70, so strict amortization needs at least three uses. At the other four byte rows Gauss already has the smaller runtime subtotal; no positive number of uses amortizes a fixed-path runtime disadvantage against Gauss. All 25 fixed-once and Gauss subtotals beat the corresponding four-product subtotal, before excluded terms.

For positive Delta=F4-Ff, H*Delta>S is exactly the strict break-even condition, with smallest integer H=floor(S/Delta)+1. Including the differing proof costs changes it to H*(F4-Ff)>S+Dsetup+H*(Df-D4). This is the appropriate conditional comparison. The unsigned A proxy is not a proved signed-subtraction cost, and a lower subtotal does not establish a runtime or full-proof winner.

The previous mixed-radix precision theorem is also not an automatic end-to-end justification of this exact-center representation. That theorem requires a particular absolute complex-gate error. The implementation still must prove that its signed real computation, cache, output rounding and capacity meet that contract. The present paper gives compatible ingredients and widths, not an evaluated output enclosure or a completed composed checker.

## Frozen evidence

Paths below are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
|prime-estimates/complex_karatsuba_sizes_20261111.py|3F9B491D6750A5CF178C65B5A25AA8FDD938B52D12189512B59DCE4C098CF213|
|prime-estimates/complex_karatsuba_sizes_20261111.json|30A7BDD7FC7AE93533329A8F4AB5253F692948F4E1F5E41D3C6EEDB75B334AC8|
|prime-estimates/EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md|83D8C2953A4AEE557786904C09CED8433972876AA0B6698EBA8BF2C3B5F39EF4|
|prime-estimates/ERRATUM_COMPLEX_ADD_WIDTHS_2026-11-11.md|AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362|
|independent-feasibility/REVIEW_EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md|684D012748AD53D492A46B643CEF78550D5CF7359AFFECEB7048E9B5118F39DE|
|audit/REVIEW_EFFICIENCY_MM0_SQUARE_KARATSUBA_2026-11-11.md|767753AB7CE59C69922363DCF239C55B2D81C716194D62D977EE4CFE9F75A7B1|
|audit/review_complex_karatsuba_counts_20261111.py|FCDD70190056343650CB7B5C2002D559D7D34BF7DD2B984579DE21260DB4C513|
|audit/review_complex_karatsuba_counts_20261111.json|9C9675340B7C873588358660ADF1A847BA26C70A2A428006E9581EA54B97F4C4|

The independent integer script exited zero and imported no author code. The recurrence's PA source bodies and their fixed-lemma implementation limits remain as recorded in the square/Karatsuba review. This report creates no new formal declaration or accepted numerical certificate.
