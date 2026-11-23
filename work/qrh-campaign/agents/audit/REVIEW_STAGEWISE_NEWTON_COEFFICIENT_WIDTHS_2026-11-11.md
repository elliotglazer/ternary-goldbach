# Review of stagewise Newton coefficient widths

2026-11-11. PASS at conditional source, finite-polynomial and exact-envelope scope. No correction requested. These are sufficient bounds for actual stored-coefficient circuits under their pinned source contracts, not a completed numerical certificate, implemented checker, selected replacement set or cost winner. No actual coefficient array, function, transform, prime or zero was evaluated; no build or source edit occurred.

The reviewed author is major-constants/STAGEWISE_NEWTON_COEFFICIENT_WIDTHS_2026-11-11.md, SHA256 `61A6DD47B1F86391BA731DAB7A97D2408D54C710BBDF34EA95C36FFD9762F7A0`. Its script is `E34B2EAB9B5B0DA49A9F61D7AA47D6D1316E74A24071BD9726B72C3D0B4A50F0`, and receipt is `717D0A360AC84F0FE327F30C18B4821CF700054521B602FADCD6D49F44F0276C`. I read the complete author/script and the stored-degree, Newton, finite-Stirling, truncated all-cell and normalized-state interfaces. I independently reconstructed every envelope and width without importing the author program. Frozen inputs remain unchanged.

## Actual coefficients and partial-degree identity

The source distinction is correct. Z_k bounds the delivered centers relative to the actual finite translated coarse-coefficient vector, including numerical source and translation errors. It does not identify those centers with the true fine-anchor jets. Analytic shift and target remainders stay in the later actual-function comparison. The final-band postscale from source4096 to output8192 is retained by the stored-degree input.

The new c_k=Z_k+3*2^-100/4 requires direct coordinate-nearest conversion of the ORIGINAL delivered center. Its complex error follows from sqrt(2)/2<3/4. An arbitrary record with only complex error<2^-100 does not imply this sharper allowance. The author explicitly preserves that distinction. All twenty conversions and actual original encodings remain required even when a short cell keeps fewer than twenty differences.

At partial degree i the exact integer object satisfies

    J_i(t)/(2^100 v^i)
      = sum_(ell=0)^i z'_(19-i+ell) (h+s*t)^ell.

Thus stage i inserts coefficient19-i and multiplies the OLD degree i-1 polynomial. The highest coefficient n19 initializes degree zero. The large original degree-zero coefficient appears only at i19 in the order-zero insertion. It is not present in earlier partial polynomials, and every positive difference annihilates its constant contribution. This is the key source-faithful improvement over assigning the final coefficient maximum to every intermediate.

## Guarded and all-cell envelopes are different contracts

For guarded rows I independently used the finite binomial formula

    Delta_sigma^j x^ell at x=1/4
      = sum_(a=0)^j (-1)^(j-a) binom(j,a) (1/4+a*sigma)^ell.

Expanding the monomial shows this equals the author's nonnegative Stirling kernel. That kernel bounds arbitrary signs of h and s by the triangle inequality. Summing against the appropriate c_(19-i+ell) gives every G_(i,j). It is positive for the recorded j<=i, and zero monomials below the difference order contribute nothing. The guard10 and guard20 tables use sigma1/20 and1/40 respectively; the latter is usable only under its stronger domain. Full-state supporting polynomial points can leave the cell. No analytic estimate is asserted at those extra points.

The all-cell table first subtracts the polynomial terms of degree below j, whose jth difference is exactly zero. At all retained support points, the remaining polynomial has norm below sum_(ell=j)^i c_(19-i+ell)/4^ell. The alternating-binomial coefficients have absolute sum2^j, proving T_(i,j). This is exact algebraic annihilation followed by an absolute bound, not a numerical cancellation assumption.

All-cell use requires j<L and the reviewed retained-order circuit. Recording rows with j>=L for reusable metadata does not authorize them in a short cell. In particular L1 uses only order zero and imposes no global step-size bound. Neither the guarded domain nor a full-state order count is silently imported into that case.

## Raw products, prescales and insertion

Normalize every new-stage raw object by2^100 v^i. The old-state bound is for degree i-1. In a guarded interior, the two separate bounds are

    (1/4+j*sigma)G_(i-1,j),
    j*sigma G_(i-1,j-1).

