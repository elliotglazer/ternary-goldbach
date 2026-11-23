# Matched costs for normalized differences and two Horner grids

2026-11-11. Conditional composition of frozen mathematical inputs. Both Horner papers have independent reviews; the normalized-difference paper's separate independent review remains an acceptance gate at this freeze. Research arithmetic only. No coefficient, analytic, prime, zero or transform values, builds, declarations or source changes. No operation-ledger saving or runtime ranking is asserted.

The comparison must charge both the arithmetic numerator and the quotient witness in Horner, and every shifted advance in normalized finite differences. The smaller normalized state does not eliminate final division. Degree-dependent Horner keeps nineteen products and rounds, but some products cross a byte boundary. Neither change has a cost determined by its number of stored bits alone.

## 1. Same outputs and different coefficient objects

Fix a height, conductor c, fine grid F=2Dout and ties-down anchor k. Write v=2c, r=Fa-kc, h=r/v, with -1/4<h<=1/4. All methods consume the same original degree19 coefficient object and its source uncertainty. They must export the same required units in each cell. This does not require identical rounded output centers.

Uniform grid-Horner and the normalized-difference option both use the optional new b100 coefficient array. The direct conversion is twenty complex rounds per distinct source object, plus decoding, witnesses and cache access. Its numerical center change is less than(4/3)2^-100 per in-cell residue. This conversion can share between those two methods only when the exact input array, height, anchor, normalization, rounding rule and retained cache object match.

The degree-grid proposal instead rounds ORIGINAL coefficients directly to b_0=b_1=100 and b_j=100-j for2<=j<=19. It is a different array. Its conversion cannot be charged as a read of the b100 array without a new double-rounding theorem and error allocation. A mixed implementation needing both arrays either pays both conversions or proves another valid common producer. Equal counts of twenty conversions do not mean equal costs for their actual input widths and witnesses.

All three source contracts preserve the old(8/3)u per-residue evaluation allowance, u=2^-100. Uniform grid-Horner uses coefficient error<4u/3 and product-round error<4u/3. The degree grid uses a combined bound<21u/8. The b100 exact-difference option uses coefficient error<4u/3 plus final round<u. Mixed character sums retain the old1688u cap by subset weights, not the all-difference1477u subtotal. The analytic coefficient/shift/target errors, finite-head corrections, conductor normalization and all spectral output obligations remain outside this arithmetic comparison.

## 2. Horner prices by stage

For a uniform stage, store A=M/2^100. Compute rM, discover a signed floor quotient q and remainder s with rM=qv+s, 0<=s<v, then round ties toward positive infinity and add the next coefficient exactly on grid100. The accepted sufficient capacities are118 signed bits for M,19 for r,136 for rM and qv,116 for q and rounded product,137 for a raw reconstruction temporary, and20 unsigned bits for v and s. The coefficient sum needs118 signed bits. The first stage obeys the same bounds because the initial coefficient was directly converted to grid100.

In this witness realization checking proves TWO coordinate products per coordinate-stage, rM and qv, plus exact reconstruction, remainder/tie inequalities, any increment and coefficient addition. Generation separately pays quotient discovery. A proved reflected checker could instead compute the quotient; price that actual algorithm rather than assigning it the witness subtotal automatically. There is no final output round. A source-level 'rounded multiplication' is not one proof opcode.

For the degree grid, at stage j from18 down to0 let p=b_(j+1), g=b_j and a_j=g-p. Compute X=rM*2^a_j, then nearest-round X/v to L and add the grid-g coefficient exactly. The shifts are a_0=0, a_1=2 and a_j=1 for2<=j<=18. Price the product rM at the INPUT precision p, and then its exact shift. Price the witness Lv at the OUTPUT precision g. The published sufficient magnitude bounds give p+17 bits for M and g+16 bits for L; the divisor remains at most20 bits. The shifted numerator fits g+36 signed bits. The witness product fits g+37, its raw subtraction g+38, and a doubled residual g+39. These are conservative capacities, not observed lengths.

Let M_t(w1,w2) price a complete signed integer product at those bounds for objective t. Let Qgen_t(n,d) price quotient discovery only when generation is being counted. Let W_t include reconstruction, signed/range/tie proofs and exact coefficient addition, and Sh_t the actual shifted-term operation and binding. For one coordinate-stage the degree schedule has the structural cost

    M_t(p+17,18) + Sh_t(rM,a_j)
      + Qgen_t(g+35,20)
      + M_t(g+16,20) + W_t(j).

The bit arguments in M_t are magnitude bounds; sign and exact term costs are included in its definition. Proof checking normally omits Qgen and receives a candidate quotient, but includes the full multiplication and order witnesses. Double this coordinate sum for complex data, sum all nineteen j, and add coefficient conversion and geometry costs. Uniform Horner has the same pattern with no alignment shifts and its sharper published quotient magnitude115; its two long multiplicands require at most117 and115 magnitude bits.

