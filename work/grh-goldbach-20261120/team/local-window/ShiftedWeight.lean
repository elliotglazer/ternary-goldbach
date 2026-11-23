import LocalWeight

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

