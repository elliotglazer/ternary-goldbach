import TernaryGoldbach.Explicit.PsiAsymp
import PsiFixedTightFormula
import PsiFixedNumeric
import QrhPsiMid

open Complex Set Filter MeasureTheory Finset
open scoped Real Interval Topology ArithmeticFunction.vonMangoldt

namespace TernaryGoldbach.Explicit

/-- The far-asymptotic psi bound from the local fixed zero-free gap. -/
theorem psi_asymp_fixed_tight {x : ℝ} (hx : Real.exp 35000 ≤ x) :
    |psiR x - x| ≤ 0.2 * x / Real.log x ^ 3 := by
  have hx0 : 0 < x := lt_of_lt_of_le (Real.exp_pos _) hx
  have hx1 : 1 < x := lt_of_lt_of_le
    (by have := Real.add_one_le_exp (35000 : ℝ); linarith) hx
  have hL : 35000 ≤ Real.log x := (Real.le_log_iff_exp_le hx0).2 hx
  apply psi_asymp_of hx
  intro a b δ Γ hδ hab hb hΓ hδa
  have h := tsum_gsm_le_fixed_tight hδ hab hb hx1 hΓ hδa
  have hLow : 3e10 * x ^ (249 / 250 : ℝ) ≤ 5e-5 * x / Real.log x ^ 3 :=
    (mul_le_mul_of_nonneg_right (by norm_num : (3e10 : ℝ) ≤ 1e24)
      (Real.rpow_nonneg hx0.le _)).trans (fixed_low_rpow_absorb hx)
  have hMid := mul_le_mul_of_nonneg_left (MidB0_8_asymp_half_le hδa hL) hx0.le
  have hZ : 0 ≤ ZLg BPz2 3e10 := by
    unfold ZLg
    exact div_nonneg (polyDatum_zeta2.log_pos _).le
      (log_ratio_pos (by norm_num) (by norm_num)).le
  have hJ : 0 ≤ Real.log (Jl 3e10) := by
    apply Real.log_nonneg
    unfold Jl
    norm_num
  have hLine : 0 ≤ √x * LineB a δ := by
    unfold LineB
    positivity
  have hMidEq : MidBH a δ 3e10 Γ x = MidB a δ Γ x := rfl
  rw [hMidEq] at h
  have hBudget : 5e-5 * x / Real.log x ^ 3 + x * (5e-5 / Real.log x ^ 3) =
      x * (1e-4 / Real.log x ^ 3) := by ring
  nlinarith only [h, hLow, hMid, hLine, hBudget]
end TernaryGoldbach.Explicit









