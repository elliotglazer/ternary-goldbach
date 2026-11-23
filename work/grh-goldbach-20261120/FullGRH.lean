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
