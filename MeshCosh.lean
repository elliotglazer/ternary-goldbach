module

public import CellSeries

@[expose] public section


open Real
namespace GoldbachEnergy

theorem mesh_cosh_series (h : ℝ) (j : ℕ) :
    Real.cosh (π*((j:ℝ)*h)) =
      (Real.exp (π*h)^j + ((Real.exp (π*h))⁻¹)^j)/2 := by
  rw [Real.cosh_eq,show π*((j:ℝ)*h)=(j:ℝ)*(π*h) by ring,
    show -((j:ℝ)*(π*h))=(j:ℝ)*(-(π*h)) by ring,Real.exp_nat_mul,Real.exp_nat_mul,Real.exp_neg]

#print axioms mesh_cosh_series
end GoldbachEnergy
