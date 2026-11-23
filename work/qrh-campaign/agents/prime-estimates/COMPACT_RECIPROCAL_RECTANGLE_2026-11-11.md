# Exact compact reciprocal rectangle test

2026-11-11. This is a proved-on-paper acceptance criterion and a bounded external exact-arithmetic prototype. It replaces rational quotient-candidate evaluation with at most sixteen signs of sums of at most three dyadic terms. On ordered finite rectangles excluding the origin, the criterion is necessary and sufficient for full rectangle containment, not merely a sufficient overestimate. No transcendental input, complete modular trace, or Lean theorem is certified here.

## Frozen evidence and inherited scope

Paths below are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
| --- | --- | --- |
| New checker and regressions | `prime-estimates/compact_reciprocal_rectangle_20261111.py` | `E32289AA8773520002804572C3F95B207850C41574A9BE45ECB178A8E632426F` |
| Deterministic result | `prime-estimates/compact_reciprocal_rectangle_20261111.json` | `73EF65C8CC1CF9DAD2C025F5A03880F2DC66BC0DDDC541555B3E943337BFD8D7` |
| Imported compact arithmetic | `integration/compact_dyadic_receipt_pilot_20261111.py` | `6FC3E2976B53B49D1A4FDFBDEA6A2D1E327CAA8BFCA24CCE0B1A77CE90B39840` |
| Imported bounded edge oracle | `integration/lossless_modular_two_step_20261111.py` | `9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6` |
| Two actual reciprocal gates | `integration/lossless_modular_two_step_20261111.json` | `31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE` |

The imports check these hashes, suppress bytecode writes and do not execute either producer's main program. The imported compact implementation supplies `D`, `mul`, `cmp`, and `sign3`; the new implementation does not claim independent reimplementation of those reviewed operations. The imported edge oracle supplies a mathematically different range calculation for bounded regression comparison.

The inherited arithmetic plan is `integration/COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md`, SHA `85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8`, reviewed at `2BD81A05B6C84A27149C1BEE5827B4918DD4F7F454AB799B1DEA8E954398F9DC`. The lossless receipt's seed remains unproved. Its other fourteen gates are not re-certified by this new two-gate test.

## 1. Domain and the four exact inequalities

Let `X=[Lx,Ux]`, `Y=[Ly,Uy]`, and let the proposed output be `R=[lr,ur]`, `I=[li,ui]`. All eight endpoints are finite real numbers. Reject reversed input or output intervals. Reject exactly the origin-containing input case

`Lx <= 0 <= Ux` and `Ly <= 0 <= Uy`.

This includes origin on an edge, at a corner, or in a singleton. The intended operation is reciprocal on its nonzero domain, not the totalized value of inverse at zero. An interval crossing one coordinate axis is allowed when the other coordinate interval excludes zero.

For every remaining input point put `D=x²+y²>0`. Since

`Re(1/(x+iy))=x/D`, `Im(1/(x+iy))=-y/D`,

full containment is equivalent to all four inequalities holding everywhere:

| Bound | Residual required nonnegative | Active coordinate | a | b |
| --- | --- | --- | --- | --- |
| real lower | `x-lr*(x²+y²)` | x | -lr | +1 |
| real upper | `ur*(x²+y²)-x` | x | ur | -1 |
| imaginary lower | `-y-li*(x²+y²)` | y | -li | -1 |
| imaginary upper | `ui*(x²+y²)+y` | y | ui | +1 |

Thus one routine suffices: decide whether `Q(x,y)=a*(x²+y²)+b*x >= 0` on `X×Y`, where `b` is exactly +1 or -1. Swap X and Y for the imaginary rows. To check `-1/z` instead, negate the proposed output intervals, reversing their endpoints, and apply the same test for `1/z`. There is no assumption about the signs of lr,ur,li,ui; bounds equal to zero are included.

## 2. Exact fixed-size quadratic test

The standalone helper requires ordered X and Y and b in {-1,+1}; its caller `accept` checks interval order first. If `a<=0`, test Q at all four corners. This includes a=0 and all degenerate intervals. For a nondegenerate interval [L,U], the univariate quadratic q(t)=a*t²+c*t satisfies

`q(t) - ((U-t)*q(L)+(t-L)*q(U))/(U-L) = a*(t-L)*(t-U) >= 0`.

Consequently its minimum is at an endpoint. Apply this independently to x and y. If an interval is a singleton the claim is immediate and no division by U-L is used. Necessity follows because the corners are input points. The checker itself never evaluates this proof's interpolation quotient.

