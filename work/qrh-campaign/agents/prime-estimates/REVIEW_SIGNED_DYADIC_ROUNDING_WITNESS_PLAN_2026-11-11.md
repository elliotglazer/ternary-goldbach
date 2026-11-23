# Review of signed dyadic rounding witnesses

2026-11-11. **PASS as a paper derivation and source-interface plan.** No mathematical or cited-API correction is required. This review contains no Lean declaration, execution, evaluator call, numerical test or build. It used document/source reads, hashes and direct algebra. The rounding and normalization lemmas, their closed witness acceptance and their attachment to the pilot remain unimplemented.

## Frozen inputs

Reviewed `moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md`, SHA256 `EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B`.

The three referenced inputs were rehashed and match the note:

| Input, relative to the campaign agents directory | SHA256 |
|---|---|
| `major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md` | `60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9` |
| `zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md` | `E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B` |
| `major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2` |

This does not independently accept a future pilot or any of its proposed coefficient boxes.

## Floor witness and signed cases

For integer p, positive integer q, natural g and S=2^g, positivity of both q and S permits every multiplication and division used in the proof. The pair of integer comparisons

`(2m-1)q <= 2pS < (2m+1)q`

is equivalent to `m<=pS/q+1/2<m+1`. It is therefore necessary and sufficient for the unique value `m=floor(pS/q+1/2)`. No reduction of p/q is needed. The equivalent quotient/remainder certificate has numerator `2pS+q`, positive denominator `2q`, and remainder in `[0,2q)`. Lean's Euclidean integer quotient has exactly this convention for a positive denominator, including negative numerators. Truncation toward zero would not suffice.

The lower boundary is included and the upper boundary excluded. Thus scaled half-integers round toward positive infinity: 1/2 maps to 1, -1/2 to 0, and -3/2 to -1. This is not a tie-to-even or sign-symmetric rule. Replacing the strict upper comparison by a weak one would lose uniqueness at a tie.

Subtracting the input from the output yields precisely

`-1/(2S) < m/S-p/q <= 1/(2S)`.

The orientation of the strict endpoint in the author note is correct. The zero output criterion is `-q<=2pS<q`. Consequently exact input zero is preserved, but a zero rounded result does not imply that the input was zero. The latter still needs its rounding-error witness.

## Complex error and canonicalization

Applying the coordinate bound separately and then the complex L1 inequality gives norm error at most 1/S. The sharper sqrt(2)/(2S) is also valid but is not needed by the checker. For g=1041 the L1 bound is delta/2, below the allocated delta=2^-1040. For g=1025 the real bound is eta/4 and the complex L1 bound eta/2, fitting the existing real eta/2 and complex eta allowances. This supplies margin; it does not authorize enlarging other errors or changing the consumer's fixed grid.

Canonicalization is a separate exact operation. For a nonzero even integer a, divisibility ensures the Euclidean quotient a/2 is the exact half, even when a is negative. Its natural absolute value is `natAbs(a)/2`, strictly less than `natAbs(a)`. The quotient remains nonzero, since otherwise the exact multiplication identity would force a=0. The zero case must bypass the loop; repeatedly halving zero would not terminate by this argument.

Each step preserves `a*2^e`; after k steps the finite witness is `m=a*2^k`, with odd a and signed exponent `e=k-g`. In a future implementation this subtraction is in integers, not truncated natural subtraction. Negative odd integers have Euclidean remainder one modulo two. The zero canonical pair is uniquely `(0,0)`.

For two nonzero odd-mantissa representations of the same rational, cancel the smaller signed exponent. If the exponents differ, one odd integer equals an integer multiple of two, a contradiction. The exponents, and then the mantissas, coincide. This proves the claimed uniqueness, including positive terminal exponents. A format with only a nonnegative denominator exponent is a different contract and cannot force an odd numerator for every nonzero integer.

The normalization witness must follow the original-grid witness. Treating the normalized mantissa as though it were still scaled by 2^-g would change the value. No new rounding error is incurred by normalization itself.

## Source audit

