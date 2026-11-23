# Independent review of compact signed-exponent dyadic replay

2026-11-11. Verdict: **PASS as a mathematical checker plan and source/API inventory.** No correction is required to the frozen note. This is not acceptance of a Lean implementation, an external Arb computation, or a spectral certificate. No build, numerical FFT, or L-function evaluation was run.

## Frozen input and review method

Author input: `integration/COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md`, SHA256 `85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8`.

I read the full note, inspected the actual core and Mathlib definitions and theorem statements, independently derived its comparison, rounding and witness rules, and wrote a bounded exact-arithmetic regression. The regression checks finite instances against Python Fraction; it is not the proof of the general rules. Huge-exponent cases use explicit algebraic expected signs and do not construct huge rational denominators.

The source environment is Lean v4.35.0 and the target's Mathlib pin `56a005855ea17e0b0958f73ec801ae140b0a1679`, read from the existing cache at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. No source files were changed.

## 1. Source statements and representation

The source inventory is accurate. The following were inspected directly.

| Source | Actual content relevant to this plan |
| --- | --- |
| Core `Init/Data/Dyadic/Basic.lean:128`, `:140` | `Dyadic.ofOdd n k hn` represents `n * 2^(-k)`; `ofIntWithPrec` normalizes a signed integer by its trailing zero count. A wire exponent `e` therefore maps to precision `-e`. |
| Same file `:265`, `:282`, `:321` | `toRat_ofIntWithPrec_eq_mul_two_pow`, `toRat_add`, and `toRat_mul` prove the claimed semantic identities. |
| Same file `:156`, `:223`, `:627`, `:638` | Addition and Boolean order align mantissas by the full precision difference; `toRat` builds shifted numerator/denominator data. These definitions cannot establish the desired compact allocation bound. |
| Same file `:543`; core `Init/Data/Dyadic/Round.lean:28`, `:72` | `roundDown` uses signed right shift, and `roundDown_le` / `le_roundUp` prove its direction. The custom guarded operation still needs its own correspondence proof. |
| Core `Init/Data/Int/Bitwise/Lemmas.lean:44` | `m >>> n = m / ((2^n):Nat)`. This is Euclidean floor division for positive denominators, including negative `m`. |
| Core `Init/Data/Dyadic/Inv.lean:31`, `:41` | `invAtPrec` and `divAtPrec` pass through `toRat`. Their zero-divisor value is totalized to zero. The proposed witness checker correctly rejects a zero divisor instead. |
| Mathlib `Data/Dyadic.lean:54` and following | `toReal` is the cast of `toRat`. The addition, multiplication, power and order lemmas give a semantic bridge, not a promise that unfolding this definition on concrete inputs is inexpensive. |
| Mathlib `Data/Nat/Size.lean:72` and following | `lt_size_self`, `size_le`, `lt_size`, `size_pos`, `size_eq_zero`, and `size_shiftLeft` provide the precise binary-length inequalities. In particular `m < size n` iff `2^m <= n`. |
| Mathlib `Data/Nat/Sqrt.lean:30`, `:32`, `:52`, `:56` | `sqrt_le'`, `lt_succ_sqrt'`, `eq_sqrt`, and `eq_sqrt'` provide the stated integer-square witness characterization. |

The author's seven source hashes were checked against the local files and agree. Core `Nat.log2_eq_iff` at `Init/Data/Nat/Lemmas.lean:1338` is another available length characterization for positive naturals. An `extern` annotation on executable `log2` does not establish a kernel runtime claim. The note makes no such claim.

The actual modular pilot's `prime-estimates/principal_theta_modular_pilot_20261111.py:51` stores each endpoint using `endpoint.man_exp()` as signed mantissa and exponent fields. The proposed wire semantics matches this representation. Such a pair is exact data; its having come from Arb does not prove that it encloses the intended transcendental value.

## 2. Comparison and the three-term sign rule

For nonzero `m`, put `l = bitlength(abs(m))` and `T=e+l`. From `2^(l-1) <= abs(m) < 2^l`, multiplication by positive `2^e` gives

```
2^(T-1) <= abs(m*2^e) < 2^T.
```

All powers here are mathematical real powers with integer exponents. The comparisons of `T` use signed integer arithmetic. No conversion of a large negative exponent to a natural is permitted before a branch proves it nonnegative and small.

Different tops order positive magnitudes strictly. Equal tops imply `e-f=l_B-l_A`. Alignment then uses only a mantissa-length difference and produces at most `max(l_A,l_B)` bits. Zero and sign branches are necessary; order reverses for two negative numbers. Canonical odd mantissas are optional for this argument.

For at most three nonzero signed terms, sort by top. If `T1 >= T2+2`, the leading magnitude is at least `2^(T1-1)` and the other two together are strictly less than `2*2^T2 <= 2^(T1-1)`. Therefore the leading term determines the sign, even at the equality threshold. This uses the strict upper magnitude bound; replacing it by a non-strict bound would lose the argument.

Otherwise the two largest tops differ by zero or one. Align only those terms. If all current mantissas have at most `W` bits, the aligned terms have at most `W+1` bits and their signed sum at most `W+2`. Drop the sum if zero, otherwise retain its exact exponent and recompute its top, then re-sort. There are at most two merges, so the initial maximum width grows by at most four. This proves both the stated exact sign result and the width bound. It applies to `x+y-L` and `U-x-y`, even when the third exponent is arbitrarily far away.

This rule has a fixed arity hypothesis. It must not be applied to an arbitrary long sum with the same two-bit dominance threshold. The note correctly evaluates longer expressions through bounded-arity graph nodes.

