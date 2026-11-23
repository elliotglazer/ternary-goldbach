import RawExpInteger

/-!
Literal signed-integer complex multiplication for the persistent raw-head loop.
The left operand and output have grid S; the right operand has grid T.
The error theorem concerns the actual two `roundDiv` calls, not a supplied
rounding certificate. No time recurrence or analytic source is asserted here.
-/

namespace RawHead

/-- Four exact signed products followed by one nearest division per coordinate. -/
def mulStep (T : ℕ) (u v : ℤ × ℤ) : ℤ × ℤ :=
  (roundDiv (T : ℤ) (u.1 * v.1 - u.2 * v.2),
   roundDiv (T : ℤ) (u.1 * v.2 + u.2 * v.1))

/-- Exact coordinates of the product before the two output divisions. -/
lemma expIntegerValue_mul_coordinates {S T : ℕ} (hS : 0 < S) (hT : 0 < T)
    (u v : ℤ × ℤ) :
    expIntegerValue S u * expIntegerValue T v =
      (⟨((u.1 * v.1 - u.2 * v.2 : ℤ) : ℝ) / ((T : ℤ) : ℝ) / (S : ℝ),
        ((u.1 * v.2 + u.2 * v.1 : ℤ) : ℝ) / ((T : ℤ) : ℝ) / (S : ℝ)⟩ : ℂ) := by
  have hSR : (S : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hS)
  have hTR : (T : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hT)
  apply Complex.ext <;>
    simp [expIntegerValue, Complex.mul_re, Complex.mul_im] <;>
    field_simp [hSR, hTR]

/-- The actual stored multiplication has norm error at most one output ulp.
This follows from the two coordinate half-ulp bounds, with no sign restriction
on either pair of integer numerators. -/
theorem mulStep_error {S T : ℕ} (hS : 0 < S) (hT : 0 < T)
    (u v : ℤ × ℤ) :
    ‖expIntegerValue S (mulStep T u v) -
      expIntegerValue S u * expIntegerValue T v‖ ≤ 1 / (S : ℝ) := by
  let r : ℤ := u.1 * v.1 - u.2 * v.2
  let i : ℤ := u.1 * v.2 + u.2 * v.1
  have hTZ : (0 : ℤ) < T := by exact_mod_cast hT
  have hr := roundDiv_scaled_error (D := (T : ℤ)) (r := r) hS hTZ
  have hi := roundDiv_scaled_error (D := (T : ℤ)) (r := i) hS hTZ
  rw [expIntegerValue_mul_coordinates hS hT]
  change ‖(⟨(roundDiv (T : ℤ) r : ℝ) / (S : ℝ),
      (roundDiv (T : ℤ) i : ℝ) / (S : ℝ)⟩ : ℂ) -
      ⟨(r : ℝ) / ((T : ℤ) : ℝ) / (S : ℝ),
        (i : ℝ) / ((T : ℤ) : ℝ) / (S : ℝ)⟩‖ ≤ _
  calc
    _ ≤ |(roundDiv (T : ℤ) r : ℝ) / (S : ℝ) -
          (r : ℝ) / ((T : ℤ) : ℝ) / (S : ℝ)| +
        |(roundDiv (T : ℤ) i : ℝ) / (S : ℝ) -
          (i : ℝ) / ((T : ℤ) : ℝ) / (S : ℝ)| :=
      Complex.norm_le_abs_re_add_abs_im _
    _ ≤ 1 / (2 * (S : ℝ)) + 1 / (2 * (S : ℝ)) := add_le_add hr hi
    _ = 1 / (S : ℝ) := by ring

end RawHead
