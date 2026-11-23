# Review of rounded initial differences and exact traversal

2026-11-11. PASS for the conditional finite-polynomial circuit, error allocation and stated capacities, with no correction. Author `major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md` has SHA256 `FB0B0F9AF9C53150E14C1F5FFDE7A39E78DD8A6BFA09FE7769BF234EBB965E46`. This is not a cost adoption, implementation or numerical certificate.

I read the complete frozen note, script and receipt and the consumed Newton, guard and grid-adapter contracts. An independent formal coefficient-matrix checker and rational width checks passed. No actual source coefficients, polynomial samples, analytic functions, transforms, primes or zeros were evaluated. No build or frozen-file mutation occurred. The separately proposed sharper Stirling envelope is not used in this review.

## Exact initialization and rounded-state identity

The initializer must consume the same explicitly bound b100 polynomial P100 and fixed bucket anchor as the grid adapter. It computes exact forward differences of f(t)=P100((q0+Ft)/(2c)); these are not derivatives or differences of the analytic function. The accepted Newton invariant supplies numerators I_j with denominator2^100(2c)^19, including its prescales and raw-product bounds. Rounding an approximate initializer or changing the anchor at auxiliary points would not satisfy this interface.

The physical bucket is nonempty and contains L<=260 consecutive integer numerators. All nonunits are traversed. Under c>10F or the stronger c>20F, the proved polynomial-only support bounds apply at every physical point and the extra19 supporting offsets, even outside the source cell. Analytic source accuracy is consumed only at actual in-cell unit outputs.

Each of the20 exact complex differences is rounded once, coordinatewise, to grid2^-p. This gives independent named error terms e_j in the algebraic sense, with norm below2^-p; no probabilistic independence is assumed. Ascending updates j=0,...,18 read the old upper entry and implement the same upper-triangular Pascal operator as exact differences. Order19 stays fixed. Hence every live order satisfies

    E_j(n)=sum_(k=0)^(19-j) binom(n,k)e_(j+k).

This follows by induction from Pascal's identity and holds with vanishing coefficients when k>n. My owned checker reconstructs the entire20 by20 formal matrix for every n=0,...,259 and compares each entry with this formula. It does not merely test the row sum or output order zero.

For n<=L-1, every row sum is at most S(L)=sum_(k<=min(19,L-1)) binom(L-1,k). Since p=102+bitlength(S(L)) and S(L)>0, S(L)<2^(p-102). Thus every live-order error is strictly below2^-102=u/4. This includes L=1, when there is no traversal and p=103. The final grid100 output round must not be fed back into the state.

## Complete source error

The three newly charged terms relative to the original polynomial are coefficient conversion below4u/3, propagated initial rounding below u/4, and final dyadic output rounding below u. Their sum is31u/12<8u/3. Source/EM, original numerical-coefficient, analytic-shift and target-tail errors remain separate. The polynomial-only supporting values are never asserted to approximate the analytic function.

With the inherited actual character/conductor norm amplification633, the all-circuit evaluation term is below6541u/4=1635.25u. This leaves211u/4 under the old1688u cap. A mixture with other accepted evaluators retains1688u unless its actual subset weights justify a stronger bound. No equality of output centers or strict signs between evaluators follows from these absolute-error comparisons.

The binding and error proof use the reviewed b100 adapter, including its explicit coefficient-magnitude slack below C=2^16. Norm accuracy alone does not establish a common grid. Different heights, anchors, conductors, lengths and precisions remain distinct state objects unless an exact identity permits reuse.

## Live and raw widths

The author supplies the required quantitative margin. The exact geometric sums satisfy G10=sum_(i=0)^19(6/5)^i<192 and G20=sum_(i=0)^19(3/4)^i<4-1/512. Consequently exact difference norms are below C2^j G_guard. Adding less than u/4 still leaves all rounded states below2^43 in the ten-guard domain and2^37 in the old-guard domain. A strict bound without a margin would not justify that step.

Stored signed capacities are therefore p+44 and p+38, respectively. A raw sum of two state operands has one additional bit before the next-state invariant is applied. During an ascending update the modified lower entries are at n+1 and unchanged upper entries remain at n; both refer to physical positions within the proved range. No update past the last numerator is required.

