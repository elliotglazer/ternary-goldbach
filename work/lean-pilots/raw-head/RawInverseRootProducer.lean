import RawInitialization
import Mathlib.Data.Nat.Sqrt

/-!
An internal alternative to supplying an inverse-root candidate as a literal.
The natural-number computation is total; its certificate and approximation
theorems below require a positive input. No runtime comparison is asserted.
-/

namespace RawHead

/-- Compute the integer lower inverse-root numerator at scale `S`.
Correctness as an inverse-root approximation requires `0 < x` and `0 < S`. -/
def inverseRootCandidate (x S : ℕ) : ℕ := Nat.sqrt ((S * S) / x)

/-- Integer division and natural square-root correctness supply both adjacent
square checks. No candidate certificate is assumed. -/
theorem inverseRootCandidate_certificate {x S : ℕ} (hx : 0 < x) :
    inverseRootCandidate x S * inverseRootCandidate x S * x ≤ S * S ∧
      S * S < (inverseRootCandidate x S + 1) *
        (inverseRootCandidate x S + 1) * x := by
  unfold inverseRootCandidate
  constructor
  · exact (Nat.le_div_iff_mul_le hx).mp (Nat.sqrt_le ((S * S) / x))
  · exact (Nat.div_lt_iff_lt_mul hx).mp (Nat.lt_succ_sqrt ((S * S) / x))

/-- The computed numerator supplies the integer certificate accepted by the
real inverse-root checker. -/
theorem inverseRootCandidate_int_certificate {x S : ℕ} (hx : 0 < x) :
    (inverseRootCandidate x S : ℤ) * (inverseRootCandidate x S : ℤ) *
        (x : ℤ) ≤ (S : ℤ) * (S : ℤ) ∧
      (S : ℤ) * (S : ℤ) < ((inverseRootCandidate x S : ℤ) + 1) *
        ((inverseRootCandidate x S : ℤ) + 1) * (x : ℤ) := by
  have h := inverseRootCandidate_certificate (S := S) hx
  constructor
  · exact_mod_cast h.1
  · exact_mod_cast h.2

/-- The generated numerator approximates the actual positive inverse square
root, with a one-sided error strictly below one scale step. -/
theorem inverseRootCandidate_error {x S : ℕ} (hx : 0 < x) (hS : 0 < S) :
    0 ≤ (Real.sqrt (x : ℝ))⁻¹ - (inverseRootCandidate x S : ℝ) / (S : ℝ) ∧
      (Real.sqrt (x : ℝ))⁻¹ - (inverseRootCandidate x S : ℝ) / (S : ℝ) <
        1 / (S : ℝ) := by
  have h := inverseRootCandidate_int_certificate (S := S) hx
  simpa only [Int.cast_natCast] using inverse_sqrt_sub_div_bounds hx hS h.1 h.2

/-- The internally generated real grid point initializes the actual complex
raw-head power at height zero. -/
theorem inverseRootCandidate_initialization_error {x S : ℕ}
    (hx : 0 < x) (hS : 0 < S) :
    ‖(((inverseRootCandidate x S : ℝ) / (S : ℝ) : ℝ) : ℂ) -
      integerPower (x : ℝ) 0‖ < 1 / (S : ℝ) := by
  have h := inverseRootCandidate_int_certificate (S := S) hx
  simpa only [Int.cast_natCast] using
    integerPower_zero_initialization_error hx hS h.1 h.2

end RawHead
