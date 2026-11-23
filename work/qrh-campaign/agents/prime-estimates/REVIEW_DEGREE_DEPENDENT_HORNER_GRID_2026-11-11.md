# Independent review: degree-dependent Horner grids

2026-11-11. **PASS at conditional paper and exact-metadata scope; no correction requested.** The proposed direct coefficient conversion, product-only rounding and sufficient signed widths preserve the old evaluation allowance. This is a new circuit with a proved paper error budget, not an implemented evaluator, successful spectral certificate or adopted cost reduction.

## Frozen evidence

- Root proposal: work/qrh-blueprint/DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md, SHA256 `0249787E3EC22DAC609C28FE62CE847A8389CDB6D81ADD5A65D783A872A5DE12`.
- Root script: degree_horner_precision_checks_20261111.py, SHA256 `DD79FB92239C33508EA8C707A491DD4822DD8C5D977A1D67989F77451FBAB4EE`.
- Root receipt: same stem JSON, SHA256 `82C68F3E3445E4594076BD411EDAC6421A9276B9878C385CCAD90322B8C32A6A`.

I read all three files and the source coefficient-grid closure and mandatory mixed-evaluator clarification. I checked their three hashes and the independent grid-review hash recorded in the root receipt. No root script was imported or executed. No source/frozen file, Lean declaration or selected operation ledger was changed.

## Circuit and grid alignment

The profile b0=b1=100 and bj=100-j for j2..19 gives grids100,100,98,...,81. The new coefficients must be obtained directly from the original source-bound centers at these grids. Re-rounding an already converted uniform-b100 array could add an unbudgeted first conversion; the author correctly excludes that shortcut.

At stage j, the previous numerator M denotes A_(j+1)=M/2^b_(j+1). Scaling the exact product hA_(j+1), h=r/v, to grid bj gives X/v with X=rM2^(bj-b_(j+1)). The shifts are0 at j0,2 at j1, and1 at j2..18. In particular the unusual two-bit transition must not be replaced by a universal one-bit shift. After proving the nearest numerator L, both L and n_j denote values on the same grid bj, so their signed addition is exact. The final stage already has grid100 and needs no extra round.

The relation -v<=2(X-Lv)<v, with v>0, is equivalent to L=floor(X/v+1/2). It includes both negative and positive ties toward positive infinity and uses one exact signed witness product. It requires the actual X, divisor and output bindings, not only a congruence. Exact shifts, products, signed residuals, order witnesses and coefficient additions remain ordinary arithmetic work.

## Independent error reconstruction

Rounding both coordinates to grid2^-b has complex norm error at most sqrt(2)/2 times2^-b. Since1/2<9/16, this is strictly less than(3/4)2^-b. The rational3/4 factor is valid for every coefficient conversion and product round; no independence or cancellation is used.

Write A_j=z'_j+hA_(j+1)+e_j. Expanding the recurrence shows that stage-j product error has final weight h^j. The coefficient error in degree j has the same final weight. The highest coefficient j19 is copied once, without a separate initialization round. There are therefore twenty conversion contributions and nineteen product-round contributions, not two sets of twenty.

I independently accumulated the two weights by descending Horner recurrences, starting from the highest coefficient and zero arithmetic error. At |h|<=1/4 they give

    coefficient weight =917503/524288 =7/4-2^-19,
    arithmetic weight  =458751/262144 =7/4-2^-18.

Their combined error factor is

    (3/4)*(coefficient+arithmetic)=5505015/2097152
        <21/8<8/3.

The exact reserve is262171/6291456 times u, greater than u/24. Multiplication by the inherited absolute character/conductor factor633 gives the coarse cap13293u/8<1688u. Thus the old per-residue evaluation allocation is preserved. The proof holds uniformly on the closed displacement range, including h=0 and either allowed nearest-anchor tie endpoint.

The comparison is to the polynomial of the ORIGINAL delivered centers. Their analytic source/EM approximation, delivered numerical coefficient uncertainty, shift bias and target remainder are not replaced by the new conversion radius. Those existing errors remain separate. For mixed evaluators the correct common allowance is the old whole-band1688u unless actual subset weights justify a sharper expression. The author neither assigns1477u to an arbitrary mixture nor claims identical rounded centers or sign margins across algorithms.

## Raw widths, including the alignment shift

The source has a quantified coefficient margin below40665. Even the coarsest new grid81 adds less than one, preserving coefficient norm below2^16. The state induction C+B/4+round_error<2^17 starts from the highest converted coefficient and covers all stages. It is independent of the coefficient values.

The coordinate numerator of A_j therefore has magnitude below2^(bj+17), requiring bj+18 signed bits. At stage j the input has exponent b_(j+1); multiplying by |r|<2^18 and shifting by bj-b_(j+1) yields |X|<2^(bj+35). The exponent difference cancels the input-grid difference exactly. Hence the stated bj+36 signed raw-product capacity includes the two-bit j1 transition without hidden overflow.

The rounded product satisfies |hA_(j+1)|<2^15, and coordinate rounding adds at most half an output-grid unit. Thus |L|<2^(bj+16), a sufficient, deliberately loose magnitude bound. With v<2^20, Lv fits bj+37 signed bits. The unsigned sum of magnitude bounds for X and Lv is below2^(bj+37), so a raw residual fits bj+38 signed bits and its double fits bj+39. These capacities do not rely on the small accepted residual before its equality/range check. The exact sum L+n_j fits bj+18 signed bits. I independently checked every one of the nineteen saved stage rows against these bounds, also using a sharper recursive magnitude envelope as a separate consistency check.

These sufficient bounds differ from the sharper uniform-b100 floor-quotient comparator: they use a nearest-output witness and intentionally conservative product/residual capacities. They must not be mixed into that comparator's table/event counts without repricing the actual operands and proof schedule. The sums1811 versus2000 coefficient/accumulator fractional bits and1730 versus1900 stage fractional bits are correct, but are only representation metadata. They are not operation, memory, proof-byte or runtime savings.

## Binding and cost boundary

The new cache object must bind the full degree-indexed grid vector, direct original-center conversions, source height, fine anchor, normalization and tie rule. It is different from a uniform-grid FD or Horner cache. Sharing is justified only for the same exact source object and checked conversions; after eviction/reconstruction the work is not automatically free. Actual original encodings may be much larger than the final grids.

The circuit retains nineteen product rounds, nineteen exact complex additions and twenty complex coefficient conversions per distinct converted array. It also retains all unit outputs and the original family/height requirements. There is no new need for a consecutive numerator run or an FD conductor guard, but neither is any FD occupancy screen discharged by this proposal. Generic soundness proofs, concrete records, ordinary kernel/PA acceptance and matched complete cost comparisons remain outstanding.

## Reviewer evidence

The separate review script passed148 exact pin, descending-recurrence, magnitude and width checks. It constructs only scalar envelopes and metadata; it evaluates no actual coefficient polynomial, analytic function, prime or spectral datum and runs no build.

Reviewer script: review_degree_horner_grid_20261111.py, SHA256 `92FFE18A3276DFF3B32BCC3D226FA0A460C709679B9F239D7A19878582A9D5B6`.

Reviewer receipt: same stem JSON, SHA256 `13B34C346BFC2D5648897B724F34FB41C0CBC27439F3E147370EED724E696C65`.

The six exact input pins are retained in that receipt. The accepted result is the conditional error/width theorem and its source-compatible binding contract. No cost adoption, runtime ratio, actual sign or complete certificate is inferred.
