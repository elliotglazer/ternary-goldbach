module

public import GammaBudget

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def invDisk (w : ℝ) : ℝ := (Real.log (10/Real.sqrt (9/4+w^2)))⁻¹

def rayCore (J d A W Y : ℝ) : ℝ :=
  let r := Real.exp (-(d*W))
  let u := (1-r)⁻¹
  Real.sqrt (2*π)*Real.exp (-(d*A))*invDisk (W/2)*u*(J+(11*W/Y)*r*u)

theorem ray_factored (q : ℕ) (z : ℂ) (dir A W Y : ℝ) :
    rayBound q z dir A W Y =
      rayCore (Real.log (BP q Y/0.355)) (π/2-dir*z.arg) A W Y / Real.sqrt ‖z‖ := by
  unfold rayBound rayCore invDisk
  simp only [div_eq_mul_inv, ← inv_pow]
  ring

theorem rayCore_box {j J d e A W Y : ℝ} (hj0 : 0 ≤ j) (hj : j ≤ J)
    (he : 0 < e) (hde : e ≤ d) (ha : 0 ≤ A) (hw : 0 < W) (hy : 0 < Y) (hK : 0 ≤ invDisk (W/2)) :
    rayCore j d A W Y ≤ rayCore J e A W Y := by
  let r := Real.exp (-(d*W))
  let R := Real.exp (-(e*W))
  have hA : Real.exp (-(d*A)) ≤ Real.exp (-(e*A)) :=
    Real.exp_le_exp.mpr (neg_le_neg (mul_le_mul_of_nonneg_right hde ha))
  have hrR : r ≤ R := Real.exp_le_exp.mpr (neg_le_neg (mul_le_mul_of_nonneg_right hde hw.le))
  have hR : R < 1 := Real.exp_lt_one_iff.mpr (neg_lt_zero.mpr (mul_pos he hw))
  have hu : (1-r)⁻¹ ≤ (1-R)⁻¹ := inv_anti₀ (by linarith) (by linarith)
  have hur : 0 ≤ (1-r)⁻¹ := inv_nonneg.mpr (by linarith)
  have hr : 0 ≤ r := (Real.exp_pos _).le
  have hV : 0 ≤ 11*W/Y := by positivity
  have hS := add_le_add hj (mul_le_mul (mul_le_mul_of_nonneg_left hrR hV) hu hur
    (mul_nonneg hV (Real.exp_pos _).le))
  have hSj : 0 ≤ j+11*W/Y*r*(1-r)⁻¹ := by positivity
  have hE := mul_le_mul_of_nonneg_left hA (Real.sqrt_nonneg (2*π))
  have hC := mul_le_mul_of_nonneg_right hE hK
  have hC0 : 0 ≤ Real.sqrt (2*π)*Real.exp (-(e*A))*invDisk (W/2) := by positivity
  exact mul_le_mul (mul_le_mul hC hu hur hC0) hS hSj (mul_nonneg hC0 (inv_nonneg.mpr (by linarith)))

#print axioms ray_factored
#print axioms rayCore_box
end GoldbachEnergy
