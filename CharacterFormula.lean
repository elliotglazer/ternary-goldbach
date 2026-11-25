module

public import AdmissibleWave

@[expose] public section


open Real Complex MeasureTheory Filter Set TernaryGoldbach.Explicit
open scoped Topology
noncomputable section
namespace GoldbachEnergy

theorem cancelled_character_formula {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) {N : ℝ} (hN : 1 ≤ N) (δ : ℝ) :
    ∃ T : ℕ → ℝ, (∀ k : ℕ, T k ∈ Icc ((k:ℝ)+1) ((k:ℝ)+2)) ∧
      Tendsto (fun k => ∑ u ∈ zerosRect χ (T k),
        (multRect χ (T k) u : ℂ)*(mellin (cancelledWeight N δ) u*(N:ℂ)^u))
        atTop (𝓝 (-SsumG χ (cancelledWeight N δ) N -
          (1/(2*π):ℂ)*∫ y : ℝ, hIntG χ (cancelledWeight N δ) N
            (((-1/2:ℝ):ℂ)+y*I))) := by
  obtain ⟨K,c,h⟩ := good_cancelled_weight hN δ
  exact explicit_formula_gen hp hχ h (by linarith)

/-- Keeping the sign of the zero ordinate preserves the faster decay on one half-line. -/
theorem critical_gamma_signed (t : ℝ) {z : ℂ} (hz : z ≠ 0) :
    ‖Complex.Gamma (critical t)*z^(-critical t)‖ ≤
      Real.sqrt (2*π)/Real.sqrt ‖z‖ * Real.exp (-(π*|t|/2)+z.arg*t) := by
  rw [norm_mul,Complex.norm_cpow_of_ne_zero hz]
  have hre : (-critical t).re = -(1/2:ℝ) := by simp [critical]
  have him : (-critical t).im = -t := by simp [critical]
  rw [hre,him,Real.rpow_neg (norm_nonneg _), ← Real.sqrt_eq_rpow,mul_neg,
    Real.exp_neg,div_inv_eq_mul,Real.exp_add]
  calc _ ≤ (Real.sqrt (2*π)*Real.exp (-(π*|t|/2)))*((Real.sqrt ‖z‖)⁻¹*Real.exp (z.arg*t)) :=
          mul_le_mul_of_nonneg_right (critical_gamma_norm t) (by positivity)
       _ = _ := by ring

#print axioms cancelled_character_formula
#print axioms critical_gamma_signed
end GoldbachEnergy
