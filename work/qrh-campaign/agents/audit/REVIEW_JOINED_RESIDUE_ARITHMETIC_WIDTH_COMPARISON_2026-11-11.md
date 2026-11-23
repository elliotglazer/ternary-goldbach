# Review of the joined residue arithmetic comparison

2026-11-11. PASS for the conditional source/error, width and cost-model composition. No correction is requested. This accepts neither an aggregate saving nor the pending candidate implementations. No analytic values, actual coefficients, transforms, prime candidates, zeros, builds or Lean changes were made.

The author is `integration/JOINED_RESIDUE_ARITHMETIC_WIDTH_COMPARISON_2026-11-11.md`, SHA256 `73609552DF8A9847C2C0E65447F6CBE609C352643A8CBA3B5B50354E78311546`. I read the entire note, script and receipt, the Newton proof/review, the ten-guard proof/review, the prior width framework and fixed-denominator proposal, together with the already inspected exact-circuit and coefficient-grid interfaces. All twelve input hashes match.

The separate b100 product-only Horner candidate is authored by this reviewer and is therefore not independently approved by this review. The joined note correctly marks that candidate as pending at its freeze. Its eventual independent review must supply that acceptance. The fixed-Q table implementation likewise remains a conditional proposal here. Rechecking its displayed arithmetic subtotal is not acceptance of all its proof-template obligations.

## Source and error composition

The target is the same delivered degree-19 finite polynomial for zeta(s,1+alpha), with a separately paid b100 change of centers when that adapter is selected. Dout and the actual fine-anchor denominator F=2Dout are preserved, including final Dout8192 rather than its source-grid4096. The ties-down cell partition is bound to the same coefficient lookup. Character/conductor weights, finite-head/residue attachment and later transforms remain separate.

For actual in-cell arguments, coefficient requantization contributes below(4/3)u and exact FD plus final rounding below u, with u=2^-100. The1477u character-summed result applies only to the all-adapter case. Mixed schedules retain the old1688u cap or a proved subset-weighted improvement, as required by the immutable grid clarification. No analytic error is claimed at off-cell setup points.

The c>20F and c>10F full-state constructions have different magnitude proofs. Their auxiliary polynomial supports are respectively below3/4 and6/5 in absolute value. The finite geometric bounds4C and256C give signed live/advance capacities500/501 and506/507 at b100. The actual in-cell function domain has not changed. The two screens involving phi(c) and all nonempty integer buckets imply their respective geometric guards; neither screen proves a compute saving.

## Old Horner is not a wide FD product

The joined note repairs the important old-comparator omissions. An original z19 on grid b_in starts the first product; it is not automatically a g100 accumulator. Its divisor after output-grid cancellation is2^(b_in-100)*2c. Later rounded accumulators use divisor2c. Every addition must align the actual original coefficient representation before rounding. A norm-error statement alone does not supply b_in122.

The old product and addition capacities are conservative and valid. With coefficient magnitude below2^16 and h at most1/4, all rounded old accumulators remain below2^17. The first coefficient product fits the declared b_in+37 signed envelope. Later g100 products fit136 signed bits, and aligned additions fit max(b_in,100)+18. The respective divisor bounds20+b_in-100 and20 bits follow from2c<2^20. Finer or non-dyadic input encodings need their actual costs.

The prospective grid100 Horner uses the converted coefficients, exact same-grid additions and only product rounds. The joined note does not silently relabel it as the original two-rounded-gate schedule. Its pending status and additional source/grid acceptance are retained. Common conversion charges can cancel in a comparison only for identical arrays retained under matching lifetimes.

## Newton counts and widths

The initializer's binomial-basis proof preserves the actual partial polynomial at every degree. Initialization writes the new top first and updates downward. Traversal updates upward. This distinction is essential. The same polynomial and full-state traversal are used under each guard; the separate pruned long-block formula is not inserted into these counts.

At degree i there are i general products, i recurrence additions and i small scales. Summing gives190 of each. The stated binary small-scale realization adds167 further additions and357 shifted-operand occurrences. This yields357 initialization additions and19(L-1) advances, or19L+338 additions per full bucket. Nineteen conductor-dependent coefficient prescales remain separate. Two real coordinate operations underlie each listed complex operation.

