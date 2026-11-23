# Normalized Bluestein prices from the saved structural manifest

2026-11-11. Bounded saved-metadata fold, pending independent structural/cost review. The underlying normalization and context proofs have passed independent paper review. No method, precision, complete proof cost or production implementation is adopted here.

Against the reviewed original-circuit LOCAL-width comparator, rounding the scaled cached kernel onto grid p and omitting the runtime inverse divisions reduces the declared three-product arithmetic core by between 3.05% and 3.06% at p112, 2.85% and 2.86% at p134, and 2.41% and 2.42% at p152. These are comparisons within one padded ordinary-arithmetic schedule, not elapsed-time or end-to-end savings. New scaled-cache rounding, cache sums and their proof/storage costs remain separate.

## 1. Exact inputs and execution boundary

The new mathematical producer is `independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md`, SHA256 `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9`, with context supplement `412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7`. Their combined independent review is `integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md`, `09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA`.

The original-circuit comparator is `work/qrh-blueprint/LOCAL_TRANSFORM_WIDTH_COSTS_2026-11-11.md`, `1A3DC2D8A7593ADD30DCBCE77FAAA3C93A902AC8FE2D98D73F3905DE4A13AF3B`; receipt `5D4C79F0958F69577D250B35F7FF5C81B7C25E4AC755C8CB3517D699F2891DA1`; independent review `major-constants/REVIEW_LOCAL_TRANSFORM_WIDTH_COSTS_2026-11-11.md`, `AB802176B2AA36DA1ACE341663B4DB0A97BB924112140F0241E80437B93D464F`. It supersedes the earlier global-width padding as this comparison's baseline.

Structural inputs are the saved integration manifest `A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`, events `06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B` and summary `503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0`. Paths other than the explicitly named blueprint files are relative to `work/qrh-campaign/agents`.

The preflight, accepted by the coordinator, limited work to these saved rows and DAG. It allowed no conductor-range generation, factoring, height calculation, plan selection, unit residue enumeration or upstream writer import. Context/classes were capped at one million and each exclusive output at64 MiB. The script obeyed these limits. It iterated the existing125400 conductor rows to recover their weighted contexts, using their supplied axes and20 band weights rather than recomputing their mathematical domain.

## 2. Exact reconstruction before replacement

For each saved conductor, operation multiplicities use the retained-output prefix times the full following-axis suffix. Norm factors use twice the FULL preceding-axis product. The script checks the saved phi/primitive products, all20 unit-band totals and the52560 top-context count. It then follows only the saved request-DAG child rows, preserving their supplied multiplicities and norm factors. This produces exactly220108 weighted contexts, of which26064 are Bluestein contexts.

No cheap-chirp arithmetic is regenerated. For a saved full Bluestein plan, subtracting two radix count vectors and the P point products/P divisions leaves twice its prechirp vector. The script verifies nonnegative even coordinates before dividing by two. A requested leaf's postchirp vector is then its saved total minus those two radix vectors, point/division counts and prechirp. This recovers the same selected output count without enumerating indices or evaluating roots.

The script reconstructs the complete old point, inverse, inverse-division and postchirp event histogram from those exact contexts. It requires dictionary equality with the corresponding frozen histogram, not merely equality of total G. The95962 event classes in all other phases are copied unchanged. Original local prices, every component and all20 band subtotals are then reproduced exactly at p112,134,152 for both three- and four-real-product choices.

This verification prevents recovering a new bound by subtracting a guessed bit count from an old rounded exponent. The exact n, P and incoming a are used before taking any new ceiling logarithm. The source labels, factor order, primitive restrictions, requested outputs, current heights and four auxiliary-prefix choices are unchanged.

## 3. Selected local bounds and stage indexing

The new circuit stores `Round_p(Khat/P)` and keeps point products/inverse stages on grid p. For n>=2, P=nextPowerOfTwo(2n-1), and incoming augmented bound aV, put

    Z_s=n(2n-1)/P+2.

The reviewed producer preserves the old C/D error contract at the same p, including the extra scaled-cache uncertainty. The semantic postchirp bound additionally requires the inherited global S_old*u<=1/2, hence C_old*u<=1/2. These hypotheses are not inferred from metadata.

The new phase keys are:

|Phase/object|Factor or capacity rule|
|---|---|
|Point-product data operand|(n+2)aV, unchanged from the original comparator|
|Scaled kernel coefficient|Norm strictly below1, magnitude capacity p|
|Inverse augmented input|Z_s*aV|
|Inverse stage j data input, one-based1<=j<=k|2^j*Z_s*aV|
|Inverse stage j additions, including their outputs|2^(j+1)*Z_s*aV|
|Postchirp key|2n*aV|
|Runtime inverse division|Removed|

The ROOT product key describes its data INPUT, not its rounded product output. In zero-based notation j0=j-1, the exact stage input bound `(2+u)^j0 Z_s*aV` is at most `2^j Z_s*aV`. The stage output is at most `2^(j+1)Z_s*aV`. The common-stage envelope in the context supplement is a valid looser choice for roots, but is not the rule selected here. Coefficient magnitude, raw products, presums and rounding are separately charged by the product template, so a root key need not also bound its output.

