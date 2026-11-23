# Review of the P20 Hurwitz contraction tradeoff

2026-11-11. PASS for the isolated analytic remainder, nominal metadata and conditional cost comparison. No mathematical correction is required. The common-stage-price qualification below must accompany the crossover. No seed values, sign precision, zero completeness or runtime saving have been established.

Author: `zero-sum/R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md`, SHA256 `3151FEBCBE953FA458CBFE437222B810468B2E4F173C723F159F67285601D853`. Its script and receipt hashes are respectively `9EF1BC728B42B9E11E109AEAB6D742BFCD413F0E78FA6C06BD2E377AE40EB891` and `F7D5E9CC9AE271B5DA2FC60A33CE8DFC23C9EED5F05999B442C20182573A8323`. All three match the inspected files. Earlier artifacts remain unchanged.

## Analytic identity and domain

I checked the retained primary Platt paper, section 4.1 and Lemma 4.2. It supports the shared Hurwitz lattice and continued Taylor identity; it does not prescribe this P20/grid choice. The local PDF hash is `8FD109AA21345BC3FEAC4FDE2FAA7DFB51B4EF1FC9A430F643323612A39EF417`, and its text hash is `2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9`.

The author's explicit tail is f(alpha)=zeta(s,1+alpha), after removing alpha^(-s). That identity fixes its one-term-head convention independently of the paper's subscript notation. For s=1/2+it and alpha in[0,1], the tail argument is at least one and s never equals the pole at one. In particular the anchor alpha0=0 is permitted for the shifted tail; no singular head evaluation at zero is required.

The P-th derivative is (-1)^P(s)_P zeta(s+P,1+alpha). This identity follows first by absolute convergence, then analytic continuation; differentiating a conditionally convergent critical-line series is not justified. For P=20, the differentiated series is absolutely convergent. With |t|<=V, every factor |s+j| is at most V+j+1, so the product is below (V+P)^P. The shifted Hurwitz absolute sum is at most 1+1/(P-1/2)<2 by the decreasing integral bound. These estimates hold on the complete real segment joining alpha to its chosen nearest anchor.

Real Taylor's integral formula for the complex-valued function supplies the factor |d|^P/P!, not merely |d|^P. The exact nearest-anchor construction gives |d|<=1/(2D') even at ties and boundary cells. Hence the author's remainder 2[(V+P)/(2D')]^P/P! is valid. This is a real-alpha argument at fixed s; it proves no complex-s panel bound.

The actual character sum is unnormalized and carries c^(-s). Since |chi(a)|=1 on units and |c^(-s)|=c^(-1/2), its amplification is phi(c)/sqrt(c)<=sqrt(c)<633. This retains every unit residue and applies to primitive and imprimitive outputs alike. It does not divide by phi(c). The five doubled-grid ratios are strictly below5/16. I independently checked the exact uniform fraction and its strict bound below2^-84, and therefore below the earlier2^-82 allocation. Both signs of t are covered.

## Arithmetic precision and seed reuse

The analytic estimate is independent of seed success. A coefficient ball still needs an actual proof of its continued Hurwitz value, rising-factorial prefactor, elementary leaves, finite correction and remainder. The new grid contains old anchors exactly at its even indices, so only sufficiently accurate old balls for orders0 through19 can be reused. No interpolation of old seeds proves a new odd-indexed anchor.

For exact d, induction down the 19 Horner steps gives the author's sum |d|^k eta_k plus 2u times the geometric sum through degree18. The last coefficient is an input, not an additional multiply. With |d|<=1/2048, the relaxed character-summed bounds1266 eta+2532u are valid. These are separate from the analytic tail, head and conductor scaling, later transform error and interpolation.

If d is rounded, the polynomial derivative on the joining segment gives the additional xi*sum k M_k a*^(k-1) term. The coefficient bound must match the polynomial whose displacement error is estimated, and the Horner propagation must use |d_hat|<=a*. Exact rational d instead requires its actual denominator arithmetic. Neither choice makes the coefficient proofs or argument error free.

Thus2^-84 is an isolated truncation allowance, not the full radius of an L-value or a guaranteed strict sign. Requests below the fixed truncation floor, unexpectedly small values, auxiliary heights or changed complex domains require further parameters and proof work. None is supplied by the current nominal substitution.

## Independent metadata and cost result

My own script uses an Euler-totient sieve and the exact retained height formulas to reconstruct the large-branch residue total, rather than accepting that number from the author receipt. It independently finds130500 conductors,103868439142446 residue-height inputs and127989 shared heights. It then partitions the exact grid indices at the five band boundaries, recovering6401,6400,12800,38400,63988 heights. The last coarse index is127988, still below height10000. This includes the ceil-grid endpoint and does not substitute the separate actual-height cohort table.

All author row fields and aggregate arithmetic agree. The seed counts are17223585528 versus28703416100, a net increase of11479830572. The literal Horner count falls from23 to19 stages per residue, saving415473756569784 real-times-complex products and the same number of complex additions. That is830947513139568 real-coordinate products under the stated two-real-product multiplication. These are slots and operations, not seed-evaluation or proof-byte counts.

The exact crossover103868439142446/2869957643 is correct in the uniform seed/stage cost model. More generally the necessary comparison is

    C_seed20-C_seed24 < C_contraction24-C_contraction20.

Writing its right side as4*N_res*c_stage assumes a common charged cost per stage at the selected precision and representation. The new anchors and degrees need not have identical actual operand widths or seed costs. A valid upper-cost design can use one common stage width; measured prices cannot be transferred without checking that assumption. Sharing rising-factorial prefactors, retained even anchors, and indexing metadata is legitimate but must be counted once at its actual scope. Sunk old-generation costs are a different comparison from producing either design afresh.

No conductor, character output or coarse time has been pruned by this substitution. It remains conditional on the R138000 family and leaves its analytic adoption, auxiliary ranges, source production and complete spectral proof to separate work.

## Owned verification artifacts

`review_r138000_p20_alpha_20261111.py` SHA256 `F5306E20F2CE0342B02A7910D90993EB2731669F03B2A20AE6CA3E8AADFF6A8C`.

`review_r138000_p20_alpha_20261111.json` SHA256 `4E4AC80243460D899DF5604A7B401B67E693B44B9605FA88EEF446AD0CC12BD9`.

The single integer/rational metadata run passed46 grouped checks and imported no producer code. It evaluated no Hurwitz or other analytic functions, roots, transforms, primes or zeros, and ran no build. All pinned source and receipt bytes were preserved.
