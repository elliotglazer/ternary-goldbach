import GoldbachBand01Prefix
import GoldbachBand02Shard0
import GoldbachBand02Shard1
import GoldbachBand02Shard2
import GoldbachBand02Shard3
import GoldbachBand02Shard4
import GoldbachBand02Shard5
import GoldbachBand02Shard6
import GoldbachBand02Shard7
import GoldbachBand02Shard8
import GoldbachBand02Shard9
import GoldbachBand02Shard10
import GoldbachBand02Shard11
namespace SmallGoldbach.GoldbachBand02
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 21945377792 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 15502926848
  · exact SmallGoldbach.GoldbachBand01.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand02
