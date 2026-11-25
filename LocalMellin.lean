module

/- Copyright 2026 Charlie Reams (two elementary Gaussian formulae, Apache-2.0). -/
public import LocalWeight

@[expose] public section


open Complex MeasureTheory Set
open scoped Interval

namespace GrhGoldbach.LocalWindow

private theorem norm_cexp_gauss (δ : ℝ) (s : ℂ) :
    ‖cexp ((δ : ℂ) ^ 2 * s ^ 2 / 2)‖ = Real.exp (δ ^ 2 * (s.re ^ 2 - s.im ^ 2) / 2) := by
  rw [Complex.norm_exp]; congr 1
  have : ((δ : ℂ) ^ 2 * s ^ 2 / 2) = ((δ ^ 2 / 2 : ℝ) : ℂ) * s ^ 2 := by push_cast; ring
  rw [this, Complex.re_ofReal_mul, sq s, Complex.mul_re]; ring

private theorem norm_intExp_le' {a b : ℝ} {s : ℂ} (hs : s ≠ 0) :
    ‖∫ w in b..a, cexp (s * w)‖ ≤ (Real.exp (a * s.re) + Real.exp (b * s.re)) / ‖s‖ := by
  rw [integral_exp_mul_complex hs, norm_div]
  apply div_le_div_of_nonneg_right _ (norm_nonneg _)
  refine (norm_sub_le _ _).trans (le_of_eq ?_)
  rw [Complex.norm_exp, Complex.norm_exp]
  congr 2 <;> simp [mul_comm]

theorem localized_mellin_integral_le {w a δ : ℝ} (hw : 0 < w) (ha : a ≤ 0)
    {s : ℂ} (hs : s.re = 1 / 2) :
    ‖cexp ((δ : ℂ) ^ 2 * s ^ 2 / 2) * ∫ t in (a-w)..a, cexp (s*t)‖ ≤ Real.exp (δ ^ 2 / 8) * weight w δ |s.im| := by
  have hab : a - w ≤ a := by linarith
  have hs0 : s ≠ 0 := by intro h; simp [h] at hs
  have hwidth : ‖∫ t in (a-w)..a, cexp (s*t)‖ ≤ w := by
    have h := intervalIntegral.norm_integral_le_of_norm_le_const
      (a := a-w) (b := a) (C := (1:ℝ)) (f := fun t : ℝ => cexp (s * t)) (fun t ht => by
        rw [uIoc_of_le hab] at ht
        simp only [Complex.norm_exp, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
          mul_zero, sub_zero, hs]
        exact Real.exp_le_one_iff.mpr (by linarith only [ht.2, ha]))
    simpa only [show a - (a-w) = w by ring, abs_of_pos hw, mul_one, one_mul] using h
  have hint : ‖∫ t in (a-w)..a, cexp (s*t)‖ ≤ 2 / max |s.im| (2 / w) := by
    by_cases h : |s.im| ≤ 2 / w
    · rw [max_eq_right h, show 2 / (2 / w) = w by field_simp]
      exact hwidth
    · have him : 0 < |s.im| := lt_trans (by positivity : (0:ℝ) < 2 / w) (lt_of_not_ge h)
      rw [max_eq_left (le_of_not_ge h)]
      have hq := norm_intExp_le' (a := a) (b := a-w) hs0
      rw [hs] at hq
      have h1 : Real.exp (a * (1/2)) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
      have h2 : Real.exp ((a-w) * (1/2)) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
      have hden := Complex.abs_im_le_norm s
      calc ‖∫ t in (a-w)..a, cexp (s*t)‖ ≤ _ := hq
        _ ≤ 2 / ‖s‖ := div_le_div_of_nonneg_right (by linarith only [h1,h2]) (norm_nonneg _)
        _ ≤ 2 / |s.im| := by
          exact div_le_div_of_nonneg_left (by norm_num) him hden
  have he : Real.exp (δ ^ 2 * (s.re ^ 2 - s.im ^ 2) / 2) =
      Real.exp (δ ^ 2 / 8) * Real.exp (-(δ ^ 2 * |s.im| ^ 2 / 2)) := by
    rw [← Real.exp_add, hs, sq_abs]
    congr 1
    ring
  rw [norm_mul, norm_cexp_gauss, he, weight, ← mul_assoc]
  exact mul_le_mul_of_nonneg_left hint (by positivity)

end GrhGoldbach.LocalWindow
