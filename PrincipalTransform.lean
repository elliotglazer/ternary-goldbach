module

public import LaplaceCube
public import TernaryGoldbach.CircleMethod

@[expose] public section


open MeasureTheory Filter Set Real TernaryGoldbach
open scoped FourierTransform Topology
noncomputable section
namespace GoldbachEnergy

def centralDen (a u : ℝ) : ℂ := (a:ℂ)-((2*π*u:ℝ):ℂ)*Complex.I

private def density (a : ℝ) : ℝ → ℂ :=
  (Ioi (0:ℝ)).indicator (fun t : ℝ => (t:ℂ)^2 * Complex.exp ((-(a:ℂ))*t) / 2)

private theorem integrable_density {a : ℝ} (ha : 0<a) : Integrable (density a) := by
  apply (integrable_indicator_iff measurableSet_Ioi).mpr
  have h := integrable_power_decay 2 (z := -(a:ℂ)) (by simpa)
  exact h.div_const 2

private theorem norm_centralDen (a u : ℝ) :
    |a| ≤ ‖centralDen a u‖ ∧ 2*π*|u| ≤ ‖centralDen a u‖ := by
  exact ⟨by simpa [centralDen] using Complex.abs_re_le_norm (centralDen a u),
    by simpa [centralDen,abs_mul,abs_of_pos Real.pi_pos] using Complex.abs_im_le_norm (centralDen a u)⟩

theorem integrable_invDen {a : ℝ} (ha : 0<a) :
    Integrable (fun u : ℝ => (1:ℂ)/(centralDen a u)^3) := by
  have hd (u : ℝ) : a ≤ ‖centralDen a u‖ := by simpa [abs_of_pos ha] using (norm_centralDen a u).1
  have hd0 (u : ℝ) : centralDen a u ≠ 0 := norm_pos_iff.mp (ha.trans_le (hd u))
  have hcont : Continuous (fun u : ℝ => (1:ℂ)/(centralDen a u)^3) := by
    unfold centralDen at *; fun_prop (disch := aesop)
  apply (integrable_inv_one_add_sq.const_mul (1/a^3+1/a)).mono' hcont.aestronglyMeasurable
  apply Eventually.of_forall
  intro u
  have hm := (norm_centralDen a u).2
  have huc : |u| ≤ ‖centralDen a u‖ := by
    calc |u| ≤ (2*π)*|u| := le_mul_of_one_le_left (abs_nonneg _) (by linarith [Real.pi_gt_three])
         _ ≤ _ := hm
  have hu : u^2 ≤ ‖centralDen a u‖^2 := by simpa using pow_le_pow_left₀ (abs_nonneg u) huc 2
  have h₁ : 1 ≤ (1/a^3)*‖centralDen a u‖^3 := by
    rw [one_div_mul_eq_div,le_div_iff₀ (by positivity)]
    simpa using pow_le_pow_left₀ ha.le (hd u) 3
  have h₂ : u^2 ≤ (1/a)*‖centralDen a u‖^3 := by
    rw [one_div_mul_eq_div,le_div_iff₀ ha]
    calc _ ≤ ‖centralDen a u‖^2 * ‖centralDen a u‖ := mul_le_mul hu (hd u) ha.le (sq_nonneg _)
         _ = _ := by ring
  simp only [norm_div, norm_one,norm_pow]
  rw [← div_eq_mul_inv,div_le_div_iff₀ (pow_pos (ha.trans_le (hd u)) _) (by positivity)]
  linarith only [h₁,h₂]

private theorem transform_density {a : ℝ} (ha : 0<a) (u : ℝ) :
    𝓕⁻ (density a) u = 1 / centralDen a u ^ 3 := by
  rw [Real.fourierInv_eq_fourier_neg,Real.fourier_real_eq_integral_exp_smul]
  simp only [smul_eq_mul]
  let z := -centralDen a u
  have hz : z.re < 0 := by simpa [z,centralDen]
  have he : (fun t : ℝ => Complex.exp ((↑(-2*π*t*(-u)):ℂ)*Complex.I) * density a t) =
      (Ioi (0:ℝ)).indicator (fun t : ℝ => (t:ℂ)^2 * Complex.exp (z*t) / 2) := by
    funext t
    by_cases ht : t ∈ Ioi (0:ℝ)
    · simp only [density, indicator_of_mem ht]
      rw [mul_div_assoc', mul_left_comm, ← Complex.exp_add]
      congr 3
      dsimp [z,centralDen]; push_cast; ring
    · simp [density, indicator_of_notMem ht]
  rw [he,integral_indicator measurableSet_Ioi, integral_div,laplace_square hz]
  dsimp [z]; ring

/-- Full-line Fourier coefficient of the cubic reciprocal used on each central arc. -/
theorem central_integral {a y : ℝ} (ha : 0<a) (hy : 0<y) :
    (∫ u : ℝ, (1/centralDen a u^3) * e (-y*u)) =
      (y:ℂ)^2 * Complex.exp (-(a:ℂ)*y) / 2 := by
  have hi : Integrable (𝓕⁻ (density a)) := by
    simpa only [funext (transform_density ha)] using integrable_invDen ha
  have hc : ContinuousAt (density a) y := by
    apply ContinuousAt.congr_of_eventuallyEq (f := fun t : ℝ => (t:ℂ)^2 * Complex.exp ((-(a:ℂ))*t) / 2)
      (by fun_prop)
    filter_upwards [Ioi_mem_nhds hy] with t ht using indicator_of_mem ht _
  have hforward : Integrable (𝓕 (density a)) := by
    simpa only [Real.fourierInv_eq_fourier_neg,neg_neg] using hi.comp_neg
  have h := (integrable_density ha).fourier_fourierInv_eq hforward hc
  have hv : density a y = (y:ℂ)^2 * Complex.exp (-(a:ℂ)*y) / 2 :=
    indicator_of_mem (show y ∈ Ioi (0:ℝ) from hy) _
  rw [Real.fourier_real_eq_integral_exp_smul,hv] at h
  convert h using 1
  apply integral_congr_ae
  filter_upwards with u
  rw [transform_density ha,smul_eq_mul,mul_comm]
  congr 2
  unfold e
  push_cast
  ring

#print axioms central_integral
end GoldbachEnergy
