module

public import Mathlib.Analysis.SpecialFunctions.Trigonometric.ArctanDeriv
public import Mathlib.Analysis.Calculus.Deriv.Pow
public import Mathlib.Analysis.Calculus.Deriv.MeanValue
public import Mathlib.Tactic

@[expose] public section


open Real
namespace GoldbachEnergy

noncomputable def atanLower (x : ℝ) : ℝ := x-x^3/3+x^5/5-x^7/7+x^9/9-x^11/11

private theorem atanLower_derivative (x : ℝ) :
    HasDerivAt atanLower (1-x^2+x^4-x^6+x^8-x^10) x := by
  let h := hasDerivAt_id x
  have hp := ((((h.sub ((h.pow 3).div_const 3)).add ((h.pow 5).div_const 5)).sub
    ((h.pow 7).div_const 7)).add ((h.pow 9).div_const 9)).sub ((h.pow 11).div_const 11)
  convert hp using 1 <;> first | rfl | (norm_num [id] <;> ring)

theorem arctan_enclosure {x : ℝ} (hx : 0 ≤ x) :
    atanLower x ≤ Real.arctan x ∧ Real.arctan x ≤ atanLower x+x^13/13 := by
  have lower := monotone_of_hasDerivAt_nonneg
    (fun t : ℝ => (Real.hasDerivAt_arctan t).sub (atanLower_derivative t)) (fun t => by
      have h : 0 < 1+t^2 := by positivity
      apply sub_nonneg.mpr
      rw [le_div_iff₀ h]
      nlinarith only [show 0 ≤ t^12 by positivity])
  have upper := monotone_of_hasDerivAt_nonneg
    (fun t : ℝ => ((atanLower_derivative t).add (((hasDerivAt_id t).pow 13).div_const 13)).sub
      (Real.hasDerivAt_arctan t)) (fun t => by
      have h : 0 < 1+t^2 := by positivity
      apply sub_nonneg.mpr
      rw [div_le_iff₀ h]
      dsimp only [id]
      nlinarith only [show 0 ≤ t^14 by positivity])
  have hlo := lower hx
  have hhi := upper hx
  simp [atanLower] at hlo hhi ⊢
  exact ⟨by linarith,by linarith⟩

#print axioms arctan_enclosure
end GoldbachEnergy
