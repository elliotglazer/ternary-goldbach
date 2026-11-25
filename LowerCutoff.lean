module

public import FiniteAtHeight

@[expose] public section


open Real TernaryGoldbach
namespace GoldbachFinite

/-- Finite cost of lowering the large-odd theorem to 2 * 10^19. -/
theorem through_two_e19_of_rh (rh : RiemannHypothesis)
    (bg : BinaryGoldbachUpTo 564383557524) : TernaryGoldbachUpTo (2*10^19) := by
  apply through_height_of_rh rh (B := 564383557524) (by norm_num) (by norm_num)
    (by decide) _ bg
  have hs : Real.sqrt ((2*10^19:ℕ):ℝ) ≤ 4472135955 := Real.sqrt_le_iff.mpr ⟨by norm_num,by norm_num⟩
  push_cast at hs ⊢
  linarith only [hs]

#print axioms through_two_e19_of_rh
end GoldbachFinite