If `a>0`, first choose the point y0 of Y nearest zero:

* If Ly>0, use Ly.
* Otherwise, if Uy<0, use Uy.
* Otherwise use 0.

This minimizes a*y². Let `dL=2*a*Lx+b` and `dU=2*a*Ux+b`, computed only as signs of two-term sums.

* If dL>=0, use x0=Lx and test Q(x0,y0)>=0.
* Otherwise, if dU<=0, use x0=Ux and test Q(x0,y0)>=0.
* Otherwise the vertex is strictly interior. Test `4*a²*y0²-1 >= 0`.

The endpoint cases follow from

`q(x)-q(Lx)=(x-Lx)*(a*(x-Lx)+dL)`

and the analogous identity with Ux. The factors have matching signs in each indicated case. In the remaining case, x0=-b/(2a) lies strictly inside X and

`q(x)=a*(x+b/(2a))²-1/(4a)`.

The exact minimum of Q is a*y0²-1/(4a). Multiplication by the positive 4a gives the checker inequality. The number x0 and the quotient 1/(4a) are never constructed during checking.

Equality dL=0 takes the left branch; equality dU=0 takes the right branch unless the left has already succeeded. This covers a vertex exactly on an endpoint, including singleton X. Every chosen minimizer belongs to the rectangle, so these conditions prove both directions of the test. For an inactive interval containing zero, the strict interior-vertex case necessarily fails because its final residual is -1. This is correct, not a special rejection heuristic.

Each endpoint residual is the sign of the three terms `a*x0²`, `a*y0²`, and `b*x0`. No sum is materialized as one exact dyadic. Each vertex residual has two terms, `4*a²*y0²` and -1.

## 3. Compact arithmetic and resource contract

Every endpoint is represented as `(m,e)` with exact meaning m*2^e, signed integer e, and normalized odd nonzero m. Neither the proposed output nor the input is converted to a rational. Negation changes the mantissa sign; multiplication multiplies mantissas and adds exponents. Factors 2 and 4 may be implemented as exponent adjustments.

Signs of sums use the reviewed `sign3` algorithm. Sort nonzero terms by signed top exponent e+bitlength(|m|). If the leader is at least two top bits above the next term, it dominates the sum of the at most two others. Otherwise merge only the two leading terms, whose shift is bounded by their mantissa widths plus one, then re-sort. At most two merges are needed. In particular cancellation is processed before a distant tiny term is considered. This avoids aligning an arbitrary input exponent gap.

For W the maximum normalized input/output mantissa width, including constants of width 1, this implementation has the following conservative fixed bounds per complete reciprocal gate:

* Four endpoint-order comparisons and a constant number of integer sign tests for domain checks.
* At most sixteen calls to `sign3`; each has at most three terms.
* At most sixty-four exact dyadic multiplication calls without common-subexpression reuse. A concave row uses at most sixteen; a convex row uses at most six.
* Polynomial terms have degree at most four in supplied endpoint mantissas. Their mantissas have at most 4W bits; powers of two do not add mantissa bits. A three-term sign has working mantissas at most 4W+4 bits. The looser policy bound 4W+8 also bounds every alignment shift.
* Exponents are added a fixed number of times, or adjusted by a normalization count bounded by the working mantissa width. If input exponent bit length is E, working exponent size is O(E+log(W+1)), independent of the magnitude of the exponent gaps.

The imported prototype has an 8192-bit hard guard on shifts. The sufficient parser policy W<=2046 makes 4W+8<=8192. This is a resource policy for this prototype, not a mathematical limit on the criterion. A production parser must bound strings before integer conversion, reject malformed representations and count resource exhaustion as rejection. The current script is a trusted local experiment, not that hardened parser.

The criterion does not promise that a tight proposed output has small mantissas, that arbitrary exact sums have compact single-dyadic representations, or that Lean will execute the eventual checker quickly. It only bounds the arithmetic needed to verify supplied bounded-width endpoints. `Dyadic.add`, `toRat`, `invAtPrec`, and division through rationals must not become accidental execution paths.

## 4. Bounded tests and actual lossless gates

The deterministic script ran successfully using standard-library Python only. It enumerates all 45 closed intervals with endpoints in {-2,-3/2,...,2}, hence 2025 input rectangles. All 625 origin-containing rectangles are rejected. For each of the 1400 admissible rectangles, the independent edge-extremum formula computes the exact rational coordinate ranges.

The script then checks:

