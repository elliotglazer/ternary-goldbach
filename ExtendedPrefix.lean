module

public import Power10Joined
public import Extension0
public import Extension1

@[expose] public section
namespace SmallGoldbach.ContiguousExtension
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10134217728 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 10^10
  · exact SmallGoldbach.Power10.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join shard0 shard1) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.ContiguousExtension
