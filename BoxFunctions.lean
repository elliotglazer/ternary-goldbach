module

public import ExpSteps
public import AtanCertificate

@[expose] public section


open Real
namespace GoldbachEnergy

theorem exp_neg_bounds {l u x : ℝ} (hl : 0 < l) (h : l ≤ Real.exp x ∧ Real.exp x ≤ u) :
    u⁻¹ ≤ Real.exp (-x) ∧ Real.exp (-x) ≤ l⁻¹ := by
  rw [Real.exp_neg]
  exact ⟨inv_anti₀ (Real.exp_pos _) h.2,inv_anti₀ hl h.1⟩

/-- One-sided exponential witnesses at the two proposed log endpoints certify a logarithm. -/
theorem log_by_exp {x l u : ℝ} (hl : Real.exp l ≤ x) (hu : x ≤ Real.exp u) :
    l ≤ Real.log x ∧ Real.log x ≤ u := by
  have hx := lt_of_lt_of_le (Real.exp_pos _) hl
  exact ⟨(Real.le_log_iff_exp_le hx).mpr hl,(Real.log_le_iff_le_exp hx).mpr hu⟩

theorem sqrt_by_squares {x l u : ℝ} (hu : 0 ≤ u) (h : l*l ≤ x ∧ x ≤ u*u) :
    l ≤ Real.sqrt x ∧ Real.sqrt x ≤ u := by
  exact ⟨Real.le_sqrt_of_sq_le (by nlinarith [h.1]),
    (Real.sqrt_le_left hu).mpr (by nlinarith [h.2])⟩

/-- Reduce angles near pi/4, where a Taylor enclosure about zero converges slowly. -/
theorem atan_shift {x : ℝ} (hx : 0 ≤ x) :
    Real.arctan x = π/4 - Real.arctan ((1-x)/(1+x)) := by
  have h : 0 < 1+x := by linarith
  have hp : x*((1-x)/(1+x)) < 1 := by
    rw [← mul_div_assoc,div_lt_iff₀ h]
    nlinarith [sq_nonneg x]
  have hr := Real.arctan_add hp
  have he : (x+(1-x)/(1+x))/(1-x*((1-x)/(1+x)))=1 := by
    have hn : 0 < 1-x*((1-x)/(1+x)) := by linarith
    apply (div_eq_iff hn.ne').mpr
    field_simp [h.ne']
    <;> ring
  rw [he,Real.arctan_one] at hr
  linarith

#print axioms exp_neg_bounds
#print axioms log_by_exp
#print axioms sqrt_by_squares
#print axioms atan_shift
end GoldbachEnergy
