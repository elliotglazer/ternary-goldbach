import PackedWideShard0
import PackedWideShard1
namespace PackedWide
theorem verified : ∀ n : Nat, 3999999999967234 ≤ n → n < 4000000000000002 → n%2=0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n hl hr he
  by_cases hm : n < 3999999999983618
  · exact Block0.verified n hl hm he
  · exact Block1.verified n (by omega) hr he
end PackedWide
#print axioms PackedWide.verified
