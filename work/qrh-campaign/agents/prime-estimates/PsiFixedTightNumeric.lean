import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace TernaryGoldbach.Explicit

/-- The tight local zero-count coefficient is negligible from exp(20000). -/
theorem fixed_tight_low_exp_absorb {L : ℝ} (hL : 20000 ≤ L) :
    3e10 * Real.exp (249 * L / 250) ≤ 6e-25 * Real.exp L := by
  have h80 : (5e34 : ℝ) ≤ Real.exp 80 := by
    have h : (2.7182818283 : ℝ) ^ 80 ≤ Real.exp 80 := by
      rw [← Real.exp_one_pow]
      exact pow_le_pow_left₀ (by norm_num) Real.exp_one_gt_d9.le 80
    norm_num at h ⊢
    linarith
  have hLower : (5e34 : ℝ) ≤ Real.exp (L / 250) :=
    h80.trans (Real.exp_le_exp.2 (by linarith))
  have hProduct := mul_le_mul_of_nonneg_left hLower
    (Real.exp_pos (249 * L / 250)).le
  have hExp : Real.exp (249 * L / 250) * Real.exp (L / 250) = Real.exp L := by
    rw [← Real.exp_add]
    congr 1
    ring
  rw [hExp] at hProduct
  nlinarith only [hProduct]

theorem fixed_tight_low_rpow_absorb {x : ℝ} (hx : Real.exp 20000 ≤ x) :
    3e10 * x ^ (249 / 250 : ℝ) ≤ 6e-25 * x := by
  have hx0 : 0 < x := lt_of_lt_of_le (Real.exp_pos _) hx
  have hL : 20000 ≤ Real.log x := (Real.le_log_iff_exp_le hx0).2 hx
  have h := fixed_tight_low_exp_absorb hL
  rw [Real.exp_log hx0] at h
  have hpow : x ^ (249 / 250 : ℝ) = Real.exp (249 * Real.log x / 250) := by
    rw [Real.rpow_def_of_pos hx0]
    congr 1
    ring
  rw [hpow]
  exact h

end TernaryGoldbach.Explicit

#print TernaryGoldbach.Explicit.fixed_tight_low_exp_absorb
#print axioms TernaryGoldbach.Explicit.fixed_tight_low_exp_absorb
#print TernaryGoldbach.Explicit.fixed_tight_low_rpow_absorb
#print axioms TernaryGoldbach.Explicit.fixed_tight_low_rpow_absorb