Their sum controls the raw addition before any new-state invariant. The new top has only the second product. There is no fictitious old order-i entry. At order zero the product contributes E_(i-1,0)/4, and the coefficient insertion contributes c_(19-i). Their sum equals the new zero-order envelope. A coefficient prescale needs its own source input and v^i power/product proofs; the small old-state bound does not price that insertion for free.

For an admitted all-cell positive order, both h and h+j*s are in the same cell. Hence the general factor has magnitude at most1/4 and j*s<1/2. This proves the separate products T_(i-1,j)/4 and T_(i-1,j-1)/2, with only the latter for a new top. The raw-sum row remains distinct from the possibly smaller new stored-state row. This is sufficient even when the guarded step bound is unavailable.

The secondary binary scale has nonnegative scalar pieces applied to one coordinate with a fixed sign. Every partial sum has magnitude no larger than the complete scale. The quoted bound therefore covers those intermediate additions too. This argument does not apply indiscriminately to the general product or the sum of two oppositely signed terms; those already have their separately reconstructed absolute bounds.

## Signed capacities and normalized variants

Each envelope E bounds the actual norm strictly. Choosing q with E<=2^q and r_i=ceil(log2(v^i)) therefore proves integer magnitude<2^(100+r_i+q). Adding a sign bit gives101+r_i+q. The receipt computes r_i by exact integer bit length, including r0=0; it performs no logarithm evaluation. For its maximum-domain examples v<=531600, the exact power identity is independently checked through that integer expression.

I reproduced the stage peaks53/44 at i0,146/138 at i4,235/230 at i8,323/320 at i12,408/406 at i16,448/447 at i18 and476/476 at i19 for the first-four/final classes. Stored and raw peaks happen to agree at these stages, but the individual rows differ. They cannot be collapsed into one price. The476-bit completed peak is a capacity result, not a ratio of proof work. Earlier operands and factor orientation are often more important for pricing.

For the separately admitted power-of-two normalization, the same h,s apply after common geometry reduction, but the degree scale is v'^i. Division by2^lambda_j is valid for states and raw terms because the normalized recurrence constructs those exact divided integers. In particular jF' and the adjacent lambda difference yield oddpart(j) on the secondary term; this is not a division of an arbitrary product. Order-zero insertion has lambda0=0. Coefficient prescales receive no invented order factor.

Consequently equation10 follows with the actual raw envelope and v'^i. Its use still requires the normalized circuit's own domain/divisibility proof; this report does not prove a new normalized all-cell composition. If a bound forces an integer magnitude below one, prove the zero case or retain a zero-capable encoding. Negative digit capacities cannot be used. These are successful-operand bounds, not permission to parse arbitrarily large untrusted inputs without limits.

Exact-state bounds also cannot be assigned to rounded initial differences without adding their propagated error and proving sufficient slack. The author retains that separate join. The new c_k already includes coefficient conversion error; numerical source errors inside Z_k may not be removed simply because Newton arithmetic is exact.

## Independent exact evidence and remaining work

Own script `audit/review_degree_specific_fd_initializer_20261111.py` has SHA256 `0629B3C1A809D4F7B7C65E3D1DD2BAE8098D3412C317DFDCAFD4F3DDB1BB3E40`. Its receipt has SHA256 `563B6CFB157DC0235451FEF7581B22F8360BF89DB40B453C69C84329C51BF15B`.

The script passed36943 exact checks. It reconstructs all40 stored-coefficient bounds from their original rational formulas, adds the explicit nearest-grid error, and compares all1260 state rows and1254 raw-update rows across both classes and three domains. It verifies coefficient indices, C_i, individual raw terms, insertion equality, strict-power/bit-length capacities, reference bounds and all stage peaks. The guarded kernels use alternating finite binomial sums instead of the author's Stirling recursion. Additional monomial checks cover all degrees/orders0..19 at both step bounds, including vanishing higher differences. These are formal rational-envelope computations, not values of a source polynomial.

All three author artifacts and ten prerequisite pins match; their full paths and hashes are in the receipt. They include stored source9B777E02/review10281561, finite Stirling4980828A/review212CADE1, all-cell52136903/review365EA347 and normalized sourceEFB31BE5/review9F1C14DF.

No initializer count changes here. Full and truncated variants keep their distinct general-product, small-scale, prescale and traversal obligations. Concrete source arrays, ordinary-rule arithmetic records, actual cache lifetimes, exhaustive unit-output coverage and complete matched prices remain outstanding. This review accepts the source-bound width implication and exact metadata only.
