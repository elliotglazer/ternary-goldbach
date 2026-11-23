# Compact signed-exponent dyadic replay

2026-11-11. Source-supported paper checker plan, submitted for independent review. It preserves endpoint values m*2^e without allocating a denominator of size 2^(-e). It specifies exact comparisons, directed rounding and arithmetic witnesses sufficient for interval replay. No backend, Lean declarations, builds, or performance experiment is supplied.

## 1. Existing semantics and the execution paths to avoid

The earlier interval plan is `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md`, SHA256 `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC`, reviewed at `4C773E1497C2C6F2D99D0A1F5A060A8029E9CC5EBCD85D5F3265914A13547181`. This note changes its arithmetic representation and checking strategy, not its real/complex interval semantics or elementary-function proofs.

Installed Lean v4.35.0 already supplies `Init.Data.Dyadic`:

* `Dyadic.zero`, or `Dyadic.ofOdd n k hn`, represents n*2^(-k), with n an odd signed integer and k a signed integer.
* `Dyadic.ofIntWithPrec m (-e)` maps the receipt pair (m,e) to that exact value. `Int.trailingZeros` and its divisibility/oddness lemmas support normalization.
* Exact multiplication multiplies mantissas and adds signed precisions; dyadic shifts change only the precision.
* `Dyadic.roundDown_le` and `Dyadic.le_roundUp` prove directed rounding soundness.
* Mathlib `Data/Dyadic.lean` supplies `toReal`, `toReal_add`, `toReal_mul`, `toReal_pow`, `toReal_le_toReal`, and `toReal_lt_toReal`.

The same source has expensive execution paths for this use case. `Dyadic.add`, `blt`, and `ble` left-shift a mantissa by the full precision difference. `toRat` constructs a power-of-two denominator or numerator. `invAtPrec` and `divAtPrec` explicitly pass through `toRat`. These are mathematically valid but not the intended runtime path for tiny endpoints with huge negative exponents.

Reuse their semantic theorems through a generic bridge; do not evaluate these expanding definitions on receipt data. The new Boolean checks below operate on signed mantissas, signed exponents, bit lengths and bounded shifts. Prove their correspondence to dyadic/real order once, then consume that theorem in the interval soundness proof.

## 2. Source inventory and pins

Core source root: `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/`.

| Core file | Relevant source and SHA256 |
| --- | --- |
| `Init/Data/Dyadic/Basic.lean` | Representation around lines 127–140; add/mul around 161–182; semantic conversion at 265,321,379; expanding order checks around 634–656. SHA `1ED0AE82E81A48C9A1554730E2BAD1853EF42F3D2ABB6D87D3498E2C49D8E373`. |
| `Init/Data/Dyadic/Round.lean` | `roundDown_le`, `le_roundUp`. SHA `704BB5516B98DA3D8E7FA45143376515BCD67E232F6141802293E8A9A354B169`. |
| `Init/Data/Dyadic/Inv.lean` | Existing reciprocal/division definitions and multiplication inequalities. SHA `A1BDF5994F50B000D3893B555187040C2B5E44D4A140D498CE04A1BD0CE55937`. |
| `Init/Data/Int/Bitwise/Lemmas.lean` | `Int.shiftRight_eq_div_pow` at 44 and `Int.shiftLeft_eq` at 133. SHA `49033D706268721294B337495E63DCDEC45325F4246DE6A92FB7E5A75B751633`. |

Mathlib remains at `56a005855ea17e0b0958f73ec801ae140b0a1679`.

| Mathlib file | Relevant source and SHA256 |
| --- | --- |
| `Data/Dyadic.lean` | Dyadic-to-real semantics. SHA `F3C712B9D4CAEE471AE5CE53B390C24DA2EDE303DD800F0D3A0BCEECD04BD68F`. |
| `Data/Nat/Size.lean` | `lt_size_self`, `size_le`, `lt_size`, `size_pos`, `size_eq_zero`, and `size_shiftLeft`. SHA `C8B7E15984405930041DD4DA7039CC0BBDCFCF0FD9ADCB5B2DF71A019F5A19E4`. |
| `Data/Nat/Sqrt.lean` | `sqrt_le'`, `lt_succ_sqrt'`, `eq_sqrt` and `eq_sqrt'`. SHA `259AF8DB2BE15E3A6DF78CC96743E4D6BD7D48DD831C1D2598CFDADDF891658B`. |

