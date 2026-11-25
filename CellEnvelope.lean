module

public import ZeroGrid

@[expose] public section


open Real Complex Finset
noncomputable section
namespace GoldbachEnergy

/-- Factoring out the common norm keeps the upper and lower consecutive heights
at the same twist. Only the angle needs interval bounds inside the difference. -/
def scaledCell (a lo hi : ℝ) : ℝ :=
  min (Real.sqrt (2*π)*Real.exp (-((π/2-a)*lo)))
    (Real.sqrt (π/Real.cosh (π*lo))*Real.exp (a*hi))

theorem scaledCell_mono {a b lo hi : ℝ} (hab : a ≤ b) (hlo : 0 ≤ lo) (hhi : 0 ≤ hi) :
    scaledCell a lo hi ≤ scaledCell b lo hi := by
  unfold scaledCell
  apply min_le_min
  · apply mul_le_mul_of_nonneg_left _ (Real.sqrt_nonneg _)
    apply Real.exp_le_exp.mpr
    nlinarith only [mul_le_mul_of_nonneg_right hab hlo]
  · exact mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_right hab hhi)) (Real.sqrt_nonneg _)

theorem cellWeight_eq_scaled (z : ℂ) (lo hi : ℝ) :
    cellWeight z lo hi = scaledCell |z.arg| lo hi / Real.sqrt ‖z‖ := by
  unfold cellWeight scaledCell
  rw [← min_div_div_right (Real.sqrt_nonneg _)]
  congr 1 <;> ring

def clippedScaled (m : ℕ) (a h : ℝ) (i : ℕ) : ℝ :=
  if i < m then scaledCell a (i*h) ((i+1:ℕ)*h) else 0

theorem grid_box {z : ℂ} {a b h : ℝ} {m i : ℕ} (ha : a ≤ |z.arg|) (hb : |z.arg| ≤ b) (hh : 0 ≤ h) :
    gridIncrement m z h i ≤ max (clippedScaled m b h i - clippedScaled m a h (i+1)) 0 / Real.sqrt ‖z‖ := by
  have eqn (j : ℕ) : clippedWeight m z h j = clippedScaled m |z.arg| h j/Real.sqrt ‖z‖ := by
    unfold clippedWeight clippedScaled; split
    · exact cellWeight_eq_scaled _ _ _
    · simp
  have mono (j : ℕ) {v w : ℝ} (hv : v ≤ w) : clippedScaled m v h j ≤ clippedScaled m w h j := by
    unfold clippedScaled; split
    · exact scaledCell_mono hv (by positivity) (by positivity)
    · rfl
  rw [gridIncrement,eqn,eqn,← sub_div]
  rw [← max_div_div_right (Real.sqrt_nonneg _)]
  simp only [zero_div]
  exact max_le_max (div_le_div_of_nonneg_right (sub_le_sub (mono i hb) (mono (i+1) ha)) (Real.sqrt_nonneg _)) le_rfl

#print axioms grid_box
end GoldbachEnergy
