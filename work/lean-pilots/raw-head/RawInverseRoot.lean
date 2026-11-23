import Mathlib.Analysis.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-!
Soundness of the integer inverse-square-root certificate used to initialize
the raw-head power state. This file does not construct the integer candidate.
The scale is generic; the producer's initialization uses `S = 2 ^ 98`.
-/

namespace RawHead

/-- The two integer square comparisons force the candidate to be nonnegative. -/
theorem inverse_root_candidate_nonneg {x S : ℕ} {m : ℤ}
    (hlo : m * m * (x : ℤ) ≤ (S : ℤ) * (S : ℤ))
    (hhi : (S : ℤ) * (S : ℤ) < (m + 1) * (m + 1) * (x : ℤ)) :
    0 ≤ m := by
  by_contra hm
  have hm' : m ≤ -1 := Int.le_sub_one_of_lt (lt_of_not_ge hm)
  have hsq : (m + 1) * (m + 1) ≤ m * m := by
    nlinarith only [hm']
  have hx : (0 : ℤ) ≤ (x : ℤ) := by exact_mod_cast (Nat.zero_le x)
  have hmul := mul_le_mul_of_nonneg_right hsq hx
  exact (not_lt_of_ge hlo) (hhi.trans_le hmul)

/-- Checking the adjacent integer squares certifies a lower approximation to
the actual positive inverse square root, with error strictly below one grid step.
No square-root approximation or candidate-generation theorem is a premise. -/
theorem inverse_sqrt_sub_div_bounds {x S : ℕ} {m : ℤ}
    (hx : 0 < x) (hS : 0 < S)
    (hlo : m * m * (x : ℤ) ≤ (S : ℤ) * (S : ℤ))
    (hhi : (S : ℤ) * (S : ℤ) < (m + 1) * (m + 1) * (x : ℤ)) :
    0 ≤ (Real.sqrt (x : ℝ))⁻¹ - (m : ℝ) / (S : ℝ) ∧
      (Real.sqrt (x : ℝ))⁻¹ - (m : ℝ) / (S : ℝ) < 1 / (S : ℝ) := by
  have hm : 0 ≤ m := inverse_root_candidate_nonneg hlo hhi
  have hxR : (0 : ℝ) < (x : ℝ) := by exact_mod_cast hx
  have hSR : (0 : ℝ) < (S : ℝ) := by exact_mod_cast hS
  have hmR : (0 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hm1R : (0 : ℝ) ≤ (m : ℝ) + 1 := by linarith only [hmR]
  have hr : 0 < Real.sqrt (x : ℝ) := Real.sqrt_pos.mpr hxR
  have hloR : (m : ℝ) * (m : ℝ) * (x : ℝ) ≤ (S : ℝ) * (S : ℝ) := by
    exact_mod_cast hlo
  have hhiR : (S : ℝ) * (S : ℝ) <
      ((m : ℝ) + 1) * ((m : ℝ) + 1) * (x : ℝ) := by
    exact_mod_cast hhi
  have hprod_lo : (m : ℝ) * Real.sqrt (x : ℝ) ≤ (S : ℝ) := by
    apply le_of_sq_le_sq _ hSR.le
    rw [mul_pow, Real.sq_sqrt hxR.le]
    simpa only [pow_two] using hloR
  have hprod_hi : (S : ℝ) < ((m : ℝ) + 1) * Real.sqrt (x : ℝ) := by
    apply (sq_lt_sq₀ hSR.le (mul_nonneg hm1R hr.le)).mp
    rw [mul_pow, Real.sq_sqrt hxR.le]
    simpa only [pow_two] using hhiR
  have hlo_div : (m : ℝ) / (S : ℝ) ≤ (Real.sqrt (x : ℝ))⁻¹ := by
    have h : (m : ℝ) / (S : ℝ) ≤ 1 / Real.sqrt (x : ℝ) :=
      (div_le_div_iff₀ hSR hr).mpr (by simpa only [one_mul] using hprod_lo)
    simpa only [one_div] using h
  have hhi_div : (Real.sqrt (x : ℝ))⁻¹ < ((m : ℝ) + 1) / (S : ℝ) := by
    have h : 1 / Real.sqrt (x : ℝ) < ((m : ℝ) + 1) / (S : ℝ) :=
      (div_lt_div_iff₀ hr hSR).mpr (by simpa only [one_mul] using hprod_hi)
    simpa only [one_div] using h
  constructor
  · exact sub_nonneg.mpr hlo_div
  · rw [add_div] at hhi_div
    linarith only [hhi_div]

end RawHead
