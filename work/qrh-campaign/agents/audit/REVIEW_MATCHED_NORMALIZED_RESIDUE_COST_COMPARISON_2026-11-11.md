# Review of matched normalized residue costs

2026-11-11. PASS at conditional source/interface, exact-metadata and cost-model scope. No remaining correction is requested. This establishes no implementation, selected replacement set, proof-cost winner, runtime saving or spectral result. No actual coefficients, analytic functions, transforms, prime/zero values, builds or source changes were used.

Reviewed author `integration/MATCHED_NORMALIZED_RESIDUE_COST_COMPARISON_2026-11-11.md`, SHA256 `4E01AE12B9224898AF3CF169389B83B0BFFAE2FF0FDB74083B094BEB6735C54C`. I read the full final report, its script/receipt, the two Horner input papers and external reviews, and the normalized-state paper and its now-completed external review. The nine author input hashes match. The normalized proof review was pending at the author's freeze; it has since passed at the separate scope recorded below. No frozen author file is changed by this review.

## Independent input status

The uniform b100 Horner paper is my own author work. Its acceptance here comes from moebius/REVIEW_B100_PRODUCT_ONLY_HORNER_2026-11-11.md, SHA256 `1C1902623E32D7D565A3173FE852E4B4340A154EC71AE6F462196C7CAA65AD7A`, binding author84E9E149. This review does not independently approve its own author result.

The degree-grid paper0249787E is independently reviewed by prime-estimates/REVIEW_DEGREE_DEPENDENT_HORNER_GRID_2026-11-11.md, SHA256 `D475972DB3EBDEC46D1AAB5DC5D4CBD7D7C157936E333ECE46737F45C34DC5E9`.

The final normalized-state source is independent-feasibility/RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md, SHA256 `EFB31BE5B3A556CE88A29B1E566ACB86E026F7C9E3E778F67F5B81453914F004`. Its external review is zero-sum/REVIEW_RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md, SHA256 `9F1C14DFD493FE96E4F234EB3526A55D2AF0A25A9BCFE98E56D1DF709DF0A3A5`. I read and hash-verified that review. Its corrected height classes are separate from this comparison, which consumes no eligibility or aggregate saving total. The withdrawn preliminary normalization receipt is not evidence here.

## Coefficients, outputs and error contracts

All methods bind the same original source coefficient object, actual height, fine anchor and Dout. Uniform Horner and FD may share one converted b100 array only under identical object and cache identities. The degree-grid array is different: its coefficients must be rounded directly from the original centers to100,100,98,...,81. Reading a uniform-b100 array and rounding it again would require an additional error proof. Equal conversion counts do not prove equal conversion costs or justify cancelling distinct work.

The output requirement is the same set of unit targets, not identical rounded values. Uniform Horner, degree-grid Horner and exact FD each preserve the old per-residue evaluation allowance. Arbitrary mixtures retain1688u after the inherited character/conductor bound. The all-FD1477u subtotal cannot be assigned to an arbitrary mixture. Original source uncertainty, analytic shift/target remainders, finite-head attachment and later transforms remain separate.

## Horner stages and the byte subtotal

The uniform schedule retains nineteen product rounds and exact same-grid coefficient additions. In its selected witness realization each real stage proves r*M and q*v, followed by reconstruction, remainder/tie checks, any increment and the coefficient addition. Native quotient discovery and a reflected-checker alternative have their own costs. The stated117/115 magnitude-bit long factors and136/137 signed product/reconstruction envelopes match the independently reviewed input.

For degree-grid stage j, the arithmetic product uses the incoming exponent b_(j+1), while the witness product uses the outgoing b_j. The exact alignment is0,2,1,...,1 bits as j runs0,1,2,...,18. The two-bit j1 transition is retained. Charging both factors at the same precision or dropping the eighteen nonzero shifts would misprice the circuit. The published raw numerator, witness, residual and doubled-residual capacities include these transitions and do not rely on a small accepted residual before subtraction.

Using the stated unsigned byte-product template only, I independently reconstructed seven stages with two13-byte long factors, eight with two14-byte factors and four with two15-byte factors. This gives16312 macro events and3156 digit cells, against17632 and3420 for the uniform15-byte envelope. These are unreduced padded product subtotals. Signed proofs, shifts, coefficient additions, range checks, quotient discovery, conversion and setup are excluded and remain charged in the complete model. The1320 difference is not a full proof-event saving or runtime comparison.

The final note also gives both Horner methods the target reduction r/2^p and v/2^p. For degree alignment a_j, cancellation of2^e with e=min(a_j,nu2(v_p)) is valid without any divisibility assumption on M. Its remaining shift, exact identities and smaller divisor must be priced. The unreduced byte subtotal cannot stand in for this reduced comparator against normalized FD.