## 3. Directed rounding and endpoint generation

The sticky-bit rules in section 5 are correct for both signs. If `e>=g`, the value is already a multiple of `2^g`, so returning its original pair is exact. Requiring an expanded integer grid coefficient here would defeat the compactness goal.

If `d=g-e>0`, write `abs(m)=q*2^d+r`, with `0<=r<2^d`. For positive `m`, lower/upper grid coefficients are `q` and `q+[r>0]`. For negative `m`, they are `-q-[r>0]` and `-q`. If `d` is at least the positive mantissa's bit length, `q=0` and `r>0`; neither the denominator nor that large shift needs to be formed. In the other case the shifts are bounded by the mantissa length. Both individual rounding errors are strictly below `2^g`, and the resulting width is zero or `2^g`.

For significant precision `p>=1`, `g=T-p` bounds a non-carried grid coefficient by `p` bits. A ceiling equal to `2^p` can be normalized. For addition on one grid, round both operands outward and add corresponding endpoints. Width is at most `2*2^g`. The author's explicit bound on `max(Tx,Ty)-g` is needed to keep expanded grid coefficients short and is sufficient.

The optional exact-add generator's gap test also checks out. If the exponent gap exceeds `W+p+2`, the smaller-exponent operand is strictly below `2^(e_large-p-2)` in magnitude, since its mantissa is below `2^W`. This is a generator optimization. Acceptance still uses the exact three-term endpoint test, so a mistaken generator proposal is not trusted.

## 4. Product, division and square-root witnesses

Exact products have summed exponents and multiplied mantissas. With `W`-bit inputs the product needs at most `2W` bits. Four endpoint products cover an interval product; an interval square needs the separate zero-crossing case. A complex product coordinate is a difference or sum of two real products, and testing a proposed coordinate endpoint therefore has exactly the required three-term form.

For a positive point divisor `b`, the equivalence

```
l <= a/b <= u  iff  l*b <= a <= u*b
```

holds without a sign assumption on `a`. Negating numerator and denominator first handles negative `b`. Checking interval division requires an interval wholly on one side of zero, followed by the four corners or a proved reciprocal/product rule. Zero exclusion is an exact comparison, not a numerical tolerance.

The quotient generator in section 7 is correctly scaled. Let `k=p+l_B-l_A`. Its bounded integer ratio is `(A/B)*2^k` in either sign branch for `k`; after division, multiplication by `2^(e-f-k)` restores the desired value. The ratio is below `2^(p+1)`, so the quotient has at most `p+1` bits. Checking `N=q*D+r` with `0<=r<D` and `D>0` identifies the quotient without trusting an external division result. The output sign must reverse and negate the interval, as stated.

For a real square root on `[a,b]` with `a>=0`, checks `0<=l<=u`, `l^2<=a`, and `b<=u^2` imply enclosure by monotonicity on the nonnegative reals. These are sufficient even without using the optional integer-square-root generator. In that generator, splitting a possibly negative exponent as `e=2q+r`, `r` in `{0,1}`, must use Euclidean division. The example for an odd negative exponent has the correct shift. The note also retains the separate complex branch obligation. A square witness alone never selects a complex square-root branch.

## 5. Exact acceptance and honest complexity scope

I accept the claimed allocation argument for these bounded-arity operations. It measures mantissa width and binary exponent size, not the exponent's numerical magnitude. A proof-producing implementation must still establish every correspondence theorem and ensure its concrete evaluator follows the guarded branches. Accidentally invoking default `Dyadic.add`, order, `toRat` or `divAtPrec` during reduction could restore the very allocation cost this design avoids.

The plan properly separates semantic use of a theorem mentioning Rat or real powers from concrete evaluation of those expressions. In a later implementation, ordinary kernel-checked proof terms must consume the compact Boolean/witness checks through proved soundness lemmas. Native evaluation, a JSON checksum, or an external checker success flag is insufficient. Resource caps can reject inputs but cannot turn unchecked arithmetic into a theorem. No such implementation has been accepted by this review.

The cancellation limitations are accurately stated. The exact one-pair representation of `1+2^(-N)` intrinsically has `N+1` significant places. The fixed-arity sign check can determine the sign of `1+2^(-N)-1` by cancelling the equal large terms first; it cannot recover information already discarded from a rounded inner sum. Ill-conditioned interval differences or division near zero can require larger mantissas. This prevents a general constant-precision or constant-time inference from compact exponent storage.

## 6. Independent finite checks and remaining work

Script: `major-constants/review_compact_dyadic_20261111.py`, SHA256 `AA679D0F803A8E1877BF63E864D31F90034538F59C3238B4AEC6BD6947C861D5`.

Receipt: `major-constants/review_compact_dyadic_20261111.json`, SHA256 `129B55AFFEABF188878D000D6016432B31C311AB665143BE6537951B142B06B7`.

Executed from the workspace root:

```
work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/major-constants/review_compact_dyadic_20261111.py
```

The run passed 9,261 signed three-term comparisons against exact Fraction sums, 18,207 rounding cases, and 13,824 quotient cases. Six additional sign cases and two sticky-rounding cases use exponent magnitude `10^100`, with explicitly known expected results and without expanding such powers. The regression asserts the stated merge-width bounds. These tests support the case analysis above; they do not replace its proof or test Lean execution.

Remaining work is exactly the implementation and connection work the author records: prove the compact Boolean semantics, implement and validate the acyclic arithmetic graph, check every function/domain/branch witness, and connect the accepted interval operations to proved analytic primitives. Existing modular receipts are possible input data, not completed replay proofs. No final-root premise, finite-zero assertion, or production throughput estimate follows from this review.
