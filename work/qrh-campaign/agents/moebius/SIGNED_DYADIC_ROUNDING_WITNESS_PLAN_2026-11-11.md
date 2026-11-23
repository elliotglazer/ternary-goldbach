# Signed dyadic rounding: exact witnesses and source APIs

2026-11-11. Paper derivation and read-only source inspection. No Lean declaration, build, arithmetic-checker implementation, numerical evaluation, or production scan was performed. The claims below describe finite arithmetic lemmas still to be implemented and checked in Lean.

## 1. Scope and pinned inputs

This note supplies the signed rounding leaf needed by `major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md`, SHA256 `60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9`. Its independent review is `zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md`, SHA256 `E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B`.

The concrete consumer is `major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md`, inspected SHA256 `8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2`. Its immutable sixteen output coefficient boxes and actual-zeta panel/endpoint claims remain separate obligations. This note certifies neither those boxes nor any function value.

The inner coordinate grid is `2^-1041`; the canonical elementary-output coordinate grid is `2^-1025`. The former supports the existing norm allowance `delta=2^-1040`, the latter the existing `eta=2^-1024` allowances. No later operation is authorized to use a new rounding grid merely because this leaf is available.

## 2. Integer witness, including negative values

Let `p` be an integer, `q` a positive integer, `g` a natural number, `S=2^g`, and `x=p/q`. Reduction of the fraction is unnecessary. Define

```
m = floor(p*S/q + 1/2),       xhat = m/S.
```

The exact necessary and sufficient witness for this value of `m` is

```
(2*m-1)*q <= 2*p*S < (2*m+1)*q.                    (W)
```

Indeed, the floor characterization says `m <= p*S/q+1/2 < m+1`. Subtraction of `1/2` and multiplication by the strictly positive integer `2*q` give (W); reversing these steps proves sufficiency. Thus a producer may propose `m`, while the checker verifies only `q>0`, the exact power `S=2^g`, and the two signed integer comparisons. There is exactly one accepted `m`. No floating-point rounding convention is a premise.

An exact producer formula is Euclidean integer division

```
m = (2*p*S+q) / (2*q).
```

Here `/` means division whose quotient is floor for a positive denominator, including a negative numerator. Truncation toward zero is not interchangeable with it. Alternatively, supply quotient/remainder integers `m,r` with

```
2*p*S+q = (2*q)*m+r,       0 <= r < 2*q.
```

These equations imply (W) directly and give a division-free checker contract. A reduced `Rat` input supplies `p=x.num`, `q=x.den` with positive denominator, but the general witness also accepts unreduced intermediate fractions.

The interval assigned to `m` is `[m-1/2,m+1/2)`. Consequently a tie `p*S/q=k+1/2` goes to `k+1`, toward positive infinity. In particular, the scaled inputs `1/2,-1/2,-3/2` round to `1,0,-1`. Rounding is not an odd function at ties. The strict upper comparison must not be changed to a non-strict comparison: doing so would accept two answers at a tie.

## 3. Coordinate and complex norm errors

Dividing (W) by positive `2*q*S` yields the signed error interval

```
-1/(2*S) < xhat-x <= 1/(2*S),
```

and hence `abs(xhat-x)<=1/(2*S)`. The closed interval is convenient for outward enclosures even though one endpoint is excluded by the actual rounding rule.

For a complex rational input, apply the witness separately to its two coordinates, with their own positive denominators if necessary. Each coordinate error is at most `1/(2*S)`. Therefore

```
norm(zhat-z) <= sqrt(2)/(2*S) <= 1/S.
```

The weaker last inequality follows without any square-root computation from `norm(w)<=abs(re w)+abs(im w)`. For the inner grid `g=1041`, it gives norm error at most `2^-1041=delta/2`, comfortably within the accepted `delta` gate. For the canonical grid `g=1025`, a real output has error at most `2^-1026=eta/4`, and a complex output has norm error at most `2^-1025=eta/2`; both fit the previously allocated real `eta/2` and complex `eta` gates. These spare factors are not used to enlarge any other budget.

When an existing norm allowance is padded into a coordinate square, each coordinate is bounded by that norm. In the reverse direction, two coordinate halfwidths cannot silently be used as one Euclidean radius. The displayed L1 estimate is a simple rational-only conversion.

