module

public import ZeroRay
public import LeftWeight
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds

@[expose] public section


open Real Complex TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

/-- Uniform on the full twist line, including arbitrarily small angular gaps. -/
theorem inverse_norm_le_gap (δ : ℝ) : 1/‖twistRate δ‖ ≤ gapAngle (twistRate δ) := by
  have hre : 0 < (twistRate δ).re := by simp [twistRate]
  have hz : twistRate δ ≠ 0 := by intro h; rw [h] at hre; simp at hre
  have hd : 0 ≤ gapAngle (twistRate δ) := (sub_pos.mpr (Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl hre))).le
  have hh := Real.sin_le hd
  unfold gapAngle at hh; rw [Real.sin_pi_div_two_sub,Real.cos_abs,Complex.cos_arg hz] at hh
  simpa only [gapAngle,twistRate,Complex.sub_re,Complex.one_re,Complex.mul_re,Complex.I_re,Complex.ofReal_im,
    mul_zero,zero_mul,sub_zero] using hh

theorem geometric_ratio_le {x : ℝ} (hx : 0 < x) : Real.exp (-x)/(1-Real.exp (-x)) ≤ 1/x := by
  have h : 0 < 1-Real.exp (-x) := sub_pos.mpr (Real.exp_lt_one_iff.mpr (by linarith))
  rw [div_le_div_iff₀ h hx]
  have h₁ := Real.add_one_le_exp x
  have h₂ := mul_le_mul_of_nonneg_right h₁ (Real.exp_pos (-x)).le
  rw [← Real.exp_add, add_neg_cancel, Real.exp_zero] at h₂
  linarith

/-- A single elementary upper bound replaces both geometric sums when Y*d >= 1. -/
theorem ray_simple {q : ℕ} [NeZero q] (z : ℂ) (dir A W Y : ℝ)
    (hd : 0 < π/2-dir*z.arg) (hW : 0<W) (hW' : W≤18) (hA : 0≤A)
    (hY : 1 ≤ Y*(π/2-dir*z.arg)) :
    rayBound q z dir A W Y ≤
      (Real.sqrt (2*π)/Real.sqrt ‖z‖/Real.log (10/Real.sqrt (9/4+(W/2)^2)))*
      (Real.log (BP q Y/0.355)+11)*(1+1/((π/2-dir*z.arg)*W)) := by
  let d := π/2-dir*z.arg
  let x := d*W
  let r := Real.exp (-x)
  let K := Real.sqrt (2*π)/Real.sqrt ‖z‖ / Real.log (10/Real.sqrt (9/4+(W/2)^2))
  have hx : 0<x := mul_pos hd hW
  have hden : 0 < 1-r := sub_pos.mpr (Real.exp_lt_one_iff.mpr (neg_neg_of_pos hx))
  have hY0 : 0<Y := by by_contra! hn; linarith [mul_nonpos_of_nonpos_of_nonneg hn hd.le]
  have hL : 0 < Real.log (10/Real.sqrt (9/4+(W/2)^2)) := by
    apply log_ratio_pos (by positivity)
    apply (Real.sqrt_lt' (by norm_num)).mpr
    nlinarith [mul_self_le_mul_self hW.le hW']
  have hK : 0≤K := by unfold K; positivity
  have hratio : r/(1-r) ≤ 1/x := geometric_ratio_le hx
  have hsum : 1/(1-r) ≤ 1+1/x := by
    have he : 1/(1-r)=1+r/(1-r) := by field_simp; ring
    rw [he]; linarith
  have hslope : (11*W/Y)*(r/(1-r)) ≤ 11 := by
    apply (mul_le_mul_of_nonneg_left hratio (by positivity : 0≤11*W/Y)).trans
    rw [mul_one_div,div_le_iff₀ hx,div_le_iff₀ hY0]
    dsimp [x,d]; nlinarith only [mul_le_mul_of_nonneg_right hY hW.le]
  have hlog := (log_BP_pos q Y).le
  have he := Real.exp_le_one_iff.mpr (neg_nonpos.mpr (mul_nonneg hd.le hA))
  change Real.exp (-(d*A)) ≤ 1 at he
  have hp := mul_le_mul_of_nonneg_left he hK
  rw [mul_one] at hp
  unfold rayBound
  change _ ≤ K*(Real.log (BP q Y/0.355)+11)*(1+1/x)
  calc _ = (K*Real.exp (-(d*A))) * (Real.log (BP q Y/0.355)+(11*W/Y)*(r/(1-r))) * (1/(1-r)) := by
           dsimp only [K,d,r,x]; simp only [div_eq_mul_inv,← inv_pow]; ring
       _ ≤ _ := mul_le_mul (mul_le_mul hp (add_le_add (le_refl _) hslope) (by positivity) hK)
           hsum (by exact one_div_nonneg.mpr hden.le) (mul_nonneg hK (by linarith))

#print axioms inverse_norm_le_gap
#print axioms ray_simple
end GoldbachEnergy
