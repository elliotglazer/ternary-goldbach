import LowerAssembly
import MajorNumerics
import MinorNumerics

open Real MeasureTheory TernaryGoldbach GoldbachEnergy GoldbachRoute
namespace GoldbachFinite

/-- Large case with entirely real numerical hypotheses for each odd height. -/
theorem large_from_numeric (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℕ} (ho : Odd N) (hn : 2*10^19≤N)
    (hmin : MinorBudgetAt N) (hmaj : MajorBudgetAt N) : IsSumOfThreePrimes N := by
  have hnr : (2:ℝ)*10^19≤N := by exact_mod_cast hn
  apply primes_from_two_e19_comparison ho hn (minor_of_numeric rh grh hnr hmin)
  have hh := major_of_numeric rh grh hn hmaj
  linarith only [hh,sq_nonneg (N:ℝ)]

theorem ternary_of_numeric (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    (bg : BinaryGoldbachUpTo 564383557524)
    (hnumeric : ∀ N : ℕ, Odd N → 2*10^19≤N → MinorBudgetAt N ∧ MajorBudgetAt N) : Statement := by
  apply statement_of_upTo_of_from (through_two_e19_of_rh rh bg)
  intro N ho hn
  obtain ⟨hmin,hmaj⟩ := hnumeric N ho hn
  exact large_from_numeric rh grh ho hn hmin hmaj

#print axioms large_from_numeric
#print axioms ternary_of_numeric
end GoldbachFinite
