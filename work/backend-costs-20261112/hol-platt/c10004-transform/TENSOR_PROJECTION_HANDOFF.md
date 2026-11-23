# Tensor projection proof candidate

2026-11-13. `C10004TensorProjectionScript.sml` is a separate, source-only HOL proof candidate. No HOL build or numerical evaluation was run. None of the declarations below is claimed proved until the parent builds the theory successfully. The original transform and missing-theorem files were read only.

Frozen dependencies received from the transform author and rehashed locally:

* `C10004TransformScript.sml`: `F352C75345C809D7BD019DF3959C4984F216AF09E644C1D777F793F52CB56440`.
* `MISSING_THEOREMS.md`: `E94D9AB07B167B92242EF3940C2DBD078022B3B1AC46C4DE5EB1152C41F1C2D9`.

The final requested declaration is:

```
!cache xs. LENGTH xs = 4800 ==>
  tx_tensor_selected cache xs = tx_project (tx_tensor_full cache xs)
```

The script proposes proving a stronger unconditional equality first. This is mathematically justified because the input lookups on both sides are identical total `tx_pair` calls. No input lookup is replaced by an in-range EL fact. Every required bound concerns an intermediate GENLIST/flatten array, whose size is fixed independently of the input length. The requested length-qualified statement follows as a corollary.

## Proof structure

The first helper lemmas relate total `tx_pair`/`tx_row` to EL only within range, specialize this to GENLIST, prove total `tx_pair k (TL xs) = tx_pair (SUC k) xs`, and expose a flattened generated row after proving both required bounds. The TL identity also holds on the empty list because both sides use the same zero default.

Four proof-side definitions name the exact original full/selected arrays after axis2 and axis40. They are not new output specifications. The two expansion lemmas recover the original full/selected final arrays by unfolding these names.

The three substantive stage invariants are:

1. For `j < 2400`, selected-axis2 position `j` equals full-axis2 position `2*j+1`.
2. For `j61 < 60` and `k41 < 39`, selected-axis40 position `39*j61+k41` equals full-axis40 position `(2*j61+1)*40+(k41+1)`.
3. For `k41 < 39` and `k61 < 59`, selected final position `59*k41+k61` equals full final position `(2*(k41+1)+1)*60+(k61+1)`.

At each transition, GENLIST extensionality proves the entire next input line equal before applying the same line transform. `tx_omit_projection` supplies the omitted-output shift. Explicit natural arithmetic side goals establish every flattened lookup bound and constant-width quotient/remainder identity. Finally, list extensionality and `x = 59*(x DIV 59) + x MOD 59` identify the stage3 invariant with the actual `tx_project` indexing formula.

This proof uses no analytic root fact, no correctness assumption about cache entries, no associativity of rounded transforms, no copied numerical input, and no testing-based equality premise. It compares the same local transform applied to equal line lists. Consequently it remains a reference-level theorem even if a later implementation replaces repeated global linear lookups by efficient row/transpose operations. That implementation would need its own refinement theorem.

## Remaining build obligations

The candidate uses the actual HOL list interfaces `LIST_EQ`, `GENLIST_EQ`, `EL_GENLIST`, `EL`, and `TL`, checked against `src/list/src/listScript.sml`. It uses `intLib.ARITH_TAC` for fixed-numeral natural quotient/remainder arithmetic. No tactics or theorem names were tested by executing HOL. The first build may expose normal tactic normalization or arithmetic preprocessing failures; these must be repaired as proof steps, not replaced by assumptions or evaluation of thousands of data values.

In particular, the parent should check the generic lookup inductions first, then the three stage invariants, then the final extensionality step. The source includes complete proof attempts for all helpers and the target, but all remain unbuilt candidates. There are no axioms, admissions, theorem-producing oracle calls, or result-shaped hypotheses. The original transform theory must itself build before this dependent theory can be checked.

No source-specific character interpretation, numerical-error theorem or full transform correctness theorem follows from projection alone. Those separate items in `MISSING_THEOREMS.md` remain open.