The exact-input zero branch is `p=0`, which forces `m=0` and preserves zero. More generally `m=0` occurs exactly when `-q <= 2*p*S < q`; a nonzero sufficiently small input may round to zero. This latter branch must retain its rounding-error witness and is not an assertion that the input is exactly zero.

## 4. Canonical odd mantissa and signed exponent

Use a representation `(a,e)` with integer mantissa and integer exponent, interpreted as the rational `a*2^e`. Start from `(m,-g)`.

* If `m=0`, return the single canonical pair `(0,0)`. Do not run a factor-of-two loop at zero.
* If `m!=0`, while `2` divides the current mantissa, replace `(a,e)` by `(a/2,e+1)` using exact integer division. Each step has the checkable identity `a=2*(a/2)`, so it preserves the interpreted rational value.
* At each nonzero divisible step, `natAbs(a/2)=natAbs(a)/2<natAbs(a)`. This proves termination for negative as well as positive mantissas. The terminal mantissa is nonzero and odd.

Equivalently, with `k` the number of successful steps, the witness is `m=a*2^k`, `k>=0`, `a` odd, and `e=k-g`. Checking these finite equalities is enough to establish value preservation; no valuation oracle is required. Negative odd integers satisfy the Euclidean remainder test `a % 2 = 1`.

This representation is unique: for two nonzero odd mantissas with equal values, clear the smaller of the two exponents. If the exponents differed, one odd integer would equal an even integer. The exponents and then the mantissas must agree. A positive terminal exponent is allowed. For example, a rounded integer divisible by two should not be forced to keep exponent zero. If a different format requires a nonnegative denominator exponent, it cannot in general also require an odd numerator for every nonzero integer; that is a different canonicalization contract.

Normalization is exact and incurs no second rounding error. Acceptance should first check (W) for the original grid mantissa `m`, then check the normalization identity. It must not interpret the normalized mantissa `a` as though it were still on the original `2^-g` grid.

## 5. Operand size is a separate ledger

The accepted bound below 2100 bits concerns denominators of exact expressions immediately before selected elementary gates. It is not a bound on the integers in (W), the quotient numerator, rational numerators, proof terms, or later moment/correction arithmetic.

For a transparent general bound, suppose `q<2^Q`, `abs(p)<2^P`, and `abs(m)<2^M`, with positive natural exponents as needed. Then

```
abs(2*p*S) < 2^(P+g+1),
abs((2*m-1)*q), abs((2*m+1)*q) < 2^(M+Q+1).
```

For the second line, integrality gives `abs(m)<=2^M-1`, hence `abs(2*m±1)<2^(M+1)`. Forming signed differences to implement comparisons may require another bit. Forming `2*p*S+q` for the quotient may also require another bit. A sign bit, word padding, and allocation overhead are additional representation choices. The parameter `Q` alone does not bound `P` or `M`; a magnitude bound or separate numerator bound is necessary.

As one concrete bound for the exponential affine gate, the accepted note gives a denominator of bit length at most 2090 and a raw absolute coordinate bound below 329. Thus

```
q < 2^2090,
abs(p) < 329*q < 2^2099,
abs(m) <= 329*2^1041+1/2 < 2^1050.
```

Each of the three integers being compared in (W) consequently has magnitude below `2^3141`; the difference-based comparison or shifted quotient numerator has a conservative bound below `2^3142`. These are sufficient bounds for this particular gate under its stated magnitude estimate, not observed maximum sizes or universal bounds for the entire pilot. Common powers of two can reduce actual sizes only when cancellation is separately proved sound.

The other accepted denominator bounds remain unchanged: log affine updates 1073 bits, Machin affine updates 1066 bits, and real squares/final products 2083 bits. Their rounding comparison ledgers should be derived from their own numerator/magnitude bounds using the same formulas; this note does not label those comparisons “2100-bit arithmetic.”

## 6. Source ledger and proposed proof path

All Mathlib paths in the following table are relative to the inspected checkout

`C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/`,

at pinned commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. Its `lean-toolchain` is `leanprover/lean4:v4.35.0`. The matching inspected core paths are relative to

`C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/`.

