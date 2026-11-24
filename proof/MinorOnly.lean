import LargeTail
import BoundedMajor

open Real TernaryGoldbach GoldbachEnergy
namespace GoldbachFinite

theorem ternary_of_bounded_minor (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s = 0 → s.re = 1/2)
    (bg : BinaryGoldbachUpTo 564383557524)
    (minor : ∀ n : ℕ, Odd n → 2*10^19 ≤ n → Real.log n < 56 → MinorBudgetAt n) : Statement := by
  apply ternary_of_bounded_numeric rh grh bg
  intro n ho hn hl
  exact ⟨minor n ho hn hl, major_budget_bounded (by exact_mod_cast hn) hl.le⟩

#print axioms ternary_of_bounded_minor
end GoldbachFinite
