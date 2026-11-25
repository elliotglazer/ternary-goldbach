module

public import ProfileAssembly
public import ProductPrefix564386325504
public import ProfileGroup0
public import ProfileGroup1
public import ProfileGroup2
public import ProfileGroup3

@[expose] public section

open TernaryGoldbach
namespace GoldbachFinite
theorem completed_of_release (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2) : Statement := by
  have bg : BinaryGoldbachUpTo 564383557524 := fun n he h4 h =>
    SmallGoldbach.ProductPrefix564386325504.binaryGoldbachUpTo n he h4 (h.trans (by decide))
  exact ternary_of_profiles rh grh bg
    ProfileGroup0.rows
    ProfileGroup1.rows
    ProfileGroup2.rows
    ProfileGroup3.rows
#print axioms completed_of_release
end GoldbachFinite
