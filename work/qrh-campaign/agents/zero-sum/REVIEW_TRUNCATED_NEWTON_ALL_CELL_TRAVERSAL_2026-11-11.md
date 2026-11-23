# Review of truncated Newton and all-cell traversal

2026-11-11. PASS at conditional finite-polynomial, error-interface and exact-count scope, without correction. This binds integration/TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md, SHA256 `5213690312A3A4C8BC262439844AF2BE227AF5D13635EEDADD3D720EEDAAAE3F`; script `1C1ACCED42EC255D5D880EC70364EB3C43D3118261122E5114607E9319F40441`; receipt `D8E01908E80DEF6EE7DCBA98DFD07F69F42168EFE273EEEACB06240F649A990E`.

I read the complete frozen packet and the consumed Newton, grid-adapter and rounded-state interfaces. The independent checks use formal coefficient variables and integer/rational controls only. No author program was executed or imported, and no actual polynomial, analytic function, transform, prime or zero values were evaluated. No build, source edit or frozen-file change occurred.

## The new domain is proved

The cell endpoints correctly express the half-open ties-down condition (2k-1)c<2Fa<=(2k+1)c, clipped to physical numerators1 through c-1. For each nonempty cell, all consecutive numerators belong to the same anchor. Consequently h lies in(-1/4,1/4]. Empty cells are outside the stated initialization contract. Nonunits are part of the traversal.

The source object retains all twenty coefficients of the degree19 polynomial, the delivered Dout normalization, its height and anchor, and an established coefficient grid. Final sourceD4096 still delivers Dout8192. Optional b100 requantization is the reviewed adapter, not a consequence of norm accuracy. Its twenty coefficient conversions cannot be reduced merely because fewer difference orders are retained.

Set m=min(20,L). The binomial-basis multiplication identity makes a new Newton order j depend only on old j and j-1. This proves that discarding orders>=m is exact at every partial degree. The new top must be assigned first when i<m; interior updates run downward, and order zero is updated last. The retained invariant is Delta^j J_i(0), not the difference of a polynomial truncated to degree m-1.

For L=1, the circuit keeps only order zero and performs all nineteen Horner degree steps. It still uses the entire degree19 source polynomial. No bound on F/c is required for this case.

## Raw partial-degree bounds and physical support

For a retained j, every integer support point0 through j is inside the cell because j<=m-1<=L-1. Thus the partial polynomial has magnitude below(4/3)C2^b v^i there. The alternating-binomial formula gives the difference bound(4/3)C2^(b+j)v^i.

The raw-product claim follows from actual endpoints, not from a final-state cancellation. For positive retained j, |q0+jF|<=v/4 and jF<v/2. The two interior products are therefore each bounded by(C/3)2^(b+j)v^i. Their raw sum fits the stored bound. The top uses only the second product; the zero-order insertion is bounded by(C/3+C)2^b v^i. Small-scale partial sums retain a common coordinate sign, so their absolute values do not exceed the completed scale. This justifies the reported per-order capacity b+bitlength(v^i)+18+j before any cancellation.

These inequalities use only in-cell support. They replace the previous c>10F or c>20F support argument; they do not merely remove its hypothesis from a cited theorem. At m1 there is no positive-order scale, so the argument never assumes a nonexistent second physical point.

At position n the live orders are j<=min(19,L-1-n). To reach n+1 the ascending updates use only old upper entries whose last support point remains inside the cell. Order19 is copied when still needed, since the twentieth difference is zero. Discarding higher orders after the update is sound. Every remaining state equals the actual difference at n+1, including the final point where only order zero remains.

The largest raw addition is safely bounded by one extra bit above the largest stored-state bound. This does not reuse a smaller higher-order encoding for a shifted or wider operand. In the selected range, b100 gives conservative exact live/Newton and addition capacities499/500 bits. Specific degrees and orders are smaller.

## Rounded initialization is consumed with a new truncation proof

