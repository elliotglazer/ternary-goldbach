module

public import MinorOnly
public import ProfileRoute

@[expose] public section

open Real TernaryGoldbach GoldbachEnergy GoldbachEnergy.Profile
namespace GoldbachFinite
theorem ternary_of_profiles (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    (bg : BinaryGoldbachUpTo 564383557524)
    (v0 : PriceRows 44.44 46.052 30 1 100000000 pieces0)
    (v1 : PriceRows 44.44 46.052 30 100000000 4047962620 pieces1)
    (v2 : PriceRows 46.05 56 70 1 100000000 pieces2)
    (v3 : PriceRows 46.05 56 70 100000000 48189030400 pieces3) : Statement := by
  apply ternary_of_bounded_minor rh grh bg
  intro n _ hn hl
  exact Profile.bounded_minor v0 v1 v2 v3 (by exact_mod_cast hn) hl.le
#print axioms ternary_of_profiles
end GoldbachFinite