These are exact source declarations inspected, not claims that a new composed proof has elaborated.

| Source path and line | Declaration and role |
| --- | --- |
| `Mathlib/Algebra/Order/Round.lean:48` | Global `round`; its docstring explicitly specifies ties toward positive infinity. |
| `Mathlib/Algebra/Order/Round.lean:178` | Global `round_eq (x)`: `round x = floor(x+1/2)`. |
| `Mathlib/Algebra/Order/Round.lean:182` | Global `round_eq_iff`: membership in `[n-1/2,n+1/2)`. This is the shortest abstract route to (W). |
| `Mathlib/Algebra/Order/Round.lean:189` | `round_neg_two_inv`: rounding `-1/2` yields zero, confirming the signed tie convention. |
| `Mathlib/Algebra/Order/Round.lean:195` | `abs_sub_round`: absolute error at most `1/2`. Scaling by positive `S` gives the coordinate bound. |
| `Mathlib/Algebra/Order/Floor/Ring.lean:139` | `Int.floor_eq_iff`: `floor a=z` iff `(z:a)<=a` and `a<z+1`. Direct proof of witness equivalence. |
| `Mathlib/Data/Rat/Floor.lean:36` | The `FloorRing` instance on rationals. |
| `Mathlib/Data/Rat/Floor.lean:42` | `Rat.floor_def'`: generic floor on a rational equals `q.num / q.den` in integers. |
| `Mathlib/Data/Rat/Floor.lean:53` | `Rat.floor_intCast_div_natCast`: floor of an integer divided by a natural denominator equals integer Euclidean division. Applies to numerator `2*p*S+q`, denominator `2*q` after treating positive `q` as a natural. |
| `Mathlib/Data/Rat/Defs.lean:46` | `Rat.pos (a)`: `0<a.den`; no positivity hypothesis needs to be guessed for a canonical rational. |
| `Mathlib/Algebra/Ring/Int/Parity.lean:28` | `Int.odd_iff`: `Odd n` iff `n % 2=1`, including negative integers. |
| `Mathlib/Algebra/GroupWithZero/Basic.lean:507` | `zpow_add₀`: nonzero-base integer powers multiply under exponent addition; supports exact signed-exponent value preservation. |
| `Mathlib/Analysis/Complex/Norm.lean:183` | `Complex.norm_le_abs_re_add_abs_im`: rational L1 error bound for the two rounded coordinates. |
| Core `Init/Data/Rat/Basic.lean:55` | `Rat.den_pos`: positivity of canonical denominator. |
| Core `Init/Data/Rat/Lemmas.lean:562` | `Rat.divInt_eq_div`: the integer-pair rational constructor agrees with rational division. |
| Core `Init/Data/Int/DivMod/Bootstrap.lean:100` | `Int.emod_add_mul_ediv`: `a % b + b*(a/b)=a`. |
| Core `Init/Data/Int/DivMod/Bootstrap.lean:199,203` | `Int.emod_nonneg` for nonzero divisor, and `Int.emod_lt_of_pos` for positive divisor; establish the quotient/remainder witness even for negative `a`. |
| Core `Init/Data/Int/DivMod/Bootstrap.lean:309` | `Int.ediv_mul_cancel` under divisibility; justifies each exact mantissa-halving step. |
| Core `Init/Data/Int/DivMod/Lemmas.lean:872` | `Int.natAbs_ediv_of_dvd`; crucially divisibility removes the correction needed by general negative division. |
| Core `Init/Data/Nat/Div/Basic.lean:89` | `Nat.div_lt_self` under `0<n`, `1<k`; with `k=2` proves normalization termination. |

A minimal implementation path is: prove integer-witness soundness over rationals by positive-denominator multiplication; derive the real-coordinate statement by order-preserving rational casts; use the complex L1 theorem for the gate bound; prove the finite normalization identities separately. Abstract `round` and the producer quotient formula can then be proved equivalent to the same witness. The checker need not execute an abstract real floor.

The remaining work is a Lean implementation and checked connection to actual closed arithmetic receipts, including power construction, signed comparisons, exact quotient/normalization witnesses and every consuming gate. Source inspection and the paper derivation do not establish elaborated axiom closure or any pilot acceptance.