## Normalized FD accounting

The common cell factor is determined by conductor valuation, F and anchor parity. It is not an arbitrary factor extracted from one output. The reduced partial Newton polynomial has a degree-dependent common factor, so prescales and initialization must use the reduced v',F',r' directly. Common-grid coefficient conversion and the c>10F domain remain required.

For lambda_j=j*delta+nu2(j!), the recurrence constructs integral order-normalized states directly. Initialization remains top-first and descending; traversal is ascending. The power-only initializer retains190 general products,190 recurrence additions,167 binary small-scale additions and357 shifted/reference occurrences. Each advance requires nineteen additions with shifted higher operands; nine shifts are nonzero at delta0 and all nineteen at delta>=1. A zero shift still requires its operand reference and addition. All nonunit positions remain traversed.

The per-order capacity W(i,j)=100+ell_i+25+j-lambda_j follows from the reduced source bound. It is the sum, not the possibly negative offset alone, that is a signed capacity. Raw Newton products/sums use the separate partial-degree bounds. Traversal's shifted higher term has twice the lower generic bound, so their raw sum can require two guard bits above W. The smaller stored-state width alone cannot price that temporary.

The distinct full-factorial normalization is explicitly outside this sum. Its190 initializer additions/top copies and40 additions/40 shifted operands per advance cannot inherit the power-only167/357 initialization accounting. Future rounded-initial-state schemes likewise need a different error and quotient schedule.

## Output-only reduction and cache keys

Order zero has lambda0=0. The order normalization does not reduce the final numerator. At a consumed in-cell output, the sharper polynomial bound instead gives100+ell_19+18 signed bits for the dividend, independent of the worst auxiliary state. Final quotient discovery or its supplied witness remains necessary.

For required units, p=t+1 occurs exactly when nu2(c)=f and k is odd. There r' and v' are even, so every homogeneous degree19 term has the additional2^19 factor. The exact output adapter can divide numerator and denominator at that target. It cannot divide the all-numerator state, whose intervening nonunits need not share the factor. The final note binds this exception and gives Horner the same target fraction reduction.

A full reduced denominator table needs conductor, t and any selected output adapter/grid identity. A conductor-only key is insufficient unless it explicitly covers the variants. An odd-core product table instead proves multiplication by odd(c)^19 followed by an exact shift. That factorization changes the product operand; it does not discard low dividend bits or shrink residual inputs without proof. It is available to direct products and table products, and to the unreduced FD comparator as well. Setup, power identity, signed restoration, decomposition, lookup, cache lifetime, imports and rebuilding remain charged.

The fixed-Q and narrow-factor table proposals are optional methods. Their separate proof and implementation conditions are not discharged by this comparison. The complete model does not grant FD free table reuse while preventing an admitted Horner alternative.

## Complete decision rule

The matched set includes the same required units and fallback partition. Horner evaluates its units; FD also pays initialization and every intervening numerator advance. Conversion, geometry/normalization, tables, source bindings, traffic, proof transport and output costs are summed over their real lifetimes. Identical b100 conversions may cancel; distinct degree-grid conversions generally do not.

The stated full-sum inequality and its declared uniform-cell specialization compare complete schedules. H_unit means an entire nineteen-stage Horner evaluation, and A_advance an entire nineteen-order shifted update. Nonnegative overhead rules out a benefit when H_unit-R_unit is nonpositive; otherwise the complete remaining terms determine the threshold. U=0 supplies no baseline evaluation saving. Metadata rejection avoids exploratory work only when that work was not already performed.

Independent objectives for generation, proof production and checking, plus storage/byte constraints, are retained. Two unrelated upper bounds cannot establish a saving. No eligibility screen, fractional-bit sum or normalized width is promoted to a full cost result. The remaining work is concrete matched arithmetic/proof methods, actual cache lifetimes, coverage records and source coefficients.

## Independent exact evidence

Own checker `audit/review_matched_normalized_residue_20261111.py`, SHA256 `AE3F985BF10422C08ED3AD2FC6A3F68B1B0872B2CECFFA062B1AD1DF865661CA`, passed10518 exact checks. Receipt `audit/review_matched_normalized_residue_20261111.json` has SHA256 `1E562A0F7A51B5AF661085CBCAA6CC849F2EBA809A67C355DF069417B3A4C29D`.

The checker reconstructs all nineteen byte rows, all300 order-offset rows for delta0..14, shift counts, oddpart counts and alignment cancellations. It also checks730 bounded abstract geometry fixtures, including56 exceptional output cases. These are integer identities, not a selected-family scan or coefficient evaluation. It imports no author program. Author script5BBE732A and receipt69441DBF, the final report and all nine input pins match; full hashes and paths are retained in the independent receipt. The later normalized-source review is additionally pinned above and was checked read-only.