`Nat.log2` also exists in core, with an executable definition and an external implementation annotation. That annotation alone is not a kernel-performance guarantee. The size theorems above are enough for the mathematical bit-length contract; the eventual implementation must check the chosen executable path separately.

## 3. Wire values, normalization, and bit lengths

A finite wire value is a pair `(m:Int,e:Int)` with meaning `(m:Real)*2^e`. There are no infinities, NaNs, unsigned negative exponents, or negative zeros. An optional canonical form requires `(0,0)` for zero and m odd otherwise. Negative odd integers satisfy `m % 2=1` under the source Euclidean convention. Noncanonical input can instead be normalized by stripping the trailing zero bits of |m| and increasing e by that count.

Only the mantissa is inspected during normalization. No operation loops |e| times. The exponent is itself a binary integer; its storage size depends on the bit length of e, not on 2^e. Reject malformed encodings, invalid earlier-node references, and reversed interval endpoints before arithmetic replay.

For A=|m|>0 define its bit length l by

```
2^(l-1) <= A < 2^l,       l>=1.
```

`Nat.size` and the cited inequalities provide this property. These powers occur in the generic proof, not as requests to construct a huge power of the endpoint exponent. Define the signed top exponent T=e+l. Then

```
2^(T-1) <= |m*2^e| < 2^T.
```

The checker stores and compares T as an Int, including when it is very negative.

## 4. Exact comparison without an exponent-gap allocation

For two nonzero positive magnitudes A*2^e and B*2^f, compute l_A,l_B and their signed tops T_A,T_B.

* If T_A<T_B, the first magnitude is strictly smaller; reverse the conclusion if T_A>T_B.
* If the tops agree, align the two mantissas to exponent min(e,f) and compare the resulting natural numbers.

In the equal-top branch, `e-f=l_B-l_A`. Thus the shift distance is bounded by the input mantissa lengths. The aligned integers have at most max(l_A,l_B) bits. The large receipt exponents are never expanded. Handle zero first, then signs; reverse magnitude order for two negative values. This also gives exact equality without requiring canonical inputs.

For example, comparison of 2^(-1000000000) and 2^(-1000000001) finishes by comparing their signed tops. It never constructs either denominator.

### Exact sign of a sum of at most three terms

This small extension permits tight arithmetic-witness checks, not merely broad rounded enclosures. Drop zero terms and sort the remaining signed terms by decreasing top exponent. If there is one term, use its sign. If there are two or three terms and the largest top is at least two above the second, the largest term determines the sign: its magnitude is at least 2^(T1-1), while the sum of the at most two smaller magnitudes is strictly below 2*2^T2<=2^(T1-1).

Otherwise the top two differ by at most one. Combine those two exactly by alignment to their smaller exponent. Although their exponents can be large signed integers, their difference is bounded by their mantissa lengths plus one. If the current largest mantissa length is W, the aligned operands have at most W+1 bits and their sum at most W+2. Normalize or leave the combined term unnormalized, drop it if zero, re-sort, and repeat.

At most two combinations are needed, so all mantissas have at most W+4 bits. This computes the exact sign, including exact cancellation, without constructing a common denominator for a widely separated third term. It verifies `L<=x+y<=U` by the signs of `x+y-L` and `U-x-y`. In particular the cancellation of 1 and -1 in `1+2^(-1000000000)-1` is handled before any small term is aligned.

## 5. Directed rounding and the small-term sticky rule

Let the target grid step be 2^g, with g an Int. For x=m*2^e, directed rounding means exact lower and upper multiples of this step. If m=0 return zero. If e>=g, x is already a grid multiple and may be returned unchanged; there is no need to expand its grid coefficient.

Otherwise d=g-e>0. To divide |m| by 2^d:

* If d>=bitlength(|m|), the quotient is zero and the remainder is nonzero. Do not construct 2^d or call a shift with the huge distance.
* If d<bitlength(|m|), use the bounded right shift `q=|m| >>> d`. Set the sticky bit to whether `|m| != q <<< d`. This tests for any discarded nonzero bit using only bounded shifts.

