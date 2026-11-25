module

public import RectGamma

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def meshAt (m i : ℕ) (h θ gap : ℝ) := if i < m then
  min (Real.sqrt (2*π)*(Real.exp (-(gap*h)))^i)
    (Real.sqrt (π/Real.cosh (π*(i*h)))*(Real.exp (θ*h))^(i+1)) else 0

theorem mesh_matches (m i : ℕ) (h θ : ℝ) :
    clippedScaled m θ h i = meshAt m i h θ (π/2-θ) := by
  unfold clippedScaled meshAt
  split
  · exact scaledCell_series _ _ _
  · rfl

def meshCoeff (m : ℕ) (h θ₀ θ₁ d₀ d₁ : ℝ) :=
  ∑ j ∈ range m, max (meshAt m j h θ₁ d₁-meshAt m (j+1) h θ₀ d₀) 0 * invDisk ((j+1:ℕ)*h)

theorem core_normalized (Q m : ℕ) (h θ₀ θ₁ : ℝ) :
    coreSum Q m h θ₀ θ₁ =
      meshCoeff m h θ₀ θ₁ (π/2-θ₀) (π/2-θ₁) * logBP Q 0 := by
  rw [coreSum,meshCoeff,Finset.sum_mul]
  apply sum_congr rfl
  intro j hj
  rw [mesh_matches,mesh_matches]
  unfold centerCount invDisk logBP
  ring

theorem logBP_arithmetic (Q : ℕ) (y : ℝ) (hy : 0 ≤ y) :
    logBP Q y = Real.log (1400*(Q:ℝ)^9*(Q+1)*(y+22)*(1.25*(y+11))^10/0.355) := by
  unfold logBP BP
  rw [abs_of_nonneg hy,show (10:ℝ)=(10:ℕ) by norm_num,Real.rpow_natCast]

#print axioms core_normalized
#print axioms logBP_arithmetic
end GoldbachEnergy
