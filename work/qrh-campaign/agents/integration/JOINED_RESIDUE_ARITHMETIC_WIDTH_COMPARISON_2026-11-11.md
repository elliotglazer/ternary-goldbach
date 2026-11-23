# Joined width-sensitive residue arithmetic comparison

2026-11-11. Paper circuit and cost composition only. No coefficient, analytic, prime, zero or transform values, builds, declarations or source edits. All frozen predecessors remain unchanged. The comparison admits no aggregate saving.

Newton initialization and the optional b100 coefficient representation now give a concrete finite-difference competitor with 500-bit or 506-bit live states. The old rational Horner stages have much narrower integer products and round divisors. The decisive comparison therefore includes initialization, nonunit advances and final wide division witnesses. Counting 19 replaced multiplications per output is insufficient.

There is also a cheaper prospective Horner competitor on the same b100 centers. It rounds only products and adds each coefficient exactly on the common grid. Its mathematical error argument is given below, but its separate author/review packet is pending at this note's freeze. Neither that candidate nor a fixed-denominator proof table is silently substituted into the accepted operation ledger.

## 1. Common target and guarded domains

Use the V2 full-state circuit, its reviewed Newton initializer, and the reviewed coefficient-grid closure with its mandatory mixed-evaluator clarification. Let F=2Dout, v=2c, and use the actual ties-down anchor

    k=floor((2F*a+c-1)/(2c)),
    r(a)=F*a-k*c,  h(a)=r(a)/v,  -1/4<h(a)<=1/4.

The first four Dout values are512,1024,2048,4096. The final delivered Dout is8192 even though its source grid is4096. Changing F in this geometry changes the polynomial/occupancy binding.

The optional adapter rounds each of20 original complex centers to coordinate grid2^-100, with ties toward positive infinity. It supplies new coefficients z'_j=n_j/2^100 and preserves |z'_j|<2^16 using the explicit source margins. The polynomial changes. At an in-cell output, its change is less than(4/3)u, u=2^-100. Original source uncertainty and analytic target/shift errors remain separate. Exact integer finite differences evaluate

    I(a)=sum_j n_j*r(a)^j*v^(19-j),
    P_100(h(a))=I(a)/(2^100*v^19).

Their final rounding contributes less than u. Thus evaluation plus coefficient conversion costs less than(7/3)u per residue, versus the old Horner allowance(8/3)u. Under character amplification633, the all-adapter subtotal is1477u instead of1688u. A mixed schedule retains the old1688u cap by subset weights; the improved1477u global formula cannot be applied to residues still using original-center Horner.

Two full-state domains are now independently reviewed:

|Guard|Polynomial-only support bound|Live signed bits at c<=265800|Advance temporary bits|
|---|---|---:|---:|
|c>20F|support magnitude<3/4, polynomial magnitude<4C|500|501|
|c>10F|support magnitude<6/5, polynomial magnitude<256C|506|507|

Here C=2^16 and b100 is explicit. Auxiliary polynomial arguments can leave their original cell or[0,1]. Only consumed in-cell targets use an analytic approximation theorem. No rounding occurs at the auxiliary points. The c>10F proof does not enlarge an analytic-function domain.

For one full cell let L be its integer length and U the number of required unit outputs. Advance through all L integers, including nonunits, with19 additions at each of L-1 advances. Short endpoint cells use the same full initialization. A zero-unit cell still costs initialization in the unpruned reference. Removing it requires a checked unit manifest and a separately charged pruning decision. The distinct pruned long-block circuit has different counts and is not priced here.

The screen phi(c)>20B_c implies c>20F; phi(c)>10B_c implies c>10F, where B_c counts all nonempty integer buckets. These are geometry implications, not saving criteria. A proposed selected schedule must still bind its actual cells, heights, units and fallback partition. Existing aggregate occupancy is not a unit-run histogram.

## 2. The old comparator and a pending stronger one

The accepted old contract has19 exact rational real-times-complex products and19 complex additions, each rounded with complex error at most u. A price H_old must include both rounds, signed arithmetic, exact h, coefficient decoding/alignment and witnesses. Its final evaluation error is at most(8/3)u.

The first multiply starts from original z_19, not automatically a g100 accumulator. If all original coordinates have an established exact common grid2^-b_in with b_in>=100, this first product has round divisor2^(b_in-100)*v after output-grid cancellation. The subsequent18 products start from g100 states and have divisor v. Every addition still aligns the original coefficient grid with100 before rounding. For arbitrary supplied rational/dyadic encodings, replace b_in by their actual checked representation costs; the old norm-error contract does not establish b_in122.

