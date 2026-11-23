import Mathlib.MeasureTheory.Integral.IntegralEqImproper

open Set

namespace MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Substitute `y = exp x` on the whole real line. -/
theorem integral_comp_exp (g : ℝ → E) :
    ∫ x, Real.exp x • g (Real.exp x) = ∫ y in Ioi 0, g y := by
  symm
  rw [← Real.range_exp, ← image_univ]
  simpa [abs_of_pos (Real.exp_pos _)] using integral_image_eq_integral_abs_deriv_smul .univ
    (fun x _ ↦ (Real.hasDerivAt_exp x).hasDerivWithinAt) Real.exp_injective.injOn g

/-- Integrability under the same substitution. -/
theorem integrable_comp_exp (g : ℝ → E) :
    Integrable (fun x ↦ Real.exp x • g (Real.exp x)) ↔ IntegrableOn g (Ioi 0) := by
  rw [← integrableOn_univ, ← Real.range_exp, ← image_univ]
  symm
  simpa [abs_of_pos (Real.exp_pos _)] using integrableOn_image_iff_integrableOn_abs_deriv_smul
    .univ (fun x _ ↦ (Real.hasDerivAt_exp x).hasDerivWithinAt) Real.exp_injective.injOn g

end MeasureTheory
