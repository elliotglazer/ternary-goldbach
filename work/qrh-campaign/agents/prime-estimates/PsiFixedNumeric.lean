import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped Real

namespace TernaryGoldbach.Explicit

/-- The far-asymptotic budget absorbs even a coarse fixed-gap low-zero constant. -/
theorem fixed_low_exp_absorb {L : ℝ} (hL : 35000 ≤ L) :
    1e24 * Real.exp (249 * L / 250) ≤ 5e-5 * Real.exp L / L ^ 3 := by
  have hL0 : 0 < L := by linarith
  have hL3 : 0 < L ^ 3 := by positivity
  have hLower : 2e28 * L ^ 3 ≤ Real.exp (L / 250) := by
    have hExp := Real.pow_div_factorial_le_exp (x := L / 250) (by positivity) 50
    have hPow : 35000 ^ 47 ≤ L ^ 47 :=
      pow_le_pow_left₀ (by norm_num) hL 47
    have hFactor : 2e28 * (Nat.factorial 50) * 250 ^ 50 ≤ (35000 : ℝ) ^ 47 := by
      norm_num [Nat.factorial]
    have hPoly : 2e28 * L ^ 3 ≤ (L / 250) ^ 50 / Nat.factorial 50 := by
      rw [le_div_iff₀ (by positivity)]
      have hProduct := mul_le_mul_of_nonneg_left (hFactor.trans hPow) hL3.le
      have hIdentity : (L / 250) ^ 50 = L ^ 3 * L ^ 47 / 250 ^ 50 := by ring
      rw [hIdentity]
      rw [le_div_iff₀ (by norm_num)]
      nlinarith only [hProduct]
    exact hPoly.trans hExp
  rw [le_div_iff₀ hL3]
  have hProduct := mul_le_mul_of_nonneg_left hLower
    (Real.exp_pos (249 * L / 250)).le
  have hExp : Real.exp (249 * L / 250) * Real.exp (L / 250) = Real.exp L := by
    rw [← Real.exp_add]
    congr 1
    ring
  rw [hExp] at hProduct
  nlinarith only [hProduct]

/-- The low-zero budget in the variable used by the explicit formula. -/
theorem fixed_low_rpow_absorb {x : ℝ} (hx : Real.exp 35000 ≤ x) :
    1e24 * x ^ (249 / 250 : ℝ) ≤ 5e-5 * x / Real.log x ^ 3 := by
  have hx0 : 0 < x := lt_of_lt_of_le (Real.exp_pos _) hx
  have hL : 35000 ≤ Real.log x := (Real.le_log_iff_exp_le hx0).2 hx
  have h := fixed_low_exp_absorb hL
  rw [Real.exp_log hx0] at h
  have hpow : x ^ (249 / 250 : ℝ) = Real.exp (249 * Real.log x / 250) := by
    rw [Real.rpow_def_of_pos hx0]
    congr 1
    ring
  rw [hpow]
  exact h

end TernaryGoldbach.Explicit