For m>0, floor and ceiling grid coefficients are q and q+sticky. For m<0 they are `-q-sticky` and `-q`. This is floor toward negative infinity, not signed truncation toward zero. Source `Int.shiftRight_eq_div_pow` confirms the floor-division semantics, but the sign/magnitude construction makes the sticky case explicit.

It proves

```
down_g(x) <= x <= up_g(x),
up_g(x)-down_g(x) is either 0 or 2^g.
```

A positive nonzero term far below the grid rounds to [0,2^g]; a negative one rounds to [-2^g,0]. It cannot be discarded from both endpoints. For example, rounding -13*2^(-5) to g=-3 gives [-4,-3]*2^(-3), namely [-1/2,-3/8].

For p>=1 significant bits, choose g=T-p for a nonzero input. The retained grid coefficient needs at most p bits, except a ceiling carry to 2^p, which normalizes to a one-bit mantissa at the next exponent. The rounding work depends on input mantissa length and p, not on the absolute value of e. An arbitrary fixed grid may require a huge grid coefficient for a huge value, so it is important that an already exact grid value may remain in compact form.

## 6. Addition, subtraction, and multiplication

Exact multiplication is `(m,e)*(n,f)=(m*n,e+f)`, followed by optional normalization or directed rounding. With W-bit inputs the raw product has at most 2W bits. Squaring is the same operation with itself. Negation changes only the mantissa sign.

Exact addition cannot always have a bounded-mantissa result: 1+2^(-N) requires N+1 significant binary places in a single dyadic pair. A compact checker therefore accepts outward endpoints, rather than insisting on an exact one-pair sum. Check a proposed addition interval by the three-term sign procedure. Subtraction uses the same rule after negation.

A constructive, possibly wider generator is available. Choose a grid g near the larger input top, round each operand outward using the sticky rule, and add the two lower grid coefficients and the two upper coefficients. The resulting interval encloses the exact sum and has width at most 2*2^g. If `max(T_x,T_y)-g` is bounded by p, the grid coefficients have at most p+1 bits. This extra condition prevents an unintended large left shift.

To preserve cancellation, a generator can first combine exactly when the exponent gap is bounded by W+p+2, then round the resulting single dyadic. If the exponent gap exceeds that bound, the smaller-exponent input has magnitude below 2^(e_large-p-2), so it is a certified small term relative to the larger one and the sticky-grid enclosure is appropriate. Either generator is untrusted; exact three-term endpoint checks establish soundness of the supplied result.

For interval multiplication, check the four exact endpoint products and choose enclosing minima and maxima by compact comparison. The square rule must handle an interval crossing zero, with lower bound zero. A complex product coordinate is the sum or difference of two exact products, so checking its proposed bound uses at most three terms after multiplying the bounded mantissas. Longer polynomials are replayed through bounded-arity operations with outward rounding, rather than one expanding rational expression.

## 7. Division witnesses without Rat conversion

For a nonzero point divisor b, first negate both a and b if necessary so b>0. Proposed dyadic endpoints l<=u enclose a/b exactly when

```
l*b <= a <= u*b.
```

Products stay dyadic and both comparisons use the compact algorithm. No reciprocal or denominator expansion is required. A reciprocal is the case a=1. Reject b=0; the core's totalized zero-divisor return value is not an admissible interval proof.

For interval division, require the divisor interval to exclude zero, then bound all four endpoint quotients by these cross-product witnesses, or use a separately checked reciprocal interval followed by interval multiplication. These are the same ordered-field rules as in the earlier interval plan.

A generator can also produce p-bit quotient bounds with bounded integer division. For positive magnitudes A*2^e and B*2^f, with lengths l_A,l_B, choose `k=p+l_B-l_A`. If k>=0, divide `(A <<< k)` by B; otherwise divide A by `(B <<< (-k))`. The shift is bounded by p plus the mantissa lengths. If the integer quotient and remainder are q,r, the lower output is `q*2^(e-f-k)`, and the upper increments q when r!=0. Restore the sign with directed endpoint reversal for a negative quotient.

