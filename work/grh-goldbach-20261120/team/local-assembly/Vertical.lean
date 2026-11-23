import Assembly
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Analysis.Real.Pi.Bounds

namespace GrhGoldbach.LocalAssembly
open Real
noncomputable def verticalFactor (a b δ : ℝ) : ℝ :=
  (2 / log 2 + 4.8) * 82.6 * exp (δ ^ 2 / 8) *
    (exp (-(a / 2)) + exp (-(b / 2))) * (√(2 * π) / δ)

private theorem contourCoefficient_le :
    (2 / log 2 + 4.8) * 82.6 * √(2 * π) / (2 * π) ≤ 253.3 := by
  have hl := Real.log_two_gt_d9
  have hpi := Real.pi_gt_d6
  have hs : (2.5066 : ℝ) ≤ √(2 * π) := Real.le_sqrt_of_sq_le (by linarith only [hpi])
  have hp : 0 < √(2 * π) := by positivity
  have he : √(2 * π) / (2 * π) = 1 / √(2 * π) := by
    rw [div_eq_div_iff (by positivity) hp.ne', one_mul, Real.mul_self_sqrt (by positivity)]
  have hinv := one_div_le_one_div_of_le (by norm_num : (0:ℝ) < 2.5066) hs
  have hl' := div_le_div_of_nonneg_left (by norm_num : (0:ℝ) ≤ 2)
    (by norm_num : (0:ℝ) < 0.6931471803) hl.le
  rw [mul_div_assoc,he]
  calc
    _ ≤ (2/(0.6931471803:ℝ)+4.8)*82.6*(1/2.5066) := by gcongr
    _ ≤ _ := by norm_num

/-- Complete left-contour term, before any simplification by the caller.
`verticalFactor` has the defining body of the project's `Vg`. -/
theorem vertical_at_x {x : ℝ} (hx : 1e15 ≤ x) (hX : x ≤ 1e27) :
    x ^ (-(1/2):ℝ) * verticalFactor (-(12.6/√x)) (-(113.6/√x)) (2.8/√x) / (2*π) ≤ 255 := by
  have h0 : 0 < x := by linarith only [hx]
  have hv : 0 < √x := Real.sqrt_pos.2 h0
  have hs : x ^ (-(1/2):ℝ) = 1 / √x := by rw [Real.rpow_neg h0.le, ← Real.sqrt_eq_rpow, one_div]
  let C := (2 / log 2 + 4.8) * 82.6 * √(2 * π) / (2 * π)
  have hc : C ≤ 253.3 := contourCoefficient_le
  unfold verticalFactor
  rw [hs, show -(-(12.6/√x)/2)=6.3/√x by ring,
    show -(-(113.6/√x)/2)=56.8/√x by ring]
  calc
    _ = C * exp ((2.8/√x)^2/8) * (exp (6.3/√x) + exp (56.8/√x))/2.8 := by
      dsimp [C]
      field_simp
    _ ≤ 253.3 * exp ((2.8/√x)^2/8) * (exp (6.3/√x) + exp (56.8/√x))/2.8 := by gcongr
    _ ≤ _ := vertical_le (sqrt_range (by norm_num at hx ⊢; exact hx)
      (by norm_num at hX ⊢; exact hX)).1

#print axioms vertical_at_x
end GrhGoldbach.LocalAssembly
