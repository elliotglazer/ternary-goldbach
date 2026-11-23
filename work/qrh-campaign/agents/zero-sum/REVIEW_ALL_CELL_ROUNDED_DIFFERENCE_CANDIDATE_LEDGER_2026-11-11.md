# Review of the all-cell candidate operation ledger

2026-11-11. PASS at saved-metadata and conditional cost-interface scope, without correction. This binds integration/ALL_CELL_ROUNDED_DIFFERENCE_CANDIDATE_LEDGER_2026-11-11.md, SHA256 `3560E8441035DEE44E983B6995F473BF51B0B54E40FD79196956D294696AD839`, script `66C0784585FF8311E31880F5475529C7EC1FA99BC4D5E6CAFDF49C11589EE1BF`, and receipt `ED3000A823FE5E0C522D557B68A9E7BDCC2AC22F2890DBCD23AB6C5E0B8FD717`.

I read the complete note and script, the saved occupancy contract and the consumed all-cell theorem. The independent checker reads only frozen histograms and receipts. It does not execute or import the author program, enumerate conductors or units, or compute any polynomial, prime, analytic function, transform or zero values. No build or frozen-file change occurred.

## Histogram meaning and coverage

The source histogram is already weighted by the exact clipped height multiplicity for each conductor, band and scenario. Folding a per-length circuit into it requires exactly one multiplication by the saved bucket-height count. No additional height factor is applied.

The four alternatives0,167,320,640 remain separate schedules. Each has five bands, each with odd and even cohorts. The fold sums those cohorts once and those bands once. It preserves the delivered grids and the closed height-index endpoints from the source. Final sourceD4096 does not replace delivered Dout8192 or fine denominator16384.

Length-zero entries are empty endpoint slots and receive no initialization, precision or output. Their counts remain diagnostic. Positive-length cells remain charged even when they contain no units; the source does not supply enough information to remove them. The independent check reconstructed each cohort's nonempty count, all-numerator visits, original advance count and nonunit count from the histogram. These match the saved occupancy totals.

Unit outputs are copied from the separately recorded source totals. They are not estimated by density or replaced by all-numerator visits. Original19U Horner stages and all final U dyadic conversions match for every scenario. No new unit scan or implicit unit-run schedule enters this result.

## Independent reconstruction of operation vectors

For each order j, I first formed T_j, the count of bucket-height instances with L>=j+1. I then reconstructed the degree/order circuit directly. At degree i, general products and recurrence additions occur at orders0 through i-1, each with multiplicity T_j. Small scales occur at orders1 through i. This gives the author's G(m)=m(39-m)/2 and the stated popcount sums without using its per-length aggregate implementation.

The m-1 new-top writes and the small-scale count are diagnostic categories. They are not added again to the binary implementation's additions and shifted operands. All quantities retain their types: a general initialization product multiplies a narrow real integer factor by a complex integer pair; a coefficient prescale uses a power of2c; a complex addition acts on two coordinates; a complex round requires two coordinate witnesses. None is silently identified with an old narrow rounded Horner stage or a general character-transform product.

I reconstructed each order's traversal count by counting its permitted live positions, which gives sum_L H(L)max(0,L-1-j). Summing over j0 through18 agrees with the per-length pruned advance formula. Nonunit positions remain included. L1 contributes no traversal, but still pays nineteen degree steps, its prescales and one initial complex round.

The exact number of initial complex rounds is sum_j T_j=sum_L H(L)min(20,L). This is distinct from the twenty conversions of original source coefficients per unique shared source array. The latter union cannot be inferred from the bucket histogram and is correctly kept as a separate charge. Nineteen coefficient prescales per nonempty bucket are retained.

For the main alternative I reproduced418829993692141 general initialization products,36731422115040 initial complex rounds,1698782723254662 pruned complex additions and59962061953248 final unit conversions. The complete initialization-plus-traversal addition count is2397218902870343. These are typed counts, not a proof that the candidate beats1139279177111712 old rational Horner stages. All other scenario totals and both displayed operation tables match as well.

## Precision and width interfaces

Every positive-length row uses m=min(20,L) and p=102+bitlength(sum_(k<m)binom(L-1,k)). I independently reconstructed the binomial sums by their multiplicative integer recurrence and checked every saved p, weighted conversion count and pruned-add count. The accepted all-cell theorem supplies the error budget; this ledger does not change it.

The saved histogram lacks a joint conductor/length distribution. The author therefore uses explicit odd/even conductor caps to bound bitlength((2c)^i), giving ell19<=343 and362. These are sufficient envelopes, not actual operands. The degree/order formulas retain the previous-degree input width for a general product, the separate prescale width, and the wide initial residual comparison before accepting its small remainder. The ledger uses the unreduced representation only. Power-of-two, factorial or Stirling improvements have not been imported.

The source also lacks unit-output counts by length or p. The final count U is exact, but its precision-price distribution is not. The report correctly allows an unresolved price or a conservative maximum across the cohort/band rows. Using p_max requires a nondecreasing width-price model; otherwise the maximum actual declared price over those rows is the stated fallback. It would be invalid to allocate units proportionally to histogram mass or label this upper price exact.

The recorded maximum widths and p correlations agree with the theorem. For example main band1 odd/even live maxima are214/234 bits and initial comparison maxima559/598 bits. Final band5 has length1, p103, live121 and initial comparison485 bits. Its zero traversal count does not remove the wide initial conversion or authorize a cost saving.

## Independent evidence and remaining obligations

Owned checker `review_all_cell_histogram_ledger_20261111.py`, SHA256 `1E4389A04088B491C695027C750ABE9C2F02326C10222351413EADEB4F26467E`, and receipt `review_all_cell_histogram_ledger_20261111.json`, SHA256 `F14D902F9CD234ED6F4B40628E370B3D773C437D49D4C9FC42B0D72C066D9E29`, pass41375 exact checks. They verify the six dependency pins, all40 cohort folds,2373 length/precision rows, retained-order counts, traversal-order counts,20 band vectors, four totals and every numeric row in both displayed operation tables. No predecessor producer is run.

Source conversion, geometry, factor and power caches, binding, precision proofs, simultaneous wide/narrow storage, imports, traffic and rebuilding remain separately charged. Shared work cancels only when the same data and checked cache lifetime are reused. Generation, proof production and ordinary checking require separate prices; subtracting unrelated upper bounds would not establish a saving.

The result is an exact candidate ledger for the accepted all-cell circuit. It adopts no replacement set, narrower normalized representation, runtime estimate or spectral success. Actual source-bound arrays, arithmetic witnesses, complete unit coverage, sign and count closure, and a complete priced comparison remain required.
