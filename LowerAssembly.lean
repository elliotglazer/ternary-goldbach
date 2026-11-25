module

public import LowerCutoff
public import LowerModel

@[expose] public section


open MeasureTheory Real TernaryGoldbach GoldbachEnergy GoldbachRoute
namespace GoldbachFinite

theorem ternary_from_two_e19 (rh : RiemannHypothesis)
    (bg : BinaryGoldbachUpTo 564383557524)
    (hmin : ∀ N : ℕ, Odd N → 2*10^19 ≤ N →
      ∀ u ∈ minorArcs N, ‖wave N u‖ ≤ 0.315*N/Real.log N)
    (hmaj : ∀ N : ℕ, Odd N → 2*10^19 ≤ N →
      (restrictedModel N).re-0.005*(N:ℝ)^2 ≤
        (∫ u in Set.Ioc (0:ℝ) 1 \ minorArcs N, integrand N u).re) : Statement := by
  apply statement_of_upTo_of_from (through_two_e19_of_rh rh bg)
  exact fun N hodd hn => primes_from_two_e19_comparison hodd hn (hmin N hodd hn) (hmaj N hodd hn)
#print axioms ternary_from_two_e19
end GoldbachFinite
