import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped Real

namespace TernaryGoldbach.Explicit

/-- The far-asymptotic budget absorbs even a coarse QRH low-zero constant. -/
theorem qrh24_low_exp_absorb {L : ℝ} (hL : 35000 ≤ L) :
    1e24 * Real.exp (23 * L / 24) ≤ 5e-5 * Real.exp L / L ^ 3 := by
  have hL0 : 0 < L := by linarith
  have hL3 : 0 < L ^ 3 := by positivity
  have hLower : 2e28 * L ^ 3 ≤ Real.exp (L / 24) := by
    have hExp := Real.pow_div_factorial_le_exp (x := L / 24) (by positivity) 20
    have hPow : 35000 ^ 17 ≤ L ^ 17 :=
      pow_le_pow_left₀ (by norm_num) hL 17
    have hFactor : 2e28 * (Nat.factorial 20) * 24 ^ 20 ≤ (35000 : ℝ) ^ 17 := by
      norm_num [Nat.factorial]
    have hPoly : 2e28 * L ^ 3 ≤ (L / 24) ^ 20 / Nat.factorial 20 := by
      rw [le_div_iff₀ (by positivity)]
      have hProduct := mul_le_mul_of_nonneg_left (hFactor.trans hPow) hL3.le
      have hIdentity : (L / 24) ^ 20 = L ^ 3 * L ^ 17 / 24 ^ 20 := by ring
      rw [hIdentity]
      rw [le_div_iff₀ (by norm_num)]
      nlinarith only [hProduct]
    exact hPoly.trans hExp
  rw [le_div_iff₀ hL3]
  have hProduct := mul_le_mul_of_nonneg_left hLower
    (Real.exp_pos (23 * L / 24)).le
  have hExp : Real.exp (23 * L / 24) * Real.exp (L / 24) = Real.exp L := by
    rw [← Real.exp_add]
    congr 1
    ring
  rw [hExp] at hProduct
  nlinarith only [hProduct]

/-- The low-zero budget in the variable used by the explicit formula. -/
theorem qrh24_low_rpow_absorb {x : ℝ} (hx : Real.exp 35000 ≤ x) :
    1e24 * x ^ (23 / 24 : ℝ) ≤ 5e-5 * x / Real.log x ^ 3 := by
  have hx0 : 0 < x := lt_of_lt_of_le (Real.exp_pos _) hx
  have hL : 35000 ≤ Real.log x := (Real.le_log_iff_exp_le hx0).2 hx
  have h := qrh24_low_exp_absorb hL
  rw [Real.exp_log hx0] at h
  have hpow : x ^ (23 / 24 : ℝ) = Real.exp (23 * Real.log x / 24) := by
    rw [Real.rpow_def_of_pos hx0]
    congr 1
    ring
  rw [hpow]
  exact h

end TernaryGoldbach.Explicit



