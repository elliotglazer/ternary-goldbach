# Correction to the complex-product addition skeleton

This corrects only the three `*_with_runtime_add_skeleton` columns in the frozen `complex_three_product_models_20261111.json` and any interpretation of those columns in `EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md` (SHA256 83D8C2953A4AEE557786904C09CED8433972876AA0B6698EBA8BF2C3B5F39EF4). The original bytes are preserved. Independent reviewer `/root/independent_feasibility` identified that output additions were incorrectly priced at input width. These columns are withdrawn as operation schedules. Product-only counts, identities and error inequalities are unchanged.

For signed integer mantissas of absolute value below 2^p, radix 2^b, let A(n)=2n+1 remain only the unsigned addition-template proxy. Define n_s=ceil((p+1)/b), n_4=ceil((2p+1)/b), n_f=ceil((2p+2)/b), and n_g=ceil((2p+3)/b). A safe width-aware replacement is:

* four products: the unchanged product count plus 2 A(n_4);
* fixed-coefficient three products: unchanged product count plus A(n_s)+2 A(n_f), excluding its two cached setup additions;
* Gauss: unchanged product count plus 2 A(n_s)+A(n_4)+2 A(n_g).

The last bound permits absolute intermediate magnitudes below 5*2^(2p), then 6*2^(2p); it does not assume cancellation during the actual computation. The fixed form permits product magnitudes below 2*2^(2p) and output sums below 4*2^(2p). The bounds are deliberately conservative. Full signed comparison/subtraction, normalization, lookup, carrying and theorem instantiation remain additional costs; these proxies are not executed proof-event counts or timings.

Identical exact centers give identical final rounded bits only when output grid, rounding rule and raw capacity also agree. Otherwise the valid statement is identical exact arithmetic followed by the separately specified rounding-error allowance. No numerical computation, transform, build or edit to a frozen artifact was performed for this correction.
