module

public import ProfileAssembly
public import ProfileGroup0
public import ProfileGroup1
public import ProfileGroup2
public import ProfileGroup3

@[expose] public section

open TernaryGoldbach
namespace GoldbachFinite
theorem ternary_of_verified_price_rows (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    (bg : BinaryGoldbachUpTo 564383557524) : Statement :=
  ternary_of_profiles rh grh bg ProfileGroup0.rows ProfileGroup1.rows ProfileGroup2.rows ProfileGroup3.rows

#print axioms ternary_of_verified_price_rows
end GoldbachFinite
