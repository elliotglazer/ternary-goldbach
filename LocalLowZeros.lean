module

public import ShiftedWeight
public import LocalMellin
public import DensityBound
public import WeilWeightedRH
public import TernaryGoldbach.Explicit.WeilNumC

@[expose] public section


/-! The localized low-zero estimate. The zero sum uses the multiplicity of
the analytic divisor on the same rectangle as the explicit formula. -/

open Complex MeasureTheory Set Finset
open scoped Real Interval Topology
open GrhGoldbach.LocalWindow

namespace TernaryGoldbach.Explicit


private theorem localized_density {t : ℝ} (ht : |t| ≤ 2e14 + 13) :
    PhiUp 0.173 2 20 13 t / KRB 0.173 2 13 ≤ 5.5 := by
  have hKK : K0 0.173 13 ≤ KRB 0.173 2 13 :=
    KRB_ge (by norm_num) (by norm_num) (by norm_num)
  have h := (PhiUp_div_le (by norm_num) (by norm_num) (by norm_num) kB_pos hKK t).trans
    (PsiB_le_PsiG (by norm_num) p0_le kap1_le kap0_le (abs_nonneg t))
  exact h.trans (by simpa only [PsiG, smallT, sub_eq_add_neg] using density_le (abs_nonneg t) ht)


/-- Uniform localized low-zero bound for the Gaussian prime sum. -/
theorem localized_low_zeros_lt (hRH : RiemannHypothesis) {x : ℝ}
    (hx : 1e15 ≤ x) (hX : x ≤ 1e27) (T : ℝ) :
    let v := √x
    let a := -(12.6 / v)
    let w := 101 / v
    let δ := 2.8 / v
    v * (∑ u ∈ (zerosRectD zetaF T).filter (fun u => |u.im| ≤ 2e14),
      (multRectD zetaF T u : ℝ) * ‖Mg a (a-w) δ u‖) < 98.977 * v := by
  set v := √x with hv
  set a := -(12.6 / v) with ha
  set w := 101 / v with hw
  set δ := 2.8 / v with hδ
  have hv0 : 0 < v := Real.sqrt_pos.2 (by linarith)
  have hvlo : 30000000 ≤ v := Real.le_sqrt_of_sq_le (by linarith only [hx])
  have hvhi : v ≤ 4e13 := (Real.sqrt_le_left (by norm_num)).2 (by linarith only [hX])
  have hw0 : 0 < w := by dsimp [w]; positivity
  have hK : 0 < KRB 0.173 2 13 :=
    lt_of_lt_of_le (mul_pos (by norm_num) kB_pos) (KRB_ge (by norm_num) (by norm_num) (by norm_num))
  let G := fun t : ℝ => weight w δ (max 0 (|t| - 13))
  let Φ := PhiUp 0.173 2 20 13
  have hGc : Continuous G := (weight_continuous hw0 δ).comp (continuous_const.max (continuous_abs.sub continuous_const))
  have hΦc : Continuous Φ := continuous_PhiUp _ _ _ _
  have hW := weil_weightedH_of_rh (ℓ := 0.173) (by norm_num) (by norm_num) (m := 2) (by norm_num)
    exp_692_lt (H := 5e14) (Y₁ := 2e14) hRH (by norm_num) (R := 13) (by norm_num) (by norm_num)
    (by norm_num) (weight_nonneg hw0 δ) (weight_antitone hw0 δ) (weight_continuous hw0 δ)
    hK hΦc (fun t _ => WPhi_le_PhiUp (by norm_num) (by norm_num) (by norm_num)
      (by norm_num) (by norm_num) t) T
  have hD : ((∫ t in (-(2e14+13:ℝ))..(2e14+13), G t * Φ t) / KRB 0.173 2 13) ≤
      5.5 * (∫ t in (-(2e14+13:ℝ))..(2e14+13), G t) := by
    rw [← intervalIntegral.integral_div, ← intervalIntegral.integral_const_mul]
    apply intervalIntegral.integral_mono_on (by norm_num) (((hGc.mul hΦc).div_const _).intervalIntegrable _ _)
      ((continuous_const.mul hGc).intervalIntegrable _ _)
    intro t ht
    change G t * Φ t / KRB 0.173 2 13 ≤ 5.5 * G t
    rw [mul_div_assoc, mul_comm (5.5:ℝ)]
    exact mul_le_mul_of_nonneg_left (localized_density (abs_le.2 ht)) (weight_nonneg hw0 δ _)
  set S := (zerosRectD zetaF T).filter (fun u => |u.im| ≤ 2e14)
  have hline : ∀ u ∈ S, u.re = 1/2 := by
    intro u hu
    obtain ⟨hr, him⟩ := Finset.mem_filter.1 hu
    obtain ⟨hz, h0, h1, -⟩ := zerosRectD_zetaF_strip hr
    exact rhBelow_of_full_rh hRH 2e14 u hz h0 h1 him
  apply multiplicity_sum_lt S (multRectD zetaF T) Complex.im (fun u => ‖Mg a (a-w) δ u‖) hvlo hvhi
  · intro u hu
    exact localized_mellin_integral_le hw0 (by dsimp [a]; exact neg_nonpos.mpr (by positivity)) (hline u hu)
  · exact hW.trans hD

end TernaryGoldbach.Explicit
