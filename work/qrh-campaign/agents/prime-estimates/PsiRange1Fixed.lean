import TernaryGoldbach.Explicit.PsiRange1
import PsiFixedTightFormula
import PsiFixedTightNumeric

open Complex Set Filter MeasureTheory Finset
open scoped Real Interval Topology ArithmeticFunction.vonMangoldt

namespace TernaryGoldbach.Explicit

/-- The original range1 error budget, obtained from the local fixed gap. -/
theorem psi_range1_err_fixed {x : ℝ} (hx : Real.exp 20000 ≤ x) (a : ℝ)
    (ha : |a| ≤ 1.26e-14) (hab : Real.log (1e10 / x) ≤ a) :
    |∑' n : ℕ, Λ n * gsm a (Real.log (1e10 / x)) 1.4e-15 (n / x) -
      Real.exp ((1.4e-15 : ℝ) ^ 2 / 2) * (Real.exp a - Real.exp (Real.log (1e10 / x))) * x| ≤
      14990 * √x + 7.61e-15 * x + 1e-17 * x + 1.82e12 := by
  have hx40 : 1e40 ≤ x := exp_20000_ge.trans hx
  have hx0 : 0 < x := by linarith
  have hx1 : 1 < x := by linarith
  have hlx : 20000 ≤ Real.log x := by rw [Real.le_log_iff_exp_le hx0]; exact hx
  set δ : ℝ := 1.4e-15 with hδ
  have hδ0 : 0 < δ := by norm_num [δ]
  have hb0 : Real.log (1e10 / x) ≤ -(1.26e-14) := by
    have := Real.log_le_sub_one_of_pos (show (0:ℝ) < 1e10 / x by positivity)
    have : 1e10 / x ≤ 1e-9 := by rw [div_le_iff₀ hx0]; linarith
    linarith
  have hδa : δ ^ 2 / 2 + |a| ≤ 1e-6 := by rw [hδ]; nlinarith [ha]
  have hT := tsum_gsm_le_fixed_tight hδ0 hab (hb0.trans (by norm_num)) hx1
    (show (3e12 : ℝ) ≤ 6.43e15 by norm_num) hδa
  have hLow := fixed_tight_low_rpow_absorb hx
  have h2 : MidBH a δ 3e10 6.43e15 x ≤ 7.6e-15 := by
    rw [hδ]; exact MidB_r1_le (a := a) (x := x) (by linarith) hlx
  have h2' : MidB0 a δ 1e8 3e10 x ≤ 1e-20 :=
    MidB0_8_le (by rw [hδ]; norm_num at ha ⊢; linarith) hlx
  have h3 : TailBG a δ 6.43e15 ≤ 1e-17 := by
    rw [hδ]; exact TailBG_r1_le (a := a) (by linarith)
  have h4 := Vg_le_gen (a := a) (δ := δ) (x := x) hδ0
    (by norm_num [δ]) (by linarith) (by linarith)
  have h4' : 2.54e-3 / δ ≤ 1.82e12 := by rw [hδ]; norm_num
  have e2 := mul_le_mul_of_nonneg_left (add_le_add h2' h2) hx0.le
  have e3 := mul_le_mul_of_nonneg_left h3 hx0.le
  have e4 := h4.trans h4'
  nlinarith only [hT, hLow, e2, e3, e4, hx0, Real.sqrt_nonneg x]

/-- The original range1 conclusion with no Platt premise. -/
theorem psi_range1_fixed {x : ℝ} (hx : Real.exp 20000 ≤ x) :
    |psiR x - x| ≤ 2.1e-14 * x :=
  psi_range1_of hx (psi_range1_err_fixed hx)

end TernaryGoldbach.Explicit

