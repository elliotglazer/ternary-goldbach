import AuditWeight

/-! Localized weighting on the symmetric Weil-window integral. -/

open MeasureTheory Set
open scoped Interval

namespace GrhGoldbach.LocalWindow

private theorem integral_symm_abs {h : ℝ → ℝ} (hc : Continuous fun t => h |t|) (Y : ℝ) :
    ∫ t in (-Y)..Y, h |t| = 2 * ∫ t in (0 : ℝ)..Y, h |t| := by
  have hi : ∀ a b : ℝ, IntervalIntegrable (fun t => h |t|) volume a b := fun a b => hc.intervalIntegrable a b
  rw [← intervalIntegral.integral_add_adjacent_intervals (hi (-Y) 0) (hi 0 Y)]
  have h1 : ∫ t in (-Y)..0, h |t| = ∫ t in (0 : ℝ)..Y, h |t| := by
    have := intervalIntegral.integral_comp_neg (a := 0) (b := Y) (fun t => h |t|)
    simp only [abs_neg, neg_zero] at this
    exact this.symm
  rw [h1]; ring

theorem shifted_weight_integral {w δ Y : ℝ} (hw : 0 < w) (hδ : 0 < δ)
    (hcut : 2 / w ≤ 1 / δ) (hY : 1 / δ ≤ Y) :
    ∫ t in (-(Y + 13))..(Y + 13), weight w δ (max 0 (|t| - 13)) ≤
    2 * (13 * w + 2 + 2 * Real.log (w / (2 * δ)) + 2 * Real.exp (-(1 / 2))) := by
  have hY0 : 0 ≤ Y := le_trans (by positivity) hY
  let f := fun t : ℝ => weight w δ (max 0 (|t| - 13))
  have hf : Continuous f := (weight_continuous hw δ).comp (continuous_const.max (continuous_abs.sub continuous_const))
  have hi : ∀ a b : ℝ, IntervalIntegrable f volume a b := hf.intervalIntegrable
  have hs := integral_symm_abs (h := fun t : ℝ => weight w δ (max 0 (t-13))) hf (Y + 13)
  change (∫ t in (-(Y+13))..(Y+13), f t) = 2 * ∫ t in (0:ℝ)..(Y+13), f t at hs
  change (∫ t in (-(Y+13))..(Y+13), f t) ≤ _
  rw [hs, ← intervalIntegral.integral_add_adjacent_intervals (hi 0 13) (hi 13 (Y+13))]
  have hfirst : (∫ t in (0:ℝ)..13, f t) ≤ 13*w := by
    calc _ ≤ ∫ _t in (0:ℝ)..13, w :=
          intervalIntegral.integral_mono_on (by norm_num) (hi _ _) (continuous_const.intervalIntegrable _ _)
            (fun t _ => weight_le_width hw δ _)
      _ = _ := by simp
  have he : (∫ t in 13..(Y+13), f t) = (∫ t in (0:ℝ)..Y, weight w δ t) := by
    rw [← show (∫ t in (0:ℝ)..Y, f (t+13)) = ∫ t in 13..(Y+13), f t by
      simpa only [zero_add] using intervalIntegral.integral_comp_add_right f (a:=0) (b:=Y) 13]
    apply intervalIntegral.integral_congr
    intro t ht
    rw [uIcc_of_le hY0] at ht
    dsimp [f]
    rw [abs_of_nonneg (by linarith only [ht.1]), add_sub_cancel_right, max_eq_right ht.1]
  rw [he]
  linarith only [hfirst, integral_weight_le hw hδ hcut hY]

/-- Combine the localized Mellin majorant and the Weil bound on a finite
zero family. The multiplicity is preserved in every sum. -/
theorem multiplicity_sum_lt {ι : Type*} (S : Finset ι) (m : ι → ℕ) (y F : ι → ℝ)
    {v : ℝ} (hvlo : 30000000 ≤ v) (hvhi : v ≤ 4e13)
    (hF : ∀ u ∈ S, F u ≤ Real.exp ((2.8/v)^2/8) * weight (101/v) (2.8/v) |y u|)
    (hW : ∑ u ∈ S, (m u : ℝ) * weight (101/v) (2.8/v) |y u| ≤
      5.5 * ∫ t in (-(2e14+13 : ℝ))..(2e14+13), weight (101/v) (2.8/v) (max 0 (|t|-13))) :
    v * ∑ u ∈ S, (m u : ℝ) * F u < 98.977 * v := by
  have hv : 0 < v := by linarith only [hvlo]
  have hw : 0 < 101/v := by positivity
  have hδ : 0 < 2.8/v := by positivity
  have hcut : 2/(101/v) ≤ 1/(2.8/v) := by
    field_simp
    linarith only [hv]
  have hY : 1/(2.8/v) ≤ (2e14 : ℝ) := by
    field_simp
    linarith only [hvhi]
  have hratio : (101/v)/(2*(2.8/v)) = 101/5.6 := by field_simp; ring
  have hJ := shifted_weight_integral hw hδ hcut hY
  rw [hratio] at hJ
  have htotal := hW.trans (mul_le_mul_of_nonneg_left hJ (by norm_num : (0:ℝ) ≤ 5.5))
  have hS : ∑ u ∈ S, (m u : ℝ) * F u ≤
      Real.exp ((2.8/v)^2/8) * ∑ u ∈ S, (m u : ℝ) * weight (101/v) (2.8/v) |y u| := by
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun u hu => ?_
    rw [mul_left_comm (Real.exp _)]
    exact mul_le_mul_of_nonneg_left (hF u hu) (Nat.cast_nonneg _)
  have hr := hS.trans (mul_le_mul_of_nonneg_left htotal (Real.exp_pos _).le)
  have hs : Real.exp ((2.8/v)^2/8) *
      (5.5 * (2 * (13*(101/v)+2+2*Real.log (101/5.6)+2*Real.exp (-(1/2))))) < 98.977 := by
    convert line_coefficient_lt hvlo using 1
    ring
  simpa only [mul_comm (98.977:ℝ) v] using mul_lt_mul_of_pos_left (hr.trans_lt hs) hv

end GrhGoldbach.LocalWindow


/- Copyright 2026 Charlie Reams (two elementary Gaussian formulae, Apache-2.0). -/

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

#print axioms GrhGoldbach.LocalWindow.shifted_weight_integral
#print axioms GrhGoldbach.LocalWindow.localized_mellin_integral_le
#print axioms GrhGoldbach.LocalWindow.multiplicity_sum_lt
