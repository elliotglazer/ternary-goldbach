module

public import RectProfile

@[expose] public section


open Real Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

theorem top_nonneg_on_box (Q m : ℕ) [NeZero Q] {h W l r : ℝ} (hh : 0 ≤ h) (h9 : m*h ≤ 9)
    (hw : 0 < W ∧ W ≤ 18) (hl : 0 ≤ l) (hr : 0 ≤ r) : 0 ≤ boxTopAt Q m h W l r := by
  have hA : 0 ≤ (m:ℝ)*h := by positivity
  have hstep := disk_nonneg (by linarith : (0:ℝ) ≤ W/2) (by linarith only [hw.2] : W/2 ≤ 9)
  have hRay (d : ℝ) (hd : 0 < d) : 0 ≤ rayCore (logBP Q (anchorY (m*h) W d)) d (m*h) W (anchorY (m*h) W d) := by
    let y := anchorY (m*h) W d
    have hy : 0 ≤ y := (by linarith [hw.1] : 0 ≤ (m:ℝ)*h+W/2).trans (le_max_left _ _)
    have hj := logBP_nonneg Q y
    have he : 0 ≤ (1-Real.exp (-(d*W)))⁻¹ := inv_nonneg.mpr
      (sub_nonneg.mpr (Real.exp_le_one_iff.mpr (neg_nonpos.mpr (mul_nonneg hd.le hw.1.le))))
    change 0 ≤ rayCore (logBP Q y) d (m*h) W y
    unfold rayCore
    exact mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg (Real.sqrt_nonneg _) (Real.exp_pos _).le) hstep) he)
      (add_nonneg hj (mul_nonneg (mul_nonneg (div_nonneg (mul_nonneg (by norm_num) hw.1.le) hy) (Real.exp_pos _).le) he))
  have hc : 0 ≤ coreSum Q m h (twistAngle l) (twistAngle r) := by
    apply sum_nonneg; intro j hj
    have hi : ((j+1:ℕ):ℝ) ≤ m := by exact_mod_cast mem_range.mp hj
    have hrad := (mul_le_mul_of_nonneg_right hi hh).trans h9
    have hd := disk_nonneg (by positivity) hrad
    apply mul_nonneg (le_max_right _ _)
    unfold centerCount; rw [div_eq_mul_inv]
    exact mul_nonneg (logBP_nonneg Q 0) hd
  have hs : 0 < slowAngle r := by rw [slow_eq hr]; exact sub_pos.mpr (Real.arctan_lt_pi_div_two _)
  have ha : 0 ≤ twistAngle l := Real.arctan_nonneg.mpr (by positivity)
  exact add_nonneg (add_nonneg hc (hRay _ hs)) (hRay _ (by linarith [Real.pi_pos] : 0 < π/2+twistAngle l))

#print axioms top_nonneg_on_box
end GoldbachEnergy
