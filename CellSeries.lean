module

public import CellEnvelope

@[expose] public section


open Real Complex Finset
noncomputable section
namespace GoldbachEnergy

/-- Each fixed angle and step requires two exponential evaluations for the entire mesh. -/
theorem scaledCell_series (a h : ℝ) (j : ℕ) :
    scaledCell a (j*h) ((j+1:ℕ)*h) =
      min (Real.sqrt (2*π)*Real.exp (-((π/2-a)*h))^j)
        (Real.sqrt (π/Real.cosh (π*((j:ℝ)*h)))*Real.exp (a*h)^(j+1)) := by
  unfold scaledCell
  have hl : -((π/2-a)*((j:ℝ)*h))=(j:ℝ)*(-((π/2-a)*h)) := by ring
  have hr : a*((j+1:ℕ)*h)=((j+1:ℕ):ℝ)*(a*h) := by ring
  rw [hl,hr,Real.exp_nat_mul,Real.exp_nat_mul]

#print axioms scaledCell_series
end GoldbachEnergy