With ell_i=bitlength((2c)^i), the degree-sensitive general operand bounds100+ell_(i-1)+j+19 and100+ell_(i-1)+j+25 are correct. They follow from the partial-polynomial difference estimates, not from a bound on the final result alone. The largest general input is480 or486 signed bits. The raw-result bound for the ten-guard interior update includes an extra factor2, compensated by j<=i-1; it does not depend on cancellation. The actual-family general factor bound remains19 magnitude bits plus sign under both guards.

Prescales multiply a117-bit signed coefficient numerator by an ell_i-bit nonnegative power, with result at most100+ell_i+17 signed bits. Geometry powers can share by conductor; prescaled coefficients and initial differences depend on the coefficient array and cannot be treated as height-independent. Every small-scale shift and proof/data reference remains charged.

## Final round and optional table

The final numerator has the stronger in-cell bound, regardless of auxiliary guard. Since |P_100(h)|<(4/3)2^16, the exact numerator I has a480-bit signed envelope, Q=(2c)^19 has362 bits, and the grid100 output numerator has118 signed bits. Using506 as a necessary final input width would overcharge this step. Conversely, a small final residual does not permit small subtraction operands before cancellation.

The one-product witness p=mQ and signed residual R=I-p, with -Q<=2R<Q, is equivalent to the intended nearest rounding with ties toward positive infinity. The analogous narrow Horner witness has divisor2c. These need different complete prices. Quotient discovery for generation, signed product checking, residual formation and comparisons do not disappear because a quotient is supplied.

The fixed-Q table's displayed conditional subtotal is arithmetically correct:3481 direct macro events,1723 table-product events and24739 setup events give first strict product-subtotal crossover at15 scalar uses. Those figures exclude substantial named terms and are not execution time or proof-byte counts. This review accepts only their faithful use as a conditional submodel. Table correctness, closed numeral bindings, decomposition, signs, retained facts, rebuilds and ordinary-rule implementation remain as stated in that separate proposal. Neither backend is given a free table unavailable to its comparator.

## Admission policy and scope

The complete model sums degree-specific initialization, all nonunit advances, actual final rounds, conversion on the union of source arrays, geometry/table setup by lifetime, coverage and data/proof traffic. The old baseline uses its actual replaced unit outputs and own first-stage/alignment costs. Fallback cancellation is valid only for an identical fallback partition. U=0 gives no baseline saving.

For a declared uniform cell model the inequality

    U*(19H_t-R_t)>I_t+19(L-1)A_t+G_t

is exactly the comparison of complete stated schedules. If19H_t<=R_t, nonnegative overhead cannot certify a win. Otherwise division by the positive denominator gives the stated strict U threshold. A per-cell allocation must sum to actual global setup and cache charges. Metadata-only rejection avoids initialization only if initialization was not already performed.

The note correctly distinguishes native generation, proof construction, checking, proof bytes and live storage. A robust implementation-independent claim needs a new-cost upper bound below an old-cost lower bound; two unrelated upper bounds cannot prove improvement. The existing occupancy totals supply no omitted per-cell unit histogram, selective pruning proof or universal cost conclusion. No total schedule deduction follows from190 Newton products alone.

The remaining obligations are concrete arithmetic/proof methods at these widths, actual cache lifetimes, exact chosen-cell/fallback coverage and coefficient data. The generic correctness theorems and concrete finite acceptance remain distinct. This is a usable conditional comparison framework, not a completed computation, proof-cost winner or finite-RH certificate.

## Exact independent evidence

Own checker `audit/review_joined_residue_width_20261111.py`, SHA256 `3A177B4A7EA18774D3F54865F18F90C5D59E8BBE72F41E897B0448FA58E5A23D`, passed1517 exact checks. Receipt `audit/review_joined_residue_width_20261111.json` has SHA256 `E4C99D50219D589F5BD8D5430189D33DEA7491F3A6333FC9FEA50697F8257567`. It independently reconstructs all nineteen degree rows, guard-specific bounds and counts, old first-gate widths, final numerator/divisor sizes, cost identities and the conditional table subtotal. It imports no author checker and evaluates no actual coefficient or analytic function.

Author script SHA256 `EDE4919DEE7A2D200E1C8803E90A695CA8857ADC51ED40AC42BF89AE81261A06`; author receipt SHA256 `581485B43E48F22C3DFAA2C7DFAE11CBC35CC758D2C5037366A1F3876404B5F2`. The twelve complete predecessor hashes and source paths, plus the author artifacts, are recorded in the independent receipt. No frozen file was modified.