The checker can verify `N=q*D+r` and `0<=r<D` on these bounded integers instead of trusting division execution. The quotient has at most p+1 bits. Exponent differences, however large, occur only in the final signed exponent e-f-k. Existing core division-through-Rat is unnecessary.

## 8. Square-root witnesses

For a nonnegative interval [a,b], proposed dyadic [l,u] is sound if

```
0<=l<=u,       l*l<=a,       b<=u*u.
```

Use compact multiplication and comparison for all three checks. The real square-root monotonicity lemmas from the earlier interval plan prove the semantic enclosure. Reject a negative lower input; do not rely on totalized square-root behavior.

A bounded-integer generator is possible. For a positive input m*2^e, split e=2q+r with r in {0,1}, using Euclidean division also for negative e. Then the root is `sqrt(m*2^r)*2^q`. A p-bit approximation only needs an integer square-root witness after a shift controlled by p and bitlength(m), not by |e|. Source `Nat.eq_sqrt` or `eq_sqrt'` identifies the integer root by `s^2<=N<(s+1)^2`; proposed real endpoints are independently verified by the simpler square inequalities above.

For example `sqrt(2^(-(2N+1)))=sqrt(2)*2^(-N-1)`. The precision needed to enclose sqrt(2) is independent of N. The interval endpoints keep -N-1 as an exponent.

The complex modular-root construction can use these real square roots and compact division to implement its existing right-half-plane formula. It still needs the positive-domain and branch proof. Dyadic arithmetic alone does not establish the correct complex branch.

## 9. Resource contract and genuine precision limits

If input and proposed output mantissas are bounded by W bits, the exact endpoint checks above use bounded-arity integer products and at most three-term sign tests. Their mantissa sizes are bounded by a small multiple of W. Large exponent gaps are compared as signed binary integers; they are not converted into shift distances unless a bit-length guard proves the distance small. Exponents themselves and requested precision still consume storage proportional to their own binary encoding lengths.

This is an allocation argument, not a measured runtime guarantee for Lean's kernel. The implementation must ensure that proof terms use the compact Boolean checker and a generic soundness theorem, rather than accidentally invoking default Dyadic order, exact add, `toRat`, or division-through-Rat on the receipt values. Core/Mathlib theorems may mention Rat or powers symbolically in proofs without requiring their large numerical evaluation.

Cancellation can require more information. If only p-bit enclosures of two nearly equal inputs are available, their difference may be too wide to determine its sign. Higher input precision or a proved algebraic cancellation is then necessary. In the expression `(1+2^(-N))-1`, first rounding the inner sum to an interval at ordinary precision loses the tiny result; subsequent arithmetic cannot recover it. Exact shared-expression simplification can cancel the two ones before rounding, but such a rewrite needs a proof and is not automatic interval reasoning.

Similarly a user demand for the exact dyadic representation of 1+2^(-N), or an interval narrower than 2^(-N) around it, cannot generally be met with fixed mantissa size. The compact representation solves exponent magnitude, not the intrinsic number of significant places in every requested result. Division near zero and cancellation in reconstructed modular derivatives may also force finer enclosures. None of these cases licenses silently setting a nonzero tiny value to zero.

## 10. Proof order and trust boundary

The minimum Lean work is a receipt-pair semantic bridge; bit-length/top bounds; guarded binary comparison; the three-term sign checker; directed sticky rounding; and product, quotient and square-root witness soundness. Compose these with the already specified interval rules and an acyclic earlier-reference certificate graph. Fixed resource caps may reject oversized certificates without affecting soundness; they are not mathematical assumptions about the target functions.

External Arb or floating-point code may propose mantissas, exponents and witnesses. Acceptance requires exact integer checks consumed by proved semantic lemmas. Neither floating output, a hash match, nor an external/native truth assertion is an axiom of correctness. A future kernel replay must verify its Boolean reductions through the approved kernel path and audit the resulting theorem dependencies.

The existing huge-negative-exponent modular receipts are compatible with this design in principle, but no complete receipt was replayed here. Implementing the compact checker, connecting every arithmetic node and branch witness, and proving the analytic primitives remain open. This note adds no new final-root premise and claims no completed backend.
