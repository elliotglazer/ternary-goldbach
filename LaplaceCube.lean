module

public import Mathlib.Analysis.Fourier.Inversion
public import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
public import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
public import Mathlib.Tactic

@[expose] public section


open Filter MeasureTheory Set Real
open scoped Topology FourierTransform
noncomputable section
namespace GoldbachEnergy

theorem integrable_power_decay (k : ℕ) {z : ℂ} (hz : z.re < 0) :
    IntegrableOn (fun t : ℝ => (t:ℂ)^k * Complex.exp (z*t)) (Ioi 0) := by
  have hh := integrableOn_rpow_mul_exp_neg_mul_rpow (p := 1) (s := (k:ℝ)) (b := -z.re)
    (by linarith [Nat.cast_nonneg (α := ℝ) k]) (by norm_num) (by linarith)
  apply (integrable_norm_iff (by fun_prop)).mp
  apply hh.congr_fun _ measurableSet_Ioi
  intro t ht
  change 0 < t at ht
  simp [Complex.norm_exp,Complex.mul_re,Real.rpow_natCast,abs_of_pos ht]

private theorem limit_power_decay (k : ℕ) {z : ℂ} (hz : z.re < 0) :
    Tendsto (fun t : ℝ => (t:ℂ)^k * Complex.exp (z*t)) atTop (𝓝 0) := by
  apply tendsto_zero_iff_norm_tendsto_zero.mpr
  have h := tendsto_rpow_mul_exp_neg_mul_atTop_nhds_zero (k:ℝ) (-z.re) (by linarith)
  apply h.congr'
  filter_upwards [eventually_gt_atTop (0:ℝ)] with t ht
  simp [Complex.norm_exp,Complex.mul_re,Real.rpow_natCast,abs_of_pos ht]

/-- The complex Laplace transform of the quadratic on the positive half-line. -/
theorem laplace_square {z : ℂ} (hz : z.re < 0) :
    (∫ t : ℝ in Ioi 0, (t:ℂ)^2*Complex.exp (z*t)) = -2/z^3 := by
  have hz0 : z ≠ 0 := by rintro rfl; simpa using hz
  let F := fun t : ℂ => (t^2/z - 2*t/z^2 + 2/z^3)*Complex.exp (z*t)
  have hd (t : ℂ) : HasDerivAt F (t^2*Complex.exp (z*t)) t := by
    unfold F
    have h := (((((hasDerivAt_id t).pow 2).div_const z).sub
      (((hasDerivAt_id t).const_mul 2).div_const (z^2))).add_const (2/z^3)).mul
      ((Complex.hasDerivAt_exp _).comp t ((hasDerivAt_id t).const_mul z))
    change HasDerivAt (fun x : ℂ => (x^2/z - 2*x/z^2 + 2/z^3)*Complex.exp (z*x)) _ t
    apply h.congr_deriv
    dsimp
    field_simp [hz0] <;> ring
  have h₂ := (limit_power_decay 2 hz).div_const z
  have h₁ := ((limit_power_decay 1 hz).const_mul 2).div_const (z^2)
  have h₀ := (limit_power_decay 0 hz).const_mul (2/z^3)
  have ht : Tendsto (fun t : ℝ => F t) atTop (𝓝 0) := by
    convert (h₂.sub h₁).add h₀ using 1
    · ext t; dsimp [F]; ring
    · simp
  have h := integral_Ioi_of_hasDerivAt_of_tendsto'
    (f := fun t : ℝ => F t) (fun t _ => (hd t).comp_ofReal) (integrable_power_decay 2 hz) ht
  simpa [F,neg_div] using h

#print axioms laplace_square
end GoldbachEnergy