These displayed bit caps use unreduced r/v. A matched normalization-aware comparison must also offer both Horner methods the exact target reduction p=min(nu_2(v),nu_2(r)), with p=nu_2(v) for r=0. Replace r,v by r_p=r/2^p,v_p=v/2^p in every product and round. For degree alignment a_j there is a further free mathematical cancellation, though its proof/encoding still costs work: set e_j=min(a_j,nu_2(v_p)); then X/v_p equals r_p*M*2^(a_j-e_j)/(v_p/2^e_j). Price the smaller divisor and remaining shift, with exact identities. No divisibility of M is assumed. If actual-factor special cases or further witnessed M divisibility are used, charge their checked branches on both sides. Thus the complete cost formula uses actual reduced widths, not the unreduced caps when avoidable.

### A limited byte-template specialization

For comparison only, use the already proposed ordinary-PA rectangular product macro M(m,n)=5mn+2n+1, where n is the short-row count, and byte digits. Both narrow multipliers use three bytes. This is an unsigned product subtotal, excluding signs, ranges, terms, shifts, quotient discovery and all other gates.

Uniform Horner uses fifteen-byte long operands, so its nineteen complex stages cost19*4*M(15,3)=17632 macro events. With the degree proposal's published sufficient bounds, seven stages use thirteen-byte long operands, eight use fourteen, and four use fifteen for BOTH products. The corresponding subtotal is16312. The raw digit-cell counts are3420 and3156. The reduction1320 is a fact about this UNREDUCED padded product template only. It is not a complete proof-event count, a runtime ratio, or a saving established by comparing two upper bounds. It cannot stand in for the reduced Horner comparator against normalized differences. Sharper bounds, target cancellation, special factors, direct kernel numerals or other multiplication algorithms require a matched reprice.

The degree schedule still has nineteen complex rounds and additions. Its exact alignment adds eighteen nonzero complex shifts. Thus the fractional-precision sums1811 versus2000 and1730 versus1900 are not complete operation ratios. Machine-limb thresholds can yield a different change from byte thresholds.

## 3. Normalized differences and their order-dependent work

This section consumes the author's frozen power-of-two normalization proof, subject to its separate independent review. Its domain is the reviewed full-state c>10F circuit, with optional retention of the stronger20F guard. Let F=2^f, s=nu_2(c), and take t=min(f,s+1,s+nu_2(k)), using t=min(f,s+1) when k=0. Equivalently t=min(f,s) for odd k and min(f,s+1) for even k. Put

    v'=v/2^t, r'=r/2^t, F'=F/2^t=2^delta,
    I'(a)=sum_j n_j*r'(a)^j*v'^(19-j),
    P_100(h(a))=I'(a)/(2^100*v'^19).

The power-of-two division must be proved exact for every numerator in the cell, with the same anchor. It is not an arbitrary output-dependent gcd optimization. The source polynomial and h stay unchanged. The reduced numerator differs from the old integer numerator by its exact common factor, so all initialization and output identities must bind the reduced representation.

For lambda_j=j*delta+nu_2(j!), store E_j=Delta^j I'/2^lambda_j. Its ordinary divisibility theorem is required. At partial degree i the Newton recurrence is

    new E_i=oddpart(i)*old E_(i-1),
    new E_j=(r'_0+jF')*old E_j+oddpart(j)*old E_(j-1),
    new E_0=r'_0*old E_0+n_(19-i)*v'^i.

The top is written first, interiors downward. Traversal is upward:

    E_j <- E_j + 2^(delta+nu_2(j+1))*E_(j+1),  j=0,...,18.

Thus the190 general products remain, but their factors and wide operands shrink. There are still nineteen coefficient prescales by v'^i. Removing trailing zero bits from j does not change popcount(j), so the specified binary oddpart scales retain167 extra initialization additions and357 shifted-operand occurrences, with smaller shift distances. The190 recurrence additions remain. If oddpart(j)=1 is represented as a copy, that is a charged reference/copy, not a general multiplication. Other scale caching needs its own schedule.

Each of the L-1 numerator advances now uses nineteen shifted additions, including nonunits. If delta>=1 all nineteen shifts are nonzero. If delta=0 exactly nine are nonzero; the other ten still need the actual operand/reference and addition. A plain unnormalized-add price cannot be reused without showing how the shifted operands are represented and checked. The author's full-factorial competitor is outside this chosen power-only cost sum: it has190 initialization additions plus top copies, but40 additions and40 shifted operands per advance under its binary schedule. Its different counts and widths cannot silently inherit the167/357 power-only initialization terms.

