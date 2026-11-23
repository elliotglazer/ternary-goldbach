# Independent review of the compact reciprocal rectangle criterion

2026-11-11. **PASS for the paper criterion and bounded external arithmetic experiment. No correction requested.** On ordered finite input and output rectangles, with the input excluding the origin, the mathematical criterion is equivalent to full containment of the reciprocal image. Its implementation avoids rational division and unbounded exponent alignment. Resource rejection and malformed-input handling remain separate from that mathematical equivalence. This review certifies no transcendental seed, complete modular calculation, Lean theorem, or kernel execution cost.

## Frozen inputs and independent evidence

Paths below are relative to `work/qrh-campaign/agents/`.

| Item | SHA256 |
| --- | --- |
| `prime-estimates/COMPACT_RECIPROCAL_RECTANGLE_2026-11-11.md` | `53E2BCD126E06BCB280F579352BEB05BCB1C939AE4ACC97661F0525B3486434F` |
| `prime-estimates/compact_reciprocal_rectangle_20261111.py` | `E32289AA8773520002804572C3F95B207850C41574A9BE45ECB178A8E632426F` |
| `prime-estimates/compact_reciprocal_rectangle_20261111.json` | `73EF65C8CC1CF9DAD2C025F5A03880F2DC66BC0DDDC541555B3E943337BFD8D7` |
| Independent script `independent-feasibility/review_compact_reciprocal_rectangle_20261111.py` | `1CACF212F26639293DCB96F39968256CA598BE53D5F9FE5270807D76BA85B3D1` |
| Independent receipt, same stem `.json` | `1FF4E20C5BBBB0819235FEC230C8B734089E51E4EE3F64DBD5B91F72A6E6DDA4` |

I read the complete frozen note, new implementation, imported compact arithmetic, and prior lossless-gate report. I inspected the defining Mathlib inverse and ordered-field statements and checked all five source hashes in the author's table. The script verifies the three producer pins and the inherited compact-plan/review pins before and after execution. Imported dependency hashes and the lossless receipt hash are also checked. Producer files were not changed.

The independent regression uses a separately written rational edge-extrema oracle and rational quadratic minimum calculation. It calls the author's compact acceptance routine, which shares the previously reviewed `D`, `mul`, `cmp`, and `sign3` implementation. Thus it independently checks the new reduction against different mathematics; it is not a second implementation of every underlying integer operation.

## Signs, domains, and exactness

Let the input be `X × Y`, with both intervals closed, nonempty and ordered. Excluding the origin means exactly that X and Y do not both contain zero. Consequently `d=x²+y²>0` at every input point. The four required residuals are

```
x - lr*d,        ur*d - x,
-y - li*d,       ui*d + y.
```

Their nonnegativity is respectively equivalent to the real lower bound, real upper bound, imaginary lower bound, and imaginary upper bound. Every multiplication of an inequality uses the strictly positive d. The imaginary rows correctly interchange active and inactive coordinates, with linear coefficients -1 and +1. Reflecting both proposed output intervals, with endpoint reversal, correctly converts the `-1/z` test to the `1/z` test.

The code checks input and output order before applying this reduction. The origin is rejected even on an edge, corner, or singleton. This is the intended nonzero-domain contract, not equivalence for the totalized inverse at zero. Crossing one coordinate axis is otherwise allowed. Output bounds of either sign, including zero, are covered. The standalone `quadratic_nonnegative` helper requires ordered X and Y and `b ∈ {-1,+1}`; its public caller establishes these preconditions.

For `Q=a(x²+y²)+bx`, the author's three cases are exact:

* If `a<=0`, each one-variable quadratic attains its minimum at an endpoint. The displayed interpolation identity has the correct sign because `(t-L)(t-U)<=0`. Applying it in both coordinates proves that testing the four corners is necessary and sufficient. Singleton intervals require no interpolation division. The linear case `a=0` is included.
* If `a>0`, choosing the inactive coordinate nearest zero exactly minimizes its contribution. When `2aL+b>=0`, the active quadratic is minimized at L; when that fails and `2aU+b<=0`, it is minimized at U. The endpoint difference factorizations give the correct nonnegative products. Equality and degenerate active intervals are handled by these branches.
* Otherwise the active vertex is strictly inside the interval. The identity
  `4aQ=(2ax+b)²+4a²y²-1`
  uses `b²=1`. The exact minimum is nonnegative if and only if `4a²y0²-1>=0`. Although the proof identifies the real vertex `-b/(2a)`, the implementation never forms it or divides by a. If y0 is zero, the required inequality is false, as it should be.