The separate full-state mechanism is reviewed in moebius/REVIEW_ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md, SHA256 `B493A9965A8C9CCDBF138CD56FE322AEE7BC4DD75252AF538951D99709E5A40E`, binding authorFB0B0F9A. This review does not re-audit that entire packet or import its old guard-dependent widths. The successor supplies the missing truncated support and error argument.

Each of the m exact initial complex differences is rounded once to grid2^-p. The live error is the stated binomial combination of these m initial errors. When L<20, a live pair satisfies j+n<=L-1=m-1, so no omitted initial order can have a nonzero binomial coefficient. When L>=20, all polynomial orders were initialized. Thus the truncated recurrence preserves the exact error identity for every retained order, even with completely correlated errors.

With S(L)=sum_(k<m)binom(L-1,k) and p=102+bitlength(S(L)), the total propagated error is strictly below u/4. The in-cell coefficient conversion below4u/3 and final dyadic round below u give31u/12<8u/3 relative to the original delivered-center polynomial. The all-circuit amplification is6541u/4 under633. Mixed evaluators retain the old1688u allowance unless actual subset weights justify another bound. No sign success or equal rounded centers follows.

The new margin(4/3)C2^j+u/4<2^(17+j) justifies rounded capacities p+18+j. It is stronger than merely adding error to an unquantified strict bound. At L260, p197 gives234/235-bit live/raw traversal capacities. There are only m complex initial conversions, but they remain wide. The exact shifted numerator and witness product require p+bitlength(v^19)+18+j signed bits, before subtraction and doubling. The largest comparison still requires598 bits. Its small accepted residual cannot be used to excuse an unbounded preceding product.

The final dyadic conversion preserves the signed Euclidean and tie semantics. It is not a free unsigned bit extraction. The stated p+20 scratch bound uses the sharper order-zero magnitude, while actual quotient generation, witnesses and binding remain costs.

## Counts, edge cases and scope

The general-product and recurrence-addition count is sum_(i=1)^19 min(i,m)=m(39-m)/2. A small scale j appears20-j times for1<=j<m. The binary-addition and shifted-operand sums therefore have the stated ranges. Nineteen coefficient prescales and all source conversions remain, including m1.

The actual number of pruned advances is sum_(ell=1)^(L-1)min(19,ell). This equals L(L-1)/2 through L20 and19L-190 thereafter. The formulas agree at20; L1 has no advance. No zero-unit cell is omitted without a checked coverage rule. Required unit outputs, finite corrections, characters and spectral completeness obligations remain unchanged.

The cost comparison is conditional on complete prices for the chosen generation, proof-production or checking objective. Common initialization cancels only for the identical source polynomial, representation and cache lifetime. Wide initial rounds, factor setup, decoding, prescales, storage, proof transport and final dyadic conversions remain charged. A later-band cell can be admissible yet more expensive than Horner. There is no selected-family saving or automatic composition with the separately normalized-state circuit.

## Independent evidence

Owned checker `review_truncated_newton_all_cells_20261111.py`, SHA256 `A5E0E72682A309D6224080AB3BAC754C865DFF2EF2A03E4A6E44253A1FD39372`, and receipt `review_truncated_newton_all_cells_20261111.json`, SHA256 `2862DC783D6738235F7AE893B59555B044FB2320C9035608EFD578EC9EA223C4`, pass1948671 exact checks. They verify the eight dependency pins and all reported count/precision/width rows.

The checker compares2850 retained partial states against the direct alternating-binomial formula for finite differences, without using the author's Stirling recurrence. It also reconstructs the complete pruned formal initial-error matrix at every physical position for every L1 through260, comparing12599485 integer entries with the binomial expression. No source coefficient values enter those checks. Raw factors and the complete error sum are checked with exact fractions. The general support and induction arguments above establish the implication; finite controls do not replace them.

The accepted result is an all-cell exact initialization/traversal theorem and its explicitly charged rounded-state variant. Ordinary formal implementation, source-bound concrete arrays, exhaustive output manifests, arithmetic witnesses, cache costs and spectral acceptance remain open.
