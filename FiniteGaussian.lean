module

public import PrimeInterval
public import LowerPrefix
public import RouteOnArcs

@[expose] public section


open TernaryGoldbach
namespace GoldbachFinite

theorem through_1e20_of_rh (rh : RiemannHypothesis)
    (bg : BinaryGoldbachUpTo 1262000000002) : TernaryGoldbachUpTo (10^20) := by
  apply through_1e20_gaussian _ bg
  intro x hx hX
  exact Explicit.exists_prime_in_sqrt_interval rh (by norm_num at hx ⊢; exact hx)
    (hX.trans (by norm_num))

theorem ternary_on_rational_arcs (rh : RiemannHypothesis)
    (bg : BinaryGoldbachUpTo 1262000000002)
    (arcs : ∀ N : ℕ, Odd N → 10^20 ≤ N →
      GoldbachRoute.CentralExpansion N ∧ GoldbachRoute.TwistedEstimate N) : Statement :=
  statement_of_upTo_of_from (through_1e20_of_rh rh bg) (GoldbachRoute.large_on_rational_arcs arcs)

theorem ternary_of_pointwise (rh : RiemannHypothesis)
    (bg : BinaryGoldbachUpTo 1262000000002)
    (arcs : ∀ N : ℕ, Odd N → 10^20 ≤ N →
      GoldbachRoute.CentralExpansion N ∧ GoldbachRoute.MinorEstimate N) : Statement :=
  statement_of_upTo_of_from (through_1e20_of_rh rh bg) (GoldbachRoute.large_of_pointwise arcs)

#print axioms ternary_of_pointwise
#print axioms through_1e20_of_rh
#print axioms ternary_on_rational_arcs
end GoldbachFinite
