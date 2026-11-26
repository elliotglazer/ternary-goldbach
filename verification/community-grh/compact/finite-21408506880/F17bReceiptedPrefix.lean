module

public import GoldbachBand01Prefix
public import GoldbachBand02Shard0
public import GoldbachBand02Shard1
public import GoldbachBand02Shard2
public import GoldbachBand02Shard3
public import GoldbachBand02Shard4
public import GoldbachBand02Shard5
public import GoldbachBand02Shard6
public import GoldbachBand02Shard7
public import GoldbachBand02Shard8
public import GoldbachBand02Shard9
public import GoldbachBand02Shard10

public section
namespace SmallGoldbach.F17bFiniteAudit
theorem binaryGoldbachThrough21408506880 : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 21408506880 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by
  intro n he h4 hh
  by_cases h : n ≤ 15502926848
  · exact GoldbachBand01.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (join (join (join GoldbachBand02.shard0 GoldbachBand02.shard1) (join GoldbachBand02.shard2 (join GoldbachBand02.shard3 GoldbachBand02.shard4))) (join (join GoldbachBand02.shard5 (join GoldbachBand02.shard6 GoldbachBand02.shard7)) (join GoldbachBand02.shard8 (join GoldbachBand02.shard9 GoldbachBand02.shard10)))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachThrough21408506880
end SmallGoldbach.F17bFiniteAudit
