import Mathlib
open scoped Real
example : ((⌊(1e8 : ℝ) / 3.48⌋₊ : ℕ) : ℝ) + 1 ≤ 1e8 := by norm_num
example : (1 / 2 : ℝ) ≤ Real.log (10 / 2.7) := by
  rw [show (10 / 2.7 : ℝ) = (0.27 : ℝ)⁻¹ by norm_num, Real.log_inv]
  have h := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 0.27)
  linarith
example (S : Finset ℂ) (m : ℂ → ℝ) (a : ℝ) :
    (∑ u ∈ S, m u * a) = (∑ u ∈ S, m u) * a :=
  (Finset.sum_mul S m a).symm
example (S : Finset ℂ) (m : ℂ → ℝ) (a : ℝ) :
    (∑ u ∈ S, a * m u) = a * (∑ u ∈ S, m u) :=
  (Finset.mul_sum S m a).symm
