import Shard0
import Shard1
namespace WideGoldbach
theorem endpoint_range : ∀ n : Nat, 3999999999967234 ≤ n → n ≤ 4000000000000000 → n % 2 = 0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n hlo hhi he
  by_cases hm : n < 3999999999983618
  · exact UpperShard0.verified n hlo hm he
  · exact UpperShard1.verified n (by omega) (by omega) he
end WideGoldbach