The exact maximum is S(260)=32305056352236018054956299912, with bitlength95 and p197. The largest live/addition capacities are241/242 signed bits in the ten-guard tier and235/236 in the old tier. The author table and all260 precision/width rows match independent calculations. These are conservative capacities, not hardware or proof-size forecasts.

## Wide initial witnesses and final dyadic conversion

Let V=(2c)^19. Rounding I_j/(2^100 V) onto grid p is equivalently rounding X_j/V, where X_j=I_j2^(p-100). With supplied rounded integer M_j, define R_j=X_j-M_jV. The inequality

    -V<=2R_j<V

is the exact nearest-grid witness with ties toward positive infinity. The left tie is included because X_j/V=M_j-1/2 rounds upward to M_j; the right tie is excluded. The rule handles negative values and zero. There are40 coordinate witnesses, one per real coordinate of the20 differences.

The raw products and subtraction must be bounded before relying on their accepted small residual. Since V<2^362, the shifted numerator and M_jV fit p+400 signed bits in the old guard and p+406 in the ten guard. Raw subtraction adds one bit and doubling adds another, giving p+402 or p+408 for the comparison. The exact initial Newton arithmetic itself retains its old500/506-bit bounds at b100. At p197 the new comparison can require605 signed bits. Narrow live traversal does not make these witnesses narrow.

At an exported unit, the final divisor is2^(p-100). A signed Euclidean split with nonnegative remainder and the same tie increment proves the round, and multiplication by that divisor is a shift. Its quotient/remainder semantics, comparisons, bit extraction, sign encoding and binding remain checked work. The stated p+40/p+46 scratch bounds are conservative for the final construction; they do not license free output conversion. Exact numerator scaling, denominator powers and any proposed factor cancellation need their own identities.

## Comparison scope

The exact wide initialization remains unchanged, followed by20 additional wide complex conversions per bucket,19(L-1) exact dyadic complex additions and U final dyadic conversions. This includes short and zero-unit buckets unless a new pruning theorem removes them. Nonunit advances are not skipped.

The author's replacement reserve against exact full-state FD is correctly

    U(C_W-C_D)+19(L-1)(C_A^wide-C_A^p)
      -20C_I-Delta_setup.

It compares the same polynomial and common exact initialization. Common costs cancel only if the actual source object and cache lifetime match. Precision selection, proof of the binomial bound, simultaneous wide/narrow storage, conversions and data movement belong in Delta_setup. Products, shifts and divisions are ordinary-rule proof costs rather than trusted opcodes. The earlier frontier receipt does not automatically count or adopt this alternative, and no claim that it beats the narrow Horner competitor is justified here.

## Exact evidence

The owned checker passed106317 exact checks, including all260 full formal20 by20 propagation matrices, every saved precision/width row, quantitative geometric slack, initial raw capacities and84 synthetic signed initialization-round witnesses. Its consumed author receipt matches the final frozen receipt. The author's10937 assertions were read but not executed. Seven predecessor pins and all three author artifacts were verified.

|Artifact under work/qrh-campaign/agents|SHA256|
|---|---|
|major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md|FB0B0F9AF9C53150E14C1F5FFDE7A39E78DD8A6BFA09FE7769BF234EBB965E46|
|major-constants/rounded_initial_differences_20261111.py|78481504C24A2DD6C19854D12EC04BEB52E86B5A4158CFD0A03A06FD6175D159|
|major-constants/rounded_initial_differences_20261111.json|51A09104F2F5C29FA84B5E39312984E4E0433764ED933A3F7BDA064830FDD6A2|
|moebius/review_rounded_initial_differences_20261111.py|FF12355C1B8E4DFCD0B91E2B04404134249D78434DABDDE449E1BE99045EE44D|
|moebius/review_rounded_initial_differences_20261111.json|96AF3C6679A6212D68B415C268749390FD5D33BE25693516C3D340BB27DE5529|

Acceptance is limited to the conditional circuit and its complete error/width interface. Concrete coefficient arrays, arithmetic witnesses, exhaustive output coverage, ordinary-kernel implementation and priced adoption remain open.
