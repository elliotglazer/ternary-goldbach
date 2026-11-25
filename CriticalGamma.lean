module

public import TernaryGoldbach.Explicit.GammaBounds
public import Mathlib.Analysis.SpecialFunctions.Gamma.Beta

@[expose] public section


open Real Complex
open scoped ComplexConjugate
noncomputable section
namespace GoldbachEnergy

def critical (t : ℝ) : ℂ := 1/2 + (t:ℂ)*I

/-- Exact squared modulus of Γ at the ordinates supplied by Dirichlet GRH. -/
theorem critical_gamma_sq (t : ℝ) :
    ‖Complex.Gamma (critical t)‖^2 = π / Real.cosh (π*t) := by
  let s := critical t
  have hs : 1-s = conj s := by apply Complex.ext <;> simp [s,critical] <;> ring
  have hr := Complex.Gamma_mul_Gamma_one_sub s
  rw [hs,Complex.Gamma_conj,Complex.mul_conj, ← Complex.sq_norm] at hr
  have hp : (π:ℂ)*s = (π:ℂ)/2 + ((π*t:ℝ):ℂ)*I := by dsimp [s,critical]; push_cast; ring
  rw [hp,Complex.sin_add,Complex.sin_pi_div_two,Complex.cos_pi_div_two,Complex.cos_mul_I] at hr
  simp only [one_mul,zero_mul,add_zero, ← Complex.ofReal_cosh] at hr
  exact_mod_cast hr

/-- The exponential decay with a sharp constant on the critical line. -/
theorem critical_gamma_norm (t : ℝ) :
    ‖Complex.Gamma (critical t)‖ ≤ Real.sqrt (2*π) * Real.exp (-(π*|t|/2)) := by
  have hx : 0 < Real.cosh (π*t) := Real.cosh_pos _
  have hc : Real.exp (π*|t|) ≤ 2*Real.cosh (π*t) := by
    rw [← Real.cosh_abs (π*t),abs_mul,abs_of_pos Real.pi_pos,Real.cosh_eq]
    linarith [Real.exp_pos (-(π*|t|))]
  have hh : π / Real.cosh (π*t) ≤ 2*π / Real.exp (π*|t|) := by
    rw [div_le_div_iff₀ hx (exp_pos _)]
    nlinarith only [mul_le_mul_of_nonneg_left hc Real.pi_pos.le]
  have he : Real.exp (-(π*|t|/2))^2 = 1/Real.exp (π*|t|) := by
    rw [← Real.exp_nat_mul, Nat.cast_ofNat, show (2:ℝ)*(-(π*|t|/2)) = -(π*|t|) by ring, Real.exp_neg, one_div]
  have hsq : (Real.sqrt (2*π)*Real.exp (-(π*|t|/2)))^2 = 2*π/Real.exp (π*|t|) := by
    rw [mul_pow,Real.sq_sqrt (by positivity),he]; ring
  exact (sq_le_sq₀ (norm_nonneg _) (by positivity)).mp
    (by rw [critical_gamma_sq,hsq]; exact hh)

/-- The complex rate z reduces the decay angle by at most |arg z|. -/
theorem critical_gamma_rate (t : ℝ) {z : ℂ} (hz : z ≠ 0) :
    ‖Complex.Gamma (critical t) * z ^ (-critical t)‖ ≤
      (Real.sqrt (2*π)/Real.sqrt ‖z‖) * Real.exp (-((π/2-|z.arg|)*|t|)) := by
  rw [norm_mul, Complex.norm_cpow_of_ne_zero hz]
  have hre : (-critical t).re = -(1/2:ℝ) := by simp [critical]
  have him : (-critical t).im = -t := by simp [critical]
  rw [hre,him,Real.rpow_neg (norm_nonneg _), ← Real.sqrt_eq_rpow, mul_neg, Real.exp_neg,div_inv_eq_mul]
  have he := Real.exp_le_exp.mpr ((le_abs_self (z.arg*t)).trans (by rw [abs_mul]))
  calc _ ≤ (Real.sqrt (2*π)*Real.exp (-(π*|t|/2))) * ((Real.sqrt ‖z‖)⁻¹*Real.exp (|z.arg| *|t|)) :=
          mul_le_mul (critical_gamma_norm t) (mul_le_mul_of_nonneg_left he (by positivity)) (by positivity) (by positivity)
       _ = _ := by
         rw [show -((π/2-|z.arg|)*|t|) = -(π*|t|/2)+|z.arg| *|t| by ring,Real.exp_add]
         ring

#print axioms critical_gamma_rate
end GoldbachEnergy
