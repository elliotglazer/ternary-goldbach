import RawDyadicProduct
import Mathlib.Tactic.Ring

/-!
An optional three-product implementation of the exact signed-integer step.
This does not change the four-product implementation used by the current test.

If the input coordinate magnitudes are bounded by U and V, the presums can
reach 2U and 2V and their product can reach 4UV. Independent triangle bounds
for the successive imaginary subtractions are 5UV and 6UV before using the
algebraic identity. A bounded-word implementation must pay these temporary
widths, signed additions, and the existing roundDiv numerator/divisor work.
The equality below licenses no unchecked overflow or intermediate rounding.
No runtime saving or optimality is asserted.
-/

namespace RawHead

/-- Three exact signed products, sharing their results, followed by the same
two output divisions as `mulStep`. -/
def mulStepThree (T : ℕ) (u v : ℤ × ℤ) : ℤ × ℤ :=
  let p := u.1 * v.1
  let q := u.2 * v.2
  let r := (u.1 + u.2) * (v.1 + v.2)
  (roundDiv (T : ℤ) (p - q), roundDiv (T : ℤ) (r - p - q))

/-- Exact output equality holds for all signed inputs and every natural scale.
At scale zero this is only equality of the total integer algorithms; the
approximation interpretation of `roundDiv` still requires a positive scale. -/
theorem mulStepThree_eq_mulStep (T : ℕ) (u v : ℤ × ℤ) :
    mulStepThree T u v = mulStep T u v := by
  have him : (u.1 + u.2) * (v.1 + v.2) - u.1 * v.1 - u.2 * v.2 =
      u.1 * v.2 + u.2 * v.1 := by ring
  unfold mulStepThree mulStep
  dsimp only
  rw [him]

end RawHead
