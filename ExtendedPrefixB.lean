module

public import ExtendedPrefix
public import ExtensionB0
public import ExtensionB1
public import ExtensionB2
public import ExtensionB3

@[expose] public section
namespace SmallGoldbach.ContiguousExtensionB
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 11207959552 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 10134217728
  · exact SmallGoldbach.ContiguousExtension.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.ContiguousExtensionB
