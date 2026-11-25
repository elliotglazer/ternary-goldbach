module

public import Coefficient
public import FiniteBridge
public import Budget

@[expose] public section


open MeasureTheory TernaryGoldbach
namespace GoldbachRoute

/-- The two remaining analytic estimates use the same arcs and the same full wave. -/
def ArcEstimates (N : ℕ) : Prop :=
  ∃ E : Set ℝ, MeasurableSet E ∧ E ⊆ Set.Ioc 0 1 ∧
    (∀ x ∈ E, ‖GoldbachEnergy.wave N x‖ ≤ 0.25*N/Real.log N) ∧
    0.18*(N:ℝ)^2 < (∫ x in Set.Ioc (0:ℝ) 1 \ E, GoldbachEnergy.integrand N x).re

theorem large (arcs : ∀ N : ℕ, Odd N → 10^20 ≤ N → ArcEstimates N) :
    TernaryGoldbachFrom (10^20) := by
  intro N ho hn
  obtain ⟨E,hm,hs,hmin,hmaj⟩ := arcs N ho hn
  exact GoldbachEnergy.three_primes_from_arc_bounds (c := 0.25) (m := 0.18)
    (by norm_num) (by norm_num) N hn hm hs hmin hmaj

theorem ternary_goldbach
    (arcs : ∀ N : ℕ, Odd N → 10^20 ≤ N → ArcEstimates N)
    (gap : GoldbachFinite.BackwardGap)
    (bg : BinaryGoldbachUpTo 587000000000) : Statement :=
  statement_of_upTo_of_from (GoldbachFinite.through_1e20 gap bg) (large arcs)

#print axioms large
#print axioms ternary_goldbach
end GoldbachRoute