For such a common dyadic input grid, sufficient coordinate capacities are:

|Old operation|Sufficient width information|
|---|---|
|First coefficient times r|at most b_in+37 signed bits, conservatively|
|Later g100 accumulator times r|136 signed bits|
|Coefficient-aligned addition|at most max(b_in,100)+18 signed bits|
|First product round divisor|at most20+b_in-100 bits|
|Later product round divisor|at most20 bits|

These are conservative envelopes, not exact operand lengths. The old stored states remain below2^17 in norm by the geometric Horner bound. The addition rounding proof is dyadic, but shifts, carries and exact source terms are still charged. The width framework's separately proposed fused stage is another candidate; it must not be identified with the original two-round schedule.

A stronger pending comparator uses the same new b100 coefficients as finite differences. Initialize A=z'_19. At each step round h*A to grid100, then add z'_j EXACTLY on that grid. If E is the norm error relative to exact Horner on P_100, then

    E_next <= |h| E + u,
    E_final < u*sum_(j=0)^18 (1/4)^j <(4/3)u.

Adding coefficient conversion gives less than(8/3)u relative to the original polynomial, within the old allowance. Stored accumulators satisfy |A|< (4/3)(C+u)<2^17, so118 signed bits suffice; coefficients need117 signed bits. The exact product numerator r*M needs at most136 signed bits and its divisor v at most20 bits. Exact grid addition stays within the118-bit accumulator cap. Its final output is already on grid100, so there is no extra final round.

For one coordinate, the product-round witness is p=m*v, R=r*M-p and

    -v <= 2R < v.

This proves the ties-up nearest round. Both coordinates give norm error below u. The direct coefficient addition uses integer addition, with no new rounding witness. This is a new circuit with its own proof/implementation obligation, not the unchanged old two-rounded-gate circuit applied to quantized centers. The separate grid-Horner packet and review are pending. Once admitted, it is the more demanding comparator for finite differences. Its conversion cost can cancel against finite differences only for identical source arrays actually converted and retained under the same cache policy.

## 3. Degree-dependent Newton work

Write q0=r(a0), C_j=n_j*v^(19-j), and ell_i=bitlength(v^i). The reviewed initializer starts D0=n19 and, at degree i=1,...,19, writes the new top first, updates interior indices downward, then D0:

    new D_i=iF*old D_(i-1),
    new D_j=(q0+jF)*old D_j+jF*old D_(j-1), 1<=j<i,
    new D_0=q0*old D_0+C_(19-i).

The state is Delta^j J_i(0), for the actual partial polynomial J_i. The subsequent traversal updates upward, D_j<-D_j+D_(j+1). These opposite loop directions are required.

Before initialization, form19 coefficient prescales n_(19-i)*v^i, i=1,...,19. Each complex prescale is two products of a117-bit signed coefficient numerator by an ell_i-bit nonnegative power. Its result fits100+ell_i+17 signed bits, at most479. These are neither the narrow-factor Newton products nor free source coefficients. Geometry powers v^i can share across cells/heights of one conductor; coefficient prescales cannot share across different actual coefficient arrays or conductors.

At degree i there are i general products with factors q0+jF, j=0,...,i-1. Each factor has at most19 magnitude bits plus sign, under either guard. The wide operand depends on degree and order. Sufficient signed widths are

    W20(i-1,j)=100+ell_(i-1)+j+19,
    W10(i-1,j)=100+ell_(i-1)+j+25.

At degree19, the largest general-product input is480 or486 signed bits. Earlier degrees are smaller. The special initial coefficient itself has the sharper117-bit bound. These envelopes are safe even where ell_0=1 makes them loose.

The raw initialization products and sums fit degree-i capacities100+ell_i+i+19 for the20F guard, or100+ell_i+i+25 for10F. For the latter, the interior raw bound has an additional factor2, but j<=i-1, so its extra bit is already covered. This uses bounds on each unadded product, not cancellation after multiplication. General product costs must therefore be summed over all(i,j), rather than pricing190 maximum-width-by-maximum-width products.

