module

public import ExtendedPrefixB
public import GoldbachBand01Shard0
public import GoldbachBand01Shard1
public import GoldbachBand01Shard2
public import GoldbachBand01Shard3
public import GoldbachBand01Shard4
public import GoldbachBand01Shard5
public import GoldbachBand01Shard6
public import GoldbachBand01Shard7

@[expose] public section
namespace SmallGoldbach.GoldbachBand01
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 15502926848 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 11207959552
  · exact SmallGoldbach.ContiguousExtensionB.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand01
