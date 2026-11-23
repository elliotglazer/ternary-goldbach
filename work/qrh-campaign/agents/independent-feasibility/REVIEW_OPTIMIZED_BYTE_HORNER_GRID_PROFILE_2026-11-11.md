# Independent review of the bounded byte Horner grid optimization

2026-11-11. **PASS at conditional paper and exact-metadata scope; no correction requested.** The 15442 minimum and all74 cost/error profiles are correct within the stated monotone grid domain and product-only template. This is not a minimum of total proof work, a runtime result, or an implemented numerical certificate.

The frozen author is prime-estimates/OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md, SHA256 `A27CD526DB41C599F43912626827062EDC454F887A722782FF3953BE5BFFCE29`. I read its complete note, script and receipt, the root linear-grid proposal, its independent review, the b100 product-only circuit and the fixed-factor price comparison. I imported and executed no author program. Major_constants supplied a preliminary width/error check, which I reconstructed before accepting the final packet. Frozen inputs remain unchanged.

## Circuit, error and widths

The input is the original degree19 center polynomial at real h=r/v with |h|<=1/4, v=2c>0 and c<=265800. Every coefficient is converted directly from its original encoding to the selected degree grid. Conversion through an already rounded b100 array would require another error allowance; neither the argument nor the optimization grants that shortcut.

At stage j, the previous coordinate M denotes M/2^b_(j+1). Its exact scaled product is X/v, where X=rM2^(b_j-b_(j+1)). Consequently rM is the multiplication before the alignment shift. The supplied rounded integer L is accepted by -v<=2(X-Lv)<v. This is nearest rounding with ties toward positive infinity, including negative ties. The subsequent addition of the coefficient is exact on the same grid. The initial highest coefficient is copied, and the final grid is100: neither requires an extra accumulator round.

There are twenty coefficient-conversion errors and nineteen product-round errors. Expanding A_j=z'_j+hA_(j+1)+e_j assigns both degree-j errors the factor h^j. The rational complex-round norm bound sqrt(2)/2<3/4 proves the author's strict envelope

    E=(3/4) sum_(j=0)^19 (2 if j<19 else1) 2^(100-b_j-2j).

This holds without independent-error assumptions and on the closed displacement interval. At h=0, the degree-zero terms still justify strictness. With W=2^38 times the bracket, E<8/3 is exactly 9W<32*2^38. Every exponent in the integer weight construction is nonnegative in the stated search domain. The original analytic/source errors remain separate, and the inherited absolute factor633 permits the old whole-band1688u cap for mixtures. No identical-output or actual-sign claim follows.

For all b>=70, each new conversion and round has norm below1. The quantified original coefficient margin below40665 therefore yields converted norm below C=2^16. The invariant |A|<4(C+1)/3 follows by induction from the highest coefficient. This bound is below2^17, and its quarter plus1 is below2^15. Thus the nearest product numerator has magnitude below2^(b_j+15), even at negative ties. The highest input numerator uses b19+16 magnitude bits; only later inputs require b_(j+1)+17. This first-input distinction is correctly priced.

Multiplying by |r|<2^18, then aligning, bounds X by2^(b_j+35). Multiplying L by v<2^20 gives the same bound. Their raw difference and doubled difference require the additional guard bits recorded by the author; they cannot be narrowed merely because the accepted residual is small. The signed capacities b_j+36, b_j+37 and b_j+38 for these stages are sufficient. Coefficient additions and shifts remain separately charged. These are validated-input capacities, not a bound on arbitrary received integers or on finer original source encodings.

## Independent optimization reconstruction

For the declared rectangular template, the narrow factor occupies three outer bytes. M(n,3)=15n+7 applies to each of the two coordinate products at a stage. Summing the stage widths gives Cost=30D+532. The constant is76 products times7; the special highest-input term is ceil((b19+16)/8). All compared profiles use this same improved bound and orientation.

The author's forward state compression is complete within b0=100 and 100>=b1>=...>=b19>=70. Two prefixes with the same last grid and digit cost have precisely the same admissible continuations. Keeping the smaller accumulated W cannot discard a feasible or better-reserve continuation. Prefix rejection at the strict budget boundary is safe because every remaining weight is positive. Ties affect the chosen realizing vector, not the frontier. This argument proves the bounded search, not optimality among nonmonotone profiles, other grids, other rounding schedules or other multiplication proofs.

I independently implemented a backward suffix dynamic program. It starts at degree19, adds degrees18 down to1, and finally attaches the fixed degree-zero term. It retains minimum integer weight for each suffix-first-grid and digit-cost pair and uses no prefix error pruning. The only cost truncation is the uniform profile's total570 digits: uniform100 minimizes every error term in this domain, so any more expensive profile is dominated. The backward reconstruction agrees with every one of the author's74 frontier weights at costs497 through570. I separately verified each saved realizing vector, every stage width and product subtotal, strict rational error, reserve and reserve-choice row. The author's forward transition count is a property of its inspected implementation, not an independently timed performance measure.

The results are:

|Profile|Product events|Error envelope in units u|
|---|---:|---:|
|Bounded minimum|15442|5253/2048|
|Earlier linear profile, consistently repriced|16252|5505015/2097152|
|Uniform100, consistently repriced|17632|less than2|

The minimum reserve is625/6144, exceeding the linear profile's262171/6291456. The reported reserve choices agree with the full reconstructed frontier; no profile achieves a reserve of1. The optimized grid has seven nonzero shifts totaling29 bits, maximum8, while the linear grid has eighteen totaling19 and uniform100 has none. Fewer product events therefore do not establish lower full cost.

## Evidence and limitations

Owned checker: independent-feasibility/review_optimized_horner_grids_20261111.py, SHA256 `D02E261F122CB9BB5BBED95899DFEB96B5E0450C33F19ED244D228156945FDAE`.

Owned receipt: same stem JSON, SHA256 `A3A8CC0BD0993775E5C4B1B913EA3109699ACABFB84F3CDBA9805F2013F61C27`. It passes4802 exact checks and retains all seven input pins, backward layer sizes and the complete minimum-weight frontier. The author script/receipt pins are respectively `CB760828296AB00D2469B06B53FEE3BE2980B815186CED384D36DF94BD225AA8` and `9BA037D7AAFB7A0F053C109ABD9751112B586805236A14D9467EFD29B32871CE`.

All direct coefficient conversions, original input widths, exact alignment, signed wrappers, additions, residual/comparison proofs, quotient production, grid-specific cache lifetimes, source bindings, numeral terms and library/proof setup remain outside the optimized subtotal. They must be priced before adoption. A PA multiplication macro is not a native instruction or a Lean reduction count. The result gives a better conditional comparator and a reserve frontier; it supplies no coefficients, signs, spectral evidence, implementation validation or runtime forecast.