Let ell_i=bitlength(v'^i). The intended per-order state capacity from the full10F proof is

    W(i,j)=100+ell_i+25+j-lambda_j

signed bits, with sharper special bounds where supplied. The general Newton product at degree i,j consumes W(i-1,j), not the maximum final state. Price its actual narrow factor r'_0+jF', the oddpart scale of the lower state, and the raw sum with the proved bounds. Initial coefficient and prescale capacities are117 and100+ell_i+17 signed bits respectively. For interior raw products/sums the author's bound is256*C*2^100*v'^i*(1/4+3j/40)*2^(j-lambda_j); its explicit top and order-zero bounds are separate. Convert those actual positive rational majorants into sufficient signed widths before assigning product/addition prices. A final stored-state bound alone does not bound every unadded intermediate. The global initialization exponent above2^100*v'^19 is24 for delta>=1 and29 for delta0, while the stored exponents are24 and28.

At a live full-degree state, the shifted higher operand and the lower one have combined magnitude at most three times the lower order's generic magnitude bound. Hence W(19,j)+2 is a sufficient shifted-add temporary capacity. Across orders, j-lambda_j has maximum0 if delta>=1 and4 if delta=0. This explains the different global widths but does not justify charging every order at that maximum. The scalar receipt will retain all twenty orders for every delta0 through14.

Order zero at a consumed in-cell unit has the sharper bound100+ell_19+18 signed bits because the actual polynomial is below2^17 there. This is the output numerator for final division. Do not charge its dividend at the worst auxiliary order's capacity. Nor may a small final residual justify narrow subtraction operands before their equality is established.

## 4. Final quotient and cache lifetime

With b=g100 the final round divides I' by Q'=v'^19. Its rounded output has at most117 magnitude bits, independent of the auxiliary normalization. Generation must discover that quotient. Checking proves its product with Q' and a signed residual range. All exact-cancellation, power, numerator and sign identities are inputs to this round.

At required unit outputs the author's target reduction has p=t+1 exactly when s=f and k is odd, and otherwise p=t. In the exceptional case I' and Q' are both divisible by2^19 at that target, so an optional exact output adapter divides both before rounding. The all-numerator state cannot use that reduction: intervening nonunits need not share it. Order normalization itself has lambda_0=0 and leaves I' unchanged. Bind the unit condition, exceptional geometry and exact output division before using its smaller dividend/divisor capacities. The p-version full-denominator cache distinguishes the output adapter as well as t. The SAME r/2^p,v/2^p target reduction must be available to both Horner comparators, as specified in section2.

The full denominator Q' depends on conductor AND cell cancellation t. A table keyed only by conductor is therefore wrong unless its construction explicitly covers those variants. Since v'=2^a*w with odd w=odd(c), the same product can instead prove m*w^19 and restore the factor2^(19a) by an exact shift. That odd-core table may share across all cells/heights of a conductor. Its power identity, shifting, dividend and residual bounds remain required. This factorization is also available to the unnormalized final-round comparator, so its product saving is not an exclusive benefit of storing normalized differences.

The fixed-Q table note gives a proposed ordinary proof implementation, not a native division shortcut. Its full setup, closed statements, terms, digit decomposition, lookup/unification, sign, storage and rebuilding costs belong in the comparison. A table surviving in one local proof may disappear at a shard/theorem boundary. A checked global theorem trades rebuilding for import/instantiation costs. Unchecked hashes do not substitute for arithmetic identities.

Horner's r and v also repeat across stages and heights for one geometry. The separate fixed-factor study currently finds no gain for its particular byte-table macro model, but this is not a prohibition on a cheaper validated Horner implementation. Use the best complete admitted comparator under the SAME backend accounting, and keep native generation independent of proof method.

## 5. Complete matched cell-set inequality

Fix the same cell set, its L_B consecutive numerator positions, U_B required unit outputs and complete fallback partition. A difference schedule advances all L_B-1 positions. Horner evaluates only the U_B units. The normalization proof does not replace the occupancy/coverage manifest or admit a new trimmed partition.

For objective t, write H_t(B,a) for the complete uniform or degree-grid Horner evaluation at a unit, including nineteen stage costs. Let N_t(B) be the full degree/order sum for difference prescales and Newton initialization; A_t(B,n,j) its shifted advance; R_t(B,a) the complete final quotient generation/check. Let C_H,C_D be the respective actual coefficient-conversion costs on unions of source objects, S_H,S_D all geometry/normalization/table setup per real cache lifetime, and X_H,X_D all remaining traffic, exact binding, coverage, storage/proof transport and output costs. Then compare

    Horner_t = C_H+S_H+X_H+sum_B sum_(unit a) H_t(B,a),

    Difference_t = C_D+S_D+X_D
      +sum_B [N_t(B)
              +sum_(n=0..L_B-2) sum_(j=0..18) A_t(B,n,j)
              +sum_(unit a) R_t(B,a)].

A concrete saving requires Difference_t<Horner_t with every term charged and memory/proof-size constraints satisfied. If prices are only bounds, compare a new-cost upper bound with an old-cost lower bound for an implementation-independent claim. Unrelated upper bounds do not establish a saving. Native generation, proof production and checking can have different winners.

The same b100 conversion may cancel against uniform Horner for exactly shared source-array lifetimes. It generally does not cancel against the distinct degree-grid arrays. Geometry powers now depend on c,t; prescales additionally depend on the height's coefficients; Newton factors depend on cell start and F'. No initialization sharing across heights follows from the same geometry. Odd-core final-product facts have a broader conductor-only key. Any reordered schedule pays its transpose, retention and repeated-source costs.

For a declared uniform cell model this reduces to

    U*(H_unit-R_unit) > N_init+(L-1)*A_advance+net_setup.

Here H_unit is a FULL nineteen-stage Horner evaluation and A_advance a FULL nineteen-order shifted update. Neither is one arithmetic operation. A nonpositive H_unit-R_unit cannot certify a gain against nonnegative overhead. U=0 has no baseline evaluation to save. Testing the complete metadata criterion before initialization can avoid rejected work; actually performed exploratory work remains charged. Product-only phi screens and normalized state widths alone do not establish this inequality.

## 6. Evidence status

Owned script `matched_normalized_residue_costs_20261111.py`, SHA `5BBE732A601C353D8F4A90807238206FC077EAE7473DC349D9BE37BB14FB068D`, and JSON `matched_normalized_residue_costs_20261111.json`, SHA `69441DBF361A7301AC96357471F0C93C8AC3CC92294C401BCAAD784FBF3C6CCA`, retain180 exact checks and nine full input hashes. They reconstruct all19 Horner stage byte rows, geometric error sums, twenty order offsets for delta0 through14, shift counts, oddpart popcounts and exact alignment/denominator cancellation. No author program is imported or executed, and no occupancy or coefficient data are generated.

The following frozen inputs were read. Paths in the table are relative to `work`, not to the current report's directory.

|Input|SHA-256|
|---|---|
|qrh-campaign/agents/audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md|84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C|
|qrh-campaign/agents/moebius/REVIEW_B100_PRODUCT_ONLY_HORNER_2026-11-11.md|1C1902623E32D7D565A3173FE852E4B4340A154EC71AE6F462196C7CAA65AD7A|
|qrh-blueprint/DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md|0249787E3EC22DAC609C28FE62CE847A8389CDB6D81ADD5A65D783A872A5DE12|
|qrh-campaign/agents/prime-estimates/REVIEW_DEGREE_DEPENDENT_HORNER_GRID_2026-11-11.md|D475972DB3EBDEC46D1AAB5DC5D4CBD7D7C157936E333ECE46737F45C34DC5E9|
|qrh-campaign/agents/independent-feasibility/RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md|EFB31BE5B3A556CE88A29B1E566ACB86E026F7C9E3E778F67F5B81453914F004|
|qrh-campaign/agents/integration/JOINED_RESIDUE_ARITHMETIC_WIDTH_COMPARISON_2026-11-11.md|73609552DF8A9847C2C0E65447F6CBE609C352643A8CBA3B5B50354E78311546|
|qrh-campaign/agents/audit/REVIEW_JOINED_RESIDUE_ARITHMETIC_WIDTH_COMPARISON_2026-11-11.md|8B9BC75166DEF4FE2F00A9AAC0528999528547A22FE410F1F32EB916A0B7EFFB|
|qrh-campaign/agents/prime-estimates/B100_HORNER_FIXED_FACTOR_PROOF_REUSE_2026-11-11.md|973FA8095EA9BC4768B1D50B70AB0218FE730508C46E7BC37F68B5E944381CE0|
|qrh-campaign/agents/zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md|E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF|

The normalized author's final EFB31BE5, not its unissued E0D3F041 draft, is the input. The correction changes its even-height metadata, which this comparison does not aggregate, and leaves the algebra/width interface unchanged. No earlier withdrawn class table is consumed.

This comparison does not independently review its own predecessor joined report, nor discharge the normalized-difference input's separate review merely from matching formulas. The proof-table choices remain optional methods with their own review and implementation conditions. The contribution is a matched width-sensitive cost interface with a bounded product-template specialization. Concrete ordinary-rule implementations, accepted records and end-to-end prices remain open. A proposed successor which rounds initial differences once and then advances dyadic states has a different error and quotient schedule; it is not priced or credited here. Further optimized Horner profiles require their own matched width/error bindings; the linear profile's published reference subtotal is not claimed minimal.