The chosen minimizers lie in the original rectangle, so the argument proves necessity as well as sufficiency. This is stronger than independently bounding numerator and norm denominator, which can reject valid reciprocal enclosures.

## Fixed-size arithmetic

I traced all acceptance paths. Endpoint residuals contain exactly three terms; slope and vertex residuals contain at most two. No intermediate sum is converted to one exact dyadic pair. Products multiply mantissas and add signed exponents. Factors two and four are compact exponent shifts.

The inherited `sign3` dominance rule applies only to at most three terms. A leading top exponent at least two above the next dominates the other two combined, using their strict magnitude upper bounds. Otherwise only the two leading terms are aligned; their top proximity bounds the shift by their mantissa widths plus one. Cancellation is handled before comparing a distant third term. The imported implementation follows these branches, including normalization after cancellation. It does not align all three values at the smallest exponent.

The reported operation bounds are valid: four endpoint-order comparisons, at most sixteen `sign3` calls and sixty-four multiplication calls per complete gate. A concave row has at most four signs and sixteen products. A convex row has at most three signs and six products. Raw monomials have degree at most four in supplied mantissas, and sign merging adds at most four bits. Thus `4W+4` bounds working mantissa width, and `4W+8` is a conservative shift policy. The prototype's 8192 shift guard is respected by the sufficient input policy `W<=2046`.

Exponent arithmetic still costs space for the binary exponent itself. It does not cost space proportional to an exponent gap's numeric magnitude. `Fraction`, powers with expanded huge exponents, default dyadic addition, `toRat`, and division-through-rationals are absent from `accept` and `quadratic_nonnegative`. Bounded rational conversion occurs only in the test oracles. The prototype is not a hardened parser; length checks before integer conversion, typed pair shapes, error handling and resource rejection must be supplied by the eventual checker.

## Independent bounded tests

My new grid uses endpoints `{-7/4,-3/4,-1/4,0,1/4,3/4,7/4}`, rather than the author's half-integer grid. It has 28 intervals and 784 rectangles. The completed run checked:

* 10,976 compact quadratic decisions against direct rational minimization;
* 9,504 full reciprocal-box decisions against the separately written edge-extrema oracle, including reflected outputs for `-1/z`;
* 4,224 exact rational boundary and inward-perturbation checks;
* rejection of all 256 origin-containing rectangles and five additional invalid-order, invalid-sign, and boundary-pole cases.

The edge oracle includes corners, axis intersections on edges, and edge stationary points with equal coordinate magnitudes. These contain all coordinate extrema, including degenerate intervals. The compact comparisons include outward dyadic rounding followed by separate inward and outward endpoint changes. Nondyadic exact extrema are checked only by the rational mathematical oracle; the report does not mislabel them as compact wire values.

Both unchanged actual lossless gates pass: `S_output=-1/translated` and `A=1/root`. My own exact edge oracle checks their entire input rectangles. Their input and output boxes were then scaled inversely by `2^E` and `2^-E`, for `E=±10^100`, without rational conversion of these scaled values. The measured maxima remain 844 mantissa bits and a 572-bit shift for S_output, and 846 mantissa bits and a 578-bit shift for A. Only exponent encoding grows, from 10 to 334 bits. This verifies the stated stress cases, not a universal runtime benchmark.

## Source and proof boundary

The actual defining file is `Mathlib/Basic/Complex/Basic.lean`, not its deprecated `Data/Complex/Basic` forwarding module. I checked `normSq_apply`, `normSq_pos`, `inv_re`, and `inv_im` at the cited lines. The actual `le_div_iff₀` and `div_le_iff₀` statements require positive denominator and have precisely the cross-product orientation used here. The square and dyadic semantic sources match the author's hashes. These facts support a short formal proof of the new mathematical reduction.

No Lean command ran. In particular the generic compact sign checker still needs a kernel-checked soundness theorem and connection to the wire semantics. The two-gate experiment continues to depend on an unproved transcendental seed and the earlier receipt's endpoint consistency. It neither repairs nor changes any frozen lossy-presentation failures, and it supplies no later modular steps, theta evaluation, whole-panel enclosure, or spectral certificate. The accepted result is an exact paper criterion plus successful bounded external arithmetic tests.
