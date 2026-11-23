import TernaryGoldbach.Statement

/-!
The bounded GRH hypothesis in the existing repository is a specialization of
the full Dirichlet zero-location statement exported by the GRH release.

This adapter takes the full statement as an explicit argument. It does not
import or certify the released GRH proof and does not change a Goldbach cutoff.
-/

namespace GrhGoldbach

theorem plattGRH_of_fullGRH
    (h : ∀ (q : ℕ) [NeZero q] (χ : DirichletCharacter ℂ q) (s : ℂ),
      0 < s.re → s.re < 1 → χ.LFunction s = 0 → s.re = 1 / 2) :
    TernaryGoldbach.PlattGRH := by
  intro q _ χ _
  constructor
  · intro _ _ ρ hzero hpos hlt _
    exact h q χ ρ hpos hlt hzero
  · intro _ _ ρ hzero hpos hlt _
    exact h q χ ρ hpos hlt hzero

end GrhGoldbach

namespace PinnedAdapterAudit
def DirichletLZerosOnLine : Prop :=
  ∀ (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (s : ℂ),
    0 < s.re → s.re < 1 → DirichletCharacter.LFunction χ s = 0 → s.re = 1 / 2

def PlattGRH : Prop :=
  ∀ (q : ℕ) [NeZero q] (χ : DirichletCharacter ℂ q), χ.IsPrimitive →
    (Odd q → q ≤ 300000 → ∀ ρ : ℂ, χ.LFunction ρ = 0 → 0 < ρ.re → ρ.re < 1 →
      |ρ.im| ≤ 1e8 / q → ρ.re = 1 / 2) ∧
    (Even q → q ≤ 400000 → ∀ ρ : ℂ, χ.LFunction ρ = 0 → 0 < ρ.re → ρ.re < 1 →
      |ρ.im| ≤ max (1e8 / q : ℝ) (200 + 7.5e7 / q) → ρ.re = 1 / 2)

example : PlattGRH = TernaryGoldbach.PlattGRH := rfl
theorem from_published_type : DirichletLZerosOnLine → TernaryGoldbach.PlattGRH :=
  GrhGoldbach.plattGRH_of_fullGRH

#print axioms GrhGoldbach.plattGRH_of_fullGRH
#print axioms from_published_type
end PinnedAdapterAudit