There are also i small scales jF, j=1,...,i. Implement each by the set bits of j, with shifts by log2(F) plus the bit position. Across the initializer:

    general products = sum_i i =190,
    recurrence additions =190,
    binary small-scale additions =167,
    shifted operand occurrences =357.

Thus initialization has357 complex additions and357 shifted operand occurrences. A shifted operand is charged for construction/reference, sign and proof transport. Since each small scale combines multiples of the same signed coordinate, its partial sums are bounded by the full small product. A different addition chain needs a different schedule.

A full bucket therefore costs19 prescales,190 degree-dependent general products,357 initialization additions,357 shifts,19(L-1) advance additions and U final conversions. The addition total is19L+338. Each complex product/addition represents two coordinate integer operations. q0 and the18 successive factors q0+jF, exact cell endpoints and unit tests are additional geometry costs. They can share across heights only when their full identities match.

## 4. Final rounding and fixed-Q proof reuse

Let Q=v^19. At a consumed output, |P_100(h)|<(4/3)2^16<2^17, independent of the auxiliary guard. Thus the signed numerator I fits480 bits, Q has at most362 bits, and the rounded numerator m fits118 signed bits. Do not price every final division as if its input were the largest506-bit auxiliary state. At b100/g100 no residual dyadic factor remains in the divisor.

Generation must find m=nearest(I/Q), or obtain it from another sound producer. Checking can prove p=mQ, R=I-p and -Q<=2R<Q. The latter inequalities are equivalent to the signed nearest-round rule, including half ties. One product suffices; two separate products for(2m-1)Q and(2m+1)Q are unnecessary. Forming the residual can require a wider signed temporary than the final small residual, so its operands must be priced before cancellation.

The frozen fixed-Q table proposal changes only the proof of p=mQ. One checked radix256 table T[d]=Q*d can share across both coordinates, cells, bands and heights of the same conductor during a checked lifetime. A15-digit |m| and46-digit Q give a stated padded macro subtotal1723 versus3481 for its matched rectangular direct product; setup is24739 such macro events. Its product-only crossover is15 scalar uses. These are proposed ordinary-arithmetic lemma events, not opcodes, bytes or times. Its independent review is pending at this note's freeze.

The full table decision must price decomposition, closed numeral terms, lookup/unification, sign, prefix proofs, storage, imports and rebuilds. The residual and comparisons remain. Native division to discover m remains. A table lifetime ending at a shard/theorem boundary requires reconstruction or checked global facts. The table does not remove the need to bind Q=(2c)^19. Known powers of two and shorter actual operands must be treated fairly on both sides.

Horner also has fixed multipliers: v per conductor and r per actual residue/band. Their possible reuse across19 stages/heights is under separate investigation. No comparison here grants a free table to finite differences while forbidding a cheaper reviewed method for Horner. A Lean numeral kernel may prefer direct multiplication; ordinary MM0 may prefer proved digit tables. The same mathematical inequalities apply, with separate backend prices and setup obligations.

## 5. Complete admission inequality

Choose objective t separately for native generation, proof production and proof checking, or specify a weighted sum. Include proof bytes and peak live storage as additional constraints. All prices below include exact terms/decoding and the chosen ordinary arithmetic certificate method; an abstract lemma application is not assigned a universal cost.

For a selected set of full cells B, let U_B,L_B be their unit and integer counts. Let N_t(B) be the explicit sum of19 prescales,190 degree-dependent products,357 additions and357 shifted operands from section3. Let A_t(B,n,j) price each actual advance addition at its proved width. Let R_t(B,a) price the complete final round, including quotient discovery for generation or its actual proof method for checking. Let C_t be coefficient conversion on the union of distinct source arrays, S_t geometry/table/cache setup per actual lifetime, and X_t all extra binding, traffic, coverage and output costs. Then

    New_t = C_t+S_t+X_t
          +sum_B [ N_t(B)
                   +sum_(n=0..L_B-2) sum_(j=0..18) A_t(B,n,j)
                   +sum_(required units a in B) R_t(B,a) ].

The old baseline is the sum of its actual19 stages at every replaced unit, including the special first product and original coefficient alignments, plus its own cache/traffic terms. Fallback work is identical only when both complete schedules really use the same original-center fallback. For the prospective grid-Horner comparator use19 product-round gates and19 exact additions per replaced unit, with its own conversion/geometry/cache terms. Do not count conversion twice or cancel it for source arrays one schedule does not use.