* 25,200 compact acceptance comparisons, including reflected outputs for -1/z, against those exact ranges. Outputs are outward-rounded to multiples of 1/64, then each endpoint is moved inward or outward by 1/64. Degenerate intervals, all quadrants, axis crossings and zero bounds occur in this enumeration.
* 7000 bounded rational checks: the exact tight range passes the quadratic formula, and moving any one tight bound inward by 1/1024 fails. Some exact extrema are nondyadic, so this particular equality suite uses a separate Fraction version of the algebra. The production acceptance routine remains dyadic-only.
* Explicit vertex-on-endpoint equality, an interior vertex with zero inactive coordinate, and cancellation exposing a term at exponent -10^100.

The two actual lossless gates are `S_output=-1/translated` and `A=1/root`. Both pass the new dyadic criterion and the original bounded edge oracle. The original input/output endpoints are used unchanged. The script reads endpoints only; it relies on the separately reviewed lossless receipt for midpoint/radius-to-endpoint consistency and all preceding gates.

| Gate | sign3 calls | products | largest working mantissa | largest shift |
| --- | ---: | ---: | ---: | ---: |
| S_output | 13 | 43 | 844 bits | 572 bits |
| A | 12 | 42 | 846 bits | 578 bits |

For each gate the input is additionally scaled by 2^E and output by 2^-E, for E=10^100 and E=-10^100. All four scaled checks pass without Fraction conversion. Operation counts, largest working mantissas and largest shifts are unchanged; largest exponent bit length rises from 10 to 334. Positive scaling preserves rectangle containment exactly because `(2^E*z)^-1=2^-E*z^-1`.

These tests are regression evidence, not a proof by finite enumeration. The four-inequality reduction and quadratic minimum proof establish the general paper rule. No new claim is made about the old lossy receipt's failing translations or quotients, or about its remaining reciprocal gates.

## 5. Source-supported formalization plan

Mathlib source root is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`, pinned at `56a005855ea17e0b0958f73ec801ae140b0a1679`. Core source root is `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/`. These source files were inspected; no Lean command ran.

| File | Actual reusable declarations | SHA256 |
| --- | --- | --- |
| `Mathlib/Basic/Complex/Basic.lean` | `Complex.normSq_apply` at 516; `normSq_pos` at 564; `inv_re` at 686; `inv_im` at 689. The inverse coordinates are respectively re/normSq and -im/normSq. | `C46DF05B286BD59A4725D02B9BCFA8AD9C50C7898C73FB116C11D60B758EEAE3` |
| `Mathlib/Algebra/Order/GroupWithZero/Basic.lean` | `le_div_iff₀` at 1128 and `div_le_iff₀` at 1132 require positive denominator and give the exact cross-products used above. | `1C813E26A4E02549461BF10D090CB9F7F9F80EA4FCE592EC449CC8C4109846E3` |
| `Mathlib/Algebra/Order/Ring/Unbundled/Basic.lean` | `sq_nonneg` at 608 supports completed-square nonnegativity. Ordinary ordered-ring product/sign facts prove the endpoint differences. | `38B363D3DAA68A84BDA9A2F231C2A59BC2447DE43111C74D8E1857334FE3D855` |
| `Mathlib/Data/Dyadic.lean` | `toReal` at 54, its ring/order lemmas and order embedding. Use as semantic bridge, not an executable toRat conversion on receipt values. | `F3C712B9D4CAEE471AE5CE53B390C24DA2EDE303DD800F0D3A0BCEECD04BD68F` |
| `Init/Data/Dyadic/Basic.lean` | Signed-precision representation, normalization and multiplication semantics. | `1ED0AE82E81A48C9A1554730E2BAD1853EF42F3D2ABB6D87D3498E2C49D8E373` |

`Mathlib/Data/Complex/Basic.lean` is a deprecated forwarding module at this pin; it is not the defining location of the complex lemmas.

The smallest new proof work is: prove the ordered-rectangle quadratic criterion by the three cases above; combine four copies with the complex inverse coordinate identities; prove the compact `cmp`/`sign3`/multiplication implementation corresponds to real arithmetic; and lift the checked endpoint representation into typed graph semantics. Completeness is available on the mathematical domain, though a resource-limited checker may explicitly reject oversized encodings. No compact reciprocal generator is required for sound checking: any untrusted producer can propose the four output endpoints.

The current script is not a Lean implementation, and it does not discharge the inherited generic compact arithmetic proof. There is no use of `native_decide`, FLINT, a floating-point acceptance oracle, or any built-in transcendental evaluator. Successful arithmetic acceptance preserves the unproved-seed status of the two-gate receipt.
