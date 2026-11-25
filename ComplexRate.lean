module

public import TernaryGoldbach.Explicit.GammaBounds
public import Mathlib.Analysis.SpecialFunctions.Complex.Arg

@[expose] public section


open MeasureTheory Complex Set TernaryGoldbach.Explicit
open scoped Real
noncomputable section
namespace GoldbachEnergy

def lapWeight (z : ℂ) (u : ℝ) : ℂ := Complex.exp (-z*u)

theorem scaled_lapWeight (s z : ℂ) {c : ℝ} (hc : 0<c) :
    mellin (lapWeight ((c:ℂ)*z)) s = (c:ℂ)^(-s) * mellin (lapWeight z) s := by
  have he : lapWeight ((c:ℂ)*z) = fun t => lapWeight z (c*t) := by
    ext t; unfold lapWeight; push_cast; congr 1; ring
  rw [he, mellin_comp_mul_left _ _ hc,smul_eq_mul]

private theorem rotated_lapWeight (s : ℂ) (θ : ℝ) :
    Gr (2*s-2) 0 (θ/2) =
      Complex.exp ((θ:ℂ)*I*s) *
      (((2:ℂ)⁻¹*((1/2:ℝ):ℂ)^(-s))*mellin (lapWeight (Complex.exp ((θ:ℂ)*I))) s) := by
  let f := lapWeight (((1/2:ℝ):ℂ)*Complex.exp ((θ:ℂ)*I))
  have h := mellin_comp_rpow f (2*s) 2
  rw [abs_two,Complex.real_smul, show (2*s)/((2:ℝ):ℂ) = s by push_cast; ring] at h
  calc _ = Complex.exp ((θ:ℂ)*I*s) * mellin (fun r => f (r^(2:ℝ))) (2*s) := by
         rw [Gr,mellin, ←integral_const_mul]
         apply setIntegral_congr_fun measurableSet_Ioi
         intro r _
         simp only [Jr,Complex.ofReal_zero, mul_zero,zero_mul,add_zero,smul_eq_mul,
           f,lapWeight,Real.rpow_two]
         push_cast
         rw [show 2*s-2+1=2*s-1 by ring, show 2*s-2+2=2*s by ring,
           show (θ:ℂ)/2*I*(2*s)=(θ:ℂ)*I*s by ring,
           show 2*((θ:ℂ)/2)*I=(θ:ℂ)*I by ring]
         rw [show -(r:ℂ)^2 * Complex.exp ((θ:ℂ)*I)/2 =
           -((1/2:ℂ)*Complex.exp ((θ:ℂ)*I))*r^2 by ring]
         ring
       _ = _ := by
         rw [h, show mellin f s = _ from scaled_lapWeight s _ (by norm_num : (0:ℝ)<1/2)]
         push_cast; ring

private theorem mellin_lap_one {s : ℂ} (hs : 0<s.re) :
    mellin (lapWeight 1) s = Complex.Gamma s := by
  rw [Complex.Gamma_eq_integral hs, Complex.GammaIntegral_eq_mellin]
  congr 1
  funext t
  simp [lapWeight]

/-- Complex Laplace integral obtained by rotating the Gaussian ray at half the argument.
It applies to arbitrary rates in the right half-plane. -/
theorem mellin_lap_polar {s : ℂ} (hs : 0<s.re) (θ : ℝ) (hθ : |θ|<Real.pi/2)
    {c : ℝ} (hc : 0<c) :
    mellin (lapWeight ((c:ℂ)*Complex.exp ((θ:ℂ)*I))) s =
    (c:ℂ)^(-s)*Complex.exp (-((θ:ℂ)*I*s))*Complex.Gamma s := by
  have h := Gr_eq (2*s-2) 0 (θ := θ/2) (by rw [abs_div,abs_two]; linarith)
    (by simp; linarith)
  have h0 := rotated_lapWeight s 0
  simp only [zero_div] at h0
  rw [rotated_lapWeight, h0] at h
  simp only [Complex.ofReal_zero,zero_mul,Complex.exp_zero,one_mul] at h
  rw [mellin_lap_one hs] at h
  let A := (2:ℂ)⁻¹*((1/2:ℝ):ℂ)^(-s)
  have hA : A ≠ 0 := by
    dsimp [A]; exact mul_ne_zero (by norm_num) (Complex.cpow_ne_zero_iff.mpr (Or.inl (by norm_num)))
  have he := Complex.exp_ne_zero ((θ:ℂ)*I*s)
  rw [scaled_lapWeight s _ hc,Complex.exp_neg,mul_assoc]
  congr 1
  field_simp [he]
  apply mul_left_cancel₀ hA
  change Complex.exp ((θ:ℂ)*I*s)*(A*mellin (lapWeight (Complex.exp ((θ:ℂ)*I))) s) = A*Complex.Gamma s at h
  linear_combination h

#print axioms mellin_lap_polar
end GoldbachEnergy