A saving is admitted only when the complete New_t is below the matched complete baseline in the chosen price model, and memory/proof-size/coverage constraints pass. A new-cost upper bound must be compared with an old-cost lower bound if the claim is to hold independently of actual implementation prices. Two unrelated upper bounds do not prove a saving.

For a single cell in a uniform declared model, let I_t denote its COMPLETE initialization, A_t its complex advance-add price, G_t its allocated extra setup/conversion/traffic cost, H_t one COMPLETE comparator stage, and R_t one COMPLETE final round. The screen becomes

    U*(19H_t-R_t) > I_t+19(L-1)A_t+G_t.

If19H_t<=R_t, this model cannot certify a win with nonnegative overhead. Otherwise the strict lower threshold is

    U > [I_t+19(L-1)A_t+G_t]/[19H_t-R_t].

This is a cost criterion, unlike phi>10B or phi>20B. In the degree-sensitive model use the preceding full sums. Cache setup can couple several cells, so per-cell allocations must sum to the actual global charge. U=0 produces no baseline saving. A metadata-only rejection can avoid initialization; any exploratory initialization actually performed remains charged.

No aggregate deduction follows from the existing occupancy totals. A selected20F or10F policy must produce a complete partition, price each admitted cell under its appropriate width bound, and account for all rejected/fallback units. The reviewed occupancy's all-numerator advances remain; skipping nonunits without a jump proof is invalid. Newton's190-product count does not turn phi>10B into a sufficient benefit test.

## 6. Reuse and remaining implementation work

Coefficient conversion is20 complex rounds, or40 coordinate rounds, per distinct original source array, with its actual input encoding, source/height/anchor/normalization/grid identity and cache traffic. Optional membership proof can avoid conversion but not source binding. The same converted array may serve several conductors. Prescales, however, depend on v; initial differences also depend on cell start and F. They change with height's coefficients. Geometry factors/unit masks share across heights. The final Q table shares by conductor alone, subject to checked cache lifetime.

Generation, proof generation and checking can select different integer algorithms. Ordinary Lean/MM0 still need generic correctness lemmas for the coefficient adapter, Newton invariant, exact advances, signed rounding and schedule coverage, followed by concrete arithmetic evidence. Hashes alone prove none of these equalities. No custom arithmetic acceptance rule or unproved analytic premise is introduced. The root's normalized-difference alternative E_j=D_j/(F^j*j!) is a separate future circuit; its different traversal costs are not credited here.

The next useful pricing evidence is a matched complete gate design for b100 Horner, wide final-round proof and degree-sensitive Newton products on the same backend. The fixed-Q and narrow fixed-factor tables must be compared with their setup/term/cache costs. Until then the joined formulas specify a checkable admission policy, not a runtime or proof-cost winner.

## Evidence and frozen inputs

Owned script `joined_residue_width_comparison_20261111.py`, SHA `EDE4919DEE7A2D200E1C8803E90A695CA8857ADC51ED40AC42BF89AE81261A06`, and receipt `joined_residue_width_comparison_20261111.json`, SHA `581485B43E48F22C3DFAA2C7DFAE11CBC35CC758D2C5037366A1F3876404B5F2`, contain852 exact checks. They reconstruct degree-specific capacities/counts, error fractions, full-cell addition identities and the conditional fixed-Q macro subtotal. They do not import author code, instantiate actual coefficient arrays or run a new occupancy scan. All19 degree rows and all12 input hashes are retained in the receipt.

Input paths below are relative to `work/qrh-campaign/agents`. Section references are to the complete pinned documents read for this composition.

|Input and consumed scope|SHA-256|
|---|---|
|integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md, section8 full-state circuit|691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025|
|audit/REVIEW_EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_2026-11-11.md|A21A7B16BFF97898E0D6C8F1FFBB3D39C231C1553BE2B9CF77B8770F5819261D|
|prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md, sections2–5|55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC|
|moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234|
|major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md, sections2–7|AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054|
|independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md|0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711|
|integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md|9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4|
|integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md, mandatory mixed scope|B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815|
|audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md|793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D|
|zero-sum/RESIDUE_FINITE_DIFFERENCE_WIDTH_BREAK_EVEN_2026-11-11.md, sections2–5|1A6976CAEC079B5745145780D344CAF63E4D3CC764440669DC103DFBEF6F2A10|
|zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md, conditional proposal sections1–5|E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF|
|prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md, count semantics only|99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1|
