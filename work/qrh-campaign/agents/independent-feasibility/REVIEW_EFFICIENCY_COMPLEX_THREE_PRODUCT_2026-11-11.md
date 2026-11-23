# Review of three-real-product complex gates

2026-11-11. Verdict: PASS for the original report together with the additive-width erratum pinned below. The three original additive-total columns are withdrawn. This review concerns symbolic identities, representation bounds, local absolute errors and a specified arithmetic cost model. It does not certify any numerical complex value or transform, and it does not establish a runtime advantage. No analytic evaluation, transform, Lean build or source edit was performed.

## Inputs and source check

The author report is `prime-estimates/EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md`, SHA256 `83D8C2953A4AEE557786904C09CED8433972876AA0B6698EBA8BF2C3B5F39EF4`. Its script and receipt are `complex_three_product_models_20261111.py`, SHA256 `79A8FB8E67B48633B2B7D5058A6477CCE3194184EDD2BEC94D4E9CABC28C80A9`, and the corresponding JSON, SHA256 `2749437A7EA7BED80692A04FA74EFC91F6864C0D7497A0562123948C2057BFCC`.

I read the full author report and script. A separate exact scalar check reconstructed all 25 product-cost/width rows and all three sufficient-allocation examples, with 128 grouped comparisons passing. It deliberately excluded the original optional additive totals because of the width defect below. The author script was not executed or imported. Tool record `db99c9` records this independent check.

I directly read `mul_re` and `mul_im` at lines 215 and 219 of the pinned Mathlib file, whose SHA256 is `C46DF05B286BD59A4725D02B9BCFA8AD9C50C7898C73FB116C11D60B758EEAE3`. The actual local path is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Basic/Complex/Basic.lean`. Both formulas follow definitionally from the complex multiplication instance. The compact-dyadic plan pin `85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8` and signed-rounding plan pin `EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B` also match. Their finite arithmetic lemmas remain plans, not a compiled checker.

## Exact center equality and representation

Expansion gives c(a+b)-b(c+d)=ac-bd and c(a+b)+a(d-c)=ad+bc. The d-pivot identities and the Gauss identity also expand to those same two coordinates. No unit-modulus or trigonometric assumption is used. The fixed-coefficient circuit uses one input pre-sum and two output sums, plus two cached coefficient pre-sums. General Gauss uses two input pre-sums and three output sums.

If a,b share one grid and c,d another, all exact products have the common product grid. With signed-magnitude bounds of p and q bits, their pre-sums have at most p+1 and q+1 bits. The ordinary raw products need p+q bits, each fixed-path product at most p+q+1, and the largest Gauss product at most p+q+2. Temporary subtraction capacity must also be provided. A conservative extra bit above the largest raw-product bound suffices for the displayed sequential schedules, even though algebraic cancellation gives a smaller final value.

Exact center equality plus the same deterministic final grid and tie rule implies identical final rounded coordinates. If the final rounding choices differ, only the stated absolute rounding bounds follow, not bit-for-bit output equality. Input and coefficient errors remain common to all circuits because they are measured against the same stored centers.

The common-grid premise is essential. Two one-bit mantissas with widely separated signed exponents can require an arbitrarily long exact pre-sum mantissa. No fixed p+1 cost claim follows from the separate canonical mantissa sizes alone. The compact-dyadic alternative must use a bounded rounded sum with a certified residual, or retain a different multiplication schedule. Even the four-product path still needs safe treatment of its final sums. None of these choices licenses a huge exponent-gap shift.

## Local errors and nonunit cached coefficients

The rectangle input-error formulas correctly retain both linear and cross-radius terms. They differ from norm-ball propagation, and the report does not interchange those carriers. Decomposing actual product minus implemented output through the exact product of stored centers separates input uncertainty from arithmetic error without independence assumptions.

For Gauss, the perturbed pre-product error is |U|e_V+|V|e_U+e_U*e_V. Adding the product and subtraction errors gives the stated imaginary bound. With exact pre-sums the errors are 3epsilon and 5epsilon; halving this arithmetic epsilon fits the old 3epsilon coordinate allowance. This is a statement about certified absolute error, not a universal one-bit floating-precision theorem.

For the fixed path, errors in cached C and D multiply |b| and |a|. The rounded input pre-sum error multiplies |c|. These are the correct stored-center factors; independent input/coefficient uncertainty is already handled by the rectangle formula. The allocation E/(8 max(1,B)), E/(8 max(1,A)) and E/4 for the three remaining contributions gives at most E. Exact pre-sums and cache identities recover the same 3epsilon allowance as the four-product reference.

Bluestein's cached kernel transform is fixed with respect to the current input, but is neither exact nor generally unit-sized. The triangle bound 2n-1 on its exact unnormalized transform is sound, since there are 2n-1 unit input chirps. Setup error must enlarge the center bound. Reusing its sums across inputs requires adequate residual bounds for the largest consumer magnitude. Treating it as a unit twiddle would invalidate the stated allocation. The report explicitly avoids that error.

## Product counts and the additive-width correction

The symbolic runtime mapping is correct: four products and two sums per ordinary complex multiplication, versus three products and three sums for the cached fixed path or five sums for Gauss. Cached pre-sums require two setup additions and storage. The distinct G_f and G_v counts describe runtime dependence, not exactness of coefficient enclosures. Quarter turns, negations and dyadic scalings are not multiplied by this replacement factor.

For the declared unsigned magnitude multiplication template M(n,m)=5nm+2 min(n,m)+1, all product-only table entries are correct. The larger operands have actually been charged. These entries do not price signed arithmetic, roundings, conversion, proof references or library construction.

I found a narrow defect in the optional JSON fields named `*_with_runtime_add_skeleton`. The original script prices every addition at A(ceil((p+1)/b)). That width can cover a pre-sum, but not output additions/subtractions of approximately 2p-bit raw products in the exact-final-only implementation. The defect is independent of the already stated missing signed-subtraction costs. Those original additive totals must not be consumed as a valid full-width unsigned schedule. The author agreed to preserve the frozen files and issue a separate width-aware correction. The main identities, error lemmas, operand-product bounds and published product-only table are unaffected.

## Decision scope

The three-product alternatives are credible candidates for a bounded common-grid exact-center implementation. They also have valid rounded-gate variants once their additional errors are budgeted. Neither a saved product nor a smaller template-event total proves a net runtime saving. The fixed circuit can lose to Gauss in product cost because it grows three operands; Gauss pays more additions. Coefficient setup, cache lifetime and intermediate widths determine the actual tradeoff.

A future implementation must state its grid/alignment bounds, signed-integer representation, output rounding rule and complete error propagation before replacing a frozen circuit. It must recheck full containment if immutable output boxes are part of acceptance. This local identity alone proves no sign or nonvanishing result, and it supplies no arbitrary-exponent same-precision guarantee.


## Reviewed correction

`prime-estimates/ERRATUM_COMPLEX_ADD_WIDTHS_2026-11-11.md`, SHA256 `AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362`, explicitly withdraws the old additive totals. I read and verified its replacement widths. Four-product outputs fit the conservative 2p+1-bit allowance; fixed-path temporary sums fit 2p+2; Gauss's sequential residuals are below 5*2^(2p) and then 6*2^(2p), both covered by 2p+3. Its pre-sum costs use p+1 separately. The corrected formulas are safe unsigned-width proxies and remain distinct from implemented signed proof costs.

With this correction, no further defect was found in the bounded algebra, local-error or symbolic-cost claims. Acceptance applies to the original plus erratum, not the original additive JSON fields alone. No frozen author artifact was changed by this review.