All new factors are computed as exact rationals before ceil(log2). Kernel coefficient exponent zero has a NEW explicit meaning: the stored coefficient norm is below1 on grid p. It is not a missing coefficient bound. Ordinary root coefficients retain exponent1. Every unchanged phase keeps its original key. The old proof's source uncertainty, output error and downstream sign obligations are unchanged, but computed centers differ and old sign successes do not transfer.

## 4. Projection results and arithmetic prices

The result has125279 event classes and133 price-width classes, versus138126 and400 originally. All root, kernel, addition, quarter-turn and negation counts match the original in every band and scenario. New runtime scale counts are zero. In particular **kernel products still have their old positive count**. The old identity G_kernel=D was an old-circuit counting invariant and is not reused after removing D.

At common V<=2^14 and grid p, the data magnitude capacity is p+14+ceil(log2 factor). The existing ordinary-PA template charges rectangular byte multiplication, product-width exact additions, and the complete two-coordinate dyadic-round witness. Three-product gates include their data presum and use exact cached coefficient sums. Signed/canonical/range/shift/encoding/binding costs remain named separate terms. The addition-price convention retains the same extra bit as the original comparator.

The main scenario gives:

|p|Original local three-product core|New three-product core|Core difference|New four-product core|
|---:|---:|---:|---:|---:|
|112|4902779373472954330|4752826652495743914|149952720977210416|6066519651827047594|
|134|6305051715366094514|6124737322160821530|180314393205272984|7881643777228454202|
|152|8010753159428325350|7817636116447099094|193117042981226256|10075331020377236374|

At p134 the alternative extra-prefix cases are:

|Extra nodes|Original local core|New core|Difference|
|---:|---:|---:|---:|
|167|6434074075305064674|6250018780057348826|184055295247715848|
|320|6552280189500648114|6364797600764945690|187482588735702424|
|640|6799508663635201714|6604857879369069850|194650784266131864|

The receipt retains all band subtotals, components, cheap-event counts and exact rational ratios. These four prefixes are alternatives, not additive campaigns or evidence that a particular auxiliary length suffices.

## 5. Setup and the complete decision inequality

The full-cache set is recovered by following saved full-plan child choices from the saved top axes. It contains the same6004 kernel lengths and337702368 kernel entries. Original kernel FFT work, roots/chirps and their certificates remain unchanged. No cache is inferred from a pruned numerical output.

A scaled kernel entry needs one complex dyadic round, with four coordinate-witness addition cores, plus its signed/range/enclosure and binding proofs. A three-product implementation also needs two exact sums of the NEW scaled centers. The old unscaled sums cannot be substituted. The per-entry numerator width for setup uses the existing local old-kernel exponent ceil(log2(2n+1)); the divisor exponent is log2 P. The new sums use coefficient capacity p. Setup counts are independent of the four runtime prefixes under the same declared cache design.

|p|Added scaled-cache round add cores|Old kernel-sum add cores|New kernel-sum add cores|Cold incremental add core|
|---:|---:|---:|---:|---:|
|112|47118457984|23393549376|20937546816|44662455424|
|134|54173640064|26349068992|23639165760|51463736832|
|152|60626552704|30147596736|27691594176|58170550144|

The four-product alternative has no exact-sum cache on either side, but retains the added scale setup. These prices assume one construction per checked cache key/lifetime. Rebuilding, precision-specific duplication, loading and storage can change them. If the old cache is already built, its sum construction is sunk; do not claim the cold subtraction as a refund.

For example the p134 main runtime difference separates into151592179696483912 product-core events and28722213508789072 addition-core events. Under common event prices alpha and beta, a complete cold-comparison improvement requires

    alpha*151592179696483912 + beta*28722213508789072
      > beta*51463736832 + Delta_other.

Delta_other is the new-minus-old price of all remaining setup/runtime proof, representation, memory and lifecycle work under the SAME backend model. It is not set to zero. Use a different price functional for generation, proof production and ordinary checking. This inequality is the decision rule; the unweighted percentages alone are not a runtime claim.

The comparison uses the stronger reviewed original LOCAL-width schedule. It does not subtract this successor from the older global-width upper bound, multiply unrelated percentage savings, or claim dominance over a separately optimized implementation.

## 6. Frozen outputs and review boundary

The own script `independent-feasibility/normalized_bluestein_structural_costs_20261111.py` has SHA256 `69F73DC72ACAE4646FD665B6B2895B7556EE9E5CA3F090C16E37AF02E54AB625`.

|Output|Bytes|SHA256|
|---|---:|---|
|`normalized_bluestein_events_20261111.json`|18684197|`721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2`|
|`normalized_bluestein_structural_costs_20261111.json`|89710|`F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3`|

The result has1936416 successful assertions including the final serialization cap; the receipt records1936415 before its own final write check. Both outputs were written exclusively and remain below64 MiB. The script imports only standard-library containers, exact rational arithmetic, hashing and JSON. It does not import or execute the earlier manifest generator or price writer.

The arithmetic proof and context supplement are independently reviewed. This successor's structural reconstruction, matched prices and setup projection are submitted for a separate review before use. Actual coefficients, roots, signs, complete error budgets, zero counts and final formalization remain outside this packet. No build, production scan or analytic evaluation was performed.