I read the cited declarations at Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679` and the installed Lean 4.35.0 source. The Mathlib `lean-toolchain` names `leanprover/lean4:v4.35.0`.

* Global `round` has the documented positive-infinity tie convention. `round_eq` and `round_eq_iff` give the precise floor and half-open interval identities. `round_neg_two_inv` and `abs_sub_round` match the signed example and error bound.
* `Int.floor_eq_iff`, the rational `FloorRing` instance, `Rat.floor_def'` and `Rat.floor_intCast_div_natCast` supply the claimed rational floor route. The last theorem takes a natural denominator; the positive integer 2q must first be identified with its natural cast. The note explicitly accounts for that conversion.
* `Rat.pos` and core `Rat.den_pos` prove positivity of canonical rational denominators. Core `Rat.divInt_eq_div` is in namespace Rat and identifies the integer-pair constructor with rational division, not integer division.
* `Int.emod_add_mul_ediv`, `Int.emod_nonneg` and `Int.emod_lt_of_pos` supply the required signed quotient/remainder laws. `Int.ediv_mul_cancel` requires divisibility; that premise is indispensable for exact halving.
* `Int.natAbs_ediv_of_dvd` has precisely the divisibility condition needed to avoid the correction in general negative Euclidean division. `Nat.div_lt_self` requires positive dividend and divisor greater than one; both hold at a nonzero even step with divisor two.
* `Int.odd_iff`, `zpow_add₀` with nonzero base two, and `Complex.norm_le_abs_re_add_abs_im` have the stated roles. The source line references in the author table match the inspected files.

The source files read have these hashes. Mathlib paths use the pinned checkout cited in the author note; core paths use its Lean 4.35.0 source root.

| File | SHA256 |
|---|---|
| `Mathlib/Algebra/Order/Round.lean` | `3A6A91543BE527D1F34D3E6B288CDABD5C23DEEEA33E0CCA21F7287E959F22D5` |
| `Mathlib/Algebra/Order/Floor/Ring.lean` | `04D0DF7A9A53A67887C6AAE63635D966510E8B2E4EB7FCD29F0275FA9A0869EF` |
| `Mathlib/Data/Rat/Floor.lean` | `2C02C24F90ABABD06D4DE70FE67EB1C00F8F82C97780B93B46BC7488BA497A6A` |
| `Mathlib/Data/Rat/Defs.lean` | `F6572BFD415B0EF5476D71A3058BE0D3DF26C6662C8E8C6C5A73E211209CE0B8` |
| `Mathlib/Algebra/Ring/Int/Parity.lean` | `0DC6794E9880932D71939F8D3E7617D99F332F1E4CDB119FF506FBAFED2E1F12` |
| `Mathlib/Algebra/GroupWithZero/Basic.lean` | `166B6136D5DD3DDC44735AE89B9DA5D7BB4F60EFF6ACE1D32AD3DC1DF5EE3099` |
| `Mathlib/Analysis/Complex/Norm.lean` | `0019DD1B210B43B387750C988259802DAE5C1CDC0417E039DD0670C97C9B7832` |
| `Init/Data/Rat/Basic.lean` | `30B77EA0918AA986F6617BEF4AD99A8D79CD538A714C9F05134BCB6A5E490CC8` |
| `Init/Data/Rat/Lemmas.lean` | `FB4134A5287F2ECE513F686633599ECFCAB42E78893FD32F3C9A721B1346B401` |
| `Init/Data/Int/DivMod/Bootstrap.lean` | `BD55B51820DBC53925D34190FCB5DE38AFC5D6B3528759101FE6DA87973026C1` |
| `Init/Data/Int/DivMod/Lemmas.lean` | `3675FF5212781C8B30E8E3B780E95AA31D6842EBD26A96D79F776C147E0CD32F` |
| `Init/Data/Nat/Div/Basic.lean` | `0C8FC51180B0D4FB6319E8A44ACD7999F3A1B3AAD21D8DA5C0AD575914F9D120` |

These are source/interface checks, not elaboration or a transitive axiom audit of new theorems.

## Operand-size audit and limits

For `abs(p)<2^P`, multiplication by 2S gives `abs(2pS)<2^(P+g+1)`. Integrality of m strengthens `abs(m)<2^M` to `abs(m)<=2^M-1`, so `abs(2m+/-1)<2^(M+1)`. Multiplying by `q<2^Q` gives the other two comparison bounds `2^(M+Q+1)`. Subtracting operands for a comparison may add one bit. A denominator bound alone cannot give P or M.

The cited inner-allocation note does supply the particular prerequisites used here: pre-gate denominator bit length at most 2090 and a raw absolute coordinate below 329 for the exponential affine update. They imply `abs(p)<2^2099` and, on grid g=1041, `abs(m)<2^1050`. Thus both exponent sums are 3141: `2099+1041+1` and `1050+2090+1`. A difference-based comparison or shifted quotient numerator has the conservative bound below 2^3142. The arithmetic is correct and is explicitly local to this gate.

The other denominator limits 1073,1066,2083 bits are retained as denominator limits only. They are not silently promoted to bounds for all cross-products, rational numerators, proof terms or the whole pilot. Even the 3142-bit bound does not include a chosen sign representation, word padding, allocation overhead or runtime. No performance claim follows from it.

The remaining work is to implement the witnesses, prove their rational/real/complex soundness, enforce the consumer's fixed grid and inputs, and obtain closed acceptance proofs for actual records. None of that is established by this paper PASS.
